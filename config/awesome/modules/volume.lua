-- modules/volume.lua
-- Volume popup with slider control

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Volume popup
local vol_slider = wibox.widget {
    widget = wibox.widget.slider,
    value = 40,
    maximum = 100,
    forced_width = 160,
    bar_color = "#585b70",
    bar_active_color = "#89b4fa",
    bar_shape = gears.shape.rounded_bar,
    bar_margins = { bottom = 8, top = 8 },
    handle_width = 12,
    handle_color = "#cdd6f4",
    handle_shape = gears.shape.circle,
    handle_border_width = 2,
    handle_border_color = "#45475a",
}

local vol_text = wibox.widget {
    markup = string.format('<span font="%s">40%%</span>', m.font),
    align = "center",
    forced_width = 36,
    widget = wibox.widget.textbox,
}

local vol_popup_widget = wibox.widget {
    {
        {
            text = m.icon(m.glyph.vol_high),
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
    timeout = 0.5,
    single_shot = true,
    callback = function()
        popup_registry.hide_popup(vol_popup)
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

-- Volume bar widget
local widgets = require("modules.widgets")
local vol_widget, vol_icon_tb, vol_text_tb, vol_layout = widgets.pill_icon_text(m.glyph.vol_high, "%d%%", m.pill_bg, m.pill_fg)

vol_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        if vol_popup.visible then
            popup_registry.hide_popup(vol_popup)
        else
            popup_registry.show_popup(vol_popup)
            local s = awful.screen.focused().geometry
            vol_popup.x = s.x + s.width - 260
            vol_popup.y = s.y + 30
        end
    end),
    awful.button({}, 4, function() awful.spawn.with_shell("pamixer -i 5") end),
    awful.button({}, 5, function() awful.spawn.with_shell("pamixer -d 5") end),
    awful.button({}, 3, function() awful.spawn.with_shell("pamixer -t") end)
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

M.vol_widget = vol_widget

return M
