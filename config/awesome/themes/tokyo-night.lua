-- themes/tokyo-night.lua
-- Tokyo Night theme - maps palette to semantic tokens

local tokens = require("themes.tokens")

local t = {
  -- Tokyo Night palette (storm variant)
  bg        = "#1a1b26",
  bg_dark   = "#16161e",
  bg_highlight = "#292e42",
  terminal_black = "#414868",
  fg        = "#c0caf5",
  fg_dark   = "#a9b1d6",
  fg_gutter = "#3b4261",
  dark3     = "#545c7e",
  comment   = "#565f89",
  dark5     = "#737aa2",
  blue0     = "#3d59a1",
  blue      = "#7aa2f7",
  cyan      = "#7dcfff",
  blue1     = "#2ac3de",
  blue2     = "#0db9d7",
  blue5     = "#89ddff",
  blue6     = "#b4f9f8",
  blue7     = "#394b70",
  magenta   = "#bb9af7",
  magenta2  = "#ff007c",
  purple    = "#9d7cd8",
  orange    = "#ff9e64",
  yellow    = "#e0af68",
  green     = "#9ece6a",
  green1    = "#73daca",
  green2    = "#41a6b5",
  teal      = "#1abc9c",
  red       = "#f7768e",
  red1      = "#db4b4b",
}

-- Map palette to semantic tokens
local theme = {
  -- Base surfaces
  bg        = t.bg_dark,
  bg_alt    = t.bg,
  bg_subtle = t.bg_highlight,

  -- Content
  fg        = t.fg,
  fg_muted  = t.fg_dark,
  fg_subtle = t.comment,

  -- Accent (will be overridden by accent preset)
  accent         = t.blue,
  accent_fg      = t.bg_dark,
  accent_subtle  = t.blue,

  -- State colors
  success   = t.green,
  warning   = t.yellow,
  error     = t.red,
  info      = t.cyan,

  -- Borders
  border         = t.terminal_black,
  border_focus   = t.blue,
  border_subtle  = t.dark3,

  -- Widget-specific
  pill_bg       = t.bg_highlight,
  pill_fg       = t.fg,
  slider_track  = t.dark3,
  slider_active = t.blue,

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
  hotkeys_modifiers_fg = t.blue,
  hotkeys_label_fg     = t.fg_dark,
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

  -- Semantic accent aliases (for backward compat with beautiful)
  blue        = t.blue,
  blue_dark   = t.bg_dark,

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
    chevron_left    = "\u{f104}",
    chevron_right   = "\u{f105}",
    -- New settings icons
    settings_display_animation = "\u{f422}",
    settings_display_shadow = "\u{f28e}",
    settings_display_blur = "\u{f9a9}",
    settings_display_transparency = "\u{fe61}",
    settings_themes_theme = "\u{f5fe}",
    settings_themes_accent = "\u{fab3}",
  },

  -- Titlebar button icons (custom SVGs)
  titlebar_icons_path = require("gears").filesystem.get_configuration_dir() .. "icons/",
}

-- Derive computed tokens
return tokens.derive(theme)