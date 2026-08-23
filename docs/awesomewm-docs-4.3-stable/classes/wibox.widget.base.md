# Class wibox.widget.base - awesome API documentation

**Module:** `classes.wibox.widget.base`  

> Source: [classes/wibox.widget.base.html](https://awesomewm.org/doc/api/classes/wibox.widget.base.html)

---

# Class `wibox.widget.base`

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[wibox.widget.base.rect_to_device_geometry ()](<#wibox.widget.base.rect_to_device_geometry>) | Figure out the geometry in the device coordinate space.  
---|---  
[wibox.widget.base.fit_widget (parent, context, widget, width, height)](<#wibox.widget.base.fit_widget>) | Fit a widget for the given available width and height.  
[wibox.widget.base.layout_widget (parent, context, widget, width, height)](<#wibox.widget.base.layout_widget>) | Lay out a widget for the given available width and height.  
[wibox.widget.base.handle_button ()](<#wibox.widget.base.handle_button>) | Handle a button event on a widget.  
[wibox.widget.base.place_widget_via_matrix (widget, mat, width, height)](<#wibox.widget.base.place_widget_via_matrix>) | Create widget placement information.  
[wibox.widget.base.place_widget_at (widget, x, y, width, height)](<#wibox.widget.base.place_widget_at>) | Create widget placement information.  
[wibox.widget.base.make_widget_declarative (args)](<#wibox.widget.base.make_widget_declarative>) | Create a widget from a declarative description.  
[wibox.widget.base.make_widget ([proxy[, widget_name[, args={}]]])](<#wibox.widget.base.make_widget>) | Create an empty widget skeleton.  
[wibox.widget.base.empty_widget ()](<#wibox.widget.base.empty_widget>) | Generate an empty widget which takes no space and displays nothing.  
[wibox.widget.base.check_widget ()](<#wibox.widget.base.check_widget>) | Do some sanity checking on a widget.  
  
## [Tables](<#Tables>)

[wibox.widget.base.widget](<#wibox.widget.base.widget>) | Functions available on all widgets.  
---|---  
  
## [Methods](<#Methods>)

[wibox.widget.base:buttons (_buttons)](<#wibox.widget.base:buttons>) | Set/get a widget’s buttons.  
---|---  
[wibox.widget.base:set_visible (b)](<#wibox.widget.base:set_visible>) | Set a widget’s visibility.  
[wibox.widget.base:get_visible ()](<#wibox.widget.base:get_visible>) | Is the widget visible?  
[wibox.widget.base:set_opacity (o)](<#wibox.widget.base:set_opacity>) | Set a widget’s opacity.  
[wibox.widget.base:get_opacity ()](<#wibox.widget.base:get_opacity>) | Get the widget’s opacity.  
[wibox.widget.base:set_forced_width ([width])](<#wibox.widget.base:set_forced_width>) | Set the widget’s forced width.  
[wibox.widget.base:get_forced_width ()](<#wibox.widget.base:get_forced_width>) | Get the widget’s forced width.  
[wibox.widget.base:set_height ([height])](<#wibox.widget.base:set_height>) | Set the widget’s forced height.  
[wibox.widget.base:get_forced_height ()](<#wibox.widget.base:get_forced_height>) | Get the widget’s forced height.  
[wibox.widget.base:get_children ()](<#wibox.widget.base:get_children>) | Get the widget’s direct children widgets.  
[wibox.widget.base:set_children (children)](<#wibox.widget.base:set_children>) | Replace the layout children.  
[wibox.widget.base:get_all_children ()](<#wibox.widget.base:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.widget.base:emit_signal_recursive (signal_name, ...)](<#wibox.widget.base:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.base:index (widget[, recursive[, ...]])](<#wibox.widget.base:index>) | Get the index of a widget.  
[wibox.widget.base:setup (args)](<#wibox.widget.base:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.base:make_widget_from_value (wdg[, ...=nil])](<#wibox.widget.base:make_widget_from_value>) | Create a widget from an undetermined value.  
  
  


## Functions

Methods 

**wibox.widget.base.rect_to_device_geometry ()**
     Figure out the geometry in the device coordinate space.

This gives only tight bounds if no rotations by non-multiples of 90° are used. 
**wibox.widget.base.fit_widget (parent, context, widget, width, height)**
     Fit a widget for the given available width and height.

This calls the widget’s `:fit` callback and caches the result for later use. Never call `:fit` directly, but always through this function! 

  * parent [widget](<../classes/wibox.widget.html>) The parent widget which requests this information. 
  * context [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The context in which we are fit. 
  * widget [widget](<../classes/wibox.widget.html>) The widget to fit (this uses `widget:fit(context, width, height)`). 
  * width number The available width for the widget. 
  * height number The available height for the widget. 


### Returns:

  1. number The width that the widget wants to use.
  2. number The height that the widget wants to use.


**wibox.widget.base.layout_widget (parent, context, widget, width, height)**
     Lay out a widget for the given available width and height.

This calls the widget’s `:layout` callback and caches the result for later use. Never call `:layout` directly, but always through this function! However, normally there shouldn’t be any reason why you need to use this function. 

  * parent [widget](<../classes/wibox.widget.html>) The parent widget which requests this information. 
  * context [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The context in which we are laid out. 
  * widget [widget](<../classes/wibox.widget.html>) The widget to layout (this uses `widget:layout(context, width, height)`). 
  * width number The available width for the widget. 
  * height number The available height for the widget. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The result from the widget’s `:layout` callback. 

**wibox.widget.base.handle_button ()**
     Handle a button event on a widget.

This is used internally and should not be called directly. 
**wibox.widget.base.place_widget_via_matrix (widget, mat, width, height)**
     Create widget placement information. This should be used in a widget’s `:layout()` callback. 

  * widget [widget](<../classes/wibox.widget.html>) The widget that should be placed. 
  * mat A matrix transforming from the parent widget’s coordinate system. For example, use matrix.create_translate(1, 2) to draw a widget at position (1, 2) relative to the parent widget. 
  * width number The width of the widget in its own coordinate system. That is, after applying the transformation matrix. 
  * height number The height of the widget in its own coordinate system. That is, after applying the transformation matrix. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) An opaque object that can be returned from `:layout()`. 

**wibox.widget.base.place_widget_at (widget, x, y, width, height)**
     Create widget placement information. This should be used for a widget’s `:layout()` callback. 

  * widget [widget](<../classes/wibox.widget.html>) The widget that should be placed. 
  * x number The x coordinate for the widget. 
  * y number The y coordinate for the widget. 
  * width number The width of the widget in its own coordinate system. That is, after applying the transformation matrix. 
  * height number The height of the widget in its own coordinate system. That is, after applying the transformation matrix. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) An opaque object that can be returned from `:layout()`. 

**wibox.widget.base.make_widget_declarative (args)**
     Create a widget from a declarative description.

See [The declarative layout system](<../documentation/03-declarative-layout.md.html>). 

  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table containing the widgets disposition. 


**wibox.widget.base.make_widget ([proxy[, widget_name[, args={}]]])**
     Create an empty widget skeleton.

See [Creating new widgets](<../documentation/04-new-widgets.md.html>). 

  * proxy [widget](<../classes/wibox.widget.html>) If this is set, the returned widget will be a proxy for this widget. It will be equivalent to this widget. This means it looks the same on the screen. (_optional_) 
  * widget_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Name of the widget. If not set, it will be set automatically via [gears.object.modulename](<../classes/gears.object.html#gears.object:modulename>). (_optional_) 
  * args Widget settings 
    * enable_properties boolean Enable automatic getter and setter methods. (_default_ false) 
    * class [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The widget class (_default_ nil) 


### See also:

[fit_widget](<../classes/wibox.widget.base.html#wibox.widget.base.fit_widget>) 

**wibox.widget.base.empty_widget ()**
     Generate an empty widget which takes no space and displays nothing. 
**wibox.widget.base.check_widget ()**
     Do some sanity checking on a widget.

This function raises an error if the widget is not valid. 

## Tables

**wibox.widget.base.widget**
     Functions available on all widgets. 

## Methods

**wibox.widget.base:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table of buttons that is bound to the widget. 


**wibox.widget.base:set_visible (b)**
     Set a widget’s visibility. 

  * b boolean Whether the widget is visible. 


**wibox.widget.base:get_visible ()**
     Is the widget visible? 

### Returns:

boolean 

**wibox.widget.base:set_opacity (o)**
     Set a widget’s opacity. 

  * o number The opacity to use (a number from 0 (transparent) to 1 (opaque)). 


**wibox.widget.base:get_opacity ()**
     Get the widget’s opacity. 

### Returns:

number The opacity (between 0 (transparent) and 1 (opaque)). 

**wibox.widget.base:set_forced_width ([width])**
     Set the widget’s forced width. 

  * width number With `nil` the default mechanism of calling the `:fit` method is used. (_optional_) 


### See also:

[fit_widget](<../classes/wibox.widget.base.html#wibox.widget.base.fit_widget>) 

**wibox.widget.base:get_forced_width ()**
     Get the widget’s forced width.

Note that widget instances can be used in different places simultaneously, and therefore can have multiple dimensions. If there is no forced width/height, then the only way to get the widget’s actual size is during a `mouse::enter`, `mouse::leave` or button event. 

### Returns:

number The forced width (nil if automatic). 


### See also:

[fit_widget](<../classes/wibox.widget.base.html#wibox.widget.base.fit_widget>) 

**wibox.widget.base:set_height ([height])**
     Set the widget’s forced height. 

  * height number With `nil` the default mechanism of calling the `:fit` method is used. (_optional_) 


### See also:

[fit_widget](<../classes/wibox.widget.base.html#wibox.widget.base.fit_widget>) 

**wibox.widget.base:get_forced_height ()**
     Get the widget’s forced height.

Note that widget instances can be used in different places simultaneously, and therefore can have multiple dimensions. If there is no forced width/height, then the only way to get the widget’s actual size is during a `mouse::enter`, `mouse::leave` or button event. 

### Returns:

number The forced height (nil if automatic). 

**wibox.widget.base:get_children ()**
     Get the widget’s direct children widgets.

This method should be re-implemented by the relevant widgets. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.base:set_children (children)**
     Replace the layout children.

The default implementation does nothing, this must be re-implemented by all layout and container widgets. 

  * children [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table composed of valid widgets. 


**wibox.widget.base:get_all_children ()**
     Get all direct and indirect children widgets.

This will scan all containers recursively to find widgets.

_Warning_ : This method it prone to stack overflow if the widget, or any of its children, contains (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.base:emit_signal_recursive (signal_name, ...)**
    

Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget.

Note that this function has some flaws:

  1. The signal is only forwarded once the widget tree has been built. This happens after all currently scheduled functions have been executed. Therefore, it will not start to work right away.
  2. In case the widget is present multiple times in a single widget tree, this function will also forward the signal multiple times (once per upward tree path).
  3. If the widget is removed from the widget tree, the signal is still forwarded for some time, similar to the first case.


  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.base:index (widget[, recursive[, ...]])**
     Get the index of a widget. 

  * widget [widget](<../classes/wibox.widget.html>) The widget to look for. 
  * recursive boolean Also check sub-widgets? (_optional_) 
  * ... [widget](<../classes/wibox.widget.html>) Additional widgets to add at the end of the “path” (_optional_) 


### Returns:

  1. number The index.
  2. [widget](<../classes/wibox.widget.html>) The parent widget.
  3. [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The path between “self” and “widget”.


**wibox.widget.base:setup (args)**
     Set a declarative widget hierarchy description.

See [The declarative layout system](<../documentation/03-declarative-layout.md.html>). 

  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table containing the widget’s disposition. 


**wibox.widget.base:make_widget_from_value (wdg[, ...=nil])**
    

Create a widget from an undetermined value.

The value can be:

  * A widget (in which case nothing new is created)
  * A declarative construct
  * A constructor function
  * A metaobject


  * wdg The value. 
  * ... Arguments passed to the contructor (if any). (_default_ nil) 


### Returns:

The new widget.