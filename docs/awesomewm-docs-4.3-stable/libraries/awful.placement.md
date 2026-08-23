# Module awful.placement - awesome API documentation

**Module:** `libraries.awful.placement`  

> Source: [libraries/awful.placement.html](https://awesomewm.org/doc/api/libraries/awful.placement.html)

---

# Module `awful.placement`

Algorithms used to place various drawables.

The functions provided by this module all follow the same arguments conventions. This allow:

  * To use them in various other module as [visitor objects](<https://en.wikipedia.org/wiki/Visitor_pattern>)
  * Turn each function into an API with various common customization parameters.
  * Re-use the same functions for the [mouse](<../libraries/mouse.html#>), [client](<../classes/client.html#>)s, [screen](<../classes/screen.html#>)s and [wibox](<../classes/wibox.html#>)es


### Compositing

It is possible to compose placement function using the `+` or `*` operator:

![Usage example](../images/AUTOGEN_awful_placement_compose.svg)
    
    
    -- 'right' will be replaced by 'left'
    local f = (awful.placement.right + awful.placement.left)
    f(client.focus)
    

![Usage example](../images/AUTOGEN_awful_placement_compose2.svg)
    
    
    -- Simulate Windows 7 'edge snap' (also called aero snap) feature
    local axis = 'vertically'
    local f = awful.placement.scale
        + awful.placement.left
        + (axis and awful.placement['maximize_'..axis] or nil)
    local geo = f(client.focus, {honor_workarea=true, to_percent = 0.5})
    

### Common arguments

**pretend** (_boolean_):

Do not apply the new geometry. This is useful if only the return values is necessary.

**honor_workarea** (_boolean_):

Take workarea into account when placing the drawable (default: false)

**honor_padding** (_boolean_):

Take the screen padding into account (see [screen.padding](<../classes/screen.html#screen.padding>))

**tag** (_tag_):

Use a tag geometry

**margins** (_number_ or _table_):

A table with left, right, top, bottom keys or a number

**parent** (client, wibox, mouse or screen):

A parent drawable to use a base geometry

**bounding_rect** (table):

A bounding rectangle

**attach** (_boolean_):

When the parent geometry (like the screen) changes, re-apply the placement function. This will add a `detach_callback` function to the drawable. Call this to detach the function. This will be called automatically when a new attached function is set.

**offset** (_table or number_):

The offset(s) to apply to the new geometry.

**store_geometry** (_boolean_):

Keep a single history of each type of placement. It can be restored using [awful.placement.restore](<../libraries/awful.placement.html#restore>) by setting the right `context` argument.

When either the parent or the screen geometry change, call the placement function again.

**update_workarea** (_boolean_):

If _attach_ is true, also update the screen workarea.

### Info:

  * **Copyright** : 2008 Julien Danjou, Emmanuel Lepage Vallee 2016
  * **Author** : Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>,Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[closest_corner ([d=client.focus[, args={}]])](<#closest_corner>) | Move a drawable to the closest corner of the parent geometry (such as the screen).  
---|---  
[no_offscreen (c[, args={}])](<#no_offscreen>) | Place the client so no part of it will be outside the screen (workarea).  
[no_overlap (c[, args={}])](<#no_overlap>) | Place the client where there’s place available with minimum overlap.  
[under_mouse (d[, args={}])](<#under_mouse>) | Place the client under the mouse.  
[next_to_mouse (d[, args={}])](<#next_to_mouse>) | Place the client next to the mouse.  
[resize_to_mouse (d[, args={}])](<#resize_to_mouse>) | Resize the drawable to the cursor.  
[align (d[, args={}])](<#align>) | Move the drawable (client or wibox) `d` to a screen position or side.  
[top_left (d[, args={}])](<#top_left>) | Align a client to the top left of the parent area.  
[top_right (d[, args={}])](<#top_right>) | Align a client to the top right of the parent area.  
[bottom_left (d[, args={}])](<#bottom_left>) | Align a client to the bottom left of the parent area.  
[bottom_right (d[, args={}])](<#bottom_right>) | Align a client to the bottom right of the parent area.  
[left (d[, args={}])](<#left>) | Align a client to the left of the parent area.  
[right (d[, args={}])](<#right>) | Align a client to the right of the parent area.  
[top (d[, args={}])](<#top>) | Align a client to the top of the parent area.  
[bottom (d[, args={}])](<#bottom>) | Align a client to the bottom of the parent area.  
[centered (d[, args={}])](<#centered>) | Align a client to the center of the parent area.  
[center_vertical (d[, args={}])](<#center_vertical>) | Align a client to the vertical center of the parent area.  
[center_horizontal (d[, args={}])](<#center_horizontal>) | Align a client to the horizontal center left of the parent area.  
[stretch ([d=client.focus[, args={}]])](<#stretch>) | Stretch a drawable in a specific direction.  
[stretch_left (d[, args={}])](<#stretch_left>) | Stretch the drawable to the left of the parent area.  
[stretch_right (d[, args={}])](<#stretch_right>) | Stretch the drawable to the right of the parent area.  
[stretch_up (d[, args={}])](<#stretch_up>) | Stretch the drawable to the top of the parent area.  
[stretch_down (d[, args={}])](<#stretch_down>) | Stretch the drawable to the bottom of the parent area.  
[maximize ([d=client.focus[, args={}]])](<#maximize>) | Maximize a drawable horizontally, vertically or both.  
[maximize_vertically (d[, args={}])](<#maximize_vertically>) | Vetically maximize the drawable in the parent area.  
[maximize_horizontally (d[, args={}])](<#maximize_horizontally>) | Horizontally maximize the drawable in the parent area.  
[scale ([d=client.focus[, args={}]])](<#scale>) | Scale the drawable by either a relative or absolute percent.  
[next_to (d, args)](<#next_to>) | Move a drawable to a relative position next to another one.  
[restore ([d=client.focus[, args={}]])](<#restore>) | Restore the geometry.  
  
  


## Functions

Methods 

**closest_corner ([d=client.focus[, args={}]])**
    

Move a drawable to the closest corner of the parent geometry (such as the screen).

Valid arguments include the common ones and:

  * **include_sides** : Also include the left, right, top and bottom positions


![Usage example](../images/AUTOGEN_awful_placement_closest_mouse.svg)

**Usage example output** :
    
    
    Closest corner: top_left
    

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) (_default_ client.focus) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The arguments (_default_ {}) 


### Returns:

  1. [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry
  2. [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The corner name


### Usage:
    
    -- Move the mouse to the closest corner of the focused client
    awful.placement.closest_corner(mouse, {include_sides=true, parent=c})
    -- It is possible to emulate the mouse API to get the closest corner of
    -- random area
    local _, corner = awful.placement.closest_corner(
        {coords=function() return {x = 100, y=100} end},
        {include_sides = true, bounding_rect = {x=0, y=0, width=200, height=200}}
    )
    print('Closest corner:', corner)


**no_offscreen (c[, args={}])**
    

Place the client so no part of it will be outside the screen (workarea).

![Usage example](../images/AUTOGEN_awful_placement_no_offscreen.svg)

**Usage example output** :
    
    
    Before: x=-30, y=-30, width=100, height=100
    After:  x=50, y=50, width=100, height=100
    

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * args The arguments 
    * screen integer The screen. (_default_ client's screen) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new client geometry. 


### Usage:
    
    awful.placement.no_offscreen(c, {honor_workarea=true, margins=40})


**no_overlap (c[, args={}])**
     Place the client where there’s place available with minimum overlap.

![Usage example](../images/AUTOGEN_awful_placement_no_overlap.svg)

  * c The client. 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.no_overlap(client.focus)
    local x,y = screen[4].geometry.x, screen[4].geometry.y


**under_mouse (d[, args={}])**
     Place the client under the mouse.

![Usage example](../images/AUTOGEN_awful_placement_under_mouse.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.under_mouse(client.focus)


**next_to_mouse (d[, args={}])**
     Place the client next to the mouse.

It will place `c` next to the mouse pointer, trying the following positions in this order: right, left, above and below.

![Usage example](../images/AUTOGEN_awful_placement_next_to_mouse.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.next_to_mouse(client.focus)


**resize_to_mouse (d[, args={}])**
     Resize the drawable to the cursor.

Valid args:

  * _axis_ : The axis (vertical or horizontal). If none is specified, then the drawable will be resized on both axis.


![Usage example](../images/AUTOGEN_awful_placement_resize_to_mouse.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 

**align (d[, args={}])**
     Move the drawable (client or wibox) `d` to a screen position or side.

Supported args.positions are:

  * top_left
  * top_right
  * bottom_left
  * bottom_right
  * left
  * right
  * top
  * bottom
  * centered
  * center_vertical
  * center_horizontal


![Usage example](../images/AUTOGEN_awful_placement_align.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 

**top_left (d[, args={}])**
     Align a client to the top left of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_top_left.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.top_left(client.focus)


**top_right (d[, args={}])**
     Align a client to the top right of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_top_right.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.top_right(client.focus)


**bottom_left (d[, args={}])**
     Align a client to the bottom left of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_bottom_left.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.bottom_left(client.focus)


**bottom_right (d[, args={}])**
     Align a client to the bottom right of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_bottom_right.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.bottom_right(client.focus)


**left (d[, args={}])**
     Align a client to the left of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_left.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.left(client.focus)


**right (d[, args={}])**
     Align a client to the right of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_right.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.right(client.focus)


**top (d[, args={}])**
     Align a client to the top of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_top.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.top(client.focus)
    assert(c.x == screen[1].geometry.width/2-40/2-c.border_width)


**bottom (d[, args={}])**
     Align a client to the bottom of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_bottom.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.bottom(client.focus)


**centered (d[, args={}])**
     Align a client to the center of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_centered.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.centered(client.focus)


**center_vertical (d[, args={}])**
     Align a client to the vertical center of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_center_vertical.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Usage:
    
    awful.placement.center_vertical(client.focus)


**center_horizontal (d[, args={}])**
     Align a client to the horizontal center left of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_center_horizontal.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>), [mouse](<../libraries/mouse.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    awful.placement.center_horizontal(client.focus)


**stretch ([d=client.focus[, args={}]])**
     Stretch a drawable in a specific direction. Valid args:

  * **direction** : The stretch direction (_left_ , _right_ , _up_ , _down_) or a table with multiple directions.


![Usage example](../images/AUTOGEN_awful_placement_stretch.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) (_default_ client.focus) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 

**stretch_left (d[, args={}])**
     Stretch the drawable to the left of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_stretch_left.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    placement.stretch_left(client.focus)


**stretch_right (d[, args={}])**
     Stretch the drawable to the right of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_stretch_right.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    placement.stretch_right(client.focus)


**stretch_up (d[, args={}])**
     Stretch the drawable to the top of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_stretch_up.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    placement.stretch_up(client.focus)


**stretch_down (d[, args={}])**
     Stretch the drawable to the bottom of the parent area.

![Usage example](../images/AUTOGEN_awful_placement_stretch_down.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### Usage:
    
    placement.stretch_down(client.focus)


**maximize ([d=client.focus[, args={}]])**
     Maximize a drawable horizontally, vertically or both. Valid args:

  * _axis_ :The axis (vertical or horizontal). If none is specified, then the drawable will be maximized on both axis.


![Usage example](../images/AUTOGEN_awful_placement_maximize.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) (_default_ client.focus) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 

**maximize_vertically (d[, args={}])**
     Vetically maximize the drawable in the parent area.

![Usage example](../images/AUTOGEN_awful_placement_maximize_vertically.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Usage:
    
    placement.maximize_vertically(c)


**maximize_horizontally (d[, args={}])**
     Horizontally maximize the drawable in the parent area.

![Usage example](../images/AUTOGEN_awful_placement_maximize_horizontally.svg)

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Other arguments') (_default_ {}) 


### Usage:
    
    placement.maximize_horizontally(c)


**scale ([d=client.focus[, args={}]])**
     Scale the drawable by either a relative or absolute percent.

Valid args:

**to_percent** : A number between 0 and 1. It represent a percent related to the parent geometry. **by_percent** : A number between 0 and 1. It represent a percent related to the current size. **direction** : Nothing or “left”, “right”, “up”, “down”. 

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) (_default_ client.focus) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The arguments (_default_ {}) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 

**next_to (d, args)**
     Move a drawable to a relative position next to another one.

This placement function offers two additional settings to align the drawable alongside the parent geometry. The first one, the position, sets the side relative to the parent. The second one, the anchor, set the alignment within the side selected by the `preferred_positions`. Both settings are tables of priorities. The first available slot will be used. If there isn’t enough space, then it will fallback to the next until it is possible to fit the drawable. This is meant to avoid going offscreen.

The `args.preferred_positions` look like this:
    
    
    {"top", "right", "left", "bottom"}
    

The `args.preferred_anchors` are:

  * “front”: The closest to the origin (0,0)
  * “middle”: Centered aligned with the parent
  * “back”: The opposite side compared to `front`


In that case, if there is room on the top of the geometry, then it will have priority, followed by all the others, in order.

![Usage example](../images/AUTOGEN_awful_placement_next_to.svg)

  * d [drawable](<../classes/drawable.html#>) A wibox or client 
  * args
    * mode [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The mode 
    * preferred_positions [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The preferred positions (in order) 
    * preferred_anchors [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The preferred anchor(s) (in order) 
    * geometry [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A geometry inside the other drawable 


### Returns:

  1. [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry
  2. [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The choosen position (“left”, “right”, “top” or “bottom”)
  3. [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The choosen anchor (“front”, “middle” or “back”)


### Usage:
    
    for _, pos in ipairs{'left', 'right', 'top', 'bottom'} do
        for _, anchor in ipairs{'front', 'middle', 'back'} do
            awful.placement.next_to(
                client.focus,
                {
                    preferred_positions = pos,
                    preferred_anchors   = anchor,
                    geometry            = parent_client,
                }
            )
        end
    end
    
    The args.mode parameters allows to control from which [next_to](<../libraries/awful.placement.html#next_to>) takes its
    source object from. The valid values are:
    
    * geometry: Next to this geometry, args.geometry has to be set.
    * cursor: Next to the mouse.
    * cursor_inside
    * geometry_inside


**restore ([d=client.focus[, args={}]])**
     Restore the geometry. 

  * d [drawable](<../classes/drawable.html#>) A drawable (like [client](<../classes/client.html#>) or [wibox](<../classes/wibox.html#>)) (_default_ client.focus) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The arguments (_default_ {}) 


### Returns:

boolean If the geometry was restored