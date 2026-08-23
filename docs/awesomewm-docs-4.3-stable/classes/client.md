# Class client - awesome API documentation

**Module:** `classes.client`  

> Source: [classes/client.html](https://awesomewm.org/doc/api/classes/client.html)

---

# Class `client`

A process window.

Clients are the name used by Awesome (and X11) to refer to a window.

A program can have multiple clients (e.g. for dialogs) or none at all (e.g. command line applications). Clients are usually grouped by classes. A class is the name used by X11 to help the window manager distinguish between windows and write rules for them. A client’s behavior is also defined by its [type](<../classes/client.html#client.type>) and [size_hints](<../classes/client.html#client.size_hints>) properties. See the `xprop` command line application to query properties for a client.

![Client geometry](../images/client_geo.svg)

The client’s `:geometry()` function returns a table with _x_ , _y_ , _width_ and _height_. The area returned **excludes the border width**. All clients also have a [shape_bounding](<../classes/client.html#client.shape_bounding>) and [shape_clip](<../classes/client.html#client.shape_clip>) used to “crop” the client’s content. Finally, each clients can have titlebars (see [awful.titlebar](<../classes/awful.titlebar.html#>)).

Additionally to the classes described here, one can also use signals as described in [signals](<../classes/signals.html#>) and X properties as described in [xproperties](<../classes/xproperties.html#>).

Some signal names are starting with a dot. These dots are artefacts from the documentation generation, you get the real signal name by removing the starting dot.

Accessing client objects can be done in multiple ways depending on the context. To get the currently focused client:
    
    
    local c = client.focus
    if c then
        -- do something
    end
    

To get a list of all clients, use [client:get](<../classes/client.html#client:get>):
    
    
    for _, c in ipairs(client.get()) do
        -- do something
    end
    

To execute a callback when a new client is added, use the [manage](<../classes/client.html#client.manage>) signal:
    
    
    client.connect_signal("manage", function(c)
        -- do something
    end)
    

To be notified when a property of a client changed:
    
    
    client.connect_signal("property::name", function(c)
        -- do something
    end)
    

To be notified when a property of a specific client `c` changed:
    
    
    c:connect_signal("property::name", function()
        -- do something
    end)
    

To get all the clients for a screen use either [screen.clients](<../classes/screen.html#screen.clients>) or [screen.tiled_clients](<../classes/screen.html#screen.tiled_clients>).

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.client.next (i[, sel[, stacked=false]])](<#awful.client.next>) | Get a client by its relative index to another client.  
---|---  
[awful.client.swap.bydirection (dir[, c=focused[, stacked=false]])](<#awful.client.swap.bydirection>) | Swap a client with another client in the given direction.  
[awful.client.swap.global_bydirection (dir[, sel])](<#awful.client.swap.global_bydirection>) | Swap a client with another client in the given direction.  
[awful.client.swap.byidx (i[, c])](<#awful.client.swap.byidx>) | Swap a client by its relative index.  
[awful.client.cycle (clockwise[, s[, stacked=false]])](<#awful.client.cycle>) | Cycle clients.  
[awful.client.getmarked ()](<#awful.client.getmarked>) | Return the marked clients and empty the marked table.  
[awful.client.restore (s)](<#awful.client.restore>) | Restore (=unminimize) a random client.  
[awful.client.property.persist (prop, kind)](<#awful.client.property.persist>) | Set a client property to be persistent across restarts (via X properties).  
[awful.client.iterate (filter, start, s)](<#awful.client.iterate>) | Returns an iterator to cycle through, starting from the client in focus or the given index, all clients that match a given criteria.  
[awful.client.focus.history.disable_tracking ()](<#awful.client.focus.history.disable_tracking>) | Disable history tracking.  
[awful.client.focus.history.enable_tracking ()](<#awful.client.focus.history.enable_tracking>) | Enable history tracking.  
[awful.client.focus.history.is_enabled ()](<#awful.client.focus.history.is_enabled>) | Is history tracking enabled?  
  
## [Object properties](<#Object_properties>)

[window](<#client.window>) | The X window id.  
---|---  
[name](<#client.name>) | The client title.  
[skip_taskbar](<#client.skip_taskbar>) | True if the client does not want to be in taskbar.  
[type](<#client.type>) | The window type.  
[class](<#client.class>) | The client class.  
[instance](<#client.instance>) | The client instance.  
[pid](<#client.pid>) | The client PID, if available.  
[role](<#client.role>) | The window role, if available.  
[machine](<#client.machine>) | The machine client is running on.  
[icon_name](<#client.icon_name>) | The client name when iconified.  
[icon](<#client.icon>) | The client icon as a surface.  
[icon_sizes](<#client.icon_sizes>) | The available sizes of client icons.  
[screen](<#client.screen>) | Client screen.  
[hidden](<#client.hidden>) | Define if the client must be hidden, i.e.  
[minimized](<#client.minimized>) | Define it the client must be iconify, i.e.  
[size_hints_honor](<#client.size_hints_honor>) | Honor size hints, e.g.  
[border_width](<#client.border_width>) | The client border width.  
[border_color](<#client.border_color>) | The client border color.  
[urgent](<#client.urgent>) | The client urgent state.  
[content](<#client.content>) | A cairo surface for the client window content.  
[opacity](<#client.opacity>) | The client opacity.  
[ontop](<#client.ontop>) | The client is on top of every other windows.  
[above](<#client.above>) | The client is above normal windows.  
[below](<#client.below>) | The client is below normal windows.  
[fullscreen](<#client.fullscreen>) | The client is fullscreen or not.  
[maximized](<#client.maximized>) | The client is maximized (horizontally and vertically) or not.  
[maximized_horizontal](<#client.maximized_horizontal>) | The client is maximized horizontally or not.  
[maximized_vertical](<#client.maximized_vertical>) | The client is maximized vertically or not.  
[transient_for](<#client.transient_for>) | The client the window is transient for.  
[group_window](<#client.group_window>) | Window identification unique to a group of windows.  
[leader_window](<#client.leader_window>) | Identification unique to windows spawned by the same command.  
[size_hints](<#client.size_hints>) | A table with size hints of the client.  
[motif_wm_hints](<#client.motif_wm_hints>) | The motif WM hints of the client.  
[sticky](<#client.sticky>) | Set the client sticky, i.e.  
[modal](<#client.modal>) | Indicate if the client is modal.  
[focusable](<#client.focusable>) | True if the client can receive the input focus.  
[shape_bounding](<#client.shape_bounding>) | The client’s bounding shape as set by awesome as a (native) cairo surface.  
[shape_clip](<#client.shape_clip>) | The client’s clip shape as set by awesome as a (native) cairo surface.  
[shape_input](<#client.shape_input>) | The client’s input shape as set by awesome as a (native) cairo surface.  
[client_shape_bounding](<#client.client_shape_bounding>) | The client’s bounding shape as set by the program as a (native) cairo surface.  
[client_shape_clip](<#client.client_shape_clip>) | The client’s clip shape as set by the program as a (native) cairo surface.  
[startup_id](<#client.startup_id>) | The FreeDesktop StartId.  
[valid](<#client.valid>) | If the client that this object refers to is still managed by awesome.  
[first_tag](<#client.first_tag>) | The first tag of the client.  
[marked](<#client.marked>) | If a client is marked or not.  
[is_fixed](<#client.is_fixed>) | Return if a client has a fixed size or not.  
[immobilized](<#client.immobilized>) | Is the client immobilized horizontally?  
[immobilized](<#client.immobilized>) | Is the client immobilized vertically?  
[floating](<#client.floating>) | The client floating state.  
[x](<#client.x>) | The x coordinates.  
[y](<#client.y>) | The y coordinates.  
[width](<#client.width>) | The width of the client.  
[height](<#client.height>) | The height of the client.  
[dockable](<#client.dockable>) | If the client is dockable.  
[requests_no_titlebar](<#client.requests_no_titlebar>) | If the client requests not to be decorated with a titlebar.  
[shape](<#client.shape>) | Set the client shape.  
  
## [Signals](<#Signals>)

[focus](<#client.focus>) | When a client gains focus.  
---|---  
[list](<#client.list>) | Before manage, after unmanage, and when clients swap.  
[swapped](<#client.swapped>) | When 2 clients are swapped  
[manage](<#client.manage>) | When a new client appears and gets managed by Awesome.  
[button::press](<#button::press>) |   
[button::release](<#button::release>) |   
[mouse::enter](<#mouse::enter>) |   
[mouse::leave](<#mouse::leave>) |   
[mouse::move](<#mouse::move>) |   
[property::window](<#property::window>) |   
[request::activate](<#request::activate>) | When a client should get activated (focused and/or raised).  
[request::geometry](<#request::geometry>) |   
[request::tag](<#request::tag>) |   
[request::urgent](<#request::urgent>) |   
[tagged](<#client.tagged>) | When a client gets tagged.  
[unfocus](<#client.unfocus>) | When a client gets unfocused.  
[unmanage](<#client.unmanage>) |   
[untagged](<#client.untagged>) | When a client gets untagged.  
[raised](<#client.raised>) |   
[lowered](<#client.lowered>) |   
[property::size](<#property::size>) | When the height or width changed.  
[property::position](<#property::position>) | When the x or y coordinate changed.  
[property::floating_geometry](<#property::floating_geometry>) | The last geometry when client was floating.  
[request::titlebars](<#request::titlebars>) | Emited when a client need to get a titlebar.  
[marked](<#client.marked>) | The client marked signal (deprecated).  
[unmarked](<#client.unmarked>) | The client unmarked signal (deprecated).  
  
## [Theme variables](<#Theme_variables>)

[beautiful.border_focus](<#beautiful.border_focus>) | The border color when the client is focused.  
---|---  
[beautiful.border_normal](<#beautiful.border_normal>) | The border color when the client is not focused.  
[beautiful.border_width](<#beautiful.border_width>) | The client border width.  
[beautiful.border_marked](<#beautiful.border_marked>) | The border color when the client is focused.  
  
## [Deprecated functions](<#Deprecated_functions>)

[awful.client.jumpto](<#awful.client.jumpto>) _[deprecated]_ | Jump to the given client.  
---|---  
[awful.client.visible](<#awful.client.visible>) _[deprecated]_ | Get visible clients from a screen.  
[awful.client.tiled](<#awful.client.tiled>) _[deprecated]_ | Get visible and tiled clients  
[awful.client.moveresize](<#awful.client.moveresize>) _[deprecated]_ | Move/resize a client relative to current coordinates.  
[awful.client.movetotag](<#awful.client.movetotag>) _[deprecated]_ | Move a client to a tag.  
[awful.client.toggletag](<#awful.client.toggletag>) _[deprecated]_ | Toggle a tag on a client.  
[awful.client.movetoscreen](<#awful.client.movetoscreen>) _[deprecated]_ | Move a client to a screen.  
[awful.client.mark](<#awful.client.mark>) _[deprecated]_ | Mark a client, and then call ‘marked’ hook.  
[awful.client.unmark](<#awful.client.unmark>) _[deprecated]_ | Unmark a client and then call ‘unmarked’ hook.  
[awful.client.ismarked](<#awful.client.ismarked>) _[deprecated]_ | Check if a client is marked.  
[awful.client.togglemarked](<#awful.client.togglemarked>) _[deprecated]_ | Toggle a client as marked.  
[awful.client.floating.set](<#awful.client.floating.set>) _[deprecated]_ | Set a client floating state, overriding auto-detection.  
[awful.client.isfixed](<#awful.client.isfixed>) _[deprecated]_ | Return if a client has a fixed size or not.  
[awful.client.floating.get](<#awful.client.floating.get>) _[deprecated]_ | Get a client floating state.  
[awful.client.floating.toggle](<#awful.client.floating.toggle>) _[deprecated]_ | Toggle the floating state of a client between ‘auto’ and ‘true’.  
[awful.client.dockable.get](<#awful.client.dockable.get>) _[deprecated]_ | Get a client’s dockable state.  
[awful.client.dockable.set](<#awful.client.dockable.set>) _[deprecated]_ | Set a client’s dockable state, overriding auto-detection.  
[awful.client.property.get](<#awful.client.property.get>) _[deprecated]_ | Get a client property.  
[awful.client.property.set](<#awful.client.property.set>) _[deprecated]_ | Set a client property.  
[awful.client.run_or_raise](<#awful.client.run_or_raise>) _[deprecated]_ | Switch to a client matching the given condition if running, else spawn it.  
[awful.client.get_transient_for_matching](<#awful.client.get_transient_for_matching>) _[deprecated]_ | Get a matching transient_for client (if any).  
[awful.client.is_transient_for](<#awful.client.is_transient_for>) _[deprecated]_ | Is a client transient for another one?  
  
## [Layout related functions](<#Layout_related_functions>)

[awful.client.getmaster](<#awful.client.getmaster>) | Get the master window.  
---|---  
[awful.client.setmaster](<#awful.client.setmaster>) | Set the client as master: put it at the beginning of other windows.  
[awful.client.setslave](<#awful.client.setslave>) | Set the client as slave: put it at the end of other windows.  
[awful.client.idx](<#awful.client.idx>) | Calculate a client’s column number, index in that column, and number of visible clients in this column.  
[awful.client.setwfact](<#awful.client.setwfact>) | Set the window factor of a client  
[awful.client.incwfact](<#awful.client.incwfact>) | Change window factor of a client.  
  
## [Extra properties available in awful.rules and awful.spawn](<#Extra_properties_available_in_awful_rules_and_awful_spawn>)

[placement](<#client.placement>) | The client default placement on the screen.  
---|---  
[honor_padding](<#client.honor_padding>) | When applying the placement, honor the screen padding.  
[honor_workarea](<#client.honor_workarea>) | When applying the placement, honor the screen work area.  
[tag](<#client.tag>) | The client default tag.  
[tags](<#client.tags>) | The client default tags.  
[new_tag](<#client.new_tag>) | Create a new tag for this client.  
[switch_to_tags](<#client.switch_to_tags>) | Unselect the current tags and select this client tags.  
[focus](<#client.focus>) | Define if the client should grab focus by default.  
[titlebars_enabled](<#client.titlebars_enabled>) | Should this client have a titlebar by default.  
[callback](<#client.callback>) | A function to call when this client is ready.  
  
## [Tables](<#Tables>)

[awful.object](<#awful.object>) | Client class.  
---|---  
  
## [Fields](<#Fields>)

[client.focus](<#client.focus>) | The focused [client](<../classes/client.html#>) or nil (in case there is none).  
---|---  
  
## [Methods](<#Methods>)

[client:struts (struts)](<#client:struts>) | Return client struts (reserved space at the edge of the screen).  
---|---  
[client:buttons (buttons_table)](<#client:buttons>) | Get or set mouse buttons bindings for a client.  
[client:instances ()](<#client:instances>) | Get the number of instances.  
[client:get ([screen[, stacked]])](<#client:get>) | Get all clients into a table.  
[client:isvisible ()](<#client:isvisible>) | Check if a client is visible on its screen.  
[client:kill ()](<#client:kill>) | Kill a client.  
[client:swap (c)](<#client:swap>) | Swap a client with another one in global client list.  
[client:tags (tags_table)](<#client:tags>) | Access or set the client tags.  
[client:raise ()](<#client:raise>) | Raise a client on top of others which are on the same layer.  
[client:lower ()](<#client:lower>) | Lower a client on bottom of others which are on the same layer.  
[client:unmanage ()](<#client:unmanage>) | Stop managing a client.  
[client:geometry (geo)](<#client:geometry>) | Return or set client geometry.  
[client:apply_size_hints (width, height)](<#client:apply_size_hints>) | Apply size hints to a size.  
[client:keys (keys_table)](<#client:keys>) | Get or set keys bindings for a client.  
[client:get_icon (index)](<#client:get_icon>) | Get the client’s n-th icon.  
[client:disconnect_signal (name, func)](<#client:disconnect_signal>) | Disconnect from a signal.  
[client:emit_signal (name, ...)](<#client:emit_signal>) | Emit a signal.  
[client:connect_signal (name, func)](<#client:connect_signal>) | Connect to a signal.  
[client:jump_to (merge)](<#client:jump_to>) | Jump to the given client.  
[client:relative_move ([x=c.x[, y=c.y[, w=c.width[, h=c.height]]]])](<#client:relative_move>) | Move/resize a client relative to current coordinates.  
[client:move_to_tag (target)](<#client:move_to_tag>) | Move a client to a tag.  
[client:toggle_tag (target)](<#client:toggle_tag>) | Toggle a tag on a client.  
[client:move_to_screen ([s=c.screen.index+1])](<#client:move_to_screen>) | Move a client to a screen.  
[client:to_selected_tags ()](<#client:to_selected_tags>) | Tag a client with the set of current tags.  
[client:get_transient_for_matching (matcher)](<#client:get_transient_for_matching>) | Get a matching transient_for client (if any).  
[client:is_transient_for (c2)](<#client:is_transient_for>) | Is a client transient for another one?  
  
## [lib.awful.client.focus Functions](<#lib_awful_client_focus_Functions>)

[awful.client.focus.history.delete (c)](<#awful.client.focus.history.delete>) | Remove a client from the focus history  
---|---  
[awful.client.focus.byidx (i[, c])](<#awful.client.focus.byidx>) | Focus a client by its relative index.  
[awful.client.focus.filter (c)](<#awful.client.focus.filter>) | Filter out window that we do not want handled by focus.  
[awful.client.focus.history.add (c)](<#awful.client.focus.history.add>) | Update client focus history.  
[awful.client.focus.history.get (s, idx, filter)](<#awful.client.focus.history.get>) | Get the latest focused client for a screen in history.  
[awful.client.focus.history.previous ()](<#awful.client.focus.history.previous>) | Focus the previous client in history.  
[awful.client.focus.bydirection (dir[, c[, stacked=false]])](<#awful.client.focus.bydirection>) | Focus a client by the given direction.  
[awful.client.focus.global_bydirection (dir[, c[, stacked=false]])](<#awful.client.focus.global_bydirection>) | Focus a client by the given direction.  
  
## [lib.awful.client.shape Functions](<#lib_awful_client_shape_Functions>)

[awful.client.shape.get_transformed (c, shape_name)](<#awful.client.shape.get_transformed>) | Get one of a client’s shapes and transform it to include window decorations.  
---|---  
[awful.client.shape.update.all (c)](<#awful.client.shape.update.all>) | Update all of a client’s shapes from the shapes the client set itself.  
[awful.client.shape.update.bounding (c)](<#awful.client.shape.update.bounding>) | Update a client’s bounding shape from the shape the client set itself.  
[awful.client.shape.update.clip (c)](<#awful.client.shape.update.clip>) | Update a client’s clip shape from the shape the client set itself.  
  
## [lib.awful.client.urgent Functions](<#lib_awful_client_urgent_Functions>)

[awful.urgent.get ()](<#awful.urgent.get>) | Get the first client that got the urgent hint.  
---|---  
[awful.urgent.jumpto (merge)](<#awful.urgent.jumpto>) | Jump to the client that received the urgent hint first.  
[awful.urgent.add (c, prop)](<#awful.urgent.add>) | Adds client to urgent stack.  
[awful.urgent.delete (c)](<#awful.urgent.delete>) | Remove client from urgent stack.  
  
  


## Functions

Methods 

**awful.client.next (i[, sel[, stacked=false]])**
     Get a client by its relative index to another client. If no client is passed, the focused client will be used. 

  * i int The index. Use 1 to get the next, -1 to get the previous. 
  * sel [client.object](<../classes/client.html#awful.object>) The client. (_optional_) 
  * stacked boolean Use stacking order? (top to bottom) (_default_ false) 


### Returns:

A client, or nil if no client is available. 


### Usage:
    
    -- focus the next window in the index
    awful.client.next(1)
    -- focus the previous
    awful.client.next(-1)


**awful.client.swap.bydirection (dir[, c=focused[, stacked=false]])**
     Swap a client with another client in the given direction. 

  * dir [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The direction, can be either “up”, “down”, “left” or “right”. 
  * c [client.object](<../classes/client.html#awful.object>) The client. (_default_ focused) 
  * stacked boolean Use stacking order? (top to bottom) (_default_ false) 


**awful.client.swap.global_bydirection (dir[, sel])**
     Swap a client with another client in the given direction. Swaps across screens. 

  * dir The direction, can be either “up”, “down”, “left” or “right”. 
  * sel [client.object](<../classes/client.html#awful.object>) The client. (_optional_) 


**awful.client.swap.byidx (i[, c])**
     Swap a client by its relative index. 

  * i The index. 
  * c [client.object](<../classes/client.html#awful.object>) The client, otherwise focused one is used. (_optional_) 


**awful.client.cycle (clockwise[, s[, stacked=false]])**
     Cycle clients. 

  * clockwise True to cycle clients clockwise. 
  * s The screen where to cycle clients. (_optional_) 
  * stacked boolean Use stacking order? (top to bottom) (_default_ false) 


**awful.client.getmarked ()**
     Return the marked clients and empty the marked table. 

### Returns:

A table with all marked clients. 

**awful.client.restore (s)**
     Restore (=unminimize) a random client. 

  * s The screen to use. 


### Returns:

The restored client if some client was restored, otherwise nil. 

**awful.client.property.persist (prop, kind)**
     Set a client property to be persistent across restarts (via X properties). 

  * prop The property name. 
  * kind The type (used for register_xproperty). One of “string”, “number” or “boolean”. 


**awful.client.iterate (filter, start, s)**
     Returns an iterator to cycle through, starting from the client in focus or the given index, all clients that match a given criteria. 

  * filter a function that returns true to indicate a positive match 
  * start what index to start iterating from. Defaults to using the index of the currently focused client. 
  * s which screen to use. nil means all screens. 


### Usage:
    
    -- un-minimize all urxvt instances
    local urxvt = function (c)
      return awful.rules.match(c, {class = "URxvt"})
    end
    
    for c in awful.client.iterate(urxvt) do
      c.minimized = false
    end


**awful.client.focus.history.disable_tracking ()**
     Disable history tracking.

See [awful.client.focus.history.enable_tracking](<../classes/client.html#awful.client.focus.history.enable_tracking>) to enable it again. 

### Returns:

int The internal value of `disabled_count` (calls to this function without calling [awful.client.focus.history.enable_tracking](<../classes/client.html#awful.client.focus.history.enable_tracking>)). 

**awful.client.focus.history.enable_tracking ()**
     Enable history tracking.

This is the default, but can be disabled through [awful.client.focus.history.disable_tracking](<../classes/client.html#awful.client.focus.history.disable_tracking>). 

### Returns:

boolean True if history tracking has been enabled. 

**awful.client.focus.history.is_enabled ()**
     Is history tracking enabled? 

### Returns:

  1. bool True if history tracking is enabled.
  2. int The number of times that tracking has been disabled.


## Object properties

**window**
    

The X window id.

**Signal:**

  * _property::window_


### Type:

  * string


**name**
    

The client title.

**Signal:**

  * _property::name_


### Type:

  * string


**skip_taskbar**
    

True if the client does not want to be in taskbar.

**Signal:**

  * _property::skip_taskbar_


### Type:

  * boolean


**type**
    

The window type.

Valid types are:

  * **desktop** : The root client, it cannot be moved or resized.
  * **dock** : A client attached to the side of the screen.
  * **splash** : A client, usually without titlebar shown when an application starts.
  * **dialog** : A dialog, see [transient_for](<../classes/client.html#client.transient_for>).
  * **menu** : A context menu.
  * **toolbar** : A floating toolbar.
  * **utility** :
  * **dropdown_menu** : A context menu attached to a parent position.
  * **popup_menu** : A context menu.
  * **notification** : A notification popup.
  * **combo** : A combobox list menu.
  * **dnd** : A drag and drop indicator.
  * **normal** : A normal application main window.


More information can be found [here](<https://specifications.freedesktop.org/wm-spec/wm-spec-latest.html#idm140200472629520>)

**Signal:**

  * _property::type_


### Type:

  * string


**class**
    

The client class.

To get a client class from the command line, use the command `xprop WM_CLASS`. The class will be the second string.

**Signal:**

  * _property::class_


### Type:

  * string


**instance**
    

The client instance.

To get a client instance from the command line, use the command `xprop WM_CLASS`. The instance will be the first string.

**Signal:**

  * _property::instance_


### Type:

  * string


**pid**
    

The client PID, if available.

**Signal:**

  * _property::pid_


### Type:

  * number


**role**
    

The window role, if available.

**Signal:**

  * _property::role_


### Type:

  * string


**machine**
    

The machine client is running on.

**Signal:**

  * _property::machine_


### Type:

  * string


**icon_name**
    

The client name when iconified.

**Signal:**

  * _property::icon_name_


### Type:

  * string


**icon**
    

The client icon as a surface.

This property holds the client icon closest to the size configured via [awesome.set_preferred_icon_size](<../libraries/awesome.html#set_preferred_icon_size>).

It is not a path or an “real” file. Rather, it is already a bitmap surface.

Typically you would want to use [awful.widget.clienticon](<../classes/awful.widget.clienticon.html#>) to get this as a widget.

Working with icons is tricky because their surfaces do not use reference counting correctly. If `gears.surface(c.icon)` is called multiple time on the same icon, it will cause a double-free error and Awesome will crash. To get a copy of the icon, you can use:
    
    
     local s = gears.surface(c.icon)
     local img = cairo.ImageSurface.create(cairo.Format.ARGB32, s:get_width(), s:get_height())
     local cr  = cairo.Context(img)
     cr:set_source_surface(s, 0, 0)
     cr:paint()
    

**Signal:**

  * _property::icon_


### Type:

  * surface


### Usage:
    
    local ib = wibox.widget.imagebox(c.icon)


**icon_sizes**
    

The available sizes of client icons. This is a table where each entry contains the width and height of an icon.

**Signal:**

  * _property::icon_sizes_


### Type:

  * sizes [table](<https://www.lua.org/manual/5.1/manual.html#5.5>)


### See also:

[get_icon](<../classes/client.html#client:get_icon>) 

**screen**
    

Client screen.

**Signal:**

  * _property::screen_


### Type:

  * screen


**hidden**
    

Define if the client must be hidden, i.e. never mapped, invisible in taskbar.

**Signal:**

  * _property::hidden_


### Type:

  * boolean


**minimized**
    

Define it the client must be iconify, i.e. only visible in taskbar.

**Signal:**

  * _property::minimized_


### Type:

  * boolean


**size_hints_honor**
    

Honor size hints, e.g. respect size ratio.

For example, a terminal such as `xterm` require the client size to be a multiple of the character size. Honoring size hints will cause the terminal window to have a small gap at the bottom.

This is enabled by default. To disable it by default, see [awful.rules](<../libraries/awful.rules.html#>).

**Signal:**

  * _property::size_hints_honor_


### Type:

  * boolean


### See also:

[size_hints](<../classes/client.html#client.size_hints>) 

**border_width**
     The client border width. 

### Type:

  * integer


**border_color**
    

The client border color.

**Signal:**

  * _property::border_color_


### Type:

  * pattern Any string, gradients and patterns will be converted to a cairo pattern. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**urgent**
    

The client urgent state.

**Signal:**

  * _property::urgent_


### Type:

  * boolean


**content**
    

A cairo surface for the client window content.

To get the screenshot, use:
    
    
    gears.surface(c.content)
    

To save it, use:
    
    
    gears.surface(c.content):write_to_png(path)
    

### Type:

  * surface


**opacity**
    

The client opacity.

**Signal:**

  * _property::opacity_


### Type:

  * number Between 0 (transparent) to 1 (opaque) 


**ontop**
     The client is on top of every other windows. 

### Type:

  * boolean


**above**
    

The client is above normal windows.

**Signal:**

  * _property::above_


### Type:

  * boolean


**below**
    

The client is below normal windows.

**Signal:**

  * _property::below_


### Type:

  * boolean


**fullscreen**
    

The client is fullscreen or not.

**Signal:**

  * _property::fullscreen_


### Type:

  * boolean


**maximized**
    

The client is maximized (horizontally and vertically) or not.

**Signal:**

  * _property::maximized_


### Type:

  * boolean


**maximized_horizontal**
    

The client is maximized horizontally or not.

**Signal:**

  * _property::maximized_horizontal_


### Type:

  * boolean


**maximized_vertical**
    

The client is maximized vertically or not.

**Signal:**

  * _property::maximized_vertical_


### Type:

  * boolean


**transient_for**
    

The client the window is transient for.

**Signal:**

  * _property::transient_for_


### Type:

  * client


**group_window**
    

Window identification unique to a group of windows.

**Signal:**

  * _property::group_window_


### Type:

  * client


**leader_window**
     Identification unique to windows spawned by the same command. 

### Type:

  * client


**size_hints**
    

A table with size hints of the client.

**Signal:**

  * _property::size_hints_


### Type:

  * table
    * user_position integer
    * user_size integer
    * program_position integer
    * program_size integer
    * max_width integer
    * max_height integer
    * min_width integer
    * min_height integer
    * width_inc integer
    * height_inc integer


### See also:

[size_hints_honor](<../classes/client.html#client.size_hints_honor>) 

**motif_wm_hints**
    

The motif WM hints of the client.

This is nil if the client has no motif hints. Otherwise, this is a table that contains the present properties. Note that awesome provides these properties as-is and does not interpret them for you. For example, if the function table only has “resize” set to true, this means that the window requests to be only resizable, but asks for the other functions not to be able. If however both “resize” and “all” are set, this means that all but the resize function should be enabled.

**Signal:**

  * _property::motif_wm_hints_


### Type:

  * table
    * functions [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) (_optional_) 
    * functions.all boolean (_optional_) 
    * functions.resize boolean (_optional_) 
    * functions.move boolean (_optional_) 
    * functions.minimize boolean (_optional_) 
    * functions.maximize boolean (_optional_) 
    * functions.close boolean (_optional_) 
    * decorations [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) (_optional_) 
    * decorations.all boolean (_optional_) 
    * decorations.border boolean (_optional_) 
    * decorations.resizeh boolean (_optional_) 
    * decorations.title boolean (_optional_) 
    * decorations.menu boolean (_optional_) 
    * decorations.minimize boolean (_optional_) 
    * decorations.maximize boolean (_optional_) 
    * input_mode [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_optional_) 
    * status [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) (_optional_) 
    * status.tearoff_window boolean (_optional_) 


**sticky**
    

Set the client sticky, i.e. available on all tags.

**Signal:**

  * _property::sticky_


### Type:

  * boolean


**modal**
    

Indicate if the client is modal.

**Signal:**

  * _property::modal_


### Type:

  * boolean


**focusable**
    

True if the client can receive the input focus.

**Signal:**

  * _property::focusable_


### Type:

  * boolean


**shape_bounding**
    

The client’s bounding shape as set by awesome as a (native) cairo surface.

**Signal:**

  * _property::shape_bounding_


### Type:

  * surface


### See also:

[gears.surface.apply_shape_bounding](<../libraries/gears.surface.html#apply_shape_bounding>) 

**shape_clip**
    

The client’s clip shape as set by awesome as a (native) cairo surface.

**Signal:**

  * _property::shape_clip_


### Type:

  * surface


**shape_input**
    

The client’s input shape as set by awesome as a (native) cairo surface.

**Signal:**

  * _property::shape_input_


### Type:

  * surface


**client_shape_bounding**
    

The client’s bounding shape as set by the program as a (native) cairo surface.

**Signal:**

  * _property::shape_client_bounding_


### Type:

  * surface


**client_shape_clip**
    

The client’s clip shape as set by the program as a (native) cairo surface.

**Signal:**

  * _property::shape_client_clip_


### Type:

  * surface


**startup_id**
    

The FreeDesktop StartId.

When a client is spawned (like using a terminal or [awful.spawn](<../libraries/awful.spawn.html#>), a startup notification identifier is created. When the client is created, this identifier remain the same. This allow to match a spawn event to an actual client.

This is used to display a different mouse cursor when the application is loading and also to attach some properties to the newly created client (like a [tag](<../classes/tag.html#>) or [floating](<../classes/client.html#client.floating>) state).

Some applications, like `xterm`, don’t support startup notification. While not perfect, the addition the following code to [rc.lua](<../sample files/rc.lua.html#>) will mitigate the issue. Please note that this code is Linux specific.
    
    
    local blacklisted_snid = setmetatable({}, {__mode = "v" })
    
    --- Make startup notification work for some clients like XTerm. This is ugly
    -- but works often enough to be useful.
    local function fix_startup_id(c)
        -- Prevent "broken" sub processes created by <code>c</code> to inherit its SNID
        if c.startup_id then
            blacklisted_snid[c.startup_id] = blacklisted_snid[c.startup_id] or c
            return
        end
    
        if not c.pid then return end
    
        -- Read the process environment variables
        local f = io.open("/proc/"..c.pid.."/environ", "rb")
    
        -- It will only work on Linux, that's already 99% of the userbase.
        if not f then return end
    
        local value = _VERSION <= "Lua 5.1" and "([^\z]*)\0" or "([^\0]*)\0"
        local snid = f:read("*all"):match("STARTUP_ID=" .. value)
        f:close()
    
        -- If there is already a client using this SNID, it means it's either a
        -- subprocess or another window for the same process. While it makes sense
        -- in some case to apply the same rules, it is not always the case, so
        -- better doing nothing rather than something stupid.
        if blacklisted_snid[snid] then return end
    
        c.startup_id = snid
    
        blacklisted_snid[snid] = c
    end
    
    awful.rules.add_rule_source(
        "snid", fix_startup_id, {}, {"awful.spawn", "awful.rules"}
    )
    

**Signal:**

  * _property::startup_id_


### Type:

  * string


### See also:

[awful.spawn](<../libraries/awful.spawn.html#>) 

**valid**
    

If the client that this object refers to is still managed by awesome.

To avoid errors, use:
    
    
    local is_valid = pcall(function() return c.valid end) and c.valid
    

**Signal:**

  * _property::valid_


### Type:

  * boolean


**first_tag**
    

The first tag of the client. Optimized form of `c:tags()[1]`.

**Signal:**

  * _property::first_tag_


### Type:

  * tag


**marked**
    

If a client is marked or not.

**Signal:**

  * _marked_ (for legacy reasons, use `property::marked`)
  * _unmarked_ (for legacy reasons, use `property::marked`)
  * _property::marked_


### Type:

  * boolean


**is_fixed**
     Return if a client has a fixed size or not.

**Signal:**

  * _property::is_fixed_


This property is read only. 

### Type:

  * boolean The fixed size state 


### See also:

  * [size_hints](<../classes/client.html#client.size_hints>)
  * [size_hints_honor](<../classes/client.html#client.size_hints_honor>)


**immobilized**
     Is the client immobilized horizontally?

Does the client have a fixed horizontal position and width, i.e. is it fullscreen, maximized, or horizontally maximized?

This property is read only. 

### Type:

  * boolean The immobilized state 


### See also:

  * [maximized](<../classes/client.html#client.maximized>)
  * [maximized_horizontal](<../classes/client.html#client.maximized_horizontal>)
  * [maximized_vertical](<../classes/client.html#client.maximized_vertical>)
  * [fullscreen](<../classes/client.html#client.fullscreen>)


**immobilized**
     Is the client immobilized vertically?

Does the client have a fixed vertical position and width, i.e. is it fullscreen, maximized, or vertically maximized?

This property is read only. 

### Type:

  * boolean The immobilized state 


### See also:

  * [maximized](<../classes/client.html#client.maximized>)
  * [maximized_horizontal](<../classes/client.html#client.maximized_horizontal>)
  * [maximized_vertical](<../classes/client.html#client.maximized_vertical>)
  * [fullscreen](<../classes/client.html#client.fullscreen>)


**floating**
    

The client floating state. If the client is part of the tiled layout or free floating.

Note that some windows might be floating even if you did not set them manually. For example, windows with a type different than normal.

**Signal:**

  * _property::floating_


### Type:

  * boolean The floating state 


**x**
    

The x coordinates.

**Signal:**

  * _property::x_


### Type:

  * integer


**y**
    

The y coordinates.

**Signal:**

  * _property::y_


### Type:

  * integer


**width**
    

The width of the client.

**Signal:**

  * _property::width_


### Type:

  * width


**height**
    

The height of the client.

**Signal:**

  * _property::height_


### Type:

  * height


**dockable**
    

If the client is dockable.

A dockable client is an application confined to the edge of the screen. The space it occupies is substracted from the [screen.workarea](<../classes/screen.html#screen.workarea>).

Clients with a type of “utility”, “toolbar” or “dock” are dockable by default.

**Signal:**

  * _property::dockable_


### Type:

  * boolean The dockable state 


**requests_no_titlebar**
    

If the client requests not to be decorated with a titlebar.

The motif wm hints allow a client to request not to be decorated by the WM in various ways. This property uses the motif MWM_DECOR_TITLE hint and interprets it as the client (not) wanting a titlebar.

**Signal:**

  * _property::requests_no_titlebar_


### Type:

  * boolean Whether the client requests not to get a titlebar 


**shape**
     Set the client shape. 

### Type:

  * A gears.shape gears.shape compatible function. 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 


## Signals

**focus**
     When a client gains focus. 
**list**
     Before manage, after unmanage, and when clients swap. 
**swapped**
     When 2 clients are swapped 

### Arguments:

  * client [client](<../classes/client.html#>) The other client 
  * is_source boolean If self is the source or the destination of the swap 


**manage**
     When a new client appears and gets managed by Awesome. 
**button::press**
    
**button::release**
    
**mouse::enter**
    
**mouse::leave**
    
**mouse::move**
    
**property::window**
    
**request::activate**
     When a client should get activated (focused and/or raised).

**Contexts are:**

  * _ewmh_ : When a client asks for focus (from `X11` events).
  * _autofocus.check_focus_ : When autofocus is enabled (from `awful.autofocus`).
  * _autofocus.check_focus_tag_ : When autofocus is enabled (from `awful.autofocus`).
  * _client.jumpto_ : When a custom lua extension asks a client to be focused (from [client.jump_to](<../classes/client.html#client:jump_to>)).
  * _client.swap.global_bydirection_ : When client swapping requires a focus change (from [awful.client.swap.bydirection](<../classes/client.html#awful.client.swap.bydirection>)).
  * _client.movetotag_ : When a client is moved to a new tag (from [client.move_to_tag](<../classes/client.html#client:move_to_tag>)).
  * _client.movetoscreen_ : When the client is moved to a new screen (from [client.move_to_screen](<../classes/client.html#client:move_to_screen>)).
  * _client.focus.byidx_ : When selecting a client using its index (from [awful.client.focus.byidx](<../classes/client.html#awful.client.focus.byidx>)).
  * _client.focus.history.previous_ : When cycling through history (from [awful.client.focus.history.previous](<../classes/client.html#awful.client.focus.history.previous>)).
  * _menu.clients_ : When using the builtin client menu (from [awful.menu.clients](<../libraries/awful.menu.html#clients>)).
  * _rules_ : When a new client is focused from a rule (from [awful.rules](<../libraries/awful.rules.html#>)).
  * _screen.focus_ : When a screen is focused (from `awful.screen.focus`).


Default implementation: [awful.ewmh.activate](<../libraries/awful.ewmh.html#awful.ewmh.activate>).

To implement focus stealing filters see [awful.ewmh.add_activate_filter](<../libraries/awful.ewmh.html#add_activate_filter>). 

### Arguments:

  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context where this signal was used. 
  * hints A table with additional hints: 
    * raise boolean should the client be raised? (_default_ false) 


**request::geometry**
    

### Arguments:

  * c [client](<../classes/client.html#>) The client 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Why and what to resize. This is used for the handlers to know if they are capable of applying the new geometry. 
  * Additional [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) arguments. Each context handler may interpret this differently. (_default_ {}) 


**request::tag**
    
**request::urgent**
    
**tagged**
     When a client gets tagged. 

### Arguments:

  * t [tag](<../classes/tag.html#>) The tag object. 


**unfocus**
     When a client gets unfocused. 
**unmanage**
    
**untagged**
     When a client gets untagged. 

### Arguments:

  * t [tag](<../classes/tag.html#>) The tag object. 


**raised**
    
**lowered**
    
**property::size**
     When the height or width changed. 

### See also:

[client.geometry](<../classes/client.html#client:geometry>) 

**property::position**
     When the x or y coordinate changed. 

### See also:

[client.geometry](<../classes/client.html#client:geometry>) 

**property::floating_geometry**
     The last geometry when client was floating. 
**request::titlebars**
     Emited when a client need to get a titlebar. 

### Arguments:

  * content [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context (like “rules”) (_default_ nil) 
  * hints [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Some hints. (_default_ nil) 


**marked**
     The client marked signal (deprecated). 
**unmarked**
     The client unmarked signal (deprecated). 

## Theme variables

**beautiful.border_focus**
     The border color when the client is focused. 

### Type:

  * string


**beautiful.border_normal**
     The border color when the client is not focused. 

### Type:

  * string


**beautiful.border_width**
     The client border width. 

### Type:

  * integer


**beautiful.border_marked**
     The border color when the client is focused. 

### Type:

  * string


## Deprecated functions

**awful.client.jumpto _[deprecated]_**
     Jump to the given client. Takes care of focussing the screen, the right tag, etc. param:

  * c [client.object](<../classes/client.html#awful.object>) the client to jump to 
  * merge bool or function If true then merge tags (select the client’s first tag additionally) when the client is not visible. If it is a function, it will be called with the client and its first tag as arguments. 

See also:

[client.jump_to](<../classes/client.html#client:jump_to>) 

**awful.client.visible _[deprecated]_**
     Get visible clients from a screen. param:

  * s integer or [screen](<../classes/screen.html#>) The screen, or nil for all screens. (_optional_) 
  * stacked boolean Use stacking order? (top to bottom) (_default_ false) 

See also:

[screen.clients](<../classes/screen.html#screen.clients>) 

**awful.client.tiled _[deprecated]_**
     Get visible and tiled clients param:

  * s integer or [screen](<../classes/screen.html#>) The screen, or nil for all screens. 
  * stacked boolean Use stacking order? (top to bottom) (_default_ false) 

See also:

[screen.tiled_clients](<../classes/screen.html#screen.tiled_clients>) 

**awful.client.moveresize _[deprecated]_**
     Move/resize a client relative to current coordinates. param:

  * x The relative x coordinate. 
  * y The relative y coordinate. 
  * w The relative width. 
  * h The relative height. 
  * c [client.object](<../classes/client.html#awful.object>) The client, otherwise focused one is used. (_optional_) 

See also:

[client.relative_move](<../classes/client.html#client:relative_move>) 

**awful.client.movetotag _[deprecated]_**
     Move a client to a tag. param:

  * target The tag to move the client to. 
  * c [client.object](<../classes/client.html#awful.object>) The client to move, otherwise the focused one is used. (_optional_) 

See also:

[client.move_to_tag](<../classes/client.html#client:move_to_tag>) 

**awful.client.toggletag _[deprecated]_**
     Toggle a tag on a client. param:

  * target The tag to toggle. 
  * c [client.object](<../classes/client.html#awful.object>) The client to toggle, otherwise the focused one is used. (_optional_) 

See also:

[client.toggle_tag](<../classes/client.html#client:toggle_tag>) 

**awful.client.movetoscreen _[deprecated]_**
     Move a client to a screen. Default is next screen, cycling. param:

  * c [client.object](<../classes/client.html#awful.object>) The client to move. 
  * s The screen, default to current + 1. 

See also:

  * [screen](<../classes/screen.html#>)
  * [client.move_to_screen](<../classes/client.html#client:move_to_screen>)


**awful.client.mark _[deprecated]_**
     Mark a client, and then call ‘marked’ hook. param:

  * c [client.object](<../classes/client.html#awful.object>) The client to mark, the focused one if not specified. 


**awful.client.unmark _[deprecated]_**
     Unmark a client and then call ‘unmarked’ hook. param:

  * c [client.object](<../classes/client.html#awful.object>) The client to unmark, or the focused one if not specified. 


**awful.client.ismarked _[deprecated]_**
     Check if a client is marked. param:

  * c [client.object](<../classes/client.html#awful.object>) The client to check, or the focused one otherwise. 


**awful.client.togglemarked _[deprecated]_**
     Toggle a client as marked. param:

  * c [client.object](<../classes/client.html#awful.object>) The client to toggle mark. 


**awful.client.floating.set _[deprecated]_**
     Set a client floating state, overriding auto-detection. Floating client are not handled by tiling layouts. param:

  * c [client.object](<../classes/client.html#awful.object>) A client. 
  * s True or false. 


**awful.client.isfixed _[deprecated]_**
     Return if a client has a fixed size or not. This function is deprecated, use `c.is_fixed` param:

  * c [client.object](<../classes/client.html#awful.object>) The client. 

See also:

  * [is_fixed](<../classes/client.html#client.is_fixed>)
  * [size_hints_honor](<../classes/client.html#client.size_hints_honor>)


**awful.client.floating.get _[deprecated]_**
     Get a client floating state. param:

  * c [client.object](<../classes/client.html#awful.object>) A client. 

See also:

[floating](<../classes/client.html#client.floating>) 

**awful.client.floating.toggle _[deprecated]_**
     Toggle the floating state of a client between ‘auto’ and ‘true’. Use `c.floating = not c.floating` param:

  * c [client.object](<../classes/client.html#awful.object>) A client. 

See also:

[floating](<../classes/client.html#client.floating>) 

**awful.client.dockable.get _[deprecated]_**
     Get a client’s dockable state. param:

  * c [client.object](<../classes/client.html#awful.object>) A client. 


**awful.client.dockable.set _[deprecated]_**
     Set a client’s dockable state, overriding auto-detection. With this enabled you can dock windows by moving them from the center to the edge of the workarea. param:

  * c [client.object](<../classes/client.html#awful.object>) A client. 
  * value True or false. 


**awful.client.property.get _[deprecated]_**
     Get a client property. This method is deprecated. It is now possible to use `c.value` directly. param:

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * prop The property name. 


**awful.client.property.set _[deprecated]_**
     Set a client property. This method is deprecated. It is now possible to use `c.value = value` directly. param:

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * prop The property name. 
  * value The value. 


**awful.client.run_or_raise _[deprecated]_**
     Switch to a client matching the given condition if running, else spawn it. If multiple clients match the given condition then the next one is focussed. param:

  * cmd the command to execute 
  * matcher a function that returns true to indicate a matching client 
  * merge bool or function If true then merge tags (select the client’s first tag additionally) when the client is not visible. If it is a function, it will be called with the client as argument. 

See also:

  * [awful.spawn.once](<../libraries/awful.spawn.html#once>)
  * [awful.spawn.single_instance](<../libraries/awful.spawn.html#single_instance>)
  * [awful.spawn.raise_or_spawn](<../libraries/awful.spawn.html#raise_or_spawn>)

Usage:
    
    -- run or raise urxvt (perhaps, with tabs) on modkey + semicolon
    awful.key({ modkey, }, 'semicolon', function ()
        local matcher = function (c)
            return awful.rules.match(c, {class = 'URxvt'})
        end
        awful.client.run_or_raise('urxvt', matcher)
    end);


**awful.client.get_transient_for_matching _[deprecated]_**
     Get a matching transient_for client (if any). param:

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * matcher function A function that should return true, if a matching parent client is found. 

See also:

[client.get_transient_for_matching](<../classes/client.html#client:get_transient_for_matching>) 

**awful.client.is_transient_for _[deprecated]_**
     Is a client transient for another one? param:

  * c [client.object](<../classes/client.html#awful.object>) The child client (having transient_for). 
  * c2 [client.object](<../classes/client.html#awful.object>) The parent client to check. 

See also:

[client.is_transient_for](<../classes/client.html#awful.client.is_transient_for>) 

Layout related functions

**awful.client.getmaster**
     Get the master window. param:

  * _or_idx [screen](<../classes/screen.html#>) [opt=awful.screen.focused()] s The screen. 


**awful.client.setmaster**
     Set the client as master: put it at the beginning of other windows. param:

  * c [client.object](<../classes/client.html#awful.object>) The window to set as master. 


**awful.client.setslave**
     Set the client as slave: put it at the end of other windows. param:

  * c [client.object](<../classes/client.html#awful.object>) The window to set as slave. 


**awful.client.idx**
     Calculate a client’s column number, index in that column, and number of visible clients in this column. param:

  * c [client.object](<../classes/client.html#awful.object>) the client 


**awful.client.setwfact**
     Set the window factor of a client param:

  * wfact the window factor value 
  * c [client.object](<../classes/client.html#awful.object>) the client 


**awful.client.incwfact**
     Change window factor of a client. param:

  * add number Amount to increase/decrease the client’s window factor. Should be between `-current_window_factor` and something close to infinite. The normalisation then ensures that the sum of all factors is 1. 
  * c [client.object](<../classes/client.html#awful.object>) the client 


Extra properties available in awful.rules and awful.spawn

**placement**
     The client default placement on the screen. The default config uses:
    
    
    awful.placement.no_overlap+awful.placement.no_offscreen
    

See also:

[awful.placement](<../libraries/awful.placement.html#>) 

**honor_padding**
     When applying the placement, honor the screen padding. Type:

  * boolean (_default_ true) 

See also:

[awful.placement](<../libraries/awful.placement.html#>) 

**honor_workarea**
     When applying the placement, honor the screen work area. The workarea is the part of the screen that excludes the bars and docks. Type:

  * boolean (_default_ true) 

See also:

[awful.placement](<../libraries/awful.placement.html#>) 

**tag**
     The client default tag. Type:

  * tag

See also:

  * [tag](<../classes/tag.html#>)
  * [new_tag](<../classes/client.html#client.new_tag>)
  * [tags](<../classes/client.html#client:tags>)
  * [switch_to_tags](<../classes/client.html#client.switch_to_tags>)


**tags**
     The client default tags. Avoid using the tag and tags properties at the same time, it will cause issues. Type:

  * table (_default_ {tag}) 

See also:

  * [tag](<../classes/tag.html#>)
  * [new_tag](<../classes/client.html#client.new_tag>)
  * [tags](<../classes/client.html#client:tags>)
  * [switch_to_tags](<../classes/client.html#client.switch_to_tags>)


**new_tag**
     Create a new tag for this client. If the value is `true`, the new tag will be named after the client [class](<../classes/client.html#client.class>). If it is a string, it will be the tag name. If a table is used, all of its properties will be passed to the tag constructor:
    
    
    new_tag = {
        name     = "My new tag!", -- The tag name.
        layout   = awful.layout.suit.max, -- Set the tag layout.
        volatile = true, -- Remove the tag when the client is closed.
    }
    

Type:

  * new_tag [table](<https://www.lua.org/manual/5.1/manual.html#5.5>), [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or boolean (_default_ false) 

See also:

  * [tag](<../classes/tag.html#>)
  * [tags](<../classes/client.html#client:tags>)
  * [switch_to_tags](<../classes/client.html#client.switch_to_tags>)


**switch_to_tags**
     Unselect the current tags and select this client tags. Note that this property was called `switchtotag` in previous Awesome versions. Type:

  * boolean (_default_ false) 

See also:

[tag.selected](<../classes/tag.html#tag.selected>) 

**focus**
     Define if the client should grab focus by default. The [request::activate](<../classes/client.html#request::activate>) context for this call is `rules`. Type:

  * boolean (_default_ false) 


**titlebars_enabled**
     Should this client have a titlebar by default. Type:

  * boolean (_default_ false) 

See also:

[awful.titlebar](<../classes/awful.titlebar.html#>) 

**callback**
     A function to call when this client is ready. It can be useful to set extra properties or perform actions. See also:

[awful.spawn](<../libraries/awful.spawn.html#>) 

Tables

**awful.object**
     Client class. This table allow to add more dynamic properties to the clients. For example, doing:
    
    
     function awful.client.object.set_my_cool_property(c, value)
         -- Some logic code
         c._my_secret_my_cool_property = value
         c:emit_signal("property::my_cool_property)
     end
    
     function awful.client.object.get_my_cool_property()
         return c._my_secret_my_cool_property
     end
    

Will add a new “my_cool_property” dyanmic property to all client. These methods will be called when an user does `c.my_cool_property = "something"` or set them in `awdul.rules`. Note that doing this isn’t required to set random properties to the client, it is only useful when setting or getting these properties require code to executed. 
Fields

**client.focus**
     The focused [client](<../classes/client.html#>) or nil (in case there is none). 

  * focus [client](<../classes/client.html#>)


Methods

**client:struts (struts)**
     Return client struts (reserved space at the edge of the screen). 

  * struts A table with new strut values, or none. 

Returns:

A table with strut values. 

**client:buttons (buttons_table)**
     Get or set mouse buttons bindings for a client. 

  * buttons_table An array of mouse button bindings objects, or nothing. 

Returns:

A table with all buttons. 

**client:instances ()**
     Get the number of instances. Returns:

The number of client objects alive. 

**client:get ([screen[, stacked]])**
     Get all clients into a table. 

  * screen integer A screen number to filter clients on. (_optional_) 
  * stacked boolean Return clients in stacking order? (ordered from top to bottom). (_optional_) 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with clients. 

**client:isvisible ()**
     Check if a client is visible on its screen. Returns:

A boolean value, true if the client is visible, false otherwise. 

**client:kill ()**
     Kill a client. 
**client:swap (c)**
     Swap a client with another one in global client list. 

  * c [client.object](<../classes/client.html#awful.object>) A client to swap with. 


**client:tags (tags_table)**
     Access or set the client tags. Use the [first_tag](<../classes/client.html#client.first_tag>) field to access the first tag of a client directly. **Signal:**

  * _property::tags_


  * tags_table [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with tags to set, or `nil` to get the current tags. 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with all tags. 

**client:raise ()**
     Raise a client on top of others which are on the same layer. 
**client:lower ()**
     Lower a client on bottom of others which are on the same layer. 
**client:unmanage ()**
     Stop managing a client. 
**client:geometry (geo)**
     Return or set client geometry. 

  * geo [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or nil A table with new coordinates, or nil. 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with client geometry and coordinates. 

**client:apply_size_hints (width, height)**
     Apply size hints to a size. 

  * width Desired width of client 
  * height Desired height of client 

Returns:

  1. Actual width of client
  2. Actual height of client


**client:keys (keys_table)**
     Get or set keys bindings for a client. 

  * keys_table An array of key bindings objects, or nothing. 

Returns:

A table with all keys. 

**client:get_icon (index)**
     Get the client’s n-th icon. **Signal:**

  * _property::icon_


  * index interger The index in the list of icons to get. 

Returns:

surface A lightuserdata for a cairo surface. This reference must be destroyed! 

**client:disconnect_signal (name, func)**
     Disconnect from a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback that should be disconnected. 


**client:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**client:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**client:jump_to (merge)**
     Jump to the given client. Takes care of focussing the screen, the right tag, etc. 

  * merge bool or function If true then merge tags (select the client’s first tag additionally) when the client is not visible. If it is a function, it will be called with the client and its first tag as arguments. 


**client:relative_move ([x=c.x[, y=c.y[, w=c.width[, h=c.height]]]])**
     Move/resize a client relative to current coordinates. 

  * x number The relative x coordinate. (_default_ c.x) 
  * y number The relative y coordinate. (_default_ c.y) 
  * w number The relative width. (_default_ c.width) 
  * h number The relative height. (_default_ c.height) 

See also:

[geometry](<../classes/client.html#client:geometry>) 

**client:move_to_tag (target)**
     Move a client to a tag. 

  * target [tag](<../classes/tag.html#>) The tag to move the client to. 


**client:toggle_tag (target)**
     Toggle a tag on a client. 

  * target [tag](<../classes/tag.html#>) The tag to move the client to. 


**client:move_to_screen ([s=c.screen.index+1])**
     Move a client to a screen. Default is next screen, cycling. 

  * s [screen](<../classes/screen.html#>) The screen, default to current + 1. (_default_ c.screen.index+1) 

See also:

  * [screen](<../classes/screen.html#>)
  * [request::activate](<../classes/client.html#request::activate>)


**client:to_selected_tags ()**
     Tag a client with the set of current tags. See also:

[screen.selected_tags](<../classes/screen.html#screen.selected_tags>) 

**client:get_transient_for_matching (matcher)**
     Get a matching transient_for client (if any). 

  * matcher function A function that should return true, if a matching parent client is found. 

Returns:

client.client or nil The matching parent client or nil. 

**client:is_transient_for (c2)**
     Is a client transient for another one? 

  * c2 [client.object](<../classes/client.html#awful.object>) The parent client to check. 

Returns:

client.client or nil The parent client or nil. 

lib.awful.client.focus Functions

**awful.client.focus.history.delete (c)**
     Remove a client from the focus history 

  * c [client.object](<../classes/client.html#awful.object>) The client that must be removed. 


**awful.client.focus.byidx (i[, c])**
     Focus a client by its relative index. 

  * i The index. 
  * c [client.object](<../classes/client.html#awful.object>) The client. (_optional_) 


**awful.client.focus.filter (c)**
     Filter out window that we do not want handled by focus. This usually means that desktop, dock and splash windows are not registered and cannot get focus. 

  * c [client.object](<../classes/client.html#awful.object>) A client. 

Returns:

The same client if it’s ok, nil otherwise. 

**awful.client.focus.history.add (c)**
     Update client focus history. 

  * c [client.object](<../classes/client.html#awful.object>) The client that has been focused. 


**awful.client.focus.history.get (s, idx, filter)**
     Get the latest focused client for a screen in history. 

  * s int or [screen](<../classes/screen.html#>) The screen to look for. 
  * idx int The index: 0 will return first candidate, 1 will return second, etc. 
  * filter function An optional filter. If no client is found in the first iteration, [awful.client.focus.filter](<../classes/client.html#awful.client.focus.filter>) is used by default to get any client. 

Returns:

[client.object](<../classes/client.html#awful.object>) A client. 

**awful.client.focus.history.previous ()**
     Focus the previous client in history. 
**awful.client.focus.bydirection (dir[, c[, stacked=false]])**
     Focus a client by the given direction. 

  * dir [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The direction, can be either `"up"`, `"down"`, `"left"` or `"right"`. 
  * c [client.object](<../classes/client.html#awful.object>) The client. (_optional_) 
  * stacked boolean Use stacking order? (top to bottom) (_default_ false) 


**awful.client.focus.global_bydirection (dir[, c[, stacked=false]])**
     Focus a client by the given direction. Moves across screens. 

  * dir The direction, can be either “up”, “down”, “left” or “right”. 
  * c [client.object](<../classes/client.html#awful.object>) The client. (_optional_) 
  * stacked boolean Use stacking order? (top to bottom) (_default_ false) 


lib.awful.client.shape Functions

**awful.client.shape.get_transformed (c, shape_name)**
     Get one of a client’s shapes and transform it to include window decorations. 

  * c [client.object](<../classes/client.html#awful.object>) The client whose shape should be retrieved 
  * shape_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Either “bounding” or “clip”


**awful.client.shape.update.all (c)**
     Update all of a client’s shapes from the shapes the client set itself. 

  * c [client.object](<../classes/client.html#awful.object>) The client to act on 


**awful.client.shape.update.bounding (c)**
     Update a client’s bounding shape from the shape the client set itself. 

  * c [client.object](<../classes/client.html#awful.object>) The client to act on 


**awful.client.shape.update.clip (c)**
     Update a client’s clip shape from the shape the client set itself. 

  * c [client.object](<../classes/client.html#awful.object>) The client to act on 


lib.awful.client.urgent Functions

**awful.urgent.get ()**
     Get the first client that got the urgent hint. Returns:

[client.object](<../classes/client.html#awful.object>) The first urgent client. 

**awful.urgent.jumpto (merge)**
     Jump to the client that received the urgent hint first. 

  * merge bool or function If true then merge tags (select the client’s first tag additionally) when the client is not visible. If it is a function, it will be called with the client as argument. 


**awful.urgent.add (c, prop)**
     Adds client to urgent stack. 

  * c [client.object](<../classes/client.html#awful.object>) The client object. 
  * prop The property which is updated. 


**awful.urgent.delete (c)**
     Remove client from urgent stack. 

  * c [client.object](<../classes/client.html#awful.object>) The client object.