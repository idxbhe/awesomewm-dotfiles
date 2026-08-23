# Class wibox.widget.calendar - awesome API documentation

**Module:** `classes.wibox.widget.calendar`  

> Source: [classes/wibox.widget.calendar.html](https://awesomewm.org/doc/api/classes/wibox.widget.calendar.html)

---

# Class `wibox.widget.calendar`

A calendar widget

This module defines two widgets: a month calendar and a year calendar

The two widgets have a [date](<../classes/wibox.widget.calendar.html#wibox.widget.calendar.date>) property, in the form of a table {day=[number|nil], month=[number|nil], year=[number]}.

The [year](<../classes/wibox.widget.calendar.html#wibox.widget.calendar.year>) widget displays the whole specified year, e.g. {year=2006}.

The [month](<../classes/wibox.widget.calendar.html#wibox.widget.calendar.month>) widget displays the calendar for the specified month, e.g. {month=12, year=2006}, highlighting the specified day if the day is provided in the date, e.g. {day=22, month=12, year=2006}.

Cell and container styles can be overridden using the [fn_embed](<../classes/wibox.widget.calendar.html#wibox.widget.calendar.fn_embed>) callback function which is called before adding the widgets to the layouts. The [fn_embed](<../classes/wibox.widget.calendar.html#wibox.widget.calendar.fn_embed>) function takes three arguments, the original widget, the flag ([string](<https://www.lua.org/manual/5.1/manual.html#5.4>) used to identified the widget) and the date ([table](<https://www.lua.org/manual/5.1/manual.html#5.5>)). It returns another widget, embedding (and modifying) the original widget.

![Usage example](../images/AUTOGEN_wibox_widget_defaults_calendar.svg)

### Usage:
    
    local cal = wibox.widget.calendar.month(os.date('*t'))
    


### Info:

  * **Copyright** : 2017 getzze
  * **Author** : getzze


## [Functions](<#Functions>)

[wibox.widget.calendar.month (date, font)](<#wibox.widget.calendar.month>) | A month calendar widget.  
---|---  
[wibox.widget.calendar.year (date, font)](<#wibox.widget.calendar.year>) | A year calendar widget.  
  
## [Object properties](<#Object_properties>)

[date](<#wibox.widget.calendar.date>) | The calendar date.  
---|---  
[font](<#wibox.widget.calendar.font>) | The calendar font.  
[spacing](<#wibox.widget.calendar.spacing>) | The calendar spacing.  
[week_numbers](<#wibox.widget.calendar.week_numbers>) | Display the calendar week numbers.  
[start_sunday](<#wibox.widget.calendar.start_sunday>) | Start the week on Sunday.  
[long_weekdays](<#wibox.widget.calendar.long_weekdays>) | Format the weekdays with three characters instead of two  
[fn_embed](<#wibox.widget.calendar.fn_embed>) | The widget encapsulating function.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.calendar_font](<#beautiful.calendar_font>) | The calendar font.  
---|---  
[beautiful.calendar_spacing](<#beautiful.calendar_spacing>) | The calendar spacing.  
[beautiful.calendar_week_numbers](<#beautiful.calendar_week_numbers>) | Display the calendar week numbers.  
[beautiful.calendar_start_sunday](<#beautiful.calendar_start_sunday>) | Start the week on Sunday.  
[beautiful.calendar_long_weekdays](<#beautiful.calendar_long_weekdays>) | Format the weekdays with three characters instead of two  
  
  


## Functions

Methods 

**wibox.widget.calendar.month (date, font)**
     A month calendar widget.

A calendar widget is a grid containing the calendar for one month. If the day is specified in the date, its cell is highlighted.

![Usage example](../images/AUTOGEN_wibox_widget_calendar_month.svg)

  * date Date of the calendar 
    * year number Date year 
    * month number Date month 
    * day number or nil Date day 
  * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Font of the calendar (_default_ "Monospace 10") 


### Returns:

[widget](<../classes/wibox.widget.html>) The month calendar widget 

**wibox.widget.calendar.year (date, font)**
     A year calendar widget.

A calendar widget is a grid containing the calendar for one year.

![Usage example](../images/AUTOGEN_wibox_widget_calendar_year.svg)

  * date Date of the calendar 
    * year number Date year 
    * month number or nil Date month 
    * day number or nil Date day 
  * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Font of the calendar (_default_ "Monospace 10") 


### Returns:

[widget](<../classes/wibox.widget.html>) The year calendar widget 


### Usage:
    
    local cal = wibox.widget {
        date         = os.date('*t'),
        font         = 'Monospace 8',
        spacing      = 2,
        week_numbers = false,
        start_sunday = false,
        widget       = wibox.widget.calendar.year
    }


## Object properties

**date**
     The calendar date.

A table representing the date {day=[number|nil], month=[number|nil], year=[number]}.

E.g.. {day=21, month=2, year=2005}, {month=2, year=2005}, {year=2005} 

### Type:

  * table [date](<../classes/wibox.widget.calendar.html#wibox.widget.calendar.date>) Date table. 


**font**
     The calendar font.

Choose a monospace font for a better rendering.

![Usage example](../images/AUTOGEN_wibox_widget_calendar_font.svg)

### Type:

  * string Font of the calendar (_default_ "Monospace 10") 


### Usage:
    
    local cal = wibox.widget.calendar.month(
        os.date('*t'), 'sans 12')


**spacing**
     The calendar spacing.

The spacing between cells in the month. The spacing between months in a year calendar is twice this value. 

### Type:

  * number Spacing of the grid (_default_ 5) 


**week_numbers**
     Display the calendar week numbers.

![Usage example](../images/AUTOGEN_wibox_widget_calendar_week_numbers.svg)

### Type:

  * boolean Display week numbers (_default_ false) 


### Usage:
    
    local cal = wibox.widget {
        date         = os.date('*t'),
        font         = 'Monospace 10',
        week_numbers = true,
        widget       = wibox.widget.calendar.month
    }


**start_sunday**
     Start the week on Sunday.

![Usage example](../images/AUTOGEN_wibox_widget_calendar_start_sunday.svg)

### Type:

  * boolean Start the week on Sunday (_default_ false) 


### Usage:
    
    local cal = wibox.widget {
        date         = os.date('*t'),
        font         = 'Monospace 10',
        start_sunday = true,
        widget       = wibox.widget.calendar.month
    }


**long_weekdays**
     Format the weekdays with three characters instead of two

![Usage example](../images/AUTOGEN_wibox_widget_calendar_long_weekdays.svg)

### Type:

  * boolean Use three characters for the weekdays instead of two (_default_ false) 


### Usage:
    
    local cal = wibox.widget {
        date          = os.date('*t'),
        font          = 'Monospace 10',
        long_weekdays = true,
        widget        = wibox.widget.calendar.month
    }


**fn_embed**
     The widget encapsulating function.

Function that takes a widget, flag ([string](<https://www.lua.org/manual/5.1/manual.html#5.4>)) and date ([table](<https://www.lua.org/manual/5.1/manual.html#5.5>)) as argument and returns a widget encapsulating the input widget.

Default value: function (widget, flag, date) return widget end

It is used to add a container to the grid layout and to the cells:

![Usage example](../images/AUTOGEN_wibox_widget_calendar_fn_embed_cell.svg)

### Type:

  * function Function to embed the widget depending on its flag 


### Usage:
    
    local styles = {}
    local function rounded_shape(size, partial)
        if partial then
            return function(cr, width, height)
                       gears.shape.partially_rounded_rect(cr, width, height,
                            false, true, false, true, 5)
                   end
        else
            return function(cr, width, height)
                       gears.shape.rounded_rect(cr, width, height, size)
                   end
        end
    end
    styles.month   = { padding      = 5,
                       bg_color     = '#555555',
                       border_width = 2,
                       shape        = rounded_shape(10)
    }
    styles.normal  = { shape    = rounded_shape(5) }
    styles.focus   = { fg_color = '#000000',
                       bg_color = '#ff9800',
                       markup   = function(t) return '<b>' .. t .. '</b>' end,
                       shape    = rounded_shape(5, true)
    }
    styles.header  = { fg_color = '#de5e1e',
                       markup   = function(t) return '<b>' .. t .. '</b>' end,
                       shape    = rounded_shape(10)
    }
    styles.weekday = { fg_color = '#7788af',
                       markup   = function(t) return '<b>' .. t .. '</b>' end,
                       shape    = rounded_shape(5)
    }
    local function decorate_cell(widget, flag, date)
        if flag=='monthheader' and not styles.monthheader then
            flag = 'header'
        end
        local props = styles[flag] or {}
        if props.markup and widget.get_text and widget.set_markup then
            widget:set_markup(props.markup(widget:get_text()))
        end
        -- Change bg color for weekends
        local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
        local weekday = tonumber(os.date('%w', os.time(d)))
        local default_bg = (weekday==0 or weekday==6) and '#232323' or '#383838'
        local ret = wibox.widget {
            {
                widget,
                margins = (props.padding or 2) + (props.border_width or 0),
                widget  = wibox.container.margin
            },
            shape              = props.shape,
            shape_border_color = props.border_color or '#b9214f',
            shape_border_width = props.border_width or 0,
            fg                 = props.fg_color or '#999999',
            bg                 = props.bg_color or default_bg,
            widget             = wibox.container.background
        }
        return ret
    end
    local cal = wibox.widget {
        date     = os.date('*t'),
        fn_embed = decorate_cell,
        widget   = wibox.widget.calendar.month
    }


## Theme variables

**beautiful.calendar_font**
     The calendar font. 

### Type:

  * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Font of the calendar 


**beautiful.calendar_spacing**
     The calendar spacing. 

### Type:

  * spacing number Spacing of the grid (twice this value for inter-month spacing) 


**beautiful.calendar_week_numbers**
     Display the calendar week numbers. 

### Type:

  * boolean Display week numbers 


**beautiful.calendar_start_sunday**
     Start the week on Sunday. 

### Type:

  * boolean Start the week on Sunday 


**beautiful.calendar_long_weekdays**
     Format the weekdays with three characters instead of two 

### Type:

  * boolean Use three characters for the weekdays instead of two