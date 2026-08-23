# Class awful.wibar - awesome API documentation

**Module:** `classes.awful.wibar`  

> Source: [classes/awful.wibar.html](https://awesomewm.org/doc/api/classes/awful.wibar.html)

---

# Class `awful.wibar`

Wibox module for awful.

This module allows you to easily create wibox and attach them to the edge of a screen.

### Info:

  * **Copyright** : 2016 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.wibar ([args=nil])](<#awful.wibar>) | Create a new wibox and attach it to a screen edge.  
---|---  
  
## [Object properties](<#Object_properties>)

[stretch](<#awful.wibar.stretch>) | If the wibar needs to be stretched to fill the screen.  
---|---  
[width](<#awful.wibar.width>) | The wibar’s width.  
[height](<#awful.wibar.height>) | The wibar’s height.  
[position](<#awful.wibar.position>) | The wibox position.  
[stretch](<#awful.wibar.stretch>) | Stretch the wibar.  
[border_width](<#awful.wibar.border_width>) | Border width.  
[border_color](<#awful.wibar.border_color>) | Border color.  
[ontop](<#awful.wibar.ontop>) | On top of other windows.  
[cursor](<#awful.wibar.cursor>) | The mouse cursor.  
[visible](<#awful.wibar.visible>) | Visibility.  
[opacity](<#awful.wibar.opacity>) | The opacity of the wibox, between 0 and 1.  
[type](<#awful.wibar.type>) | The window type (desktop, normal, dock, …).  
[x](<#awful.wibar.x>) | The x coordinates.  
[y](<#awful.wibar.y>) | The y coordinates.  
[width](<#awful.wibar.width>) | The width of the wibox.  
[height](<#awful.wibar.height>) | The height of the wibox.  
[screen](<#awful.wibar.screen>) | The wibox screen.  
[drawable](<#awful.wibar.drawable>) | The wibox’s [drawable](<../classes/drawable.html#>).  
[widget](<#awful.wibar.widget>) | The widget that the [wibox](<../classes/wibox.html#>) displays.  
[window](<#awful.wibar.window>) | The X window id.  
[shape_bounding](<#awful.wibar.shape_bounding>) | The wibox’s bounding shape as a (native) cairo surface.  
[shape_clip](<#awful.wibar.shape_clip>) | The wibox’s clip shape as a (native) cairo surface.  
[shape_input](<#awful.wibar.shape_input>) | The wibox’s input shape as a (native) cairo surface.  
[shape](<#awful.wibar.shape>) | The wibar’s shape.  
[input_passthrough](<#awful.wibar.input_passthrough>) | Forward the inputs to the client below the wibox.  
[bg](<#awful.wibar.bg>) | The background of the wibox.  
[bgimage](<#awful.wibar.bgimage>) | The background image of the drawable.  
[fg](<#awful.wibar.fg>) | The foreground (text) of the wibox.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.wibar_stretch](<#beautiful.wibar_stretch>) | If the wibar needs to be stretched to fill the screen.  
---|---  
[beautiful.wibar_border_width](<#beautiful.wibar_border_width>) | The wibar border width.  
[beautiful.wibar_border_color](<#beautiful.wibar_border_color>) | The wibar border color.  
[beautiful.wibar_ontop](<#beautiful.wibar_ontop>) | If the wibar is to be on top of other windows.  
[beautiful.wibar_cursor](<#beautiful.wibar_cursor>) | The wibar’s mouse cursor.  
[beautiful.wibar_opacity](<#beautiful.wibar_opacity>) | The wibar opacity, between 0 and 1.  
[beautiful.wibar_type](<#beautiful.wibar_type>) | The window type (desktop, normal, dock, …).  
[beautiful.wibar_width](<#beautiful.wibar_width>) | The wibar’s width.  
[beautiful.wibar_height](<#beautiful.wibar_height>) | The wibar’s height.  
[beautiful.wibar_bg](<#beautiful.wibar_bg>) | The wibar’s background color.  
[beautiful.wibar_bgimage](<#beautiful.wibar_bgimage>) | The wibar’s background image.  
[beautiful.wibar_fg](<#beautiful.wibar_fg>) | The wibar’s foreground (text) color.  
[beautiful.wibar_shape](<#beautiful.wibar_shape>) | The wibar’s shape.  
[beautiful.bg_normal](<#beautiful.bg_normal>) | The default background color.  
[beautiful.fg_normal](<#beautiful.fg_normal>) | The default foreground (text) color.  
  
## [Deprecated functions](<#Deprecated_functions>)

[awful.wibar.get_position](<#awful.wibar.get_position>) _[deprecated]_ | Get a wibox position if it has been set, or return top.  
---|---  
[awful.wibar.set_position](<#awful.wibar.set_position>) _[deprecated]_ | Put a wibox on a screen at this position.  
[awful.wibar.attach](<#awful.wibar.attach>) _[deprecated]_ | Attach a wibox to a screen.  
[awful.wibar.align](<#awful.wibar.align>) _[deprecated]_ | Align a wibox.  
[awful.wibox.stretch](<#awful.wibox.stretch>) _[deprecated]_ | Stretch a wibox so it takes all screen width or height.  
  
## [Methods](<#Methods>)

[awful.wibar:remove ()](<#awful.wibar:remove>) | Remove a wibar.  
---|---  
[awful.wibar:buttons (buttons_table)](<#awful.wibar:buttons>) | Get or set mouse buttons bindings to a wibox.  
[awful.wibar:geometry (A)](<#awful.wibar:geometry>) | Get or set wibox geometry.  
[awful.wibar:struts (strut)](<#awful.wibar:struts>) | Get or set wibox struts.  
[awful.wibar:setup (args)](<#awful.wibar:setup>) | Set a declarative widget hierarchy description.  
[awful.wibar:find_widgets (x, y)](<#awful.wibar:find_widgets>) | Find a widget by a point.  
  
  


## Functions

Methods 

**awful.wibar ([args=nil])**
     Create a new wibox and attach it to a screen edge. You can add also position key with value top, bottom, left or right. You can also use width or height in % and set align to center, right or left. You can also set the screen key with a screen number to attach the wibox. If not specified, the primary screen is assumed. 

  * args
    * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The position. 
    * stretch [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) If the wibar need to be stretched to fill the screen. 
    * border_width integer Border width. 
    * border_color [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Border color. 
    * ontop boolean On top of other windows. (_default_ false) 
    * cursor [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The mouse cursor. 
    * visible boolean Visibility. 
    * opacity number The opacity, between 0 and 1. (_default_ 1) 
    * type [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The window type (desktop, normal, dock, …). 
    * x integer The x coordinates. 
    * y integer The y coordinates. 
    * width integer The width. 
    * height integer The height. 
    * screen [screen](<../classes/screen.html#>) The wibox screen. 
    * widget [wibox.widget](<../classes/wibox.widget.html#>) The widget that the wibox displays. 
    * shape_bounding The wibox’s bounding shape as a (native) cairo surface. 
    * shape_clip The wibox’s clip shape as a (native) cairo surface. 
    * shape_input The wibox’s input shape as a (native) cairo surface. 
    * bg color The background. 
    * bgimage surface The background image of the drawable. 
    * fg color The foreground (text) color. 
    * shape gears.shape The shape. 
    * input_passthrough boolean If the inputs are forward to the element below. (_default_ false) 


### Returns:

The new wibar 


### See also:

[wibox](<../classes/wibox.html#>) 


## Object properties

**stretch**
     If the wibar needs to be stretched to fill the screen. 

### Type:

  * stretch boolean


**width**
     The wibar’s width. 

### Type:

  * width integer


**height**
     The wibar’s height. 

### Type:

  * height integer


**position**
     The wibox position. 

### Type:

  * string Either “left”, right", “top” or “bottom”


**stretch**
     Stretch the wibar. 

### Type:

  * boolean (_default_ true) 


**border_width**
    

Border width.

**Signal:**

  * _property::border_width_


### Type:

  * integer


**border_color**
    

Border color.

Please note that this property only support string based 24 bit or 32 bit colors:
    
    
    Red Blue
     _|  _|
    #FF00FF
       T‾
     Green
    
    
    Red Blue
     _|  _|
    #FF00FF00
       T‾  ‾T
    Green   Alpha
    

**Signal:**

  * _property::border_color_


### Type:

  * string


**ontop**
    

On top of other windows.

**Signal:**

  * _property::ontop_


### Type:

  * boolean


**cursor**
    

The mouse cursor.

**Signal:**

  * _property::cursor_


### Type:

  * string


### See also:

[mouse](<../libraries/mouse.html#>) 

**visible**
    

Visibility.

**Signal:**

  * _property::visible_


### Type:

  * boolean


**opacity**
    

The opacity of the wibox, between 0 and 1.

**Signal:**

  * _property::opacity_


### Type:

  * opacity number (between 0 and 1) 


**type**
    

The window type (desktop, normal, dock, …).

**Signal:**

  * _property::type_


### Type:

  * string


### See also:

[client.type](<../classes/client.html#client.type>) 

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
    

The width of the wibox.

**Signal:**

  * _property::width_


### Type:

  * width


**height**
    

The height of the wibox.

**Signal:**

  * _property::height_


### Type:

  * height


**screen**
     The wibox screen. 

### Type:

  * screen


**drawable**
    

The wibox’s [drawable](<../classes/drawable.html#>).

**Signal:**

  * _property::drawable_


### Type:

  * drawable [drawable](<../classes/drawable.html#>)


**widget**
     The widget that the [wibox](<../classes/wibox.html#>) displays. 

### Type:

  * widget


**window**
    

The X window id.

**Signal:**

  * _property::window_


### Type:

  * string


### See also:

[client.window](<../classes/client.html#property::window>) 

**shape_bounding**
    

The wibox’s bounding shape as a (native) cairo surface.

**Signal:**

  * _property::shape_bounding_


**shape_clip**
    

The wibox’s clip shape as a (native) cairo surface.

**Signal:**

  * _property::shape_clip_


**shape_input**
    

The wibox’s input shape as a (native) cairo surface.

**Signal:**

  * _property::shape_input_


**shape**
    

The wibar’s shape.

**Signal:**

  * _property::shape_


### Type:

  * shape gears.shape


**input_passthrough**
    

Forward the inputs to the client below the wibox.

This replace the [shape_input](<../classes/awful.wibar.html#awful.wibar.shape_input>) mask with an empty area. All mouse and keyboard events are sent to the object (such as a client) positioned below this wibox. When used alongside compositing, it allows, for example, to have a subtle transparent wibox on top a fullscreen client to display important data such as a low battery warning.

**Signal:**

  * _property::input_passthrough_


### Type:

  * boolean (_default_ false) 


### See also:

[shape_input](<../classes/awful.wibar.html#awful.wibar.shape_input>) 

**bg**
     The background of the wibox. 

### Type:

  * c The background to use. This must either be a cairo pattern object, nil or a string that gears.color() understands. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**bgimage**
     The background image of the drawable. If `image` is a function, it will be called with `(context, cr, width, height)` as arguments. Any other arguments passed to this method will be appended. 

### Type:

  * image A background image or a function 


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**fg**
     The foreground (text) of the wibox. 

### Type:

  * c The foreground to use. This must either be a cairo pattern object, nil or a string that gears.color() understands. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 


## Theme variables

**beautiful.wibar_stretch**
     If the wibar needs to be stretched to fill the screen. 

### Type:

  * stretch boolean


**beautiful.wibar_border_width**
     The wibar border width. 

### Type:

  * border_width integer


**beautiful.wibar_border_color**
     The wibar border color. 

### Type:

  * border_color [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**beautiful.wibar_ontop**
     If the wibar is to be on top of other windows. 

### Type:

  * ontop boolean


**beautiful.wibar_cursor**
     The wibar’s mouse cursor. 

### Type:

  * cursor [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**beautiful.wibar_opacity**
     The wibar opacity, between 0 and 1. 

### Type:

  * opacity number


**beautiful.wibar_type**
     The window type (desktop, normal, dock, …). 

### Type:

  * type [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**beautiful.wibar_width**
     The wibar’s width. 

### Type:

  * width integer


**beautiful.wibar_height**
     The wibar’s height. 

### Type:

  * height integer


**beautiful.wibar_bg**
     The wibar’s background color. 

### Type:

  * bg color


**beautiful.wibar_bgimage**
     The wibar’s background image. 

### Type:

  * bgimage surface


**beautiful.wibar_fg**
     The wibar’s foreground (text) color. 

### Type:

  * fg color


**beautiful.wibar_shape**
     The wibar’s shape. 

### Type:

  * shape gears.shape


**beautiful.bg_normal**
     The default background color. 

### See also:

[bg](<../classes/awful.wibar.html#awful.wibar.bg>) 

**beautiful.fg_normal**
     The default foreground (text) color. 

### See also:

[fg](<../classes/awful.wibar.html#awful.wibar.fg>) 


## Deprecated functions

**awful.wibar.get_position _[deprecated]_**
     Get a wibox position if it has been set, or return top. param:

  * wb The wibox 


**awful.wibar.set_position _[deprecated]_**
     Put a wibox on a screen at this position. param:

  * wb The wibox to attach. 
  * position The position: top, bottom left or right. 
  * screen This argument is deprecated, use wb.screen directly. 


**awful.wibar.attach _[deprecated]_**
     Attach a wibox to a screen. This function has been moved to the [awful.placement](<../libraries/awful.placement.html#>) module. Calling this no longer does anything. param:

  * wb The wibox to attach. 
  * position The position of the wibox: top, bottom, left or right. 
  * screen The screen to attach to 

See also:

[awful.placement](<../libraries/awful.placement.html#>) 

**awful.wibar.align _[deprecated]_**
     Align a wibox. Supported alignment are:

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

param:

  * wb The wibox. 
  * align The alignment 
  * screen This argument is deprecated. It is not used. Use wb.screen directly. 

See also:

[awful.placement.align](<../libraries/awful.placement.html#align>) 

**awful.wibox.stretch _[deprecated]_**
     Stretch a wibox so it takes all screen width or height. **This function has been removed.** See also:

  * [awful.placement](<../libraries/awful.placement.html#>)
  * [awful.wibar.stretch](<../classes/awful.wibar.html#awful.wibar.stretch>)


Methods

**awful.wibar:remove ()**
     Remove a wibar. 
**awful.wibar:buttons (buttons_table)**
     Get or set mouse buttons bindings to a wibox. 

  * buttons_table A table of buttons objects, or nothing. 


**awful.wibar:geometry (A)**
     Get or set wibox geometry. That’s the same as accessing or setting the x, y, width or height properties of a wibox. 

  * A table with coordinates to modify. 

Returns:

A table with wibox coordinates and geometry. 

**awful.wibar:struts (strut)**
     Get or set wibox struts. 

  * strut A table with new strut, or nothing 

Returns:

The wibox strut in a table. 
See also:

[client.struts](<../classes/client.html#client:struts>) 

**awful.wibar:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**awful.wibar:find_widgets (x, y)**
     Find a widget by a point. The wibox must have drawn itself at least once for this to work. 

  * x number X coordinate of the point 
  * y number Y coordinate of the point 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A sorted table of widgets positions. The first element is the biggest container while the last is the topmost widget. The table contains _x_ , _y_ , _width_ , _height_ and _widget_.