-- modules/tools.lua
-- Tools popup: list of utility tools with icons
-- Also exposes standalone functions for keyboard shortcuts

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")
local alarm = require("modules.alarm")
local clipboard = require("modules.clipboard")

local M = {}

-- =============================================================================
-- Screenshot setup
-- =============================================================================
local screenshot_dir = os.getenv("HOME") .. "/Pictures/Screenshots"
awful.spawn.with_shell("mkdir -p '" .. screenshot_dir .. "'")

local function screenshot_filename()
    return screenshot_dir .. "/screenshot-" .. os.date("%Y%m%d-%H%M%S") .. ".png"
end

local function notify_saved(filename)
    m.naughty.notify({
        title = "Screenshot Saved",
        text = filename,
        timeout = 4,
    })
end

-- The screenshot popup reference (for toggle / keyboard shortcut)
local screenshot_popup = nil

-- Helper: create one clickable option row for screenshot popup
local function make_screenshot_option(icon, label, callback)
    local icon_tb = wibox.widget {
        markup = string.format('<span font="%s">%s</span>', m.font_icon, icon),
        align = "center",
        valign = "center",
        forced_width = 24,
        forced_height = 32,
        widget = wibox.widget.textbox,
    }

    local label_tb = wibox.widget {
        markup = string.format('<span font="%s">%s</span>', m.font_popup, label),
        align = "left",
        valign = "center",
        forced_height = 32,
        widget = wibox.widget.textbox,
    }

    local row = wibox.widget {
        icon_tb,
        {
            label_tb,
            left = 8,
            widget = wibox.container.margin,
        },
        nil,
        expand = "inside",
        layout = wibox.layout.align.horizontal,
        forced_height = 32,
    }

    local bg = wibox.widget {
        {
            row,
            left = 16,
            right = 8,
            widget = wibox.container.margin,
        },
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 4)
        end,
        widget = wibox.container.background,
    }

    bg:connect_signal("mouse::enter", function() bg.bg = m.surface0 or "#313244" end)
    bg:connect_signal("mouse::leave", function() bg.bg = "#00000000" end)

    bg:buttons(gears.table.join(
        awful.button({}, 1, function()
            if callback then callback() end
        end)
    ))

    return bg
end

-- Take screenshot after a short delay (let popup close first)
local function take_screenshot(cmd)
    local filename = screenshot_filename()
    -- Hide popup immediately
    if screenshot_popup then
        screenshot_popup.visible = false
        screenshot_popup = nil
    end
    -- Small delay so popup is gone before capture
    gears.timer.start_new(0.15, function()
        awful.spawn.easy_async_with_shell(cmd .. " '" .. filename .. "'", function(_, _, _, exit_code)
            if exit_code == 0 then
                notify_saved(filename)
            end
        end)
        return false
    end)
end

-- =============================================================================
-- Public: show_screenshot_menu()
-- Called from tools popup AND keyboard shortcut
-- =============================================================================
function M.show_screenshot_menu()
    -- Close tools popup if open
    if M.tools_popup then
        popup_registry.hide_popup(M.tools_popup)
    end

    -- If already open, just toggle off
    if screenshot_popup and screenshot_popup.visible then
        screenshot_popup.visible = false
        screenshot_popup = nil
        return
    end

    -- Back arrow (returns to tools popup)
    local back_icon = wibox.widget {
        text = "<-",
        font = m.font_popup,
        align = "center",
        valign = "center",
        forced_width = 24,
        forced_height = 24,
        widget = wibox.widget.textbox,
    }

    local back_btn = wibox.widget {
        back_icon,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    back_btn:connect_signal("mouse::enter", function() back_btn.bg = m.surface0 end)
    back_btn:connect_signal("mouse::leave", function() back_btn.bg = nil end)

    back_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            popup_registry.hide_popup(screenshot_popup)
            local tools = require("modules.tools")
            popup_registry.show_popup(tools.tools_popup)
            local s = awful.screen.focused().geometry
            tools.tools_popup.x = s.x + s.width - 380
            tools.tools_popup.y = s.y + 30
        end)
    ))

    local title_widget = wibox.widget {
        {
            back_btn,
            forced_width = 24,
            widget = wibox.container.place,
        },
        {
            markup = '<b><span font="' .. m.font_popup .. '">Screenshot</span></b>',
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        {
            forced_width = 24,
            widget = wibox.widget.textbox,
        },
        expand = "inside",
        layout = wibox.layout.align.horizontal,
    }

    local content = wibox.widget {
        title_widget,
        make_screenshot_option(
            "",  -- nf-md-monitor_screenshot (full)
            "Full Screen",
            function() take_screenshot("maim") end
        ),
        make_screenshot_option(
            "",  -- nf-md-crop (selection)
            "Selection",
            function() take_screenshot("maim -s") end
        ),
        make_screenshot_option(
            "",  -- nf-md-application (window)
            "Window",
            function() take_screenshot("maim -i") end
        ),
        spacing = 8,
        layout = wibox.layout.fixed.vertical,
    }

    local container = wibox.widget {
        content,
        margins = 12,
        widget = wibox.container.margin,
    }

    screenshot_popup = awful.popup {
        widget = container,
        bg = "#1e1e2eee",
        border_width = 1,
        border_color = "#313244",
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 6)
        end,
        minimum_width = 280,
        maximum_width = 280,
        ontop = true,
        visible = false,
    }
    screenshot_popup.ontop = true

    -- Register with popup registry
    popup_registry.show_child_popup(screenshot_popup)

    -- Position same as tools popup
    local s = awful.screen.focused().geometry
    screenshot_popup.x = s.x + s.width - 380
    screenshot_popup.y = s.y + 30
end

-- =============================================================================
-- Tools popup - list of available tools
-- =============================================================================
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

-- Track selected row

local function make_tool_row(icon, label, callback)
    -- Icon widget centered vertically
    local icon_tb = wibox.widget {
        markup = icon,
        font = m.font_icon,
        align = "center",
        valign = "center",
        forced_width = 24,
        forced_height = 32,
        widget = wibox.widget.textbox,
    }

    local icon_container = wibox.widget {
        nil,
        icon_tb,
        expand = "none",
        layout = wibox.layout.align.vertical,
        forced_width = 24,
        forced_height = 32,
    }

    -- Label widget centered vertically
    local label_tb = wibox.widget {
        markup = label,
        font = m.font_popup,
        align = "left",
        valign = "center",
        forced_height = 32,
        widget = wibox.widget.textbox,
    }

    local label_container = wibox.widget {
        nil,
        label_tb,
        expand = "none",
        layout = wibox.layout.align.vertical,
        forced_height = 32,
    }

    local layout = wibox.widget {
        icon_container,
        {
            label_container,
            left = 8,
            widget = wibox.container.margin,
        },
        nil,
        expand = "inside",
        layout = wibox.layout.align.horizontal,
        forced_width = 200,
        forced_height = 32,
    }

    -- Wrap in background container to enable .bg property
    local row = wibox.widget {
        {
            layout,
            left = 8,
            widget = wibox.container.margin,
        },
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 2)
        end,
        widget = wibox.container.background,
    }

    -- Selection highlight functions
    local function apply_hover()
        row.bg = m.surface0
    end

    local function apply_normal()
        row.bg = "#00000000"
    end

    row:connect_signal("mouse::enter", function()
        apply_hover()
    end)

    row:connect_signal("mouse::leave", function()
        apply_normal()
    end)

    row:buttons(gears.table.join(
        awful.button({}, 1, function()
            if callback then callback() end
        end)
    ))

    return row
end

-- Tools list
local tools_list = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 4,
}

-- Screenshot icon
local screenshot_icon = m.glyph.tools_ss

-- Alarm icon
local alarm_icon = m.glyph.alarm

-- Clipboard icon
local clipboard_icon = m.glyph.clipboard

tools_list:add(make_tool_row(
    screenshot_icon,
    "Screenshot",
    function() M.show_screenshot_menu() end
))

tools_list:add(make_tool_row(
    alarm_icon,
    "Alarm",
    function() alarm.show_alarm_list() end
))

tools_list:add(make_tool_row(
    clipboard_icon,
    "Clipboard",
    function() clipboard.show_clipboard_popup() end
))

-- Tools popup
M.tools_popup = awful.popup {
    widget = {
        {
            tools_list,
            margins = 12,
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical,
    },
    minimum_width = 280,
    maximum_width = 280,
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
local tools_popup_hide_timer = gears.timer {
    timeout = 0.3,
    single_shot = true,
    callback = function()
        local coords = mouse.coords()
        local geo = M.tools_popup:geometry()
        if coords.x < geo.x or coords.x > geo.x + geo.width or
           coords.y < geo.y or coords.y > geo.y + geo.height then
            popup_registry.hide_popup(M.tools_popup)
        end
    end,
}

M.tools_popup:connect_signal("mouse::leave", function()
    if not popup_registry.should_auto_hide() then return end

    -- Jangan close jika child popup baru saja ditutup via widget click
    if popup_registry._child_popup_just_closed then
        return
    end

    tools_popup_hide_timer:again()
end)

-- Tools widget (wrench icon)
M.tools_widget = wibox.widget.textbox()
M.tools_widget.font = m.font_icon
M.tools_widget.align = "center"
M.tools_widget.valign = "center"
M.tools_widget.forced_width = 24
M.tools_widget:set_markup_silently(m.glyph.tools)

M.tools_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        -- Jika tools popup terbuka, tutup
        if M.tools_popup.visible then
            popup_registry.hide_popup(M.tools_popup)
            return
        end

        -- Jika child popup terbuka (alarm, screenshot, dll), tutup saja tanpa buka tools parent
        if popup_registry.has_child_popup() then
            popup_registry.hide_active(true) -- true = mark as just closed
            return
        end

        -- Jika tidak ada yang terbuka, buka tools popup
        popup_registry.show_popup(M.tools_popup)
        local s = awful.screen.focused().geometry
        M.tools_popup.x = s.x + s.width - 380
        M.tools_popup.y = s.y + 30
    end)
))

return M
