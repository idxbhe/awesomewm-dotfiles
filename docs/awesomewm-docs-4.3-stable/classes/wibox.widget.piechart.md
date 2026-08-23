# Class wibox.widget.piechart - awesome API documentation

**Module:** `classes.wibox.widget.piechart`  

> Source: [classes/wibox.widget.piechart.html](https://awesomewm.org/doc/api/classes/wibox.widget.piechart.html)

---

# Class `wibox.widget.piechart`

Display percentage in a circle.

Note that this widget makes no attempts to prevent overlapping labels or labels drawn outside of the widget boundaries.

![Usage example](../images/AUTOGEN_wibox_widget_defaults_piechart.svg)

### Usage:
    
    wibox.widget {
        data_list = {
            { 'L1', 100 },
            { 'L2', 200 },
            { 'L3', 300 },
        },
        border_width = 1,
        colors = {
            beautiful.bg_normal,
            beautiful.bg_highlight,
            beautiful.border_color,
        },
        widget = wibox.widget.piechart
    }
    


### Info:

  * **Copyright** : 2012 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Valle


## [Object properties](<#Object_properties>)

[data_list](<#wibox.widget.piechart.data_list>) | The pie chart data list.  
---|---  
[data](<#wibox.widget.piechart.data>) | The pie chart data.  
[border_color](<#wibox.widget.piechart.border_color>) | The border color.  
[border_width](<#wibox.widget.piechart.border_width>) | The pie elements border width.  
[colors](<#wibox.widget.piechart.colors>) | The pie chart colors.  
[display_labels](<#wibox.widget.piechart.display_labels>) | If the pie chart has labels.  
[forced_height](<#wibox.widget.piechart.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.piechart.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.piechart.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.piechart.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.piechart_border_color](<#beautiful.piechart_border_color>) | The border color.  
---|---  
[beautiful.piechart_border_width](<#beautiful.piechart_border_width>) | The pie elements border width.  
[beautiful.piechart_colors](<#beautiful.piechart_colors>) | The pie chart colors.  
  
## [Methods](<#Methods>)

[wibox.widget.piechart:get_all_children ()](<#wibox.widget.piechart:get_all_children>) | Get all direct and indirect children widgets.  
---|---  
[wibox.widget.piechart:setup (args)](<#wibox.widget.piechart:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.piechart:buttons (_buttons)](<#wibox.widget.piechart:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.piechart:emit_signal_recursive (signal_name, ...)](<#wibox.widget.piechart:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.piechart:emit_signal (name, ...)](<#wibox.widget.piechart:emit_signal>) | Emit a signal.  
[wibox.widget.piechart:connect_signal (name, func)](<#wibox.widget.piechart:connect_signal>) | Connect to a signal.  
[wibox.widget.piechart:weak_connect_signal (name, func)](<#wibox.widget.piechart:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Object properties

**data_list**
     The pie chart data list. 

### Type:

  * data_list [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Sorted table where each entry has a label as its first value and a number as its second value. 


**data**
     The pie chart data. 

### Type:

  * data [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Labels as keys and number as value. 


**border_color**
     The border color. If none is set, it will use current foreground (text) color.

![Usage example](../images/AUTOGEN_wibox_widget_piechart_border_color.svg)

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**border_width**
     The pie elements border width.

![Usage example](../images/AUTOGEN_wibox_widget_piechart_border_width.svg)

### Type:

  * border_width number (_default_ 1) 


**colors**
     The pie chart colors. If no color is set, only the border will be drawn. If less colors than required are set, colors will be re-used in order. 

### Type:

  * colors [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table of colors, one for each elements 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**display_labels**
     If the pie chart has labels.

![Usage example](../images/AUTOGEN_wibox_widget_piechart_label.svg)

### Type:

  * boolean (_default_ true) 


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

[widget::redraw_needed](<../classes/wibox.widget.piechart.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.piechart.html#widget::layout_changed>) 

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

**beautiful.piechart_border_color**
     The border color. If none is set, it will use current foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.piechart_border_width**
     The pie elements border width. 

### Type:

  * border_width number (_default_ 1) 


**beautiful.piechart_colors**
     The pie chart colors. If no color is set, only the border will be drawn. If less colors than required are set, colors will be re-used in order. 

### Type:

  * colors [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table of colors, one for each elements 


### See also:

[gears.color](<../libraries/gears.color.html#>) 


## Methods

**wibox.widget.piechart:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.piechart:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.piechart:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.piechart:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.piechart:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.piechart:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.piechart:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.