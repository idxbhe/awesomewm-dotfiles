-- Main rc.lua - Modular AwesomeWM configuration

-- Load core module
local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local beautiful = m.beautiful
local naughty = m.naughty
local menubar = m.menubar
local hotkeys_popup = m.hotkeys_popup

-- Load sub-modules
local popup_registry = require("modules.popup_registry")
local widgets = require("modules.widgets")
local volume = require("modules.volume")
local settings = require("modules.settings")
local calendar = require("modules.calendar")
local tools = require("modules.tools")
local power = require("modules.power")
local signals = require("modules.signals")

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
terminal = m.terminal
editor = m.editor
editor_cmd = m.editor_cmd
modkey = m.modkey

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.floating,
    awful.layout.suit.max,
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

mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

mylauncher = wibox.widget {
    {
        {
            text = beautiful.glyph.launcher,
            font = m.font_icon,
            align = "center",
            valign = "center",
            forced_width = 22,
            forced_height = 22,
            widget = wibox.widget.textbox,
        },
        id = "bg",
        shape = function(cr, w, h) gears.shape.circle(cr, w, h) end,
        bg = beautiful.pill_bg or beautiful.bg_focus,
        widget = wibox.container.background,
    },
    margins = 0,
    widget = wibox.container.margin,
}

mylauncher:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        awful.spawn.with_shell("rofi -show drun")
    end
end)

menubar.utils.terminal = terminal
-- }}}

-- {{{ Key bindings
require("modules.bindings")
-- }}}

-- {{{ Rules
require("modules.rules")
-- }}}

-- {{{ Signals

-- Wallpaper (random from ~/Pictures/Wallpapers)
screen.connect_signal("property::geometry", function(s)
    local wallpaper_dir = os.getenv("HOME") .. "/Pictures/Wallpapers"
    local exts = { "%.jpg$", "%.jpeg$", "%.png$", "%.webp$" }
    local wallpapers = {}
    local handle = io.popen('ls -1 "' .. wallpaper_dir .. '" 2>/dev/null')
    if handle then
        for file in handle:lines() do
            for _, ext in ipairs(exts) do
                if file:lower():match(ext) then
                    wallpapers[#wallpapers + 1] = wallpaper_dir .. "/" .. file
                    break
                end
            end
        end
        handle:close()
    end
    if #wallpapers > 0 then
        local chosen = wallpapers[math.random(#wallpapers)]
        gears.wallpaper.maximized(chosen, s, true)
    end
end)

-- Tags
awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, awful.layout.layouts[1])

    s.mytaglist = widgets.make_taglist(s)
    s.mytasklist = widgets.make_tasklist(s)
    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function() awful.layout.inc(1) end),
        awful.button({ }, 3, function() awful.layout.inc(-1) end),
        awful.button({ }, 4, function() awful.layout.inc(1) end),
        awful.button({ }, 5, function() awful.layout.inc(-1) end)
    ))

    -- Setup calendar
    calendar.setup_clock_click(widgets.clock_widget)
    calendar.setup_clock_tooltip(widgets.clock_widget)
    calendar.setup_autoclose()

    -- Wibar
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = m.wibar_height,
        bg = m.wibar_bg,
        stretch = true,
    })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = m.pill_spacing,
                widgets.pill_widget(mylauncher),
                {
                    s.mytaglist,
                    top = 3,
                    bottom = 3,
                    widget = wibox.container.margin,
                },
            },
            widget = wibox.container.place,
            valign = "center",
        },
        { -- Center
            {
                layout = wibox.layout.align.horizontal,
                expand = "inside",
                nil,
                s.mytasklist,
                nil,
            },
            widget = wibox.container.place,
            valign = "center",
        },
        { -- Right
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = m.pill_spacing,
                widgets.pill_widget(widgets.cpu_widget),
                widgets.pill_widget(widgets.ram_widget),
                widgets.pill_widget(widgets.net_widget),
                widgets.pill_widget(volume.vol_widget),
                widgets.pill_widget(tools.tools_widget),
                widgets.pill_widget(settings.set_widget),
                widgets.pill_widget(widgets.clock_widget),
                widgets.pill_widget(widgets.layout_widget),
                widgets.pill_widget(power.power_widget),
            },
            widget = wibox.container.place,
            valign = "center",
        },
    }
end)
-- }}}
