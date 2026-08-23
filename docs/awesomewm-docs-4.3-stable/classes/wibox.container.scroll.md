# Class wibox.container.scroll - awesome API documentation

**Module:** `classes.wibox.container.scroll`  

> Source: [classes/wibox.container.scroll.html](https://awesomewm.org/doc/api/classes/wibox.container.scroll.html)

---

# Class `wibox.container.scroll`

This container scrolls its inner widget inside of the available space.

An example usage would be a text widget that displays information about the currently playing song without using too much space for long song titles.

Please note that mouse events do not propagate to widgets inside of the scroll container. Also, if this widget is causing too high CPU usage, you can use [set_fps](<../classes/wibox.container.scroll.html#wibox.container.scroll:set_fps>) to make it update less often.

### Usage:
    
    wibox.widget {
       layout = wibox.container.scroll.horizontal,
       max_size = 100,
       step_function = wibox.container.scroll.step_functions
                       .waiting_nonlinear_back_and_forth,
       speed = 100,
       {
           widget = wibox.widget.textbox,
           text = "This is a " .. string.rep("very, ", 10) ..  " very long text",
       },
    }
    


### Info:

  * **Copyright** : 2015 Uli Schlachter
  * **Author** : Uli Schlachter (based on ideas from Saleur Geoffrey)


## [Functions](<#Functions>)

[scroll.step_functions.linear_increase (elapsed, size, _, speed, extra_space)](<#scroll.step_functions.linear_increase>) | A step function that scrolls the widget in an increasing direction with constant speed.  
---|---  
[scroll.step_functions.linear_decrease (elapsed, size, _, speed, extra_space)](<#scroll.step_functions.linear_decrease>) | A step function that scrolls the widget in an decreasing direction with constant speed.  
[scroll.step_functions.linear_back_and_forth (elapsed, size, visible_size, speed)](<#scroll.step_functions.linear_back_and_forth>) | A step function that scrolls the widget to its end and back to its beginning, then back to its end, etc.  
[scroll.step_functions.nonlinear_back_and_forth (elapsed, size, visible_size, speed)](<#scroll.step_functions.nonlinear_back_and_forth>) | A step function that scrolls the widget to its end and back to its beginning, then back to its end, etc.  
[scroll.step_functions.waiting_nonlinear_back_and_forth (elapsed, size, visible_size, speed)](<#scroll.step_functions.waiting_nonlinear_back_and_forth>) | A step function that scrolls the widget to its end and back to its beginning, then back to its end, etc.  
  
## [Object properties](<#Object_properties>)

[widget](<#wibox.container.scroll.widget>) | The widget to be scrolled.  
---|---  
[forced_height](<#wibox.container.scroll.forced_height>) | Force a widget height.  
[forced_width](<#wibox.container.scroll.forced_width>) | Force a widget width.  
[opacity](<#wibox.container.scroll.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.container.scroll.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Tables](<#Tables>)

[wibox.container.scroll.step_functions](<#wibox.container.scroll.step_functions>) | A selection of step functions  
---|---  
  
## [Methods](<#Methods>)

[wibox.container.scroll:pause ()](<#wibox.container.scroll:pause>) | Pause the scrolling animation.  
---|---  
[wibox.container.scroll:continue ()](<#wibox.container.scroll:continue>) | Continue the scrolling animation.  
[wibox.container.scroll:reset_scrolling ()](<#wibox.container.scroll:reset_scrolling>) | Reset the scrolling state to its initial condition.  
[wibox.container.scroll:set_direction (dir)](<#wibox.container.scroll:set_direction>) | Set the direction in which this widget scroll.  
[wibox.container.scroll:get_children ()](<#wibox.container.scroll:get_children>) | Get the number of children element  
[wibox.container.scroll:set_children (children)](<#wibox.container.scroll:set_children>) | Replace the layout children This layout only accept one children, all others will be ignored  
[wibox.container.scroll:set_expand (expand)](<#wibox.container.scroll:set_expand>) | Specify the expand mode that is used for extra space.  
[wibox.container.scroll:set_fps (fps)](<#wibox.container.scroll:set_fps>) | Set the number of frames per second that this widget should draw.  
[wibox.container.scroll:set_extra_space (extra_space)](<#wibox.container.scroll:set_extra_space>) | Set the amount of extra space that should be included in the scrolling.  
[wibox.container.scroll:set_speed (speed)](<#wibox.container.scroll:set_speed>) | Set the speed of the scrolling animation.  
[wibox.container.scroll:set_max_size (max_size)](<#wibox.container.scroll:set_max_size>) | Set the maximum size of this widget in the direction set by [set_direction](<../classes/wibox.container.scroll.html#wibox.container.scroll:set_direction>).  
[wibox.container.scroll:set_step_function (step_function)](<#wibox.container.scroll:set_step_function>) | Set the step function that determines the exact behaviour of the scrolling animation.  
[wibox.container.scroll:set_space_for_scrolling (space_for_scrolling)](<#wibox.container.scroll:set_space_for_scrolling>) | Set an upper limit for the space for scrolling.  
[wibox.container.scroll:horizontal ([widget[, fps=20[, speed=10[, extra_space=0[, expand=false[, max_size[, step_function=step_functions.linear_increase[, space_for_scrolling=2^1024]]]]]]]])](<#wibox.container.scroll:horizontal>) | Get a new horizontal scrolling container.  
[wibox.container.scroll:vertical ([widget[, fps=20[, speed=10[, extra_space=0[, expand=false[, max_size[, step_function=step_functions.linear_increase[, space_for_scrolling=2^1024]]]]]]]])](<#wibox.container.scroll:vertical>) | Get a new vertical scrolling container.  
[wibox.container.scroll:get_all_children ()](<#wibox.container.scroll:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.container.scroll:setup (args)](<#wibox.container.scroll:setup>) | Set a declarative widget hierarchy description.  
[wibox.container.scroll:buttons (_buttons)](<#wibox.container.scroll:buttons>) | Set/get a widget’s buttons.  
[wibox.container.scroll:emit_signal_recursive (signal_name, ...)](<#wibox.container.scroll:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.container.scroll:emit_signal (name, ...)](<#wibox.container.scroll:emit_signal>) | Emit a signal.  
[wibox.container.scroll:connect_signal (name, func)](<#wibox.container.scroll:connect_signal>) | Connect to a signal.  
[wibox.container.scroll:weak_connect_signal (name, func)](<#wibox.container.scroll:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**scroll.step_functions.linear_increase (elapsed, size, _, speed, extra_space)**
     A step function that scrolls the widget in an increasing direction with constant speed. 

  * elapsed
  * size
  * _
  * speed
  * extra_space


**scroll.step_functions.linear_decrease (elapsed, size, _, speed, extra_space)**
     A step function that scrolls the widget in an decreasing direction with constant speed. 

  * elapsed
  * size
  * _
  * speed
  * extra_space


**scroll.step_functions.linear_back_and_forth (elapsed, size, visible_size, speed)**
     A step function that scrolls the widget to its end and back to its beginning, then back to its end, etc. The speed is constant. 

  * elapsed
  * size
  * visible_size
  * speed


**scroll.step_functions.nonlinear_back_and_forth (elapsed, size, visible_size, speed)**
     A step function that scrolls the widget to its end and back to its beginning, then back to its end, etc. The speed is null at the ends and maximal in the middle. 

  * elapsed
  * size
  * visible_size
  * speed


**scroll.step_functions.waiting_nonlinear_back_and_forth (elapsed, size, visible_size, speed)**
     A step function that scrolls the widget to its end and back to its beginning, then back to its end, etc. The speed is null at the ends and maximal in the middle. At both ends the widget stands still for a moment. 

  * elapsed
  * size
  * visible_size
  * speed


## Object properties

**widget**
     The widget to be scrolled. 

### Type:

  * widget [widget](<../classes/wibox.widget.html>) The widget 


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

[widget::redraw_needed](<../classes/wibox.container.scroll.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.container.scroll.html#widget::layout_changed>) 

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


## Tables

**wibox.container.scroll.step_functions**
     A selection of step functions 

### See also:

[set_step_function](<../classes/wibox.container.scroll.html#wibox.container.scroll:set_step_function>) 


## Methods

**wibox.container.scroll:pause ()**
     Pause the scrolling animation. 

### See also:

[continue](<../classes/wibox.container.scroll.html#wibox.container.scroll:continue>) 

**wibox.container.scroll:continue ()**
     Continue the scrolling animation. 

### See also:

[pause](<../classes/wibox.container.scroll.html#wibox.container.scroll:pause>) 

**wibox.container.scroll:reset_scrolling ()**
     Reset the scrolling state to its initial condition. For must scroll step functions, the effect of this function should be to display the widget without any scrolling applied. This function does not undo the effect of [pause](<../classes/wibox.container.scroll.html#wibox.container.scroll:pause>). 
**wibox.container.scroll:set_direction (dir)**
     Set the direction in which this widget scroll. 

  * dir Either “h” for horizontal scrolling or “v” for vertical scrolling 


**wibox.container.scroll:get_children ()**
     Get the number of children element 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.scroll:set_children (children)**
     Replace the layout children This layout only accept one children, all others will be ignored 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets 


**wibox.container.scroll:set_expand (expand)**
     Specify the expand mode that is used for extra space. 

  * expand boolean If true, the widget is expanded to include the extra space. If false, the extra space is simply left empty. 


### See also:

[set_extra_space](<../classes/wibox.container.scroll.html#wibox.container.scroll:set_extra_space>) 

**wibox.container.scroll:set_fps (fps)**
     Set the number of frames per second that this widget should draw. 

  * fps number The number of frames per second 


**wibox.container.scroll:set_extra_space (extra_space)**
     Set the amount of extra space that should be included in the scrolling. This extra space will likely be left empty between repetitions of the widgets. 

  * extra_space number The amount of extra space 


### See also:

[set_expand](<../classes/wibox.container.scroll.html#wibox.container.scroll:set_expand>) 

**wibox.container.scroll:set_speed (speed)**
     Set the speed of the scrolling animation. The exact meaning depends on the step function that is used, but for the simplest step functions, this will be in pixels per second. 

  * speed number The speed for the animation 


**wibox.container.scroll:set_max_size (max_size)**
     Set the maximum size of this widget in the direction set by [set_direction](<../classes/wibox.container.scroll.html#wibox.container.scroll:set_direction>). If the child widget is smaller than this size, no scrolling is done. If the child widget is larger, then only this size will be visible and the rest is made visible via scrolling. 

  * max_size number The maximum size of this widget or nil for unlimited. 


**wibox.container.scroll:set_step_function (step_function)**
     Set the step function that determines the exact behaviour of the scrolling animation. The step function is called with five arguments:

  * The time in seconds since the state of the animation
  * The size of the child widget
  * The size of the visible part of the widget
  * The speed of the animation. This should have a linear effect on this function’s behaviour.
  * The extra space configured by [set_extra_space](<../classes/wibox.container.scroll.html#wibox.container.scroll:set_extra_space>). This was not yet added to the size of the child widget, but should likely be added to it in most cases.


The step function should return a single number. This number is the offset at which the widget is drawn and should be between 0 and `size+extra_space`. 

  * step_function function A step function. 


### See also:

[step_functions](<../classes/wibox.container.scroll.html#wibox.container.scroll.step_functions>) 

**wibox.container.scroll:set_space_for_scrolling (space_for_scrolling)**
     Set an upper limit for the space for scrolling. This restricts the child widget’s maximal size. 

  * space_for_scrolling number The space for scrolling 


**wibox.container.scroll:horizontal ([widget[, fps=20[, speed=10[, extra_space=0[, expand=false[, max_size[, step_function=step_functions.linear_increase[, space_for_scrolling=2^1024]]]]]]]])**
     Get a new horizontal scrolling container. 

  * widget The widget that should be scrolled (_optional_) 
  * fps The number of frames per second (_default_ 20) 
  * speed The speed of the animation (_default_ 10) 
  * extra_space The amount of extra space to include (_default_ 0) 
  * expand boolean Should the widget be expanded to include the extra space? (_default_ false) 
  * max_size The maximum size of the child widget (_optional_) 
  * step_function The step function to be used (_default_ step_functions.linear_increase) 
  * space_for_scrolling The space for scrolling (_default_ 2^1024) 


**wibox.container.scroll:vertical ([widget[, fps=20[, speed=10[, extra_space=0[, expand=false[, max_size[, step_function=step_functions.linear_increase[, space_for_scrolling=2^1024]]]]]]]])**
     Get a new vertical scrolling container. 

  * widget The widget that should be scrolled (_optional_) 
  * fps The number of frames per second (_default_ 20) 
  * speed The speed of the animation (_default_ 10) 
  * extra_space The amount of extra space to include (_default_ 0) 
  * expand boolean Should the widget be expanded to include the extra space? (_default_ false) 
  * max_size The maximum size of the child widget (_optional_) 
  * step_function The step function to be used (_default_ step_functions.linear_increase) 
  * space_for_scrolling The space for scrolling (_default_ 2^1024) 


**wibox.container.scroll:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.container.scroll:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.container.scroll:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.container.scroll:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.container.scroll:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.container.scroll:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.container.scroll:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.