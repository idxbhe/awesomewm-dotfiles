-- modules/calendar.lua
-- Calendar popup with click-to-toggle and mouse-follow

local m = require("modules")
local gears = m.gears
local awful = m.awful
local wibox = m.wibox
local popup_registry = require("modules.popup_registry")

local M = {}

-- Calendar state
local cal_year, cal_month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
local days_in_month = {31,28,31,30,31,30,31,31,30,31,30,31}
local month_names = {"January","February","March","April","May","June","July","August","September","October","November","December"}
local day_names = {"Mo","Tu","We","Th","Fr","Sa","Su"}

local function is_leap_year(y) return (y%4==0 and y%100~=0) or (y%400==0) end
local function days_in(m,y) return m==2 and is_leap_year(y) and 29 or days_in_month[m] end
local function first_day_of_month(m,y)
    local wday = tonumber(os.date("%w", os.time{year=y,month=m,day=1}))
    return wday == 0 and 6 or wday - 1
end

-- Pre-create all day widgets (7x6 grid = 42 cells max)
local day_widgets = {}
for i = 1, 42 do
    local tb = wibox.widget.textbox()
    tb.font = "Maple Mono NF 10"
    tb.align = "center"
    tb.valign = "center"
    tb.forced_width = 24
    tb.forced_height = 24
    day_widgets[i] = tb
end

-- Create calendar grid with header
local cal_grid_widget = wibox.widget {
    layout = wibox.layout.fixed.vertical,
    spacing = 2,
}

-- Header row
local header_row = wibox.widget { layout = wibox.layout.fixed.horizontal, spacing = 4 }
local header_colors = {"#cdd6f4","#cdd6f4","#cdd6f4","#cdd6f4","#74c7a4","#cdd6f4","#e06c8a"}
for idx, day in ipairs(day_names) do
    header_row:add(wibox.widget {
        markup = string.format("<span foreground='%s'>%s</span>", header_colors[idx], day),
        font = m.font_popup,
        align = "center",
        valign = "center",
        forced_width = 28,
        forced_height = 20,
        widget = wibox.widget.textbox,
    })
end
cal_grid_widget:add(header_row)

-- Week rows (6 rows max)
local day_cells = {}
local week_rows = {}
for w = 1, 6 do
    local row = wibox.widget { layout = wibox.layout.fixed.horizontal, spacing = 4 }
    for d = 1, 7 do
        local idx = (w-1)*7 + d
        local cell = wibox.container.background()
        cell.forced_width = 28
        cell.forced_height = 28
        cell.bg = "#1e1e2e"
        cell.shape = gears.shape.circle
        cell.shape_clip = true
        local place = wibox.container.place(day_widgets[idx])
        place.halign = "center"
        place.valign = "center"
        cell.widget = place
        day_cells[idx] = cell
        row:add(cell)
    end
    week_rows[w] = row
    cal_grid_widget:add(row)
end

local cal_month_year = wibox.widget.textbox()
cal_month_year.font = m.font_popup
cal_month_year.align = "center"
cal_month_year.valign = "center"

local function render_calendar()
    cal_month_year.markup = string.format("<span foreground='#89b4fa'><b>%s %d</b></span>", month_names[cal_month], cal_year)

    local first_day = first_day_of_month(cal_month, cal_year)
    local num_days = days_in(cal_month, cal_year)
    local today = tonumber(os.date("%d"))
    local current_month = tonumber(os.date("%m"))
    local current_year = tonumber(os.date("%Y"))

    -- Calculate how many weeks are needed
    local total_cells = first_day + num_days
    local weeks_needed = math.ceil(total_cells / 7)
    if weeks_needed < 4 then weeks_needed = 4 end  -- minimum 4 rows
    if weeks_needed > 6 then weeks_needed = 6 end  -- maximum 6 rows

    -- Hide unused week rows
    for w = 1, 6 do
        week_rows[w].visible = (w <= weeks_needed)
    end

    local prev_month = cal_month - 1
    local prev_year = cal_year
    if prev_month < 1 then
        prev_month = 12
        prev_year = cal_year - 1
    end
    local prev_days = days_in(prev_month, prev_year)
    
    local next_month = cal_month + 1
    local next_year = cal_year
    if next_month > 12 then
        next_month = 1
        next_year = cal_year + 1
    end
    
    for i = 1, 42 do
        day_widgets[i].markup = ""
        day_cells[i].bg = "#1e1e2e"
    end
    
    for i = 1, first_day do
        local day_num = prev_days - first_day + i
        local col_idx = i
        local fg
        
        if col_idx == 7 then
            fg = "#78424d"
        elseif col_idx == 5 then
            fg = "#4a7a68"
        else
            fg = "#585b70"
        end
        
        day_widgets[i].markup = string.format("<span foreground='%s'>%d</span>", fg, day_num)
    end
    
    for i = first_day + 1, first_day + num_days do
        local day_num = i - first_day
        local col_idx = ((i-1)%7)+1
        local is_today = (day_num == today and cal_month == current_month and cal_year == current_year)
        local fg, bg
        
        if is_today then
            fg = "#ffffff"
            bg = "#1e3a8a"
        elseif col_idx == 7 then
            fg = "#e06c8a"
            bg = "#1e1e2e"
        elseif col_idx == 5 then
            fg = "#74c7a4"
            bg = "#1e1e2e"
        else
            fg = "#cdd6f4"
            bg = "#1e1e2e"
        end
        
        day_widgets[i].markup = string.format("<span foreground='%s'>%d</span>", fg, day_num)
        day_cells[i].bg = bg
    end
    
    local next_start = first_day + num_days + 1
    local next_day_num = 1
    for i = next_start, 42 do
        local col_idx = ((i-1)%7)+1
        local fg
        
        if col_idx == 7 then
            fg = "#78424d"
        elseif col_idx == 5 then
            fg = "#4a7a68"
        else
            fg = "#585b70"
        end
        
        day_widgets[i].markup = string.format("<span foreground='%s'>%d</span>", fg, next_day_num)
        next_day_num = next_day_num + 1
    end
end

-- Calendar popup
local calendar_popup = awful.popup {
    widget = wibox.container.margin(
        wibox.widget {
            {
                {
                    text = "<-",
                    font = m.font_popup,
                    align = "center",
                    valign = "center",
                    forced_height = 18,
                    widget = wibox.widget.textbox,
                    buttons = gears.table.join(
                        awful.button({}, 1, function() 
                            cal_month = cal_month - 1
                            if cal_month < 1 then cal_month = 12; cal_year = cal_year - 1 end
                            render_calendar()
                        end)
                    ),
                },
                cal_month_year,
                {
                    text = "->",
                    font = m.font_popup,
                    align = "center",
                    valign = "center",
                    forced_height = 18,
                    widget = wibox.widget.textbox,
                    buttons = gears.table.join(
                        awful.button({}, 1, function() 
                            cal_month = cal_month + 1
                            if cal_month > 12 then cal_month = 1; cal_year = cal_year + 1 end
                            render_calendar()
                        end)
                    ),
                },
                layout = wibox.layout.align.horizontal,
            },
            cal_grid_widget,
            layout = wibox.layout.fixed.vertical,
            spacing = 12,
        },
        24, 24, 16, 20
    ),
    bg = "#1e1e2eee",
    border_width = 1,
    border_color = "#313244",
    shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 6) end,
    ontop = true,
    visible = false,
}

M.calendar_popup = calendar_popup
M.render_calendar = render_calendar

function M.setup_clock_click(clock_widget)
    clock_widget:buttons(gears.table.join(
        awful.button({}, 1, function()
            if calendar_popup.visible then
                popup_registry.hide_popup(calendar_popup)
            else
                popup_registry.show_popup(calendar_popup)
                cal_year, cal_month = tonumber(os.date("%Y")), tonumber(os.date("%m"))
                render_calendar()
                local s = awful.screen.focused().geometry
                calendar_popup.x = s.x + s.width - 275
                calendar_popup.y = s.y + 30
            end
        end)
    ))
end

function M.setup_clock_tooltip(clock_widget)
    local tooltip_text_widget = wibox.widget.textbox()
    tooltip_text_widget.font = m.font_popup
    tooltip_text_widget.align = "center"
    tooltip_text_widget.valign = "center"
    tooltip_text_widget.markup = '<span foreground="#cdd6f4">Sunday, 31 August 2025</span>'

    local clock_tooltip_popup = awful.popup {
        widget = {
            tooltip_text_widget,
            margins = 8,
            widget = wibox.container.margin,
        },
        bg = "#1e1e2eee",
        fg = "#cdd6f4",
        border_width = 1,
        border_color = "#313244",
        shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 4) end,
        ontop = true,
        visible = false,
        type = "tooltip",
    }

    clock_widget:connect_signal("mouse::enter", function()
        tooltip_text_widget.markup = '<span foreground="#cdd6f4">' .. os.date("%A, %d %B %Y") .. '</span>'
        popup_registry.show_tooltip(clock_tooltip_popup)

        -- Position tooltip same as calendar popup (right side, below wibar)
        local s = awful.screen.focused().geometry
        clock_tooltip_popup.x = s.x + s.width - 275
        clock_tooltip_popup.y = s.y + 30
    end)

    clock_widget:connect_signal("mouse::leave", function()
        gears.timer.start_new(0.1, function()
            local mouse_x, mouse_y = mouse.coords().x, mouse.coords().y
            local popup_geo = clock_tooltip_popup:geometry()
            if mouse_x < popup_geo.x or mouse_x > popup_geo.x + popup_geo.width or
               mouse_y < popup_geo.y or mouse_y > popup_geo.y + popup_geo.height then
                popup_registry.hide_tooltip(clock_tooltip_popup)
            end
            return false
        end)
    end)
end

function M.setup_autoclose()
    calendar_popup:connect_signal("mouse::leave", function()
        if not popup_registry.should_auto_hide() then return end
        gears.timer.start_new(0.3, function()
            local mouse_x, mouse_y = mouse.coords().x, mouse.coords().y
            local popup_geo = calendar_popup:geometry()
            if mouse_x < popup_geo.x or mouse_x > popup_geo.x + popup_geo.width or
               mouse_y < popup_geo.y or mouse_y > popup_geo.y + popup_geo.height then
                popup_registry.hide_popup(calendar_popup)
            end
            return false
        end)
    end)
end

return M
