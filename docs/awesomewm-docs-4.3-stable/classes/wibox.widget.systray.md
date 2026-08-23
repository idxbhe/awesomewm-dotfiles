# Class wibox.widget.systray - awesome API documentation

**Module:** `classes.wibox.widget.systray`  

> Source: [classes/wibox.widget.systray.html](https://awesomewm.org/doc/api/classes/wibox.widget.systray.html)

---

# Class `wibox.widget.systray`

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.widget.systray (revers)](<#wibox.widget.systray>) | Create the systray widget.  
---|---  
  
## [Object properties](<#Object_properties>)

[forced_height](<#wibox.widget.systray.forced_height>) | Force a widget height.  
---|---  
[forced_width](<#wibox.widget.systray.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.systray.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.systray.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.bg_systray](<#beautiful.bg_systray>) | The systray background color.  
---|---  
[beautiful.systray_icon_spacing](<#beautiful.systray_icon_spacing>) | The systray icon spacing.  
  
## [Methods](<#Methods>)

[wibox.widget.systray:set_base_size (size)](<#wibox.widget.systray:set_base_size>) | Set the size of a single icon.  
---|---  
[wibox.widget.systray:set_horizontal (horiz)](<#wibox.widget.systray:set_horizontal>) | Decide between horizontal or vertical display.  
[wibox.widget.systray:set_reverse (rev)](<#wibox.widget.systray:set_reverse>) | Should the systray icons be displayed in reverse order?  
[wibox.widget.systray:set_screen (s)](<#wibox.widget.systray:set_screen>) | Set the screen that the systray should be displayed on.  
[wibox.widget.systray:get_all_children ()](<#wibox.widget.systray:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.widget.systray:setup (args)](<#wibox.widget.systray:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.systray:buttons (_buttons)](<#wibox.widget.systray:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.systray:emit_signal_recursive (signal_name, ...)](<#wibox.widget.systray:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.systray:emit_signal (name, ...)](<#wibox.widget.systray:emit_signal>) | Emit a signal.  
[wibox.widget.systray:connect_signal (name, func)](<#wibox.widget.systray:connect_signal>) | Connect to a signal.  
[wibox.widget.systray:weak_connect_signal (name, func)](<#wibox.widget.systray:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.widget.systray (revers)**
     Create the systray widget. Note that this widget can only exist once. 

  * revers boolean Show in the opposite direction 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new [systray](<../classes/wibox.widget.systray.html>) widget 


## Object properties

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

[widget::redraw_needed](<../classes/wibox.widget.systray.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.systray.html#widget::layout_changed>) 

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

**beautiful.bg_systray**
     The systray background color. 

### Type:

  * string The color (string like “#ff0000” only) 


**beautiful.systray_icon_spacing**
     The systray icon spacing. 

### Type:

  * The integer icon spacing (_default_ 0) 


## Methods

**wibox.widget.systray:set_base_size (size)**
     Set the size of a single icon. If this is set to nil, then the size is picked dynamically based on the available space. Otherwise, any single icon has a size of `size`x`size`. 

  * size integer or nil The base size 


**wibox.widget.systray:set_horizontal (horiz)**
     Decide between horizontal or vertical display. 

  * horiz boolean Use horizontal mode? 


**wibox.widget.systray:set_reverse (rev)**
     Should the systray icons be displayed in reverse order? 

  * rev boolean Display in reverse order 


**wibox.widget.systray:set_screen (s)**
     Set the screen that the systray should be displayed on. This can either be a screen, in which case the systray will be displayed on exactly that screen, or the string `"primary"`, in which case it will be visible on the primary screen. The default value is “primary”. 

  * s [screen](<../classes/screen.html#>) or "primary" The screen to display on. 


**wibox.widget.systray:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.systray:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.systray:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.systray:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.systray:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.systray:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.systray:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.