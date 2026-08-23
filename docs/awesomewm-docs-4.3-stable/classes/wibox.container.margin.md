# Class wibox.container.margin - awesome API documentation

**Module:** `classes.wibox.container.margin`  

> Source: [classes/wibox.container.margin.html](https://awesomewm.org/doc/api/classes/wibox.container.margin.html)

---

# Class `wibox.container.margin`

![Usage example](../images/AUTOGEN_wibox_container_defaults_margin.svg)

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.container.margin ([widget[, left[, right[, top[, bottom[, color[, draw_empty]]]]]]])](<#wibox.container.margin>) | Returns a new margin container.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.margin.widget>) | The widget to be wrapped the the margins.  
---|---  
[margins](<#wibox.container.margin.margins>) | Set all the margins to val.  
[color](<#wibox.container.margin.color>) | Set the margins color to create a border.  
[left](<#wibox.container.margin.left>) | Set the left margin that this layout adds to its widget.  
[right](<#wibox.container.margin.right>) | Set the right margin that this layout adds to its widget.  
[top](<#wibox.container.margin.top>) | Set the top margin that this layout adds to its widget.  
[bottom](<#wibox.container.margin.bottom>) | Set the bottom margin that this layout adds to its widget.  
[forced_height](<#wibox.container.margin.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.margin.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.margin.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.margin.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.container.margin:draw_empty (draw_empty)](<#wibox.container.margin:draw_empty>) | Draw the margin even if the content size is 0x0 (default: true)  
---|---  
[wibox.container.margin:reset ()](<#wibox.container.margin:reset>) | Reset this layout.  
[wibox.container.margin:get_all_children ()](<#wibox.container.margin:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.margin:setup (args)](<#wibox.container.margin:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.margin:buttons (_buttons)](<#wibox.container.margin:buttons>) | Set/get a widget’s buttons.  
[wibox.container.margin:emit_signal_recursive (signal_name, ...)](<#wibox.container.margin:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.margin:emit_signal (name, ...)](<#wibox.container.margin:emit_signal>) | Emit a signal.  
[wibox.container.margin:connect_signal (name, func)](<#wibox.container.margin:connect_signal>) | Connect to a signal.  
[wibox.container.margin:weak_connect_signal (name, func)](<#wibox.container.margin:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.container.margin ([widget[, left[, right[, top[, bottom[, color[, draw_empty]]]]]]])**
     Returns a new margin container. 

  * widget A widget to use. (_optional_) 
  * left A margin to use on the left side of the widget. (_optional_) 
  * right A margin to use on the right side of the widget. (_optional_) 
  * top A margin to use on the top side of the widget. (_optional_) 
  * bottom A margin to use on the bottom side of the widget. (_optional_) 
  * color A color for the margins. (_optional_) 
  * draw_empty whether or not to draw the margin when the content is empty (_optional_) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new margin container 


## Object properties

**widget**
     The widget to be wrapped the the margins. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget 


**margins**
     Set all the margins to val. 

### Type:

  * val number The margin value 


**color**
     Set the margins color to create a border. 

### Type:

  * color A color used to fill the margin. 


**left**
     Set the left margin that this layout adds to its widget. 

### Type:

  * margin The new margin to use. 


**right**
     Set the right margin that this layout adds to its widget. 

### Type:

  * margin The new margin to use. 


**top**
     Set the top margin that this layout adds to its widget. 

### Type:

  * margin The new margin to use. 


**bottom**
     Set the bottom margin that this layout adds to its widget. 

### Type:

  * margin The new margin to use. 


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

[widget::redraw_needed](<../classes/wibox.container.margin.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.margin.html#widget::layout_changed>) 

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

**wibox.container.margin:draw_empty (draw_empty)**
     Draw the margin even if the content size is 0x0 (default: true) 

  * draw_empty boolean Draw nothing is content is 0x0 or draw the margin anyway 


**wibox.container.margin:reset ()**
     Reset this layout. The widget will be unreferenced, the margins set to 0 and the color erased 
**wibox.container.margin:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.margin:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.margin:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.margin:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.margin:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.margin:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.margin:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.