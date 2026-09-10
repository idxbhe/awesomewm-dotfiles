-- modules/settings.lua
-- Settings control panel: WiFi, Bluetooth, brightness

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Popup state tracking
local popup_entered = false

-- Helper functions
local icon_font_str = m.font_icon
local row_h = 24
local icon_w = row_h

local function make_icon_tb(icon_char)
    local inner_tb = wibox.widget {
        markup = icon_char,
        font = icon_font_str,
        widget = wibox.widget.textbox,
    }
    -- Nested align layouts for true geometric centering (from drawBox.lua pattern)
    local wrapper = wibox.widget {
        {
            nil,
            {
                nil,
                inner_tb,
                expand = "none",
                layout = wibox.layout.align.vertical,
            },
            expand = "none",
            layout = wibox.layout.align.horizontal,
        },
        forced_width = icon_w,
        forced_height = row_h,
        widget = wibox.container.background,
    }
    wrapper.inner = inner_tb
    return wrapper
end

local function make_row(icon, label, fnt)
    fnt = fnt or "Maple Mono NF Bold 10"

    local icon_tb = make_icon_tb(icon)
    local inner_label = wibox.widget {
        markup = label,
        font = fnt,
        widget = wibox.widget.textbox,
    }
    local label_container = wibox.widget {
        inner_label,
        forced_height = row_h,
        halign = "left",
        valign = "center",
        widget = wibox.container.place,
    }

    local left = wibox.widget {
        icon_tb,
        label_container,
        spacing = 8,
        layout = wibox.layout.fixed.horizontal,
    }

    -- Proxy for icon_widget - write to inner textbox
    local icon_proxy = {}
    function icon_proxy:set_text(new_icon)
        icon_tb.inner.markup = new_icon
    end

    -- Proxy for label_widget - write to inner textbox
    local label_proxy = {}
    setmetatable(label_proxy, {
        __newindex = function(self, key, value)
            if key == "markup" then
                inner_label.markup = value
            end
        end,
        __index = function(self, key)
            if key == "markup" then return inner_label.markup end
            return inner_label[key]
        end,
    })

    local right_slot = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 8,
    }

    local row = wibox.widget {
        left,
        nil,
        right_slot,
        layout = wibox.layout.align.horizontal,
        forced_height = row_h,
    }

    row.icon_widget = icon_proxy
    row.label_widget = label_proxy
    row.right_slot = right_slot
    return row
end

local function make_sep()
    return wibox.widget {
        forced_height = 1,
        bg = "#45475a",
        widget = wibox.container.background,
    }
end

local function make_toggle_button(icon_on, icon_off, initial_state, on_toggle)
    local state = initial_state

    local icon = wibox.widget {
        markup = state and string.format('<span font="icons 17" color="%s">%s</span>', m.blue, icon_on)
                               or string.format('<span font="icons 17">%s</span>', icon_off),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local btn = wibox.widget {
        icon,
        bg = nil,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        forced_width = 28,
        forced_height = 28,
        widget = wibox.container.background,
    }

    btn.icon = icon  -- Store icon on button for later access

    btn._enabled = state

    btn:connect_signal("mouse::enter", function(self)
        if self._enabled then
            self.bg = m.surface0
        else
            self.bg = m.surface0
        end
    end)

    btn:connect_signal("mouse::leave", function(self)
        self.bg = nil
    end)

    btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            state = not state
            btn._enabled = state
            icon.markup = state and string.format('<span font="icons 17" color="%s">%s</span>', m.blue, icon_on)
                                  or string.format('<span font="icons 17">%s</span>', icon_off)
            if on_toggle then on_toggle(state) end
        end)
    ))

    return btn, function() return state end, function(new_state)
        state = new_state
        btn._enabled = state
        icon.markup = state and string.format('<span font="icons 17" color="%s">%s</span>', m.blue, icon_on)
                              or string.format('<span font="icons 17">%s</span>', icon_off)
    end
end

-- Brightness slider
local bri_slider = wibox.widget {
    widget = wibox.widget.slider,
    value = 50,
    maximum = 100,
    forced_width = 180,
    bar_color = "#585b70",
    bar_active_color = "#f9e2af",
    bar_shape = gears.shape.rounded_bar,
    bar_margins = { bottom = 10, top = 10 },
    handle_width = 10,
    handle_color = "#cdd6f4",
    handle_shape = gears.shape.circle,
    handle_border_width = 2,
    handle_border_color = "#45475a",
}
local bri_text = wibox.widget {
    markup = string.format('<span font="%s">50%%</span>', m.font),
    forced_width = 40,
    align = "center",
    widget = wibox.widget.textbox,
}
bri_slider:connect_signal("property::value", function(self)
    local val = self.value
    if val then
        bri_text.markup = string.format('<span font="%s">%d%%</span>', m.font, math.floor(val))
        awful.spawn("brightnessctl set " .. math.floor(val) .. "%", false)
    end
end)

-- WiFi section
local wifi_refresh = wibox.widget {
    text = "",
    font = m.font,
    visible = false,
    align = "center",
    valign = "center",
    forced_width = 20,
    widget = wibox.widget.textbox,
}

local wifi_btn, wifi_get_state, wifi_set_state = make_toggle_button(
    m.glyph.toggle_on, m.glyph.toggle_off, false, nil
)
local wifi_row = make_row(m.glyph.wifi_off, "Wi-Fi", m.font_popup)
wifi_row.right_slot:add(wifi_refresh)
wifi_row.right_slot:add(wifi_btn)

-- Now set up the callback after wifi_row exists
wifi_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
wifi_btn._enabled = false
wifi_btn:connect_signal("mouse::enter", function(self)
    self.bg = m.surface0
end)
wifi_btn:connect_signal("mouse::leave", function(self)
    self.bg = nil
end)
wifi_btn:buttons(gears.table.join(
    awful.button({}, 1, function()
        local new_state = not wifi_btn._enabled
        wifi_btn._enabled = new_state
        if new_state then
            awful.spawn("nmcli radio wifi on")
            wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
            wifi_row.icon_widget:set_text(m.glyph.wifi_on)
            set_wifi_visible(true)
            awful.spawn.easy_async("nmcli device wifi rescan", function() refresh_wifi() end)
            wifi_btn.icon.markup = string.format('<span font="icons 17" color="%s">%s</span>', m.blue, m.glyph.toggle_on)
        else
            awful.spawn("nmcli radio wifi off")
            wifi_row.label_widget.markup = "<span foreground='#a6adc8'>Wi-Fi</span>"
            wifi_row.icon_widget:set_text(m.glyph.wifi_off)
            set_wifi_visible(false)
            wifi_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
        end
    end)
))

local wifi_list_layout = wibox.widget {
    layout = wibox.layout.fixed.vertical,
}
local wifi_list_pad = wibox.widget {
    wifi_list_layout,
    left = 14, right = 8, bottom = 4,
    widget = wibox.container.margin,
}
wifi_list_pad.visible = false
local wifi_sep = make_sep()
wifi_sep.visible = false

-- set_wifi_visible function (must be after wifi_sep, wifi_list_pad, wifi_refresh are defined)
local function set_wifi_visible(on)
    wifi_sep.visible = on
    wifi_list_pad.visible = on
    wifi_refresh.visible = on
end

local function connect_to(ssid)
    m.naughty.notify({ text = "Connecting to " .. ssid .. "...", timeout = 3 })
    awful.spawn.easy_async_with_shell(
        "nmcli dev wifi connect '" .. ssid:gsub("'", "'\\''") .. "'",
        function(stdout, stderr, exit_reason, exit_code)
            if exit_code == 0 then
                m.naughty.notify({ text = "Connected to " .. ssid, timeout = 3 })
            else
                local pass_popup
                local pass_tb = wibox.widget.textbox()
                pass_tb.font = m.font_popup
                pass_tb.align = "left"
                pass_tb.valign = "center"
                pass_tb.forced_width = 240
                
                local function close_popup()
                    if pass_popup then
                        awful.keygrabber.stop()
                        pass_popup.visible = false
                        pass_popup = nil
                    end
                end
                
                pass_popup = awful.popup {
                    widget = wibox.widget {
                        {
                            {
                                markup = "<b>Password for " .. ssid .. "</b>",
                                font = m.font_popup,
                                widget = wibox.widget.textbox,
                            },
                            {
                                pass_tb,
                                forced_height = 28,
                                bg = "#313244",
                                shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
                                widget = wibox.container.background,
                            },
                            spacing = 8,
                            layout = wibox.layout.fixed.vertical,
                        },
                        margins = 12,
                        widget = wibox.container.margin,
                    },
                    bg = "#1e1e2eee",
                    border_width = 1,
                    border_color = "#313244",
                    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
                    ontop = true,
                    visible = true,
                }
                
                local s = awful.screen.focused().geometry
                pass_popup.x = s.x + s.width / 2 - 150
                pass_popup.y = s.y + s.height / 2 - 60
                
                awful.prompt.run {
                    prompt = "",
                    textbox = pass_tb,
                    bg_cursor = "#cdd6f4",
                    exe_callback = function(pass)
                        close_popup()
                        if pass and pass ~= "" then
                            awful.spawn.easy_async_with_shell(
                                "nmcli dev wifi connect '" .. ssid:gsub("'", "'\\''") .. "' password '" .. pass:gsub("'", "'\\''") .. "'",
                                function(o, e, r, c)
                                    if c == 0 then
                                        m.naughty.notify({ text = "Connected to " .. ssid, timeout = 3 })
                                    else
                                        m.naughty.notify({ text = "Failed: wrong password?", timeout = 4 })
                                    end
                                end
                            )
                        end
                    end,
                    done_callback = function()
                        close_popup()
                    end,
                }
            end
        end
    )
end

local wifi_spinner = wibox.widget.textbox()
wifi_spinner.font = m.font
local spin_frame = 0
local spin_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spin_timer = gears.timer {
    timeout = 0.2,
    call_now = false,
    callback = function()
        spin_frame = (spin_frame % #spin_frames) + 1
        wifi_spinner.markup = "<span foreground='#89b4fa'>" .. spin_frames[spin_frame] .. "</span> <i>Scanning...</i>"
    end,
}

local function refresh_wifi()
    spin_timer:stop()
    spin_frame = 0
    wifi_list_layout:reset()
    wifi_list_layout:add(wifi_spinner)
    wifi_spinner.markup = "<span foreground='#89b4fa'>⠋</span> <i>Scanning...</i>"
    spin_timer:start()
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f ACTIVE,SIGNAL,SSID dev wifi list 2>/dev/null | head -8",
        function(stdout)
            spin_timer:stop()
            local rows = {}
            for line in stdout:gmatch("[^\n]+") do
                local active, signal, ssid = line:match("^(yes):(%d+):(.*)$")
                if not active then
                    local sig, name = line:match("^no:(%d+):(.*)$")
                    if name and name ~= "" then
                        rows[#rows+1] = { ssid = name, signal = tonumber(sig) or 0, active = false }
                    end
                else
                    table.insert(rows, 1, { ssid = ssid, signal = tonumber(signal) or 0, active = true })
                end
            end

            wifi_list_layout:reset()
            if #rows == 0 then
                wifi_list_layout:add(wibox.widget {
                    markup = "<i>No networks found</i>",
                    font = m.font,
                    widget = wibox.widget.textbox,
                })
                return
            end

            for _, net in ipairs(rows) do
                local label = string.format("%s %s (%d%%)", net.active and "●" or "○", net.ssid, net.signal)
                local row_w = wibox.widget {
                    markup = net.active and ("<b>" .. label .. "</b>"):gsub("●", '<span foreground="#a6e3a1">●</span>') or label,
                    font = m.font,
                    align = "left",
                    widget = wibox.widget.textbox,
                }
                row_w:buttons(gears.table.join(
                    awful.button({ }, 1, function()
                        if not net.active then connect_to(net.ssid) end
                    end)
                ))
                wifi_list_layout:add(row_w)
            end
        end
    )
end

wifi_refresh:buttons(gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn.easy_async("nmcli device wifi rescan", function() refresh_wifi() end)
    end)
))

-- Bluetooth section
local bt_btn, bt_get_state, bt_set_state = make_toggle_button(
    m.glyph.toggle_on, m.glyph.toggle_off, false, nil
)
local bt_row = make_row(m.glyph.bt_off, "Bluetooth", m.font_popup)
bt_row.right_slot:add(bt_btn)

-- Set up Bluetooth callback after row exists
bt_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
bt_btn._enabled = false
bt_btn:connect_signal("mouse::enter", function(self)
    self.bg = m.surface0
end)
bt_btn:connect_signal("mouse::leave", function(self)
    self.bg = nil
end)
bt_btn:buttons(gears.table.join(
    awful.button({}, 1, function()
        local new_state = not bt_btn._enabled
        bt_btn._enabled = new_state
        if new_state then
            awful.spawn("rfkill unblock bluetooth")
            bt_row.label_widget.markup = "<b>Bluetooth</b>"
            bt_row.icon_widget:set_text(m.glyph.bt_on)
            bt_btn.icon.markup = string.format('<span font="icons 17" color="%s">%s</span>', m.blue, m.glyph.toggle_on)
        else
            awful.spawn("rfkill block bluetooth")
            bt_row.label_widget.markup = "<span foreground='#a6adc8'>Bluetooth</span>"
            bt_row.icon_widget:set_text(m.glyph.bt_off)
            bt_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
        end
    end)
))

-- Airplane mode toggle
local ap_btn, ap_get_state, ap_set_state = make_toggle_button(
    m.glyph.toggle_on, m.glyph.toggle_off, false, nil
)
local ap_row = make_row(m.glyph.airplane_off, "Airplane Mode", m.font_popup)
ap_row.right_slot:add(ap_btn)

-- Set up Airplane callback after row exists
ap_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
ap_btn._enabled = false
ap_btn:connect_signal("mouse::enter", function(self)
    self.bg = m.surface0
end)
ap_btn:connect_signal("mouse::leave", function(self)
    self.bg = nil
end)
ap_btn:buttons(gears.table.join(
    awful.button({}, 1, function()
        local new_state = not ap_btn._enabled
        ap_btn._enabled = new_state
        if new_state then
            awful.spawn("rfkill block all")
            ap_btn.icon.markup = string.format('<span font="icons 17" color="%s">%s</span>', m.blue, m.glyph.toggle_on)
            ap_row.label_widget.markup = "<span foreground='#a6adc8'>Airplane Mode</span>"
            ap_row.icon_widget:set_text(m.glyph.airplane_on)
            wifi_set_state(false)
            bt_btn._enabled = false
            bt_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
        else
            awful.spawn("rfkill unblock all")
            ap_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
            ap_row.label_widget.markup = "<b>Airplane Mode</b>"
            ap_row.icon_widget:set_text(m.glyph.airplane_off)
            wifi_set_state(true)
            bt_btn._enabled = true
            bt_btn.icon.markup = string.format('<span font="icons 17" color="%s">%s</span>', m.blue, m.glyph.toggle_on)
            awful.spawn.easy_async("nmcli device wifi rescan", function() refresh_wifi() end)
        end
    end)
))

-- Picom config path
local picom_conf_path = os.getenv("HOME") .. "/.config/picom/picom.conf"

-- Helper: read picom config value
local function read_picom_value(key)
    local f = io.open(picom_conf_path, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    local key_pat = key:gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
    if key == "blur-method" then
        local method = content:match("blur:%s*{%s*method%s*=%s*\"([^\"]+)\"")
        return method
    end
    local val = content:match(key_pat .. "%s*=%s*(.-)%s*;")
    return val
end

-- Helper: write picom config value
local function write_picom_value(key, value)
    local f = io.open(picom_conf_path, "r")
    if not f then return end
    local content = f:read("*a")
    f:close()
    local key_pat = key:gsub("([%-%.%+%[%]%(%)%$%^%%%?%*])", "%%%1")
    if key == "blur-method" then
        if value == "none" then
            content = content:gsub('(blur:%s*{%s*method%s*=%s*")([^"]+)(")', '%1none%3')
        else
            content = content:gsub('(blur:%s*{%s*method%s*=%s*")([^"]+)(")', '%1' .. value .. '%3')
        end
    elseif key == "opacity-rule" then
        -- value is "95" or "100" - replace both Alacritty and Thunar entries
        content = content:gsub('(")%d+:class_g = \'Alacritty\'(")', '%1' .. value .. ':class_g = \'Alacritty\'%2')
        content = content:gsub('(")%d+:class_g = \'Thunar\'(")', '%1' .. value .. ':class_g = \'Thunar\'%2')
    else
        local new_line = key .. " = " .. value .. ";"
        if content:match(key_pat .. "%s*=") then
            content = content:gsub(key_pat .. "%s*=.-;", new_line)
        else
            content = content .. "\n" .. new_line
        end
    end
    f = io.open(picom_conf_path, "w")
    if f then f:write(content); f:close() end
    awful.spawn("killall picom 2>/dev/null; sleep 0.2; picom --config " .. picom_conf_path .. " --daemon 2>/dev/null")
end

-- Helper: write alacritty opacity
local function write_alacritty_opacity(value)
    local alacritty_conf = os.getenv("HOME") .. "/.config/alacritty/alacritty.toml"
    local f = io.open(alacritty_conf, "r")
    if not f then return end
    local content = f:read("*a")
    f:close()
    content = content:gsub("opacity%s*=%s*[%d%.]+", "opacity = " .. value)
    f = io.open(alacritty_conf, "w")
    if f then f:write(content); f:close() end
    -- Alacritty live reloads config automatically
end

-- Picom settings toggle buttons
local picom_animation_btn, picom_animation_get, picom_animation_set = make_toggle_button(
    m.glyph.toggle_on, m.glyph.toggle_off, true, function(new_state)
        write_picom_value("fading", new_state and "true" or "false")
    end
)
local picom_shadow_btn, picom_shadow_get, picom_shadow_set = make_toggle_button(
    m.glyph.toggle_on, m.glyph.toggle_off, true, function(new_state)
        write_picom_value("shadow", new_state and "true" or "false")
    end
)
local picom_blur_btn, picom_blur_get, picom_blur_set = make_toggle_button(
    m.glyph.toggle_on, m.glyph.toggle_off, true, function(new_state)
        write_picom_value("blur-method", new_state and "gaussian" or "none")
    end
)

-- Transparency input (1-100%, where 100 = opaque, 1 = nearly transparent)
local transparency_input = wibox.widget {
    widget = wibox.widget.textbox,
    text = "100",
    forced_width = 50,
    align = "center",
    font = m.font,
}
local transparency_text = wibox.widget {
    markup = string.format('<span font="%s">%%</span>', m.font),
    forced_width = 20,
    align = "center",
    widget = wibox.widget.textbox,
}

-- Make input container clickable
local transparency_container = wibox.widget {
    {
        transparency_input,
        transparency_text,
        spacing = 2,
        layout = wibox.layout.fixed.horizontal,
    },
    bg = m.surface0,
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
    widget = wibox.container.background,
}

-- Helper: apply transparency value (1-100)
local function apply_transparency(val)
    val = math.max(1, math.min(100, math.floor(val)))
    local opacity = val / 100  -- 0.01 to 1.0
    local opacity_str = string.format("%.2f", opacity)
    local rule_val = val
    write_picom_value("inactive-opacity", opacity_str)
    write_picom_value("active-opacity", opacity_str)
    write_picom_value("inactive-opacity-override", val < 100 and "true" or "false")
    write_picom_value("opacity-rule", tostring(rule_val))
    write_alacritty_opacity(opacity_str)
    transparency_input.text = tostring(val)
end

-- Transparency input state
local transparency_editing = false

transparency_container:connect_signal("button::press", function(self, _, _, button)
    if button == 1 and not transparency_editing then
        transparency_editing = true

        -- Store current value
        local current_val = transparency_input.text

        -- Show prompt in the textbox
        transparency_input.text = ""
        transparency_input.markup = '<span font="' .. m.font .. '" color="' .. m.surface0 .. '">1-100</span>'

        -- Use awful.prompt.run for proper input handling with auto-cleanup
        awful.prompt.run {
            prompt = "",
            textbox = transparency_input,
            exe_callback = function(input)
                local val = tonumber(input)
                if val then
                    apply_transparency(val)
                else
                    transparency_input.text = current_val
                end
                transparency_editing = false
                transparency_container.bg = m.surface0
            end,
            done_callback = function()
                -- Called when prompt finishes (Enter, Escape, or focus loss)
                if transparency_editing then
                    transparency_editing = false
                    transparency_container.bg = m.surface0
                end
            end,
            history_path = gears.filesystem.get_cache_dir() .. "/transparency_history",
        }
    end
end)

transparency_container:connect_signal("mouse::enter", function(self) self.bg = m.surface1 end)
transparency_container:connect_signal("mouse::leave", function(self) self.bg = m.surface0 end)

-- Initialize transparency from config
local function init_transparency()
    local inactive_opacity = read_picom_value("inactive-opacity")
    if inactive_opacity then
        local val = math.floor(tonumber(inactive_opacity) * 100 + 0.5)
        apply_transparency(math.max(1, val))
    end
end

-- Titlebar toggle
local function toggle_titlebar(on)
    _G._titlebar_hidden = not on
    for _, c in ipairs(client.get()) do
        if c.type == "normal" or c.type == "dialog" then
            if on then
                awful.titlebar.show(c)
            else
                awful.titlebar.hide(c)
            end
        end
    end
end

local titlebar_btn, titlebar_get_state, titlebar_set_state = make_toggle_button(
    m.glyph.toggle_on, m.glyph.toggle_off, true, function(new_state)
        toggle_titlebar(new_state)
    end
)

-- Initialize picom toggle states from config
local function init_picom_toggles()
    local fading = read_picom_value("fading")
    if fading then
        local state = fading:match("true")
        picom_animation_set(state)
    end
    local shadow = read_picom_value("shadow")
    if shadow then
        local state = shadow:match("true")
        picom_shadow_set(state)
    end
    local blur_method = read_picom_value("blur-method")
    if blur_method then
        local state = blur_method ~= "none"
        picom_blur_set(state)
    end
end

-- Initialize titlebar toggle state
if _G._titlebar_hidden == nil then
    _G._titlebar_hidden = false
end
titlebar_btn._enabled = not _G._titlebar_hidden
if _G._titlebar_hidden then
    titlebar_btn.icon.markup = string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off)
end

-- Initialize picom toggle states from config
init_picom_toggles()
init_transparency()

local function make_tab_content()
    return wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = 4,
    }
end

-- Helper: add widget to tab content
local function add_to_tab(tab, content)
    local widget
    if type(content) == "table" and content.layout then
        widget = wibox.widget(content)
    else
        widget = content
    end
    tab:add(widget)
end

-- ============================================================================
-- Settings Popup with Arrow Navigation
-- ============================================================================

-- Tab contents (pages)
local content_network = make_tab_content()
local content_display = make_tab_content()
local content_themes = make_tab_content()

-- Page contents (each page is a vertical layout)
local page_network = content_network
local page_display = content_display
local page_themes = content_themes

local pages = {page_network, page_display, page_themes}
local page_names = {"Network", "Display", "Themes"}
local current_page = 1

-- Arrow buttons
local arrow_left = wibox.widget {
    markup = m.glyph.chevron_left or "‹",
    font = m.font_icon,
    align = "center",
    valign = "center",
    forced_width = 28,
    forced_height = 28,
    widget = wibox.widget.textbox,
}

local arrow_right = wibox.widget {
    markup = m.glyph.chevron_right or "›",
    font = m.font_icon,
    align = "center",
    valign = "center",
    forced_width = 28,
    forced_height = 28,
    widget = wibox.widget.textbox,
}

-- Page title (boxed like alarm tone selector)
local page_title = wibox.widget {
    {
        markup = "<b>" .. page_names[1] .. "</b>",
        font = m.font_popup,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    forced_width = 200,
    forced_height = 28,
    widget = wibox.container.background,
}

-- Navigate to page
local function go_to_page(idx)
    if idx < 1 or idx > #pages then return end
    current_page = idx
    for i, page in ipairs(pages) do
        page.visible = (i == idx)
    end
    page_title.widget.markup = "<b>" .. page_names[idx] .. "</b>"
end

local function next_page() go_to_page(current_page + 1) end
local function prev_page() go_to_page(current_page - 1) end

-- Arrow button signals
arrow_left:connect_signal("mouse::enter", function(self) self.bg = m.surface0 end)
arrow_left:connect_signal("mouse::leave", function(self) self.bg = nil end)
arrow_left:buttons(gears.table.join(awful.button({}, 1, prev_page)))

arrow_right:connect_signal("mouse::enter", function(self) self.bg = m.surface0 end)
arrow_right:connect_signal("mouse::leave", function(self) self.bg = nil end)
arrow_right:buttons(gears.table.join(awful.button({}, 1, next_page)))

-- Navigation bar
local nav_bar = wibox.widget {
    {
        arrow_left,
        page_title,
        arrow_right,
        spacing = 8,
        layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.place,
}

-- Network tab content
add_to_tab(content_network, {
    wifi_row,
    wifi_sep,
    wifi_list_pad,
    bt_row,
    { forced_height = 6, widget = wibox.container.background },
    ap_row,
    layout = wibox.layout.fixed.vertical,
})

-- Display tab content (picom settings)
add_to_tab(content_display, {
    { -- Brightness row
        make_icon_tb(m.glyph.brightness),
        bri_slider,
        bri_text,
        spacing = 8,
        forced_height = row_h,
        layout = wibox.layout.fixed.horizontal,
    },
    { forced_height = 6, widget = wibox.container.background },
    make_sep(),
    -- Picom settings
    (function()
        local row = make_row(m.glyph.settings_display_animation or m.glyph.animation or "", "Animation", m.font_popup)
        row.right_slot:add(picom_animation_btn)
        return row
    end)(),
    (function()
        local row = make_row(m.glyph.settings_display_transparency or m.glyph.transparent or "", "Transparent", m.font_popup)
        row.right_slot:add(transparency_container)
        return row
    end)(),
    (function()
        local row = make_row(m.glyph.settings_display_shadow or m.glyph.shadow or "", "Shadow", m.font_popup)
        row.right_slot:add(picom_shadow_btn)
        return row
    end)(),
    (function()
        local row = make_row(m.glyph.settings_display_blur or m.glyph.blur or "", "Blur", m.font_popup)
        row.right_slot:add(picom_blur_btn)
        return row
    end)(),
    (function()
        local row = make_row(m.glyph.settings_display_titlebar or "", "Titlebar", m.font_popup)
        row.right_slot:add(titlebar_btn)
        return row
    end)(),
    layout = wibox.layout.fixed.vertical,
})

-- Themes tab content (theme switcher with arrows + accent picker)
local theme_name_display = wibox.widget {
    {
        markup = "<b>Mocha</b>",
        font = m.font_popup,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    forced_width = 50,
    forced_height = 22,
    widget = wibox.container.background,
}

local theme_left_arrow = wibox.widget {
    markup = m.glyph.chevron_left or "‹",
    font = m.font_icon,
    align = "center",
    valign = "center",
    forced_width = 28,
    forced_height = 28,
    widget = wibox.widget.textbox,
}

local theme_right_arrow = wibox.widget {
    markup = m.glyph.chevron_right or "›",
    font = m.font_icon,
    align = "center",
    valign = "center",
    forced_width = 28,
    forced_height = 28,
    widget = wibox.widget.textbox,
}

-- Theme cycling
local theme_order = {"Mocha", "Tokyo"}
local theme_keys = {"catppuccin-mocha", "tokyo-night"}
local current_theme_idx = 1

local function cycle_theme_left()
    current_theme_idx = (current_theme_idx - 2) % #theme_order + 1
    local key = theme_keys[current_theme_idx]
    m.theme.load_theme(key)
    theme_name_display.widget.markup = "<b>" .. theme_order[current_theme_idx] .. "</b>"
end

local function cycle_theme_right()
    current_theme_idx = current_theme_idx % #theme_order + 1
    local key = theme_keys[current_theme_idx]
    m.theme.load_theme(key)
    theme_name_display.widget.markup = "<b>" .. theme_order[current_theme_idx] .. "</b>"
end

theme_left_arrow:connect_signal("mouse::enter", function(self) self.bg = m.surface0 end)
theme_left_arrow:connect_signal("mouse::leave", function(self) self.bg = nil end)
theme_left_arrow:buttons(gears.table.join(awful.button({}, 1, cycle_theme_left)))

theme_right_arrow:connect_signal("mouse::enter", function(self) self.bg = m.surface0 end)
theme_right_arrow:connect_signal("mouse::leave", function(self) self.bg = nil end)
theme_right_arrow:buttons(gears.table.join(awful.button({}, 1, cycle_theme_right)))

-- Accent color display
local accent_name_display = wibox.widget {
    {
        markup = "<b>Blue</b>",
        font = m.font_popup,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    },
    forced_width = 50,
    forced_height = 22,
    widget = wibox.container.background,
}

local accent_left_arrow = wibox.widget {
    markup = m.glyph.chevron_left or "‹",
    font = m.font_icon,
    align = "center",
    valign = "center",
    forced_width = 28,
    forced_height = 28,
    widget = wibox.widget.textbox,
}

local accent_right_arrow = wibox.widget {
    markup = m.glyph.chevron_right or "›",
    font = m.font_icon,
    align = "center",
    valign = "center",
    forced_width = 28,
    forced_height = 28,
    widget = wibox.widget.textbox,
}

-- Accent cycling
local accent_order = {"blue", "purple", "pink", "red", "peach", "yellow", "green", "teal", "mauve", "rosewater", "flamingo"}
local accent_names = {"Blue", "Purple", "Pink", "Red", "Peach", "Yellow", "Green", "Teal", "Mauve", "Rosewater", "Flamingo"}
local current_accent_idx = 1

local function cycle_accent_left()
    current_accent_idx = (current_accent_idx - 2) % #accent_order + 1
    local key = accent_order[current_accent_idx]
    m.theme.load_theme(m.theme.current_theme, key)
    accent_name_display.widget.markup = "<b>" .. accent_names[current_accent_idx] .. "</b>"
end

local function cycle_accent_right()
    current_accent_idx = current_accent_idx % #accent_order + 1
    local key = accent_order[current_accent_idx]
    m.theme.load_theme(m.theme.current_theme, key)
    accent_name_display.widget.markup = "<b>" .. accent_names[current_accent_idx] .. "</b>"
end

accent_left_arrow:connect_signal("mouse::enter", function(self) self.bg = m.surface0 end)
accent_left_arrow:connect_signal("mouse::leave", function(self) self.bg = nil end)
accent_left_arrow:buttons(gears.table.join(awful.button({}, 1, cycle_accent_left)))

accent_right_arrow:connect_signal("mouse::enter", function(self) self.bg = m.surface0 end)
accent_right_arrow:connect_signal("mouse::leave", function(self) self.bg = nil end)
accent_right_arrow:buttons(gears.table.join(awful.button({}, 1, cycle_accent_right)))

add_to_tab(content_themes, {
    -- Theme row
    (function()
        local row = make_row(m.glyph.settings_themes_theme or m.glyph.settings or "", "Theme", m.font_popup)
        row.label_widget.markup = "<b>Theme</b>"
        row.right_slot.spacing = 2
        row.right_slot:add(theme_left_arrow)
        row.right_slot:add(theme_name_display)
        row.right_slot:add(theme_right_arrow)
        return row
    end)(),
    {
        forced_height = 6,
        widget = wibox.container.background,
    },
    -- Accent row
    (function()
        local row = make_row(m.glyph.settings_themes_accent or m.glyph.settings or "", "Accent", m.font_popup)
        row.label_widget.markup = "<b>Accent</b>"
        row.right_slot.spacing = 2
        row.right_slot:add(accent_left_arrow)
        row.right_slot:add(accent_name_display)
        row.right_slot:add(accent_right_arrow)
        return row
    end)(),
    layout = wibox.layout.fixed.vertical,
})

-- Content stack
local content_stack = wibox.widget {
    content_network,
    content_display,
    content_themes,
    layout = wibox.layout.stack,
}

-- Settings popup
local set_popup = awful.popup {
    widget = wibox.widget {
        {
            nav_bar,
            { forced_height = 8, widget = wibox.container.background },
            content_stack,
            layout = wibox.layout.fixed.vertical,
        },
        margins = 12,
        widget = wibox.container.margin,
    },
    minimum_width = 280,
    maximum_width = 280,
    bg = m.bg_alt or "#1e1e2eee",
    border_width = 1,
    border_color = m.border or "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
    ontop = true,
    visible = false,
}

-- Update popup bg on theme change
awesome.connect_signal("theme::changed", function()
    set_popup.bg = m.bg_alt or "#1e1e2eee"
    set_popup.border_color = m.border or "#313244"
end)

-- Init states
awful.spawn.easy_async_with_shell(
    "nmcli radio wifi; rfkill list bluetooth 2>/dev/null | grep -o 'blocked: yes'; brightnessctl g 2>/dev/null; brightnessctl m 2>/dev/null",
    function(stdout)
        local wifi_on = stdout:match("enabled") ~= nil
        wifi_set_state(wifi_on)
        if wifi_on then
            wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
            wifi_row.icon_widget:set_text(m.glyph.wifi_on)
        end

        local vals = {}
        for v in stdout:gmatch("%d+") do vals[#vals+1] = tonumber(v) end
        local bri_cur, bri_max
        if #vals >= 2 then bri_cur, bri_max = vals[#vals-1], vals[#vals] end
        if bri_cur and bri_max and bri_max > 0 then
            local pct = math.floor(bri_cur / bri_max * 100)
            bri_slider.value = pct
            bri_text.markup = pct .. "%"
        end

        local bt_blocked = stdout:find("blocked: yes") ~= nil
        bt_set_state(not bt_blocked)
    end
)

-- Settings button
local set_widget = wibox.widget.textbox()
set_widget.font = m.font_icon
set_widget.align = "center"
set_widget.valign = "center"
set_widget.forced_width = 24
set_widget:set_markup_silently(m.glyph.settings)

set_widget:buttons(gears.table.join(
    awful.button({ }, 1, function()
        popup_entered = false
        if set_popup.visible then
            popup_registry.hide_popup(set_popup)
            set_wifi_visible(false)
        else
            popup_registry.show_popup(set_popup)
            go_to_page(1) -- ensure only first page visible on open
            local s = awful.screen.focused().geometry
            set_popup.x = s.x + s.width - 340
            set_popup.y = s.y + 30
            awful.spawn.easy_async_with_shell("nmcli radio wifi", function(stdout)
                if stdout:match("enabled") then
                    wifi_set_state(true)
                    wifi_row.label_widget.markup = "<b>Wi-Fi</b>"
                    wifi_row.icon_widget:set_text(m.glyph.wifi_on)
                    set_wifi_visible(true)
                    awful.spawn.easy_async("nmcli device wifi rescan", function() refresh_wifi() end)
                else
                    wifi_set_state(false)
                    set_wifi_visible(false)
                end
            end)
            awful.spawn.easy_async_with_shell("brightnessctl g 2>/dev/null; brightnessctl m 2>/dev/null", function(out)
                local cur, mx = out:match("(%d+)\n(%d+)")
                if cur and mx and tonumber(mx) > 0 then
                    local pct = math.floor(tonumber(cur) / tonumber(mx) * 100)
                    bri_slider.value = pct
                    bri_text.markup = pct .. "%"
                end
            end)
        end
    end)
))

M.set_widget = set_widget

return M
