# Class awful.widget.only_on_screen - awesome API documentation

**Module:** `classes.awful.widget.only_on_screen`  

> Source: [classes/awful.widget.only_on_screen.html](https://awesomewm.org/doc/api/classes/awful.widget.only_on_screen.html)

---

# Class `awful.widget.only_on_screen`

A container that makes a widget display only on a specified screen.

### Info:

  * **Copyright** : 2017 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.container.only_on_screen ([widget[, s]])](<#wibox.container.only_on_screen>) | Returns a new only_on_screen container.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#awful.widget.only_on_screen.widget>) | The widget to be displayed  
---|---  
[screen](<#awful.widget.only_on_screen.screen>) | The screen to display on.  
[forced_height](<#awful.widget.only_on_screen.forced_height>) | Force a widget height.  
[forced_width](<#awful.widget.only_on_screen.forced_width>) | Force a widget width.  
[opacity](<#awful.widget.only_on_screen.opacity>) | The widget opacity (transparency).  
[visible](<#awful.widget.only_on_screen.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[awful.widget.only_on_screen:get_children ()](<#awful.widget.only_on_screen:get_children>) | Get the number of children element  
---|---  
[awful.widget.only_on_screen:set_children (children)](<#awful.widget.only_on_screen:set_children>) | Replace the layout children This layout only accept one children, all others will be ignored  
[awful.widget.only_on_screen:get_all_children ()](<#awful.widget.only_on_screen:get_all_children>) | Get all direct and indirect children widgets.  
[awful.widget.only_on_screen:setup (args)](<#awful.widget.only_on_screen:setup>) | Set a declarative widget hierarchy description.  
[awful.widget.only_on_screen:buttons (_buttons)](<#awful.widget.only_on_screen:buttons>) | Set/get a widget’s buttons.  
[awful.widget.only_on_screen:emit_signal_recursive (signal_name, ...)](<#awful.widget.only_on_screen:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[awful.widget.only_on_screen:emit_signal (name, ...)](<#awful.widget.only_on_screen:emit_signal>) | Emit a signal.  
[awful.widget.only_on_screen:connect_signal (name, func)](<#awful.widget.only_on_screen:connect_signal>) | Connect to a signal.  
[awful.widget.only_on_screen:weak_connect_signal (name, func)](<#awful.widget.only_on_screen:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.container.only_on_screen ([widget[, s]])**
     Returns a new only_on_screen container. This widget makes some other widget visible on just some screens. Use `:set_widget()` to set the widget and `:set_screen()` to set the screen. 

  * widget The widget to display. (_optional_) 
  * s The screen to display on. (_optional_) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new only_on_screen container 


## Object properties

**widget**
     The widget to be displayed 

### Type:

  * widget [widget](<../classes/awful.widget.only_on_screen.html#awful.widget.only_on_screen.widget>) The widget 


**screen**
     The screen to display on. Can be a screen object, a screen index, a screen name (“VGA1”) or the string “primary” for the primary screen. 

### Type:

  * screen [screen](<../classes/screen.html#>), [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or integer The screen. 


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

[widget::redraw_needed](<../classes/awful.widget.only_on_screen.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/awful.widget.only_on_screen.html#widget::layout_changed>) 

**button::press**
     When a mouse button is pressed over the widget. 

### Arguments:

  * lx number The horizontal position relative to the (0,0) position in the widget. 
  * ly number The vertical position relative to the (0,0) position in the widget. 
  * button number The button number. 
  * mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifiers (mod4, mod1 (alt), Control, Shift) 
  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/awful.widget.only_on_screen.html#awful.widget.only_on_screen.widget>) The widget being displayed. 
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
    * widget [widget](<../classes/awful.widget.only_on_screen.html#awful.widget.only_on_screen.widget>) The widget being displayed. 
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
    * widget [widget](<../classes/awful.widget.only_on_screen.html#awful.widget.only_on_screen.widget>) The widget being displayed. 
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
    * widget [widget](<../classes/awful.widget.only_on_screen.html#awful.widget.only_on_screen.widget>) The widget being displayed. 
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

**awful.widget.only_on_screen:get_children ()**
     Get the number of children element 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**awful.widget.only_on_screen:set_children (children)**
     Replace the layout children This layout only accept one children, all others will be ignored 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets 


**awful.widget.only_on_screen:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**awful.widget.only_on_screen:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**awful.widget.only_on_screen:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**awful.widget.only_on_screen:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**awful.widget.only_on_screen:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**awful.widget.only_on_screen:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**awful.widget.only_on_screen:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.