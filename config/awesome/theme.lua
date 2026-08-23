-- Catppuccin Mocha theme for AwesomeWM
local gears = require("gears")
local theme = {}

-- Catppuccin Mocha palette
local mocha = {
    rosewater = "#f5e0dc",
    flamingo  = "#f2cdcd",
    pink      = "#f5c2e7",
    mauve     = "#cba6f7",
    red       = "#f38ba8",
    maroon    = "#eba0ac",
    peach     = "#fab387",
    yellow    = "#f9e2af",
    green     = "#a6e3a1",
    teal      = "#94e2d5",
    sky       = "#89dceb",
    sapphire  = "#74c7ec",
    blue      = "#89b4fa",
    lavender  = "#b4befe",
    text      = "#cdd6f4",
    subtext1  = "#bac2de",
    subtext0  = "#a6adc8",
    overlay2  = "#9399b2",
    overlay1  = "#7f849c",
    overlay0  = "#6c7086",
    surface2  = "#585b70",
    surface1  = "#45475a",
    surface0  = "#313244",
    base      = "#1e1e2e",
    mantle    = "#181825",
    crust     = "#11111b",
}

-- Font
theme.font          = "JetBrainsMono Nerd Font 9"
theme.font_bold     = "JetBrainsMono Nerd Font Bold 9"
theme.font_mono     = "JetBrainsMono Nerd Font Mono 9"

-- Colors
theme.bg_normal     = mocha.mantle .. "ee"  -- translucent mantle
theme.bg_focus      = mocha.surface0
theme.bg_urgent     = mocha.red
theme.bg_minimize   = mocha.surface1
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = mocha.text
theme.fg_focus      = mocha.text
theme.fg_urgent     = mocha.crust
theme.fg_minimize   = mocha.overlay1

-- Borders
theme.useless_gap         = 4
theme.border_width        = 1
theme.border_normal       = mocha.surface0
theme.border_focus        = mocha.blue
theme.border_marked       = mocha.red

-- Rounded corners radius
theme.border_radius       = 2

-- Taglist
theme.taglist_bg_focus    = mocha.surface1
theme.taglist_bg_occupied = mocha.surface0
theme.taglist_bg_urgent   = mocha.red
theme.taglist_bg_empty    = mocha.mantle .. "00"
theme.taglist_fg_focus    = mocha.blue
theme.taglist_fg_occupied = mocha.subtext1
theme.taglist_fg_urgent   = mocha.crust
theme.taglist_fg_empty    = mocha.overlay0
theme.taglist_shape       = gears.shape.rounded_rect
theme.taglist_spacing     = 2

-- Tasklist
theme.tasklist_bg_normal  = mocha.surface0 .. "80"
theme.tasklist_bg_focus   = mocha.blue
theme.tasklist_bg_urgent  = mocha.red
theme.tasklist_bg_minimize= mocha.surface0
theme.tasklist_fg_normal  = mocha.text
theme.tasklist_fg_focus   = mocha.text
theme.tasklist_fg_urgent  = mocha.crust
theme.tasklist_fg_minimize= mocha.overlay1
theme.tasklist_shape      = gears.shape.rounded_rect
theme.tasklist_spacing    = 4
theme.tasklist_align      = "center"
theme.tasklist_font       = theme.font
theme.tasklist_font_focus = theme.font_bold
theme.tasklist_disable_icon = false
theme.tasklist_icon_size  = 28

-- Wibar
theme.wibar_height        = 26
theme.wibar_bg            = mocha.mantle .. "cc"  -- 80% opacity
theme.wibar_fg            = mocha.text
theme.wibar_border_width  = 0
theme.wibar_border_color  = mocha.surface0
theme.wibar_shape         = gears.shape.rectangle

-- Tooltip
theme.tooltip_bg          = mocha.surface0
theme.tooltip_fg          = mocha.text
theme.tooltip_border_width= 1
theme.tooltip_border_color= mocha.surface1
theme.tooltip_shape       = gears.shape.rounded_rect

-- Menu
theme.menu_height         = 24
theme.menu_width          = 160
theme.menu_bg_normal      = mocha.mantle
theme.menu_bg_focus       = mocha.surface1
theme.menu_fg_normal      = mocha.text
theme.menu_fg_focus       = mocha.blue
theme.menu_border_width   = 1
theme.menu_border_color   = mocha.surface1
theme.menu_shape          = gears.shape.rounded_rect

-- Notification
theme.notification_bg     = mocha.mantle
theme.notification_fg     = mocha.text
theme.notification_border_width = 1
theme.notification_border_color = mocha.blue
theme.notification_shape  = gears.shape.rounded_rect
theme.notification_max_width = 400
theme.notification_icon_size = 48

-- Snap
theme.snap_bg             = mocha.blue
theme.snap_border_width   = 2
theme.snap_shape          = gears.shape.rounded_rect

-- Hotkeys popup
theme.hotkeys_bg          = mocha.mantle
theme.hotkeys_fg          = mocha.text
theme.hotkeys_border_width= 1
theme.hotkeys_border_color= mocha.blue
theme.hotkeys_shape       = gears.shape.rounded_rect
theme.hotkeys_modifiers_fg = mocha.blue
theme.hotkeys_label_fg    = mocha.subtext1
theme.hotkeys_font        = theme.font
theme.hotkeys_description_font = theme.font

-- Titlebar colors (Catppuccin Mocha)
theme.titlebar_bg_normal = mocha.mantle
theme.titlebar_bg_focus = mocha.surface0
theme.titlebar_fg_normal = mocha.subtext1
theme.titlebar_fg_focus = mocha.text

-- Titlebar button icons (Papirus-Dark 16x16)
local pi = "/usr/share/icons/Papirus-Dark/16x16/actions/"

-- Close
theme.titlebar_close_button_normal = pi .. "window-close.svg"
theme.titlebar_close_button_focus  = pi .. "window-close.svg"
theme.titlebar_close_button_normal_hover = pi .. "window-close.svg"
theme.titlebar_close_button_focus_hover  = pi .. "window-close.svg"
theme.titlebar_close_button_normal_press = pi .. "window-close.svg"
theme.titlebar_close_button_focus_press  = pi .. "window-close.svg"

-- Minimize
theme.titlebar_minimize_button_normal = pi .. "window-minimize.svg"
theme.titlebar_minimize_button_focus  = pi .. "window-minimize.svg"
theme.titlebar_minimize_button_normal_hover = pi .. "window-minimize.svg"
theme.titlebar_minimize_button_focus_hover  = pi .. "window-minimize.svg"
theme.titlebar_minimize_button_normal_press = pi .. "window-minimize.svg"
theme.titlebar_minimize_button_focus_press  = pi .. "window-minimize.svg"

-- Maximize
theme.titlebar_maximized_button_normal = pi .. "window-maximize.svg"
theme.titlebar_maximized_button_focus  = pi .. "window-maximize.svg"
theme.titlebar_maximized_button_normal_active = pi .. "window-restore.svg"
theme.titlebar_maximized_button_focus_active  = pi .. "window-restore.svg"

-- Floating
theme.titlebar_floating_button_normal = pi .. "window.svg"
theme.titlebar_floating_button_focus  = pi .. "window.svg"
theme.titlebar_floating_button_normal_active = pi .. "window.svg"
theme.titlebar_floating_button_focus_active  = pi .. "window.svg"

-- Sticky/Pin
theme.titlebar_sticky_button_normal = pi .. "window-pin.svg"
theme.titlebar_sticky_button_focus  = pi .. "window-pin.svg"
theme.titlebar_sticky_button_normal_active = pi .. "window-unpin.svg"
theme.titlebar_sticky_button_focus_active  = pi .. "window-unpin.svg"

-- On top
theme.titlebar_ontop_button_normal = pi .. "window-keep-above.svg"
theme.titlebar_ontop_button_focus  = pi .. "window-keep-above.svg"
theme.titlebar_ontop_button_normal_active = pi .. "window-keep-above.svg"
theme.titlebar_ontop_button_focus_active  = pi .. "window-keep-above.svg"

-- Layout icons (will use text fallback)
theme.layout_floating     = "󰝴"
theme.layout_tile         = "󰕰"
theme.layout_tileleft     = "󰕱"
theme.layout_tilebottom   = "󰕲"
theme.layout_tiletop      = "󰕳"
theme.layout_fairv        = "󰕴"
theme.layout_fairh        = "󰕵"
theme.layout_spiral       = "󰕶"
theme.layout_dwindle      = "󰕷"
theme.layout_max          = "󰕸"
theme.layout_fullscreen   = "󰕹"
theme.layout_magnifier    = "󰕺"
theme.layout_corner_nw    = "󰕻"

-- Icon theme
theme.icon_theme = "Papirus-Dark"

-- Widget pill colors
theme.pill_bg       = mocha.surface0
theme.pill_fg       = mocha.text
theme.pill_spacing  = 6
theme.pill_padding  = 10

-- Glyphs (Nerd Font codepoints verified)
theme.glyph = {
    arch        = "󰣇",  -- U+F08C7 dev-archlinux
    cpu         = "󰻠",  -- U+F0EE0 fa-microchip (alt)
    ram         = "󰍛",  -- U+F035B fa-memory
    net_up      = "󰁝",  -- U+F005D
    net_down    = "󰁅",  -- U+F0045
    clock       = "󰥔",  -- U+F0954
    layout      = "󰕰",  -- U+F0570
    vol_high    = "󰕾",  -- U+F057E
    vol_mid     = "󰖀",  -- U+F0580
    vol_low     = "󰕿",  -- U+F057F
    vol_mute    = "󰝟",  -- U+F075F
    bat_full    = "󰁹",  -- U+F0079
    bat_mid     = "󰁿",  -- U+F007F
    bat_low     = "󰂎",  -- U+F008E
    bat_charge  = "󰂄",  -- U+F0084
    sep         = "│",
    launcher    = "",  -- U+E732 Arch Linux logo
}

-- Load default theme as fallback for missing properties (titlebar button images, etc.)
local default_theme_path = gears.filesystem.get_themes_dir() .. "default/theme.lua"
if gears.filesystem.file_readable(default_theme_path) then
    local default = dofile(default_theme_path)
    for k, v in pairs(default) do
        if rawget(theme, k) == nil then
            theme[k] = v
        end
    end
end

return theme