-- modules/init.lua
-- Shared requires, constants, and utility functions

-- Standard awesome libraries
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Load theme
beautiful.init("/home/bhe/dotfiles/config/awesome/theme.lua")
assert(beautiful.glyph, "Failed to load theme glyphs from /home/bhe/dotfiles/config/awesome/theme.lua")

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
    
    -- Theme values
    glyph = beautiful.glyph,
    pill_bg = beautiful.pill_bg,
    pill_fg = beautiful.pill_fg,
    pill_padding = beautiful.pill_padding,
    pill_spacing = beautiful.pill_spacing,
    border_radius = beautiful.border_radius,
    useless_gap = beautiful.useless_gap,
    wibar_height = beautiful.wibar_height,
    wibar_bg = beautiful.wibar_bg,
    tooltip_bg = beautiful.tooltip_bg,
    tooltip_fg = beautiful.tooltip_fg,
    overlay0 = beautiful.overlay0,
    surface0 = beautiful.surface0,
    blue = beautiful.blue,
    
    -- Font sizes
    font = "Maple Mono NF Bold 10",
    font_icon = "icons 13",
    font_popup = "Maple Mono NF Bold 11",
    font_popup_regular = "Maple Mono NF 11",
    
    -- Settings
    terminal = "kitty",
    editor = os.getenv("EDITOR") or "nano",
    modkey = "Mod4",
}

-- Icon helper function (uses custom "icons" font)
M.icon = function(t)
    return string.format('<span font="icons 13">%s</span>', t)
end

-- Editor command
M.editor_cmd = M.terminal .. " -e " .. M.editor

return M
