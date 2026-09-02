-- modules/power.lua
-- Power menu popup: shutdown, restart, logout
-- Centered, persistent (no auto-hide)

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Layout constants
local popup_w = 300
local option_h = 50
local font_icon_big = "icons 24"
local font_label_big = "JetBrainsMono Nerd Font Mono Bold 16"

local function make_power_option(icon, label, callback)
    local markup = string.format(
        '<span font="%s">%s</span>  <span font="%s">%s</span>',
        font_icon_big, icon, font_label_big, label
    )

    local row = wibox.widget {
        {
            markup = markup,
            align = "left",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        layout = wibox.layout.fixed.horizontal,
        forced_height = option_h,
    }

    row:connect_signal("mouse::enter", function() row.bg = m.surface0 end)
    row:connect_signal("mouse::leave", function() row.bg = "#00000000" end)

    row:buttons(gears.table.join(
        awful.button({}, 1, function()
            if callback then callback() end
        end)
    ))

    return row
end

local function center_on_screen(popup)
    local s = awful.screen.focused().geometry
    popup.x = s.x + (s.width - popup_w) / 2
    popup.y = s.y + (s.height - 220) / 2
end

-- Power popup
M.power_popup = awful.popup {
    widget = {
        {
            {
                make_power_option(
                    m.glyph.shutdown or "",
                    "Shutdown",
                    function() awful.spawn("systemctl poweroff") end
                ),
                make_power_option(
                    m.glyph.restart or "，",
                    "Restart",
                    function() awful.spawn("systemctl reboot") end
                ),
                make_power_option(
                    m.glyph.logout or "︵",
                    "Logout",
                    function() awesome.quit() end
                ),
                spacing = 8,
                layout = wibox.layout.fixed.vertical,
            },
            halign = "center",
            widget = wibox.container.place,
        },
        margins = 12,
        widget = wibox.container.margin,
    },
    minimum_width = popup_w,
    maximum_width = popup_w,
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end,
    ontop = true,
    visible = false,
}

-- Power widget (power icon)
M.power_widget = wibox.widget.textbox()
M.power_widget.font = m.font_icon
M.power_widget.align = "center"
M.power_widget.valign = "center"
M.power_widget.forced_width = 24
M.power_widget:set_markup_silently(m.glyph.power or "，")

M.power_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        if M.power_popup.visible then
            popup_registry.hide_popup(M.power_popup)
        else
            popup_registry.show_popup(M.power_popup)
            center_on_screen(M.power_popup)
        end
    end)
))

return M
