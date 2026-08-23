# Class wibox.widget.imagebox - awesome API documentation

**Module:** `classes.wibox.widget.imagebox`  

> Source: [classes/wibox.widget.imagebox.html](https://awesomewm.org/doc/api/classes/wibox.widget.imagebox.html)

---

# Class `wibox.widget.imagebox`

![Usage example](../images/AUTOGEN_wibox_widget_defaults_imagebox.svg)

### Usage:
    
    wibox.widget {
        image  = beautiful.awesome_icon,
        resize = false,
        widget = wibox.widget.imagebox
    }
    


### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.widget.imagebox (image, resize_allowed, clip_shape)](<#wibox.widget.imagebox>) | Returns a new imagebox.  
---|---  
  
## [Object properties](<#Object_properties>)

[image](<#wibox.widget.imagebox.image>) | Set an imagebox' image  
---|---  
[clip_shape](<#wibox.widget.imagebox.clip_shape>) | Set a clip shape for this imagebox A clip shape define an area where the content is displayed and one where it is trimmed.  
[resize](<#wibox.widget.imagebox.resize>) | Should the image be resized to fit into the available space?  
[forced_height](<#wibox.widget.imagebox.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.imagebox.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.imagebox.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.imagebox.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.widget.imagebox:set_clip_shape (clip_shape)](<#wibox.widget.imagebox:set_clip_shape>) | Set a clip shape for this imagebox A clip shape define an area where the content is displayed and one where it is trimmed.  
---|---  
[wibox.widget.imagebox:get_all_children ()](<#wibox.widget.imagebox:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.widget.imagebox:setup (args)](<#wibox.widget.imagebox:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.imagebox:buttons (_buttons)](<#wibox.widget.imagebox:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.imagebox:emit_signal_recursive (signal_name, ...)](<#wibox.widget.imagebox:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.imagebox:emit_signal (name, ...)](<#wibox.widget.imagebox:emit_signal>) | Emit a signal.  
[wibox.widget.imagebox:connect_signal (name, func)](<#wibox.widget.imagebox:connect_signal>) | Connect to a signal.  
[wibox.widget.imagebox:weak_connect_signal (name, func)](<#wibox.widget.imagebox:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.widget.imagebox (image, resize_allowed, clip_shape)**
     Returns a new imagebox. Any other arguments will be passed to the clip shape function 

  * image the image to display, may be nil 
  * resize_allowed If false, the image will be clipped, else it will be resized to fit into the available space. 
  * clip_shape A [gears.shape](<../libraries/gears.shape.html#>) compatible function 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new [imagebox](<../classes/wibox.widget.imagebox.html>) 


## Object properties

**image**
     Set an imagebox' image 

### Type:

  * image Either a string or a cairo image surface. A string is interpreted as the path to a png image file. 


**clip_shape**
     Set a clip shape for this imagebox A clip shape define an area where the content is displayed and one where it is trimmed. 

### Type:

  * clip_shape A `gears_shape` compatible shape function 


### See also:

  * [gears.shape](<../libraries/gears.shape.html#>)
  * [set_clip_shape](<../classes/wibox.widget.imagebox.html#wibox.widget.imagebox:set_clip_shape>)


**resize**
     Should the image be resized to fit into the available space? 

### Type:

  * allowed If false, the image will be clipped, else it will be resized to fit into the available space. 


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

[widget::redraw_needed](<../classes/wibox.widget.imagebox.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.imagebox.html#widget::layout_changed>) 

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

**wibox.widget.imagebox:set_clip_shape (clip_shape)**
     Set a clip shape for this imagebox A clip shape define an area where the content is displayed and one where it is trimmed.

Any other parameters will be passed to the clip shape function 

  * clip_shape A `gears_shape` compatible shape function 


### See also:

  * [gears.shape](<../libraries/gears.shape.html#>)
  * [clip_shape](<../classes/wibox.widget.imagebox.html#wibox.widget.imagebox.clip_shape>)


**wibox.widget.imagebox:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.imagebox:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.imagebox:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.imagebox:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.imagebox:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.imagebox:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.imagebox:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.