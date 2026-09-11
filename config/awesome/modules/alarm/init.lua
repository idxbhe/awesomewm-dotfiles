-- modules/alarm.lua
-- Alarm system with specific day, every day, and interval support

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Alarm storage
local alarms_file = require("modules.state").path("alarms.json")
local alarms = {}
local alarm_timers = {}
local active_ring_alarm = nil -- Track currently ringing alarm

-- Forward declarations
local show_alarm_ring_popup

-- Tone files directory
local tones_dir = debug.getinfo(1, "S").source:sub(2):match("(.*/)") .. "tones/"

-- Available tones (scanned from tones folder)
local available_tones = {}
local function scan_tones()
    available_tones = {}
    local handle = io.popen('ls "' .. tones_dir .. '" 2>/dev/null')
    if handle then
        for file in handle:lines() do
            -- Extract name without extension
            local name = file:match("(.+)%..+$")
            if name then
                table.insert(available_tones, {
                    name = name,
                    file = tones_dir .. file,
                })
            end
        end
        handle:close()
    end
end
scan_tones()

-- Ensure we have at least one tone available
if #available_tones == 0 then
    table.insert(available_tones, {
        name = "default",
        file = "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga",
    })
end

-- Silent after options (in seconds)
local silent_after_options = {
    { label = "1 min", value = 60 },
    { label = "3 min", value = 180 },
    { label = "5 min", value = 300 },
    { label = "10 min", value = 600 },
    { label = "30 min", value = 1800 },
    { label = "None", value = nil },
}

-- =============================================================================
-- Persistence
-- =============================================================================

local function save_alarms()
    local f = io.open(alarms_file, "w")
    if not f then return end
    f:write("{\n")
    for i, alarm in ipairs(alarms) do
        f:write(string.format('  {"id":%d,"type":"%s",', alarm.id, alarm.type))
        if alarm.type == "time" then
            f:write(string.format('"time":"%s","days":[', alarm.time))
            for j, day in ipairs(alarm.days) do
                if j > 1 then f:write(",") end
                f:write(tostring(day))
            end
            f:write("],")
        elseif alarm.type == "interval" then
            f:write(string.format('"interval":%d,', alarm.interval))
        end
        f:write(string.format('"enabled":%s', alarm.enabled and "true" or "false"))
        -- Add tone
        if alarm.tone then
            f:write(string.format(',"tone":"%s"', alarm.tone))
        end
        -- Add silent_after
        if alarm.silent_after then
            f:write(string.format(',"silent_after":%d', alarm.silent_after))
        end
        f:write("}")
        if i < #alarms then
            f:write(",\n")
        else
            f:write("\n")
        end
    end
    f:write("}\n")
    f:close()
end

local function load_alarms()
    local f = io.open(alarms_file, "r")
    if not f then return end
    local content = f:read("*all")
    f:close()

    alarms = {}
    -- Parse each alarm object
    for alarm_obj in content:gmatch('%{([^}]+)%}') do
        local alarm = {}
        alarm.id = tonumber(alarm_obj:match('"id":(%d+)'))
        alarm.type = alarm_obj:match('"type":"([^"]+)"')
        alarm.enabled = alarm_obj:match('"enabled":(%w+)') == "true"

        if alarm.type == "time" then
            alarm.time = alarm_obj:match('"time":"([^"]+)"')
            alarm.days = {}
            local days_str = alarm_obj:match('"days":%[([^%]]*)%]')
            if days_str then
                for d in days_str:gmatch("(%d+)") do
                    table.insert(alarm.days, tonumber(d))
                end
            end
        elseif alarm.type == "interval" then
            local interval = alarm_obj:match('"interval":(%d+)')
            alarm.interval = tonumber(interval)
        end

        -- Optional fields
        alarm.tone = alarm_obj:match('"tone":"([^"]+)"')
        local silent_after = alarm_obj:match('"silent_after":(%d+)')
        alarm.silent_after = silent_after and tonumber(silent_after) or nil

        if alarm.id then
            table.insert(alarms, alarm)
        end
    end
end

-- =============================================================================
-- Alarm execution
-- =============================================================================

local function trigger_alarm(alarm)
    -- Prevent multiple triggers of the same alarm while it's still ringing
    if active_ring_alarm == alarm then
        return
    end

    local name = alarm.name or "Alarm"
    local message = ""

    if alarm.type == "time" then
        message = alarm.time
    elseif alarm.type == "interval" then
        local mins = math.floor(alarm.interval / 60)
        message = string.format("Every %d minutes", mins)
    end

    m.naughty.notify({
        title = name,
        text = message,
        timeout = 10,
        urgency = "critical",
    })

    -- Show alarm ring popup
    local ok, err = pcall(show_alarm_ring_popup, alarm)
    if not ok then
        print("ALARM POPUP ERROR: " .. tostring(err))
    end

    -- Play sound with proper handling based on tone length vs silent_after
    local tone_file = nil
    if alarm.tone then
        for _, t in ipairs(available_tones) do
            if t.name == alarm.tone and t.file then
                tone_file = t.file
                break
            end
        end
    else
        tone_file = "/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
    end

    if not tone_file then return end

    -- Get tone duration using ffprobe
    local function get_tone_duration()
        local duration = nil
        local handle = io.popen(string.format('ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "%s"', tone_file))
        if handle then
            local output = handle:read("*a")
            handle:close()
            duration = tonumber(output:match("([%d%.]+)"))
        end
        return duration or 5 -- fallback 5 seconds
    end

    local tone_duration = get_tone_duration()
    local silent_duration = alarm.silent_after

    -- Case 1: silent_after = None → infinite repeat with no gaps
    if not silent_duration then
        awful.spawn.with_shell('mpv --no-terminal --no-video --loop "' .. tone_file .. '" 2>/dev/null')
        return
    end

    -- Case 2: tone length > silent_after → play once, stop at silent_after
    if tone_duration > silent_duration then
        awful.spawn.with_shell(string.format('mpv --no-terminal --no-video --length=%d "%s" 2>/dev/null', silent_duration, tone_file))
        return
    end

    -- Case 3: tone length < silent_after → loop continuously until silent_after
    awful.spawn.with_shell(string.format('mpv --no-terminal --no-video --loop --length=%d "%s" 2>/dev/null', silent_duration, tone_file))

    -- One-time alarm: disable after trigger if no days selected
    if #alarm.days == 0 then
        alarm.enabled = false
        save_alarms()
        schedule_alarms() -- Reschedule to stop this alarm's timer
    end
end

-- =============================================================================
-- Scheduling
-- =============================================================================

local function clear_timers()
    for _, timer in pairs(alarm_timers) do
        if timer then timer:stop() end
    end
    alarm_timers = {}
end

local function schedule_alarms()
    clear_timers()

    for _, alarm in ipairs(alarms) do
        if not alarm.enabled then goto continue end

        if alarm.type == "time" then
            -- Parse time HH:MM
            local hour, min = alarm.time:match("(%d+):(%d+)")
            if hour and min then
                hour = tonumber(hour)
                min = tonumber(min)

                local function create_check_timer()
                    -- Calculate seconds until next minute boundary
                    local now = os.date("*t")
                    local secs_until = 60 - now.sec

                    local t = gears.timer({
                        timeout = secs_until,
                        single_shot = true,
                        autostart = true,
                        callback = function()
                            local now = os.date("*t")
                            local now_hour = now.hour
                            local now_min = now.min
                            local now_wday = now.wday - 1 -- 0-6 (Sunday=0)
                            local now_time = string.format("%02d:%02d", now_hour, now_min)

                            -- Check if already triggered this minute
                            if alarm.last_trigger_time == now_time then
                                create_check_timer()
                                return
                            end

                            if now_hour == hour and now_min == min then
                                -- Check if today is in the days list
                                local should_trigger = false
                                if #alarm.days == 0 or #alarm.days == 7 then
                                    should_trigger = true
                                else
                                    for _, day in ipairs(alarm.days) do
                                        if day == now_wday then
                                            should_trigger = true
                                            break
                                        end
                                    end
                                end

                                if should_trigger then
                                    alarm.last_trigger_time = now_time
                                    trigger_alarm(alarm)
                                end
                            end

                            -- Schedule next check (single-shot timers auto-cleanup, don't store in alarm_timers)
                            create_check_timer()
                        end,
                    })
                    -- Don't store single-shot timers in alarm_timers - they auto-cleanup after firing
                end

                create_check_timer()
            end
        elseif alarm.type == "interval" then
            local timer = gears.timer({
                timeout = alarm.interval,
                call_now = false,
                autostart = true,
                callback = function()
                    trigger_alarm(alarm)
                end,
            })
            table.insert(alarm_timers, timer)
        end

        ::continue::
    end
end

-- =============================================================================
-- Alarm Ring Popup
-- =============================================================================

local alarm_ring_popup = nil
local snooze_timer = nil

-- Stop the currently ringing alarm
local function stop_alarm()
    if not active_ring_alarm then return end

    -- Kill all mpv processes playing alarm sounds
    awful.spawn.with_shell("pkill -f 'mpv.*tones/' 2>/dev/null")
    awful.spawn.with_shell("pkill -f 'mpv.*alarm-clock-elapsed' 2>/dev/null")

    -- Stop repeat timer if exists
    if active_ring_alarm._repeat_timer then
        active_ring_alarm._repeat_timer:stop()
        active_ring_alarm._repeat_timer = nil
    end

    -- Hide the popup using priority method
    if alarm_ring_popup and alarm_ring_popup.visible then
        popup_registry.hide_priority_popup(alarm_ring_popup)
    end

    active_ring_alarm = nil
end

-- Snooze alarm for 10 minutes
local function snooze_alarm()
    if not active_ring_alarm then return end

    local alarm = active_ring_alarm

    -- Stop current ringing
    stop_alarm()

    -- Set snooze timer for 10 minutes
    snooze_timer = gears.timer({
        timeout = 600, -- 10 minutes in seconds
        single_shot = true,
        callback = function()
            trigger_alarm(alarm)
            snooze_timer = nil
        end
    })
    snooze_timer:start()
end

-- Create the alarm ring popup
local function create_alarm_ring_popup()
    if alarm_ring_popup then return alarm_ring_popup end

    -- Stop button (same width as tools popup: 280px, minus margins)
    local stop_btn = wibox.widget {
        {
            markup = '<span font="' .. m.font_popup .. '">Dismiss</span>',
            align = "center",
            valign = "center",
            forced_height = 32,
            widget = wibox.widget.textbox,
        },
        bg = m.red_dark or "#a33b4e",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
        widget = wibox.container.background,
    }

    stop_btn:connect_signal("mouse::enter", function()
        stop_btn.bg = "#d44a5e"
    end)
    stop_btn:connect_signal("mouse::leave", function()
        stop_btn.bg = m.red_dark or "#a33b4e"
    end)

    stop_btn:buttons(gears.table.join(
        awful.button({}, 1, stop_alarm)
    ))

    -- Snooze button
    local snooze_btn = wibox.widget {
        {
            markup = '<span font="' .. m.font_popup .. '">Snooze (+10 min)</span>',
            align = "center",
            valign = "center",
            forced_height = 32,
            widget = wibox.widget.textbox,
        },
        bg = m.blue_dark or "#3b5998",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
        widget = wibox.container.background,
    }

    snooze_btn:connect_signal("mouse::enter", function()
        snooze_btn.bg = "#5a7abf"
    end)
    snooze_btn:connect_signal("mouse::leave", function()
        snooze_btn.bg = m.blue_dark or "#3b5998"
    end)

    snooze_btn:buttons(gears.table.join(
        awful.button({}, 1, snooze_alarm)
    ))

    -- Create popup (match tools popup dimensions and style)
    alarm_ring_popup = awful.popup {
        widget = {
            {
                {
                    {
                        markup = '<span font="icons 48">' .. m.glyph.alarm .. '</span>',
                        align = "center",
                        valign = "center",
                        forced_height = 60,
                        widget = wibox.widget.textbox,
                    },
                    top = 20,
                    bottom = 20,
                    widget = wibox.container.margin,
                },
                {
                    stop_btn,
                    snooze_btn,
                    spacing = 6,
                    layout = wibox.layout.fixed.vertical,
                },
                spacing = 8,
                layout = wibox.layout.fixed.vertical,
            },
            margins = 10,
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.vertical,
        minimum_width = 280,
        maximum_width = 280,
        bg = "#1e1e2eee",
        border_width = 1,
        border_color = "#313244",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
        ontop = true,
        visible = false,
    }

    return alarm_ring_popup
end

-- Show alarm ring popup
show_alarm_ring_popup = function(alarm)
    active_ring_alarm = alarm
    local popup = create_alarm_ring_popup()

    -- Position same as tools popup (top-right)
    local s = awful.screen.focused()
    popup.x = s.geometry.x + s.geometry.width - 380
    popup.y = s.geometry.y + 30

    popup_registry.show_priority_popup(popup)
end

-- =============================================================================
-- Alarm management
-- =============================================================================

local next_id = 1

function M.add_alarm(alarm)
    alarm.id = next_id
    next_id = next_id + 1
    table.insert(alarms, alarm)
    save_alarms()
    schedule_alarms()
    return alarm.id
end

function M.remove_alarm(id)
    for i, alarm in ipairs(alarms) do
        if alarm.id == id then
            table.remove(alarms, i)
            break
        end
    end
    save_alarms()
    schedule_alarms()
end

function M.toggle_alarm(id)
    for _, alarm in ipairs(alarms) do
        if alarm.id == id then
            alarm.enabled = not alarm.enabled
            break
        end
    end
    save_alarms()
    schedule_alarms()
end

function M.get_alarms()
    return alarms
end

-- =============================================================================
-- GUI - Add/Edit Alarm Popup
-- =============================================================================

local add_popup = nil
local current_edit_id = nil
local form_widgets = nil  -- Store references to form widgets for edit mode

local function create_add_popup()
    if add_popup then return add_popup end

    -- Forward declaration for stop_editing (will be fully defined after inline edit setup)
    local active_keygrabber = nil
    local stop_editing = function(save) end  -- placeholder, will be replaced
    local just_started_editing = false
    local global_click_handler = nil  -- will be defined later when popup exists

    -- Day toggles
    local day_names = {"S", "M", "T", "W", "T", "F", "S"}
    local day_toggles = {}
    local selected_days = {false, false, false, false, false, false, false}

    local function update_day_display()
        for i, btn in ipairs(day_toggles) do
            if selected_days[i] then
                btn.bg = m.blue_dark or "#3b5998"
            else
                btn.bg = m.surface0 or "#313244"
            end
        end
    end

    for i = 1, 7 do
        local btn = wibox.widget {
            {
                markup = string.format('<span font="%s">%s</span>', m.font_popup, day_names[i]),
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            forced_width = 32,
            forced_height = 32,
            bg = m.surface0 or "#313244",
            shape = gears.shape.circle,
            widget = wibox.container.background,
        }
        btn:buttons(gears.table.join(
            awful.button({}, 1, function()
                stop_editing(true)
                selected_days[i] = not selected_days[i]
                update_day_display()
            end)
        ))
        btn:connect_signal("mouse::enter", function()
            if not selected_days[i] then
                btn.bg = m.overlay0 or "#45475a"
            end
        end)
        btn:connect_signal("mouse::leave", function()
            if not selected_days[i] then
                btn.bg = m.surface0 or "#313244"
            end
        end)
        table.insert(day_toggles, btn)
    end

    -- Time input: separate hour and minute fields
    local hour_tb = wibox.widget.textbox()
    hour_tb:set_font("Maple Mono NF Bold 36")
    hour_tb:set_text("08")

    local minute_tb = wibox.widget.textbox()
    minute_tb:set_font("Maple Mono NF Bold 36")
    minute_tb:set_text("00")

    local colon_tb = wibox.widget {
        markup = string.format('<span font="Maple Mono NF Bold 36">:</span>'),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local time_input_widget = wibox.widget {
        hour_tb,
        colon_tb,
        minute_tb,
        spacing = 4,
        layout = wibox.layout.fixed.horizontal,
    }

    -- Inline edit functions
    local editing_textbox = nil
    local editing_callback = nil
    local editing_cursor_timer = nil

    -- Stop any active editing session (actual implementation)
    stop_editing = function(save)
        if not active_keygrabber then return end

        awful.keygrabber.stop(active_keygrabber)
        active_keygrabber = nil

        -- Stop cursor blink timer
        if editing_cursor_timer then
            editing_cursor_timer:stop()
            editing_cursor_timer = nil
        end

        -- Remove global click handler
        if global_click_handler then
            local buttons = root.buttons()
            local new_buttons = {}
            for _, b in ipairs(buttons) do
                if b._alarm_global then
                    -- skip
                else
                    table.insert(new_buttons, b)
                end
            end
            root.buttons(new_buttons)
        end

        if editing_textbox and save and editing_callback then
            -- Get current value without cursor
            local val = editing_textbox:get_text()
            -- Remove trailing | if present (cursor visible)
            if val:sub(-1) == "|" then
                val = val:sub(1, -2)
            end
            editing_callback(val)
        elseif editing_textbox and not save then
            -- Cancelled, restore original (callback will handle this)
            local val = editing_textbox:get_text()
            -- Remove trailing | if present (cursor visible)
            if val:sub(-1) == "|" then
                val = val:sub(1, -2)
            end
            editing_callback(val, false)
        end

        editing_textbox = nil
        editing_callback = nil
    end

    local function setup_inline_edit(tb, default_val, max_val)
        -- Validate input: only digits, max 2 chars
        local function validate_char(key)
            if not key or #key ~= 1 then return false end
            -- Only allow digits
            if key < "0" or key > "9" then return false end
            return true
        end

        -- Check if new value is valid for this field
        local function is_valid_value(val)
            local num = tonumber(val)
            if not num then return false end
            if num > max_val then return false end
            return true
        end

        -- Format number with leading zero if needed
        local function format_number(val)
            local num = tonumber(val)
            if not num then return default_val end
            return string.format("%02d", num)
        end

        tb:buttons(gears.table.join(
            awful.button({}, 1, function()
                -- Stop existing edit if any - SAVE current value
                stop_editing(true)

                local current_val = tb:get_text() or default_val
                local edit_val = current_val

                -- Update display as user types (with cursor)
                local function update_display()
                    tb:set_text(edit_val .. "|")
                end

                -- Show cursor initially
                tb:set_text(current_val .. "|")

                -- Blink cursor every 500ms
                local cursor_visible = true
                local cursor_timer = gears.timer({
                    timeout = 0.5,
                    autostart = true,
                    call_now = false,
                    callback = function()
                        cursor_visible = not cursor_visible
                        if cursor_visible then
                            tb:set_text(edit_val .. "|")
                        else
                            tb:set_text(edit_val .. " ")
                        end
                    end
                })

                -- Store timer reference so stop_editing can clean it up
                editing_cursor_timer = cursor_timer

                editing_textbox = tb
                editing_callback = function(val, was_save)
                    if was_save ~= false then
                        -- Save - format with leading zero
                        local formatted = format_number(val)
                        if is_valid_value(formatted) then
                            tb:set_text(formatted)
                        else
                            tb:set_text(default_val)
                        end
                    else
                        -- Cancelled, restore original
                        tb:set_text(current_val)
                    end
                end

                -- Grab keyboard
                active_keygrabber = awful.keygrabber.run(function(_, key, event)
                    if event == "release" then return end
                    if not key then return end

                    if key == "Return" or key == "KP_Enter" then
                        stop_editing(true)
                    elseif key == "Escape" then
                        stop_editing(false)
                    elseif key == "BackSpace" then
                        edit_val = edit_val:sub(1, -2)
                        update_display()
                    elseif validate_char(key) then
                        -- Only allow up to 2 digits
                        if #edit_val < 2 then
                            local new_val = edit_val .. key
                            -- Check if would exceed max
                            if #new_val == 2 then
                                local num = tonumber(new_val)
                                if num and num <= max_val then
                                    edit_val = new_val
                                    update_display()
                                elseif tonumber(key) and tonumber(key) <= max_val then
                                    -- Replace with single digit
                                    edit_val = key
                                    update_display()
                                end
                            else
                                edit_val = new_val
                                update_display()
                            end
                        end
                    elseif key == "Tab" then
                        -- Tab to next field - save current
                        stop_editing(true)
                    end
                end)

                -- Install global mouse handler for clicks outside popup
                local existing_buttons = root.buttons()
                local new_buttons = {}
                for _, b in ipairs(existing_buttons) do
                    if not b._alarm_global then
                        table.insert(new_buttons, b)
                    end
                end
                local global_btn = awful.button({}, 1, global_click_handler)
                global_btn._alarm_global = true
                table.insert(new_buttons, global_btn)
                root.buttons(new_buttons)

                -- Set flag to prevent immediate stop from click bubble-up
                just_started_editing = true
                gears.timer.start_new(0.1, function()
                    just_started_editing = false
                    return false
                end)
            end)
        ))
    end

    setup_inline_edit(hour_tb, "08", 23)
    setup_inline_edit(minute_tb, "00", 59)

    -- Set initial values

    -- Tone selector
    local selected_tone_index = 1

    local function create_arrow(label)
        local arrow = wibox.widget {
            {
                markup = string.format('<span font="%s">%s</span>', m.font_popup, label),
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            forced_width = 24,
            forced_height = 28,
            shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
            widget = wibox.container.background,
        }
        arrow:connect_signal("mouse::enter", function()
            arrow.bg = "#7f849c"  -- brighter overlay2
        end)
        arrow:connect_signal("mouse::leave", function()
            arrow.bg = nil
        end)
        return arrow
    end

    local tone_left_arrow = create_arrow("&lt;")
    local tone_right_arrow = create_arrow("&gt;")

    local tone_name_tb = wibox.widget {
        markup = string.format('<span font="%s">%s</span>', m.font_popup, available_tones[1].name),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local preview_pid = nil

    local function preview_tone(tone_file)
        if preview_pid then
            awful.spawn.with_shell("kill " .. preview_pid .. " 2>/dev/null")
            preview_pid = nil
        end
        -- Use mpv with --length=5 to auto-stop after 5 seconds
        local pid = awful.spawn.with_shell('mpv --no-terminal --no-video --length=5 "' .. tone_file .. '" 2>/dev/null')
        preview_pid = pid
    end

    local function update_tone_display()
        tone_name_tb:set_markup(string.format('<span font="%s">%s</span>', m.font_popup, available_tones[selected_tone_index].name))
    end

    tone_left_arrow:buttons(gears.table.join(
        awful.button({}, 1, function()
            stop_editing(true)
            selected_tone_index = selected_tone_index - 1
            if selected_tone_index < 1 then
                selected_tone_index = #available_tones
            end
            update_tone_display()
            preview_tone(available_tones[selected_tone_index].file)
        end)
    ))

    tone_right_arrow:buttons(gears.table.join(
        awful.button({}, 1, function()
            stop_editing(true)
            selected_tone_index = selected_tone_index + 1
            if selected_tone_index > #available_tones then
                selected_tone_index = 1
            end
            update_tone_display()
            preview_tone(available_tones[selected_tone_index].file)
        end)
    ))

    local tone_box = wibox.widget {
        {
            tone_name_tb,
            left = 8, right = 8,
            widget = wibox.container.margin,
        },
        bg = m.surface0 or "#313244",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
        forced_height = 28,
        forced_width = 140,
    }

    local tone_selector = wibox.widget {
        tone_left_arrow,
        tone_box,
        tone_right_arrow,
        spacing = 4,
        layout = wibox.layout.fixed.horizontal,
    }

    -- Silent after selector
    local selected_silent_after_index = 1

    local silent_left_arrow = create_arrow("&lt;")
    local silent_right_arrow = create_arrow("&gt;")

    local silent_name_tb = wibox.widget {
        markup = string.format('<span font="%s">%s</span>', m.font_popup, silent_after_options[1].label),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local function update_silent_display()
        silent_name_tb:set_markup(string.format('<span font="%s">%s</span>', m.font_popup, silent_after_options[selected_silent_after_index].label))
    end

    silent_left_arrow:buttons(gears.table.join(
        awful.button({}, 1, function()
            stop_editing(true)
            selected_silent_after_index = selected_silent_after_index - 1
            if selected_silent_after_index < 1 then
                selected_silent_after_index = #silent_after_options
            end
            update_silent_display()
        end)
    ))

    silent_right_arrow:buttons(gears.table.join(
        awful.button({}, 1, function()
            stop_editing(true)
            selected_silent_after_index = selected_silent_after_index + 1
            if selected_silent_after_index > #silent_after_options then
                selected_silent_after_index = 1
            end
            update_silent_display()
        end)
    ))

    local silent_box = wibox.widget {
        {
            silent_name_tb,
            left = 8, right = 8,
            widget = wibox.container.margin,
        },
        bg = m.surface0 or "#313244",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
        forced_height = 28,
        forced_width = 140,
    }

    local silent_after_selector = wibox.widget {
        silent_left_arrow,
        silent_box,
        silent_right_arrow,
        spacing = 4,
        layout = wibox.layout.fixed.horizontal,
    }

    -- Time input is the only input mode
    local input_container = wibox.widget {
        time_input_widget,
        widget = wibox.container.place,
        halign = "center",
    }

    -- Buttons with icons and text
    local btn_width = 120

    local save_btn = wibox.widget {
        {
            {
                {
                    markup = string.format('<span font="icons 12">%s</span>', m.glyph.btn_save),
                    align = "center",
                    valign = "center",
                    widget = wibox.widget.textbox,
                },
                {
                    markup = string.format('<span font="%s">Save</span>', m.font_popup_regular),
                    align = "center",
                    valign = "center",
                    widget = wibox.widget.textbox,
                },
                spacing = 6,
                layout = wibox.layout.fixed.horizontal,
            },
            halign = "center",
            valign = "center",
            widget = wibox.container.place,
        },
        forced_height = 28,
        forced_width = btn_width,
        bg = m.green_dark or "#2a9d4f",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    save_btn:connect_signal("mouse::enter", function()
        save_btn.bg = "#50d975"
    end)
    save_btn:connect_signal("mouse::leave", function()
        save_btn.bg = m.green_dark or "#2a9d4f"
    end)

    local cancel_btn = wibox.widget {
        {
            {
                {
                    markup = string.format('<span font="icons 12">%s</span>', m.glyph.btn_cancel),
                    align = "center",
                    valign = "center",
                    widget = wibox.widget.textbox,
                },
                {
                    markup = string.format('<span font="%s">Cancel</span>', m.font_popup_regular),
                    align = "center",
                    valign = "center",
                    widget = wibox.widget.textbox,
                },
                spacing = 6,
                layout = wibox.layout.fixed.horizontal,
            },
            halign = "center",
            valign = "center",
            widget = wibox.container.place,
        },
        forced_height = 28,
        forced_width = btn_width,
        bg = m.red_dark or "#a33b4e",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    cancel_btn:connect_signal("mouse::enter", function()
        cancel_btn.bg = "#e05565"
    end)
    cancel_btn:connect_signal("mouse::leave", function()
        cancel_btn.bg = m.red_dark or "#a33b4e"
    end)

    save_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            -- Stop any active editing first to save value
            if form_widgets and form_widgets.stop_editing then
                form_widgets.stop_editing(true)
            end

            local alarm = {
                type = "time",
                enabled = true,
                tone = available_tones[selected_tone_index].name,
                silent_after = silent_after_options[selected_silent_after_index].value,
            }

            local h = hour_tb:get_text() or "08"
            local mi = minute_tb:get_text() or "00"
            alarm.time = h .. ":" .. mi
            alarm.days = {}
            for i, selected in ipairs(selected_days) do
                if selected then
                    table.insert(alarm.days, i - 1) -- 0-indexed
                end
            end

            if current_edit_id then
                M.remove_alarm(current_edit_id)
                current_edit_id = nil
            end
            M.add_alarm(alarm)

            popup_registry.hide_popup(add_popup)
            M.show_alarm_list()
        end)
    ))

    cancel_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            if form_widgets and form_widgets.stop_editing then
                form_widgets.stop_editing(false)
            end
            current_edit_id = nil
            popup_registry.hide_popup(add_popup)
        end)
    ))

    -- Back arrow (returns to alarm list)
    local add_back_inner = wibox.widget {
        markup = string.format('<span font="%s">&lt;-</span>', m.font_popup),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }
    local add_back_tb = wibox.widget {
        add_back_inner,
        forced_width = 24,
        forced_height = 24,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    add_back_tb:buttons(gears.table.join(
        awful.button({}, 1, function()
            current_edit_id = nil
            popup_registry.hide_popup(add_popup)
            M.show_alarm_list()
        end)
    ))
    add_back_tb:connect_signal("mouse::enter", function()
        add_back_tb.bg = m.overlay0 or "#45475a"
    end)
    add_back_tb:connect_signal("mouse::leave", function()
        add_back_tb.bg = nil
    end)

    local days_row = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 4,
        day_toggles[1], day_toggles[2], day_toggles[3], day_toggles[4],
        day_toggles[5], day_toggles[6], day_toggles[7],
    }

    -- Tone section with title
    local tone_title = wibox.widget {
        markup = string.format('<span font="%s">Tone</span>', m.font_popup_regular),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local tone_row = wibox.widget {
        {
            {
                tone_title,
                tone_selector,
                spacing = 4,
                layout = wibox.layout.fixed.vertical,
            },
            layout = wibox.container.place,
            halign = "center",
        },
        forced_width = 256,
        layout = wibox.container.place,
        halign = "center",
    }

    -- Silent after section with title
    local silent_title = wibox.widget {
        markup = string.format('<span font="%s">Silent After</span>', m.font_popup_regular),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local silent_row = wibox.widget {
        {
            {
                silent_title,
                silent_after_selector,
                spacing = 4,
                layout = wibox.layout.fixed.vertical,
            },
            layout = wibox.container.place,
            halign = "center",
        },
        forced_width = 256,
        layout = wibox.container.place,
        halign = "center",
    }

    local button_row = wibox.widget {
        {
            save_btn,
            cancel_btn,
            spacing = 8,
            layout = wibox.layout.fixed.horizontal,
        },
        forced_width = 256,
        layout = wibox.container.place,
        halign = "center",
    }

    local title_row = wibox.widget {
        {
            add_back_tb,
            forced_width = 24,
            widget = wibox.container.place,
        },
        {
            markup = string.format('<span font="%s">Alarms</span>', m.font_popup),
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        {
            forced_width = 24,
            widget = wibox.container.place,
        },
        expand = "inside",
        layout = wibox.layout.align.horizontal,
    }

    -- Wrap sections with margins for spacing
    local days_section = wibox.widget {
        days_row,
        top = 12,
        bottom = 12,
        widget = wibox.container.margin,
    }

    local time_section = wibox.widget {
        input_container,
        top = 8,
        bottom = 12,
        widget = wibox.container.margin,
    }

    local tone_section = wibox.widget {
        tone_row,
        top = 8,
        bottom = 12,
        widget = wibox.container.margin,
    }

    local silent_section = wibox.widget {
        silent_row,
        top = 8,
        bottom = 12,
        widget = wibox.container.margin,
    }

    local button_section = wibox.widget {
        button_row,
        top = 12,
        widget = wibox.container.margin,
    }

    local main_content = wibox.widget {
        title_row,
        days_section,
        time_section,
        tone_section,
        silent_section,
        button_section,
        layout = wibox.layout.fixed.vertical,
    }

    local popup_container = wibox.widget {
        main_content,
        margins = 12,
        widget = wibox.container.margin,
    }

    add_popup = awful.popup {
        widget = popup_container,
        bg = "#1e1e2eee",
        border_width = 1,
        border_color = "#313244",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
        ontop = true,
        visible = false,
        x = 0,
        y = 0,
    }

    -- Force layout recalculation
    add_popup:connect_signal("property::width", function()
        if add_popup.visible then
            add_popup:emit_signal("widget::layout_changed")
        end
    end)

    -- Stop editing when clicking anywhere outside the time textboxes
    add_popup:connect_signal("button::press", function(_, x, y, button, modifiers, find_result)
        if just_started_editing then return end
        if not active_keygrabber then return end
        -- Check if click was on hour_tb or minute_tb - if so, skip (they handle their own edit start)
        if find_result then
            for _, w in ipairs(find_result) do
                if w == hour_tb or w == minute_tb then return end
            end
        end
        stop_editing(true)
    end)

    -- Global mouse handler: stop editing when clicking outside popup
    global_click_handler = function()
        if just_started_editing then return end
        if active_keygrabber then
            stop_editing(true)
        end
    end

    -- Store widget references for edit mode
    form_widgets = {
        day_toggles = day_toggles,
        selected_days = selected_days,
        hour_tb = hour_tb,
        minute_tb = minute_tb,
        stop_editing = stop_editing,
        set_tone = function(name)
            for i, t in ipairs(available_tones) do
                if t.name == name then
                    selected_tone_index = i
                    update_tone_display()
                    return
                end
            end
            selected_tone_index = 1
            update_tone_display()
        end,
        set_silent_after = function(value)
            if value == "None" then
                selected_silent_after_index = #silent_after_options
                update_silent_display()
                return
            end
            for i, opt in ipairs(silent_after_options) do
                if opt.value == value then
                    selected_silent_after_index = i
                    update_silent_display()
                    return
                end
            end
            selected_silent_after_index = #silent_after_options
            update_silent_display()
        end,
    }

    -- Clean up editing session when popup is hidden
    add_popup:connect_signal("property::visible", function()
        if not add_popup.visible and active_keygrabber then
            stop_editing(false)
        end
    end)

    return add_popup
end

function M.show_add_alarm()
    current_edit_id = nil
    local popup = create_add_popup()

    -- Reset form to default state
    if form_widgets then
        -- Reset all days
        for i = 1, 7 do
            form_widgets.selected_days[i] = false
            form_widgets.day_toggles[i].bg = m.surface0 or "#313244"
        end

        form_widgets.hour_tb:set_text("08")
        form_widgets.minute_tb:set_text("00")
        form_widgets.set_tone(available_tones[1].name)
        form_widgets.set_silent_after(silent_after_options[1].value)
    end

    local s = awful.screen.focused().geometry
    popup.x = s.x + s.width - 380
    popup.y = s.y + 30
    popup_registry.show_child_popup(popup)
end

function M.edit_alarm(id)
    local alarm = nil
    for _, a in ipairs(alarms) do
        if a.id == id then alarm = a break end
    end
    if not alarm then return end

    current_edit_id = id
    local popup = create_add_popup()

    -- Fill form with alarm data (time only now)
    if form_widgets then
        -- Reset all days first
        for i = 1, 7 do
            form_widgets.selected_days[i] = false
        end

        local h, mi = alarm.time:match("(%d+):(%d+)")
        form_widgets.hour_tb:set_text(h or "08")
        form_widgets.minute_tb:set_text(mi or "00")
        -- Set selected days
        for _, day in ipairs(alarm.days) do
            form_widgets.selected_days[day + 1] = true
        end

        -- Update day toggle visuals
        for i, btn in ipairs(form_widgets.day_toggles) do
            if form_widgets.selected_days[i] then
                btn.bg = m.blue_dark or "#3b5998"
            else
                btn.bg = m.surface0 or "#313244"
            end
        end

        -- Restore tone and silent_after
        if alarm.tone then
            form_widgets.set_tone(alarm.tone)
        else
            form_widgets.set_tone(available_tones[1].name)
        end
        if alarm.silent_after then
            form_widgets.set_silent_after(alarm.silent_after)
        else
            form_widgets.set_silent_after(silent_after_options[1].value)
        end
    end

    local s = awful.screen.focused().geometry
    popup.x = s.x + s.width - 380
    popup.y = s.y + 30
    popup_registry.show_child_popup(popup)
end

-- =============================================================================
-- GUI - Alarm List Popup
-- =============================================================================

local list_popup = nil
local alarm_list_widget = nil

local function create_alarm_row(alarm)
    local label = "Alarm"
    local detail = ""

    if alarm.type == "time" then
        local days_abbr = {"S", "M", "T", "W", "T", "F", "S"}
        local day_str = ""
        if #alarm.days == 0 then
            day_str = "Once"
        elseif #alarm.days == 7 then
            day_str = "Every day"
        elseif #alarm.days == 1 then
            day_str = days_abbr[alarm.days[1] + 1]
        else
            local parts = {}
            for _, d in ipairs(alarm.days) do
                table.insert(parts, days_abbr[d + 1])
            end
            day_str = table.concat(parts, ",")
        end
        label = alarm.time
        detail = day_str
    elseif alarm.type == "interval" then
        label = "Interval"
        detail = string.format("Every %dm", math.floor(alarm.interval / 60))
    end

    local markup = string.format(
        '<span font="%s">%s</span>  <span font="Maple Mono NF 10" color="#a6adc8">%s</span>',
        m.font_popup, label, detail
    )

    -- Toggle icon
    local toggle_icon = wibox.widget {
        markup = alarm.enabled and string.format('<span font="icons 17" color="%s">%s</span>', m.blue, m.glyph.toggle_on)
                               or string.format('<span font="icons 17">%s</span>', m.glyph.toggle_off),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local toggle_btn = wibox.widget {
        toggle_icon,
        bg = nil,  -- always transparent by default
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        forced_width = 28,
        forced_height = 28,
        widget = wibox.container.background,
    }

    -- Store enabled state for hover/leave handlers
    toggle_btn._enabled = alarm.enabled

    toggle_btn:connect_signal("mouse::enter", function(self)
        self.bg = m.surface0
    end)

    toggle_btn:connect_signal("mouse::leave", function(self)
        self.bg = nil  -- always transparent when not hovering
    end)

    toggle_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            M.toggle_alarm(alarm.id)
            popup_registry.hide_popup(list_popup)
            M.show_alarm_list()
        end)
    ))

    -- Delete icon (red)
    local delete_icon = wibox.widget {
        markup = string.format('<span font="icons 11" color="%s">%s</span>', m.red_dark or "#a33b4e", m.glyph.btn_delete),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local delete_btn = wibox.widget {
        delete_icon,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        forced_width = 24,
        forced_height = 24,
        widget = wibox.container.background,
    }

    delete_btn:connect_signal("mouse::enter", function() delete_btn.bg = m.surface0 end)
    delete_btn:connect_signal("mouse::leave", function() delete_btn.bg = nil end)

    delete_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            M.remove_alarm(alarm.id)
            popup_registry.hide_popup(list_popup)
            M.show_alarm_list()
        end)
    ))

    -- Edit icon
    local edit_icon = wibox.widget {
        markup = string.format('<span font="icons 11">%s</span>', m.glyph.btn_edit),
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
    }

    local edit_btn = wibox.widget {
        edit_icon,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        forced_width = 24,
        forced_height = 24,
        widget = wibox.container.background,
    }

    edit_btn:connect_signal("mouse::enter", function() edit_btn.bg = m.surface0 end)
    edit_btn:connect_signal("mouse::leave", function() edit_btn.bg = nil end)

    edit_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            popup_registry.hide_popup(list_popup)
            M.edit_alarm(alarm.id)
        end)
    ))

    local right_buttons = wibox.widget {
        edit_btn,
        delete_btn,
        toggle_btn,
        spacing = 4,
        layout = wibox.layout.fixed.horizontal,
    }

    local row = wibox.widget {
        {
            {
                markup = markup,
                align = "left",
                valign = "center",
                widget = wibox.widget.textbox,
            },
            {
                right_buttons,
                halign = "right",
                valign = "center",
                widget = wibox.container.place,
            },
            expand = "inside",
            layout = wibox.layout.align.horizontal,
        },
        left = 8,
        right = 8,
        forced_height = 28,
        bg = "#00000000",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    return row
end

local function create_list_popup()
    if list_popup then return list_popup end

    alarm_list_widget = wibox.widget {
        layout = wibox.layout.fixed.vertical,
        spacing = 4,
        forced_width = 200,
    }

    local add_btn_icon = wibox.widget {
        markup = string.format('<span font="icons 14">%s</span>', m.glyph.btn_add),
        align = "center",
        valign = "center",
        forced_width = 24,
        forced_height = 24,
        widget = wibox.widget.textbox,
    }

    local add_btn = wibox.widget {
        add_btn_icon,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        forced_width = 24,
        forced_height = 24,
        widget = wibox.container.background,
    }

    add_btn:connect_signal("mouse::enter", function() add_btn.bg = m.surface0 or "#313244" end)
    add_btn:connect_signal("mouse::leave", function() add_btn.bg = "#00000000" end)

    add_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            popup_registry.hide_popup(list_popup)
            M.show_add_alarm()
        end)
    ))

    -- Back arrow (returns to tools popup)
    local back_icon = wibox.widget {
        text = "<-",
        font = m.font_popup,
        align = "center",
        valign = "center",
        forced_width = 24,
        forced_height = 24,
        widget = wibox.widget.textbox,
    }

    local back_btn = wibox.widget {
        back_icon,
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        widget = wibox.container.background,
    }

    back_btn:connect_signal("mouse::enter", function() back_btn.bg = m.surface0 end)
    back_btn:connect_signal("mouse::leave", function() back_btn.bg = nil end)

    back_btn:buttons(gears.table.join(
        awful.button({}, 1, function()
            popup_registry.hide_popup(list_popup)
            local tools = require("modules.tools")
            popup_registry.show_popup(tools.tools_popup)
            local s = awful.screen.focused().geometry
            tools.tools_popup.x = s.x + s.width - 380
            tools.tools_popup.y = s.y + 30
        end)
    ))

    local title_widget = wibox.widget {
        {
            back_btn,
            forced_width = 24,
            widget = wibox.container.place,
        },
        {
            markup = string.format('<span font="%s">Alarms</span>', m.font_popup),
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox,
        },
        {
            add_btn,
            forced_width = 24,
            widget = wibox.container.place,
        },
        expand = "inside",
        layout = wibox.layout.align.horizontal,
    }

    local list_content = wibox.widget {
        title_widget,
        alarm_list_widget,
        spacing = 8,
        layout = wibox.layout.fixed.vertical,
    }

    local list_container = wibox.widget {
        list_content,
        margins = 12,
        widget = wibox.container.margin,
    }

    list_popup = awful.popup {
        widget = list_container,
        bg = "#1e1e2eee",
        border_width = 1,
        border_color = "#313244",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
        minimum_width = 280,
        maximum_width = 280,
        ontop = true,
        visible = false,
        x = 0,
        y = 0,
    }
    list_popup.ontop = true

    return list_popup
end

function M.show_alarm_list()
    local popup = create_list_popup()
    local s = awful.screen.focused().geometry
    popup.x = s.x + s.width - 380
    popup.y = s.y + 30
    popup_registry.show_child_popup(popup)

    -- Auto-hide on mouse leave
    local alarm_list_hide_timer = gears.timer {
        timeout = 0.5,
        single_shot = true,
        callback = function()
            local coords = mouse.coords()
            local geo = popup:geometry()
            if coords.x < geo.x or coords.x > geo.x + geo.width or
               coords.y < geo.y or coords.y > geo.y + geo.height then
                popup_registry.hide_popup(popup)
            end
        end,
    }

    popup:connect_signal("mouse::leave", function()
        if not popup_registry.should_auto_hide() then return end
        alarm_list_hide_timer:again()
    end)

    -- Rebuild alarm list
    alarm_list_widget:reset()

    if #alarms == 0 then
        local empty = wibox.widget {
            markup = string.format('<span font="%s" color="#a6adc8">No alarms</span>', m.font_popup_regular),
            align = "center",
            valign = "center",
            forced_height = 28,
            widget = wibox.widget.textbox,
        }
        alarm_list_widget:add(empty)
    else
        for _, alarm in ipairs(alarms) do
            alarm_list_widget:add(create_alarm_row(alarm))
        end
    end
end

-- =============================================================================
-- Initialization
-- =============================================================================

load_alarms()

-- Find max ID
for _, alarm in ipairs(alarms) do
    if alarm.id >= next_id then
        next_id = alarm.id + 1
    end
end

schedule_alarms()

return M
