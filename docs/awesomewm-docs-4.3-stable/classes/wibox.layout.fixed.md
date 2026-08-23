# Class wibox.layout.fixed - awesome API documentation

**Module:** `classes.wibox.layout.fixed`  

> Source: [classes/wibox.layout.fixed.html](https://awesomewm.org/doc/api/classes/wibox.layout.fixed.html)

---

# Class `wibox.layout.fixed`

![Usage example](../images/AUTOGEN_wibox_layout_defaults_fixed.svg)

### Usage:
    
    wibox.widget {
        generic_widget( 'first'  ),
        generic_widget( 'second' ),
        generic_widget( 'third'  ),
        layout  = wibox.layout.fixed.horizontal
    }
    


### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.layout.fixed.horizontal (...)](<#wibox.layout.fixed.horizontal>) | Returns a new horizontal fixed layout.  
---|---  
[wibox.layout.fixed.vertical (...)](<#wibox.layout.fixed.vertical>) | Returns a new vertical fixed layout.  
  
## [Object properties](<#Object_properties>)

[spacing_widget](<#wibox.layout.fixed.spacing_widget>) | The widget used to fill the spacing between the layout elements.  
---|---  
[fill_space](<#wibox.layout.fixed.fill_space>) | Set the layout’s fill_space property.  
[spacing](<#wibox.layout.fixed.spacing>) | Add spacing between each layout widgets.  
[children](<#wibox.layout.fixed.children>) | Get all direct children of this layout.  
[forced_height](<#wibox.layout.fixed.forced_height>) | Force a widget height.  
[forced_width](<#wibox.layout.fixed.forced_width>) | Force a widget width.  
[opacity](<#wibox.layout.fixed.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.layout.fixed.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.layout.fixed:add (...)](<#wibox.layout.fixed:add>) | Add some widgets to the given fixed layout  
---|---  
[wibox.layout.fixed:remove (index)](<#wibox.layout.fixed:remove>) | Remove a widget from the layout  
[wibox.layout.fixed:remove_widgets (widget)](<#wibox.layout.fixed:remove_widgets>) | Remove one or more widgets from the layout The last parameter can be a boolean, forcing a recursive seach of the widget(s) to remove.  
[wibox.layout.fixed:replace_widget (widget, widget2[, recursive=false])](<#wibox.layout.fixed:replace_widget>) | Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`  
[wibox.layout.fixed:insert (index, widget)](<#wibox.layout.fixed:insert>) | Insert a new widget in the layout at position `index` **Signal:** widget::inserted The arguments are the widget and the index  
[wibox.layout.fixed:set (index, widget2)](<#wibox.layout.fixed:set>) | Set a widget at a specific index, replace the current one.  
[wibox.layout.fixed:replace_widget (widget, widget2[, recursive=false])](<#wibox.layout.fixed:replace_widget>) | Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`.  
[wibox.layout.fixed:swap (index1, index2)](<#wibox.layout.fixed:swap>) | Swap 2 widgets in a layout.  
[wibox.layout.fixed:swap_widgets (widget1, widget2[, recursive=false])](<#wibox.layout.fixed:swap_widgets>) | Swap 2 widgets in a layout.  
[wibox.layout.fixed:reset (layout)](<#wibox.layout.fixed:reset>) | Reset a ratio layout.  
[wibox.layout.fixed:get_all_children ()](<#wibox.layout.fixed:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.layout.fixed:setup (args)](<#wibox.layout.fixed:setup>) | Set a declarative widget hierarchy description.  
[wibox.layout.fixed:buttons (_buttons)](<#wibox.layout.fixed:buttons>) | Set/get a widget’s buttons.  
[wibox.layout.fixed:emit_signal_recursive (signal_name, ...)](<#wibox.layout.fixed:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.layout.fixed:emit_signal (name, ...)](<#wibox.layout.fixed:emit_signal>) | Emit a signal.  
[wibox.layout.fixed:connect_signal (name, func)](<#wibox.layout.fixed:connect_signal>) | Connect to a signal.  
[wibox.layout.fixed:weak_connect_signal (name, func)](<#wibox.layout.fixed:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.layout.fixed.horizontal (...)**
     Returns a new horizontal fixed layout. Each widget will get as much space as it asks for and each widget will be drawn next to its neighboring widget. Widgets can be added via :add() or as arguments to this function. Note that widgets ignore [forced_height](<../classes/wibox.layout.fixed.html#wibox.layout.fixed.forced_height>). They will use the preferred/minimum width on the horizontal axis, and a stretched height on the vertical axis. 

  * ... [widget](<../classes/wibox.widget.html>) Widgets that should be added to the layout. 


**wibox.layout.fixed.vertical (...)**
     Returns a new vertical fixed layout. Each widget will get as much space as it asks for and each widget will be drawn next to its neighboring widget. Widgets can be added via :add() or as arguments to this function. Note that widgets ignore [forced_width](<../classes/wibox.layout.fixed.html#wibox.layout.fixed.forced_width>). They will use the preferred/minimum height on the vertical axis, and a stretched width on the horizontal axis. 

  * ... [widget](<../classes/wibox.widget.html>) Widgets that should be added to the layout. 


## Object properties

**spacing_widget**
     The widget used to fill the spacing between the layout elements.

By default, no widget is used.

![Usage example](../images/AUTOGEN_wibox_layout_fixed_spacing_widget.svg)

### Type:

  * widget


### Usage:
    
    -- Use the separator widget directly
    local w1 = wibox.widget {
        spacing        = 10,
        spacing_widget = wibox.widget.separator,
        layout         = wibox.layout.fixed.horizontal
    }
    -- Use a standard declarative widget construct
    local w2 = wibox.widget {
        spacing = 10,
        spacing_widget = {
            color  = '#00ff00',
            shape  = gears.shape.circle,
            widget = wibox.widget.separator,
        },
        layout = wibox.layout.fixed.horizontal
    }
    -- Use composed widgets
    local w3 = wibox.widget {
        spacing = 10,
        spacing_widget = {
            {
                text   = 'F',
                widget = wibox.widget.textbox,
            },
            bg     = '#ff0000',
            widget = wibox.container.background,
        },
        layout = wibox.layout.fixed.horizontal
    }
    -- Use negative spacing to create a powerline effect
    local w4 = wibox.widget {
        spacing = -12,
        spacing_widget = {
            color  = '#ff0000',
            shape  = gears.shape.powerline,
            widget = wibox.widget.separator,
        },
        layout = wibox.layout.fixed.horizontal
    }


**fill_space**
     Set the layout’s fill_space property. If this property is true, the last widget will get all the space that is left. If this is false, the last widget won’t be handled specially and there can be space left unused. 
**spacing**
     Add spacing between each layout widgets.

![Usage example](../images/AUTOGEN_wibox_layout_fixed_spacing.svg)

### Type:

  * spacing number Spacing between widgets. 


### Usage:
    
    for i=1, 5 do
        local w = wibox.widget {
            first,
            second,
            third,
            spacing = i*3,
            layout  = wibox.layout.fixed.horizontal
        }
    end


**children**
     Get all direct children of this layout. 

### Type:

  * layout The layout you are modifying. 


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

[widget::redraw_needed](<../classes/wibox.layout.fixed.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.layout.fixed.html#widget::layout_changed>) 

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

**wibox.layout.fixed:add (...)**
     Add some widgets to the given fixed layout 

  * ... Widgets that should be added (must at least be one) 


**wibox.layout.fixed:remove (index)**
     Remove a widget from the layout 

  * index number The widget index to remove 


### Returns:

boolean index If the operation is successful 

**wibox.layout.fixed:remove_widgets (widget)**
     Remove one or more widgets from the layout The last parameter can be a boolean, forcing a recursive seach of the widget(s) to remove. 

  * widget … Widgets that should be removed (must at least be one) 


### Returns:

boolean If the operation is successful 

**wibox.layout.fixed:replace_widget (widget, widget2[, recursive=false])**
     Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`

  * widget The widget to replace 
  * widget2 The widget to replace [widget](<../classes/wibox.widget.html>) with 
  * recursive boolean Digg in all compatible layouts to find the widget. (_default_ false) 


### Returns:

boolean If the operation is successful 

**wibox.layout.fixed:insert (index, widget)**
     Insert a new widget in the layout at position `index` **Signal:** widget::inserted The arguments are the widget and the index 

  * index number The position 
  * widget The widget 


### Returns:

boolean If the operation is successful 

**wibox.layout.fixed:set (index, widget2)**
     Set a widget at a specific index, replace the current one. **Signal:** widget::replaced The argument is the new widget and the old one and the index. 

  * index number A widget or a widget index 
  * widget2 The widget to take the place of the first one 


### Returns:

boolean If the operation is successful 

**wibox.layout.fixed:replace_widget (widget, widget2[, recursive=false])**
     Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`. **Signal:** widget::replaced The argument is the new widget and the old one and the index. 

  * widget The widget to replace 
  * widget2 The widget to replace [widget](<../classes/wibox.widget.html>) with 
  * recursive boolean Dig in all compatible layouts to find the widget. (_default_ false) 


### Returns:

boolean If the operation is successful 

**wibox.layout.fixed:swap (index1, index2)**
     Swap 2 widgets in a layout. **Signal:** widget::swapped The arguments are both widgets and both (new) indexes. 

  * index1 number The first widget index 
  * index2 number The second widget index 


### Returns:

boolean If the operation is successful 

**wibox.layout.fixed:swap_widgets (widget1, widget2[, recursive=false])**
     Swap 2 widgets in a layout. If widget1 is present multiple time, only the first instance is swapped **Signal:** widget::swapped The arguments are both widgets and both (new) indexes. if the layouts not the same, then only `widget::replaced` will be emitted. 

  * widget1 The first widget 
  * widget2 The second widget 
  * recursive boolean Dig in all compatible layouts to find the widget. (_default_ false) 


### Returns:

boolean If the operation is successful 

**wibox.layout.fixed:reset (layout)**
     Reset a ratio layout. This removes all widgets from the layout. **Signal:** widget::reset 

  * layout The layout you are modifying. 


**wibox.layout.fixed:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.layout.fixed:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.layout.fixed:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.layout.fixed:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.layout.fixed:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.layout.fixed:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.layout.fixed:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.