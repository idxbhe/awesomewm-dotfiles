# Class wibox.container.arcchart - awesome API documentation

**Module:** `classes.wibox.container.arcchart`  

> Source: [classes/wibox.container.arcchart.html](https://awesomewm.org/doc/api/classes/wibox.container.arcchart.html)

---

# Class `wibox.container.arcchart`

A circular chart (arc chart).

It can contain a central widget (or not) and display multiple values.

![Usage example](../images/AUTOGEN_wibox_container_defaults_arcchart.svg)

### Info:

  * **Copyright** : 2013 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[wibox.container.arcchart ([widget])](<#wibox.container.arcchart>) | Returns a new arcchart layout.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.arcchart.widget>) | The widget to wrap in a radial proggressbar.  
---|---  
[paddings](<#wibox.container.arcchart.paddings>) | The padding between the outline and the progressbar.  
[border_color](<#wibox.container.arcchart.border_color>) | The border background color.  
[colors](<#wibox.container.arcchart.colors>) | The arcchart values foreground colors.  
[border_width](<#wibox.container.arcchart.border_width>) | The border width.  
[min_value](<#wibox.container.arcchart.min_value>) | The minimum value.  
[max_value](<#wibox.container.arcchart.max_value>) | The maximum value.  
[bg](<#wibox.container.arcchart.bg>) | The radial background.  
[value](<#wibox.container.arcchart.value>) | The value.  
[values](<#wibox.container.arcchart.values>) | The values.  
[rounded_edge](<#wibox.container.arcchart.rounded_edge>) | If the chart has rounded edges.  
[thickness](<#wibox.container.arcchart.thickness>) | The arc thickness.  
[start_angle](<#wibox.container.arcchart.start_angle>) | The (radiant) angle where the first value start.  
[forced_height](<#wibox.container.arcchart.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.arcchart.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.arcchart.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.arcchart.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.arcchart_border_color](<#beautiful.arcchart_border_color>) | The progressbar border background color.  
---|---  
[beautiful.arcchart_color](<#beautiful.arcchart_color>) | The progressbar foreground color.  
[beautiful.arcchart_border_width](<#beautiful.arcchart_border_width>) | The progressbar border width.  
[beautiful.arcchart_paddings](<#beautiful.arcchart_paddings>) | The padding between the outline and the progressbar.  
[beautiful.arcchart_thickness](<#beautiful.arcchart_thickness>) | The arc thickness.  
  
## [Methods](<#Methods>)

[wibox.container.arcchart:get_children ()](<#wibox.container.arcchart:get_children>) | Get the children elements.  
---|---  
[wibox.container.arcchart:set_children (children)](<#wibox.container.arcchart:set_children>) | Replace the layout children This layout only accept one children, all others will be ignored  
[wibox.container.arcchart:reset ()](<#wibox.container.arcchart:reset>) | Reset this layout.  
[wibox.container.arcchart:get_all_children ()](<#wibox.container.arcchart:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.arcchart:setup (args)](<#wibox.container.arcchart:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.arcchart:buttons (_buttons)](<#wibox.container.arcchart:buttons>) | Set/get a widget’s buttons.  
[wibox.container.arcchart:emit_signal_recursive (signal_name, ...)](<#wibox.container.arcchart:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.arcchart:emit_signal (name, ...)](<#wibox.container.arcchart:emit_signal>) | Emit a signal.  
[wibox.container.arcchart:connect_signal (name, func)](<#wibox.container.arcchart:connect_signal>) | Connect to a signal.  
[wibox.container.arcchart:weak_connect_signal (name, func)](<#wibox.container.arcchart:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.container.arcchart ([widget])**
     Returns a new arcchart layout. 

  * widget The widget to display. (_optional_) 


## Object properties

**widget**
     The widget to wrap in a radial proggressbar. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget 


**paddings**
     The padding between the outline and the progressbar.

![Usage example](../images/AUTOGEN_wibox_container_arcchart_paddings.svg)

### Type:

  * paddings A number or a table 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


**border_color**
     The border background color. 
**colors**
     The arcchart values foreground colors. 

### Type:

  * values [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) An ordered set of colors for each value in arcchart. 


**border_width**
     The border width.

![Usage example](../images/AUTOGEN_wibox_container_arcchart_border_width.svg)

### Type:

  * border_width number (_default_ 3) 


**min_value**
     The minimum value. 
**max_value**
     The maximum value. 
**bg**
     The radial background.

![Usage example](../images/AUTOGEN_wibox_container_arcchart_bg.svg)

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**value**
     The value.

![Usage example](../images/AUTOGEN_wibox_container_arcchart_value.svg)

### Type:

  * value number Between min_value and max_value 


### See also:

[values](<../classes/wibox.container.arcchart.html#wibox.container.arcchart.values>) 

**values**
     The values. The arcchart is designed to display multiple values at once. Each will be shown in table order. 

### Type:

  * values [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) An ordered set of values. 


### See also:

[value](<../classes/wibox.container.arcchart.html#wibox.container.arcchart.value>) 

**rounded_edge**
     If the chart has rounded edges.

![Usage example](../images/AUTOGEN_wibox_container_arcchart_rounded_edge.svg)

### Type:

  * boolean (_default_ false) 


**thickness**
     The arc thickness.

![Usage example](../images/AUTOGEN_wibox_container_arcchart_thickness.svg)

### Type:

  * number


**start_angle**
     The (radiant) angle where the first value start.

![Usage example](../images/AUTOGEN_wibox_container_arcchart_start_angle.svg)

### Type:

  * number A number between 0 and 2*math.pi (_default_ math.pi) 


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

[widget::redraw_needed](<../classes/wibox.container.arcchart.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.arcchart.html#widget::layout_changed>) 

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

**beautiful.arcchart_border_color**
     The progressbar border background color. 
**beautiful.arcchart_color**
     The progressbar foreground color. 
**beautiful.arcchart_border_width**
     The progressbar border width. 
**beautiful.arcchart_paddings**
     The padding between the outline and the progressbar. 

### Type:

  * paddings A number or a table 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


**beautiful.arcchart_thickness**
     The arc thickness. 

### Type:

  * number


## Methods

**wibox.container.arcchart:get_children ()**
     Get the children elements. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.arcchart:set_children (children)**
     Replace the layout children This layout only accept one children, all others will be ignored 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets 


**wibox.container.arcchart:reset ()**
     Reset this layout. The widget will be removed and the rotation reset. 
**wibox.container.arcchart:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.arcchart:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.arcchart:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.arcchart:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.arcchart:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.arcchart:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.arcchart:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.