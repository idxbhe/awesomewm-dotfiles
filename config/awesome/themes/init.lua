-- themes/init.lua
-- Theme manager: runtime switching, generators for all apps

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local tokens = require("themes.tokens")
local accents = require("themes.accents")

local M = {}

-- State
M.current_theme = "catppuccin-mocha"
M.current_accent = "blue"
M.tokens = {}
M.themes = {
  ["catppuccin-mocha"] = "themes.catppuccin-mocha",
  ["tokyo-night"] = "themes.tokyo-night",
}
M.accents = accents  -- expose accents module

-- Cache directory for generated configs
M.cache_dir = gears.filesystem.get_cache_dir() .. "/theme-gen"
gears.filesystem.make_directories(M.cache_dir)

-- Theme order for cycling
M.theme_order = {"catppuccin-mocha", "tokyo-night"}

-- Load and apply theme
function M.load_theme(name, accent_name)
  if not M.themes[name] then
    print("[theme] Unknown theme: " .. name)
    return false
  end

  M.current_theme = name
  if accent_name then M.current_accent = accent_name end

  -- Load base theme tokens
  local theme_mod = require(M.themes[name])
  local base_tokens = gears.table.clone(theme_mod)

  -- Apply accent preset
  local accent = accents.get(M.current_accent)
  local merged = gears.table.join(base_tokens, accent)

  -- Derive computed tokens
  M.tokens = tokens.derive(merged)

  -- Apply to beautiful
  M.apply_to_beautiful()

  -- Generate external configs
  M.generate_all()

  -- Emit signal for widgets to refresh
  awesome.emit_signal("theme::changed")

  print("[theme] Loaded: " .. name .. " with accent " .. M.current_accent)
  return true
end

-- Apply tokens to beautiful.theme
function M.apply_to_beautiful()
  local t = M.tokens
  local theme = {}

  -- Copy all tokens to beautiful
  for k, v in pairs(t) do
    theme[k] = v
  end

  -- Beautiful-specific mappings
  theme.bg_normal     = t.bg
  theme.bg_focus      = t.bg_subtle
  theme.bg_urgent     = t.error
  theme.bg_minimize   = t.bg_subtle
  theme.bg_systray    = t.bg

  theme.fg_normal     = t.fg
  theme.fg_focus      = t.fg
  theme.fg_urgent     = t.accent_fg
  theme.fg_minimize   = t.fg_muted

  theme.useless_gap   = t.useless_gap
  theme.border_width  = t.border_width
  theme.border_normal = t.border
  theme.border_focus  = t.border_focus
  theme.border_marked = t.warning

  theme.border_radius = t.border_radius

  -- Taglist
  theme.taglist_font        = t.taglist_font
  theme.taglist_bg_focus    = t.taglist_bg_focus
  theme.taglist_bg_occupied = t.taglist_bg_occupied
  theme.taglist_bg_urgent   = t.error
  theme.taglist_bg_empty    = t.taglist_bg_empty
  theme.taglist_fg_focus    = t.accent
  theme.taglist_fg_occupied = t.fg_muted
  theme.taglist_fg_urgent   = t.accent_fg
  theme.taglist_fg_empty    = t.fg_subtle
  theme.taglist_spacing     = t.taglist_spacing
  theme.taglist_squares_sel = t.taglist_squares_sel
  theme.taglist_squares_unsel = t.taglist_squares_unsel
  theme.taglist_squares_sel_empty = t.taglist_squares_sel_empty
  theme.taglist_squares_unsel_empty = t.taglist_squares_unsel_empty

  -- Tasklist
  theme.tasklist_bg_normal  = t.tasklist_bg_normal
  theme.tasklist_bg_focus   = t.tasklist_bg_focus
  theme.tasklist_bg_urgent  = t.error
  theme.tasklist_bg_minimize = t.bg_subtle
  theme.tasklist_fg_normal  = t.fg
  theme.tasklist_fg_focus   = t.accent_fg
  theme.tasklist_fg_urgent  = t.accent_fg
  theme.tasklist_fg_minimize = t.fg_muted
  theme.tasklist_shape      = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, t.border_radius) end
  theme.tasklist_spacing    = t.tasklist_spacing
  theme.tasklist_align      = t.tasklist_align
  theme.tasklist_font       = t.font
  theme.tasklist_font_focus = t.font_bold
  theme.tasklist_disable_icon = t.tasklist_disable_icon
  theme.tasklist_icon_size  = t.tasklist_icon_size

  -- Wibar
  theme.wibar_height        = t.wibar_height
  theme.wibar_bg            = t.wibar_bg
  theme.wibar_fg            = t.fg
  theme.wibar_border_width  = 0
  theme.wibar_border_color  = t.border
  theme.wibar_shape         = gears.shape.rectangle
  theme.wibar_cursor        = "left_ptr"

  -- Never show the busy "watch" cursor for spawns (it lingers for the full
  -- 20s startup-notification timeout on shell utilities and is inherited by
  -- wiboxes such as the titlebar)
  theme.enable_spawn_cursor = false

  -- Tooltip
  theme.tooltip_bg          = t.tooltip_bg
  theme.tooltip_fg          = t.fg
  theme.tooltip_border_width = t.tooltip_border_width
  theme.tooltip_border_color = t.border_subtle
  theme.tooltip_shape       = t.tooltip_shape

  -- Menu
  theme.menu_height         = t.menu_height
  theme.menu_width          = t.menu_width
  theme.menu_bg_normal      = t.menu_bg_normal
  theme.menu_bg_focus       = t.menu_bg_focus
  theme.menu_fg_normal      = t.fg
  theme.menu_fg_focus       = t.accent
  theme.menu_border_width   = t.menu_border_width
  theme.menu_border_color   = t.border_subtle
  theme.menu_shape          = t.menu_shape

  -- Notification
  theme.notification_bg     = t.notification_bg
  theme.notification_fg     = t.fg
  theme.notification_border_width = t.notification_border_width
  theme.notification_border_color = t.accent
  theme.notification_shape  = t.notification_shape
  theme.notification_max_width = t.notification_max_width
  theme.notification_icon_size = t.notification_icon_size

  -- Snap
  theme.snap_bg             = t.snap_bg
  theme.snap_border_width   = t.snap_border_width
  theme.snap_shape          = t.snap_shape

  -- Hotkeys
  theme.hotkeys_bg          = t.hotkeys_bg
  theme.hotkeys_fg          = t.fg
  theme.hotkeys_border_width = t.hotkeys_border_width
  theme.hotkeys_border_color = t.hotkeys_border_color
  theme.hotkeys_shape       = t.hotkeys_shape
  theme.hotkeys_modifiers_fg = t.hotkeys_modifiers_fg
  theme.hotkeys_label_fg    = t.hotkeys_label_fg
  theme.hotkeys_font        = t.hotkeys_font
  theme.hotkeys_description_font = t.hotkeys_description_font

  -- Titlebar
  theme.titlebar_bg_normal  = t.titlebar_bg_normal
  theme.titlebar_bg_focus   = t.titlebar_bg_focus
  theme.titlebar_fg_normal  = t.fg_muted
  theme.titlebar_fg_focus   = t.fg
  theme.titlebar_size       = t.titlebar_size
  theme.titlebar_font       = t.titlebar_font

  -- Layout
  theme.layout_floating   = t.layout_floating
  theme.layout_tile       = t.layout_tile
  theme.layout_tilebottom = t.layout_tilebottom
  theme.layout_max        = t.layout_max

  -- Icon
  theme.icon_theme = t.icon_theme

  -- Pill
  theme.pill_bg       = t.pill_bg
  theme.pill_fg       = t.pill_fg
  theme.pill_spacing  = t.pill_spacing
  theme.pill_padding  = t.pill_padding
  theme.pill_radius   = t.pill_radius

  -- Surface colors (for widget backgrounds)
  theme.surface0 = t.bg_subtle
  theme.surface1 = t.border_subtle
  theme.blue = t.blue
  theme.blue_dark = t.blue_dark
  theme.red_dark = t.error
  theme.green_dark = t.success

  -- Glyphs
  theme.glyph = t.glyph

  -- Titlebar icons
  local ic = t.titlebar_icons_path
  theme.titlebar_close_button_normal = ic .. "close-normal.svg"
  theme.titlebar_close_button_focus  = ic .. "close-normal.svg"
  theme.titlebar_close_button_normal_hover = ic .. "close-hover.svg"
  theme.titlebar_close_button_focus_hover  = ic .. "close-hover.svg"
  theme.titlebar_close_button_normal_press = ic .. "close-press.svg"
  theme.titlebar_close_button_focus_press  = ic .. "close-press.svg"

  theme.titlebar_minimize_button_normal = ic .. "minimize-normal.svg"
  theme.titlebar_minimize_button_focus  = ic .. "minimize-normal.svg"
  theme.titlebar_minimize_button_normal_hover = ic .. "minimize-hover.svg"
  theme.titlebar_minimize_button_focus_hover  = ic .. "minimize-hover.svg"
  theme.titlebar_minimize_button_normal_press = ic .. "minimize-press.svg"
  theme.titlebar_minimize_button_focus_press  = ic .. "minimize-press.svg"

  theme.titlebar_maximized_button_normal = ic .. "maximize-normal.svg"
  theme.titlebar_maximized_button_focus  = ic .. "maximize-normal.svg"
  theme.titlebar_maximized_button_normal_inactive = ic .. "maximize-normal.svg"
  theme.titlebar_maximized_button_focus_inactive  = ic .. "maximize-normal.svg"
  theme.titlebar_maximized_button_normal_active = ic .. "maximize-normal.svg"
  theme.titlebar_maximized_button_focus_active  = ic .. "maximize-normal.svg"
  theme.titlebar_maximized_button_normal_hover = ic .. "maximize-hover.svg"
  theme.titlebar_maximized_button_focus_hover  = ic .. "maximize-hover.svg"
  theme.titlebar_maximized_button_normal_active_hover = ic .. "maximize-hover.svg"
  theme.titlebar_maximized_button_focus_active_hover = ic .. "maximize-hover.svg"
  theme.titlebar_maximized_button_normal_press = ic .. "maximize-press.svg"
  theme.titlebar_maximized_button_focus_press  = ic .. "maximize-press.svg"
  theme.titlebar_maximized_button_normal_active_press = ic .. "maximize-press.svg"
  theme.titlebar_maximized_button_focus_active_press  = ic .. "maximize-press.svg"

  -- Initialize beautiful
  beautiful.init(theme)
end

-- Generate GTK CSS
function M.generate_gtk()
  local t = M.tokens
  local css = [[
/* Generated by AwesomeWM theme system - DO NOT EDIT MANUALLY */
/* Theme: ]] .. M.current_theme .. [[ | Accent: ]] .. M.current_accent .. [[ */

:root {
  /* Base surfaces */
  --bg: ]] .. t.bg .. [[;
  --bg-alt: ]] .. t.bg_alt .. [[;
  --bg-subtle: ]] .. t.bg_subtle .. [[;

  /* Content */
  --fg: ]] .. t.fg .. [[;
  --fg-muted: ]] .. t.fg_muted .. [[;
  --fg-subtle: ]] .. t.fg_subtle .. [[;

  /* Accent */
  --accent: ]] .. t.accent .. [[;
  --accent-fg: ]] .. t.accent_fg .. [[;
  --accent-subtle: ]] .. t.accent_subtle .. [[;

  /* State */
  --success: ]] .. t.success .. [[;
  --warning: ]] .. t.warning .. [[;
  --error: ]] .. t.error .. [[;
  --info: ]] .. t.info .. [[;

  /* Borders */
  --border: ]] .. t.border .. [[;
  --border-focus: ]] .. t.border_focus .. [[;
  --border-subtle: ]] .. t.border_subtle .. [[;

  /* Widgets */
  --pill-bg: ]] .. t.pill_bg .. [[;
  --pill-fg: ]] .. t.pill_fg .. [[;
  --slider-track: ]] .. t.slider_track .. [[;
  --slider-active: ]] .. t.slider_active .. [[;

  /* Opacity */
  --alpha-90: ]] .. t.alpha_90 .. [[;
  --alpha-80: ]] .. t.alpha_80 .. [[;
  --alpha-50: ]] .. t.alpha_50 .. [[;
  --alpha-10: ]] .. t.alpha_10 .. [[;
}

/* GTK3 applications */
window {
  background-color: var(--bg);
  color: var(--fg);
}

headerbar {
  background-color: var(--bg-alt);
  color: var(--fg);
  border-bottom: 1px solid var(--border);
}

button {
  background-color: var(--bg-subtle);
  color: var(--fg);
  border: 1px solid var(--border);
  border-radius: 4px;
}

button:hover {
  background-color: var(--accent-subtle);
}

button:focus {
  border-color: var(--border-focus);
  box-shadow: 0 0 0 2px var(--accent-subtle);
}

button.suggested-action {
  background-color: var(--accent);
  color: var(--accent-fg);
}

button.destructive-action {
  background-color: var(--error);
  color: var(--accent-fg);
}

entry, textview, spinbutton, combobox {
  background-color: var(--bg);
  color: var(--fg);
  border: 1px solid var(--border);
  border-radius: 4px;
}

entry:focus, textview:focus, spinbutton:focus, combobox:focus {
  border-color: var(--border-focus);
}

scale {
  background-color: transparent;
}

scale slider {
  min-width: 12px;
  min-height: 12px;
  background-color: var(--accent);
  border-radius: 6px;
}

scale trough {
  background-color: var(--slider-track);
  border-radius: 4px;
  min-height: 6px;
}

progressbar {
  background-color: var(--slider-track);
  border-radius: 4px;
}

progressbar progress {
  background-color: var(--accent);
  border-radius: 4px;
}

menu, .menu {
  background-color: var(--bg-alt);
  border: 1px solid var(--border);
  border-radius: 6px;
}

menuitem:hover {
  background-color: var(--accent-subtle);
}

scrollbar {
  background-color: var(--bg-subtle);
}

scrollbar slider {
  background-color: var(--border);
  border-radius: 4px;
  min-width: 8px;
  min-height: 8px;
}

scrollbar slider:hover {
  background-color: var(--accent);
}

/* Thunar-specific */
.thunar {
  background-color: var(--bg);
}

.thunar .sidebar {
  background-color: var(--bg-alt);
  border-right: 1px solid var(--border);
}

.thunar .view {
  background-color: var(--bg);
}

.thunar .view:selected {
  background-color: var(--accent-subtle);
}

/* Tooltip */
tooltip {
  background-color: var(--bg-subtle);
  color: var(--fg);
  border: 1px solid var(--border-subtle);
  border-radius: 4px;
}

/* Notification */
.notification {
  background-color: var(--bg);
  color: var(--fg);
  border: 1px solid var(--accent);
  border-radius: 6px;
}
]]

  local file = M.cache_dir .. "/gtk.css"
  local f = io.open(file, "w")
  if f then
    f:write(css)
    f:close()
  end

  -- Also generate settings.ini (minimal - theme name handled by GTK theme packages)
  local ini = [[
[Settings]
gtk-application-prefer-dark-theme=1
gtk-font-name=Maple Mono NF 10
gtk-icon-theme-name=Papirus-Dark
gtk-cursor-theme-name=capitaine-cursors
gtk-theme-name=Adwaita-dark
]]
  file = M.cache_dir .. "/settings.ini"
  f = io.open(file, "w")
  if f then
    f:write(ini)
    f:close()
  end

  return M.cache_dir .. "/gtk.css"
end

-- Generate Alacritty TOML
function M.generate_alacritty()
  local t = M.tokens
  local toml = [[
# Generated by AwesomeWM theme system - DO NOT EDIT MANUALLY
# Theme: ]] .. M.current_theme .. [[ | Accent: ]] .. M.current_accent .. [[

[colors.primary]
background = ']] .. t.bg .. [['
foreground = ']] .. t.fg .. [['
dim_foreground = ']] .. t.fg_muted .. [['
bright_foreground = ']] .. t.fg .. [['

[colors.cursor]
text = ']] .. t.accent_fg .. [['
cursor = ']] .. t.accent .. [['
vi_mode_cursor = ']] .. t.warning .. [['
vi_mode_text = ']] .. t.accent_fg .. [['
selection = ']] .. t.accent_subtle .. [['
search_match = ']] .. t.warning .. [['

[colors.normal]
black = ']] .. t.bg_subtle .. [['
red = ']] .. t.error .. [['
green = ']] .. t.success .. [['
yellow = ']] .. t.warning .. [['
blue = ']] .. t.accent .. [['
magenta = ']] .. (t.magenta or t.purple or t.accent) .. [['
cyan = ']] .. t.info .. [['
white = ']] .. t.fg_muted .. [['
dim_black = ']] .. t.bg_subtle .. [['
dim_red = ']] .. t.error .. [['
dim_green = ']] .. t.success .. [['
dim_yellow = ']] .. t.warning .. [['
dim_blue = ']] .. t.accent .. [['
dim_magenta = ']] .. (t.magenta or t.purple or t.accent) .. [['
dim_cyan = ']] .. t.info .. [['
dim_white = ']] .. t.fg_subtle .. [['

[colors.bright]
black = ']] .. t.fg_subtle .. [['
red = ']] .. t.error .. [['
green = ']] .. t.success .. [['
yellow = ']] .. t.warning .. [['
blue = ']] .. t.accent .. [['
magenta = ']] .. (t.magenta or t.purple or t.accent) .. [['
cyan = ']] .. t.info .. [['
white = ']] .. t.fg .. [['
bright_black = ']] .. t.fg_subtle .. [['
bright_red = ']] .. t.error .. [['
bright_green = ']] .. t.success .. [['
bright_yellow = ']] .. t.warning .. [['
bright_blue = ']] .. t.accent .. [['
bright_magenta = ']] .. (t.magenta or t.purple or t.accent) .. [['
bright_cyan = ']] .. t.info .. [['
bright_white = ']] .. t.fg .. [['
]]

  local file = M.cache_dir .. "/alacritty.toml"
  local f = io.open(file, "w")
  if f then
    f:write(toml)
    f:close()
  end
  return file
end

-- Generate Rofi theme
function M.generate_rofi()
  local t = M.tokens
  local rasi = [[
/* Generated by AwesomeWM theme system - DO NOT EDIT MANUALLY */
/* Theme: ]] .. M.current_theme .. [[ | Accent: ]] .. M.current_accent .. [[ */

configuration {
  font: "Maple Mono NF Bold 10";
  show-icons: true;
  icon-theme: "Papirus-Dark";
}

* {
  /* Base surfaces */
  background: ]] .. t.bg .. [[;
  background-alt: ]] .. t.bg_alt .. [[;
  background-subtle: ]] .. t.bg_subtle .. [[;

  /* Content */
  foreground: ]] .. t.fg .. [[;
  foreground-muted: ]] .. t.fg_muted .. [[;
  foreground-subtle: ]] .. t.fg_subtle .. [[;

  /* Accent */
  accent: ]] .. t.accent .. [[;
  accent-fg: ]] .. t.accent_fg .. [[;
  accent-subtle: ]] .. t.accent_subtle .. [[;

  /* State */
  success: ]] .. t.success .. [[;
  warning: ]] .. t.warning .. [[;
  error: ]] .. t.error .. [[;
  info: ]] .. t.info .. [[;

  /* Borders */
  border: ]] .. t.border .. [[;
  border-focus: ]] .. t.border_focus .. [[;
  border-subtle: ]] .. t.border_subtle .. [[;

  /* Opacity */
  alpha-90: ]] .. t.alpha_90 .. [[;
  alpha-80: ]] .. t.alpha_80 .. [[;
  alpha-50: ]] .. t.alpha_50 .. [[;
  alpha-10: ]] .. t.alpha_10 .. [[;
}

/* Window */
window {
  background-color: @background;
  border: 2px solid @border;
  border-radius: 8px;
}

/* Main box */
mainbox {
  background-color: @background;
}

/* Input bar */
entry {
  background-color: @background-alt;
  text-color: @foreground;
  border: 1px solid @border;
  border-radius: 6px;
  padding: 8px;
}

entry:focus {
  border-color: @accent;
}

/* List view */
listview {
  background-color: @background;
  border: 0;
  margin: 4px;
  spacing: 2px;
}

element {
  background-color: transparent;
  text-color: @foreground;
  padding: 8px 12px;
  border-radius: 4px;
}

element:hover {
  background-color: @accent-subtle;
  text-color: @foreground;
}

element:selected {
  background-color: @accent;
  text-color: @accent-fg;
}

element:selected:highlight {
  background-color: @accent;
  text-color: @accent-fg;
}

/* Scrollbar */
scrollbar {
  background-color: @background-subtle;
  handle-color: @border;
  handle-width: 6px;
  border-radius: 3px;
}

scrollbar:hover {
  handle-color: @accent;
}

/* Message */
message {
  background-color: @background-alt;
  text-color: @foreground-muted;
  border: 1px solid @border;
  border-radius: 6px;
  padding: 8px;
}

/* Prompt */
prompt {
  background-color: @background-alt;
  text-color: @foreground;
}

/* Match highlighting */
matching {
  text-color: @accent;
  font-weight: bold;
}
]]

  local file = M.cache_dir .. "/theme.rasi"
  local f = io.open(file, "w")
  if f then
    f:write(rasi)
    f:close()
  end
  return file
end

-- Generate Picom config
function M.generate_picom()
  local t = M.tokens
  local conf = [[
# Generated by AwesomeWM theme system - DO NOT EDIT MANUALLY
# Theme: ]] .. M.current_theme .. [[ | Accent: ]] .. M.current_accent .. [[

backend = "glx";
vsync = true;

# Shadows
shadow = true;
shadow-radius = 12;
shadow-offset-x = 0;
shadow-offset-y = 4;
shadow-opacity = 0.3;
shadow-exclude = [
  "window_type == 'dock'",
  "window_type == 'desktop'",
  "_GTK_FRAME_EXTENTS@:c",
  "name = 'Notification'",
  "class_g = 'Conky'",
  "class_g = 'Klipper'",
  "class_g = 'nm-applet'",
  "_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'",
  "_NET_WM_STATE@:32a *= '_NET_WM_STATE_SKIP_TASKBAR'",
];

# Fading
fading = true;
fade-in-step = 0.03;
fade-out-step = 0.03;
fade-delta = 4;

# Window transparency
inactive-opacity = 1;
active-opacity = 1;
frame-opacity = 1;
inactive-opacity-override = false;

# Corners
corner-radius = 8;
rounded-corners-exclude = [
  "window_type == 'dock'",
  "window_type == 'desktop'",
];

# Blur (if supported)
blur-background = true;
blur-method = "dual_kawase";
blur-strength = 4;

# Focus
focus-exclude = [
  "class_g = 'Conky'",
  "class_g = 'Klipper'",
  "class_g = 'nm-applet'",
];

# VSync
glx-no-stencil = true;
glx-copy-from-front = false;
use-damage = true;
xrender-sync-fence = true;

# Colors (for window frame)
frame-opacity = 0.9;
]]

  local file = M.cache_dir .. "/picom.conf"
  local f = io.open(file, "w")
  if f then
    f:write(conf)
    f:close()
  end
  return file
end

-- Generate all external configs
function M.generate_all()
  M.generate_gtk()
  M.generate_alacritty()
  M.generate_rofi()
  M.generate_picom()
end

-- Cycle to next theme
function M.cycle_theme()
  for i, name in ipairs(M.theme_order) do
    if name == M.current_theme then
      local next_theme = M.theme_order[(i % #M.theme_order) + 1]
      return M.load_theme(next_theme)
    end
  end
  return M.load_theme(M.theme_order[1])
end

-- Cycle to next accent
function M.cycle_accent()
  local next_accent = accents.next(M.current_accent)
  return M.load_theme(M.current_theme, next_accent)
end

-- Get current theme info
function M.get_info()
  return {
    theme = M.current_theme,
    accent = M.current_accent,
    accent_name = accents.get(M.current_accent).name,
    tokens = M.tokens,
  }
end

-- Initialize on startup
function M.init()
  -- Load saved preference
  local state_file = gears.filesystem.get_cache_dir() .. "/theme_state"
  local f = io.open(state_file, "r")
  if f then
    local content = f:read("*a")
    f:close()
    local theme, accent = content:match("^(%S+)%s+(%S+)$")
    if theme and M.themes[theme] then
      M.load_theme(theme, accent or "blue")
      return
    end
  end

  -- Default
  M.load_theme("catppuccin-mocha", "blue")
end

-- Save theme state
function M.save_state()
  local state_file = gears.filesystem.get_cache_dir() .. "/theme_state"
  local f = io.open(state_file, "w")
  if f then
    f:write(M.current_theme .. " " .. M.current_accent)
    f:close()
  end
end

-- Call save on exit
awesome.connect_signal("exit", function()
  M.save_state()
end)

return M