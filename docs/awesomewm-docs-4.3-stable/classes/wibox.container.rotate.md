# Class wibox.container.rotate - awesome API documentation

**Module:** `classes.wibox.container.rotate`  

> Source: [classes/wibox.container.rotate.html](https://awesomewm.org/doc/api/classes/wibox.container.rotate.html)

---

# Class `wibox.container.rotate`

A container rotating the conained widget by 90 degrees.

![Usage example](../images/AUTOGEN_wibox_container_defaults_rotate.svg)

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.container.rotate ([widget[, dir]])](<#wibox.container.rotate>) | Returns a new rotate container.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.rotate.widget>) | The widget to be rotated.  
---|---  
[forced_height](<#wibox.container.rotate.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.rotate.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.rotate.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.rotate.visible>) | The widget visibility.  
[direction](<#wibox.container.rotate.direction>) | The direction of this rotating container.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.container.rotate:get_children ()](<#wibox.container.rotate:get_children>) | Get the number of children element  
---|---  
[wibox.container.rotate:set_children (children)](<#wibox.container.rotate:set_children>) | Replace the layout children This layout only accept one children, all others will be ignored  
[wibox.container.rotate:reset ()](<#wibox.container.rotate:reset>) | Reset this layout.  
[wibox.container.rotate:get_all_children ()](<#wibox.container.rotate:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.rotate:setup (args)](<#wibox.container.rotate:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.rotate:buttons (_buttons)](<#wibox.container.rotate:buttons>) | Set/get a widget’s buttons.  
[wibox.container.rotate:emit_signal_recursive (signal_name, ...)](<#wibox.container.rotate:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.rotate:emit_signal (name, ...)](<#wibox.container.rotate:emit_signal>) | Emit a signal.  
[wibox.container.rotate:connect_signal (name, func)](<#wibox.container.rotate:connect_signal>) | Connect to a signal.  
[wibox.container.rotate:weak_connect_signal (name, func)](<#wibox.container.rotate:weak_connect_signal>) | Connect to a signal weakly.  
[wibox.container.rotate:get_direction ()](<#wibox.container.rotate:get_direction>) | Get the direction of this rotating layout  
  
  


## Functions

Methods 

**wibox.container.rotate ([widget[, dir]])**
     Returns a new rotate container. A rotate container rotates a given widget. Use :set_widget() to set the widget and :set_direction() for the direction. The default direction is “north” which doesn’t change anything. 

  * widget The widget to display. (_optional_) 
  * dir The direction to rotate to. (_optional_) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new rotate container. 


## Object properties

**widget**
     The widget to be rotated. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget 


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


**direction**
     The direction of this rotating container. Valid values are:

  * _north_
  * _east_
  * _south_
  * _north_


![Usage example](../images/AUTOGEN_wibox_container_rotate_angle.svg)

### Type:

  * dir [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The direction 


### Usage:
    
    local normal = create_arrow('Normal')
    local north  = wibox.container {
        create_arrow('North'),
        direction = 'north',
        widget    = wibox.container.rotate
    }
    local south  = wibox.container {
        create_arrow('South'),
        direction = 'south',
        widget    = wibox.container.rotate
    }
    local east  = wibox.container {
        create_arrow('East'),
        direction = 'east',
        widget    = wibox.container.rotate
    }
    local west  = wibox.container {
        create_arrow('West'),
        direction = 'west',
        widget    = wibox.container.rotate
    }


## Signals

**widget::layout_changed**
     When the layout (size) change. This signal is emitted when the previous results of `:layout()` and `:fit()` are no longer valid. Unless this signal is emitted, `:layout()` and `:fit()` must return the same result when called with the same arguments. 

### See also:

[widget::redraw_needed](<../classes/wibox.container.rotate.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.rotate.html#widget::layout_changed>) 

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


## Methods

**wibox.container.rotate:get_children ()**
     Get the number of children element 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.rotate:set_children (children)**
     Replace the layout children This layout only accept one children, all others will be ignored 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets 


**wibox.container.rotate:reset ()**
     Reset this layout. The widget will be removed and the rotation reset. 
**wibox.container.rotate:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.rotate:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.rotate:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.rotate:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.rotate:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.rotate:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.rotate:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.rotate:get_direction ()**
     Get the direction of this rotating layout