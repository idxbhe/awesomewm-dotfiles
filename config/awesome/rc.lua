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
-- Font sizes — icons larger than text
local font       = "JetBrainsMono Nerd Font Mono Bold 10"
local font_icon  = "JetBrainsMono Nerd Font Mono Bold 14"
local font_popup = "JetBrainsMono Nerd Font Mono Bold 11"
local font_popup_regular = "JetBrainsMono Nerd Font Mono 11"
local icon = function(t) return string.format('<span font="%s">%s</span>', font_icon, t) end
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

mylauncher = wibox.widget {
    {
        {
            text = beautiful.glyph.launcher,
            font = font_icon,
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

-- Make launcher clickable to open rofi
mylauncher:connect_signal("button::press", function(_, _, _, button)
    if button == 1 then
        awful.spawn.with_shell("rofi -show drun")
    end
end)

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
        forced_height = wibar_height - 4,
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

-- Pill with separate icon + text containers for perfect centering
local function pill_icon_text(icon_glyph, text_markup, bg, fg)
    local icon_tb = wibox.widget {
        text = icon_glyph,
        font = font_icon,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }
    local text_tb = wibox.widget {
        markup = text_markup,
        font = font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }
    local h_layout = wibox.layout.fixed.horizontal()
    h_layout:add(icon_tb)
    h_layout:add(text_tb)
    h_layout.spacing = 8
    -- Use pill_widget directly — it handles padding
    return pill_widget(h_layout, bg, fg), icon_tb, text_tb, h_layout
end

-- CPU widget — separate icon + text containers for perfect centering
local cpu_widget, cpu_icon_tb, cpu_text_tb, cpu_layout = pill_icon_text(glyph.cpu, "%d%%", pill_bg, pill_fg)
awful.widget.watch("bash -c \"top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1\"", 2, function(_, stdout)
    local cpu = math.floor(tonumber(stdout) or 0)
    cpu_text_tb.markup = string.format("%d%%", cpu)
end)

-- RAM widget
local ram_widget, ram_icon_tb, ram_text_tb, ram_layout = pill_icon_text(glyph.ram, "%d%%", pill_bg, pill_fg)
awful.widget.watch("bash -c \"free | awk '/Mem:/ {printf \\\\\"%.0f\\\\\", $3/$2 * 100}'\"", 2, function(_, stdout)
    local ram = math.floor(tonumber(stdout) or 0)
    ram_text_tb.markup = string.format("%d%%", ram)
end)

-- Network widget
local net_widget, net_icon_tb, net_text_tb, net_layout = pill_icon_text(glyph.net_down, "%s", pill_bg, pill_fg)
local last_rx, last_tx = 0, 0
awful.widget.watch("bash -c \"cat /proc/net/dev | awk '/wlp|enp|eth/ {rx+=$2; tx+=$10} END {print rx, tx}'\"", 1, function(_, stdout)
    local rx, tx = stdout:match("(%d+)%s+(%d+)")
    rx, tx = tonumber(rx) or 0, tonumber(tx) or 0
    if last_rx > 0 and last_tx > 0 then
        local down = (rx - last_rx) / 1024
        local down_str = down > 1024 and string.format("%.1fM", down/1024) or string.format("%.0fK", down)
        net_text_tb.markup = string.format("%s", down_str)
    end
    last_rx, last_tx = rx, tx
end)

-- Clock widget — separate icon + text containers
local clock_widget, clock_icon_tb, clock_text_tb, clock_layout = pill_icon_text(glyph.clock, "%H:%M", pill_bg, pill_fg)
-- Update clock periodically using os.date
local clock_timer = gears.timer {
    timeout = 1,
    callback = function()
        clock_text_tb.markup = os.date("%H:%M")
    end,
}
clock_timer:start()

-- Popup/Tooltip Management System
local popup_registry = {
    active_popup = nil,
    active_tooltip = nil,
    password_popup = nil,  -- special case, doesn't interfere with others
}

local function hide_active_tooltip()
    if popup_registry.active_tooltip and popup_registry.active_tooltip.visible then
        popup_registry.active_tooltip.visible = false
        popup_registry.active_tooltip = nil
    end
end

local function hide_active_popup()
    if popup_registry.active_popup and popup_registry.active_popup.visible then
        popup_registry.active_popup.visible = false
        popup_registry.active_popup = nil
    end
end

local function show_popup(popup, is_password)
    if is_password then
        -- Password popup is special, doesn't interfere
        popup_registry.password_popup = popup
        popup.visible = true
        return
    end
    
    -- Regular popup: hide tooltip and other popups
    hide_active_tooltip()
    hide_active_popup()
    popup_registry.active_popup = popup
    popup.visible = true
end

local function hide_popup(popup, is_password)
    if is_password then
        if popup_registry.password_popup == popup then
            popup_registry.password_popup = nil
        end
    else
        if popup_registry.active_popup == popup then
            popup_registry.active_popup = nil
        end
    end
    popup.visible = false
end

local function show_tooltip(popup)
    -- Tooltip: hide if there's already a popup active
    if popup_registry.active_popup then
        return  -- Don't show tooltip if popup is active
    end
    hide_active_tooltip()
    popup_registry.active_tooltip = popup
    popup.visible = true
end

local function hide_tooltip(popup)
    if popup_registry.active_tooltip == popup then
        popup_registry.active_tooltip = nil
    end
    popup.visible = false
end

-- Clock tooltip showing date (custom popup for better styling)
local tooltip_text_widget = wibox.widget.textbox()
tooltip_text_widget.font = font_popup
tooltip_text_widget.align = "center"
tooltip_text_widget.valign = "center"
tooltip_text_widget.markup = '<span foreground="#cdd6f4">Sunday, 31 August 2025</span>'

local clock_tooltip_popup = awful.popup {
    widget = {
        tooltip_text_widget,
        margins = 8,
        widget = wibox.container.margin,
    },
    bg = "#1e1e2eee",
    fg = "#cdd6f4",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
    ontop = true,
    visible = false,
    type = "tooltip",
}

-- Mouse follow tooltip
local clock_tooltip_follow_timer = nil

clock_widget:connect_signal("mouse::enter", function()
    tooltip_text_widget.markup = '<span foreground="#cdd6f4">' .. os.date("%A, %d %B %Y") .. '</span>'
    show_tooltip(clock_tooltip_popup)
    
    local x, y = mouse.coords().x, mouse.coords().y
    clock_tooltip_popup.x = x - 100
    clock_tooltip_popup.y = y + 20
    
    -- Start following mouse
    clock_tooltip_follow_timer = gears.timer {
        timeout = 0.016,  -- ~60fps
        call_now = false,
        autostart = true,
        callback = function()
            if clock_tooltip_popup.visible then
                local mx, my = mouse.coords().x, mouse.coords().y
                clock_tooltip_popup.x = mx - 100
                clock_tooltip_popup.y = my + 20
            else
                clock_tooltip_follow_timer:stop()
                clock_tooltip_follow_timer = nil
            end
        end
    }
end)

clock_widget:connect_signal("mouse::leave", function()
    gears.timer.start_new(0.3, function()
        local mouse_x, mouse_y = mouse.coords().x, mouse.coords().y
        local popup_geo = clock_tooltip_popup:geometry()
        if mouse_x < popup_geo.x or mouse_x > popup_geo.x + popup_geo.width or
           mouse_y < popup_geo.y or mouse_y > popup_geo.y + popup_geo.height then
            hide_tooltip(clock_tooltip_popup)
            if clock_tooltip_follow_timer then
                clock_tooltip_follow_timer:stop()
                clock_tooltip_follow_timer = nil
            end
        end
        return false
    end)
end)

-- Calendar state
local cal_year, cal_month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
local days_in_month = {31,28,31,30,31,30,31,31,30,31,30,31}
local month_names = {"January","February","March","April","May","June","July","August","September","October","November","December"}
local day_names = {"Mo","Tu","We","Th","Fr","Sa","Su"}

local function is_leap_year(y) return (y%4==0 and y%100~=0) or (y%400==0) end
local function days_in(m,y) return m==2 and is_leap_year(y) and 29 or days_in_month[m] end
local function first_day_of_month(m,y)
    local wday = tonumber(os.date("%w", os.time{year=y,month=m,day=1}))
    -- Convert from Sunday=0 to Monday=0
    return wday == 0 and 6 or wday - 1
end

-- Pre-create all day widgets (7x6 grid = 42 cells max)
local day_widgets = {}
for i = 1, 42 do
    local tb = wibox.widget.textbox()
    tb.font = font_popup_regular
    tb.align = "center"
    tb.valign = "center"
    tb.forced_width = 24
    tb.forced_height = 24
    day_widgets[i] = tb
end

-- Create calendar grid with header
local cal_grid_widget = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 2,
}

-- Header row
local header_row = wibox.widget { layout = wibox.layout.fixed.horizontal, spacing = 4 }
local header_colors = {"#cdd6f4","#cdd6f4","#cdd6f4","#cdd6f4","#74c7a4","#cdd6f4","#e06c8a"} -- Fr green darker, Su red darker
for idx, day in ipairs(day_names) do
    header_row:add(wibox.widget {
        markup = string.format("<span foreground='%s'>%s</span>", header_colors[idx], day),
        font = font_popup,
        align = "center",
        valign = "center",
        forced_width = 28,
        forced_height = 20,
        widget = wibox.widget.textbox,
    })
end
cal_grid_widget:add(header_row)

-- Week rows (6 rows max)
local day_cells = {}  -- indexed by widget position 1..42, holds the circle bg container
local week_rows = {}
for w = 1, 6 do
    local row = wibox.widget { layout = wibox.layout.fixed.horizontal, spacing = 4 }
    for d = 1, 7 do
        local idx = (w-1)*7 + d
        -- Create a fixed-size container with circle background
        local cell = wibox.container.background()
        cell.forced_width = 28
        cell.forced_height = 28
        cell.bg = "#1e1e2e"
        cell.shape = gears.shape.circle
        cell.shape_clip = true
        -- Place textbox in center of circle
        local place = wibox.container.place(day_widgets[idx])
        place.halign = "center"
        place.valign = "center"
        cell.widget = place
        day_cells[idx] = cell
        row:add(cell)
    end
    week_rows[w] = row
    cal_grid_widget:add(row)
end

local cal_month_year = wibox.widget.textbox()
cal_month_year.font = font_popup
cal_month_year.align = "center"
cal_month_year.valign = "center"

local function render_calendar()
    -- Update month/year label (dark blue for current month)
    cal_month_year.markup = string.format("<span foreground='#89b4fa'><b>%s %d</b></span>", month_names[cal_month], cal_year)
    
    -- Calculate days
    local first_day = first_day_of_month(cal_month, cal_year)
    local num_days = days_in(cal_month, cal_year)
    local today = tonumber(os.date("%d"))
    local current_month = tonumber(os.date("%m"))
    local current_year = tonumber(os.date("%Y"))
    
    -- Calculate previous month
    local prev_month = cal_month - 1
    local prev_year = cal_year
    if prev_month < 1 then
        prev_month = 12
        prev_year = cal_year - 1
    end
    local prev_days = days_in(prev_month, prev_year)
    
    -- Calculate next month
    local next_month = cal_month + 1
    local next_year = cal_year
    if next_month > 12 then
        next_month = 1
        next_year = cal_year + 1
    end
    
    -- Clear all cells first
    for i = 1, 42 do
        day_widgets[i].markup = ""
        day_cells[i].bg = "#1e1e2e"
    end
    
    -- Fill previous month days (before current month)
    for i = 1, first_day do
        local day_num = prev_days - first_day + i
        local col_idx = i  -- 1=Monday, 7=Sunday
        local fg
        
        if col_idx == 7 then  -- Sunday
            fg = "#78424d"  -- Darker faded red
        elseif col_idx == 5 then  -- Friday
            fg = "#4a7a68"  -- Darker faded green
        else
            fg = "#585b70"  -- Faded gray
        end
        
        day_widgets[i].markup = string.format("<span foreground='%s'>%d</span>", fg, day_num)
    end
    
    -- Fill current month days
    for i = first_day + 1, first_day + num_days do
        local day_num = i - first_day
        local col_idx = ((i-1)%7)+1  -- 1=Monday, 7=Sunday
        local is_today = (day_num == today and cal_month == current_month and cal_year == current_year)
        local fg, bg
        
        if is_today then
            fg = "#ffffff"  -- White text on dark blue
            bg = "#1e3a8a"  -- Dark blue background
        elseif col_idx == 7 then  -- Sunday
            fg = "#e06c8a"
            bg = "#1e1e2e"
        elseif col_idx == 5 then  -- Friday
            fg = "#74c7a4"
            bg = "#1e1e2e"
        else
            fg = "#cdd6f4"
            bg = "#1e1e2e"
        end
        
        day_widgets[i].markup = string.format("<span foreground='%s'>%d</span>", fg, day_num)
        day_cells[i].bg = bg
    end
    
    -- Fill next month days (after current month)
    local next_start = first_day + num_days + 1
    local next_day_num = 1
    for i = next_start, 42 do
        local col_idx = ((i-1)%7)+1  -- 1=Monday, 7=Sunday
        local fg
        
        if col_idx == 7 then  -- Sunday
            fg = "#78424d"  -- Darker faded red
        elseif col_idx == 5 then  -- Friday
            fg = "#4a7a68"  -- Darker faded green
        else
            fg = "#585b70"  -- Faded gray
        end
        
        day_widgets[i].markup = string.format("<span foreground='%s'>%d</span>", fg, next_day_num)
        next_day_num = next_day_num + 1
    end
end

local calendar_popup = awful.popup {
    widget = wibox.container.margin(
        wibox.widget {
            {
                {
                    text = "<-",
                    font = font_popup,
                    align = "center",
                    valign = "center",
                    forced_height = 18,
                    widget = wibox.widget.textbox,
                    buttons = gears.table.join(
                        awful.button({}, 1, function() 
                            cal_month = cal_month - 1
                            if cal_month < 1 then cal_month = 12; cal_year = cal_year - 1 end
                            render_calendar()
                        end)
                    ),
                },
                cal_month_year,
                {
                    text = "->",
                    font = font_popup,
                    align = "center",
                    valign = "center",
                    forced_height = 18,
                    widget = wibox.widget.textbox,
                    buttons = gears.table.join(
                        awful.button({}, 1, function() 
                            cal_month = cal_month + 1
                            if cal_month > 12 then cal_month = 1; cal_year = cal_year + 1 end
                            render_calendar()
                        end)
                    ),
                },
                layout = wibox.layout.align.horizontal,
            },
            cal_grid_widget,
            layout = wibox.layout.fixed.vertical,
            spacing = 12,
        },
        24, 24, 16, 20  -- left, right, top, bottom
    ),
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
    ontop = true,
    visible = false,
}

-- Toggle calendar on clock click
clock_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        if calendar_popup.visible then
            hide_popup(calendar_popup)
        else
            show_popup(calendar_popup)
            cal_year, cal_month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
            render_calendar()
            local s = awful.screen.focused().geometry
            calendar_popup.x = s.x + s.width - 300
            calendar_popup.y = s.y + 30
        end
    end)
))

-- Auto-hide calendar when mouse leaves
calendar_popup:connect_signal("mouse::leave", function()
    gears.timer.start_new(0.3, function()
        local mouse_x, mouse_y = mouse.coords().x, mouse.coords().y
        local popup_geo = calendar_popup:geometry()
        if mouse_x < popup_geo.x or mouse_x > popup_geo.x + popup_geo.width or
           mouse_y < popup_geo.y or mouse_y > popup_geo.y + popup_geo.height then
            hide_popup(calendar_popup)
        end
        return false
    end)
end)

-- Layout indicator widget — icon only, no text
local layout_widget = wibox.widget {
    {
        widget = wibox.widget.textbox,
        font = font_icon,
        align = "center",
        valign = "center",
    },
    left = pill_padding,
    right = pill_padding,
    top = 2,
    bottom = 2,
    widget = wibox.container.margin,
    forced_width = 24,
}
layout_widget.forced_height = wibar_height - 4
local layout_icon_tb = layout_widget.children[1]

local function update_layout_w()
    local s = awful.screen.focused()
    local layout = s.selected_tag and s.selected_tag.layout or awful.layout.suit.floating
    local name = layout.name or "floating"
    local icons = {
        floating = "󰝴", tile = "󰕰", tileleft = "󰕱", tilebottom = "󰕲",
        tiletop = "󰕳", fairv = "󰕴", fairh = "󰕵", spiral = "󰕶",
        dwindle = "󰕷", max = "󰕸", fullscreen = "󰕹", magnifier = "󰕺", cornernw = "󰕻"
    }
    layout_icon_tb:set_markup_silently(icons[name] or icons.floating)
end

awful.screen.connect_for_each_screen(function(s)
    s:connect_signal("tag::history::update", update_layout_w)
    s:connect_signal("tag::property::selected", update_layout_w)
end)
client.connect_signal("property::fullscreen", update_layout_w)
client.connect_signal("focus", update_layout_w)
update_layout_w()

-- Volume popup
local vol_slider = wibox.widget {
    widget     = wibox.widget.slider,
    value      = 40,
    maximum    = 100,
    forced_width = 160,
    bar_color  = "#585b70",
    bar_active_color = "#89b4fa",
    bar_shape  = gears.shape.rounded_bar,
    bar_margins = { bottom = 8, top = 8 },
    handle_width = 12,
    handle_color = "#cdd6f4",
    handle_shape = gears.shape.circle,
    handle_border_width = 2,
    handle_border_color = "#45475a",
}

local vol_text = wibox.widget {
    markup = string.format("<span font=\"%s\">40%%</span>", font),
    align = "center",
    forced_width = 36,
    widget = wibox.widget.textbox,
}

local vol_popup_widget = wibox.widget {
    {
        {
            text = icon(glyph.vol_high),
            forced_width = 20,
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        vol_slider,
        vol_text,
        spacing = 10,
        layout = wibox.layout.fixed.horizontal,
    },
    margins = 10,
    forced_height = 42,
    widget = wibox.container.margin,
}

local vol_popup = awful.popup {
    widget = vol_popup_widget,
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
    ontop = true,
    visible = false,
    x = 0,
    y = 0,
}

-- Auto-hide popup when mouse leaves
local vol_popup_timer = gears.timer {
    timeout   = 0.5,
    single_shot = true,
    callback  = function()
        vol_popup.visible = false
    end,
}
vol_popup:connect_signal("mouse::leave", function()
    vol_popup_timer:start()
end)
vol_popup:connect_signal("mouse::enter", function()
    vol_popup_timer:stop()
end)

vol_slider:connect_signal("property::value", function(self)
    local val = self.value
    if val then
        vol_text.markup = math.floor(val) .. "%"
        awful.spawn("pamixer --set-volume " .. math.floor(val), false)
    end
end)

-- Volume bar widget — use pill_icon_text for proper centering
local vol_widget, vol_icon_tb, vol_text_tb, vol_layout = pill_icon_text(glyph.vol_high, "%d%%", pill_bg, pill_fg)
vol_widget:buttons(gears.table.join(
    awful.button({ }, 1, function()
        vol_popup.visible = not vol_popup.visible
        if vol_popup.visible then
            local s = awful.screen.focused().geometry
            vol_popup.x = s.x + s.width - 260
            vol_popup.y = s.y + 30
        end
    end),
    awful.button({ }, 4, function() awful.spawn.with_shell("pamixer -i 5") end),
    awful.button({ }, 5, function() awful.spawn.with_shell("pamixer -d 5") end),
    awful.button({ }, 3, function() awful.spawn.with_shell("pamixer -t") end)
))
vol_text_tb.markup = "45%"
awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
    local vol = math.floor(tonumber(stdout) or 0)
    vol_slider.value = vol
    vol_text_tb.markup = string.format("%d%%", vol)
end)
awful.widget.watch("pamixer --get-volume 2>/dev/null", 1, function(_, stdout)
    local vol = math.floor(tonumber(stdout) or 0)
    vol_slider.value = vol
    vol_text_tb.markup = string.format("%d%%", vol)
end, vol_layout)

-- Settings widget (control center popup)
local set_widget = wibox.widget.textbox()
set_widget.font = font_icon

-- Brightness slider
local bri_slider = wibox.widget {
    widget     = wibox.widget.slider,
    value      = 50,
    maximum    = 100,
    forced_width = 180,
    bar_color  = "#585b70",
    bar_active_color = "#f9e2af",
    bar_shape  = gears.shape.rounded_bar,
    bar_margins = { bottom = 10, top = 10 },
    handle_width = 10,
    handle_color = "#cdd6f4",
    handle_shape = gears.shape.circle,
    handle_border_width = 2,
    handle_border_color = "#45475a",
}
local bri_text = wibox.widget {
    markup = string.format("<span font=\"%s\">50%%</span>", font),
    forced_width = 40,
    align = "center",
    widget = wibox.widget.textbox,
}
bri_slider:connect_signal("property::value", function(self)
    local val = self.value
    if val then
        bri_text.markup = string.format("<span font=\"%s\">%d%%</span>", font, math.floor(val))
        awful.spawn("brightnessctl set " .. math.floor(val) .. "%", false)
    end
end)

-- Toggle button helper (wifi/bt/airplane) — settings-style switch
-- Drawn entirely with cairo: pill track + sliding knob circle.
local function make_switch(sz)
    sz = sz or 10
    local state = false
    local sw = wibox.widget.base.make_widget(nil, nil, { enable_properties = true })
    local function fit(_, _, _, _) return 24, sz + 2 end
    local function draw(_, _, cr, w, h)
        -- track pill
        cr:set_source(gears.color(state and "#89b4fa" or "#585b70"))
        gears.shape.rounded_rect(cr, w, h, h / 2)
        cr:fill()
        -- knob circle: left when off, right when on
        local r = h / 2 - 1
        local cx = state and (w - h / 2) or (h / 2)
        cr:set_source(gears.color(state and "#1e1e2e" or "#cdd6f4"))
        cr:arc(cx, h / 2, r, 0, 2 * math.pi)
        cr:fill_preserve()
        cr:set_source(gears.color("#00000022"))
        cr:set_line_width(0.5)
        cr:stroke()
    end
    rawset(sw, "fit", fit)
    rawset(sw, "draw", draw)
    sw.set_switch = function(on)
        state = on
        sw:emit_signal("widget::redraw_needed")
    end
    return sw
end

local function wrap_switch(sw)
    return wibox.widget {
        sw,
        valign = "center",
        widget = wibox.container.place,
    }
end

local icon_font_str = "JetBrainsMono Nerd Font Mono 14"
local row_h = 24
local icon_w  = 20

local function make_icon_tb(icon_char)
    return wibox.widget {
        markup = icon_char,
        font = icon_font_str,
        align = "center",
        valign = "center",
        forced_width = icon_w,
        forced_height = row_h,
        widget = wibox.widget.textbox,
    }
end

local function make_row(icon, label, fnt)
    fnt = fnt or font

    local icon_tb = make_icon_tb(icon)

    local label_tb = wibox.widget {
        markup = label,
        font = fnt,
        align = "left",
        valign = "center",
        forced_height = row_h,
        widget = wibox.widget.textbox,
    }

    local left = wibox.widget {
        icon_tb,
        label_tb,
        spacing = 8,
        layout = wibox.layout.fixed.horizontal,
    }

    -- Proxy for icon_widget
    local icon_proxy = {}
    function icon_proxy:set_text(new_icon)
        icon_tb.markup = new_icon
    end

    -- Proxy for label_widget
    local label_proxy = {}
    setmetatable(label_proxy, {
        __newindex = function(self, key, value)
            if key == "markup" then
                label_tb.markup = value
            end
        end,
        __index = function(self, key)
            if key == "markup" then return label_tb.markup end
            return label_tb[key]
        end,
    })

    local right_slot = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 8,
    }

    local row = wibox.widget {
        left,
        nil,
        right_slot,
        layout = wibox.layout.align.horizontal,
        forced_height = row_h,
    }

    row.icon_widget = icon_proxy
    row.label_widget = label_proxy
    row.right_slot = right_slot
    return row
end

-- Separator line
local function make_sep()
    return wibox.widget {
        forced_height = 1,
        bg = "#45475a",
        widget = wibox.container.background,
    }
end

-- WiFi section
local wifi_switch = make_switch()
local wifi_refresh = wibox.widget {
    text = "",
    font = font,
    visible = false,
    align = "center",
    valign = "center",
    forced_width = 20,
    widget = wibox.widget.textbox,
}
local wifi_row = make_row(glyph.wifi_off, "Wi-Fi", font_popup)
-- insert refresh + switch into right slot
do
    wifi_row.right_slot:add(wifi_refresh)
    wifi_row.right_slot:add(wrap_switch(wifi_switch))
end

-- WiFi network list: container rebuilt on each scan, one clickable row per SSID
local wifi_list_layout = wibox.widget {
    layout = wibox.layout.fixed.vertical,
}
local wifi_list_pad = wibox.widget {
    wifi_list_layout,
    left = 14, right = 8, bottom = 4,
    widget = wibox.container.margin,
}
wifi_list_pad.visible = false
local wifi_sep = make_sep()
wifi_sep.visible = false

local wifi_networks = {} -- keep SSIDs alive for button closures

local function connect_to(ssid)
    naughty.notify({ text = "Connecting to " .. ssid .. "...", timeout = 3 })
    awful.spawn.easy_async_with_shell(
        "nmcli dev wifi connect '" .. ssid:gsub("'", "'\\''") .. "'",
        function(stdout, stderr, exit_reason, exit_code)
            if exit_code == 0 then
                naughty.notify({ text = "Connected to " .. ssid, timeout = 3 })
            else
                -- likely needs a password; prompt for it via popup
                local pass_popup
                local pass_tb = wibox.widget.textbox()
                pass_tb.font = font_popup
                pass_tb.align = "left"
                pass_tb.valign = "center"
                pass_tb.forced_width = 240
                
                local function close_popup()
                    if pass_popup then
                        awful.keygrabber.stop()
                        pass_popup.visible = false
                        pass_popup = nil
                    end
                end
                
                pass_popup = awful.popup {
                    widget = wibox.widget {
                        {
                            {
                                markup = "<b>Password for " .. ssid .. "</b>",
                                font = font_popup,
                                widget = wibox.widget.textbox,
                            },
                            {
                                pass_tb,
                                forced_height = 28,
                                bg = "#313244",
                                shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
                                widget = wibox.container.background,
                            },
                            spacing = 8,
                            layout = wibox.layout.fixed.vertical,
                        },
                        margins = 12,
                        widget = wibox.container.margin,
                    },
                    bg = "#1e1e2eee",
                    border_width = 1,
                    border_color = "#313244",
                    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
                    ontop = true,
                    visible = true,
                }
                
                local s = awful.screen.focused().geometry
                pass_popup.x = s.x + s.width / 2 - 150
                pass_popup.y = s.y + s.height / 2 - 60
                
                awful.prompt.run {
                    prompt = "",
                    textbox = pass_tb,
                    bg_cursor = "#cdd6f4",
                    exe_callback = function(pass)
                        close_popup()
                        if pass and pass ~= "" then
                            awful.spawn.easy_async_with_shell(
                                "nmcli dev wifi connect '" .. ssid:gsub("'", "'\\''") .. "' password '" .. pass:gsub("'", "'\\''") .. "'",
                                function(o, e, r, c)
                                    if c == 0 then
                                        naughty.notify({ text = "Connected to " .. ssid, timeout = 3 })
                                    else
                                        naughty.notify({ text = "Failed: wrong password?", timeout = 4 })
                                    end
                                end
                            )
                        end
                    end,
                    done_callback = function()
                        close_popup()
                    end,
                }
            end
        end
    )
end

local wifi_spinner = wibox.widget.textbox()
wifi_spinner.font = font
local spin_frame = 0

-- Spinning dots animation while scanning
local spin_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spin_timer = gears.timer {
    timeout = 0.08,
    call_now = false,
    callback = function()
        spin_frame = (spin_frame % #spin_frames) + 1
        wifi_spinner.markup = "<span foreground='#89b4fa'>" .. spin_frames[spin_frame] .. "</span> <i>Scanning...</i>"
    end,
}

local function refresh_wifi()
    -- Always show spinner, replace contents
    spin_timer:stop()
    spin_frame = 0
    wifi_list_layout:reset()
    wifi_list_layout:add(wifi_spinner)
    wifi_spinner.markup = "<span foreground='#89b4fa'>⠋</span> <i>Scanning...</i>"
    spin_timer:start()
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f ACTIVE,SIGNAL,SSID dev wifi list 2>/dev/null | head -8",
        function(stdout)
            spin_timer:stop()
            local rows = {}
            local count = 0
            for line in stdout:gmatch("[^\n]+") do
                local active, signal, ssid = line:match("^(yes):(%d+):(.*)$")
                if not active then
                    local sig, name = line:match("^no:(%d+):(.*)$")
                    if name and name ~= "" then
                        rows[#rows+1] = { ssid = name, signal = tonumber(sig) or 0, active = false }
                        count = count + 1
                    end
                else
                    table.insert(rows, 1, { ssid = ssid, signal = tonumber(signal) or 0, active = true })
                end
            end

            wifi_list_layout:reset()
            if #rows == 0 then
                wifi_list_layout:add(wibox.widget {
                    markup = "<i>No networks found</i>",
                    font = font,
                    widget = wibox.widget.textbox,
                })
                return
            end

            for _, net in ipairs(rows) do
                local label = string.format(
                    "%s %s (%d%%)",
                    net.active and "●" or "○",
                    net.ssid,
                    net.signal
                )
                local row_w = wibox.widget {
                    markup = net.active and ("<b>" .. label .. "</b>") :gsub("●", '<span foreground="#a6e3a1">●</span>') or label,
                    font = font,
                    align = "left",
                    widget = wibox.widget.textbox,
                }
                row_w:buttons(gears.table.join(
                    awful.button({ }, 1, function()
                        if not net.active then connect_to(net.ssid) end
                    end)
                ))
                wifi_list_layout:add(row_w)
            end
        end
    )
end

local function set_wifi_visible(on)
    wifi_sep.visible = on
    wifi_list_pad.visible = on
    wifi_refresh.visible = on
    if on then refresh_wifi() end
end

wifi_refresh:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async("nmcli device wifi rescan", function() refresh_wifi() end)
    end)
))

wifi_switch:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async_with_shell("nmcli radio wifi", function(stdout)
            local is_on = stdout:match("enabled")
            if is_on then
                awful.spawn("nmcli radio wifi off")
                wifi_switch.set_switch(false)
                wifi_row.label_widget.markup = "<span foreground='#a6adc8'>Wi-Fi</span>"
                wifi_row.icon_widget:set_text(glyph.wifi_off)
                set_wifi_visible(false)
            else
                awful.spawn("nmcli radio wifi on")
                wifi_switch.set_switch(true)
                wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
                wifi_row.icon_widget:set_text(glyph.wifi_on)
                set_wifi_visible(true)
                awful.spawn.easy_async("nmcli device wifi rescan", function() refresh_wifi() end)
            end
        end)
    end)
))

-- Bluetooth section
local bt_switch = make_switch()
local bt_row = make_row(glyph.bt_off, "Bluetooth", font_popup)
bt_row.right_slot:add(wrap_switch(bt_switch))

bt_switch:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async_with_shell("rfkill list bluetooth", function(stdout)
            local blocked = stdout:find("blocked: yes")
            if blocked then
                awful.spawn("rfkill unblock bluetooth")
                bt_switch.set_switch(true)
                bt_row.label_widget.markup = "<b>Bluetooth</b>"
                bt_row.icon_widget:set_text(glyph.bt_on)
            else
                awful.spawn("rfkill block bluetooth")
                bt_switch.set_switch(false)
                bt_row.label_widget.markup = "<span foreground='#a6adc8'>Bluetooth</span>"
                bt_row.icon_widget:set_text(glyph.bt_off)
            end
        end)
    end)
))

-- Airplane mode toggle
local ap_switch = make_switch()
local ap_row = make_row(glyph.airplane_off, "Airplane Mode", font_popup)
ap_row.right_slot:add(wrap_switch(ap_switch))

ap_switch:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async_with_shell("rfkill list | grep -c 'blocked: yes'", function(stdout)
            local any_blocked = tonumber(stdout) or 0
            if any_blocked > 0 then
                awful.spawn("rfkill unblock all")
                ap_switch.set_switch(false)
                wifi_switch.set_switch(true)
                wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
                wifi_row.icon_widget:set_text(glyph.wifi_on)
                set_wifi_visible(true)
                bt_switch.set_switch(true)
                bt_row.label_widget.markup = "<b>Bluetooth</b>"
                bt_row.icon_widget:set_text(glyph.bt_on)
            else
                awful.spawn("rfkill block all")
                ap_switch.set_switch(true)
                wifi_switch.set_switch(false)
                wifi_row.label_widget.markup = "<span foreground='#a6adc8'>Wi-Fi</span>"
                wifi_row.icon_widget:set_text(glyph.wifi_off)
                set_wifi_visible(false)
                bt_switch.set_switch(false)
                bt_row.label_widget.markup = "<span foreground='#a6adc8'>Bluetooth</span>"
                bt_row.icon_widget:set_text(glyph.bt_off)
            end
        end)
    end)
))

-- Settings popup
local set_popup = awful.popup {
    widget = wibox.widget {
        {
            { -- Brightness row
                make_icon_tb(glyph.brightness),
                bri_slider,
                bri_text,
                spacing = 8,
                forced_height = row_h,
                layout = wibox.layout.fixed.horizontal,
            },
            { -- spacing after brightness
                forced_height = 6,
                widget = wibox.container.background,
            },
            make_sep(),
            wifi_row,
            wifi_sep,
            wifi_list_pad,
            bt_row,
            { forced_height = 6, widget = wibox.container.background },
            ap_row,
            layout = wibox.layout.fixed.vertical,
        },
        margins = 12,
        widget = wibox.container.margin,
    },
    minimum_width = 280,
    maximum_width = 280,
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
    ontop = true,
    visible = false,
}

-- Init states
awful.spawn.easy_async_with_shell(
    "nmcli radio wifi; rfkill list bluetooth 2>/dev/null | grep -o 'blocked: yes'; brightnessctl g 2>/dev/null; brightnessctl m 2>/dev/null",
    function(stdout)
        local wifi_on = stdout:match("enabled") ~= nil
        wifi_switch.set_switch(wifi_on)
        if wifi_on then
            wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
            wifi_row.icon_widget:set_text(glyph.wifi_on)
        end

        local vals = {}
        for v in stdout:gmatch("%d+") do vals[#vals+1] = tonumber(v) end
        local bri_cur, bri_max
        -- brightness values are the last two numbers (g then m)
        if #vals >= 2 then bri_cur, bri_max = vals[#vals-1], vals[#vals] end
        if bri_cur and bri_max and bri_max > 0 then
            local pct = math.floor(bri_cur / bri_max * 100)
            bri_slider.value = pct
            bri_text.markup = pct .. "%"
        end

        local bt_blocked = stdout:find("blocked: yes") ~= nil
        bt_switch.set_switch(not bt_blocked)
    end
)

-- Track if mouse has entered the popup (avoid instant leave on spawn)
local popup_entered = false

set_popup:connect_signal("mouse::enter", function()
    popup_entered = true
end)

set_popup:connect_signal("mouse::leave", function()
    if popup_entered then
        set_popup.visible = false
        set_wifi_visible(false)
        popup_entered = false
    end
end)

set_widget.font = font_icon
set_widget.align = "center"
set_widget.valign = "center"
set_widget.forced_width = 24
set_widget:set_markup_silently(glyph.settings)
set_widget:buttons(gears.table.join(
    awful.button({ }, 1, function()
        popup_entered = false
        set_popup.visible = not set_popup.visible
        if set_popup.visible then
            local s = awful.screen.focused().geometry
            set_popup.x = s.x + s.width - 300
            set_popup.y = s.y + 30
            -- Auto rescan wifi if enabled
            awful.spawn.easy_async_with_shell("nmcli radio wifi", function(stdout)
                if stdout:match("enabled") then
                    wifi_switch.set_switch(true)
                    wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
                    wifi_row.icon_widget:set_text(glyph.wifi_on)
                    set_wifi_visible(true)
                else
                    wifi_switch.set_switch(false)
                    set_wifi_visible(false)
                end
            end)
            -- Refresh brightness
            awful.spawn.easy_async_with_shell("brightnessctl g 2>/dev/null; brightnessctl m 2>/dev/null", function(out)
                local cur, mx = out:match("(%d+)\n(%d+)")
                if cur and mx and tonumber(mx) > 0 then
                    local pct = math.floor(tonumber(cur) / tonumber(mx) * 100)
                    bri_slider.value = pct
                    bri_text.markup = pct .. "%"
                end
            end)
        end
    end)
))

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
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
        style = {
            spacing = 4,
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 10) end,
            bg_empty = "transparent",
            bg_occupied = beautiful.surface0,
            bg_focus = "#3b5998",
            fg_focus = beautiful.text,
            fg_occupied = beautiful.subtext1,
            fg_empty = "transparent",
            default = {
                shape = function() end,
            },
            focus = {
                shape = function() end,
            },
            urgent = {
                shape = function() end,
            },
        },
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                id = "text_role",
                font = font,
                align = "center",
                valign = "center",
                forced_width = 20,
                forced_height = 20,
                widget = wibox.widget.textbox
            },
            id = "background_role",
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 10) end,
            forced_width = 20,
            forced_height = 20,
            widget = wibox.container.background
        },
        create_callback = function(self, c3, index)
            self:get_children_by_id("text_role")[1]:set_text(tostring(index))
        end,
        update_callback = function(self, c3, index)
            self:get_children_by_id("text_role")[1]:set_text(tostring(index))
        end,
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
            shape = gears.shape.rectangle,
        },
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id     = 'clienticon',
                        widget = awful.widget.clienticon,
                        forced_width = 16,
                        forced_height = 16,
                    },
                    halign = "center",
                    valign = "center",
                    widget = wibox.container.place,
                },
                margins = 2,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 28,
            forced_height   = 28,
            widget          = wibox.container.background,
            create_callback = function(self, c, index, objects)
                local icon = self:get_children_by_id('clienticon')[1]
                icon.client = c
            end,
            update_callback = function(self, c, index, objects)
                if c == client.focus then
                    self.bg = beautiful.tasklist_bg_focus
                else
                    self.bg = beautiful.tasklist_bg_normal
                end
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
        expand = "none",
        { -- Left: launcher + taglist
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = pill_spacing,
                pill_widget(mylauncher),
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
        { -- Center: tasklist
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
        { -- Right: pills
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = pill_spacing,
                pill_widget(cpu_widget),
                pill_widget(ram_widget),
                pill_widget(net_widget),
                pill_widget(vol_widget),
                pill_widget(set_widget),
                pill_widget(clock_widget),
                pill_widget(layout_widget),
            },
            widget = wibox.container.place,
            valign = "center",
        },
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
    awful.key({ "Mod1" }, "F1", hotkeys_popup.show_help, {description="show help", group="awesome"}),
    awful.key({ modkey }, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({ modkey }, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),

    awful.key({ modkey }, "d", function() awful.client.focus.byidx(1) end, {description = "focus next by index", group = "client"}),
    awful.key({ modkey }, "a", function() awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}),
    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end, {description = "focus next by index", group = "client"}),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}),

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
    awful.key({ modkey }, "f", function() awful.spawn("thunar") end, {description = "open file explorer", group = "launcher"}),
    awful.key({ modkey }, "b", function() awful.spawn("firefox") end, {description = "open browser", group = "launcher"}),
    awful.key({ modkey }, "space", function() awful.spawn("rofi -show drun") end, {description = "rofi app launcher", group = "launcher"}),
    awful.key({ modkey }, "o", function() awful.spawn("obsidian") end, {description = "open notes", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift" }, "q", awesome.quit, {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end, {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end, {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end, {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end, {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end, {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end, {description = "decrease the number of columns", group = "layout"}),
    awful.key({ "Mod1" }, "space", function() awful.layout.inc(1) end, {description = "select next", group = "layout"}),
    awful.key({ "Mod1", "Shift" }, "space", function() awful.layout.inc(-1) end, {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        if c then c:emit_signal("request::activate", "key.unminimize", {raise = true}) end
    end, {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end, {description = "run prompt", group = "launcher"}),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end, {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ "Mod1" }, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end, {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey }, "x", function(c) c:kill() end, {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle, {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
    awful.key({ modkey, "Control" }, "o", function(c) c:move_to_screen() end, {description = "move to screen", group = "client"}),
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
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, {description = "toggle tag #" .. i, group = "tag"}),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
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
                     placement = function(c)
                         -- Don't re-position restored clients on awesome restart
                         if not awesome.startup then
                             return awful.placement.centered(c)
                         end
                     end,
                     size_hints_honor = false,
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
-- }}}
