-- modules/tools.lua
-- Tools popup: list of utility tools with icons
-- Also exposes standalone functions for keyboard shortcuts

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

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
    local markup = string.format(
        '<span font="%s">%s</span>  <span font="%s">%s</span>',
        m.font_icon, icon, m.font_popup, label
    )

    local row = wibox.widget {
        {
            markup = markup,
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        widget = wibox.container.place,
        halign = "center",
        valign = "center",
        forced_width = 200,
        forced_height = 32,
    }

    row:connect_signal("mouse::enter", function() row.bg = "#313244" end)
    row:connect_signal("mouse::leave", function() row.bg = "#00000000" end)

    row:buttons(gears.table.join(
        awful.button({}, 1, function()
            if callback then callback() end
        end)
    ))

    return row
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

    local screen = awful.screen.focused()
    local geo = screen.geometry
    local popup_w = 220
    local popup_h = 150

    screenshot_popup = awful.popup {
        widget = {
            {
                {
                    markup = '<b><span font="' .. m.font_popup .. '">Screenshot</span></b>',
                    align = "center",
                    valign = "center",
                    forced_height = 28,
                    widget = wibox.widget.textbox,
                },
                make_screenshot_option(
                    "󰥑",  -- nf-md-monitor_screenshot (full)
                    "Full Screen",
                    function() take_screenshot("maim") end
                ),
                make_screenshot_option(
                    "󰼔",  -- nf-md-crop (selection)
                    "Selection",
                    function() take_screenshot("maim -s") end
                ),
                make_screenshot_option(
                    "󰃗",  -- nf-md-application (window)
                    "Window",
                    function() take_screenshot("maim -i") end
                ),
                spacing = 4,
                layout = wibox.layout.fixed.vertical,
            },
            margins = 12,
            widget = wibox.container.margin,
        },
        bg = "#1e1e2eee",
        border_width = 1,
        border_color = "#313244",
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, 6)
        end,
        ontop = true,
        visible = true,
        x = geo.x + (geo.width - popup_w) / 2,
        y = geo.y + (geo.height - popup_h) / 2,
        minimum_width = popup_w,
        maximum_width = popup_w,
    }

    -- Register with popup registry
    popup_registry.show_popup(screenshot_popup)

    -- Auto-hide on mouse leave
    screenshot_popup:connect_signal("mouse::leave", function()
        gears.timer.start_new(0.5, function()
            local coords = mouse.coords()
            local pgeo = screenshot_popup:geometry()
            if coords.x < pgeo.x or coords.x > pgeo.x + pgeo.width or
               coords.y < pgeo.y or coords.y > pgeo.y + pgeo.height then
                screenshot_popup.visible = false
                screenshot_popup = nil
            end
            return false
        end)
    end)
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

local function make_tool_row(icon, label, callback)
    local row = wibox.widget {
        {
            markup = string.format('<span font="%s">%s</span>  %s', m.font_icon, icon, label),
            font = m.font_popup,
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        widget = wibox.container.place,
        halign = "center",
        valign = "center",
        forced_width = 200,
        forced_height = 32,
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

-- Tools list
local tools_list = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 4,
}

-- Screenshot icon (camera)
local screenshot_icon = "󰵝"  -- U+F0D5D fa-camera

tools_list:add(make_tool_row(
    screenshot_icon,
    "Screenshot",
    function() M.show_screenshot_menu() end
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
M.tools_popup:connect_signal("mouse::leave", function()
    if not popup_registry.should_auto_hide() then return end
    gears.timer.start_new(0.5, function()
        local coords = mouse.coords()
        local geo = M.tools_popup:geometry()
        if coords.x < geo.x or coords.x > geo.x + geo.width or
           coords.y < geo.y or coords.y > geo.y + geo.height then
            popup_registry.hide_popup(M.tools_popup)
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

M.tools_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        if M.tools_popup.visible then
            popup_registry.hide_popup(M.tools_popup)
        else
            popup_registry.show_popup(M.tools_popup)
            local s = awful.screen.focused().geometry
            M.tools_popup.x = s.x + s.width - 220
            M.tools_popup.y = s.y + 30
        end
    end)
))

return M
