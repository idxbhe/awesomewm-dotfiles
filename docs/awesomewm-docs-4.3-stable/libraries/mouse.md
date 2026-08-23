# Module mouse - awesome API documentation

**Module:** `libraries.mouse`  

> Source: [libraries/mouse.html](https://awesomewm.org/doc/api/libraries/mouse.html)

---

# Module `mouse`

awesome mouse API.

The mouse buttons are represented as index. The common ones are:

![Client geometry](../images/mouse.svg)

It is possible to be notified of mouse events by connecting to various [client](<../classes/client.html#>), `widget`s and [wibox](<../classes/wibox.html#>) signals:

  * `mouse::enter`
  * `mouse::leave`
  * `mouse::press`
  * `mouse::release`
  * `mouse::move`


It is also possible to add generic mouse button callbacks for [client](<../classes/client.html#>)s, `wiboxe`s and the [root](<../libraries/root.html#>) window. Those are set in the default [rc.lua](<../sample files/rc.lua.html#>) as such:

**root** :
    
    
    root.buttons(awful.util.table.join(
        awful.button({ }, 3, function () mymainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    ))
    

**client** :
    
    
    clientbuttons = awful.util.table.join(
        awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
        awful.button({ modkey }, 1, awful.mouse.client.move),
        awful.button({ modkey }, 3, awful.mouse.client.resize)
    )
    

See also [mousegrabber](<../libraries/mousegrabber.html#>)

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[object_under_pointer ()](<#object_under_pointer>) | Get the client or any object which is under the pointer.  
---|---  
[awful.mouse.client.move (c, snap, finished_cb)](<#awful.mouse.client.move>) | Move a client.  
[awful.mouse.wibox.move (w)](<#awful.mouse.wibox.move>) | Move the wibox under the cursor.  
[awful.mouse.client.resize (c, corner[, args={}])](<#awful.mouse.client.resize>) | Resize a client.  
[coords ([coords_table=nil[, silent=nil]])](<#coords>) | Get or set the mouse coords.  
  
## [Object properties](<#Object_properties>)

[screen](<#screen>) | The [screen](<../classes/screen.html#>) under the cursor  
---|---  
[current_client](<#current_client>) | Get the client currently under the mouse cursor.  
[current_wibox](<#current_wibox>) | Get the wibox currently under the mouse cursor.  
[current_widgets](<#current_widgets>) | Get the widgets currently under the mouse cursor.  
[current_widget](<#current_widget>) | Get the topmost widget currently under the mouse cursor.  
[current_widget_geometry](<#current_widget_geometry>) | Get the current widget geometry.  
[current_widget_geometries](<#current_widget_geometries>) | Get the current widget geometries.  
[is_left_mouse_button_pressed](<#is_left_mouse_button_pressed>) | True if the left mouse button is pressed.  
[is_right_mouse_button_pressed](<#is_right_mouse_button_pressed>) | True if the right mouse button is pressed.  
[is_middle_mouse_button_pressed](<#is_middle_mouse_button_pressed>) | True if the middle mouse button is pressed.  
  
## [Request handlers](<#Request_handlers>)

[awful.mouse.resize_handler](<#awful.mouse.resize_handler>) | Default handler for `request::geometry` signals with “mouse.resize” context.  
---|---  
  
## [Theme variables](<#Theme_variables>)

[beautiful.snap_bg](<#beautiful.snap_bg>) | The snap outline background color.  
---|---  
[beautiful.snap_border_width](<#beautiful.snap_border_width>) | The snap outline width.  
[beautiful.snap_shape](<#beautiful.snap_shape>) | The snap outline shape.  
[beautiful.snapper_gap](<#beautiful.snapper_gap>) | The gap between snapped contents.  
  
## [Deprecated functions](<#Deprecated_functions>)

[awful.mouse.client_under_pointer](<#awful.mouse.client_under_pointer>) _[deprecated]_ | Get the client object under the pointer.  
---|---  
[awful.mouse.client.dragtotag.border](<#awful.mouse.client.dragtotag.border>) _[deprecated]_ | Move a client to a tag by dragging it onto the left / right side of the screen.  
[awful.mouse.client.corner](<#awful.mouse.client.corner>) _[deprecated]_ | Get a client corner coordinates.  
  
## [Fields](<#Fields>)

[awful.mouse.snap.default_distance](<#awful.mouse.snap.default_distance>) | The default snap distance.  
---|---  
[awful.mouse.snap.edge_enabled](<#awful.mouse.snap.edge_enabled>) | Enable screen edges snapping.  
[awful.mouse.snap.client_enabled](<#awful.mouse.snap.client_enabled>) | Enable client to client snapping.  
[awful.mouse.drag_to_tag.enabled](<#awful.mouse.drag_to_tag.enabled>) | Enable changing tag when a client is dragged to the edge of the screen.  
  
## [lib.awful.mouse.resize Functions](<#lib_awful_mouse_resize_Functions>)

[beautiful.cursor_mouse_resize](<#beautiful.cursor_mouse_resize>) | The resize cursor name.  
---|---  
[beautiful.cursor_mouse_move](<#beautiful.cursor_mouse_move>) | The move cursor name.  
[awful.mouse.resize.set_mode (m)](<#awful.mouse.resize.set_mode>) | Set the resize mode.  
[awful.mouse.resize.add_enter_callback (cb, context)](<#awful.mouse.resize.add_enter_callback>) | Add an initialization callback.  
[awful.mouse.resize.add_move_callback (cb, context)](<#awful.mouse.resize.add_move_callback>) | Add a “move” callback.  
[awful.mouse.resize.add_leave_callback (cb, context)](<#awful.mouse.resize.add_leave_callback>) | Add a “leave” callback This callback is executed just before the [mousegrabber](<../libraries/mousegrabber.html#>) stop  
[awful.mouse.resize (client, context[, args={}])](<#awful.mouse.resize>) | Resize the drawable.  
  
## [lib.awful.mouse.snap Functions](<#lib_awful_mouse_snap_Functions>)

[awful.mouse.snap (c, snap, x, y, fixed_x, fixed_y)](<#awful.mouse.snap>) | Snap a client to the closest client or screen edge.  
---|---  
  
  


## Functions

Methods 

**object_under_pointer ()**
     Get the client or any object which is under the pointer. 

### Returns:

[client.object](<../classes/client.html#awful.object>) or nil A client or nil. 

**awful.mouse.client.move (c, snap, finished_cb)**
     Move a client. 

  * c The client to move, or the focused one if nil. 
  * snap The pixel to snap clients. 
  * finished_cb Deprecated, do not use 


**awful.mouse.wibox.move (w)**
     Move the wibox under the cursor. 

  * w [wibox](<../classes/wibox.html#>) The wibox to move, or none to use that under the pointer 


**awful.mouse.client.resize (c, corner[, args={}])**
     Resize a client. 

  * c The client to resize, or the focused one by default. 
  * corner [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The corner to grab on resize. Auto detected by default. 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A set of [awful.placement](<../libraries/awful.placement.html#>) arguments (_default_ {}) 


### Returns:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The corner (or side) name 

**coords ([coords_table=nil[, silent=nil]])**
    

Get or set the mouse coords.

![Usage example](../images/AUTOGEN_awful_mouse_coords.svg)

**Usage example output** :
    
    
    235
    

  * coords_table None or a table with x and y keys as mouse coordinates. 
    * x integer The mouse horizontal position (_default_ nil) 
    * y integer The mouse vertical position (_default_ nil) 
  * silent boolean Disable mouse::enter or mouse::leave events that could be triggered by the pointer when moving. (_default_ false) 


### Returns:

  1. integer table.x The horizontal position
  2. integer table.y The vertical position
  3. [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) table.buttons Table containing the status of buttons, e.g. field [1] is true when button 1 is pressed.


### Usage:
    
    -- Get the position
    print(mouse.coords().x)
    -- Change the position
    mouse.coords {
        x = 185,
        y = 10
    }


## Object properties

**screen**
     The [screen](<../classes/screen.html#>) under the cursor 

### Type:

  * screen


**current_client**
     Get the client currently under the mouse cursor. 

### Type:

  * The [client](<../classes/client.html#>) or nil client 


**current_wibox**
     Get the wibox currently under the mouse cursor. 

### Type:

  * The [wibox](<../classes/wibox.html#>) or nil wibox 


**current_widgets**
     Get the widgets currently under the mouse cursor. 

### Type:

  * list nil or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The widget list 


**current_widget**
     Get the topmost widget currently under the mouse cursor. 

### Type:

  * widget widget or nil The widget 


### See also:

[current_widget_geometry](<../libraries/mouse.html#current_widget_geometry>) 

**current_widget_geometry**
     Get the current widget geometry. 

### Type:

  * The optional [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) geometry. 


### See also:

[current_widget](<../libraries/mouse.html#current_widget>) 

**current_widget_geometries**
     Get the current widget geometries. 

### Type:

  * A optional [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) list of geometry tables. 


### See also:

[current_widgets](<../libraries/mouse.html#current_widgets>) 

**is_left_mouse_button_pressed**
     True if the left mouse button is pressed. 

### Type:

  * boolean


**is_right_mouse_button_pressed**
     True if the right mouse button is pressed. 

### Type:

  * boolean


**is_middle_mouse_button_pressed**
     True if the middle mouse button is pressed. 

### Type:

  * boolean


## Request handlers

**awful.mouse.resize_handler**
     Default handler for `request::geometry` signals with “mouse.resize” context. 

### Arguments:

  * c [client](<../classes/client.html#>) The client 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context 
  * hints [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The hints to pass to the handler (_default_ {}) 


## Theme variables

**beautiful.snap_bg**
     The snap outline background color. 

### Type:

  * color color, [string](<https://www.lua.org/manual/5.1/manual.html#5.4>), gradient or pattern


**beautiful.snap_border_width**
     The snap outline width. 

### Type:

  * integer


**beautiful.snap_shape**
     The snap outline shape. 

### Type:

  * shape function A [gears.shape](<../libraries/gears.shape.html#>) compatible function 


**beautiful.snapper_gap**
     The gap between snapped contents. 

### Type:

  * default: number 0) 


## Deprecated functions

**awful.mouse.client_under_pointer _[deprecated]_**
     Get the client object under the pointer. See also:

[current_client](<../libraries/mouse.html#current_client>) 

**awful.mouse.client.dragtotag.border _[deprecated]_**
     Move a client to a tag by dragging it onto the left / right side of the screen. param:

  * c The client to move 


**awful.mouse.client.corner _[deprecated]_**
     Get a client corner coordinates. param:

  * c [client](<../classes/client.html#>) The client to get corner from, focused one by default. (_default_ client.focus) 
  * corner [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The corner to use: auto, top_left, top_right, bottom_left, bottom_right, left, right, top bottom. Default is auto, and auto find the nearest corner. 


Fields

**awful.mouse.snap.default_distance**
     The default snap distance. 

  * default_distance integer (_default_ 8) 

See also:

[awful.mouse.snap](<../libraries/mouse.html#awful.mouse.snap>) 

**awful.mouse.snap.edge_enabled**
     Enable screen edges snapping. 
**awful.mouse.snap.client_enabled**
     Enable client to client snapping. 
**awful.mouse.drag_to_tag.enabled**
     Enable changing tag when a client is dragged to the edge of the screen. 
lib.awful.mouse.resize Functions

**beautiful.cursor_mouse_resize**
     The resize cursor name. Type:

  * cursor [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ cross) 


**beautiful.cursor_mouse_move**
     The move cursor name. Type:

  * cursor [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ fleur) 


**awful.mouse.resize.set_mode (m)**
     Set the resize mode. The available modes are:

  * **live** : Resize the layout everytime the mouse moves.
  * **after** : Resize the layout only when the mouse is released.

Some clients, such as XTerm, may lose information if resized too often. 

  * m [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The mode 


**awful.mouse.resize.add_enter_callback (cb, context)**
     Add an initialization callback. This callback will be executed before the mouse grabbing starts. 

  * cb function The callback (or nil) 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The callback context 


**awful.mouse.resize.add_move_callback (cb, context)**
     Add a “move” callback. This callback is executed in “after” mode (see [set_mode](<../libraries/mouse.html#awful.mouse.resize.set_mode>)) instead of applying the operation. 

  * cb function The callback (or nil) 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The callback context 


**awful.mouse.resize.add_leave_callback (cb, context)**
     Add a “leave” callback This callback is executed just before the [mousegrabber](<../libraries/mousegrabber.html#>) stop 

  * cb function The callback (or nil) 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The callback context 


**awful.mouse.resize (client, context[, args={}])**
     Resize the drawable. Valid `args` are:

  * _enter_callback_ : A function called before the [mousegrabber](<../libraries/mousegrabber.html#>) starts.
  * _move_callback_ : A function called when the mouse moves.
  * _leave_callback_ : A function called before the [mousegrabber](<../libraries/mousegrabber.html#>) is released.
  * _mode_ : The resize mode.


  * client [client](<../classes/client.html#>) A client. 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The resizing context. 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A set of [awful.placement](<../libraries/awful.placement.html#>) arguments. (_default_ {}) 


lib.awful.mouse.snap Functions

**awful.mouse.snap (c, snap, x, y, fixed_x, fixed_y)**
     Snap a client to the closest client or screen edge. 

  * c The client to snap. 
  * snap The pixel to snap clients. 
  * x The client x coordinate. 
  * y The client y coordinate. 
  * fixed_x True if the client isn’t allowed to move in the x direction. 
  * fixed_y True if the client isn’t allowed to move in the y direction.