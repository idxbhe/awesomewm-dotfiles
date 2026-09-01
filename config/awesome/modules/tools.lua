-- modules/tools.lua
-- Tools popup: list of utility tools with icons
-- Clickable items will trigger respective actions

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Helper: Create icon textbox
local function make_icon_tb(icon_char)
    return wibox.widget {
        markup = icon_char,
        font = m.font_icon,
        align = "center",
        valign = "center",
        forced_width = 20,
        forced_height = 24,
        widget = wibox.widget.textbox,
    }
end

-- Helper: Create clickable tool row
local function make_tool_row(icon, label, callback)
    local row = wibox.widget {
        markup = string.format('<span font="%s">%s</span>  %s', m.font_icon, icon, label),
        font = m.font_popup,
        align = "left",
        valign = "center",
        forced_height = 24,
        widget = wibox.widget.textbox,
    }
    
    -- Make row clickable
    row:buttons(gears.table.join(
        awful.button({}, 1, function()
            if callback then
                callback()
                -- Hide popup after clicking
                popup_registry.hide_popup(tools_popup)
            end
        end)
    ))
    
    -- Hover effect
    row:connect_signal("mouse::enter", function()
        row.bg = m.surface0
    end)
    
    row:connect_signal("mouse::leave", function()
        row.bg = "#00000000"
    end)
    
    return row
end

-- Screenshot icon (camera)
local screenshot_icon = "󰵝"  -- U+F0D5D fa-camera

-- Create tools list
local tools_list = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 4,
}

-- Add Screenshot tool
tools_list:add(make_tool_row(
    screenshot_icon,
    "Screenshot",
    function()
        -- TODO: Implement screenshot menu/submenu
        m.naughty.notify({
            title = "Screenshot",
            text = "Screenshot tool coming soon!",
            timeout = 3,
        })
    end
))

-- Create tools popup
local tools_popup = awful.popup {
    widget = wibox.widget {
        {
            tools_list,
            margins = 12,
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical,
    },
    minimum_width = 200,
    maximum_width = 200,
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 6)
    end,
    ontop = true,
    visible = false,
}

-- Auto-hide on mouse leave
tools_popup:connect_signal("mouse::leave", function()
    gears.timer.start_new(0.5, function()
        local coords = mouse.coords()
        local geo = tools_popup:geometry()
        
        if coords.x < geo.x or coords.x > geo.x + geo.width or
           coords.y < geo.y or coords.y > geo.y + geo.height then
            popup_registry.hide_popup(tools_popup)
        end
        return false
    end)
end)

-- Tools widget (wrench icon)
M.tools_widget = wibox.widget.textbox()
M.tools_widget.font = m.font_icon
M.tools_widget.align = "center"
M.tools_widget.valign = "center"
M.tools_widget.forced_width = 24
M.tools_widget:set_markup_silently(m.glyph.tools)

-- Toggle popup on click
M.tools_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        if tools_popup.visible then
            popup_registry.hide_popup(tools_popup)
        else
            popup_registry.show_popup(tools_popup)
            local s = awful.screen.focused().geometry
            tools_popup.x = s.x + s.width - 220
            tools_popup.y = s.y + 30
        end
    end)
))

return M
