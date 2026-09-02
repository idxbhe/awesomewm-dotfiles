-- modules/signals.lua
-- Client signals: Papirus icons, window state, titlebars

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local beautiful = m.beautiful

-- {{{ Papirus icon lookup and application
-- Build a WM_CLASS -> Icon mapping from .desktop files
local desktop_icon_map = {}
do
    local desktop_dirs = {"/usr/share/applications/", "/usr/local/share/applications/"}
    for _, dir in ipairs(desktop_dirs) do
        local handle = io.popen("ls " .. dir .. "*.desktop 2>/dev/null")
        if handle then
            for file in handle:lines() do
                local f = io.open(file, "r")
                if f then
                    local content = f:read("*all")
                    f:close()
                    local wmclass = content:match("StartupWMClass=([^\n]+)")
                    local icon = content:match("^Icon=([^\n]+)")
                    if wmclass and icon then
                        desktop_icon_map[wmclass:lower()] = icon
                    end
                end
            end
            handle:close()
        end
    end
end

-- Find Papirus icon path for a given icon name
local function find_papirus_icon(icon_name)
    if not icon_name or icon_name == "" then return nil end
    for _, size in ipairs({"48x48", "32x32", "24x24", "22x22", "16x16"}) do
        local p = "/usr/share/icons/Papirus-Dark/" .. size .. "/apps/" .. icon_name .. ".svg"
        if gears.filesystem.file_readable(p) then
            return p
        end
    end
    return nil
end

-- Look up icon for a client, trying multiple strategies
local function lookup_client_icon(c)
    -- Strategy 1: Check .desktop file mapping by WM_CLASS
    if c.class then
        local icon_name = desktop_icon_map[c.class:lower()]
        if icon_name then
            local path = find_papirus_icon(icon_name)
            if path then return path end
        end
    end
    
    -- Strategy 2: Try direct Papirus lookup with various name transformations
    local candidates = {}
    if c.class and c.class ~= "" then
        local cls = c.class:lower()
        table.insert(candidates, cls)
        -- Strip common prefixes/suffixes (md., com., org., .desktop)
        local stripped = cls:gsub("^(md|com|org)%.",""):gsub("%.desktop$","")
        if stripped ~= cls then table.insert(candidates, stripped) end
        -- Handle dotted names: md.obsidian.Obsidian -> obsidian
        local last_part = cls:match("([^.]+)$")
        if last_part and last_part ~= cls then table.insert(candidates, last_part) end
    end
    
    for _, name in ipairs(candidates) do
        local path = find_papirus_icon(name)
        if path then return path end
    end
    
    return nil
end

-- Apply Papirus icon to a client via xseticon
local function apply_papirus_icon(c)
    if not c.valid then return end
    
    -- Guard: prevent infinite loops
    if c._papirus_applying then return end
    
    local icon_path = lookup_client_icon(c)
    if not icon_path or not c.window then return end
    
    c._papirus_applying = true
    local wid = tostring(c.window)
    local png_path = "/tmp/awesome-icon-" .. wid .. ".png"
    
    awful.spawn.easy_async_with_shell(
        "rsvg-convert -w 48 -h 48 '" .. icon_path .. "' -o '" .. png_path .. "' 2>/dev/null && " ..
        "xseticon -id " .. wid .. " '" .. png_path .. "' 2>/dev/null && " ..
        "rm -f '" .. png_path .. "'",
        function()
            if c.valid then
                c._papirus_applying = false
                -- Mark the time so property::icon handler knows we caused it
                c._papirus_own_emit = true
                c:emit_signal("property::icon")
                c._papirus_own_emit = false
            end
        end
    )
end
-- }}}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Apply rounded corners using theme border_radius
    if beautiful.border_radius then
        c.shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
        end
    end

    -- Apply Papirus icon immediately (retry logic handles apps that overwrite it)
    if c.valid then
        apply_papirus_icon(c)
    end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Re-apply Papirus icon when app tries to change it
client.connect_signal("property::icon", function(c)
    if not c.valid then return end
    
    -- Ignore our own emit from apply_papirus_icon
    if c._papirus_own_emit then return end
    
    -- Allow up to 3 retries within 10 seconds of first application
    local now = os.time()
    if not c._papirus_first_time then c._papirus_first_time = now end
    c._papirus_retry_count = (c._papirus_retry_count or 0) + 1
    
    if (now - c._papirus_first_time) > 10 or c._papirus_retry_count > 3 then
        return -- Stop retrying after 10 seconds or 3 attempts
    end
    
    -- Delay before re-applying (batch rapid changes)
    gears.timer.start_new(0.2, function()
        if c.valid and not c._papirus_applying then
            apply_papirus_icon(c)
        end
        return false
    end)
end)

-- {{{ Remember window state (position, size, floating mode) per app class
local state_file = gears.filesystem.get_cache_dir() .. "/window_state"

-- Load saved states (format: class|x|y|width|height|maximized|floating)
local window_states = {}
do
    local f = io.open(state_file, "r")
    if f then
        for line in f:lines() do
            local class, x, y, w, h, maximized, floating =
                line:match("^(.-)|(.-)|(.-)|(.-)|(.-)|(.-)|(.+)$")
            if class and x then
                window_states[class] = {
                    x = tonumber(x), y = tonumber(y),
                    width = tonumber(w), height = tonumber(h),
                    maximized = maximized == "1",
                    floating = floating == "1",
                }
            end
        end
        f:close()
    end
end

local function save_window_states()
    local f = io.open(state_file, "w")
    if not f then return end
    for class, s in pairs(window_states) do
        f:write(string.format("%s|%d|%d|%d|%d|%s|%s\n",
            class,
            math.floor(s.x or 0), math.floor(s.y or 0),
            math.floor(s.width or 0), math.floor(s.height or 0),
            s.maximized and "1" or "0",
            s.floating and "1" or "0"))
    end
    f:close()
end

-- Debounced save (avoid writing on every pixel of resize)
local save_timer = gears.timer {
    timeout = 2,
    single_shot = true,
    callback = save_window_states,
}

local function record_window_state(c)
    if not (c.class and c.valid and not c.fullscreen) then return end
    window_states[c.class] = {
        x = c.x, y = c.y,
        width = c.width, height = c.height,
        maximized = c.maximized,
        floating = c.floating,
    }
    save_timer:again()
end

client.connect_signal("manage", function(c)
    -- Restore last state for this app
    local state = c.class and window_states[c.class]
    if state then
        if state.maximized then
            c.maximized = true
        else
            c.floating = state.floating or false
            if c.floating and state.width and state.width > 0 then
                pcall(function()
                    c.x = state.x
                    c.y = state.y
                    c.width = state.width
                    c.height = state.height
                end)
            end
        end
    end
end)

client.connect_signal("property::geometry", function(c)
    if not awesome.startup then record_window_state(c) end
end)
client.connect_signal("property::floating", function(c)
    if not awesome.startup then record_window_state(c) end
end)
client.connect_signal("property::maximized", function(c)
    if not awesome.startup then record_window_state(c) end
end)
client.connect_signal("unmanage", function(c) record_window_state(c) end)
-- }}}

client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({ }, 1, function() c:emit_signal("request::activate", "titlebar", {raise = true}); awful.mouse.client.move(c) end),
        awful.button({ }, 3, function() c:emit_signal("request::activate", "titlebar", {raise = true}); awful.mouse.client.resize(c) end)
    )

    -- Helper: titlebar icon button in a square box
    local function tbbtn(widget, size, shift_up, bg)
        size = size or 16
        shift_up = shift_up or 0
        widget.resize = true
        widget.forced_width  = size
        widget.forced_height = size
        return wibox.widget {
            {
                {
                    widget,
                    widget = wibox.container.place,
                },
                top    = 4,
                left   = 4,
                right  = 4,
                bottom = 4 + shift_up,
                widget = wibox.container.margin,
            },
            forced_width  = 26,
            forced_height = 26,
            bg = bg or beautiful.surface1,
            border_width = 1,
            border_color = beautiful.surface0,
            widget = wibox.container.background,
        }
    end

    -- Helper: toggle button — same icon, blue tint when active
    local function tbbtn_toggled(c, prop, svg_path, action, size)
        size = size or 13
        local img = wibox.widget {
            image = gears.surface.load(svg_path),
            resize = true, forced_width = size, forced_height = size,
            widget = wibox.widget.imagebox,
        }
        local box = wibox.widget {
            {
                { img, widget = wibox.container.place },
                top = 4, left = 4, right = 4, bottom = 4,
                widget = wibox.container.margin,
            },
            forced_width = 26, forced_height = 26,
            bg = beautiful.surface1,
            border_width = 1, border_color = beautiful.surface0,
            widget = wibox.container.background,
        }
        local function update()
            if c[prop] then
                box.bg = beautiful.blue_dark
            else
                box.bg = beautiful.surface1
            end
        end
        c:connect_signal("property::" .. prop, update)
        update()
        box:buttons(gears.table.join(
            awful.button({ }, 1, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                action(c)
            end)
        ))
        return box
    end

    awful.titlebar(c, { size = 28 }):setup {
        { awful.titlebar.widget.iconwidget(c), buttons = buttons, layout = wibox.layout.fixed.horizontal },
        { { align = "center", widget = awful.titlebar.widget.titlewidget(c) }, buttons = buttons, layout = wibox.layout.flex.horizontal },
        { tbbtn(awful.titlebar.widget.minimizebutton(c), 16, 2),
          tbbtn(awful.titlebar.widget.floatingbutton(c), 13),
          tbbtn_toggled(c, "maximized",
            "/usr/share/icons/Papirus-Dark/16x16/actions/window-maximize.svg",
            function(c) c.maximized = not c.maximized; c:raise() end, 15),
          tbbtn_toggled(c, "sticky",
            "/usr/share/icons/Papirus-Dark/16x16/actions/window-pin.svg",
            function(c) c.sticky = not c.sticky end),
          tbbtn_toggled(c, "ontop",
            "/usr/share/icons/Papirus-Dark/16x16/actions/window-shade.svg",
            function(c) c.ontop = not c.ontop end),
          tbbtn(awful.titlebar.widget.closebutton(c), 16, 0, beautiful.red_dark),
          layout = wibox.layout.fixed.horizontal() },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", {raise = false}) end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Apply gap to maximized windows
local function apply_max_gap(c)
    if c.maximized then
        local gap = beautiful.useless_gap or 1
        c:geometry({
            x = c.screen.workarea.x + gap,
            y = c.screen.workarea.y + gap,
            width = c.screen.workarea.width - gap * 2,
            height = c.screen.workarea.height - gap * 2,
        })
    end
end

client.connect_signal("property::maximized", apply_max_gap)
client.connect_signal("manage", function(c)
    if c.maximized then apply_max_gap(c) end
end)
