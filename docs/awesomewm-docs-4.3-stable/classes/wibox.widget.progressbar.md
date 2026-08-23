# Class wibox.widget.progressbar - awesome API documentation

**Module:** `classes.wibox.widget.progressbar`  

> Source: [classes/wibox.widget.progressbar.html](https://awesomewm.org/doc/api/classes/wibox.widget.progressbar.html)

---

# Class `wibox.widget.progressbar`

A progressbar widget.

To add text on top of the progressbar, a [wibox.layout.stack](<../classes/wibox.layout.stack.html#>) can be used:

![Usage example](../images/AUTOGEN_wibox_widget_progressbar_text.svg)
    
    
    wibox.widget {
        {
            max_value     = 1,
            value         = 0.5,
            forced_height = 20,
            forced_width  = 100,
            paddings      = 1,
            border_width  = 1,
            border_color  = beautiful.border_color,
            widget        = wibox.widget.progressbar,
        },
        {
            text   = '50%',
            widget = wibox.widget.textbox,
        },
        layout = wibox.layout.stack
    }
    

To display the progressbar vertically, use a [wibox.container.rotate](<../classes/wibox.container.rotate.html#>) widget:

![Usage example](../images/AUTOGEN_wibox_widget_progressbar_vertical.svg)
    
    
    wibox.widget {
        {
            max_value     = 1,
            value         = 0.33,
            widget        = wibox.widget.progressbar,
        },
        forced_height = 100,
        forced_width  = 20,
        direction     = 'east',
        layout        = wibox.container.rotate,
    }
    

By default, this widget will take all the available size. To prevent this, a [wibox.container.constraint](<../classes/wibox.container.constraint.html#>) widget or the [forced_width](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.forced_width>)/[forced_height](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.forced_height>) properties have to be used.

![Usage example](../images/AUTOGEN_wibox_widget_defaults_progressbar.svg)

### Usage:
    
    wibox.widget {
        max_value     = 1,
        value         = 0.33,
        forced_height = 20,
        forced_width  = 100,
        shape         = gears.shape.rounded_bar,
        border_width  = 2,
        border_color  = beautiful.border_color,
        widget        = wibox.widget.progressbar,
    }
    


### Info:

  * **Copyright** : 2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[wibox.widget.progressbar (args)](<#wibox.widget.progressbar>) | Create a progressbar widget.  
---|---  
  
## [Object properties](<#Object_properties>)

[border_color](<#wibox.widget.progressbar.border_color>) | The progressbar border color.  
---|---  
[border_width](<#wibox.widget.progressbar.border_width>) | The progressbar border width.  
[bar_border_color](<#wibox.widget.progressbar.bar_border_color>) | The progressbar inner border color.  
[bar_border_width](<#wibox.widget.progressbar.bar_border_width>) | The progressbar inner border width.  
[color](<#wibox.widget.progressbar.color>) | The progressbar foreground color.  
[background_color](<#wibox.widget.progressbar.background_color>) | The progressbar background color.  
[bar_shape](<#wibox.widget.progressbar.bar_shape>) | The progressbar inner shape.  
[shape](<#wibox.widget.progressbar.shape>) | The progressbar shape.  
[clip](<#wibox.widget.progressbar.clip>) | Force the inner part (the bar) to fit in the background shape.  
[ticks](<#wibox.widget.progressbar.ticks>) | The progressbar to draw ticks.  
[ticks_gap](<#wibox.widget.progressbar.ticks_gap>) | The progressbar ticks gap.  
[ticks_size](<#wibox.widget.progressbar.ticks_size>) | The progressbar ticks size.  
[max_value](<#wibox.widget.progressbar.max_value>) | The maximum value the progressbar should handle.  
[margins](<#wibox.widget.progressbar.margins>) | The progressbar margins.  
[paddings](<#wibox.widget.progressbar.paddings>) | The progressbar padding.  
[forced_height](<#wibox.widget.progressbar.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.progressbar.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.progressbar.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.progressbar.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.progressbar_bg](<#beautiful.progressbar_bg>) | The progressbar background color.  
---|---  
[beautiful.progressbar_fg](<#beautiful.progressbar_fg>) | The progressbar foreground color.  
[beautiful.progressbar_shape](<#beautiful.progressbar_shape>) | The progressbar shape.  
[beautiful.progressbar_border_color](<#beautiful.progressbar_border_color>) | The progressbar border color.  
[beautiful.progressbar_border_width](<#beautiful.progressbar_border_width>) | The progressbar outer border width.  
[beautiful.progressbar_bar_shape](<#beautiful.progressbar_bar_shape>) | The progressbar inner shape.  
[beautiful.progressbar_bar_border_width](<#beautiful.progressbar_bar_border_width>) | The progressbar bar border width.  
[beautiful.progressbar_bar_border_color](<#beautiful.progressbar_bar_border_color>) | The progressbar bar border color.  
[beautiful.progressbar_margins](<#beautiful.progressbar_margins>) | The progressbar margins.  
[beautiful.progressbar_paddings](<#beautiful.progressbar_paddings>) | The progressbar padding.  
  
## [Deprecated functions](<#Deprecated_functions>)

[wibox.widget.progressbar.set_vertical](<#wibox.widget.progressbar.set_vertical>) _[deprecated]_ | Set the progressbar to draw vertically.  
---|---  
[wibox.widget.progressbar.set_height](<#wibox.widget.progressbar.set_height>) _[deprecated]_ | Set the progressbar height.  
[wibox.widget.progressbar.set_width](<#wibox.widget.progressbar.set_width>) _[deprecated]_ | Set the progressbar width.  
  
## [Methods](<#Methods>)

[wibox.widget.progressbar:set_value (value)](<#wibox.widget.progressbar:set_value>) | Set the progressbar value.  
---|---  
[wibox.widget.progressbar:get_all_children ()](<#wibox.widget.progressbar:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.widget.progressbar:setup (args)](<#wibox.widget.progressbar:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.progressbar:buttons (_buttons)](<#wibox.widget.progressbar:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.progressbar:emit_signal_recursive (signal_name, ...)](<#wibox.widget.progressbar:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.progressbar:emit_signal (name, ...)](<#wibox.widget.progressbar:emit_signal>) | Emit a signal.  
[wibox.widget.progressbar:connect_signal (name, func)](<#wibox.widget.progressbar:connect_signal>) | Connect to a signal.  
[wibox.widget.progressbar:weak_connect_signal (name, func)](<#wibox.widget.progressbar:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.widget.progressbar (args)**
     Create a progressbar widget. 

  * args Standard widget() arguments. You should add width and height key to set progressbar geometry. 


### Returns:

A progressbar widget. 


## Object properties

**border_color**
     The progressbar border color. If the value is nil, no border will be drawn. 

### Type:

  * color gears.color The border color to set. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**border_width**
     The progressbar border width. 
**bar_border_color**
     The progressbar inner border color. If the value is nil, no border will be drawn. 

### Type:

  * color gears.color The border color to set. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**bar_border_width**
     The progressbar inner border width. 
**color**
     The progressbar foreground color. 

### Type:

  * color gears.color The progressbar color. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**background_color**
     The progressbar background color. 

### Type:

  * color gears.color The progressbar background color. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**bar_shape**
     The progressbar inner shape.

![Usage example](../images/AUTOGEN_wibox_widget_progressbar_bar_shape.svg)

### Type:

  * shape gears.shape (_default_ gears.shape.rectangle) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 


### Usage:
    
    for _, shape in ipairs {'rounded_bar', 'octogon', 'hexagon', 'powerline' } do
        l:add(wibox.widget {
              value            = 0.33,
              bar_shape        = gears.shape[shape],
              bar_border_color = beautiful.border_color,
              bar_border_width = 1,
              border_width     = 2,
              border_color     = beautiful.border_color,
              paddings         = 1,
              widget           = wibox.widget.progressbar,
          })
    end


**shape**
     The progressbar shape.

![Usage example](../images/AUTOGEN_wibox_widget_progressbar_shape.svg)

### Type:

  * shape gears.shape (_default_ gears.shape.rectangle) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 


### Usage:
    
    for _, shape in ipairs {'rounded_bar', 'octogon', 'hexagon', 'powerline' } do
        l:add(wibox.widget {
              value         = 0.33,
              shape         = gears.shape[shape],
              border_width  = 2,
              border_color  = beautiful.border_color,
              widget        = wibox.widget.progressbar,
          })
    end


**clip**
     Force the inner part (the bar) to fit in the background shape.

![Usage example](../images/AUTOGEN_wibox_widget_progressbar_clip.svg)

### Type:

  * clip boolean (_default_ true) 


### Usage:
    
    wibox.widget {
        value            = 75,
        max_value        = 100,
        border_width     = 2,
        border_color     = beautiful.border_color,
        color            = beautiful.border_color,
        shape            = gears.shape.rounded_bar,
        bar_shape        = gears.shape.rounded_bar,
        clip             = false,
        forced_height    = 30,
        forced_width     = 100,
        paddings         = 5,
        margins          = {
            top    = 12,
            bottom = 12,
        },
        widget = wibox.widget.progressbar,
    }


**ticks**
     The progressbar to draw ticks. Default is false. 

### Type:

  * boolean


**ticks_gap**
     The progressbar ticks gap. 

### Type:

  * number


**ticks_size**
     The progressbar ticks size. 

### Type:

  * number


**max_value**
     The maximum value the progressbar should handle. 

### Type:

  * number


**margins**
     The progressbar margins. Note that if the [clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) is disabled, this allows the background to be smaller than the bar.

See the [clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) example. 

### Type:

  * margins A table for each side or a number 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


### See also:

[clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) 

**paddings**
     The progressbar padding. Note that if the [clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) is disabled, this allows the bar to be taller than the background.

See the [clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) example. 

### Type:

  * padding A table for each side or a number 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


### See also:

[clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) 

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

[widget::redraw_needed](<../classes/wibox.widget.progressbar.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.progressbar.html#widget::layout_changed>) 

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

**beautiful.progressbar_bg**
     The progressbar background color. 
**beautiful.progressbar_fg**
     The progressbar foreground color. 
**beautiful.progressbar_shape**
     The progressbar shape. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.progressbar_border_color**
     The progressbar border color. 
**beautiful.progressbar_border_width**
     The progressbar outer border width. 
**beautiful.progressbar_bar_shape**
     The progressbar inner shape. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.progressbar_bar_border_width**
     The progressbar bar border width. 
**beautiful.progressbar_bar_border_color**
     The progressbar bar border color. 
**beautiful.progressbar_margins**
     The progressbar margins. Note that if the [clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) is disabled, this allows the background to be smaller than the bar. 

### Type:

  * margins A table for each side or a number 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


### See also:

[clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) 

**beautiful.progressbar_paddings**
     The progressbar padding. Note that if the [clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) is disabled, this allows the bar to be taller than the background. 

### Type:

  * padding A table for each side or a number 
    * top number (_default_ 0) 
    * bottom number (_default_ 0) 
    * left number (_default_ 0) 
    * right number (_default_ 0) 


### See also:

[clip](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.clip>) 


## Deprecated functions

**wibox.widget.progressbar.set_vertical _[deprecated]_**
     Set the progressbar to draw vertically. This doesn’t do anything anymore, use a [wibox.container.rotate](<../classes/wibox.container.rotate.html#>) widget. param:

  * vertical boolean


**wibox.widget.progressbar.set_height _[deprecated]_**
     Set the progressbar height. This method is deprecated. Use a [wibox.container.constraint](<../classes/wibox.container.constraint.html#>) widget or [forced_height](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.forced_height>). param:

  * height The height to set. 


**wibox.widget.progressbar.set_width _[deprecated]_**
     Set the progressbar width. This method is deprecated. Use a [wibox.container.constraint](<../classes/wibox.container.constraint.html#>) widget or [forced_width](<../classes/wibox.widget.progressbar.html#wibox.widget.progressbar.forced_width>). param:

  * width The width to set. 


Methods

**wibox.widget.progressbar:set_value (value)**
     Set the progressbar value. 

  * value The progress bar value between 0 and 1. 


**wibox.widget.progressbar:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.progressbar:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.progressbar:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.progressbar:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.progressbar:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.progressbar:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.progressbar:weak_connect_signal (name, func)**
     Connect to a signal weakly. This allows the callback function to be garbage collected and automatically disconnects the signal when that happens. **Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.