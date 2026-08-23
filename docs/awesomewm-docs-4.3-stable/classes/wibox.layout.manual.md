# Class wibox.layout.manual - awesome API documentation

**Module:** `classes.wibox.layout.manual`  

> Source: [classes/wibox.layout.manual.html](https://awesomewm.org/doc/api/classes/wibox.layout.manual.html)

---

# Class `wibox.layout.manual`

A layout with widgets added at specific positions.

Use cases include desktop icons, complex custom composed widgets, a floating client layout and fine grained control over the output.

![Usage example](../images/AUTOGEN_wibox_layout_defaults_manual.svg)

### Usage:
    
    local w1, w2 = generic_widget(), generic_widget()
    w1.point  = {x=75,y=5}
    w1.text   = 'first'
    w1.forced_width = 50
    w2.text = 'second'
    w2.point  = function(geo, args)
        -- Bottom right
        return {
            x = args.parent.width-geo.width,
            y = args.parent.height-geo.height
        }
    end
    wibox.layout {
        w1,
        w2,
        generic_widget('third'),
        layout  = wibox.layout.manual
    }
    


### Info:

  * **Copyright** : 2016 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee


## [Functions](<#Functions>)

[manual_layout:add_at (widget, point)](<#manual_layout:add_at>) | Add a widget at a specific point.  
---|---  
[manual_layout:move (index, point)](<#manual_layout:move>) | Move a widget (by index).  
[manual_layout:move_widget (widget, point)](<#manual_layout:move_widget>) | Move a widget.  
  
## [Object properties](<#Object_properties>)

[forced_height](<#wibox.layout.manual.forced_height>) | Force a widget height.  
---|---  
[forced_width](<#wibox.layout.manual.forced_width>) | Force a widget width.  
[opacity](<#wibox.layout.manual.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.layout.manual.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.layout.manual:add (layout, ...)](<#wibox.layout.manual:add>) | Add some widgets to the given stack layout  
---|---  
[wibox.layout.manual:remove (The)](<#wibox.layout.manual:remove>) | Remove a widget from the layout  
[wibox.layout.manual:insert (index, widget)](<#wibox.layout.manual:insert>) | Insert a new widget in the layout at position `index`  
[wibox.layout.manual:remove_widgets (widget)](<#wibox.layout.manual:remove_widgets>) | Remove one or more widgets from the layout The last parameter can be a boolean, forcing a recursive seach of the widget(s) to remove.  
[wibox.layout.manual:get_all_children ()](<#wibox.layout.manual:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.layout.manual:setup (args)](<#wibox.layout.manual:setup>) | Set a declarative widget hierarchy description.  
[wibox.layout.manual:buttons (_buttons)](<#wibox.layout.manual:buttons>) | Set/get a widget’s buttons.  
[wibox.layout.manual:emit_signal_recursive (signal_name, ...)](<#wibox.layout.manual:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.layout.manual:emit_signal (name, ...)](<#wibox.layout.manual:emit_signal>) | Emit a signal.  
[wibox.layout.manual:connect_signal (name, func)](<#wibox.layout.manual:connect_signal>) | Connect to a signal.  
[wibox.layout.manual:weak_connect_signal (name, func)](<#wibox.layout.manual:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**manual_layout:add_at (widget, point)**
     Add a widget at a specific point.

The point can either be a function or a table. The table follow the generic geometry format used elsewhere in Awesome.

  * _x_ : The horizontal position.
  * _y_ : The vertical position.
  * _width_ : The width.
  * _height_ : The height.


If a function is used, it follows the same prototype as [awful.placement](<../libraries/awful.placement.html#>) functions.

  * _geo_ : 
    * _x_ : The horizontal position (always 0).
    * _y_ : The vertical position (always 0).
    * _width_ : The width.
    * _height_ : The height.
    * _geometry_ : A function to get or set the geometry (for compatibility). The function is compatible with the [awful.placement](<../libraries/awful.placement.html#>) prototype.
  * _args_ : 
    * _parent_ The layout own geometry 
      * _x_ : The horizontal position (always 0).
      * _y_ : The vertical position (always 0).
      * _width_ : The width.
      * _height_ : The height.
      * _geometry_ : A function to get or set the geometry (for compatibility) The function is compatible with the [awful.placement](<../libraries/awful.placement.html#>) prototype.


![Usage example](../images/AUTOGEN_wibox_layout_manual_add_at.svg)

  * widget [widget](<../classes/wibox.widget.html>) The widget. 
  * point [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or function Either an `{x=x,y=y}` table or a function returning the new geometry. 


### Usage:
    
    local l = wibox.layout {
        layout  = wibox.layout.manual
    }
    --
    -- Option 1: Set the point directly in the widget
    local w1        = generic_widget()
    w1.point        = {x=75, y=5}
    w1.text         = 'first'
    w1.forced_width = 50
    l:add(w1)
    --
    -- Option 2: Set the point directly in the widget as a function
    local w2  = generic_widget()
    w2.text   = 'second'
    w2.point  = function(geo, args)
        return {
            x = args.parent.width  - geo.width,
            y = 0
        }
    end
    l:add(w2)
    --
    -- Option 3: Set the point directly in the widget as an [awful.placement](<../libraries/awful.placement.html#>)
    -- function.
    local w3 = generic_widget()
    w3.text  = 'third'
    w3.point = awful.placement.bottom_right
    l:add(w3)
    --
    -- Option 4: Use :add_at instead of using the .point property. This works
    -- with all 3 ways to define the point.
    -- function.
    local w4 = generic_widget()
    w4.text  = 'fourth'
    l:add_at(w4, awful.placement.centered + awful.placement.maximize_horizontally)


**manual_layout:move (index, point)**
     Move a widget (by index). 

  * index number The widget index. 
  * point [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or function A new point value. 


### See also:

[add_at](<../classes/wibox.layout.manual.html#manual_layout:add_at>) 

**manual_layout:move_widget (widget, point)**
     Move a widget.

![Usage example](../images/AUTOGEN_wibox_layout_manual_move_widget.svg)

  * widget [widget](<../classes/wibox.widget.html>) The widget. 
  * point [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or function A new point value. 


### See also:

[add_at](<../classes/wibox.layout.manual.html#manual_layout:add_at>) 


### Usage:
    
    local l = wibox.layout {
        layout  = wibox.layout.manual
    }
    --
    local w1        = generic_widget()
    w1.point        = {x=75, y=5}
    w1.text         = 'first'
    w1.forced_width = 50
    l:add(w1)
    l:move_widget(w1, awful.placement.bottom_right)


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

[widget::redraw_needed](<../classes/wibox.layout.manual.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.layout.manual.html#widget::layout_changed>) 

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

**wibox.layout.manual:add (layout, ...)**
     Add some widgets to the given stack layout 

  * layout The layout you are modifying. 
  * ... [widget](<../classes/wibox.widget.html>) Widgets that should be added 


**wibox.layout.manual:remove (The)**
     Remove a widget from the layout 

  * The index widget index to remove 


### Returns:

boolean index If the operation is successful 

**wibox.layout.manual:insert (index, widget)**
     Insert a new widget in the layout at position `index`

  * index number The position 
  * widget The widget 


### Returns:

boolean If the operation is successful 

**wibox.layout.manual:remove_widgets (widget)**
     Remove one or more widgets from the layout The last parameter can be a boolean, forcing a recursive seach of the widget(s) to remove. 

  * widget … Widgets that should be removed (must at least be one) 


### Returns:

boolean If the operation is successful 

**wibox.layout.manual:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.layout.manual:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.layout.manual:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.layout.manual:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.layout.manual:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.layout.manual:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.layout.manual:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.