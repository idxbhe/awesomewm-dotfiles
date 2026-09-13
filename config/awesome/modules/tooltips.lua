-- modules/tooltips.lua
-- Hover tooltips for the wibar action pills.
--
-- Uses the built-in awful.tooltip (positioned near the cursor and styled from
-- the theme's beautiful.tooltip_* tokens). Attached to the widgets themselves
-- so they work regardless of the surrounding pill container.
--
-- Tooltips are suppressed while a popup is open: awful.tooltip wires
-- mouse::enter straight to tt.show, so the show handler is re-wired with a
-- popup-state gate, and any visible tooltip is force-hidden when a popup opens.

local m = require("modules")
local gears = m.gears
local awful = m.awful
local beautiful = m.beautiful
local popup_registry = require("modules.popup_registry")

local M = {}

local attached = {}

local function popup_open()
    return popup_registry.is_any_popup_open()
end

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

-- Swap the auto-connected hover handler for a gated one: refuse to show
-- while a popup is open.
local function gate_tooltip(tt, widget)
    if not widget then return tt end

    tt:remove_from_object(widget)
    local orig_show = tt.show
    tt.show = function(other, geo)
        if popup_open() then return end
        orig_show(other, geo)
    end
    tt:add_to_object(widget)

    return tt
end

local function attach(widget, text)
    if not widget then return nil end

    local args = tooltip_common(widget)
    args.text = text

    local tt = awful.tooltip(args)
    gate_tooltip(tt, widget)
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
    gate_tooltip(tt, widget)
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

-- When a popup opens, hide any tooltip that is already visible (e.g. the
-- tooltip of the widget that was just clicked).
awesome.connect_signal("popup::changed", function()
    if popup_open() then
        for _, tt in ipairs(attached) do
            tt.visible = false
        end
    end
end)

M.attach = attach
M.attach_dynamic = attach_dynamic

return M
