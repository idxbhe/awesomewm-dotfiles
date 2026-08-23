# Class awful.widget.calendar_popup - awesome API documentation

**Module:** `classes.awful.widget.calendar_popup`  

> Source: [classes/awful.widget.calendar_popup.html](https://awesomewm.org/doc/api/classes/awful.widget.calendar_popup.html)

---

# Class `awful.widget.calendar_popup`

A calendar popup wibox

Display a month or year calendar popup using [calendar_popup.month](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.month>) or [calendar_popup.year](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.year>).

The calendar style can be tweaked by providing tables of style properties at creation: `style_year`, `style_month`, `style_yearheader`, `style_header`, `style_weekday`, `style_weeknumber`, `style_normal`, `style_focus` (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)).

The wibox accepts arguments for the calendar widget: `font`, `spacing`, `week_numbers`, `start_sunday`, `long_weekdays`. It also accepts the extra arguments `opacity`, `bg`, [screen](<../classes/screen.html#>) and `position`. `opacity` and `bg` apply to the wibox itself, they are mainly useful to manage opacity by setting `opacity` for the false opacity or setting `bg="#00000000"` for compositor opacity. The [screen](<../classes/screen.html#>) argument forces the display of the wibox to this screen (instead of the focused screen by default). The `position` argument is a two-characters string describing the screen alignment “[vertical][horizontal]”, e.g. “cc”, “tr”, “bl”, …

The wibox visibility can be changed calling the [toggle](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup:toggle>) method. The [attach](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup:attach>) method adds mouse bindings to an existing widget in order to toggle the display of the wibox.

### Info:

  * **Copyright** : 2017 getzze
  * **Author** : getzze


## [Functions](<#Functions>)

[awful.widget.calendar_popup.month (args)](<#awful.widget.calendar_popup.month>) | A month calendar wibox.  
---|---  
[awful.widget.calendar_popup.year (args)](<#awful.widget.calendar_popup.year>) | A year calendar wibox.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.calendar_style](<#beautiful.calendar_style>) | The generic calendar style table.  
---|---  
  
## [Tables](<#Tables>)

[awful.widget.calendar_popup.cell_properties](<#awful.widget.calendar_popup.cell_properties>) | Cell properties.  
---|---  
[awful.widget.calendar_popup.cell_flags](<#awful.widget.calendar_popup.cell_flags>) | Cell types (flags).  
  
## [Methods](<#Methods>)

[awful.widget.calendar_popup:call_calendar (offset, position, screen)](<#awful.widget.calendar_popup:call_calendar>) | Call the calendar with offset  
---|---  
[awful.widget.calendar_popup:toggle ()](<#awful.widget.calendar_popup:toggle>) | Toggle calendar visibility  
[awful.widget.calendar_popup:attach (widget[, position="tr"[, args={}]])](<#awful.widget.calendar_popup:attach>) | Attach the calendar to a widget to display at a specific position.  
  
  


## Functions

Methods 

**awful.widget.calendar_popup.month (args)**
    

A month calendar wibox.

It is highly customizable using the same options as for the widgets. The options are set once and for all at creation, though.
    
    
    local mytextclock = wibox.widget.textclock()
    local month_calendar = awful.widget.calendar_popup.month()
    month_calendar:attach( mytextclock, "tr" )
    

  * args Properties of the widget 
    * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Two-character position of the calendar in the screen 
    * screen [screen](<../classes/screen.html#>) Screen where to display the calendar 
    * opacity number Wibox opacity 
    * bg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Wibox background color 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Calendar font 
    * spacing number Calendar spacing 
    * margin number Margin around calendar widget 
    * week_numbers boolean Show weeknumbers 
    * start_sunday boolean Start week on Sunday 
    * long_weekdays boolean Format the weekdays with three characters instead of two 
    * style_month [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Container style for the month calendar (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_header [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the month calendar header (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_weekday [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the weekday cells (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_weeknumber [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the weeknumber cells (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_normal [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the normal day cells (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_focus [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the current day cell (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 


### Returns:

[wibox](<../classes/wibox.html#>) A wibox containing the calendar 

**awful.widget.calendar_popup.year (args)**
    

A year calendar wibox.

It is highly customizable using the same options as for the widgets. The options are set once and for all at creation, though.
    
    
    globalkeys = gears.table.join(globalkeys, awful.key(
            { modkey, "Control" }, "c",  function () year_calendar:toggle() end))
    

  * args Properties of the widget 
    * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Two-character position of the calendar in the screen 
    * screen [screen](<../classes/screen.html#>) Screen where to display the calendar 
    * opacity number Wibox opacity 
    * bg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Wibox background color 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Calendar font 
    * spacing number Calendar spacing 
    * margin number Margin around calendar widget 
    * week_numbers boolean Show weeknumbers 
    * start_sunday boolean Start week on Sunday 
    * long_weekdays boolean Format the weekdays with three characters instead of two 
    * style_year [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Container style for the year calendar (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_month [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Container style for the month calendar (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)). This field can also be called `style_monthheader`. 
    * style_yearheader [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the year calendar header (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_header [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the month calendar header (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_weekday [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the weekday cells (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_weeknumber [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the weeknumber cells (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_normal [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the normal day cells (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 
    * style_focus [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Cell style for the current day cell (see [cell_properties](<../classes/awful.widget.calendar_popup.html#awful.widget.calendar_popup.cell_properties>)) 


### Returns:

[wibox](<../classes/wibox.html#>) A wibox containing the calendar 


## Theme variables

**beautiful.calendar_style**
     The generic calendar style table.

Each table property can also be defined by `beautiful.calendar_[flag]_[property]=val`. 

### Type:

  * table cell_properties Table of cell style properties 


## Tables

**awful.widget.calendar_popup.cell_properties**
     Cell properties. 

### Fields:

  * markup Markup function or format string 
  * fg_color Text foreground color 
  * bg_color Text background color 
  * shape Cell shape 
  * padding Cell padding 
  * border_width Calendar border width 
  * border_color Calendar border color 
  * opacity Cell opacity 


**awful.widget.calendar_popup.cell_flags**
     Cell types (flags). 

### Fields:

  * year Year calendar grid properties table 
  * month Month calendar grid properties table 
  * yearheader Year header cell properties table 
  * header Month header cell properties table (called `monthheader` for a year calendar) 
  * weekday Weekday cell properties table 
  * weeknumber Weeknumber cell properties table 
  * normal Normal day cell properties table 
  * focus Current day cell properties table 


## Methods

**awful.widget.calendar_popup:call_calendar (offset, position, screen)**
     Call the calendar with offset 

  * offset number Offset with respect to current month or year 
  * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Two-character position of the calendar in the screen 
  * screen [screen](<../classes/screen.html#>) Screen where to display the calendar 


### Returns:

[wibox](<../classes/wibox.html#>) The wibox calendar 

**awful.widget.calendar_popup:toggle ()**
     Toggle calendar visibility 
**awful.widget.calendar_popup:attach (widget[, position="tr"[, args={}]])**
    

Attach the calendar to a widget to display at a specific position.
    
    
    local mytextclock = wibox.widget.textclock()
    local month_calendar = awful.widget.calendar_popup.month()
    month_calendar:attach(mytextclock, 'tr')
    

  * widget Widget to attach the calendar 
  * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Two characters string defining the position on the screen (_default_ "tr") 
  * args Additional options 
    * on_hover bool Show popup during mouse hover (_default_ true) 


### Returns:

[wibox](<../classes/wibox.html#>) The wibox calendar