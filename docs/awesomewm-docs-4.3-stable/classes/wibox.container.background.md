# Class wibox.container.background - awesome API documentation

**Module:** `classes.wibox.container.background`  

> Source: [classes/wibox.container.background.html](https://awesomewm.org/doc/api/classes/wibox.container.background.html)

---

# Class `wibox.container.background`

A container capable of changing the background color, foreground color widget shape.

![Usage example](../images/AUTOGEN_wibox_container_defaults_background.svg)

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.container.background ([widget[, bg[, shape]]])](<#wibox.container.background>) | Returns a new background container.  
---|---  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.background.widget>) | The widget displayed in the background widget.  
---|---  
[bg](<#wibox.container.background.bg>) | The background color/pattern/gradient to use.  
[fg](<#wibox.container.background.fg>) | The foreground (text) color/pattern/gradient to use.  
[shape](<#wibox.container.background.shape>) | The background shap e.  
[shape_border_width](<#wibox.container.background.shape_border_width>) | When a [shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) is set, also draw a border.  
[shape_border_color](<#wibox.container.background.shape_border_color>) | When a [shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) is set, also draw a border.  
[shape_clip](<#wibox.container.background.shape_clip>) | When a [shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) is set, make sure nothing is drawn outside of it.  
[bgimage](<#wibox.container.background.bgimage>) | The background image to use If `image` is a function, it will be called with `(context, cr, width, height)` as arguments.  
[forced_height](<#wibox.container.background.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.background.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.background.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.background.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Methods](<#Methods>)

[wibox.container.background:set_shape (shape)](<#wibox.container.background:set_shape>) | Set the background shape.  
---|---  
[wibox.container.background:get_all_children ()](<#wibox.container.background:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.background:setup (args)](<#wibox.container.background:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.background:buttons (_buttons)](<#wibox.container.background:buttons>) | Set/get a widget’s buttons.  
[wibox.container.background:emit_signal_recursive (signal_name, ...)](<#wibox.container.background:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.background:emit_signal (name, ...)](<#wibox.container.background:emit_signal>) | Emit a signal.  
[wibox.container.background:connect_signal (name, func)](<#wibox.container.background:connect_signal>) | Connect to a signal.  
[wibox.container.background:weak_connect_signal (name, func)](<#wibox.container.background:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.container.background ([widget[, bg[, shape]]])**
     Returns a new background container.

A background container applies a background and foreground color to another widget. 

  * widget The widget to display. (_optional_) 
  * bg The background to use for that widget. (_optional_) 
  * shape A [gears.shape](<../libraries/gears.shape.html#>) compatible shape function (_optional_) 


## Object properties

**widget**
     The widget displayed in the background widget. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget to be disaplayed inside of the background area 


**bg**
     The background color/pattern/gradient to use.

![Usage example](../images/AUTOGEN_wibox_container_background_bg.svg)

### Type:

  * bg A color string, pattern or gradient 


### See also:

[gears.color](<../libraries/gears.color.html#>) 


### Usage:
    
    local text_widget = {
        text   = 'Hello world!',
        widget = wibox.widget.textbox
    }
    parent : setup {
        {
            text_widget,
            bg     = '#ff0000',
            widget = wibox.container.background
        },
        {
            text_widget,
            bg     = '#00ff00',
            widget = wibox.container.background
        },
        {
            text_widget,
            bg     = '#0000ff',
            widget = wibox.container.background
        },
        spacing = 10,
        layout  = wibox.layout.fixed.vertical
    }


**fg**
     The foreground (text) color/pattern/gradient to use.

![Usage example](../images/AUTOGEN_wibox_container_background_fg.svg)

### Type:

  * fg A color string, pattern or gradient 


### See also:

[gears.color](<../libraries/gears.color.html#>) 


### Usage:
    
    local text_widget = {
        text   = 'Hello world!',
        widget = wibox.widget.textbox
    }
    parent : setup {
        {
            text_widget,
            fg     = '#ff0000',
            widget = wibox.container.background
        },
        {
            text_widget,
            fg     = '#00ff00',
            widget = wibox.container.background
        },
        {
            text_widget,
            fg     = '#0000ff',
            widget = wibox.container.background
        },
        spacing = 10,
        layout  = wibox.layout.fixed.vertical
    }


**shape**
     The background shap e.

Use [set_shape](<../classes/wibox.container.background.html#wibox.container.background:set_shape>) to set additional shape paramaters.

![Usage example](../images/AUTOGEN_wibox_container_background_shape.svg)

### Type:

  * shape A function taking a context, width and height as arguments 


### See also:

  * [gears.shape](<../libraries/gears.shape.html#>)
  * [set_shape](<../classes/wibox.container.background.html#wibox.container.background:set_shape>)


### Usage:
    
    parent : setup {
        {
            -- Adding a shape without margin may result in cropped output
            {
                text   = 'Hello world!',
                widget = wibox.widget.textbox
            },
            shape              = gears.shape.hexagon,
            bg                 = beautiful.bg_normal,
            shape_border_color = beautiful.border_color,
            shape_border_width = beautiful.border_width,
            widget             = wibox.container.background
        },
        {
            -- To solve this, use a margin
            {
                {
                    text   = 'Hello world!',
                    widget = wibox.widget.textbox
                },
                left   = 10,
                right  = 10,
                top    = 3,
                bottom = 3,
                widget = wibox.container.margin
            },
            shape              = gears.shape.hexagon,
            bg                 = beautiful.bg_normal,
            shape_border_color = beautiful.border_color,
            shape_border_width = beautiful.border_width,
            widget             = wibox.container.background
        },
        spacing = 10,
        layout  = wibox.layout.fixed.vertical
    }


**shape_border_width**
     When a [shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) is set, also draw a border.

See [wibox.container.background.shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) for an usage example. 

### Type:

  * width number The border width 


**shape_border_color**
     When a [shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) is set, also draw a border.

See [wibox.container.background.shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) for an usage example. 

### Type:

  * fg The border color, pattern or gradient (_default_ self._private.foreground) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**shape_clip**
     When a [shape](<../classes/wibox.container.background.html#wibox.container.background.shape>) is set, make sure nothing is drawn outside of it.

![Usage example](../images/AUTOGEN_wibox_container_background_clip.svg)

### Type:

  * value boolean If the shape clip is enable 


### Usage:
    
    parent : setup {
        {
            -- Some content may be outside of the shape
            {
                text   = 'Hello\nworld!',
                widget = wibox.widget.textbox
            },
            shape              = gears.shape.circle,
            bg                 = beautiful.bg_normal,
            shape_border_color = beautiful.border_color,
            widget             = wibox.container.background
        },
        {
            -- To solve this, clip the content
            {
                text   = 'Hello\nworld!',
                widget = wibox.widget.textbox
            },
            shape_clip         = true,
            shape              = gears.shape.circle,
            bg                 = beautiful.bg_normal,
            shape_border_color = beautiful.border_color,
            widget             = wibox.container.background
        },
        spacing = 10,
        layout  = wibox.layout.fixed.vertical
    }


**bgimage**
     The background image to use If `image` is a function, it will be called with `(context, cr, width, height)` as arguments. Any other arguments passed to this method will be appended. 

### Type:

  * image A background image or a function 


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

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

[widget::redraw_needed](<../classes/wibox.container.background.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.background.html#widget::layout_changed>) 

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

**wibox.container.background:set_shape (shape)**
     Set the background shape.

Any other arguments will be passed to the shape function 

  * shape A function taking a context, width and height as arguments 


### See also:

  * [gears.shape](<../libraries/gears.shape.html#>)
  * [shape](<../classes/wibox.container.background.html#wibox.container.background.shape>)


**wibox.container.background:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.background:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.background:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.background:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.background:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.background:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.background:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.