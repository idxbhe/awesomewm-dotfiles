# Class wibox.container.constraint - awesome API documentation

**Module:** `classes.wibox.container.constraint`  

> Source: [classes/wibox.container.constraint.html](https://awesomewm.org/doc/api/classes/wibox.container.constraint.html)

---

# Class `wibox.container.constraint`

![Usage example](../images/AUTOGEN_wibox_container_defaults_constraint.svg)

### Info:

  * **Copyright** : 2012 Lukáš Hrázký
  * **Author** : Lukáš Hrázký


## [Functions](<#Functions>)

[wibox.container.constraint ([widget[, strategy[, width[, height]]]])](<#wibox.container.constraint>) | Returns a new constraint container.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.constraint.widget>) | The widget to be constrained.  
---|---  
[strategy](<#wibox.container.constraint.strategy>) | Set the strategy to use for the constraining.  
[height](<#wibox.container.constraint.height>) | Set the maximum width to val.  
[width](<#wibox.container.constraint.width>) | Set the maximum height to val.  
[forced_height](<#wibox.container.constraint.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.constraint.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.constraint.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.constraint.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.container.constraint:get_children ()](<#wibox.container.constraint:get_children>) | Get the number of children element  
---|---  
[wibox.container.constraint:set_children (children)](<#wibox.container.constraint:set_children>) | Replace the layout children This layout only accept one children, all others will be ignored  
[wibox.container.constraint:reset ()](<#wibox.container.constraint:reset>) | Reset this layout.  
[wibox.container.constraint:get_all_children ()](<#wibox.container.constraint:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.constraint:setup (args)](<#wibox.container.constraint:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.constraint:buttons (_buttons)](<#wibox.container.constraint:buttons>) | Set/get a widget’s buttons.  
[wibox.container.constraint:emit_signal_recursive (signal_name, ...)](<#wibox.container.constraint:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.constraint:emit_signal (name, ...)](<#wibox.container.constraint:emit_signal>) | Emit a signal.  
[wibox.container.constraint:connect_signal (name, func)](<#wibox.container.constraint:connect_signal>) | Connect to a signal.  
[wibox.container.constraint:weak_connect_signal (name, func)](<#wibox.container.constraint:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.container.constraint ([widget[, strategy[, width[, height]]]])**
     Returns a new constraint container. This container will constraint the size of a widget according to the strategy. Note that this will only work for layouts that respect the widget’s size, eg. fixed layout. In layouts that don’t (fully) respect widget’s requested size, the inner widget still might get drawn with a size that does not fit the constraint, eg. in flex layout. 

  * widget A widget to use. (_optional_) 
  * strategy How to constraint the size. ‘max’ (default), ‘min’ or ‘exact’. (_optional_) 
  * width The maximum width of the widget. nil for no limit. (_optional_) 
  * height The maximum height of the widget. nil for no limit. (_optional_) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new constraint container 


## Object properties

**widget**
     The widget to be constrained. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget 


**strategy**
     Set the strategy to use for the constraining. Valid values are ‘max’, ‘min’ or ‘exact’. Throws an error on invalid values. 
**height**
     Set the maximum width to val. nil for no width limit. 

### Type:

  * number


**width**
     Set the maximum height to val. nil for no height limit. 

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

[widget::redraw_needed](<../classes/wibox.container.constraint.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.constraint.html#widget::layout_changed>) 

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

**wibox.container.constraint:get_children ()**
     Get the number of children element 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.constraint:set_children (children)**
     Replace the layout children This layout only accept one children, all others will be ignored 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets 


**wibox.container.constraint:reset ()**
     Reset this layout. The widget will be unreferenced, strategy set to “max” and the constraints set to nil. 
**wibox.container.constraint:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.constraint:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.constraint:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.constraint:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.constraint:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.constraint:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.constraint:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.