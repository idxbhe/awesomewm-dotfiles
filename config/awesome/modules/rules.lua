-- modules/rules.lua
-- Client rules

local m = require("modules")
local awful = m.awful
local beautiful = m.beautiful

-- Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = function(c)
                         -- Don't re-position restored clients on awesome restart
                         if not awesome.startup then
                             return awful.placement.centered(c)
                         end
                     end,
                     size_hints_honor = false,
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = { "DTA", "copyq", "pinentry" },
        class = { "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", "Sxiv", "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer" },
        name = { "Event Tester" },
        role = { "AlarmWindow", "ConfigManager", "pop-up" }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }}, properties = { titlebars_enabled = true }},
}
