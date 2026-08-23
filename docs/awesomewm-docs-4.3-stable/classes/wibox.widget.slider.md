# Class wibox.widget.slider - awesome API documentation

**Module:** `classes.wibox.widget.slider`  

> Source: [classes/wibox.widget.slider.html](https://awesomewm.org/doc/api/classes/wibox.widget.slider.html)

---

# Class `wibox.widget.slider`

An interactive mouse based slider widget.

![Usage example](../images/AUTOGEN_wibox_widget_defaults_slider.svg)

### Usage:
    
    wibox.widget {
        bar_shape           = gears.shape.rounded_rect,
        bar_height          = 3,
        bar_color           = beautiful.border_color,
        handle_color        = beautiful.bg_normal,
        handle_shape        = gears.shape.circle,
        handle_border_color = beautiful.border_color,
        handle_border_width = 1,
        value               = 25,
        widget              = wibox.widget.slider,
    }
    


### Info:

  * **Copyright** : 2015 Grigory Mishchenko, 2016 Emmanuel Lepage Vallee
  * **Author** : Grigory Mishchenko <[[email protected]](</cdn-cgi/l/email-protection>)>,Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[wibox.widget.slider ([args={}])](<#wibox.widget.slider>) | Create a slider widget.  
---|---  
  
## [Object properties](<#Object_properties>)

[handle_shape](<#wibox.widget.slider.handle_shape>) | The slider handle shape.  
---|---  
[handle_color](<#wibox.widget.slider.handle_color>) | The slider handle color.  
[handle_margins](<#wibox.widget.slider.handle_margins>) | The slider handle margins.  
[handle_width](<#wibox.widget.slider.handle_width>) | The slider handle width.  
[handle_border_color](<#wibox.widget.slider.handle_border_color>) | The handle border_color.  
[handle_border_width](<#wibox.widget.slider.handle_border_width>) | The handle border width.  
[bar_shape](<#wibox.widget.slider.bar_shape>) | The bar (background) shape.  
[bar_height](<#wibox.widget.slider.bar_height>) | The bar (background) height.  
[bar_color](<#wibox.widget.slider.bar_color>) | The bar (background) color.  
[bar_margins](<#wibox.widget.slider.bar_margins>) | The bar (background) margins.  
[bar_border_width](<#wibox.widget.slider.bar_border_width>) | The bar (background) border width.  
[bar_border_color](<#wibox.widget.slider.bar_border_color>) | The bar (background) border_color.  
[value](<#wibox.widget.slider.value>) | The slider value.  
[minimum](<#wibox.widget.slider.minimum>) | The slider minimum value.  
[maximum](<#wibox.widget.slider.maximum>) | The slider maximum value.  
[forced_height](<#wibox.widget.slider.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.slider.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.slider.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.slider.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.slider_bar_border_width](<#beautiful.slider_bar_border_width>) | The bar (background) border width.  
---|---  
[beautiful.slider_bar_border_color](<#beautiful.slider_bar_border_color>) | The bar (background) border color.  
[beautiful.slider_handle_border_color](<#beautiful.slider_handle_border_color>) | The handle border_color.  
[beautiful.slider_handle_border_width](<#beautiful.slider_handle_border_width>) | The handle border width.  
[beautiful.slider_handle_width](<#beautiful.slider_handle_width>) | The handle .  
[beautiful.slider_handle_shape](<#beautiful.slider_handle_shape>) | The handle shape.  
[beautiful.slider_bar_shape](<#beautiful.slider_bar_shape>) | The bar (background) shape.  
[beautiful.slider_bar_height](<#beautiful.slider_bar_height>) | The bar (background) height.  
[beautiful.slider_bar_margins](<#beautiful.slider_bar_margins>) | The bar (background) margins.  
[beautiful.slider_handle_margins](<#beautiful.slider_handle_margins>) | The slider handle margins.  
[beautiful.slider_bar_color](<#beautiful.slider_bar_color>) | The bar (background) color.  
  
## [Methods](<#Methods>)

[wibox.widget.slider:get_all_children ()](<#wibox.widget.slider:get_all_children>) | Get all direct and indirect children widgets.  
---|---  
[wibox.widget.slider:setup (args)](<#wibox.widget.slider:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.slider:buttons (_buttons)](<#wibox.widget.slider:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.slider:emit_signal_recursive (signal_name, ...)](<#wibox.widget.slider:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.slider:emit_signal (name, ...)](<#wibox.widget.slider:emit_signal>) | Emit a signal.  
[wibox.widget.slider:connect_signal (name, func)](<#wibox.widget.slider:connect_signal>) | Connect to a signal.  
[wibox.widget.slider:weak_connect_signal (name, func)](<#wibox.widget.slider:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.widget.slider ([args={}])**
     Create a slider widget. 

  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) (_default_ {}) 


## Object properties

**handle_shape**
     The slider handle shape.

![Usage example](../images/AUTOGEN_wibox_widget_slider_handle_shape.svg)

### Type:

  * shape gears.shape (_default_ gears shape rectangle) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**handle_color**
     The slider handle color.

![Usage example](../images/AUTOGEN_wibox_widget_slider_handle_color.svg)

### Type:

  * color


**handle_margins**
     The slider handle margins.

![Usage example](../images/AUTOGEN_wibox_widget_slider_handle_margins.svg)

### Type:

  * margins
    * left number (_default_ 0) 
    * right number (_default_ 0) 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 


**handle_width**
     The slider handle width.

![Usage example](../images/AUTOGEN_wibox_widget_slider_handle_width.svg)

### Type:

  * number


**handle_border_color**
     The handle border_color.

![Usage example](../images/AUTOGEN_wibox_widget_slider_handle_border.svg)

### Type:

  * color


**handle_border_width**
     The handle border width. 

### Type:

  * number (_default_ 0) 


**bar_shape**
     The bar (background) shape.

![Usage example](../images/AUTOGEN_wibox_widget_slider_bar_shape.svg)

### Type:

  * shape gears.shape (_default_ gears shape rectangle) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**bar_height**
     The bar (background) height.

![Usage example](../images/AUTOGEN_wibox_widget_slider_bar_height.svg)

### Type:

  * number


**bar_color**
     The bar (background) color.

![Usage example](../images/AUTOGEN_wibox_widget_slider_bar_color.svg)

### Type:

  * color


**bar_margins**
     The bar (background) margins.

![Usage example](../images/AUTOGEN_wibox_widget_slider_bar_margins.svg)

### Type:

  * margins
    * left number (_default_ 0) 
    * right number (_default_ 0) 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 


**bar_border_width**
     The bar (background) border width. 

### Type:

  * numbergb (_default_ 0) 


**bar_border_color**
     The bar (background) border_color.

![Usage example](../images/AUTOGEN_wibox_widget_slider_bar_border.svg)

### Type:

  * color


**value**
     The slider value.

**Signal:** _property::value_ notify the value is changed.

![Usage example](../images/AUTOGEN_wibox_widget_slider_value.svg)

### Type:

  * number (_default_ 0) 


**minimum**
     The slider minimum value. 

### Type:

  * number (_default_ 0) 


**maximum**
     The slider maximum value. 

### Type:

  * number (_default_ 100) 


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

[widget::redraw_needed](<../classes/wibox.widget.slider.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.slider.html#widget::layout_changed>) 

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

**beautiful.slider_bar_border_width**
     The bar (background) border width. 

### Type:

  * number


**beautiful.slider_bar_border_color**
     The bar (background) border color. 

### Type:

  * color


**beautiful.slider_handle_border_color**
     The handle border_color. 

### Type:

  * color


**beautiful.slider_handle_border_width**
     The handle border width. 

### Type:

  * number


**beautiful.slider_handle_width**
     The handle . 

### Type:

  * number


**beautiful.slider_handle_shape**
     The handle shape. 

### Type:

  * shape gears.shape (_default_ gears shape rectangle) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.slider_bar_shape**
     The bar (background) shape. 

### Type:

  * shape gears.shape (_default_ gears shape rectangle) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.slider_bar_height**
     The bar (background) height. 

### Type:

  * number


**beautiful.slider_bar_margins**
     The bar (background) margins. 

### Type:

  * margins
    * left number (_default_ 0) 
    * right number (_default_ 0) 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 


**beautiful.slider_handle_margins**
     The slider handle margins. 

### Type:

  * margins
    * left number (_default_ 0) 
    * right number (_default_ 0) 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 


**beautiful.slider_bar_color**
     The bar (background) color. 

### Type:

  * color


## Methods

**wibox.widget.slider:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.slider:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.slider:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.slider:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.slider:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.slider:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.slider:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.