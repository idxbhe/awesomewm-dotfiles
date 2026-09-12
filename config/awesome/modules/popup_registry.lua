-- modules/popup_registry.lua
-- Popup/Tooltip Management System
-- Ensures only one popup/tooltip is visible at a time (password popup is exception)

local gears = require("gears")
local matrix = require("gears.matrix")
local awful = require("awful")

local M = {
    active_popup = nil,
    active_tooltip = nil,
    password_popup = nil,
    active_priority_popup = nil,
    child_popups = {},
    DEBUG_MODE = false,
    _child_popup_just_closed = false,
}

local function hide_active_tooltip()
    if M.active_tooltip and M.active_tooltip.visible then
        M.active_tooltip.visible = false
        M.active_tooltip = nil
    end
end

local function hide_active_popup()
    if M.active_popup and M.active_popup.visible then
        M.active_popup.visible = false
        M.active_popup = nil
    end
end

local function hide_all_child_popups()
    for _, popup in ipairs(M.child_popups) do
        if popup.visible then
            popup.visible = false
        end
    end
end

function M.show_popup(popup, is_password)
    -- Block if priority popup is active
    if M.active_priority_popup and M.active_priority_popup.visible then
        return false
    end

    if is_password then
        -- Password popup is special, doesn't interfere with others
        M.password_popup = popup
        popup.visible = true
        return true
    end

    -- In debug mode, allow multiple popups
    if not M.DEBUG_MODE then
        -- Regular popup: hide tooltip and other popups
        hide_active_tooltip()
        hide_active_popup()
        M.active_popup = popup
    end

    popup.visible = true
    return true
end

function M.show_child_popup(popup)
    -- Show a child popup (belongs to a parent like tools)
    -- Child popups are tracked separately but still close on click outside

    if M.active_priority_popup and M.active_priority_popup.visible then
        return false
    end

    if not M.DEBUG_MODE then
        hide_active_tooltip()
        hide_active_popup()
        hide_all_child_popups()
    end

    M.active_popup = popup
    popup.visible = true
    return true
end

function M.has_child_popup()
    -- Check if any child popup is visible
    if M.active_popup and M.active_popup.visible then
        return true
    end
    return false
end

function M.hide_popup(popup, is_password)
    if is_password then
        if M.password_popup == popup then
            M.password_popup = nil
        end
    else
        if M.active_popup == popup then
            M.active_popup = nil
        end
    end
    popup.visible = false
end

function M.hide_active(mark_as_just_closed)
    local had_active = M.active_popup ~= nil
    hide_active_popup()

    -- Mark that child popup was just closed (used to prevent parent from opening)
    if mark_as_just_closed and had_active then
        M._child_popup_just_closed = true
        M._last_close_time = os.clock()
        gears.timer.start_new(0.15, function()
            M._child_popup_just_closed = false
        end)
    end

    return had_active
end

-- Check if mouse is under a widget
function M.is_under_mouse(widget)
    if not widget or not widget.visible then return false end

    local geo = widget:geometry()
    local coords = mouse.coords()

    return coords.x >= geo.x and coords.x <= geo.x + geo.width and
           coords.y >= geo.y and coords.y <= geo.y + geo.height
end

-- Global click handler: auto-dismiss popups on click outside
function M.setup_global_click_handler()
    M._child_popup_just_closed = false
    M._last_close_time = 0

    -- Listen for button press on clients (catches clicks on windows)
    client.connect_signal("button::press", function()
        -- Ignore if child popup was just closed (prevents re-opening parent)
        if M._child_popup_just_closed then
            return
        end

        -- Skip if priority popup is active (they have their own dismiss logic)
        if M.is_priority_popup_active() then return end

        -- Skip if no active popup
        if not M.active_popup or not M.active_popup.visible then return end

        -- Use mouse coords directly for accurate global position
        local mx, my = mouse.coords().x, mouse.coords().y
        local pgeo = M.active_popup:geometry()
        if not pgeo then return end

        local is_inside = mx >= pgeo.x and mx <= pgeo.x + pgeo.width and
                         my >= pgeo.y and my <= pgeo.y + pgeo.height
        if not is_inside then
            M.active_popup.visible = false
            M.active_popup = nil
        end
    end)
end

-- Mark that child popup was just closed (used by tools widget)
function M.mark_child_closed()
    M._child_popup_just_closed = true
    M._last_close_time = os.clock()

    -- Reset flag after short delay
    gears.timer.start_new(0.15, function()
        M._child_popup_just_closed = false
    end)
end

function M.show_priority_popup(popup)
    -- Close all other popups
    hide_active_tooltip()
    hide_active_popup()

    -- Set as priority popup
    M.active_priority_popup = popup
    popup.visible = true

    return true
end

function M.hide_priority_popup(popup)
    if M.active_priority_popup == popup then
        M.active_priority_popup = nil
        popup.visible = false
    end
end

function M.is_priority_popup_active()
    return M.active_priority_popup ~= nil and M.active_priority_popup.visible
end

function M.show_tooltip(popup)
    -- Block if priority popup is active
    if M.active_priority_popup and M.active_priority_popup.visible then
        return false
    end

    -- In debug mode, don't block tooltips
    if not M.DEBUG_MODE then
        -- Tooltip: don't show if there's already a popup active
        if M.active_popup then
            return false
        end
        hide_active_tooltip()
        M.active_tooltip = popup
    end
    popup.visible = true
    return true
end

function M.hide_tooltip(popup)
    if M.active_tooltip == popup then
        M.active_tooltip = nil
    end
    popup.visible = false
end

-- Helper for modules to check if auto-hide should be enabled
-- Disabled: popups now only close on click outside, not on mouse leave
function M.should_auto_hide()
    return false
end

-- Get geometry of a widget inside a screen's wibox
function M.get_widget_geometry(target_widget, target_screen)
    if not target_widget then return nil end
    target_screen = target_screen or awful.screen.focused()
    local wb = target_screen and target_screen.mywibox
    if not wb or not wb._drawable or not wb._drawable._widget_hierarchy then
        return nil
    end

    local function search_hierarchy(h)
        if not h then return nil end
        if h:get_widget() == target_widget then
            local width, height = h:get_size()
            local m = h:get_matrix_to_device()
            local x, y, w, h_dim = matrix.transform_rectangle(m, 0, 0, width, height)
            return { x = x, y = y, width = w, height = h_dim }
        end
        for _, child in ipairs(h:get_children()) do
            local found = search_hierarchy(child)
            if found then return found end
        end
        return nil
    end

    local local_geo = search_hierarchy(wb._drawable._widget_hierarchy)
    if not local_geo then return nil end

    local wb_geo = wb:geometry()
    return {
        x = wb_geo.x + local_geo.x,
        y = wb_geo.y + local_geo.y,
        width = local_geo.width,
        height = local_geo.height,
        wibox_x = wb_geo.x,
        wibox_y = wb_geo.y,
        wibox_width = wb_geo.width,
        wibox_height = wb_geo.height,
        screen = target_screen,
    }
end

-- Anchor a popup relative to a widget on the wibar
function M.anchor_to_widget(popup, target_widget, options)
    if not popup then return end
    options = options or {}
    local gap = options.gap or 4
    local screen_margin = options.screen_margin or 8
    local align = options.align or "center"
    local s = awful.screen.focused()
    local s_geo = s.geometry

    if popup._apply_size_now then
        popup:_apply_size_now(false)
    end
    local popup_w = popup.width or popup.minimum_width or 280

    local geo = target_widget and M.get_widget_geometry(target_widget, s)
    local wibar_h = (s.mywibox and s.mywibox.height) or 26
    local wibar_y = (s.mywibox and s.mywibox.y) or s_geo.y

    if geo then
        popup.y = geo.wibox_y + geo.wibox_height + gap
        local target_x
        if align == "right" then
            target_x = geo.x + geo.width - popup_w
        elseif align == "left" then
            target_x = geo.x
        else
            target_x = math.floor(geo.x + (geo.width / 2) - (popup_w / 2))
        end
        popup.x = math.max(s_geo.x + screen_margin, math.min(target_x, s_geo.x + s_geo.width - popup_w - screen_margin))
    else
        popup.y = wibar_y + wibar_h + gap
        popup.x = math.max(s_geo.x + screen_margin, s_geo.x + s_geo.width - popup_w - screen_margin)
    end
end

return M
