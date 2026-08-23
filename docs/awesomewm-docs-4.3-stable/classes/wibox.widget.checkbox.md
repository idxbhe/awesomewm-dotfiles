# Class wibox.widget.checkbox - awesome API documentation

**Module:** `classes.wibox.widget.checkbox`  

> Source: [classes/wibox.widget.checkbox.html](https://awesomewm.org/doc/api/classes/wibox.widget.checkbox.html)

---

# Class `wibox.widget.checkbox`

A boolean display widget.

If necessary, themes can implement custom shape:

![Usage example](../images/AUTOGEN_wibox_widget_checkbox_custom.svg)
    
    
    wibox.widget {
        checked       = true,
        color         = beautiful.bg_normal,
        paddings      = 2,
        check_shape   = function(cr, width, height)
            local rs = math.min(width, height)
            cr:move_to( 0  , 0  )
            cr:line_to( rs , 0  )
            cr:move_to( 0  , 0  )
            cr:line_to( 0  , rs )
            cr:move_to( 0  , rs )
            cr:line_to( rs , rs )
            cr:move_to( rs , 0  )
            cr:line_to( rs , rs )
            cr:move_to( 0  , 0  )
            cr:line_to( rs , rs )
            cr:move_to( 0  , rs )
            cr:line_to( rs , 0  )
        end,
        check_border_color = '#ff0000',
        check_color        = '#00000000',
        check_border_width = 1,
        widget             = wibox.widget.checkbox
    }
    

![Usage example](../images/AUTOGEN_wibox_widget_defaults_checkbox.svg)

### Usage:
    
    wibox.widget {
        checked       = true,
        color         = beautiful.bg_normal,
        paddings      = 2,
        shape         = gears.shape.circle,
        widget        = wibox.widget.checkbox
    }
    


### Info:

  * **Copyright** : 2010 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Valle


## [Object properties](<#Object_properties>)

[border_width](<#wibox.widget.checkbox.border_width>) | The outer (unchecked area) border width.  
---|---  
[bg](<#wibox.widget.checkbox.bg>) | The outer (unchecked area) background color, pattern or gradient.  
[border_color](<#wibox.widget.checkbox.border_color>) | The outer (unchecked area) border color.  
[check_border_color](<#wibox.widget.checkbox.check_border_color>) | The checked part border color.  
[check_border_width](<#wibox.widget.checkbox.check_border_width>) | The checked part border width.  
[check_color](<#wibox.widget.checkbox.check_color>) | The checked part filling color.  
[shape](<#wibox.widget.checkbox.shape>) | The outer (unchecked area) shape.  
[check_shape](<#wibox.widget.checkbox.check_shape>) | The checked part shape.  
[paddings](<#wibox.widget.checkbox.paddings>) | The padding between the outline and the progressbar.  
[color](<#wibox.widget.checkbox.color>) | The checkbox color.  
[checked](<#wibox.widget.checkbox.checked>) | If the checkbox is checked.  
[color](<#wibox.widget.checkbox.color>) | The checkbox color.  
[forced_height](<#wibox.widget.checkbox.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.checkbox.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.checkbox.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.checkbox.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.checkbox_border_width](<#beautiful.checkbox_border_width>) | The outer (unchecked area) border width.  
---|---  
[beautiful.checkbox_bg](<#beautiful.checkbox_bg>) | The outer (unchecked area) background color, pattern or gradient.  
[beautiful.checkbox_border_color](<#beautiful.checkbox_border_color>) | The outer (unchecked area) border color.  
[beautiful.checkbox_check_border_color](<#beautiful.checkbox_check_border_color>) | The checked part border color.  
[beautiful.checkbox_check_border_width](<#beautiful.checkbox_check_border_width>) | The checked part border width.  
[beautiful.checkbox_check_color](<#beautiful.checkbox_check_color>) | The checked part filling color.  
[beautiful.checkbox_shape](<#beautiful.checkbox_shape>) | The outer (unchecked area) shape.  
[beautiful.checkbox_check_shape](<#beautiful.checkbox_check_shape>) | The checked part shape.  
[beautiful.checkbox_paddings](<#beautiful.checkbox_paddings>) | The padding between the outline and the progressbar.  
[beautiful.checkbox_color](<#beautiful.checkbox_color>) | The checkbox color.  
  
## [Methods](<#Methods>)

[wibox.widget.checkbox:get_all_children ()](<#wibox.widget.checkbox:get_all_children>) | Get all direct and indirect children widgets.  
---|---  
[wibox.widget.checkbox:setup (args)](<#wibox.widget.checkbox:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.checkbox:buttons (_buttons)](<#wibox.widget.checkbox:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.checkbox:emit_signal_recursive (signal_name, ...)](<#wibox.widget.checkbox:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.checkbox:emit_signal (name, ...)](<#wibox.widget.checkbox:emit_signal>) | Emit a signal.  
[wibox.widget.checkbox:connect_signal (name, func)](<#wibox.widget.checkbox:connect_signal>) | Connect to a signal.  
[wibox.widget.checkbox:weak_connect_signal (name, func)](<#wibox.widget.checkbox:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Object properties

**border_width**
     The outer (unchecked area) border width. 
**bg**
     The outer (unchecked area) background color, pattern or gradient.

![Usage example](../images/AUTOGEN_wibox_widget_checkbox_bg.svg)

### Usage:
    
    wibox.widget {
        checked            = true,
        color              = beautiful.bg_normal,
        bg                 = '#ff00ff',
        border_width       = 3,
        paddings           = 4,
        border_color       = '#0000ff',
        check_color        = '#ff0000',
        check_border_color = '#ffff00',
        check_border_width = 1,
        widget             = wibox.widget.checkbox
    }


**border_color**
     The outer (unchecked area) border color. 
**check_border_color**
     The checked part border color. 
**check_border_width**
     The checked part border width. 
**check_color**
     The checked part filling color. 
**shape**
     The outer (unchecked area) shape.

![Usage example](../images/AUTOGEN_wibox_widget_checkbox_shape.svg)

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 


### Usage:
    
    for _, s in ipairs {'rectangle', 'circle', 'losange', 'octogon'} do
        wibox.widget {
            checked       = true,
            color         = beautiful.bg_normal,
            paddings      = 2,
            shape         = gears.shape[s],
            widget        = wibox.widget.checkbox
        }
    end


**check_shape**
     The checked part shape. If none is set, then the [shape](<../classes/wibox.widget.checkbox.html#wibox.widget.checkbox.shape>) property will be used.

![Usage example](../images/AUTOGEN_wibox_widget_checkbox_check_shape.svg)

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 


### Usage:
    
    for _, s in ipairs {'rectangle', 'circle', 'losange', 'octogon'} do
        wibox.widget {
            checked       = true,
            color         = beautiful.bg_normal,
            paddings      = 2,
            check_shape   = gears.shape[s],
            widget        = wibox.widget.checkbox
        }
    end


**paddings**
     The padding between the outline and the progressbar. 

### Type:

  * paddings A number or a table 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


**color**
     The checkbox color. This will be used for the unchecked part border color and the checked part filling color. Note that [check_color](<../classes/wibox.widget.checkbox.html#wibox.widget.checkbox.check_color>) and [border_color](<../classes/wibox.widget.checkbox.html#wibox.widget.checkbox.border_color>) have priority over this property. 
**checked**
     If the checkbox is checked. 

### Type:

  * boolean


**color**
     The checkbox color. 
**forced_height**
     Force a widget height. 

### Type:

  * height number or nil The height (`nil` for automatic) 


**forced_width**
     Force a widget width. 

### Type:

  * width number or nil The width (`nil` for automatic) 


**opacity**
     The widget opacity (transparency). 

### Type:

  * opacity number The opacity (between 0 and 1) (_default_ 1) 


**visible**
     The widget visibility. 

### Type:

  * boolean


## Signals

**widget::layout_changed**
     When the layout (size) change. This signal is emitted when the previous results of `:layout()` and `:fit()` are no longer valid. Unless this signal is emitted, `:layout()` and `:fit()` must return the same result when called with the same arguments. 

### See also:

[widget::redraw_needed](<../classes/wibox.widget.checkbox.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.checkbox.html#widget::layout_changed>) 

**button::press**
     When a mouse button is pressed over the widget. 

### Arguments:

  * lx number The horizontal position relative to the (0,0) position in the widget. 
  * ly number The vertical position relative to the (0,0) position in the widget. 
  * button number The button number. 
  * mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifiers (mod4, mod1 (alt), Control, Shift) 
  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 

**button::release**
     When a mouse button is released over the widget. 

### Arguments:

  * lx number The horizontal position relative to the (0,0) position in the widget. 
  * ly number The vertical position relative to the (0,0) position in the widget. 
  * button number The button number. 
  * mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifiers (mod4, mod1 (alt), Control, Shift) 
  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 

**mouse::enter**
     When the mouse enter a widget. 

### Arguments:

  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 

**mouse::leave**
     When the mouse leave a widget. 

### Arguments:

  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 


## Theme variables

**beautiful.checkbox_border_width**
     The outer (unchecked area) border width. 
**beautiful.checkbox_bg**
     The outer (unchecked area) background color, pattern or gradient. 
**beautiful.checkbox_border_color**
     The outer (unchecked area) border color. 
**beautiful.checkbox_check_border_color**
     The checked part border color. 
**beautiful.checkbox_check_border_width**
     The checked part border width. 
**beautiful.checkbox_check_color**
     The checked part filling color. 
**beautiful.checkbox_shape**
     The outer (unchecked area) shape. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.checkbox_check_shape**
     The checked part shape. If none is set, then the [shape](<../classes/wibox.widget.checkbox.html#wibox.widget.checkbox.shape>) property will be used. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.checkbox_paddings**
     The padding between the outline and the progressbar. 

### Type:

  * paddings A number or a table 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


**beautiful.checkbox_color**
     The checkbox color. This will be used for the unchecked part border color and the checked part filling color. Note that [check_color](<../classes/wibox.widget.checkbox.html#wibox.widget.checkbox.check_color>) and [border_color](<../classes/wibox.widget.checkbox.html#wibox.widget.checkbox.border_color>) have priority over this property. 

## Methods

**wibox.widget.checkbox:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.checkbox:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.checkbox:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.checkbox:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.checkbox:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.checkbox:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.checkbox:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.