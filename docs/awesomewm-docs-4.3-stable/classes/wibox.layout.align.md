# Class wibox.layout.align - awesome API documentation

**Module:** `classes.wibox.layout.align`  

> Source: [classes/wibox.layout.align.html](https://awesomewm.org/doc/api/classes/wibox.layout.align.html)

---

# Class `wibox.layout.align`

![Usage example](../images/AUTOGEN_wibox_layout_defaults_align.svg)

### Usage:
    
    wibox.widget {
        generic_widget( 'first'  ),
        generic_widget( 'second' ),
        generic_widget( 'third'  ),
        layout  = wibox.layout.align.horizontal
    }
    


### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Object properties](<#Object_properties>)

[first](<#wibox.layout.align.first>) | Set the layout’s first widget.  
---|---  
[second](<#wibox.layout.align.second>) | Set the layout’s second widget.  
[third](<#wibox.layout.align.third>) | Set the layout’s third widget.  
[children](<#wibox.layout.align.children>) | All direct children of this layout.  
[expand](<#wibox.layout.align.expand>) | Set the expand mode which determines how sub widgets expand to take up unused space.  
[children](<#wibox.layout.align.children>) | Get all direct children of this layout.  
[forced_height](<#wibox.layout.align.forced_height>) | Force a widget height.  
[forced_width](<#wibox.layout.align.forced_width>) | Force a widget width.  
[opacity](<#wibox.layout.align.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.layout.align.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.layout.align:horizontal ([left[, middle[, right]]])](<#wibox.layout.align:horizontal>) | Returns a new horizontal align layout.  
---|---  
[wibox.layout.align:vertical ([top[, middle[, bottom]]])](<#wibox.layout.align:vertical>) | Returns a new vertical align layout.  
[wibox.layout.align:set (index, widget2)](<#wibox.layout.align:set>) | Set a widget at a specific index, replace the current one.  
[wibox.layout.align:replace_widget (widget, widget2[, recursive=false])](<#wibox.layout.align:replace_widget>) | Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`.  
[wibox.layout.align:swap (index1, index2)](<#wibox.layout.align:swap>) | Swap 2 widgets in a layout.  
[wibox.layout.align:swap_widgets (widget1, widget2[, recursive=false])](<#wibox.layout.align:swap_widgets>) | Swap 2 widgets in a layout.  
[wibox.layout.align:reset (layout)](<#wibox.layout.align:reset>) | Reset a ratio layout.  
[wibox.layout.align:get_all_children ()](<#wibox.layout.align:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.layout.align:setup (args)](<#wibox.layout.align:setup>) | Set a declarative widget hierarchy description.  
[wibox.layout.align:buttons (_buttons)](<#wibox.layout.align:buttons>) | Set/get a widget’s buttons.  
[wibox.layout.align:emit_signal_recursive (signal_name, ...)](<#wibox.layout.align:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.layout.align:emit_signal (name, ...)](<#wibox.layout.align:emit_signal>) | Emit a signal.  
[wibox.layout.align:connect_signal (name, func)](<#wibox.layout.align:connect_signal>) | Connect to a signal.  
[wibox.layout.align:weak_connect_signal (name, func)](<#wibox.layout.align:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Object properties

**first**
     Set the layout’s first widget. This is the widget that is at the left/top 
**second**
     Set the layout’s second widget. This is the centered one. 
**third**
     Set the layout’s third widget. This is the widget that is at the right/bottom 
**children**
     All direct children of this layout. This can be used to replace all 3 widgets at once. 
**expand**
     Set the expand mode which determines how sub widgets expand to take up unused space. 

### Type:

  * mode [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)

How to use unused space.

    * “inside” \- Default option. Size of outside widgets is determined using their fit function. Second, middle, or center widget expands to fill remaining space.
    * “outside” \- Center widget is sized using its fit function and placed in the center of the allowed space. Outside widgets expand (or contract) to fill remaining space on their side.
    * “none” \- All widgets are sized using their fit function, drawn to only the returned space, or remaining space, whichever is smaller. Center widget gets priority.
(_default_ inside) 


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

[widget::redraw_needed](<../classes/wibox.layout.align.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.layout.align.html#widget::layout_changed>) 

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

**wibox.layout.align:horizontal ([left[, middle[, right]]])**
     Returns a new horizontal align layout. An align layout can display up to three widgets. The widget set via :set_left() is left-aligned. :set_right() sets a widget which will be right-aligned. The remaining space between those two will be given to the widget set via :set_middle(). 

  * left [widget](<../classes/wibox.widget.html>) Widget to be put to the left. (_optional_) 
  * middle [widget](<../classes/wibox.widget.html>) Widget to be put to the middle. (_optional_) 
  * right [widget](<../classes/wibox.widget.html>) Widget to be put to the right. (_optional_) 


**wibox.layout.align:vertical ([top[, middle[, bottom]]])**
     Returns a new vertical align layout. An align layout can display up to three widgets. The widget set via :set_top() is top-aligned. :set_bottom() sets a widget which will be bottom-aligned. The remaining space between those two will be given to the widget set via :set_middle(). 

  * top [widget](<../classes/wibox.widget.html>) Widget to be put to the top. (_optional_) 
  * middle [widget](<../classes/wibox.widget.html>) Widget to be put to the middle. (_optional_) 
  * bottom [widget](<../classes/wibox.widget.html>) Widget to be put to the right. (_optional_) 


**wibox.layout.align:set (index, widget2)**
     Set a widget at a specific index, replace the current one. **Signal:** widget::replaced The argument is the new widget and the old one and the index. 

  * index number A widget or a widget index 
  * widget2 The widget to take the place of the first one 


### Returns:

boolean If the operation is successful 

**wibox.layout.align:replace_widget (widget, widget2[, recursive=false])**
     Replace the first instance of [widget](<../classes/wibox.widget.html>) in the layout with `widget2`. **Signal:** widget::replaced The argument is the new widget and the old one and the index. 

  * widget The widget to replace 
  * widget2 The widget to replace [widget](<../classes/wibox.widget.html>) with 
  * recursive boolean Dig in all compatible layouts to find the widget. (_default_ false) 


### Returns:

boolean If the operation is successful 

**wibox.layout.align:swap (index1, index2)**
     Swap 2 widgets in a layout. **Signal:** widget::swapped The arguments are both widgets and both (new) indexes. 

  * index1 number The first widget index 
  * index2 number The second widget index 


### Returns:

boolean If the operation is successful 

**wibox.layout.align:swap_widgets (widget1, widget2[, recursive=false])**
     Swap 2 widgets in a layout. If widget1 is present multiple time, only the first instance is swapped **Signal:** widget::swapped The arguments are both widgets and both (new) indexes. if the layouts not the same, then only `widget::replaced` will be emitted. 

  * widget1 The first widget 
  * widget2 The second widget 
  * recursive boolean Dig in all compatible layouts to find the widget. (_default_ false) 


### Returns:

boolean If the operation is successful 

**wibox.layout.align:reset (layout)**
     Reset a ratio layout. This removes all widgets from the layout. **Signal:** widget::reset 

  * layout The layout you are modifying. 


**wibox.layout.align:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.layout.align:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.layout.align:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.layout.align:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.layout.align:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.layout.align:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.layout.align:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.