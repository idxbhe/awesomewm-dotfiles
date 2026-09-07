-- themes/accents.lua
-- Dynamic accent presets - swap accent color without changing base theme

local M = {}

-- Accent presets: each defines accent, accent_fg, and derived colors
M.presets = {
  blue = {
    name = "Blue",
    accent        = "#89b4fa",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#89b4fa",
    blue          = "#89b4fa",
    blue_dark     = "#1e1e2e",
    border_focus  = "#89b4fa",
    slider_active = "#89b4fa",
    tasklist_bg_focus = "#89b4fa",
    snap_bg       = "#89b4fa",
    hotkeys_border_color = "#89b4fa",
  },
  green = {
    name = "Green",
    accent        = "#a6e3a1",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#a6e3a1",
    blue          = "#a6e3a1",
    blue_dark     = "#1e1e2e",
    border_focus  = "#a6e3a1",
    slider_active = "#a6e3a1",
    tasklist_bg_focus = "#a6e3a1",
    snap_bg       = "#a6e3a1",
    hotkeys_border_color = "#a6e3a1",
  },
  purple = {
    name = "Purple",
    accent        = "#cba6f7",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#cba6f7",
    blue          = "#cba6f7",
    blue_dark     = "#1e1e2e",
    border_focus  = "#cba6f7",
    slider_active = "#cba6f7",
    tasklist_bg_focus = "#cba6f7",
    snap_bg       = "#cba6f7",
    hotkeys_border_color = "#cba6f7",
  },
  pink = {
    name = "Pink",
    accent        = "#f5c2e7",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#f5c2e7",
    blue          = "#f5c2e7",
    blue_dark     = "#1e1e2e",
    border_focus  = "#f5c2e7",
    slider_active = "#f5c2e7",
    tasklist_bg_focus = "#f5c2e7",
    snap_bg       = "#f5c2e7",
    hotkeys_border_color = "#f5c2e7",
  },
  red = {
    name = "Red",
    accent        = "#f38ba8",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#f38ba8",
    blue          = "#f38ba8",
    blue_dark     = "#1e1e2e",
    border_focus  = "#f38ba8",
    slider_active = "#f38ba8",
    tasklist_bg_focus = "#f38ba8",
    snap_bg       = "#f38ba8",
    hotkeys_border_color = "#f38ba8",
  },
  orange = {
    name = "Orange",
    accent        = "#fab387",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#fab387",
    blue          = "#fab387",
    blue_dark     = "#1e1e2e",
    border_focus  = "#fab387",
    slider_active = "#fab387",
    tasklist_bg_focus = "#fab387",
    snap_bg       = "#fab387",
    hotkeys_border_color = "#fab387",
  },
  teal = {
    name = "Teal",
    accent        = "#94e2d5",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#94e2d5",
    blue          = "#94e2d5",
    blue_dark     = "#1e1e2e",
    border_focus  = "#94e2d5",
    slider_active = "#94e2d5",
    tasklist_bg_focus = "#94e2d5",
    snap_bg       = "#94e2d5",
    hotkeys_border_color = "#94e2d5",
  },
  yellow = {
    name = "Yellow",
    accent        = "#f9e2af",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#f9e2af",
    blue          = "#f9e2af",
    blue_dark     = "#1e1e2e",
    border_focus  = "#f9e2af",
    slider_active = "#f9e2af",
    tasklist_bg_focus = "#f9e2af",
    snap_bg       = "#f9e2af",
    hotkeys_border_color = "#f9e2af",
  },
  sapphire = {
    name = "Sapphire",
    accent        = "#74c7ec",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#74c7ec",
    blue          = "#74c7ec",
    blue_dark     = "#1e1e2e",
    border_focus  = "#74c7ec",
    slider_active = "#74c7ec",
    tasklist_bg_focus = "#74c7ec",
    snap_bg       = "#74c7ec",
    hotkeys_border_color = "#74c7ec",
  },
  mauve = {
    name = "Mauve",
    accent        = "#cba6f7",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#cba6f7",
    blue          = "#cba6f7",
    blue_dark     = "#1e1e2e",
    border_focus  = "#cba6f7",
    slider_active = "#cba6f7",
    tasklist_bg_focus = "#cba6f7",
    snap_bg       = "#cba6f7",
    hotkeys_border_color = "#cba6f7",
  },
  rosewater = {
    name = "Rosewater",
    accent        = "#f5e0dc",
    accent_fg     = "#1e1e2e",
    accent_subtle = "#f5e0dc",
    blue          = "#f5e0dc",
    blue_dark     = "#1e1e2e",
    border_focus  = "#f5e0dc",
    slider_active = "#f5e0dc",
    tasklist_bg_focus = "#f5e0dc",
    snap_bg       = "#f5e0dc",
    hotkeys_border_color = "#f5e0dc",
  },
}

-- Ordered list for cycling
M.order = {"blue", "green", "purple", "pink", "red", "orange", "teal", "yellow", "sapphire", "mauve", "rosewater"}

-- Get accent by name
function M.get(name)
  return M.presets[name] or M.presets.blue
end

-- Get next accent in cycle
function M.next(current)
  for i, name in ipairs(M.order) do
    if name == current then
      return M.order[(i % #M.order) + 1]
    end
  end
  return "blue"
end

-- Get previous accent in cycle
function M.prev(current)
  for i, name in ipairs(M.order) do
    if name == current then
      return M.order[(i - 2) % #M.order + 1]
    end
  end
  return "rosewater"
end

-- List all accent names
function M.list()
  local list = {}
  for _, name in ipairs(M.order) do
    local p = M.presets[name]
    table.insert(list, {id = name, name = p.name, color = p.accent})
  end
  return list
end

return M