-- themes/mocha/colors.lua — Catppuccin Mocha palette and semantic color mappings
-- Single source of truth. Symlink this file into any config that needs it:
--   ln -s ../../themes/mocha/colors.lua ~/.config/awesome/colors.lua
--   ln -s ../../themes/mocha/colors.lua ~/.config/gtk-3.0/colors.lua  (or use gen-gtk-colors.lua)

local M = {}

-- Catppuccin Mocha palette
M.mocha = {
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

local m = M.mocha

-- Semantic mappings
M.bg = m.base
M.bg_popup = m.base .. "ee"
M.bg_hover = m.surface0
M.bg_active = m.surface1
M.bg_selected = "#3b5998"

M.fg = m.text
M.fg_dim = m.subtext0
M.fg_muted = m.overlay0
M.fg_accent = m.blue

M.accent = m.blue
M.accent_hover = "#50d975"
M.accent_active = "#2a9d4f"

M.danger = m.red
M.danger_hover = "#d44a5e"
M.danger_active = "#a33b4e"

M.success = m.green
M.success_hover = "#50d975"
M.success_active = "#2a9d4f"

M.warning = m.yellow

M.border = m.surface0
M.border_focus = m.blue

M.surface0 = m.surface0
M.surface1 = m.surface1
M.surface2 = m.surface2

M.overlay0 = m.overlay0
M.overlay1 = m.overlay1
M.overlay2 = m.overlay2

M.transparent = "#00000000"

M.cursor = m.text
M.calendar_today = "#1e3a8a"
M.calendar_weekend = "#e06c8a"
M.calendar_other = "#5a9a5e"

return M
