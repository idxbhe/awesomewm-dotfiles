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
    forced_width = 180,
    bar_color = "#585b70",
    bar_active_color = "#89b4fa",
    bar_shape = gears.shape.rounded_bar,
    bar_margins = { bottom = 10, top = 10 },
    handle_width = 10,
    handle_color = "#cdd6f4",
    handle_shape = gears.shape.circle,
    handle_border_width = 2,
    handle_border_color = "#45475a",
}

local vol_text = wibox.widget {
    markup = string.format('<span font="%s">40%%</span>', m.font),
    align = "center",
    forced_width = 48,
    widget = wibox.widget.textbox,
}

local vol_popup_widget = wibox.widget {
    {
        {
            markup = m.icon(m.glyph.vol_high),
            forced_width = 24,
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        vol_slider,
        vol_text,
        spacing = 8,
        forced_height = 24,
        layout = wibox.layout.fixed.horizontal,
    },
    margins = 10,
    widget = wibox.container.margin,
}

local vol_popup = awful.popup {
    widget = vol_popup_widget,
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
    minimum_width = 288,
    maximum_width = 288,
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
    if not popup_registry.should_auto_hide() then return end
    vol_popup_timer:start()
end)

vol_popup:connect_signal("mouse::enter", function()
    vol_popup_timer:stop()
end)

vol_slider:connect_signal("property::value", function(self)
    local val = self.value
    if val then
        vol_text.markup = math.floor(val) .. "%"
        awful.spawn({"pamixer", "--set-volume", math.floor(val)})
    end
end)

-- Helper: choose icon based on volume level
local function vol_icon(vol)
    if vol == 0 then
        return m.glyph.vol_mute
    elseif vol <= 10 then
        return m.glyph.vol_none
    elseif vol <= 50 then
        return m.glyph.vol_low
    else
        return m.glyph.vol_high
    end
end

-- Volume bar widget
local widgets = require("modules.widgets")
local vol_widget, vol_icon_tb, vol_text_tb, vol_layout = widgets.pill_icon_text(m.glyph.vol_high, "%d%%", m.pill_bg, m.pill_fg)

local function update_vol_icon(vol)
    vol_icon_tb:set_text(vol_icon(vol))
end

-- Get current volume from bar widget text
local function get_current_vol()
    local text = vol_text_tb:get_text()
    return math.floor(tonumber(text:match("(%d+)")) or 0)
end

-- Update bar widget UI immediately
local function update_bar_vol(vol)
    vol = math.max(0, math.min(100, vol))
    vol_text_tb:set_text(string.format("%d%%", vol))
    update_vol_icon(vol)
    vol_slider.value = vol
end

vol_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        if vol_popup.visible then
            popup_registry.hide_popup(vol_popup)
        else
            popup_registry.show_popup(vol_popup)
            local s = awful.screen.focused().geometry
            vol_popup.x = s.x + s.width - 440
            vol_popup.y = s.y + 30
        end
    end),
    awful.button({}, 4, function()
        local new_vol = get_current_vol() + 5
        awful.spawn({"pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%"})
        update_bar_vol(new_vol)
    end),
    awful.button({}, 5, function()
        local new_vol = get_current_vol() - 5
        awful.spawn({"pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%"})
        update_bar_vol(new_vol)
    end),
    awful.button({}, 3, function() awful.spawn({"pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle"}) end)
))

vol_text_tb.markup = "45%"

awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
    local vol = math.floor(tonumber(stdout) or 0)
    vol_slider.value = vol
    vol_text_tb.markup = string.format("%d%%", vol)
    update_vol_icon(vol)
end)

awful.widget.watch("pamixer --get-volume 2>/dev/null", 1, function(_, stdout)
    local vol = math.floor(tonumber(stdout) or 0)
    vol_slider.value = vol
    vol_text_tb.markup = string.format("%d%%", vol)
    update_vol_icon(vol)
end, vol_layout)

M.vol_widget = vol_widget

return M
