# Module awful.layout - awesome API documentation

**Module:** `libraries.awful.layout`  

> Source: [libraries/awful.layout.html](https://awesomewm.org/doc/api/libraries/awful.layout.html)

---

# Module `awful.layout`

Layout module for awful

### Info:

  * **Copyright** : 2008 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[get_tag_layout_index (t)](<#get_tag_layout_index>) | Return the tag layout index (from [awful.layout.layouts](<../libraries/awful.layout.html#layouts>)).  
---|---  
[get (screen)](<#get>) | Get the current layout.  
[inc (i, s[, layouts])](<#inc>) | Change the layout of the current tag.  
[set (_layout[, t=mouse.screen.selected_tag])](<#set>) | Set the layout function of the current tag.  
[parameters ([t[, screen]])](<#parameters>) | Get the layout parameters used for the screen This should give the same result as “arrange”, but without the “geometries” parameter, as this is computed during arranging.  
[arrange (screen)](<#arrange>) | Arrange a screen using its current layout.  
[getname (_layout)](<#getname>) | Get the current layout name.  
[move_handler (c, context, hints)](<#move_handler>) | Default handler for `request::geometry` signals for tiled clients with the “mouse.move” context.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.layout_cornernw](<#beautiful.layout_cornernw>) | The cornernw layout layoutbox icon.  
---|---  
[beautiful.layout_cornerne](<#beautiful.layout_cornerne>) | The cornerne layout layoutbox icon.  
[beautiful.layout_cornersw](<#beautiful.layout_cornersw>) | The cornersw layout layoutbox icon.  
[beautiful.layout_cornerse](<#beautiful.layout_cornerse>) | The cornerse layout layoutbox icon.  
[beautiful.layout_fairh](<#beautiful.layout_fairh>) | The fairh layout layoutbox icon.  
[beautiful.layout_fairv](<#beautiful.layout_fairv>) | The fairv layout layoutbox icon.  
[beautiful.layout_floating](<#beautiful.layout_floating>) | The floating layout layoutbox icon.  
[beautiful.layout_magnifier](<#beautiful.layout_magnifier>) | The magnifier layout layoutbox icon.  
[beautiful.layout_max](<#beautiful.layout_max>) | The max layout layoutbox icon.  
[beautiful.layout_fullscreen](<#beautiful.layout_fullscreen>) | The fullscreen layout layoutbox icon.  
[beautiful.layout_spiral](<#beautiful.layout_spiral>) | The spiral layout layoutbox icon.  
[beautiful.layout_dwindle](<#beautiful.layout_dwindle>) | The dwindle layout layoutbox icon.  
[beautiful.layout_tile](<#beautiful.layout_tile>) | The tile layout layoutbox icon.  
[beautiful.layout_tiletop](<#beautiful.layout_tiletop>) | The tile top layout layoutbox icon.  
[beautiful.layout_tilebottom](<#beautiful.layout_tilebottom>) | The tile bottom layout layoutbox icon.  
[beautiful.layout_tileleft](<#beautiful.layout_tileleft>) | The tile left layout layoutbox icon.  
  
## [Client layouts](<#Client_layouts>)

[awful.layout.suit.corner.nw](<#awful.layout.suit.corner.nw>) | Corner layout.  
---|---  
[awful.layout.suit.corner.ne](<#awful.layout.suit.corner.ne>) | Corner layout.  
[awful.layout.suit.corner.sw](<#awful.layout.suit.corner.sw>) | Corner layout.  
[awful.layout.suit.corner.se](<#awful.layout.suit.corner.se>) | Corner layout.  
[awful.layout.suit.](<#awful.layout.suit.>) | The floating layout.  
[awful.layout.suit.magnifier](<#awful.layout.suit.magnifier>) | The magnifier layout.  
[awful.layout.suit.max.name](<#awful.layout.suit.max.name>) | Maximized layout.  
[awful.layout.suit.max.fullscreen](<#awful.layout.suit.max.fullscreen>) | Fullscreen layout.  
[awful.layout.suit.spiral.dwindle](<#awful.layout.suit.spiral.dwindle>) | Dwindle layout.  
[awful.layout.suit.spiral.name](<#awful.layout.suit.spiral.name>) | Spiral layout.  
[awful.layout.suit.tile.right](<#awful.layout.suit.tile.right>) | The main tile algo, on the right.  
[awful.layout.suit.tile.left](<#awful.layout.suit.tile.left>) | The main tile algo, on the left.  
[awful.layout.suit.tile.bottom](<#awful.layout.suit.tile.bottom>) | The main tile algo, on the bottom.  
[awful.layout.suit.tile.top](<#awful.layout.suit.tile.top>) | The main tile algo, on the top.  
  
## [Tables](<#Tables>)

[fair.horizontal](<#fair.horizontal>) | Horizontal fair layout.  
---|---  
  
## [Fields](<#Fields>)

[layouts](<#layouts>) | The default list of layouts.  
---|---  
[fair.name](<#fair.name>) | Vertical fair layout.  
[floating.resize_jump_to_corner](<#floating.resize_jump_to_corner>) | Jump mouse cursor to the client’s corner when resizing it.  
[tile.resize_jump_to_corner](<#tile.resize_jump_to_corner>) | Jump mouse cursor to the client’s corner when resizing it.  
  
  


## Functions

Methods 

**get_tag_layout_index (t)**
     Return the tag layout index (from [awful.layout.layouts](<../libraries/awful.layout.html#layouts>)).

If the layout isn’t part of [awful.layout.layouts](<../libraries/awful.layout.html#layouts>), this function returns nil. 

  * t [tag](<../classes/tag.html#>) The tag. 


### Returns:

nil or number The layout index. 

**get (screen)**
     Get the current layout. 

  * screen The screen. 


### Returns:

The layout function. 

**inc (i, s[, layouts])**
     Change the layout of the current tag. 

  * i Relative index. 
  * s The screen. 
  * layouts A table of layouts. (_optional_) 


**set (_layout[, t=mouse.screen.selected_tag])**
     Set the layout function of the current tag. 

  * _layout Layout name. 
  * t [tag](<../classes/tag.html#>) The tag to modify. (_default_ mouse.screen.selected_tag) 


**parameters ([t[, screen]])**
     Get the layout parameters used for the screen

This should give the same result as “arrange”, but without the “geometries” parameter, as this is computed during arranging.

If `t` is given, [screen](<../classes/screen.html#>) is ignored, if none are given, the mouse screen is used. 

  * t [tag](<../classes/tag.html#>) The tag to query (_optional_) 
  * screen The screen (_optional_) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with the workarea (x, y, width, height), the screen geometry (x, y, width, height), the clients, the screen and sometime, a “geometries” table with client as keys and geometry as value 

**arrange (screen)**
     Arrange a screen using its current layout. 

  * screen The screen to arrange. 


**getname (_layout)**
     Get the current layout name. 

  * _layout The layout. 


### Returns:

The layout name. 

**move_handler (c, context, hints)**
     Default handler for `request::geometry` signals for tiled clients with the “mouse.move” context. 

  * c [client](<../classes/client.html#>) The client 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context 
  * hints [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Additional hints 


## Theme variables

**beautiful.layout_cornernw**
     The cornernw layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_cornerne**
     The cornerne layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_cornersw**
     The cornersw layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_cornerse**
     The cornerse layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_fairh**
     The fairh layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_fairv**
     The fairv layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_floating**
     The floating layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_magnifier**
     The magnifier layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_max**
     The max layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_fullscreen**
     The fullscreen layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_spiral**
     The spiral layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_dwindle**
     The dwindle layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_tile**
     The tile layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_tiletop**
     The tile top layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_tilebottom**
     The tile bottom layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.layout_tileleft**
     The tile left layout layoutbox icon. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 


## Client layouts

**awful.layout.suit.corner.nw**
     Corner layout. Display master client in a corner of the screen, and slaves in one column and one row around the master. 
**awful.layout.suit.corner.ne**
     Corner layout. Display master client in a corner of the screen, and slaves in one column and one row around the master. 
**awful.layout.suit.corner.sw**
     Corner layout. Display master client in a corner of the screen, and slaves in one column and one row around the master. 
**awful.layout.suit.corner.se**
     Corner layout. Display master client in a corner of the screen, and slaves in one column and one row around the master. 
**awful.layout.suit.**
     The floating layout. 
**awful.layout.suit.magnifier**
     The magnifier layout. 
**awful.layout.suit.max.name**
     Maximized layout. 
**awful.layout.suit.max.fullscreen**
     Fullscreen layout. 
**awful.layout.suit.spiral.dwindle**
     Dwindle layout. 
**awful.layout.suit.spiral.name**
     Spiral layout. 
**awful.layout.suit.tile.right**
     The main tile algo, on the right. 

### param:

  * screen The screen number to tile. 


**awful.layout.suit.tile.left**
     The main tile algo, on the left. 

### param:

  * screen The screen number to tile. 


**awful.layout.suit.tile.bottom**
     The main tile algo, on the bottom. 

### param:

  * screen The screen number to tile. 


**awful.layout.suit.tile.top**
     The main tile algo, on the top. 

### param:

  * screen The screen number to tile. 


## Tables

**fair.horizontal**
     Horizontal fair layout. 

### Fields:

  * screen The screen to arrange. 


## Fields

**layouts**
    

The default list of layouts.

The default value is:
    
    
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.corner.ne,
    awful.layout.suit.corner.sw,
    awful.layout.suit.corner.se,
    

**fair.name**
     Vertical fair layout. 

  * screen The screen to arrange. 


**floating.resize_jump_to_corner**
     Jump mouse cursor to the client’s corner when resizing it. 
**tile.resize_jump_to_corner**
     Jump mouse cursor to the client’s corner when resizing it.