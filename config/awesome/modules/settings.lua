-- modules/settings.lua
-- Settings control panel: WiFi, Bluetooth, brightness

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Helper functions
local icon_font_str = "JetBrainsMono Nerd Font Mono 14"
local row_h = 24
local icon_w = 20

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
    fnt = fnt or m.font

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

local function make_sep()
    return wibox.widget {
        forced_height = 1,
        bg = "#45475a",
        widget = wibox.container.background,
    }
end

local function make_switch(sz)
    sz = sz or 10
    local state = false
    local sw = wibox.widget.base.make_widget(nil, nil, { enable_properties = true })
    local function fit(_, _, _, _) return 24, sz + 2 end
    local function draw(_, _, cr, w, h)
        cr:set_source(gears.color(state and "#89b4fa" or "#585b70"))
        gears.shape.rounded_rect(cr, w, h, h / 2)
        cr:fill()
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

-- Brightness slider
local bri_slider = wibox.widget {
    widget = wibox.widget.slider,
    value = 50,
    maximum = 100,
    forced_width = 180,
    bar_color = "#585b70",
    bar_active_color = "#f9e2af",
    bar_shape = gears.shape.rounded_bar,
    bar_margins = { bottom = 10, top = 10 },
    handle_width = 10,
    handle_color = "#cdd6f4",
    handle_shape = gears.shape.circle,
    handle_border_width = 2,
    handle_border_color = "#45475a",
}
local bri_text = wibox.widget {
    markup = string.format('<span font="%s">50%%</span>', m.font),
    forced_width = 40,
    align = "center",
    widget = wibox.widget.textbox,
}
bri_slider:connect_signal("property::value", function(self)
    local val = self.value
    if val then
        bri_text.markup = string.format('<span font="%s">%d%%</span>', m.font, math.floor(val))
        awful.spawn("brightnessctl set " .. math.floor(val) .. "%", false)
    end
end)

-- WiFi section
local wifi_switch = make_switch()
local wifi_refresh = wibox.widget {
    text = "",
    font = m.font,
    visible = false,
    align = "center",
    valign = "center",
    forced_width = 20,
    widget = wibox.widget.textbox,
}
local wifi_row = make_row(m.glyph.wifi_off, "Wi-Fi", m.font_popup)
wifi_row.right_slot:add(wifi_refresh)
wifi_row.right_slot:add(wrap_switch(wifi_switch))

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

local function set_wifi_visible(on)
    wifi_sep.visible = on
    wifi_list_pad.visible = on
    wifi_refresh.visible = on
end

local function connect_to(ssid)
    m.naughty.notify({ text = "Connecting to " .. ssid .. "...", timeout = 3 })
    awful.spawn.easy_async_with_shell(
        "nmcli dev wifi connect '" .. ssid:gsub("'", "'\\''") .. "'",
        function(stdout, stderr, exit_reason, exit_code)
            if exit_code == 0 then
                m.naughty.notify({ text = "Connected to " .. ssid, timeout = 3 })
            else
                local pass_popup
                local pass_tb = wibox.widget.textbox()
                pass_tb.font = m.font_popup
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
                                font = m.font_popup,
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
                                        m.naughty.notify({ text = "Connected to " .. ssid, timeout = 3 })
                                    else
                                        m.naughty.notify({ text = "Failed: wrong password?", timeout = 4 })
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
wifi_spinner.font = m.font
local spin_frame = 0
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
            for line in stdout:gmatch("[^\n]+") do
                local active, signal, ssid = line:match("^(yes):(%d+):(.*)$")
                if not active then
                    local sig, name = line:match("^no:(%d+):(.*)$")
                    if name and name ~= "" then
                        rows[#rows+1] = { ssid = name, signal = tonumber(sig) or 0, active = false }
                    end
                else
                    table.insert(rows, 1, { ssid = ssid, signal = tonumber(signal) or 0, active = true })
                end
            end

            wifi_list_layout:reset()
            if #rows == 0 then
                wifi_list_layout:add(wibox.widget {
                    markup = "<i>No networks found</i>",
                    font = m.font,
                    widget = wibox.widget.textbox,
                })
                return
            end

            for _, net in ipairs(rows) do
                local label = string.format("%s %s (%d%%)", net.active and "●" or "○", net.ssid, net.signal)
                local row_w = wibox.widget {
                    markup = net.active and ("<b>" .. label .. "</b>"):gsub("●", '<span foreground="#a6e3a1">●</span>') or label,
                    font = m.font,
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
                wifi_row.icon_widget:set_text(m.glyph.wifi_off)
                set_wifi_visible(false)
            else
                awful.spawn("nmcli radio wifi on")
                wifi_switch.set_switch(true)
                wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
                wifi_row.icon_widget:set_text(m.glyph.wifi_on)
                set_wifi_visible(true)
                awful.spawn.easy_async("nmcli device wifi rescan", function() refresh_wifi() end)
            end
        end)
    end)
))

-- Bluetooth section
local bt_switch = make_switch()
local bt_row = make_row(m.glyph.bt_off, "Bluetooth", m.font_popup)
bt_row.right_slot:add(wrap_switch(bt_switch))

bt_switch:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async_with_shell("rfkill list bluetooth", function(stdout)
            local blocked = stdout:find("blocked: yes")
            if blocked then
                awful.spawn("rfkill unblock bluetooth")
                bt_switch.set_switch(true)
                bt_row.label_widget.markup = "<b>Bluetooth</b>"
                bt_row.icon_widget:set_text(m.glyph.bt_on)
            else
                awful.spawn("rfkill block bluetooth")
                bt_switch.set_switch(false)
                bt_row.label_widget.markup = "<span foreground='#a6adc8'>Bluetooth</span>"
                bt_row.icon_widget:set_text(m.glyph.bt_off)
            end
        end)
    end)
))

-- Airplane mode toggle
local ap_switch = make_switch()
local ap_row = make_row(m.glyph.airplane_off, "Airplane Mode", m.font_popup)
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
                wifi_row.icon_widget:set_text(m.glyph.wifi_on)
                set_wifi_visible(true)
                bt_switch.set_switch(true)
                bt_row.label_widget.markup = "<b>Bluetooth</b>"
                bt_row.icon_widget:set_text(m.glyph.bt_on)
            else
                awful.spawn("rfkill block all")
                ap_switch.set_switch(true)
                wifi_switch.set_switch(false)
                wifi_row.label_widget.markup = "<span foreground='#a6adc8'>Wi-Fi</span>"
                wifi_row.icon_widget:set_text(m.glyph.wifi_off)
                set_wifi_visible(false)
                bt_switch.set_switch(false)
                bt_row.label_widget.markup = "<span foreground='#a6adc8'>Bluetooth</span>"
                bt_row.icon_widget:set_text(m.glyph.bt_off)
            end
        end)
    end)
))

-- Settings popup
local set_popup = awful.popup {
    widget = wibox.widget {
        {
            { -- Brightness row
                make_icon_tb(m.glyph.brightness),
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
            wifi_row.icon_widget:set_text(m.glyph.wifi_on)
        end

        local vals = {}
        for v in stdout:gmatch("%d+") do vals[#vals+1] = tonumber(v) end
        local bri_cur, bri_max
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

-- Mouse enter/leave
local popup_entered = false
set_popup:connect_signal("mouse::enter", function()
    popup_entered = true
end)

set_popup:connect_signal("mouse::leave", function()
    if popup_entered then
        popup_registry.hide_popup(set_popup)
        set_wifi_visible(false)
        popup_entered = false
    end
end)

-- Settings button
local set_widget = wibox.widget.textbox()
set_widget.font = m.font_icon
set_widget.align = "center"
set_widget.valign = "center"
set_widget.forced_width = 24
set_widget:set_markup_silently(m.glyph.settings)

set_widget:buttons(gears.table.join(
    awful.button({ }, 1, function()
        popup_entered = false
        if set_popup.visible then
            popup_registry.hide_popup(set_popup)
            set_wifi_visible(false)
        else
            popup_registry.show_popup(set_popup)
            local s = awful.screen.focused().geometry
            set_popup.x = s.x + s.width - 300
            set_popup.y = s.y + 30
            awful.spawn.easy_async_with_shell("nmcli radio wifi", function(stdout)
                if stdout:match("enabled") then
                    wifi_switch.set_switch(true)
                    wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
                    wifi_row.icon_widget:set_text(m.glyph.wifi_on)
                    set_wifi_visible(true)
                else
                    wifi_switch.set_switch(false)
                    set_wifi_visible(false)
                end
            end)
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

M.set_widget = set_widget

return M
