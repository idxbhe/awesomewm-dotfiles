-- modules/popup_registry.lua
-- Popup/Tooltip Management System
-- Ensures only one popup/tooltip is visible at a time (password popup is exception)

local M = {
    active_popup = nil,
    active_tooltip = nil,
    password_popup = nil,
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

function M.show_popup(popup, is_password)
    if is_password then
        -- Password popup is special, doesn't interfere with others
        M.password_popup = popup
        popup.visible = true
        return
    end
    -- Regular popup: hide tooltip and other popups
    hide_active_tooltip()
    hide_active_popup()
    M.active_popup = popup
    popup.visible = true
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

function M.show_tooltip(popup)
    -- Tooltip: don't show if there's already a popup active
    if M.active_popup then
        return
    end
    hide_active_tooltip()
    M.active_tooltip = popup
    popup.visible = true
end

function M.hide_tooltip(popup)
    if M.active_tooltip == popup then
        M.active_tooltip = nil
    end
    popup.visible = false
end

return M
