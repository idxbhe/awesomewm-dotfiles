-- modules/theme_switcher.lua
-- Theme switching UI and keybindings

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local beautiful = m.beautiful
local naughty = m.naughty
local popup_registry = require("modules.popup_registry")
local theme_manager = require("themes.init")

local M = {}

-- Theme switcher popup
local switcher_popup = nil
local switcher_list = nil

local function create_theme_row(theme_id, theme_name, is_current)
  local bg = is_current and m.surface0 or "transparent"
  local fg = is_current and m.blue or m.fg

  local row = wibox.widget {
    {
      {
        markup = is_current and "● " or "○ ",
        font = m.font_icon,
        align = "center",
        valign = "center",
        forced_width = 24,
        widget = wibox.widget.textbox,
      },
      {
        markup = theme_name,
        font = m.font_popup,
        align = "left",
        valign = "center",
        widget = wibox.widget.textbox,
      },
      spacing = 8,
      layout = wibox.layout.fixed.horizontal,
    },
    bg = bg,
    fg = fg,
    forced_height = 36,
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
    widget = wibox.container.background,
  }

  row:connect_signal("mouse::enter", function()
    if not is_current then row.bg = m.surface1 end
  end)

  row:connect_signal("mouse::leave", function()
    row.bg = is_current and m.surface0 or "transparent"
  end)

  row:buttons(gears.table.join(
    awful.button({}, 1, function()
      theme_manager.load_theme(theme_id)
      M.show_switcher(true)  -- refresh
    end)
  ))

  return row
end

local function create_accent_row(accent_id, accent_info, is_current)
  local bg = is_current and m.surface0 or "transparent"
  local fg = is_current and m.blue or m.fg

  local color_box = wibox.widget {
    forced_width = 16,
    forced_height = 16,
    bg = accent_info.color,
    shape = gears.shape.circle,
    widget = wibox.container.background,
  }

  local row = wibox.widget {
    {
      color_box,
      {
        markup = accent_info.name,
        font = m.font_popup,
        align = "left",
        valign = "center",
        widget = wibox.widget.textbox,
      },
      spacing = 8,
      layout = wibox.layout.fixed.horizontal,
    },
    bg = bg,
    fg = fg,
    forced_height = 32,
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
    widget = wibox.container.background,
  }

  row:connect_signal("mouse::enter", function()
    if not is_current then row.bg = m.surface1 end
  end)

  row:connect_signal("mouse::leave", function()
    row.bg = is_current and m.surface0 or "transparent"
  end)

  row:buttons(gears.table.join(
    awful.button({}, 1, function()
      theme_manager.load_theme(theme_manager.current_theme, accent_id)
      M.show_switcher(true)  -- refresh
    end)
  ))

  return row
end

function M.show_switcher(refresh_only)
  if refresh_only and switcher_popup and switcher_popup.visible then
    M.rebuild_switcher()
    return
  end

  if switcher_popup and switcher_popup.visible then
    popup_registry.hide_popup(switcher_popup)
    switcher_popup = nil
    return
  end

  M.rebuild_switcher()

  local s = awful.screen.focused().geometry
  switcher_popup.x = s.x + s.width - 400
  switcher_popup.y = s.y + 30

  popup_registry.show_popup(switcher_popup)
end

function M.rebuild_switcher()
  local themes = {
    {id = "catppuccin-mocha", name = "Catppuccin Mocha"},
    {id = "tokyo-night", name = "Tokyo Night"},
  }

  local accents = theme_manager.accents.list()

  local list = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 4,
  }

  -- Theme section header
  list:add(wibox.widget {
    markup = "<b>Theme</b>",
    font = m.font_popup,
    align = "left",
    widget = wibox.widget.textbox,
  })

  for _, theme in ipairs(themes) do
    list:add(create_theme_row(theme.id, theme.name, theme.id == theme_manager.current_theme))
  end

  -- Separator
  list:add(wibox.widget {
    forced_height = 1,
    bg = m.border_subtle,
    widget = wibox.container.background,
  })

  -- Accent section header
  list:add(wibox.widget {
    markup = "<b>Accent Color</b>",
    font = m.font_popup,
    align = "left",
    widget = wibox.widget.textbox,
  })

  for _, accent in ipairs(accents) do
    list:add(create_accent_row(accent.id, accent, accent.id == theme_manager.current_accent))
  end

  local container = wibox.widget {
    list,
    margins = 12,
    widget = wibox.container.margin,
  }

  local popup_content = wibox.widget {
    container,
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
    widget = wibox.container.background,
  }

  if not switcher_popup then
    switcher_popup = awful.popup {
      widget = popup_content,
      minimum_width = 320,
      maximum_width = 320,
      ontop = true,
      visible = false,
    }
  else
    switcher_popup.widget = popup_content
  end
end

-- Keybindings
function M.setup_keys()
  local modkey = m.modkey
  local keys = gears.table.join(
    -- Cycle theme
    awful.key({ modkey, "Control" }, "t", function()
      theme_manager.cycle_theme()
      naughty.notify({
        title = "Theme",
        text = "Switched to " .. theme_manager.current_theme,
        timeout = 2,
      })
    end, {description = "cycle theme", group = "theme"}),

    -- Cycle accent
    awful.key({ modkey, "Control", "Shift" }, "t", function()
      theme_manager.cycle_accent()
      naughty.notify({
        title = "Accent",
        text = "Switched to " .. theme_manager.accents.get(theme_manager.current_accent).name,
        timeout = 2,
      })
    end, {description = "cycle accent color", group = "theme"}),

    -- Open theme switcher UI
    awful.key({ modkey }, "t", function()
      M.show_switcher()
    end, {description = "open theme switcher", group = "theme"})
  )

  -- Append to existing globalkeys
  root.keys(gears.table.join(root.keys() or {}, keys))
end

-- Initialize
function M.init()
  theme_manager.init()
  M.setup_keys()

  -- Listen for theme changes to refresh widgets
  awesome.connect_signal("theme::changed", function()
    -- Widgets should listen to this signal and update their colors
    -- This is handled in each widget module
  end)
end

return M