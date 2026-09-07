-- themes/catppuccin-mocha.lua
-- Catppuccin Mocha theme - maps palette to semantic tokens

local tokens = require("themes.tokens")

local m = {
  -- Catppuccin Mocha palette
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

-- Map palette to semantic tokens
local theme = {
  -- Base surfaces
  bg        = m.mantle,
  bg_alt    = m.base,
  bg_subtle = m.surface0,

  -- Content
  fg        = m.text,
  fg_muted  = m.subtext1,
  fg_subtle = m.overlay1,

  -- Accent (will be overridden by accent preset)
  accent         = m.blue,
  accent_fg      = m.crust,
  accent_subtle  = m.blue,

  -- State colors
  success   = m.green,
  warning   = m.yellow,
  error     = m.red,
  info      = m.sapphire,

  -- Borders
  border         = m.surface0,
  border_focus   = m.blue,
  border_subtle  = m.surface1,

  -- Widget-specific
  pill_bg       = m.surface0,
  pill_fg       = m.text,
  slider_track  = m.surface2,
  slider_active = m.blue,

  -- Fonts
  font          = "Maple Mono NF Bold 10",
  font_bold     = "Maple Mono NF Bold 10",
  font_mono     = "Maple Mono NF Bold 10",
  font_icon     = "icons 12",
  font_popup    = "Maple Mono NF Bold 11",
  font_popup_regular = "Maple Mono NF 11",

  -- Sizing
  wibar_height  = 26,
  border_radius = 6,
  useless_gap   = 1,
  border_width  = 1,

  -- Taglist
  taglist_font        = "Maple Mono NF Bold 10",
  taglist_spacing     = 4,
  taglist_squares_sel = false,
  taglist_squares_unsel = false,

  -- Tasklist
  tasklist_spacing   = 4,
  tasklist_align     = "center",
  tasklist_disable_icon = false,
  tasklist_icon_size = 28,

  -- Tooltip
  tooltip_border_width = 1,
  tooltip_shape        = function(cr, w, h) require("gears").shape.rounded_rect(cr, w, h, 4) end,

  -- Menu
  menu_height      = 24,
  menu_width       = 160,
  menu_border_width = 1,
  menu_shape       = function(cr, w, h) require("gears").shape.rounded_rect(cr, w, h, 6) end,

  -- Notification
  notification_border_width = 1,
  notification_shape        = function(cr, w, h) require("gears").shape.rounded_rect(cr, w, h, 6) end,
  notification_max_width    = 400,
  notification_icon_size    = 48,

  -- Snap
  snap_border_width = 2,
  snap_shape        = function(cr, w, h) require("gears").shape.rounded_rect(cr, w, h, 6) end,

  -- Hotkeys
  hotkeys_border_width = 1,
  hotkeys_shape        = function(cr, w, h) require("gears").shape.rounded_rect(cr, w, h, 6) end,
  hotkeys_modifiers_fg = m.blue,
  hotkeys_label_fg     = m.subtext1,
  hotkeys_font         = "Maple Mono NF Bold 10",
  hotkeys_description_font = "Maple Mono NF 10",

  -- Titlebar
  titlebar_size = 22,
  titlebar_font = "Maple Mono NF Bold 9",

  -- Layout icons (glyphs from custom icons font)
  layout_floating   = "\u{f260}",
  layout_tile       = "\u{fb96}",
  layout_tilebottom = "\u{fa2e}",
  layout_max        = "\u{1002d}",

  -- Icon theme
  icon_theme = "Papirus-Dark",

  -- Widget pill
  pill_spacing = 6,
  pill_padding = 6,
  pill_radius  = 4,

  -- Alpha constants
  alpha_90 = "ee",
  alpha_80 = "cc",
  alpha_50 = "80",
  alpha_10 = "1a",
  alpha_05 = "0d",

  -- Glyphs (custom "icons" font codepoints)
  glyph = {
    cpu             = "\u{f810}",
    ram             = "\u{ffdc}",
    clock           = "\u{f02b}",
    net_down        = "\u{101b2}",
    layout          = "\u{f174}",
    vol_high        = "\u{f2d5}",
    vol_mid         = "\u{fc41}",
    vol_low         = "\u{fd71}",
    vol_none        = "\u{fc41}",
    vol_mute        = "\u{f635}",
    bat_full        = "\u{ffdc}",
    bat_mid         = "\u{ffdc}",
    bat_low         = "\u{ffdc}",
    bat_charge      = "\u{ffdc}",
    sep             = "|",
    launcher        = "\u{fb8c}",
    wifi_on         = "\u{fcfe}",
    wifi_off        = "\u{fcfe}",
    bt_on           = "\u{f90e}",
    bt_off          = "\u{f90e}",
    airplane_on     = "\u{fbba}",
    airplane_off    = "\u{fbba}",
    brightness      = "\u{fae1}",
    bar_brightness  = "\u{fae2}",
    settings        = "\u{fcd8}",
    tools           = "\u{f174}",
    tools_ss        = "\u{f98b}",
    alarm           = "\u{fecd}",
    clipboard       = "\u{fec5}",
    power           = "\u{f8cf}",
    shutdown        = "\u{f8cf}",
    restart         = "\u{ff0c}",
    logout          = "\u{fe35}",
    restart_wm      = "\u{f421}",
    toggle_on       = "\u{fa3f}",
    toggle_off      = "\u{f6e3}",
    btn_delete      = "\u{f32f}",
    btn_delete_alt  = "\u{f890}",
    btn_edit        = "\u{f565}",
    btn_edit_alt    = "\u{fd33}",
    btn_arrow_left  = "\u{f03d}",
    btn_cancel      = "\u{f488}",
    btn_save        = "\u{f0ce}",
    btn_add         = "\u{f99c}",
    pin             = "\u{f5f4}",
    pin_outline     = "\u{fafd}",
    wm_floating     = "\u{f260}",
    wm_tile         = "\u{fb96}",
    wm_tile_bottom  = "\u{fa2e}",
    wm_full         = "\u{1002d}",
    floating        = "\u{f260}",
    tile            = "\u{fb96}",
    tilebottom      = "\u{fa2e}",
    max             = "\u{1002d}",
  },

  -- Titlebar button icons (custom SVGs)
  titlebar_icons_path = require("gears").filesystem.get_configuration_dir() .. "icons/",
}

-- Derive computed tokens
return tokens.derive(theme)