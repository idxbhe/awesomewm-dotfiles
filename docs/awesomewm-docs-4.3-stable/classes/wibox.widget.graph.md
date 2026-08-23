# Class wibox.widget.graph - awesome API documentation

**Module:** `classes.wibox.widget.graph`  

> Source: [classes/wibox.widget.graph.html](https://awesomewm.org/doc/api/classes/wibox.widget.graph.html)

---

# Class `wibox.widget.graph`

A graph widget.

The graph goes from left to right. To change this to right to left, use a [wibox.container.mirror](<../classes/wibox.container.mirror.html#>) widget. This can also be used to have data shown from top to bottom.

To add text on top of the graph, use a [wibox.layout.stack](<../classes/wibox.layout.stack.html#>) and a `wibox.container.align` widgets.

To display the graph vertically, use a [wibox.container.rotate](<../classes/wibox.container.rotate.html#>) widget.

![Usage example](../images/AUTOGEN_wibox_widget_defaults_graph.svg)

### Usage:
    
    wibox.widget {
        max_value = 29,
        widget = wibox.widget.graph
    }
    


### Info:

  * **Copyright** : 2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[wibox.widget.graph (args)](<#wibox.widget.graph>) | Create a graph widget.  
---|---  
  
## [Object properties](<#Object_properties>)

[border_color](<#wibox.widget.graph.border_color>) | Set the graph border color.  
---|---  
[color](<#wibox.widget.graph.color>) | Set the graph foreground color.  
[background_color](<#wibox.widget.graph.background_color>) | Set the graph background color.  
[max_value](<#wibox.widget.graph.max_value>) | Set the maximum value the graph should handle.  
[min_value](<#wibox.widget.graph.min_value>) | The minimum value.  
[scale](<#wibox.widget.graph.scale>) | Set the graph to automatically scale its values.  
[step_width](<#wibox.widget.graph.step_width>) | Set the width or the individual steps.  
[step_spacing](<#wibox.widget.graph.step_spacing>) | Set the spacing between the steps.  
[step_shape](<#wibox.widget.graph.step_shape>) | The step shape.  
[stack](<#wibox.widget.graph.stack>) | Set the graph to draw stacks.  
[stack_colors](<#wibox.widget.graph.stack_colors>) | Set the graph stacking colors.  
[forced_height](<#wibox.widget.graph.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.graph.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.graph.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.graph.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.graph_bg](<#beautiful.graph_bg>) | The graph background color.  
---|---  
[beautiful.graph_fg](<#beautiful.graph_fg>) | The graph foreground color.  
[beautiful.graph_border_color](<#beautiful.graph_border_color>) | The graph border color.  
  
## [Methods](<#Methods>)

[wibox.widget.graph:add_value (value, group)](<#wibox.widget.graph:add_value>) | Add a value to the graph  
---|---  
[wibox.widget.graph:clear ()](<#wibox.widget.graph:clear>) | Clear the graph.  
[wibox.widget.graph:set_height (height)](<#wibox.widget.graph:set_height>) | Set the graph height.  
[wibox.widget.graph:set_width (width)](<#wibox.widget.graph:set_width>) | Set the graph width.  
[wibox.widget.graph:get_all_children ()](<#wibox.widget.graph:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.widget.graph:setup (args)](<#wibox.widget.graph:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.graph:buttons (_buttons)](<#wibox.widget.graph:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.graph:emit_signal_recursive (signal_name, ...)](<#wibox.widget.graph:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.graph:emit_signal (name, ...)](<#wibox.widget.graph:emit_signal>) | Emit a signal.  
[wibox.widget.graph:connect_signal (name, func)](<#wibox.widget.graph:connect_signal>) | Connect to a signal.  
[wibox.widget.graph:weak_connect_signal (name, func)](<#wibox.widget.graph:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.widget.graph (args)**
     Create a graph widget. 

  * args Standard widget() arguments. You should add width and height key to set graph geometry. 


### Returns:

A new graph widget. 


## Object properties

**border_color**
     Set the graph border color. If the value is nil, no border will be drawn. 

### Type:

  * border_color gears.color The border color to set. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**color**
     Set the graph foreground color. 

### Type:

  * color [color](<../classes/wibox.widget.graph.html#wibox.widget.graph.color>) The graph color. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**background_color**
     Set the graph background color. 

### Type:

  * background_color gears.color The graph background color. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**max_value**
     Set the maximum value the graph should handle. If “scale” is also set, the graph never scales up below this value, but it automatically scales down to make all data fit. 

### Type:

  * number


**min_value**
     The minimum value. Note that the min_value is not supported when used along with the stack property. 

### Type:

  * number


**scale**
     Set the graph to automatically scale its values. Default is false. 

### Type:

  * boolean


**step_width**
     Set the width or the individual steps.

Note that it isn’t supported when used along with stacked graphs.

![Usage example](../images/AUTOGEN_wibox_widget_graph_step.svg)

### Type:

  * number (_default_ 1) 


### Usage:
    
    wibox.widget {
        max_value = 29,
        step_width = 3,
        step_spacing = 1,
        step_shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 2)
        end,
        widget = wibox.widget.graph
    }


**step_spacing**
     Set the spacing between the steps.

Note that it isn’t supported when used along with stacked graphs. 

### Type:

  * number (_default_ 0) 


**step_shape**
     The step shape. 

### Type:

  * shape (_default_ rectangle) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**stack**
     Set the graph to draw stacks. Default is false. 

### Type:

  * boolean


**stack_colors**
     Set the graph stacking colors. Order matters. 

### Type:

  * stack_colors A table with stacking colors. 


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

[widget::redraw_needed](<../classes/wibox.widget.graph.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.graph.html#widget::layout_changed>) 

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

**beautiful.graph_bg**
     The graph background color. 
**beautiful.graph_fg**
     The graph foreground color. 
**beautiful.graph_border_color**
     The graph border color. 

## Methods

**wibox.widget.graph:add_value (value, group)**
     Add a value to the graph 

  * value The value to be added to the graph 
  * group The stack color group index. 


**wibox.widget.graph:clear ()**
     Clear the graph. 
**wibox.widget.graph:set_height (height)**
     Set the graph height. 

  * height The height to set. 


**wibox.widget.graph:set_width (width)**
     Set the graph width. 

  * width The width to set. 


**wibox.widget.graph:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.graph:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.graph:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.graph:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.graph:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.graph:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.graph:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.