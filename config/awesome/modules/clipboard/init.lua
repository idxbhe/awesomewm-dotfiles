-- modules/clipboard/init.lua
-- Clipboard manager with history tracking

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Config
local MAX_ITEMS = 50
local POLL_INTERVAL = 0.5
local clipboard_file = gears.filesystem.get_cache_dir() .. "/clipboard.json"

-- State
local clipboard_history = {}
local last_clipboard = ""
local clipboard_popup = nil

-- =============================================================================
-- Persistence
-- =============================================================================

local function save_history()
    local f = io.open(clipboard_file, "w")
    if not f then return end
    f:write("[\n")
    for i, item in ipairs(clipboard_history) do
        f:write("  {")
        f:write(string.format('"text":%q', item.text))
        if item.pinned then
            f:write(string.format(',"pinned":%s', tostring(item.pinned)))
        end
        f:write("}")
        if i < #clipboard_history then
            f:write(",")
        end
        f:write("\n")
    end
    f:write("]\n")
    f:close()
end

local function load_history()
    clipboard_history = {}
    local f = io.open(clipboard_file, "r")
    if not f then return end

    local content = f:read("*a")
    f:close()

    -- Simple JSON parser for our format
    for item in content:gmatch("%b{}") do
        local text = item:match('"text":%s*"([^"]*)"')
        local pinned = item:match('"pinned":%s*(true)') == "true"
        if text then
            table.insert(clipboard_history, {
                text = text,
                pinned = pinned,
            })
        end
    end
end

-- =============================================================================
-- Clipboard Operations
-- =============================================================================

local function get_clipboard()
    awful.spawn.easy_async_with_shell("xclip -selection clipboard -o 2>/dev/null", function(output)
        local text = output:gsub("%s+$", "") -- trim trailing whitespace
        if text ~= last_clipboard and text ~= "" then
            last_clipboard = text

            -- Check if already exists
            local exists = false
            for i, item in ipairs(clipboard_history) do
                if item.text == text then
                    -- Move to front
                    if i > 1 then
                        local pinned = item.pinned
                        table.remove(clipboard_history, i)
                        table.insert(clipboard_history, 1, {text = text, pinned = pinned})
                        save_history()
                    end
                    exists = true
                    break
                end
            end

            if not exists then
                table.insert(clipboard_history, 1, {text = text, pinned = false})
                if #clipboard_history > MAX_ITEMS then
                    table.remove(clipboard_history)
                end
                save_history()
            end
        end
    end)
end

local function set_clipboard(text)
    awful.spawn.with_shell(string.format("echo %q | xclip -selection clipboard", text))
    last_clipboard = text
end

local function add_item(text, pinned)
    -- Check if exists
    for i, item in ipairs(clipboard_history) do
        if item.text == text then
            item.pinned = pinned
            if i > 1 then
                table.remove(clipboard_history, i)
                table.insert(clipboard_history, 1, item)
            end
            save_history()
            return
        end
    end

    table.insert(clipboard_history, 1, {text = text, pinned = pinned})
    if #clipboard_history > MAX_ITEMS then
        table.remove(clipboard_history)
    end
    save_history()
end

local function remove_item(index)
    table.remove(clipboard_history, index)
    save_history()
end

local function clear_all()
    clipboard_history = {}
    save_history()
end

-- =============================================================================
-- UI - Clipboard Popup
-- =============================================================================

local function create_clipboard_row(item, index)
    local text_preview = item.text
    if #text_preview > 50 then
        text_preview = text_preview:sub(1, 50) .. "..."
    end
    text_preview = text_preview:gsub("\n", "\\n")

    local markup = string.format(
        '<span font="%s">%s</span>',
        m.font_popup_regular, text_preview
    )

    -- Pin icon
    local pin_markup = item.pinned and
        string.format('<span font="icons 12" color="%s">%s</span>', m.blue_dark, m.glyph.pin) or
        string.format('<span font="icons 12" color="#6c7086">%s</span>', m.glyph.pin)

    local pin_btn = wibox.widget {
        markup = pin_markup,
        align = "center",
        valign = "center",
        forced_width = 20,
        forced_height = 20,
        widget = wibox.widget.textbox,
    }

    local pin_bg = wibox.widget {
        pin_btn,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    pin_bg:connect_signal("mouse::enter", function() pin_bg.bg = m.surface0 end)
    pin_bg:connect_signal("mouse::leave", function() pin_bg.bg = nil end)

    pin_bg:buttons(gears.table.join(
        awful.button({}, 1, function()
            add_item(item.text, not item.pinned)
            M.show_clipboard_popup()
        end)
    ))

    -- Delete icon
    local delete_icon = wibox.widget {
        markup = string.format('<span font="icons 12" color="%s">%s</span>', m.red_dark or "#a33b4e", m.glyph.btn_delete),
        align = "center",
        valign = "center",
        forced_width = 20,
        forced_height = 20,
        widget = wibox.widget.textbox,
    }

    local delete_bg = wibox.widget {
        delete_icon,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    delete_bg:connect_signal("mouse::enter", function() delete_bg.bg = m.surface0 end)
    delete_bg:connect_signal("mouse::leave", function() delete_bg.bg = nil end)

    delete_bg:buttons(gears.table.join(
        awful.button({}, 1, function()
            remove_item(index)
            M.show_clipboard_popup()
        end)
    ))

    -- Text row
    local text_tb = wibox.widget {
        markup = markup,
        align = "left",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local row = wibox.widget {
        text_tb,
        forced_height = 32,
        widget = wibox.container.background,
    }

    local row_bg = wibox.widget {
        row,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    row_bg:connect_signal("mouse::enter", function() row_bg.bg = m.surface0 end)
    row_bg:connect_signal("mouse::leave", function() row_bg.bg = nil end)

    row_bg:buttons(gears.table.join(
        awful.button({}, 1, function()
            set_clipboard(item.text)
            popup_registry.hide_popup(clipboard_popup)
        end)
    ))

    return row_bg, pin_bg, delete_bg
end

function M.show_clipboard_popup()
    -- Close tools popup if open
    if m.tools_popup then
        popup_registry.hide_popup(m.tools_popup)
    end

    -- If already open, just toggle off
    if clipboard_popup and clipboard_popup.visible then
        clipboard_popup.visible = false
        clipboard_popup = nil
        return
    end

    -- Back arrow
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
            popup_registry.hide_popup(clipboard_popup)
            local tools = require("modules.tools")
            popup_registry.show_popup(tools.tools_popup)
            local s = awful.screen.focused().geometry
            tools.tools_popup.x = s.x + s.width - 380
            tools.tools_popup.y = s.y + 30
        end)
    ))

    -- Clear all button
    local clear_icon = wibox.widget {
        markup = string.format('<span font="icons 14">%s</span>', m.glyph.btn_delete),
        align = "center",
        valign = "center",
        forced_width = 24,
        forced_height = 24,
        widget = wibox.widget.textbox,
    }

    local clear_btn = wibox.widget {
        clear_icon,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        forced_width = 24,
        forced_height = 24,
        widget = wibox.container.background,
    }

    clear_btn:connect_signal("mouse::enter", function() clear_btn.bg = m.red_dark or "#a33b4e" end)
    clear_btn:connect_signal("mouse::leave", function() clear_btn.bg = nil end)

    clear_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            clear_all()
            M.show_clipboard_popup()
        end)
    ))

    local title_widget = wibox.widget {
        {
            back_btn,
            forced_width = 24,
            widget = wibox.container.place,
        },
        {
            markup = string.format('<span font="%s">Clipboard</span>', m.font_popup),
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        {
            clear_btn,
            forced_width = 24,
            widget = wibox.container.place,
        },
        expand = "inside",
        layout = wibox.layout.align.horizontal,
    }

    -- Clipboard list
    local list_widget = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = 4,
    }

    if #clipboard_history == 0 then
        local empty = wibox.widget {
            markup = string.format('<span font="%s" color="#6c7086">No clipboard history</span>', m.font_popup_regular),
            align = "center",
            valign = "center",
            forced_height = 60,
            widget = wibox.widget.textbox,
        }
        list_widget:add(empty)
    else
        for i, item in ipairs(clipboard_history) do
            local row, pin_btn, delete_btn = create_clipboard_row(item, i)
            local row_with_buttons = wibox.widget {
                {
                    pin_btn,
                    left = 4,
                    right = 4,
                    widget = wibox.container.margin,
                },
                {
                    row,
                    forced_width = 200,
                    widget = wibox.container.place,
                },
                {
                    delete_btn,
                    right = 4,
                    widget = wibox.container.margin,
                },
                expand = "none",
                layout = wibox.layout.align.horizontal,
                forced_height = 32,
            }
            list_widget:add(row_with_buttons)
        end
    end

    local content = wibox.widget {
        title_widget,
        list_widget,
        spacing = 8,
        layout = wibox.layout.fixed.vertical,
    }

    local container = wibox.widget {
        content,
        margins = 12,
        widget = wibox.container.margin,
    }

    clipboard_popup = awful.popup {
        widget = container,
        bg = "#1e1e2eee",
        border_width = 1,
        border_color = "#313244",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
        minimum_width = 280,
        maximum_width = 280,
        ontop = true,
        visible = false,
    }
    clipboard_popup.ontop = true

    popup_registry.show_child_popup(clipboard_popup)

    local s = awful.screen.focused().geometry
    clipboard_popup.x = s.x + s.width - 380
    clipboard_popup.y = s.y + 30
end

-- =============================================================================
-- Initialization
-- =============================================================================

load_history()

-- Start polling timer
gears.timer({
    timeout = POLL_INTERVAL,
    call_now = true,
    autostart = true,
    callback = get_clipboard,
})

return M
