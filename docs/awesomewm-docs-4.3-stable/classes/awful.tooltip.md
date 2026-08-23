# Class awful.tooltip - awesome API documentation

**Module:** `classes.awful.tooltip`  

> Source: [classes/awful.tooltip.html](https://awesomewm.org/doc/api/classes/awful.tooltip.html)

---

# Class `awful.tooltip`

Tooltip module for awesome objects.

A tooltip is a small hint displayed when the mouse cursor hovers over a specific item. In awesome, a tooltip can be linked with almost any object having a `:connect_signal()` method and receiving `mouse::enter` and `mouse::leave` signals.

##  How to create a tooltip?

![Usage example](../images/AUTOGEN_awful_tooltip_textclock.svg)
    
    
    local mytextclock = wibox.widget.textclock()
    
    local myclock_t = awful.tooltip {
        objects        = { mytextclock },
        timer_function = function()
            return os.date('Today is %A %B %d %Y\nThe time is %T')
        end,
    }
    

Alternatively, you can use `mouse::enter` signal:

![Usage example](../images/AUTOGEN_awful_tooltip_textclock2.svg)
    
    
    local mytextclock = wibox.widget.textclock()
    
    local myclock_t = awful.tooltip { }
    
    myclock_t:add_to_object(mytextclock)
    
    mytextclock:connect_signal('mouse::enter', function()
        myclock_t.text = os.date('Today is %A %B %d %Y\nThe time is %T')
    end)
    

##  How to create a tooltip without objects?

![Usage example](../images/AUTOGEN_awful_tooltip_mouse.svg)
    
    
    local tt = awful.tooltip {
        text = 'A tooltip!',
        visible = true,
    }
    
    tt.bg = beautiful.bg_normal
    

##  How to add the same tooltip to multiple objects?
    
    
    myclock_t:add_to_object(obj1)
    myclock_t:add_to_object(obj2)
    

Now the same tooltip is attached to `myclock`, `obj1`, `obj2`.

##  How to remove a tooltip from several objects?
    
    
    myclock_t:remove_from_object(obj1)
    myclock_t:remove_from_object(obj2)
    

Now the same tooltip is only attached to `myclock`.

### Info:

  * **Copyright** : 2009 Sébastien Gross
  * **Author** : Sébastien Gross <seb•ɱɩɲʋʃ•awesome•ɑƬ•chezwam•ɖɵʈ•org>


## [Functions](<#Functions>)

[awful.tooltip (args)](<#awful.tooltip>) | Create a new tooltip and link it to a widget.  
---|---  
  
## [Object properties](<#Object_properties>)

[wibox](<#awful.tooltip.wibox>) | The wibox containing the tooltip widgets.  
---|---  
[visible](<#awful.tooltip.visible>) | Is the tooltip visible?  
[align](<#awful.tooltip.align>) | The horizontal alignment.  
[shape](<#awful.tooltip.shape>) | The shape of the tooltip window.  
[mode](<#awful.tooltip.mode>) | Set the tooltip positioning mode.  
[preferred_positions](<#awful.tooltip.preferred_positions>) | The preferred positions when in `outside` mode.  
[preferred_alignments](<#awful.tooltip.preferred_alignments>) | The preferred alignment when using the `outside` mode.  
[text](<#awful.tooltip.text>) | Change displayed text.  
[markup](<#awful.tooltip.markup>) | Change displayed markup.  
[timeout](<#awful.tooltip.timeout>) | Change the tooltip’s update interval.  
[margins](<#awful.tooltip.margins>) | Set all margins around the tooltip textbox  
[border_width](<#awful.tooltip.border_width>) | The border width.  
[border_color](<#awful.tooltip.border_color>) | The border color.  
[margins_leftright](<#awful.tooltip.margins_leftright>) | Set the margins around the left and right of the tooltip textbox  
[margins_topbottom](<#awful.tooltip.margins_topbottom>) | Set the margins around the top and bottom of the tooltip textbox  
  
## [Theme variables](<#Theme_variables>)

[beautiful.tooltip_border_color](<#beautiful.tooltip_border_color>) | The tooltip border color.  
---|---  
[beautiful.tooltip_bg](<#beautiful.tooltip_bg>) | The tooltip background color.  
[beautiful.tooltip_fg](<#beautiful.tooltip_fg>) | The tooltip foregound (text) color.  
[beautiful.tooltip_font](<#beautiful.tooltip_font>) | The tooltip font.  
[beautiful.tooltip_border_width](<#beautiful.tooltip_border_width>) | The tooltip border width.  
[beautiful.tooltip_opacity](<#beautiful.tooltip_opacity>) | The tooltip opacity.  
[beautiful.tooltip_shape](<#beautiful.tooltip_shape>) | The default tooltip shape.  
[beautiful.tooltip_align](<#beautiful.tooltip_align>) | The default tooltip alignment.  
  
## [Methods](<#Methods>)

[awful.tooltip:set_shape (s)](<#awful.tooltip:set_shape>) | Set the tooltip shape.  
---|---  
[awful.tooltip:add_to_object (self, obj)](<#awful.tooltip:add_to_object>) | Add tooltip to an object.  
[awful.tooltip:remove_from_object (self, obj)](<#awful.tooltip:remove_from_object>) | Remove tooltip from an object.  
  
  


## Functions

Methods 

**awful.tooltip (args)**
     Create a new tooltip and link it to a widget. Tooltips emit `property::visible` when their visibility changes. 

  * args Arguments for tooltip creation. 
    * timer_function function A function to dynamically set the tooltip text. Its return value will be passed to `wibox.widget.textbox.set_markup`. 
    * timeout number The timeout value for `timer_function`. (_default_ 1) 
    * objects [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A list of objects linked to the tooltip. (_optional_) 
    * delay_show number Delay showing the tooltip by this many seconds. (_optional_) 
    * margin_leftright integer The left/right margin for the text. (_default_ apply_dpi(5)) 
    * margin_topbottom integer The top/bottom margin for the text. (_default_ apply_dpi(3)) 
    * shape gears.shape The shape (_default_ nil) 
    * bg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The background color (_optional_) 
    * fg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The foreground color (_optional_) 
    * border_color [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The tooltip border color (_optional_) 
    * border_width number The tooltip border width (_optional_) 
    * align [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The horizontal alignment (_optional_) 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The tooltip font (_optional_) 
    * opacity number The tooltip opacity (_optional_) 


### Returns:

[awful.tooltip](<../classes/awful.tooltip.html#>) The created tooltip. 


### See also:

  * [add_to_object](<../classes/awful.tooltip.html#awful.tooltip:add_to_object>)
  * [timeout](<../classes/awful.tooltip.html#awful.tooltip.timeout>)
  * [text](<../classes/awful.tooltip.html#awful.tooltip.text>)
  * [markup](<../classes/awful.tooltip.html#awful.tooltip.markup>)
  * [align](<../classes/awful.tooltip.html#awful.tooltip.align>)


## Object properties

**wibox**
     The wibox containing the tooltip widgets. 

### Type:

  * wibox ` 


**visible**
     Is the tooltip visible? 

### Type:

  * boolean


**align**
    

The horizontal alignment.

This is valid for the mouse mode only. For the outside mode, use [preferred_positions](<../classes/awful.tooltip.html#awful.tooltip.preferred_positions>).

![Usage example](../images/AUTOGEN_awful_tooltip_align.svg)

![Usage example](../images/AUTOGEN_awful_tooltip_align2.svg)

The following values are valid:

  * top_left
  * left
  * bottom_left
  * right
  * top_right
  * bottom_right
  * bottom
  * top


### See also:

  * [beautiful.tooltip_align](<../classes/awful.tooltip.html#beautiful.tooltip_align>)
  * [mode](<../classes/awful.tooltip.html#awful.tooltip.mode>)
  * [preferred_positions](<../classes/awful.tooltip.html#awful.tooltip.preferred_positions>)


**shape**
     The shape of the tooltip window. If the shape require some parameters, use [set_shape](<../classes/awful.tooltip.html#awful.tooltip:set_shape>).

![Usage example](../images/AUTOGEN_awful_tooltip_shape.svg)

### See also:

  * [gears.shape](<../libraries/gears.shape.html#>)
  * [set_shape](<../classes/awful.tooltip.html#awful.tooltip:set_shape>)
  * [beautiful.tooltip_shape](<../classes/awful.tooltip.html#beautiful.tooltip_shape>)


**mode**
    

Set the tooltip positioning mode. This affects how the tooltip is placed. By default, the tooltip is [align](<../classes/awful.tooltip.html#awful.tooltip.align>)ed close to the mouse cursor. It is also possible to place the tooltip relative to the widget geometry.

**mouse:**

![Usage example](../images/AUTOGEN_awful_tooltip_mode.svg)

**outside:**

![Usage example](../images/AUTOGEN_awful_tooltip_mode2.svg)

Valid modes are:

  * “mouse”: Next to the mouse cursor
  * “outside”: Outside of the widget


### Type:

  * string


**preferred_positions**
    

The preferred positions when in `outside` mode.

![Usage example](../images/AUTOGEN_awful_tooltip_preferred_positions.svg)

If the tooltip fits on multiple sides of the drawable, then this defines the priority.

The valid table values are:

  * “top”
  * “right”
  * “left”
  * “bottom”


The default is:
    
    
    {"top", "right", "left", "bottom"}
    

### Type:

  * preferred_positions [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The position, ordered by priorities 


### See also:

  * [align](<../classes/awful.tooltip.html#awful.tooltip.align>)
  * [mode](<../classes/awful.tooltip.html#awful.tooltip.mode>)
  * [preferred_alignments](<../classes/awful.tooltip.html#awful.tooltip.preferred_alignments>)


**preferred_alignments**
    

The preferred alignment when using the `outside` mode.

The values of the table are ordered by priority, the first one that fits will be used.

**front:**

![Usage example](../images/AUTOGEN_awful_tooltip_preferred_alignment.svg)

**middle:**

![Usage example](../images/AUTOGEN_awful_tooltip_preferred_alignment2.svg)

**back:**

![Usage example](../images/AUTOGEN_awful_tooltip_preferred_alignment3.svg)

The valid table values are:

  * front
  * middle
  * back


The default is:
    
    
    {"front", "back", "middle"}
    

### Type:

  * string


### See also:

[preferred_positions](<../classes/awful.tooltip.html#awful.tooltip.preferred_positions>) 

**text**
     Change displayed text. 

### Type:

  * self [tooltip](<../classes/awful.tooltip.html>) The tooltip object. 
  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) New tooltip text, passed to `wibox.widget.textbox.set_text`. 


### See also:

[wibox.widget.textbox](<../classes/wibox.widget.textbox.html#>) 

**markup**
     Change displayed markup. 

### Type:

  * self [tooltip](<../classes/awful.tooltip.html>) The tooltip object. 
  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) New tooltip markup, passed to `wibox.widget.textbox.set_markup`. 


### See also:

[wibox.widget.textbox](<../classes/wibox.widget.textbox.html#>) 

**timeout**
     Change the tooltip’s update interval. 

### Type:

  * self [tooltip](<../classes/awful.tooltip.html>) A tooltip object. 
  * timeout number The timeout value. 


**margins**
     Set all margins around the tooltip textbox

![Usage example](../images/AUTOGEN_awful_tooltip_margins.svg)

### Type:

  * self [tooltip](<../classes/awful.tooltip.html>) A tooltip object 
  * New number margins value 


**border_width**
     The border width.

![Usage example](../images/AUTOGEN_awful_tooltip_border_width.svg)

### Type:

  * number


**border_color**
     The border color.

![Usage example](../images/AUTOGEN_awful_tooltip_border_color.svg)
**margins_leftright**
     Set the margins around the left and right of the tooltip textbox

![Usage example](../images/AUTOGEN_awful_tooltip_margins_leftright.svg)

### Type:

  * self [tooltip](<../classes/awful.tooltip.html>) A tooltip object 
  * New number margins value 


**margins_topbottom**
     Set the margins around the top and bottom of the tooltip textbox

![Usage example](../images/AUTOGEN_awful_tooltip_margins_topbottom.svg)

### Type:

  * self [tooltip](<../classes/awful.tooltip.html>) A tooltip object 
  * New number margins value 


## Theme variables

**beautiful.tooltip_border_color**
     The tooltip border color. 
**beautiful.tooltip_bg**
     The tooltip background color. 
**beautiful.tooltip_fg**
     The tooltip foregound (text) color. 
**beautiful.tooltip_font**
     The tooltip font. 
**beautiful.tooltip_border_width**
     The tooltip border width. 
**beautiful.tooltip_opacity**
     The tooltip opacity. 
**beautiful.tooltip_shape**
     The default tooltip shape. The default shape for all tooltips is a rectangle. However, by setting this variable they can default to rounded rectangle or stretched octogons. 

### Type:

  * shape function A [gears.shape](<../libraries/gears.shape.html#>) compatible function (_default_ gears.shape.rectangle) 


### See also:

  * [shape](<../classes/awful.tooltip.html#awful.tooltip.shape>)
  * [gears.shape](<../libraries/gears.shape.html#>)


**beautiful.tooltip_align**
     The default tooltip alignment. 

### Type:

  * string


### See also:

[align](<../classes/awful.tooltip.html#awful.tooltip.align>) 


## Methods

**awful.tooltip:set_shape (s)**
     Set the tooltip shape. All other arguments will be passed to the shape function. 

  * s gears.shape The shape 


### See also:

  * [shape](<../classes/awful.tooltip.html#awful.tooltip.shape>)
  * [gears.shape](<../libraries/gears.shape.html#>)


**awful.tooltip:add_to_object (self, obj)**
     Add tooltip to an object. 

  * self [tooltip](<../classes/awful.tooltip.html>) The tooltip. 
  * obj [gears.object](<../classes/gears.object.html#>) An object with `mouse::enter` and `mouse::leave` signals. 


**awful.tooltip:remove_from_object (self, obj)**
     Remove tooltip from an object. 

  * self [tooltip](<../classes/awful.tooltip.html>) The tooltip. 
  * obj [gears.object](<../classes/gears.object.html#>) An object with `mouse::enter` and `mouse::leave` signals.