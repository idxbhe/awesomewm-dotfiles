-- modules/layout_menu.lua
-- Layout mode popup for the wibar layout pill.
--
-- Lists the layouts configured in `awful.layout.layouts` and applies the
-- selected one to the focused tag. Setting `tag.layout` emits
-- `property::layout`, which modules/layout_manager picks up to perform the
-- hard mode switch (un-maximize, un-fullscreen, restore/cascade floating).

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")
local widgets = require("modules.widgets")

local M = {}

local POPUP_WIDTH = 220
local ROW_HEIGHT = 32

-- Fallback pretty names for layouts not in the map.
local display_names = {
    tile          = "Tile",
    tilebottom    = "Tile Bottom",
    tiletop       = "Tile Top",
    tileleft      = "Tile Left",
    fair          = "Fair",
    fairh         = "Fair (Horizontal)",
    fairv         = "Fair (Vertical)",
    max           = "Max",
    fullscreen    = "Fullscreen",
    floating      = "Floating",
    magnifier     = "Magnifier",
    spiral        = "Spiral",
    corner        = "Corner",
}

local function layout_name(layout)
    return (layout and layout.name) or "floating"
end

local function glyph_for(layout)
    local name = layout_name(layout)
    return m.glyph[name] or m.glyph["wm_" .. name] or m.glyph.layout or m.glyph.wm_floating
end

local function display_name(layout)
    local name = layout_name(layout)
    return display_names[name] or (name:gsub("^%l", string.upper))
end

-- Row refs: { bg = <container>, indicator = <textbox>, layout = <layout> }
local rows = {}
local rows_built = false

local rows_layout = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 2,
}

local function current_layout()
    local s = awful.screen.focused()
    local t = s and s.selected_tag
    return t and t.layout or nil
end

local function is_current(row, cur)
    if not cur or not row.layout then return false end
    return row.layout == cur or layout_name(row.layout) == layout_name(cur)
end

-- Re-render every row's background + check indicator for the focused tag.
local function update_highlight()
    local cur = current_layout()
    for _, row in ipairs(rows) do
        local active = is_current(row, cur)
        row.bg.bg = active and (m.surface0 or "#313244") or "#00000000"
        row.indicator.markup = active
            and ('<span foreground="' .. (m.blue or "#89b4fa") .. '">●</span>')
            or " "
    end
end

local function make_row(layout)
    local icon = wibox.widget {
        markup = string.format('<span font="%s">%s</span>', m.font_icon, glyph_for(layout)),
        align = "center",
        valign = "center",
        forced_width = 24,
        widget = wibox.widget.textbox,
    }

    local label = wibox.widget {
        markup = string.format('<span font="%s">%s</span>', m.font_popup, display_name(layout)),
        align = "left",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local left = wibox.widget {
        icon,
        {
            label,
            left = 10,
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
    }

    local indicator = wibox.widget {
        markup = " ",
        font = m.font_icon,
        align = "center",
        valign = "center",
        forced_width = 16,
        widget = wibox.widget.textbox,
    }

    local row = wibox.widget {
        left,
        nil,
        indicator,
        layout = wibox.layout.align.horizontal,
        forced_height = ROW_HEIGHT,
    }

    local bg = wibox.widget {
        {
            row,
            left = 10,
            right = 10,
            widget = wibox.container.margin,
        },
        bg = "#00000000",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    local ref = { bg = bg, indicator = indicator, layout = layout }

    bg:connect_signal("mouse::enter", function()
        if not is_current(ref, current_layout()) then
            bg.bg = m.surface1 or "#45475a"
        end
    end)
    bg:connect_signal("mouse::leave", update_highlight)

    bg:buttons(gears.table.join(
        awful.button({}, 1, function()
            local s = awful.screen.focused()
            local t = s and s.selected_tag
            if t then t.layout = layout end
            if M.popup then popup_registry.hide_popup(M.popup) end
        end)
    ))

    return ref
end

local function build_rows()
    if rows_built then return end
    rows_built = true
    for _, layout in ipairs(awful.layout.layouts or {}) do
        local ref = make_row(layout)
        rows[#rows + 1] = ref
        rows_layout:add(ref.bg)
    end
end

-- Layout popup
M.popup = awful.popup {
    widget = {
        rows_layout,
        margins = 10,
        widget = wibox.container.margin,
    },
    minimum_width = POPUP_WIDTH,
    maximum_width = POPUP_WIDTH,
    bg = m.bg_alt or "#1e1e2eee",
    border_width = 1,
    border_color = m.border or "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
    ontop = true,
    visible = false,
}

local function show_menu()
    build_rows()
    update_highlight()

    popup_registry.anchor_to_widget(M.popup, widgets.layout_widget)
    popup_registry.show_popup(M.popup)
end

function M.toggle()
    if M.popup.visible then
        popup_registry.hide_popup(M.popup)
    else
        show_menu()
    end
end

-- Clicking the layout pill toggles the popup.
widgets.layout_widget:buttons(gears.table.join(
    awful.button({}, 1, function() M.toggle() end)
))

-- Keep the check mark in sync while visible.
tag.connect_signal("property::layout", function()
    if M.popup.visible then update_highlight() end
end)
tag.connect_signal("property::selected", function()
    if M.popup.visible then update_highlight() end
end)

-- Follow theme changes.
awesome.connect_signal("theme::changed", function()
    M.popup.bg = m.bg_alt or "#1e1e2eee"
    M.popup.border_color = m.border or "#313244"
    if M.popup.visible then update_highlight() end
end)

return M
