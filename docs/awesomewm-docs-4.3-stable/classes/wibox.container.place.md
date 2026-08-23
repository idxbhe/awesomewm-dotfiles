# Class wibox.container.place - awesome API documentation

**Module:** `classes.wibox.container.place`  

> Source: [classes/wibox.container.place.html](https://awesomewm.org/doc/api/classes/wibox.container.place.html)

---

# Class `wibox.container.place`

A container used to place smaller widgets into larger space.

![Usage example](../images/AUTOGEN_wibox_container_defaults_place.svg)

### Info:

  * **Copyright** : 2016 Emmanuel Lepage Vallee
  * **Release** : 
  * **Author** : Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[wibox.container.place ([widget[, halign="center"[, valign="center"]]])](<#wibox.container.place>) | Returns a new place container.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.place.widget>) | The widget to be placed.  
---|---  
[valign](<#wibox.container.place.valign>) | The vertical alignment.  
[halign](<#wibox.container.place.halign>) | The horizontal alignment.  
[fill_vertical](<#wibox.container.place.fill_vertical>) | Fill the vertical space.  
[fill_horizontal](<#wibox.container.place.fill_horizontal>) | Fill the horizontal space.  
[content_fill_vertical](<#wibox.container.place.content_fill_vertical>) | Stretch the contained widget so it takes all the vertical space.  
[content_fill_horizontal](<#wibox.container.place.content_fill_horizontal>) | Stretch the contained widget so it takes all the horizontal space.  
[forced_height](<#wibox.container.place.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.place.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.place.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.place.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.container.place:get_children ()](<#wibox.container.place:get_children>) | Get the number of children element  
---|---  
[wibox.container.place:set_children (children)](<#wibox.container.place:set_children>) | Replace the layout children This layout only accept one children, all others will be ignored  
[wibox.container.place:reset ()](<#wibox.container.place:reset>) | Reset this layout.  
[wibox.container.place:get_all_children ()](<#wibox.container.place:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.place:setup (args)](<#wibox.container.place:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.place:buttons (_buttons)](<#wibox.container.place:buttons>) | Set/get a widget’s buttons.  
[wibox.container.place:emit_signal_recursive (signal_name, ...)](<#wibox.container.place:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.place:emit_signal (name, ...)](<#wibox.container.place:emit_signal>) | Emit a signal.  
[wibox.container.place:connect_signal (name, func)](<#wibox.container.place:connect_signal>) | Connect to a signal.  
[wibox.container.place:weak_connect_signal (name, func)](<#wibox.container.place:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.container.place ([widget[, halign="center"[, valign="center"]]])**
     Returns a new place container. 

  * widget The widget to display. (_optional_) 
  * halign [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The horizontal alignment (_default_ "center") 
  * valign [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The vertical alignment (_default_ "center") 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new place container. 


## Object properties

**widget**
     The widget to be placed. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget 


**valign**
    

The vertical alignment.

Possible values are:

  * _top_
  * _center_ (default)
  * _bottom_


### Type:

  * string (_default_ "center") 


**halign**
    

The horizontal alignment.

Possible values are:

  * _left_
  * _center_ (default)
  * _right_


### Type:

  * string (_default_ "center") 


**fill_vertical**
     Fill the vertical space. 

### Type:

  * boolean (_default_ false) 


**fill_horizontal**
     Fill the horizontal space. 

### Type:

  * boolean (_default_ false) 


**content_fill_vertical**
     Stretch the contained widget so it takes all the vertical space. 

### Type:

  * boolean (_default_ false) 


**content_fill_horizontal**
     Stretch the contained widget so it takes all the horizontal space. 

### Type:

  * boolean (_default_ false) 


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

[widget::redraw_needed](<../classes/wibox.container.place.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.place.html#widget::layout_changed>) 

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

**wibox.container.place:get_children ()**
     Get the number of children element 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.place:set_children (children)**
     Replace the layout children This layout only accept one children, all others will be ignored 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets 


**wibox.container.place:reset ()**
     Reset this layout. The widget will be removed and the rotation reset. 
**wibox.container.place:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.place:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.place:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.place:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.place:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.place:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.place:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.