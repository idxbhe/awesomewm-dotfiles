-- modules/init.lua
-- Shared requires, constants, and utility functions

-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
require("awful.titlebar")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Load theme manager (initializes theme system)
local theme_manager = require("themes.init")
theme_manager.init()

-- Export module table
local M = {
    -- Libraries
    gears = gears,
    awful = awful,
    wibox = wibox,
    beautiful = beautiful,
    naughty = naughty,
    menubar = menubar,
    hotkeys_popup = hotkeys_popup,

    -- Theme manager
    theme = theme_manager,

    -- Theme values (updated on theme::changed)
    glyph = beautiful.glyph,
    pill_bg = beautiful.pill_bg,
    pill_fg = beautiful.pill_fg,
    pill_padding = beautiful.pill_padding,
    pill_spacing = beautiful.pill_spacing,
    pill_radius = beautiful.pill_radius,
    border_radius = beautiful.border_radius,
    useless_gap = beautiful.useless_gap,
    wibar_height = beautiful.wibar_height,
    wibar_bg = beautiful.wibar_bg,
    tooltip_bg = beautiful.tooltip_bg,
    tooltip_fg = beautiful.tooltip_fg,
    overlay0 = beautiful.overlay0,
    surface0 = beautiful.surface0,
    blue = beautiful.blue,
    blue_dark = beautiful.blue_dark,
    green_dark = beautiful.green_dark,
    red_dark = beautiful.red_dark,

    -- Font sizes
    font = "Maple Mono NF Bold 10",
    font_icon = "icons 12",
    font_popup = "Maple Mono NF Bold 11",
    font_popup_regular = "Maple Mono NF 11",

    -- Settings
    terminal = "alacritty",
    editor = os.getenv("EDITOR") or "nano",
    modkey = "Mod4",
}

-- Update theme values when theme changes
awesome.connect_signal("theme::changed", function()
    M.glyph = beautiful.glyph
    M.pill_bg = beautiful.pill_bg
    M.pill_fg = beautiful.pill_fg
    M.pill_padding = beautiful.pill_padding
    M.pill_spacing = beautiful.pill_spacing
    M.pill_radius = beautiful.pill_radius
    M.border_radius = beautiful.border_radius
    M.useless_gap = beautiful.useless_gap
    M.wibar_height = beautiful.wibar_height
    M.wibar_bg = beautiful.wibar_bg
    M.tooltip_bg = beautiful.tooltip_bg
    M.tooltip_fg = beautiful.tooltip_fg
    M.overlay0 = beautiful.overlay0
    M.surface0 = beautiful.surface0
    M.blue = beautiful.blue
    M.blue_dark = beautiful.blue_dark
    M.green_dark = beautiful.green_dark
    M.red_dark = beautiful.red_dark
end)

-- Icon helper function (uses custom "icons" font)
M.icon = function(t)
    return string.format('<span font="icons 12">%s</span>', t)
end

-- Editor command
M.editor_cmd = M.terminal .. " -e " .. M.editor

return M
