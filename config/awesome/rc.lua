-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Theme - load FIRST before any widget code
beautiful.init("/home/bhe/dotfiles/config/awesome/theme.lua")
assert(beautiful.glyph, "Failed to load theme glyphs from /home/bhe/dotfiles/config/awesome/theme.lua")

-- Cache glyphs locally to avoid any runtime issues
local glyph = beautiful.glyph
local pill_bg = beautiful.pill_bg
local pill_fg = beautiful.pill_fg
local pill_padding = beautiful.pill_padding
local pill_spacing = beautiful.pill_spacing
local border_radius = beautiful.border_radius
local useless_gap = beautiful.useless_gap
local font = beautiful.font
local wibar_height = beautiful.wibar_height
local wibar_bg = beautiful.wibar_bg
local tooltip_bg = beautiful.tooltip_bg
local tooltip_fg = beautiful.tooltip_fg
local overlay0 = beautiful.overlay0

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
}
-- }}}

-- {{{ Menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

menubar.utils.terminal = terminal
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Widget helpers
local function pill_widget(widget, bg, fg)
    return wibox.widget {
        {
            widget,
            left = pill_padding,
            right = pill_padding,
            top = 2,
            bottom = 2,
            widget = wibox.container.margin
        },
        bg = bg or pill_bg,
        fg = fg or pill_fg,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, border_radius)
        end,
        widget = wibox.container.background
    }
end

local function pill_text(text, bg, fg)
    return pill_widget(wibox.widget {
        markup = text,
        font = font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }, bg, fg)
end

-- CPU widget
local cpu_widget = wibox.widget.textbox()
cpu_widget.font = font
awful.widget.watch("bash -c \"top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1\"", 2, function(w, stdout)
    local cpu = math.floor(tonumber(stdout) or 0)
    local icon = glyph.cpu
    w:set_markup_silently(string.format("%s %d%%", icon, cpu))
end, cpu_widget)

-- RAM widget
local ram_widget = wibox.widget.textbox()
ram_widget.font = font
awful.widget.watch("bash -c \"free | awk '/Mem:/ {printf \\\"%.0f\\\", $3/$2 * 100}'\"", 2, function(w, stdout)
    local ram = math.floor(tonumber(stdout) or 0)
    local icon = glyph.ram
    w:set_markup_silently(string.format("%s %d%%", icon, ram))
end, ram_widget)

-- Network widget
local net_widget = wibox.widget.textbox()
net_widget.font = font
local last_rx, last_tx = 0, 0
awful.widget.watch("bash -c \"cat /proc/net/dev | awk '/wlp|enp|eth/ {rx+=$2; tx+=$10} END {print rx, tx}'\"", 1, function(w, stdout)
    local rx, tx = stdout:match("(%d+)%s+(%d+)")
    rx, tx = tonumber(rx) or 0, tonumber(tx) or 0
    if last_rx > 0 and last_tx > 0 then
        local down = (rx - last_rx) / 1024
        local up = (tx - last_tx) / 1024
        local down_str = down > 1024 and string.format("%.1fM", down/1024) or string.format("%.0fK", down)
        local up_str = up > 1024 and string.format("%.1fM", up/1024) or string.format("%.0fK", up)
        w:set_markup_silently(string.format("%s %s %s %s", glyph.net_down, down_str, glyph.net_up, up_str))
    end
    last_rx, last_tx = rx, tx
end, net_widget)

-- Clock widget
local clock_widget = wibox.widget.textclock(string.format("%s %%H:%%M", glyph.clock), 1)

-- Layout indicator widget
local layout_widget = wibox.widget.textbox()
layout_widget.font = font
layout_widget.forced_width = 20
awful.widget.watch("bash -c \"echo\"", 1, function(w)
    local s = awful.screen.focused()
    local layout = s.selected_tag and s.selected_tag.layout or awful.layout.suit.floating
    local name = layout.name or "floating"
    local icons = {
        floating = "󰝴", tile = "󰕰", tileleft = "󰕱", tilebottom = "󰕲",
        tiletop = "󰕳", fairv = "󰕴", fairh = "󰕵", spiral = "󰕶",
        dwindle = "󰕷", max = "󰕸", fullscreen = "󰕹", magnifier = "󰕺", cornernw = "󰕻"
    }
    w:set_markup_silently(string.format("%s", icons[name] or icons.floating))
end, layout_widget)

-- Volume widget (requires pulseaudio/pipewire)
local vol_widget = wibox.widget.textbox()
vol_widget.font = font
awful.widget.watch("bash -c \"pamixer --get-volume-human 2>/dev/null || amixer get Master | grep -o '\\\\[[0-9]*%\\\\]' | head -1 | tr -d '[]%' || echo '?'\"", 1, function(w, stdout)
    local vol = stdout:gsub("%s+", "")
    local icon = glyph.vol_high
    if vol == "muted" or vol == "0%" then icon = glyph.vol_mute
    elseif tonumber(vol:match("%d+") or 100) < 30 then icon = glyph.vol_low
    elseif tonumber(vol:match("%d+") or 100) < 70 then icon = glyph.vol_mid end
    w:set_markup_silently(string.format("%s %s", icon, vol))
end, vol_widget)

-- Battery widget
local bat_widget = wibox.widget.textbox()
bat_widget.font = font
awful.widget.watch("bash -c \"cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1; cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1\"", 10, function(w, stdout)
    local cap, status = stdout:match("(%d+)%s*(%w*)")
    cap = tonumber(cap) or 0
    status = status or ""
    local icon = glyph.bat_mid
    if status:lower():find("charg") then icon = glyph.bat_charge
    elseif cap > 80 then icon = glyph.bat_full
    elseif cap > 30 then icon = glyph.bat_mid
    else icon = glyph.bat_low end
    w:set_markup_silently(string.format("%s %d%%", icon, cap))
end, bat_widget)

-- Separator
local sep_widget = pill_text(glyph.sep, pill_bg, overlay0)

-- Taglist with Arch icons (7 static tags)
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local function make_taglist(s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id = "text_role",
                        font = font,
                        align = "center",
                        valign = "center",
                        widget = wibox.widget.textbox
                    },
                    id = "margin_role",
                    left = 10,
                    right = 10,
                    top = 2,
                    bottom = 2,
                    widget = wibox.container.margin
                },
                id = "background_role",
                shape = gears.shape.rounded_rect,
                widget = wibox.container.background
            },
            create_callback = function(self, c3, index)
                self:get_children_by_id("text_role")[1]:set_text(tostring(index))
            end,
            update_callback = function(self, c3, index)
                self:get_children_by_id("text_role")[1]:set_text(tostring(index))
            end,
            widget = wibox.container.margin
        }
    }
end

-- Tasklist (circular app icons only, 28x28)
local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function(c)
        if c == client.focus then c.minimized = true
        else c:emit_signal("request::activate", "tasklist", {raise = true}) end
    end),
    awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

local function make_tasklist(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style   = {
            bg_normal = beautiful.tasklist_bg_normal,
            bg_focus  = beautiful.tasklist_bg_focus,
            bg_urgent = beautiful.tasklist_bg_urgent,
            bg_minimize = beautiful.tasklist_bg_minimize,
            fg_normal = beautiful.tasklist_fg_normal,
            fg_focus  = beautiful.tasklist_fg_focus,
            fg_urgent = beautiful.tasklist_fg_urgent,
            fg_minimize = beautiful.tasklist_fg_minimize,
            shape = gears.shape.rounded_rect,
        },
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    id     = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 4,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 36,
            forced_height   = 36,
            widget          = wibox.container.background,
            create_callback = function(self, c, index, objects)
                self:get_children_by_id('clienticon')[1].client = c
            end,
        }
    }
end

-- Prompt box
local function make_promptbox(s)
    return awful.widget.prompt()
end

-- Layoutbox
local function make_layoutbox(s)
    local lb = awful.widget.layoutbox(s)
    lb:buttons(gears.table.join(
        awful.button({ }, 1, function() awful.layout.inc(1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end),
        awful.button({ }, 4, function() awful.layout.inc(1) end),
        awful.button({ }, 5, function() awful.layout.inc(-1) end)
    ))
    return lb
end

-- {{{ Wibar setup - 3 bars per screen: left, center, right
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
    screen.connect_signal("property::geometry", function(s)
        if beautiful.wallpaper then
            local wallpaper = beautiful.wallpaper
            if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
            gears.wallpaper.maximized(wallpaper, s, true)
        end
    end)

    -- 7 static tags with numbers
    awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])

    -- Widgets per screen
    s.mytaglist = make_taglist(s)
    s.mytasklist = make_tasklist(s)
    s.mypromptbox = make_promptbox(s)
    s.mylayoutbox = make_layoutbox(s)

    -- Single unified bar with 3 sections (left, center, right)
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = wibar_height,
        bg = wibar_bg,
        stretch = true,
    })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "outside",
        { -- Left: launcher + tags
            layout = wibox.layout.fixed.horizontal,
            spacing = pill_spacing,
            pill_widget(mylauncher),
            s.mytaglist,
        },
        { -- Center: tasklist
            layout = wibox.layout.align.horizontal,
            expand = "none",
            nil,
            s.mytasklist,
            nil,
        },
        { -- Right: pills (CPU, RAM, Net, Vol, Bat, Clock, Layout)
            layout = wibox.layout.align.horizontal,
            expand = "none",
            nil,
            nil,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = pill_spacing,
                pill_widget(cpu_widget),
                pill_widget(ram_widget),
                pill_widget(net_widget),
                pill_widget(vol_widget),
                pill_widget(bat_widget),
                pill_widget(clock_widget),
                pill_widget(layout_widget),
            },
        }
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function() mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, {description="show help", group="awesome"}),
    awful.key({ modkey }, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),

    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end, {description = "focus next by index", group = "client"}),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}),
    awful.key({ modkey }, "w", function() mymainmenu:show() end, {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end, {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end, {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end, {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end, {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey }, "u", awful.client.urgent.jumpto, {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end, {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end, {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end, {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end, {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end, {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end, {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey }, "space", function() awful.layout.inc(1) end, {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end, {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        if c then c:emit_signal("request::activate", "key.unminimize", {raise = true}) end
    end, {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end, {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x", function()
        awful.prompt.run {
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. "/history_eval"
        }
    end, {description = "lua execute prompt", group = "awesome"}),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end, {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end, {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift" }, "c", function(c) c:kill() end, {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
    awful.key({ modkey }, "o", function(c) c:move_to_screen() end, {description = "move to screen", group = "client"}),
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey }, "n", function(c) c.minimized = true end, {description = "minimize", group = "client"}),
    awful.key({ modkey }, "m", function(c) c.maximized = not c.maximized; c:raise() end, {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m", function(c) c.maximized_vertical = not c.maximized_vertical; c:raise() end, {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift" }, "m", function(c) c.maximized_horizontal = not c.maximized_horizontal; c:raise() end, {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags (1-7)
for i = 1, 7 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, {description = "view tag #"..i, group = "tag"}),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, {description = "toggle tag #" .. i, group = "tag"}),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, {description = "move focused client to tag #"..i, group = "tag"}),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}); awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}); awful.mouse.client.resize(c) end)
)

root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap + awful.placement.no_offscreen
     }
    },

    { rule_any = {
        instance = { "DTA", "copyq", "pinentry" },
        class = { "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", "Sxiv", "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer" },
        name = { "Event Tester" },
        role = { "AlarmWindow", "ConfigManager", "pop-up" }
      }, properties = { floating = true }},

    { rule_any = {type = { "normal", "dialog" }}, properties = { titlebars_enabled = true }},
}
-- }}}

-- {{{ Signals
client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({ }, 1, function() c:emit_signal("request::activate", "titlebar", {raise = true}); awful.mouse.client.move(c) end),
        awful.button({ }, 3, function() c:emit_signal("request::activate", "titlebar", {raise = true}); awful.mouse.client.resize(c) end)
    )
    awful.titlebar(c):setup {
        { awful.titlebar.widget.iconwidget(c), buttons = buttons, layout = wibox.layout.fixed.horizontal },
        { { align = "center", widget = awful.titlebar.widget.titlewidget(c) }, buttons = buttons, layout = wibox.layout.flex.horizontal },
        { awful.titlebar.widget.floatingbutton(c), awful.titlebar.widget.maximizedbutton(c), awful.titlebar.widget.stickybutton(c), awful.titlebar.widget.ontopbutton(c), awful.titlebar.widget.closebutton(c), layout = wibox.layout.fixed.horizontal() },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("mouse::enter", function(c) c:emit_signal("request::activate", "mouse_enter", {raise = false}) end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}