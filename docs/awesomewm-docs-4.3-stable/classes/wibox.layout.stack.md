# Class wibox.layout.stack - awesome API documentation

**Module:** `classes.wibox.layout.stack`  

> Source: [classes/wibox.layout.stack.html](https://awesomewm.org/doc/api/classes/wibox.layout.stack.html)

---

# Class `wibox.layout.stack`

A stacked layout.

This layout display widgets on top of each other. It can be used to overlay a [wibox.widget.textbox](<../classes/wibox.widget.textbox.html#>) on top of a `awful.widget.progressbar` or manage “pages” where only one is visible at any given moment.

The indices are going from 1 (the bottom of the stack) up to the top of the stack. The order can be changed either using `:swap` or `:raise`.

![Usage example](../images/AUTOGEN_wibox_layout_defaults_stack.svg)

### Usage:
    
    wibox.widget {
        generic_widget( 'first'  ),
        generic_widget( 'second' ),
        generic_widget( 'third'  ),
        layout  = wibox.layout.stack
    }
    


### Info:

  * **Copyright** : 2016 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee


## [Functions](<#Functions>)

[wibox.layout.stack ()](<#wibox.layout.stack>) | Create a new stack layout.  
---|---  
  
## [Object properties](<#Object_properties>)

[children](<#wibox.layout.stack.children>) | Get all direct children of this layout.  
---|---  
[spacing](<#wibox.layout.stack.spacing>) | Add spacing around the widget, similar to the margin container.  
[top_only](<#wibox.layout.stack.top_only>) | If only the first stack widget is drawn  
[horizontal_offset](<#wibox.layout.stack.horizontal_offset>) | Add an horizontal offset to each layers.  
[vertial_offset](<#wibox.layout.stack.vertial_offset>) | Add an vertical offset to each layers.  
[forced_height](<#wibox.layout.stack.forced_height>) | Force a widget height.  
[forced_width](<#wibox.layout.stack.forced_width>) | Force a widget width.  
[opacity](<#wibox.layout.stack.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.layout.stack.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.layout.stack:set (index, widget2)](<#wibox.layout.stack:set>) | Set a widget at a specific index, replace the current one.  
---|---  
[wibox.layout.stack:replace_widget (widget, widget2[, recursive=false])](<#wibox.layout.stack:replace_widget>) | Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`.  
[wibox.layout.stack:swap (index1, index2)](<#wibox.layout.stack:swap>) | Swap 2 widgets in a layout.  
[wibox.layout.stack:swap_widgets (widget1, widget2[, recursive=false])](<#wibox.layout.stack:swap_widgets>) | Swap 2 widgets in a layout.  
[wibox.layout.stack:reset (layout)](<#wibox.layout.stack:reset>) | Reset a ratio layout.  
[wibox.layout.stack:add (layout, ...)](<#wibox.layout.stack:add>) | Add some widgets to the given stack layout  
[wibox.layout.stack:remove (The)](<#wibox.layout.stack:remove>) | Remove a widget from the layout  
[wibox.layout.stack:insert (index, widget)](<#wibox.layout.stack:insert>) | Insert a new widget in the layout at position `index`  
[wibox.layout.stack:remove_widgets (widget)](<#wibox.layout.stack:remove_widgets>) | Remove one or more widgets from the layout The last parameter can be a boolean, forcing a recursive seach of the widget(s) to remove.  
[wibox.layout.stack:raise (index)](<#wibox.layout.stack:raise>) | Raise a widget at `index` to the top of the stack  
[wibox.layout.stack:raise_widget (widget[, recursive=false])](<#wibox.layout.stack:raise_widget>) | Raise the first instance of [widget](<../classes/wibox.widget.html>)  
[wibox.layout.stack:get_all_children ()](<#wibox.layout.stack:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.layout.stack:setup (args)](<#wibox.layout.stack:setup>) | Set a declarative widget hierarchy description.  
[wibox.layout.stack:buttons (_buttons)](<#wibox.layout.stack:buttons>) | Set/get a widget’s buttons.  
[wibox.layout.stack:emit_signal_recursive (signal_name, ...)](<#wibox.layout.stack:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.layout.stack:emit_signal (name, ...)](<#wibox.layout.stack:emit_signal>) | Emit a signal.  
[wibox.layout.stack:connect_signal (name, func)](<#wibox.layout.stack:connect_signal>) | Connect to a signal.  
[wibox.layout.stack:weak_connect_signal (name, func)](<#wibox.layout.stack:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.layout.stack ()**
     Create a new stack layout. 

### Returns:

[widget](<../classes/wibox.widget.html>) A new stack layout 


## Object properties

**children**
     Get all direct children of this layout. 

### Type:

  * layout The layout you are modifying. 


**spacing**
     Add spacing around the widget, similar to the margin container.

![Usage example](../images/AUTOGEN_wibox_layout_stack_spacing.svg)

### Type:

  * spacing number Spacing between widgets. 


### Usage:
    
    wibox.widget {
        generic_widget( 'first'  ),
        generic_widget( 'second' ),
        generic_widget( 'third'  ),
        spacing = 6,
        layout  = wibox.layout.stack
    }


**top_only**
     If only the first stack widget is drawn 
**horizontal_offset**
     Add an horizontal offset to each layers.

Note that this reduces the overall size of each widgets by the sum of all layers offsets.

![Usage example](../images/AUTOGEN_wibox_layout_stack_offset.svg)

### Type:

  * number


### Usage:
    
    wibox.widget {
        generic_widget( 'first'  ),
        generic_widget( 'second' ),
        generic_widget( 'third'  ),
        horizontal_offset = 5,
        vertical_offset   = 5,
        layout            = wibox.layout.stack
    }


**vertial_offset**
     Add an vertical offset to each layers.

Note that this reduces the overall size of each widgets by the sum of all layers offsets. 

### Type:

  * number


### See also:

[horizontal_offset](<../classes/wibox.layout.stack.html#wibox.layout.stack.horizontal_offset>) 

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

[widget::redraw_needed](<../classes/wibox.layout.stack.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.layout.stack.html#widget::layout_changed>) 

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

**wibox.layout.stack:set (index, widget2)**
     Set a widget at a specific index, replace the current one. **Signal:** widget::replaced The argument is the new widget and the old one and the index. 

  * index number A widget or a widget index 
  * widget2 The widget to take the place of the first one 


### Returns:

boolean If the operation is successful 

**wibox.layout.stack:replace_widget (widget, widget2[, recursive=false])**
     Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`. **Signal:** widget::replaced The argument is the new widget and the old one and the index. 

  * widget The widget to replace 
  * widget2 The widget to replace [widget](<../classes/wibox.widget.html>) with 
  * recursive boolean Dig in all compatible layouts to find the widget. (_default_ false) 


### Returns:

boolean If the operation is successful 

**wibox.layout.stack:swap (index1, index2)**
     Swap 2 widgets in a layout. **Signal:** widget::swapped The arguments are both widgets and both (new) indexes. 

  * index1 number The first widget index 
  * index2 number The second widget index 


### Returns:

boolean If the operation is successful 

**wibox.layout.stack:swap_widgets (widget1, widget2[, recursive=false])**
     Swap 2 widgets in a layout. If widget1 is present multiple time, only the first instance is swapped **Signal:** widget::swapped The arguments are both widgets and both (new) indexes. if the layouts not the same, then only `widget::replaced` will be emitted. 

  * widget1 The first widget 
  * widget2 The second widget 
  * recursive boolean Dig in all compatible layouts to find the widget. (_default_ false) 


### Returns:

boolean If the operation is successful 

**wibox.layout.stack:reset (layout)**
     Reset a ratio layout. This removes all widgets from the layout. **Signal:** widget::reset 

  * layout The layout you are modifying. 


**wibox.layout.stack:add (layout, ...)**
     Add some widgets to the given stack layout 

  * layout The layout you are modifying. 
  * ... [widget](<../classes/wibox.widget.html>) Widgets that should be added (must at least be one) 


**wibox.layout.stack:remove (The)**
     Remove a widget from the layout 

  * The index widget index to remove 


### Returns:

boolean index If the operation is successful 

**wibox.layout.stack:insert (index, widget)**
     Insert a new widget in the layout at position `index`

  * index number The position 
  * widget The widget 


### Returns:

boolean If the operation is successful 

**wibox.layout.stack:remove_widgets (widget)**
     Remove one or more widgets from the layout The last parameter can be a boolean, forcing a recursive seach of the widget(s) to remove. 

  * widget … Widgets that should be removed (must at least be one) 


### Returns:

boolean If the operation is successful 

**wibox.layout.stack:raise (index)**
     Raise a widget at `index` to the top of the stack 

  * index number the widget index to raise 


**wibox.layout.stack:raise_widget (widget[, recursive=false])**
     Raise the first instance of [widget](<../classes/wibox.widget.html>)

  * widget The widget to raise 
  * recursive boolean Also look deeper in the hierarchy to find the widget (_default_ false) 


**wibox.layout.stack:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.layout.stack:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.layout.stack:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.layout.stack:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.layout.stack:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.layout.stack:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.layout.stack:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.