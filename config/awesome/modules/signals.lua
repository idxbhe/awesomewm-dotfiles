-- modules/signals.lua
-- Client signals: Papirus icons, window state, titlebars

---@diagnostic disable: undefined-global

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
    for _, theme in ipairs({"Papirus-Dark", "Papirus"}) do
        for _, size in ipairs({"48x48", "32x32", "24x24", "22x22", "16x16"}) do
            local p = "/usr/share/icons/" .. theme .. "/" .. size .. "/apps/" .. icon_name .. ".svg"
            if gears.filesystem.file_readable(p) then
                return p
            end
        end
    end
    return nil
end

-- Look up icon for a client, trying multiple strategies
local function lookup_client_icon(c)
    -- Strategy 0: Terminal apps use generic "terminal" icon
    if c.class then
        local cls_lower = c.class:lower()
        if cls_lower == "alacritty" or cls_lower == "kitty" or cls_lower == "xterm" or cls_lower == "st" then
            local p = find_papirus_icon("terminal")
            if p then return p end
        end
    end

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
        -- Try dotted form with original case: com.alacritty.Alacritty
        table.insert(candidates, "com." .. cls .. "." .. c.class)
    end

    for _, name in ipairs(candidates) do
        local path = find_papirus_icon(name)
        if path then return path end
    end

    return nil
end

-- Apply Papirus icon to a client via xseticon (with caching)
local icon_cache = {}
local function apply_papirus_icon(c)
    if not c.valid then return end

    -- Guard: prevent infinite loops
    if c._papirus_applying then return end

    local icon_path = lookup_client_icon(c)
    if not icon_path or not c.window then return end

    local wid = tostring(c.window)
    -- Use cached PNG if available
    local png_path = icon_cache[icon_path]
    if not png_path then
        png_path = "/tmp/awesome-icon-" .. wid .. ".png"
        icon_cache[icon_path] = png_path
    end

    c._papirus_applying = true
    awful.spawn.easy_async_with_shell(
        "rsvg-convert -w 48 -h 48 '" .. icon_path .. "' -o '" .. png_path .. "' 2>/dev/null && " ..
        "xseticon -id " .. wid .. " '" .. png_path .. "' 2>/dev/null",
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

-- {{{ Remember window state (position, size) per app class, separately for floating and tiled
local state_file = gears.filesystem.get_cache_dir() .. "/window_state"

-- Load saved states (format: class|fx|fy|fw|fh|tx|ty|tw|th|last_mode)
local window_states = {}
do
    local f = io.open(state_file, "r")
    if f then
        for line in f:lines() do
            local class, fx, fy, fw, fh, tx, ty, tw, th, last_mode =
                line:match("^(.-)|(.-)|(.-)|(.-)|(.-)|(.-)|(.-)|(.-)|(.-)|(.+)$")
            if class and fx then
                window_states[class] = {
                    floating = {
                        x = tonumber(fx) ~= -999 and tonumber(fx) or nil,
                        y = tonumber(fy) ~= -999 and tonumber(fy) or nil,
                        width = tonumber(fw) ~= -999 and tonumber(fw) or nil,
                        height = tonumber(fh) ~= -999 and tonumber(fh) or nil,
                    },
                    tiled = {
                        x = tonumber(tx) ~= -999 and tonumber(tx) or nil,
                        y = tonumber(ty) ~= -999 and tonumber(ty) or nil,
                        width = tonumber(tw) ~= -999 and tonumber(tw) or nil,
                        height = tonumber(th) ~= -999 and tonumber(th) or nil,
                    },
                    last_mode = last_mode or "tiled",
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
        local fl = s.floating or {}
        local ti = s.tiled or {}
        f:write(string.format("%s|%d|%d|%d|%d|%d|%d|%d|%d|%s\n",
            class,
            fl.x and math.floor(fl.x) or -999,
            fl.y and math.floor(fl.y) or -999,
            fl.width and math.floor(fl.width) or -999,
            fl.height and math.floor(fl.height) or -999,
            ti.x and math.floor(ti.x) or -999,
            ti.y and math.floor(ti.y) or -999,
            ti.width and math.floor(ti.width) or -999,
            ti.height and math.floor(ti.height) or -999,
            s.last_mode or "tiled"))
    end
    f:close()
end

-- Debounced save (avoid writing on every pixel of resize)
local save_timer = gears.timer {
    timeout = 2,
    single_shot = true,
    callback = save_window_states,
}

-- Flag to prevent recording during startup
local startup_phase = true

local function record_window_state(c)
    if not (c.class and c.valid) then return end

    -- Skip recording fullscreen windows
    if c.fullscreen then return end

    local class = c.class
    if not window_states[class] then
        window_states[class] = { floating = {}, tiled = {}, last_mode = "tiled" }
    end

    local geo = c:geometry()
    if c.floating then
        window_states[class].floating = {
            x = geo.x, y = geo.y,
            width = geo.width, height = geo.height,
        }
        window_states[class].last_mode = "floating"
    elseif not c.maximized then
        window_states[class].tiled = {
            x = geo.x, y = geo.y,
            width = geo.width, height = geo.height,
        }
        window_states[class].last_mode = "tiled"
    end
    save_timer:again()
end

-- Restore window state with proper handling
client.connect_signal("manage", function(c)
    -- Skip restoration during startup to let windows position themselves
    if awesome.startup then return end

    local state = c.class and window_states[c.class]
    if not state then return end

    -- Delay restoration slightly to ensure window is ready
    gears.timer.start_new(0.1, function()
        if not c.valid then return false end

        -- Restore based on last saved state
        if state.floating and state.floating.width and state.floating.width > 0 then
            -- Restore floating state
            c.floating = true
            pcall(function()
                c.x = state.floating.x
                c.y = state.floating.y
                c.width = state.floating.width
                c.height = state.floating.height
            end)
        else
            -- Restore tiled state
            c.floating = false
            pcall(function()
                c.x = state.tiled.x
                c.y = state.tiled.y
                c.width = state.tiled.width
                c.height = state.tiled.height
            end)
        end

        return false
    end)
end)

-- Start recording after startup is complete
client.connect_signal("property::geometry", function(c)
    if not startup_phase then record_window_state(c) end
end)
client.connect_signal("property::floating", function(c)
    if not startup_phase then record_window_state(c) end
end)
client.connect_signal("property::maximized", function(c)
    if not startup_phase then record_window_state(c) end
end)
client.connect_signal("property::fullscreen", function(c)
    if not startup_phase then record_window_state(c) end
end)
client.connect_signal("unmanage", function(c) record_window_state(c) end)

-- Mark startup as complete after a short delay
gears.timer.start_new(3, function()
    startup_phase = false
    return false
end)
-- }}}

client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({ }, 1, function() c:emit_signal("request::activate", "titlebar", {raise = true}); awful.mouse.client.move(c) end),
        awful.button({ }, 3, function() c:emit_signal("request::activate", "titlebar", {raise = true}); awful.mouse.client.resize(c) end)
    )

    -- Helper: titlebar icon button using cached imagebox with hover + focus support (no background)
    local ic = gears.filesystem.get_configuration_dir() .. "icons/"
    
    -- Global icon cache (module-level) to share surfaces across all clients
    if not _G._titlebar_icon_cache then
        _G._titlebar_icon_cache = {}
    end
    local function get_surface(path)
        if not _G._titlebar_icon_cache[path] then
            _G._titlebar_icon_cache[path] = gears.surface.load(path)
        end
        return _G._titlebar_icon_cache[path]
    end
    
    local function tbbtn_icon(svg_normal, svg_hover, svg_nofocus, action, size)
        size = size or 16
        local img = wibox.widget {
            image = get_surface(svg_normal),
            resize = true, forced_width = size, forced_height = size,
            widget = wibox.widget.imagebox,
        }
        local box = wibox.widget {
            { img, widget = wibox.container.place },
            forced_width = 20, forced_height = 20,
            widget = wibox.container.background,
        }
        local is_hover = false
        local is_focused = true
        local function update()
            if not is_focused then
                img.image = get_surface(svg_nofocus)
            elseif is_hover then
                img.image = get_surface(svg_hover)
            else
                img.image = get_surface(svg_normal)
            end
        end
        c:connect_signal("focus", function()
            is_focused = true
            update()
        end)
        c:connect_signal("unfocus", function()
            is_focused = false
            update()
        end)
        box:connect_signal("mouse::enter", function() is_hover = true; update() end)
        box:connect_signal("mouse::leave", function() is_hover = false; update() end)
        box:buttons(gears.table.join(
            awful.button({ }, 1, function()
                c:emit_signal("request::activate", "titlebar", {raise = true})
                action(c)
            end)
        ))
        update()
        return box
    end

    awful.titlebar(c, { size = 22 }):setup {
        { awful.titlebar.widget.iconwidget(c), buttons = buttons, layout = wibox.layout.fixed.horizontal },
        { { { align = "center", widget = awful.titlebar.widget.titlewidget(c), font = "Maple Mono NF Bold 9" }, buttons = buttons, layout = wibox.layout.flex.horizontal }, align = "center", valign = "center", widget = wibox.container.place },
        { tbbtn_icon(ic .. "minimize-normal.svg", ic .. "minimize-hover.svg", ic .. "nofocus.svg",
            function(c) c.minimized = true end, 16),
          tbbtn_icon(ic .. "maximize-normal.svg", ic .. "maximize-hover.svg", ic .. "nofocus.svg",
            function(c) c.maximized = not c.maximized; c:raise() end, 16),
          tbbtn_icon(ic .. "close-normal.svg", ic .. "close-hover.svg", ic .. "nofocus.svg",
            function(c) c:kill() end, 16),
          layout = wibox.layout.fixed.horizontal() },
        layout = wibox.layout.align.horizontal
    }
end)

-- Ensure titlebars are always shown for normal and dialog windows
local function ensure_titlebars(c)
    if c.type ~= "normal" and c.type ~= "dialog" then return end

    local tb = awful.titlebar(c, { size = 22 })
    if tb then
        tb.size = 22  -- Force resize if titlebar already exists
        tb.visible = true
    end
end

-- Resize existing titlebars to current size after restart
gears.timer.start_new(0.5, function()
    local new_size = 22
    for _, c in ipairs(client.get()) do
        local tb = awful.titlebar(c, { size = new_size })
        if tb and tb.size ~= new_size then
            tb.size = new_size
        end
    end
    return false
end)

-- Hide titlebar when fullscreen, show when not
client.connect_signal("property::fullscreen", function(c)
    local tb = awful.titlebar(c, { size = 22 })
    if tb then
        tb.visible = not c.fullscreen
    end
end)

-- Restore titlebar visibility when layout changes or window state changes
tag.connect_signal("property::layout", function()
    for _, c in ipairs(client.get()) do
        ensure_titlebars(c)
    end
end)

client.connect_signal("property::floating", function(c)
    ensure_titlebars(c)
end)

client.connect_signal("property::maximized", function(c)
    if not c.fullscreen then
        ensure_titlebars(c)
    end
end)

-- Also ensure titlebars on manage
client.connect_signal("manage", function(c)
    gears.timer.start_new(0.1, function()
        if c.valid then
            ensure_titlebars(c)
        end
        return false
    end)
end)

client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", {raise = false}) end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Apply gap to maximized windows (skip fullscreen)
local function apply_max_gap(c)
    if c.maximized and not c.fullscreen then
        local gap = beautiful.useless_gap or 1
        local s = c.screen or screen.primary
        c:geometry({
            x = s.workarea.x + gap,
            y = s.workarea.y + gap,
            width = s.workarea.width - gap * 2,
            height = s.workarea.height - gap * 2,
        })
    end
end

client.connect_signal("property::maximized", apply_max_gap)
client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        -- Fullscreen uses screen.geometry (ignores bar/wibar)
        local s = c.screen and c.screen.geometry or screen.primary.geometry
        c:geometry({
            x = s.x,
            y = s.y,
            width = s.width,
            height = s.height,
        })
    else
        apply_max_gap(c)
    end
end)
client.connect_signal("manage", function(c)
    if c.maximized and not c.fullscreen then apply_max_gap(c) end
end)

-- {{{ Persist active tag per screen
local tag_state_file = gears.filesystem.get_cache_dir() .. "/tag_state"

-- Load saved tag states
local saved_tags = {}
do
    local f = io.open(tag_state_file, "r")
    if f then
        for line in f:lines() do
            local idx, tag_idx = line:match("^(%d+)|(.+)$")
            if idx and tag_idx then
                saved_tags[tonumber(idx)] = tag_idx
            end
        end
        f:close()
    end
end

local function save_tag_states()
    local f = io.open(tag_state_file, "w")
    if not f then return end
    for idx, tag_idx in pairs(saved_tags) do
        f:write(string.format("%d|%s\n", idx, tag_idx))
    end
    f:close()
end

-- Record current active tag for each screen
local function record_current_tags()
    for _, s in ipairs(screen) do
        if s.selected_tag then
            saved_tags[s.index] = s.selected_tag.name
        end
    end
    save_tag_states()
end

-- Save before restart/quit
awesome.connect_signal("exit", function()
    print("[awesome] Saving tag states on exit")
    record_current_tags()
end)

-- Also save when switching between screens (in case tag changed)
awful.screen.connect_for_each_screen(function(s)
    s:connect_signal("focus", function()
        if s.selected_tag then
            saved_tags[s.index] = s.selected_tag.name
            save_tag_states()
        end
    end)
end)

-- Save when tag changes
tag.connect_signal("property::selected", function(t)
    if t.selected then
        saved_tags[t.screen.index] = t.name
        save_tag_states()
    end
end)

-- Restore active tag after startup
gears.timer.start_new(1, function()
    for idx, tag_name in pairs(saved_tags) do
        local s = screen[idx]
        if s then
            for _, t in ipairs(s.tags) do
                if t.name == tag_name then
                    t:view_only()
                    break
                end
            end
        end
    end
    return false
end)
-- }}}
