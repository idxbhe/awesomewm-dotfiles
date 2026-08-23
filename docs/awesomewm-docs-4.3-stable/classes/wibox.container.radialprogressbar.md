# Class wibox.container.radialprogressbar - awesome API documentation

**Module:** `classes.wibox.container.radialprogressbar`  

> Source: [classes/wibox.container.radialprogressbar.html](https://awesomewm.org/doc/api/classes/wibox.container.radialprogressbar.html)

---

# Class `wibox.container.radialprogressbar`

A circular progressbar wrapper.

If no child [widget](<../classes/wibox.widget.html>) is set, then the radialprogressbar will take all the available size. Use a [wibox.container.constraint](<../classes/wibox.container.constraint.html#>) to prevent this.

![Usage example](../images/AUTOGEN_wibox_container_defaults_radialprogressbar.svg)

### Info:

  * **Copyright** : 2013 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[wibox.container.radialprogressbar ([widget])](<#wibox.container.radialprogressbar>) | Returns a new radialprogressbar layout.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.radialprogressbar.widget>) | The widget to wrap in a radial proggressbar.  
---|---  
[paddings](<#wibox.container.radialprogressbar.paddings>) | The padding between the outline and the progressbar.  
[value](<#wibox.container.radialprogressbar.value>) | The progressbar value.  
[border_color](<#wibox.container.radialprogressbar.border_color>) | The border background color.  
[color](<#wibox.container.radialprogressbar.color>) | The border foreground color.  
[border_width](<#wibox.container.radialprogressbar.border_width>) | The border width.  
[min_value](<#wibox.container.radialprogressbar.min_value>) | The minimum value.  
[max_value](<#wibox.container.radialprogressbar.max_value>) | The maximum value.  
[forced_height](<#wibox.container.radialprogressbar.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.radialprogressbar.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.radialprogressbar.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.radialprogressbar.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.radialprogressbar_border_color](<#beautiful.radialprogressbar_border_color>) | The progressbar border background color.  
---|---  
[beautiful.radialprogressbar_color](<#beautiful.radialprogressbar_color>) | The progressbar foreground color.  
[beautiful.radialprogressbar_border_width](<#beautiful.radialprogressbar_border_width>) | The progressbar border width.  
[beautiful.radialprogressbar_paddings](<#beautiful.radialprogressbar_paddings>) | The padding between the outline and the progressbar.  
  
## [Methods](<#Methods>)

[wibox.container.radialprogressbar:get_children ()](<#wibox.container.radialprogressbar:get_children>) | Get the children elements  
---|---  
[wibox.container.radialprogressbar:set_children (children)](<#wibox.container.radialprogressbar:set_children>) | Replace the layout children This layout only accept one children, all others will be ignored  
[wibox.container.radialprogressbar:reset ()](<#wibox.container.radialprogressbar:reset>) | Reset this container.  
[wibox.container.radialprogressbar:get_all_children ()](<#wibox.container.radialprogressbar:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.radialprogressbar:setup (args)](<#wibox.container.radialprogressbar:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.radialprogressbar:buttons (_buttons)](<#wibox.container.radialprogressbar:buttons>) | Set/get a widget’s buttons.  
[wibox.container.radialprogressbar:emit_signal_recursive (signal_name, ...)](<#wibox.container.radialprogressbar:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.radialprogressbar:emit_signal (name, ...)](<#wibox.container.radialprogressbar:emit_signal>) | Emit a signal.  
[wibox.container.radialprogressbar:connect_signal (name, func)](<#wibox.container.radialprogressbar:connect_signal>) | Connect to a signal.  
[wibox.container.radialprogressbar:weak_connect_signal (name, func)](<#wibox.container.radialprogressbar:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.container.radialprogressbar ([widget])**
     Returns a new radialprogressbar layout. A radialprogressbar layout radialprogressbars a given widget. Use `.widget` to set the widget. 

  * widget The widget to display. (_optional_) 


## Object properties

**widget**
     The widget to wrap in a radial proggressbar. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget 


**paddings**
     The padding between the outline and the progressbar.

![Usage example](../images/AUTOGEN_wibox_container_radialprogressbar_padding.svg)

### Type:

  * paddings A number or a table 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


**value**
     The progressbar value.

![Usage example](../images/AUTOGEN_wibox_container_radialprogressbar_value.svg)

### Type:

  * value number Between min_value and max_value 


**border_color**
     The border background color.

![Usage example](../images/AUTOGEN_wibox_container_radialprogressbar_border_color.svg)
**color**
     The border foreground color.

![Usage example](../images/AUTOGEN_wibox_container_radialprogressbar_color.svg)
**border_width**
     The border width.

![Usage example](../images/AUTOGEN_wibox_container_radialprogressbar_border_width.svg)

### Type:

  * border_width number (_default_ 3) 


**min_value**
     The minimum value. 
**max_value**
     The maximum value. 
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

[widget::redraw_needed](<../classes/wibox.container.radialprogressbar.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.radialprogressbar.html#widget::layout_changed>) 

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

**beautiful.radialprogressbar_border_color**
     The progressbar border background color. 
**beautiful.radialprogressbar_color**
     The progressbar foreground color. 
**beautiful.radialprogressbar_border_width**
     The progressbar border width. 
**beautiful.radialprogressbar_paddings**
     The padding between the outline and the progressbar. 

### Type:

  * paddings A number or a table 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


## Methods

**wibox.container.radialprogressbar:get_children ()**
     Get the children elements 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.radialprogressbar:set_children (children)**
     Replace the layout children This layout only accept one children, all others will be ignored 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets 


**wibox.container.radialprogressbar:reset ()**
     Reset this container. 
**wibox.container.radialprogressbar:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.radialprogressbar:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.radialprogressbar:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.radialprogressbar:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.radialprogressbar:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.radialprogressbar:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.radialprogressbar:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.