-- themes/tokens.lua
-- Semantic color token definitions (single source of truth)
-- All themes map their palette colors to these semantic roles

local M = {}

-- Token role definitions with descriptions
M.roles = {
  -- Base surfaces (backgrounds)
  bg        = "Primary background (windows, wibar)",
  bg_alt    = "Secondary background (popups, cards, menus)",
  bg_subtle = "Subtle background (hover states, inactive items)",

  -- Content (foregrounds)
  fg        = "Primary text/content",
  fg_muted  = "Secondary text (labels, descriptions)",
  fg_subtle = "Disabled/placeholder text",

  -- Accent (dynamic - overridden by accent preset)
  accent         = "Primary brand color (focus, active, primary actions)",
  accent_fg      = "Text on accent backgrounds",
  accent_subtle  = "Accent with transparency (glow, selection)",

  -- State colors (semantic, not palette-specific)
  success   = "Success states, positive actions",
  warning   = "Warning states, caution",
  error     = "Error states, destructive actions",
  info      = "Informational states",

  -- Borders
  border        = "Default borders",
  border_focus  = "Focused/active borders",
  border_subtle = "Subtle dividers, separators",

  -- Widget-specific
  pill_bg       = "Pill widget background",
  pill_fg       = "Pill widget text",
  slider_track  = "Slider track background",
  slider_active = "Slider active fill",

  -- Transparency helpers (hex suffixes)
  alpha_90 = "ee",  -- 93%
  alpha_80 = "cc",  -- 80%
  alpha_50 = "80",  -- 50%
  alpha_10 = "1a",  -- 10%
  alpha_05 = "0d",  -- 5%
}

-- Default token values (fallback)
M.defaults = {
  bg        = "#181825",
  bg_alt    = "#1e1e2e",
  bg_subtle = "#313244",
  fg        = "#cdd6f4",
  fg_muted  = "#bac2de",
  fg_subtle = "#7f849c",
  accent         = "#89b4fa",
  accent_fg      = "#1e1e2e",
  accent_subtle  = "#89b4fa",
  success        = "#a6e3a1",
  warning        = "#f9e2af",
  error          = "#f38ba8",
  info           = "#74c7ec",
  border         = "#313244",
  border_focus   = "#89b4fa",
  border_subtle  = "#45475a",
  pill_bg        = "#313244",
  pill_fg        = "#cdd6f4",
  slider_track   = "#585b70",
  slider_active  = "#89b4fa",
  alpha_90 = "ee",
  alpha_80 = "cc",
  alpha_50 = "80",
  alpha_10 = "1a",
  alpha_05 = "0d",
}

-- Helper: apply alpha suffix to hex color
function M.with_alpha(hex, alpha)
  if not hex or not alpha then return hex end
  if hex:sub(1,1) == "#" then
    return hex .. alpha
  end
  return "#" .. hex .. alpha
end

-- Alpha constants (ensure they're in tokens)
M.alpha_90 = "ee"  -- 93%
M.alpha_80 = "cc"  -- 80%
M.alpha_50 = "80"  -- 50%
M.alpha_10 = "1a"  -- 10%
M.alpha_05 = "0d"  -- 5%

-- Helper: generate all derived tokens from base tokens
function M.derive(tokens)
  local t = {}
  for k, v in pairs(tokens) do
    t[k] = v
  end

  -- Derived tokens (computed from base)
  t.wibar_bg       = t.bg .. t.alpha_80
  t.popup_bg       = t.bg_alt .. t.alpha_90
  t.tooltip_bg     = t.bg_subtle
  t.titlebar_bg_normal = t.bg
  t.titlebar_bg_focus  = t.bg_subtle
  t.tasklist_bg_normal = t.bg_subtle .. t.alpha_50
  t.tasklist_bg_focus  = t.accent
  t.taglist_bg_focus   = t.bg_subtle
  t.taglist_bg_occupied = t.bg_subtle
  t.taglist_bg_empty   = t.bg .. t.alpha_05
  t.notification_bg    = t.bg
  t.menu_bg_normal     = t.bg
  t.menu_bg_focus      = t.bg_subtle
  t.snap_bg            = t.accent
  t.hotkeys_bg         = t.bg
  t.hotkeys_border_color = t.accent

  return t
end

return M