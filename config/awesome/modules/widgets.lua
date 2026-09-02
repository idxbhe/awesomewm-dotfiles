-- modules/widgets.lua
-- All wibar widgets: CPU, RAM, Network, Clock, Volume, Layout
-- Returns creation functions and widget instances

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local beautiful = m.beautiful

local M = {}

-- {{{ Pill helpers
local function pill_widget(widget, bg, fg)
    return wibox.widget {
        {
            widget,
            left = m.pill_padding,
            right = m.pill_padding,
            top = 2,
            bottom = 2,
            widget = wibox.container.margin
        },
        bg = bg or m.pill_bg,
        fg = fg or m.pill_fg,
        forced_height = m.wibar_height - 4,
        shape = function(cr, w, h)
            gears.shape.rounded_rect(cr, w, h, m.border_radius)
        end,
        widget = wibox.container.background
    }
end

local function pill_text(text, bg, fg)
    return pill_widget(wibox.widget {
        markup = text,
        font = m.font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }, bg, fg)
end

local function pill_icon_text(icon_glyph, text_markup, bg, fg)
    local icon_tb = wibox.widget {
        text = icon_glyph,
        font = m.font_icon,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }
    local text_tb = wibox.widget {
        markup = text_markup,
        font = m.font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }
    local h_layout = wibox.layout.fixed.horizontal()
    h_layout:add(icon_tb)
    h_layout:add(text_tb)
    h_layout.spacing = 8
    return pill_widget(h_layout, bg, fg), icon_tb, text_tb, h_layout
end

M.pill_widget = pill_widget
M.pill_text = pill_text
M.pill_icon_text = pill_icon_text
-- }}}

-- {{{ CPU widget
M.cpu_widget, M.cpu_icon_tb, M.cpu_text_tb, M.cpu_layout = pill_icon_text(
    m.glyph.cpu, "%d%%", m.pill_bg, m.pill_fg
)
awful.widget.watch(
    "bash -c \"top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1\"",
    2,
    function(_, stdout)
        local cpu = math.floor(tonumber(stdout) or 0)
        M.cpu_text_tb.markup = string.format("%d%%", cpu)
    end
)
-- }}}

-- {{{ RAM widget
M.ram_widget, M.ram_icon_tb, M.ram_text_tb, M.ram_layout = pill_icon_text(
    m.glyph.ram, "%d%%", m.pill_bg, m.pill_fg
)
awful.widget.watch(
    "bash -c \"free | awk '/Mem:/ {printf \\\"%.0f\\\", $3/$2 * 100}'\"",
    2,
    function(_, stdout)
        local ram = math.floor(tonumber(stdout) or 0)
        M.ram_text_tb.markup = string.format("%d%%", ram)
    end
)
-- }}}

-- {{{ Network widget
M.net_widget, M.net_icon_tb, M.net_text_tb, M.net_layout = pill_icon_text(
    m.glyph.net_down, "%s", m.pill_bg, m.pill_fg
)
local last_rx, last_tx = 0, 0
awful.widget.watch(
    "bash -c \"cat /proc/net/dev | awk '/wlp|enp|eth/ {rx+=$2; tx+=$10} END {print rx, tx}'\"",
    1,
    function(_, stdout)
        local rx, tx = stdout:match("(%d+)%s+(%d+)")
        rx, tx = tonumber(rx) or 0, tonumber(tx) or 0
        if last_rx > 0 and last_tx > 0 then
            local down = (rx - last_rx) / 1024
            local down_str = down > 1024 and string.format("%.1fM", down/1024) or string.format("%.0fK", down)
            M.net_text_tb.markup = string.format("%s", down_str)
        end
        last_rx, last_tx = rx, tx
    end
)
-- }}}

-- {{{ Clock widget
M.clock_widget, M.clock_icon_tb, M.clock_text_tb, M.clock_layout = pill_icon_text(
    m.glyph.clock, "%H:%M", m.pill_bg, m.pill_fg
)
local clock_timer = gears.timer {
    timeout = 1,
    callback = function()
        M.clock_text_tb.markup = os.date("%H:%M")
    end,
}
clock_timer:start()
-- }}}

-- {{{ Layout widget
M.layout_widget = wibox.widget {
    {
        widget = wibox.widget.textbox,
        font = m.font_icon,
        align = "center",
        valign = "center",
    },
    left = m.pill_padding,
    right = m.pill_padding,
    top = 2,
    bottom = 2,
    widget = wibox.container.margin,
    forced_width = 24,
}
M.layout_widget.forced_height = m.wibar_height - 4
local layout_icon_tb = M.layout_widget.children[1]

local function update_layout_w()
    local s = awful.screen.focused()
    local layout = s.selected_tag and s.selected_tag.layout or awful.layout.suit.floating
    local name = layout.name or "floating"
    local icons = {
        floating = "FL", tile = "TL", tileleft = "TT", tilebottom = "TB",
        tiletop = "TR", fairv = "FV", fairh = "FH", spiral = "SP",
        dwindle = "DW", max = "MX", fullscreen = "FS", magnifier = "MG", cornernw = "NW"
    }
    layout_icon_tb:set_markup_silently(icons[name] or icons.floating)
end

awful.screen.connect_for_each_screen(function(s)
    s:connect_signal("tag::history::update", update_layout_w)
    s:connect_signal("tag::property::selected", update_layout_w)
end)
client.connect_signal("property::fullscreen", update_layout_w)
client.connect_signal("focus", update_layout_w)
update_layout_w()
-- }}}

-- {{{ Taglist with Arch icons (7 static tags)
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

function M.make_taglist(s)
    return awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = taglist_buttons,
        style = {
            spacing = 4,
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 10) end,
            bg_empty = "transparent",
            bg_occupied = beautiful.surface0,
            bg_focus = "#3b5998",
            fg_focus = beautiful.text,
            fg_occupied = beautiful.subtext1,
            fg_empty = "transparent",
            default = {
                shape = function() end,
            },
            focus = {
                shape = function() end,
            },
            urgent = {
                shape = function() end,
            },
        },
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                id = "text_role",
                font = m.font,
                align = "center",
                valign = "center",
                forced_width = 20,
                forced_height = 20,
                widget = wibox.widget.textbox
            },
            id = "background_role",
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 10) end,
            forced_width = 20,
            forced_height = 20,
            widget = wibox.container.background
        },
        create_callback = function(self, c3, index)
            self:get_children_by_id("text_role")[1]:set_text(tostring(index))
        end,
        update_callback = function(self, c3, index)
            self:get_children_by_id("text_role")[1]:set_text(tostring(index))
        end,
    }
end
-- }}}

-- {{{ Tasklist (circular app icons only, 28x28)
local tasklist_buttons = gears.table.join(
    awful.button({ }, 1, function(c)
        if c == client.focus then c.minimized = true
        else c:emit_signal("request::activate", "tasklist", {raise = true}) end
    end),
    awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
    awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

function M.make_tasklist(s)
    return awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style   = {
            bg_normal = beautiful.tasklist_bg_normal,
            bg_focus  = beautiful.tasklist_bg_focus,
            bg_urgent = beautiful.tasklist_bg_urgent,
            bg_minimize = beautiful.tasklist_bg_minimize,
            fg_normal = beautiful.tasklist_fg_normal,
            fg_focus  = beautiful.tasklist_fg_focus,
            fg_urgent = beautiful.tasklist_fg_urgent,
            fg_minimize = beautiful.tasklist_fg_minimize,
            shape = gears.shape.rectangle,
        },
        layout = {
            spacing = 4,
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id     = 'clienticon',
                        widget = awful.widget.clienticon,
                        forced_width = 16,
                        forced_height = 16,
                    },
                    halign = "center",
                    valign = "center",
                    widget = wibox.container.place,
                },
                margins = 2,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 28,
            forced_height   = 28,
            widget          = wibox.container.background,
            create_callback = function(self, c, index, objects)
                local icon = self:get_children_by_id('clienticon')[1]
                icon.client = c
            end,
            update_callback = function(self, c, index, objects)
                if c == client.focus then
                    self.bg = beautiful.tasklist_bg_focus
                else
                    self.bg = beautiful.tasklist_bg_normal
                end
            end,
        }
    }
end
-- }}}

return M
