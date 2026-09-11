-- modules/tooltips.lua
-- Hover tooltips for the wibar action pills.
--
-- Uses the built-in awful.tooltip (positioned near the cursor and styled from
-- the theme's beautiful.tooltip_* tokens). Attached to the widgets themselves
-- so they work regardless of the surrounding pill container.

local m = require("modules")
local gears = m.gears
local awful = m.awful
local beautiful = m.beautiful

local M = {}

local attached = {}

local function tooltip_common(widget)
    return {
        objects = { widget },
        font = m.font_popup,
        bg = m.tooltip_bg,
        fg = m.tooltip_fg,
        border_width = 1,
        border_color = beautiful.tooltip_border_color,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
        margin_leftright = 8,
        margin_topbottom = 4,
        preferred_positions = { "bottom", "top" },
    }
end

local function attach(widget, text)
    if not widget then return nil end

    local args = tooltip_common(widget)
    args.text = text

    local tt = awful.tooltip(args)
    attached[#attached + 1] = tt
    return tt
end

-- Tooltip whose markup is produced by `fn` each time it is shown (e.g. a live
-- date). Same style/position as `attach`, so it stays consistent with the rest.
local function attach_dynamic(widget, fn)
    if not widget then return nil end

    local args = tooltip_common(widget)
    args.timer_function = fn
    args.timeout = 30

    local tt = awful.tooltip(args)
    attached[#attached + 1] = tt
    return tt
end

-- Provide the widgets from the modules that own them.
local widgets = require("modules.widgets")
local settings = require("modules.settings")
local tools = require("modules.tools")
local power = require("modules.power")

attach(tools.tools_widget, "Tools")
attach(settings.set_widget, "Settings")
attach(power.power_widget, "Power Menu")
attach(widgets.layout_widget, "Layout Settings")

-- Follow runtime theme switches.
awesome.connect_signal("theme::changed", function()
    for _, tt in ipairs(attached) do
        tt.backgroundbox.bg = m.tooltip_bg
        tt.backgroundbox.shape_border_color = beautiful.tooltip_border_color
        local wb = tt:get_wibox()
        if wb then wb.fg = m.tooltip_fg end
    end
end)

M.attach = attach
M.attach_dynamic = attach_dynamic

return M
