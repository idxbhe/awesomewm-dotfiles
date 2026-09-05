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
theme.font          = "Maple Mono NF Bold 12"
theme.font_bold     = "Maple Mono NF Bold 12"
theme.font_mono     = "Maple Mono NF Bold 12"

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
theme.useless_gap         = 1
theme.border_width        = 1
theme.border_normal       = mocha.surface0
theme.border_focus        = mocha.blue
theme.border_marked       = mocha.red

-- Rounded corners radius
theme.border_radius       = 6

-- Taglist
theme.taglist_font        = "Maple Mono NF Bold 10"
theme.taglist_bg_focus    = mocha.surface1
theme.taglist_bg_occupied = mocha.surface0
theme.taglist_bg_urgent   = mocha.red
theme.taglist_bg_empty    = mocha.mantle .. "00"
theme.taglist_fg_focus    = mocha.blue
theme.taglist_fg_occupied = mocha.subtext1
theme.taglist_fg_urgent   = mocha.crust
theme.taglist_fg_empty    = mocha.overlay0
theme.taglist_spacing     = 4
theme.taglist_squares_sel = false
theme.taglist_squares_unsel = false
theme.taglist_squares_sel_empty = false
theme.taglist_squares_unsel_empty = false

-- Tasklist
theme.tasklist_bg_normal  = mocha.surface0 .. "80"
theme.tasklist_bg_focus   = "#3b5998"
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
theme.titlebar_size = 22
theme.titlebar_font = "Maple Mono NF Bold 9"

-- Titlebar button icons (Papirus-Dark 16x16, forced 14x14 render)
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
theme.titlebar_maximized_button_normal_inactive = pi .. "window-maximize.svg"
theme.titlebar_maximized_button_focus_inactive  = pi .. "window-maximize.svg"
theme.titlebar_maximized_button_normal_active = pi .. "window-maximize.svg"
theme.titlebar_maximized_button_focus_active  = pi .. "window-maximize.svg"

-- Floating
theme.titlebar_floating_button_normal = pi .. "focus-windows.svg"
theme.titlebar_floating_button_focus  = pi .. "focus-windows.svg"
theme.titlebar_floating_button_normal_inactive = pi .. "focus-windows.svg"
theme.titlebar_floating_button_focus_inactive  = pi .. "focus-windows.svg"
theme.titlebar_floating_button_normal_active = pi .. "focus-windows.svg"
theme.titlebar_floating_button_focus_active  = pi .. "focus-windows.svg"

-- Sticky/Pin
theme.titlebar_sticky_button_normal = pi .. "window-pin.svg"
theme.titlebar_sticky_button_focus  = pi .. "window-pin.svg"
theme.titlebar_sticky_button_normal_inactive = pi .. "window-pin.svg"
theme.titlebar_sticky_button_focus_inactive  = pi .. "window-pin.svg"
theme.titlebar_sticky_button_normal_active = pi .. "window-unpin.svg"
theme.titlebar_sticky_button_focus_active  = pi .. "window-unpin.svg"

-- On top
theme.titlebar_ontop_button_normal = pi .. "window-shade.svg"
theme.titlebar_ontop_button_focus  = pi .. "window-shade.svg"
theme.titlebar_ontop_button_normal_inactive = pi .. "window-shade.svg"
theme.titlebar_ontop_button_focus_inactive  = pi .. "window-shade.svg"
theme.titlebar_ontop_button_normal_active = pi .. "window-unshade.svg"
theme.titlebar_ontop_button_focus_active  = pi .. "window-unshade.svg"

-- Layout icons (custom icons.ttf layout glyphs)
theme.layout_floating     = "\u{f260}"   -- wm-floating
theme.layout_tile         = "\u{fb96}"   -- wm-tile
theme.layout_tilebottom   = "\u{fa2e}"   -- wm-tile-bottom
theme.layout_max          = "\u{1002d}"  -- wm-full

-- Icon theme
theme.icon_theme = "Papirus-Dark"

-- Widget pill colors
theme.pill_bg       = mocha.surface0
theme.pill_fg       = mocha.text
theme.pill_spacing  = 6
theme.pill_padding  = 6
theme.pill_radius   = 4

-- Surface colors (for widget backgrounds)
theme.surface0 = mocha.surface0
theme.surface1 = mocha.surface1
theme.blue = mocha.blue
theme.blue_dark = "#3b5998"
theme.red_dark = "#a33b4e"
theme.green_dark = "#2a9d4f"

-- Glyphs (custom "icons" font, codepoints from demo.html)
theme.glyph = {
    cpu             = "\u{f810}",  -- bar-cpu
    ram             = "\u{ffdc}",  -- bar-memory
    clock           = "\u{f02b}",  -- bar-clock
    net_down        = "\u{101b2}", -- bar-netspeed
    layout          = "\u{f174}",  -- bar-tools
    vol_high        = "\u{f2d5}",  -- volume-high
    vol_mid         = "\u{fc41}",  -- volume-none
    vol_low         = "\u{fd71}",  -- volume-low
    vol_none        = "\u{fc41}",  -- volume-none (alias)
    vol_mute        = "\u{f635}",  -- volume-mute
    bat_full        = "\u{ffdc}",  -- bar-memory (reuse)
    bat_mid         = "\u{ffdc}",  -- bar-memory (reuse)
    bat_low         = "\u{ffdc}",  -- bar-memory (reuse)
    bat_charge      = "\u{ffdc}",  -- bar-memory (reuse)
    sep             = "|",
    launcher        = "\u{fb8c}",  -- bar-main-menu
    wifi_on         = "\u{fcfe}",  -- settings-wifi
    wifi_off        = "\u{fcfe}",  -- settings-wifi
    bt_on           = "\u{f90e}",  -- settings-bluetooth
    bt_off          = "\u{f90e}",  -- settings-bluetooth
    airplane_on     = "\u{fbba}",  -- settings-airplane
    airplane_off    = "\u{fbba}",  -- settings-airplane
    brightness      = "\u{fae1}",  -- settings-brightness
    bar_brightness  = "\u{fae2}",  -- bar-brightness
    settings        = "\u{fcd8}",  -- bar-settings
    tools           = "\u{f174}",  -- bar-tools
    tools_ss        = "\u{f98b}",  -- tools-ss (screenshot)
    alarm           = "\u{fecd}",  -- tools-alarm
    clipboard       = "\u{fec5}",  -- tools-clipboard
    power           = "\u{f8cf}",  -- power-shutdown
    shutdown        = "\u{f8cf}",  -- power-shutdown
    restart         = "\u{ff0c}",  -- power-restart
    logout          = "\u{fe35}",  -- power-logout
    toggle_on       = "\u{fa3f}",  -- toggle-on
    toggle_off      = "\u{f6e3}",  -- toggle-off
    btn_delete      = "\u{f32f}",  -- button-delete
    btn_delete_alt  = "\u{f890}",  -- button-delete-alt
    btn_edit        = "\u{f565}",  -- button-edit
    btn_edit_alt    = "\u{fd33}",  -- button-edit-alt
    btn_arrow_left  = "\u{f03d}",  -- arrow-left (back arrow)
    btn_cancel      = "\u{f488}",  -- button-cancel
    btn_save        = "\u{f0ce}",  -- button-save
    btn_add         = "\u{f99c}",  -- button-add
    pin             = "\u{f5f4}",  -- pin
    pin_outline     = "\u{fafd}",  -- pin-alt
    -- Window manager layout icons (mapped to AwesomeWM layout names)
    wm_floating     = "\u{f260}",  -- wm-floating
    wm_tile         = "\u{fb96}",  -- wm-tile
    wm_tile_bottom  = "\u{fa2e}",  -- wm-tile-bottom
    wm_full         = "\u{1002d}", -- wm-full
    -- AwesomeWM layout name mappings
    floating        = "\u{f260}",
    tile            = "\u{fb96}",
    tilebottom      = "\u{fa2e}",
    max             = "\u{1002d}",
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