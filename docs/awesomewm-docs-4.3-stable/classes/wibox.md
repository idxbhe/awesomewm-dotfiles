# Class wibox - awesome API documentation

**Module:** `classes.wibox`  

> Source: [classes/wibox.html](https://awesomewm.org/doc/api/classes/wibox.html)

---

# Class `wibox`

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[.wibox ([args=nil])](<#.wibox>) | Create a wibox.  
---|---  
  
## [Object properties](<#Object_properties>)

[border_width](<#wibox.border_width>) | Border width.  
---|---  
[border_color](<#wibox.border_color>) | Border color.  
[ontop](<#wibox.ontop>) | On top of other windows.  
[cursor](<#wibox.cursor>) | The mouse cursor.  
[visible](<#wibox.visible>) | Visibility.  
[opacity](<#wibox.opacity>) | The opacity of the wibox, between 0 and 1.  
[type](<#wibox.type>) | The window type (desktop, normal, dock, …).  
[x](<#wibox.x>) | The x coordinates.  
[y](<#wibox.y>) | The y coordinates.  
[width](<#wibox.width>) | The width of the wibox.  
[height](<#wibox.height>) | The height of the wibox.  
[screen](<#wibox.screen>) | The wibox screen.  
[drawable](<#wibox.drawable>) | The wibox’s [drawable](<../classes/drawable.html#>).  
[widget](<#wibox.widget>) | The widget that the [wibox](<../classes/wibox.html#>) displays.  
[window](<#wibox.window>) | The X window id.  
[shape_bounding](<#wibox.shape_bounding>) | The wibox’s bounding shape as a (native) cairo surface.  
[shape_clip](<#wibox.shape_clip>) | The wibox’s clip shape as a (native) cairo surface.  
[shape_input](<#wibox.shape_input>) | The wibox’s input shape as a (native) cairo surface.  
[shape](<#wibox.shape>) | The wibar’s shape.  
[input_passthrough](<#wibox.input_passthrough>) | Forward the inputs to the client below the wibox.  
[bg](<#wibox.bg>) | The background of the wibox.  
[bgimage](<#wibox.bgimage>) | The background image of the drawable.  
[fg](<#wibox.fg>) | The foreground (text) of the wibox.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.bg_normal](<#beautiful.bg_normal>) | The default background color.  
---|---  
[beautiful.fg_normal](<#beautiful.fg_normal>) | The default foreground (text) color.  
  
## [Methods](<#Methods>)

[wibox:buttons (buttons_table)](<#wibox:buttons>) | Get or set mouse buttons bindings to a wibox.  
---|---  
[wibox:geometry (A)](<#wibox:geometry>) | Get or set wibox geometry.  
[wibox:struts (strut)](<#wibox:struts>) | Get or set wibox struts.  
[wibox:setup (args)](<#wibox:setup>) | Set a declarative widget hierarchy description.  
[wibox:find_widgets (x, y)](<#wibox:find_widgets>) | Find a widget by a point.  
[wibox:to_widget ()](<#wibox:to_widget>) | Create a widget that reflects the current state of this wibox.  
[wibox:save_to_svg (path[, context=nil])](<#wibox:save_to_svg>) | Save a screenshot of the wibox to `path`.  
[wibox:draw (wibox)](<#wibox:draw>) | Redraw a wibox.  
  
  


## Functions

Methods 

**.wibox ([args=nil])**
     Create a wibox. 

  * args
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

[wibox](<../classes/wibox.html#>) The new wibox 


## Object properties

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

This replace the [shape_input](<../classes/wibox.html#wibox.shape_input>) mask with an empty area. All mouse and keyboard events are sent to the object (such as a client) positioned below this wibox. When used alongside compositing, it allows, for example, to have a subtle transparent wibox on top a fullscreen client to display important data such as a low battery warning.

**Signal:**

  * _property::input_passthrough_


### Type:

  * boolean (_default_ false) 


### See also:

[shape_input](<../classes/wibox.html#wibox.shape_input>) 

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

**beautiful.bg_normal**
     The default background color. 

### See also:

[bg](<../classes/wibox.html#wibox.bg>) 

**beautiful.fg_normal**
     The default foreground (text) color. 

### See also:

[fg](<../classes/wibox.html#wibox.fg>) 


## Methods

**wibox:buttons (buttons_table)**
     Get or set mouse buttons bindings to a wibox. 

  * buttons_table A table of buttons objects, or nothing. 


**wibox:geometry (A)**
     Get or set wibox geometry. That’s the same as accessing or setting the x, y, width or height properties of a wibox. 

  * A table with coordinates to modify. 


### Returns:

A table with wibox coordinates and geometry. 

**wibox:struts (strut)**
     Get or set wibox struts. 

  * strut A table with new strut, or nothing 


### Returns:

The wibox strut in a table. 


### See also:

[client.struts](<../classes/client.html#client:struts>) 

**wibox:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox:find_widgets (x, y)**
     Find a widget by a point. The wibox must have drawn itself at least once for this to work. 

  * x number X coordinate of the point 
  * y number Y coordinate of the point 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A sorted table of widgets positions. The first element is the biggest container while the last is the topmost widget. The table contains _x_ , _y_ , _width_ , _height_ and _widget_. 

**wibox:to_widget ()**
     Create a widget that reflects the current state of this wibox. 

### Returns:

[widget](<../classes/wibox.html#wibox.widget>) A new widget. 

**wibox:save_to_svg (path[, context=nil])**
     Save a screenshot of the wibox to `path`. 

  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The path. 
  * context [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A widget context. (_default_ nil) 


**wibox:draw (wibox)**
     Redraw a wibox. You should never have to call this explicitely because it is automatically called when needed. 

  * wibox