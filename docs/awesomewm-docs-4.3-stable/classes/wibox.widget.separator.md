# Class wibox.widget.separator - awesome API documentation

**Module:** `classes.wibox.widget.separator`  

> Source: [classes/wibox.widget.separator.html](https://awesomewm.org/doc/api/classes/wibox.widget.separator.html)

---

# Class `wibox.widget.separator`

A flexible separator widget.

By default, this widget display a simple line, but can be extended by themes (or directly) to display much more complex visuals.

This widget is mainly intended to be used alongside the `spacing_widget` property supported by various layouts such as:

  * [wibox.layout.fixed](<../classes/wibox.layout.fixed.html#>)
  * [wibox.layout.flex](<../classes/wibox.layout.flex.html#>)
  * [wibox.layout.ratio](<../classes/wibox.layout.ratio.html#>)


When used with these layouts, it is also possible to provide custom clipping functions. This is useful when the layout has overlapping widgets (negative spacing).

![Usage example](../images/AUTOGEN_wibox_widget_defaults_separator.svg)

### Usage:
    
    wibox.widget {
        widget = wibox.widget.separator
    }
    


### Info:

  * **Copyright** : 2014, 2017 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Object properties](<#Object_properties>)

[orientation](<#wibox.widget.separator.orientation>) | The separator’s orientation.  
---|---  
[thickness](<#wibox.widget.separator.thickness>) | The separator’s thickness.  
[shape](<#wibox.widget.separator.shape>) | The separator’s shape.  
[span_ratio](<#wibox.widget.separator.span_ratio>) | The relative percentage covered by the bar.  
[color](<#wibox.widget.separator.color>) | The separator’s color.  
[border_color](<#wibox.widget.separator.border_color>) | The separator’s border color.  
[border_width](<#wibox.widget.separator.border_width>) | The separator’s border width.  
[forced_height](<#wibox.widget.separator.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.separator.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.separator.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.separator.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.separator_thickness](<#beautiful.separator_thickness>) | The separator thickness.  
---|---  
[beautiful.separator_border_color](<#beautiful.separator_border_color>) | The separator border color.  
[beautiful.separator_border_width](<#beautiful.separator_border_width>) | The separator border width.  
[beautiful.separator_span_ratio](<#beautiful.separator_span_ratio>) | The relative percentage covered by the bar.  
[beautiful.separator_color](<#beautiful.separator_color>) | The separator’s color.  
[beautiful.separator_shape](<#beautiful.separator_shape>) | The separator’s shape.  
  
## [Methods](<#Methods>)

[wibox.widget.separator:get_all_children ()](<#wibox.widget.separator:get_all_children>) | Get all direct and indirect children widgets.  
---|---  
[wibox.widget.separator:setup (args)](<#wibox.widget.separator:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.separator:buttons (_buttons)](<#wibox.widget.separator:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.separator:emit_signal_recursive (signal_name, ...)](<#wibox.widget.separator:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.separator:emit_signal (name, ...)](<#wibox.widget.separator:emit_signal>) | Emit a signal.  
[wibox.widget.separator:connect_signal (name, func)](<#wibox.widget.separator:connect_signal>) | Connect to a signal.  
[wibox.widget.separator:weak_connect_signal (name, func)](<#wibox.widget.separator:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Object properties

**orientation**
     The separator’s orientation.

Valid values are:

  * _vertical_ : From top to bottom
  * _horizontal_ : From left to right
  * _auto_ : Decide depending on the widget geometry (default)


The default value is selected automatically. If the widget is taller than large, it will use vertical and vice versa.

![Usage example](../images/AUTOGEN_wibox_widget_separator_orientation.svg)

### Type:

  * string


**thickness**
     The separator’s thickness.

This is used by the default line separator, but ignored when a shape is used. 

### Type:

  * number


**shape**
     The separator’s shape.

![Usage example](../images/AUTOGEN_wibox_widget_separator_shape.svg)

### Type:

  * shape function A valid shape function 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 


### Usage:
    
    for _, s in ipairs { 'losange' ,'circle', 'isosceles_triangle', 'cross' } do
        local w = wibox.widget {
            shape  = gears.shape[s],
            widget = wibox.widget.separator,
        }
    end


**span_ratio**
     The relative percentage covered by the bar. 

### Type:

  * A number number between 0 and 1. (_default_ 1) 


**color**
     The separator’s color. 

### Type:

  * string


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**border_color**
     The separator’s border color.

![Usage example](../images/AUTOGEN_wibox_widget_separator_border_color.svg)

### Type:

  * string


### See also:

[gears.color](<../libraries/gears.color.html#>) 


### Usage:
    
    wibox.widget {
        shape        = gears.shape.circle,
        color        = '#00000000',
        border_width = 1,
        border_color = beautiful.bg_normal,
        widget       = wibox.widget.separator,
    }


**border_width**
     The separator’s border width. 

### Type:

  * number


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

[widget::redraw_needed](<../classes/wibox.widget.separator.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.separator.html#widget::layout_changed>) 

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

**beautiful.separator_thickness**
     The separator thickness. 

### Type:

  * number


### See also:

[thickness](<../classes/wibox.widget.separator.html#wibox.widget.separator.thickness>) 

**beautiful.separator_border_color**
     The separator border color. 

### See also:

[border_color](<../classes/wibox.widget.separator.html#wibox.widget.separator.border_color>) 

**beautiful.separator_border_width**
     The separator border width. 

### Type:

  * number


### See also:

[border_width](<../classes/wibox.widget.separator.html#wibox.widget.separator.border_width>) 

**beautiful.separator_span_ratio**
     The relative percentage covered by the bar. 

### Type:

  * A number number between 0 and 1. (_default_ 1) 


**beautiful.separator_color**
     The separator’s color. 

### Type:

  * string


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.separator_shape**
     The separator’s shape. 

### Type:

  * shape function A valid shape function 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 


## Methods

**wibox.widget.separator:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.separator:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.separator:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.separator:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.separator:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.separator:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.separator:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.