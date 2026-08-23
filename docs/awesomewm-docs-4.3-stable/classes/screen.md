# Class screen - awesome API documentation

**Module:** `classes.screen`  

> Source: [classes/screen.html](https://awesomewm.org/doc/api/classes/screen.html)

---

# Class `screen`

awesome screen API

Screen objects can be added and removed over time.

To get a callback for all current and future screens, use [awful.screen.connect_for_each_screen](<../classes/screen.html#awful.screen.connect_for_each_screen>):
    
    
    awful.screen.connect_for_each_screen(function(s)
        -- do something
    end)
    

It is also possible loop over all current screens using:
    
    
    for s in screen do
        -- do something
    end
    

Most basic Awesome objects also have a screen property, see [mouse.screen](<../libraries/mouse.html#screen>) [client.screen](<../classes/client.html#client.screen>), [wibox.screen](<../classes/wibox.html#wibox.screen>) and [tag.screen](<../classes/tag.html#request::screen>).

Furthermore to the classes described here, one can also use signals as described in [signals](<../classes/signals.html#>).

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.screen.getbycoord (x, y)](<#awful.screen.getbycoord>) | Return the screen index corresponding to the given (pixel) coordinates.  
---|---  
[awful.screen.focus (_screen)](<#awful.screen.focus>) | Move the focus to a screen.  
[awful.screen.focus_bydirection (dir, _screen)](<#awful.screen.focus_bydirection>) | Move the focus to a screen in a specific direction.  
[awful.screen.focus_relative (offset)](<#awful.screen.focus_relative>) | Move the focus to a screen relative to the current one,  
[awful.screen.focused ([args])](<#awful.screen.focused>) | Get the focused screen.  
[awful.screen.connect_for_each_screen (func)](<#awful.screen.connect_for_each_screen>) | Call a function for each existing and created-in-the-future screen.  
[awful.screen.disconnect_for_each_screen (func)](<#awful.screen.disconnect_for_each_screen>) | Undo the effect of connect_for_each_screen.  
  
## [Object properties](<#Object_properties>)

[geometry](<#screen.geometry>) | The screen coordinates.  
---|---  
[index](<#screen.index>) | The internal screen number.  
[outputs](<#screen.outputs>) | If RANDR information is available, a list of outputs for this screen and their size in mm.  
[workarea](<#screen.workarea>) | The screen workarea.  
[padding](<#screen.padding>) | The screen padding.  
[clients](<#screen.clients>) | The list of visible clients for the screen.  
[hidden_clients](<#screen.hidden_clients>) | Get the list of clients assigned to the screen but not currently visible.  
[all_clients](<#screen.all_clients>) | All clients assigned to the screen.  
[tiled_clients](<#screen.tiled_clients>) | Tiled clients for the screen.  
[tags](<#screen.tags>) | A list of all tags on the screen.  
[selected_tags](<#screen.selected_tags>) | A list of all selected tags on the screen.  
[selected_tag](<#screen.selected_tag>) | The first selected tag.  
[dpi](<#screen.dpi>) | The number of pixels per inch of the screen.  
  
## [Signals](<#Signals>)

[primary_changed](<#screen.primary_changed>) |   
---|---  
[added](<#screen.added>) | This signal is emitted when a new screen is added to the current setup.  
[removed](<#screen.removed>) | This signal is emitted when a screen is removed from the setup.  
[list](<#screen.list>) | This signal is emitted when the list of available screens changes.  
[swapped](<#screen.swapped>) | When 2 screens are swapped  
[tag::history::update](<#tag::history::update>) | When the tag history changed.  
  
## [Deprecated functions](<#Deprecated_functions>)

[awful.screen.getdistance_sq](<#awful.screen.getdistance_sq>) _[deprecated]_ | Get the square distance between a [screen](<../classes/screen.html#>) and a point.  
---|---  
[awful.screen.padding](<#awful.screen.padding>) _[deprecated]_ | Get or set the screen padding.  
  
## [Fields](<#Fields>)

[screen.primary](<#screen.primary>) | The primary screen.  
---|---  
[awful.screen.default_focused_args](<#awful.screen.default_focused_args>) | The defaults arguments for [awful.screen.focused](<../classes/screen.html#awful.screen.focused>).  
  
## [Methods](<#Methods>)

[screen:instances ()](<#screen:instances>) | Get the number of instances.  
---|---  
[screen:screen ()](<#screen:screen>) | Iterate over screens.  
[screen:count ()](<#screen:count>) | Get the number of screens.  
[screen:fake_add (x, y, width, height)](<#screen:fake_add>) | Add a fake screen.  
[screen:fake_remove ()](<#screen:fake_remove>) | Remove a screen.  
[screen:fake_resize (x, y, width, height)](<#screen:fake_resize>) | Fake-resize a screen  
[screen:swap (s)](<#screen:swap>) | Swap a screen with another one in global screen list.  
[screen:disconnect_signal (name, func)](<#screen:disconnect_signal>) | Disconnect from a signal.  
[screen:emit_signal (name, ...)](<#screen:emit_signal>) | Emit a signal.  
[screen:connect_signal (name, func)](<#screen:connect_signal>) | Connect to a signal.  
[screen:get_square_distance (x, y)](<#screen:get_square_distance>) | Get the square distance between a [screen](<../classes/screen.html#>) and a point.  
[screen:get_next_in_direction (self, dir)](<#screen:get_next_in_direction>) | Get the next screen in a specific direction.  
[screen:preferred (c)](<#screen:preferred>) | Get the preferred screen in the context of a client.  
[screen:get_bounding_geometry ([args={}])](<#screen:get_bounding_geometry>) | Get a placement bounding geometry.  
[screen:get_clients ([stacked=true])](<#screen:get_clients>) | Get the list of visible clients for the screen.  
[screen:get_all_clients ([stacked=true])](<#screen:get_all_clients>) | Get all clients assigned to the screen.  
[screen:get_tiled_clients ([stacked=true])](<#screen:get_tiled_clients>) | Get tiled clients for the screen.  
[screen:set_auto_dpi_enabled (enabled)](<#screen:set_auto_dpi_enabled>) | Enable the automatic calculation of the screen DPI (experimental).  
  
  


## Functions

Methods 

**awful.screen.getbycoord (x, y)**
     Return the screen index corresponding to the given (pixel) coordinates.

The number returned can be used as an index into the global [screen](<../classes/screen.html#>) table/object. 

  * x number The x coordinate 
  * y number The y coordinate 


### Returns:

optional number The screen index 

**awful.screen.focus (_screen)**
     Move the focus to a screen.

This moves the mouse pointer to the last known position on the new screen, or keeps its position relative to the current focused screen. 

  * _screen [screen](<../classes/screen.html#>) Screen number (defaults / falls back to mouse.screen). 


**awful.screen.focus_bydirection (dir, _screen)**
     Move the focus to a screen in a specific direction.

This moves the mouse pointer to the last known position on the new screen, or keeps its position relative to the current focused screen. 

  * dir The direction, can be either “up”, “down”, “left” or “right”. 
  * _screen Screen. 


**awful.screen.focus_relative (offset)**
     Move the focus to a screen relative to the current one, This moves the mouse pointer to the last known position on the new screen, or keeps its position relative to the current focused screen. 

  * offset int Value to add to the current focused screen index. 1 to focus the next one, -1 to focus the previous one. 


**awful.screen.focused ([args])**
     Get the focused screen.

It is possible to set [awful.screen.default_focused_args](<../classes/screen.html#awful.screen.default_focused_args>) to override the default settings. 

  * args
    * client boolean Use the client screen instead of the mouse screen. (_default_ false) 
    * mouse boolean Use the mouse screen (_default_ true) 


### Returns:

optional [screen](<../classes/screen.html#>) The focused screen object, or `nil` in case no screen is present currently. 

**awful.screen.connect_for_each_screen (func)**
     Call a function for each existing and created-in-the-future screen. 

  * func The function to call. 
    * screen [screen](<../classes/screen.html#>) The screen. 


**awful.screen.disconnect_for_each_screen (func)**
     Undo the effect of connect_for_each_screen. 

  * func function The function that should no longer be called. 


## Object properties

**geometry**
     The screen coordinates.

**Signal:**

  * _property::geometry_


**Immutable:** true 

### Type:

  * table
    * x integer The horizontal position 
    * y integer The vertical position 
    * width integer The width 
    * height integer The height 


**index**
     The internal screen number.

  * The indeces are a continuous sequence from 1 to `screen.count()`.
  * It is **NOT** related to the actual screen position relative to each other.
  * 1 is **NOT** necessarily the primary screen.
  * When screens are added and removed indices **CAN** change.


If you really want to keep an array of screens you should use something along:
    
    
     local myscreens = setmetatable({}. {__mode="k"})
     myscreens[ screen[1] ] = "mydata"
    

But it might be a better option to simply store the data directly in the screen object as:
    
    
     screen[1].mydata = "mydata"
    

Remember that screens are also objects, so if you only want to store a simple property, you can do it directly:
    
    
     screen[1].answer = 42
    

**Immutable:** true 

### Type:

  * integer


### See also:

[screen](<../classes/screen.html#>) 

**outputs**
     If RANDR information is available, a list of outputs for this screen and their size in mm.

Please note that the table content may vary.

**Signal:**

  * _property::outputs_


**Immutable:** true 

### Type:

  * table
    * name [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with the screen name as key (like `eDP1` on a laptop) 
    * name.mm_width integer The screen physical width 
    * name.mm_height integer The screen physical height 


**workarea**
    

The screen workarea.

The workarea is a subsection of the screen where clients can be placed. It usually excludes the toolbars (see [awful.wibar](<../classes/awful.wibar.html#>)) and dockable clients (see [client.dockable](<../classes/client.html#client.dockable>)) like WindowMaker DockAPP.

It can be modified be altering the [wibox](<../classes/wibox.html#>) or [client](<../classes/client.html#>) struts.

**Signal:**

  * _property::workarea_


### Type:

  * table
    * x integer The horizontal position 
    * y integer The vertical position 
    * width integer The width 
    * height integer The height 


### See also:

[client.struts](<../classes/client.html#client:struts>) 

**padding**
    

The screen padding.

This adds a “buffer” section on each side of the screen.

**Signal:**

  * _property::padding_


### Type:

  * table
    * left integer The padding on the left. 
    * right integer The padding on the right. 
    * top integer The padding on the top. 
    * bottom integer The padding on the bottom. 


**clients**
     The list of visible clients for the screen.

Minimized and unmanaged clients are not included in this list as they are technically not on the screen.

The clients on tags that are currently not visible are not part of this list.

Clients are returned using the stacking order (from top to bottom). See [get_clients](<../classes/screen.html#screen:get_clients>) if you want them in the order used in the tasklist by default. 

### Type:

  * table The clients list, ordered from top to bottom. 


### See also:

  * [all_clients](<../classes/screen.html#screen.all_clients>)
  * [hidden_clients](<../classes/screen.html#screen.hidden_clients>)
  * [client.get](<../classes/client.html#awful.client.dockable.get>)


**hidden_clients**
     Get the list of clients assigned to the screen but not currently visible.

This includes minimized clients and clients on hidden tags. 

### Type:

  * table The clients list, ordered from top to bottom. 


### See also:

  * [clients](<../classes/screen.html#screen.clients>)
  * [all_clients](<../classes/screen.html#screen.all_clients>)
  * [client.get](<../classes/client.html#awful.client.dockable.get>)


**all_clients**
     All clients assigned to the screen. 

### Type:

  * table The clients list, ordered from top to bottom. 


### See also:

  * [clients](<../classes/screen.html#screen.clients>)
  * [hidden_clients](<../classes/screen.html#screen.hidden_clients>)
  * [client.get](<../classes/client.html#awful.client.dockable.get>)


**tiled_clients**
    

Tiled clients for the screen.

Same as [clients](<../classes/screen.html#screen.clients>), but excluding:

  * fullscreen clients
  * maximized clients
  * floating clients


### Type:

  * table The clients list, ordered from top to bottom. 


**tags**
     A list of all tags on the screen.

This property is read only, use [tag.screen](<../classes/tag.html#request::screen>), `awful.tag.add`, `awful.tag.new` or `t:delete()` to alter this list. 

### Type:

  * table


**selected_tags**
     A list of all selected tags on the screen. 

### Type:

  * table


### See also:

  * [tag.selected](<../classes/tag.html#tag.selected>)
  * [client.to_selected_tags](<../classes/client.html#client:to_selected_tags>)


**selected_tag**
     The first selected tag. 

### Type:

  * tag


### See also:

  * [tag.selected](<../classes/tag.html#tag.selected>)
  * [selected_tags](<../classes/screen.html#screen.selected_tags>)


**dpi**
     The number of pixels per inch of the screen. 

## Signals

**primary_changed**
    
**added**
     This signal is emitted when a new screen is added to the current setup. 
**removed**
     This signal is emitted when a screen is removed from the setup. 
**list**
     This signal is emitted when the list of available screens changes. 
**swapped**
     When 2 screens are swapped 

### Arguments:

  * screen [screen](<../classes/screen.html#>) The other screen 
  * is_source boolean If self is the source or the destination of the swap 


**tag::history::update**
     When the tag history changed. 

## Deprecated functions

**awful.screen.getdistance_sq _[deprecated]_**
     Get the square distance between a [screen](<../classes/screen.html#>) and a point. param:

  * s Screen 
  * x X coordinate of point 
  * y Y coordinate of point 

See also:

[screen.get_square_distance](<../classes/screen.html#screen:get_square_distance>) 

**awful.screen.padding _[deprecated]_**
     Get or set the screen padding. param:

  * _screen The screen object to change the padding on 
  * padding The padding, a table with ‘top’, ‘left’, ‘right’ and/or ‘bottom’ or a number value to apply set the same padding on all sides. Can be nil if you only want to retrieve padding (_default_ nil) 

See also:

[padding](<../classes/screen.html#screen.padding>) 

Fields

**screen.primary**
     The primary screen. 

  * primary [screen](<../classes/screen.html#>)


**awful.screen.default_focused_args**
     The defaults arguments for [awful.screen.focused](<../classes/screen.html#awful.screen.focused>). 
Methods

**screen:instances ()**
     Get the number of instances. Returns:

The number of screen objects alive. 

**screen:screen ()**
     Iterate over screens. Usage:
    
    for s in screen do
        print("Oh, wow, we have screen " .. tostring(s))
    end


**screen:count ()**
     Get the number of screens. Returns:

The screen count, at least 1. 

**screen:fake_add (x, y, width, height)**
     Add a fake screen. To vertically split the first screen in 2 equal parts, use:
    
    
    local geo = screen[1].geometry
    local new_width = math.ceil(geo.width/2)
    local new_width2 = geo.width - new_width
    screen[1]:fake_resize(geo.x, geo.y, new_width, geo.height)
    screen.fake_add(geo.x + new_width, geo.y, new_width2, geo.height)
    

Both virtual screens will have their own taglist and wibars. 

  * x integer X-coordinate for screen. 
  * y integer Y-coordinate for screen. 
  * width integer width for screen. 
  * height integer height for screen. 

Returns:

The new screen. 

**screen:fake_remove ()**
     Remove a screen. 
**screen:fake_resize (x, y, width, height)**
     Fake-resize a screen 

  * x integer The new X-coordinate for screen. 
  * y integer The new Y-coordinate for screen. 
  * width integer The new width for screen. 
  * height integer The new height for screen. 


**screen:swap (s)**
     Swap a screen with another one in global screen list. 

  * s [client.object](<../classes/client.html#awful.object>) A screen to swap with. 


**screen:disconnect_signal (name, func)**
     Disconnect from a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback that should be disconnected. 


**screen:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**screen:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**screen:get_square_distance (x, y)**
     Get the square distance between a [screen](<../classes/screen.html#>) and a point. 

  * x number X coordinate of point 
  * y number Y coordinate of point 

Returns:

number The squared distance of the screen to the provided point. 

**screen:get_next_in_direction (self, dir)**
     Get the next screen in a specific direction. This gets the next screen relative to this one in the specified direction. 

  * self Screen. 
  * dir The direction, can be either “up”, “down”, “left” or “right”. 


**screen:preferred (c)**
     Get the preferred screen in the context of a client. This is exactly the same as [awful.screen.focused](<../classes/screen.html#awful.screen.focused>) except that it avoids clients being moved when Awesome is restarted. This is used in the default [rc.lua](<../sample files/rc.lua.html#>) to ensure clients get assigned to the focused screen by default. 

  * c [client](<../classes/client.html#>) A client. 

Returns:

[screen](<../classes/screen.html#>) The preferred screen. 

**screen:get_bounding_geometry ([args={}])**
     Get a placement bounding geometry. This method computes the different variants of the “usable” screen geometry. 

  * args The arguments 
    * honor_padding boolean Whether to honor the screen’s padding. (_default_ false) 
    * honor_workarea boolean Whether to honor the screen’s workarea. (_default_ false) 
    * margins int or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Apply some margins on the output. This can either be a number or a table with _left_ , _right_ , _top_ and _bottom_ keys. (_optional_) 
    * tag [tag](<../classes/tag.html#>) Use this tag’s screen. (_optional_) 
    * parent [drawable](<../classes/drawable.html#>) A parent drawable to use as base geometry. (_optional_) 
    * bounding_rect [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A bounding rectangle. This parameter is incompatible with `honor_workarea`. (_optional_) 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with _x_ , _y_ , _width_ and _height_. 
Usage:
    
    local geo = screen:get_bounding_geometry {
        honor_padding  = true,
        honor_workarea = true,
        margins        = {
             left = 20,
        },
    }


**screen:get_clients ([stacked=true])**
     Get the list of visible clients for the screen. This is used by [screen.clients](<../classes/screen.html#screen.clients>) internally (with `stacked=true`). 

  * stacked boolean Use stacking order? (top to bottom) (_default_ true) 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The clients list. 

**screen:get_all_clients ([stacked=true])**
     Get all clients assigned to the screen. This is used by [all_clients](<../classes/screen.html#screen.all_clients>) internally (with `stacked=true`). 

  * stacked boolean Use stacking order? (top to bottom) (_default_ true) 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The clients list. 

**screen:get_tiled_clients ([stacked=true])**
     Get tiled clients for the screen. This is used by `tiles_clients` internally (with `stacked=true`). 

  * stacked boolean Use stacking order? (top to bottom) (_default_ true) 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The clients list. 

**screen:set_auto_dpi_enabled (enabled)**
     Enable the automatic calculation of the screen DPI (experimental). This will cause many elements such as the font and some widgets to be scaled so they look the same (physical) size on different devices with different pixel density. It is calculated using the information provided from `xrandr`. When enabled, the theme and configuration must avoid using pixel sizes for different elements as this will cause misalignment or hidden content on some devices. Note that it has to be called early in [rc.lua](<../sample files/rc.lua.html#>) and requires restarting awesome to take effect. It is disabled by default and changes introduced in minor releases of Awesome may slightly break the behavior as more components gain support for HiDPI. When disabled the DPI is acquired from the `Xft.dpi` X resource (xrdb), defaulting to 96. 

  * enabled boolean Enable or disable automatic DPI support.