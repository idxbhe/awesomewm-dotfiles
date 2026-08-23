# Class wibox.drawable - awesome API documentation

**Module:** `classes.wibox.drawable`  

> Source: [classes/wibox.drawable.html](https://awesomewm.org/doc/api/classes/wibox.drawable.html)

---

# Class `wibox.drawable`

Handling of drawables.

A drawable is something that can be drawn to.

### Info:

  * **Copyright** : 2012 Uli Schlachter
  * **Author** : Uli Schlachter


## [Methods](<#Methods>)

[wibox.drawable:find_widgets (x, y)](<#wibox.drawable:find_widgets>) | Find a widget by a point.  
---|---  
[wibox.drawable:set_widget (widget)](<#wibox.drawable:set_widget>) | Set the widget that the drawable displays  
[wibox.drawable:set_bg (c)](<#wibox.drawable:set_bg>) | Set the background of the drawable  
[wibox.drawable:set_bgimage (image)](<#wibox.drawable:set_bgimage>) | Set the background image of the drawable If `image` is a function, it will be called with `(context, cr, width, height)` as arguments.  
[wibox.drawable:set_fg (c)](<#wibox.drawable:set_fg>) | Set the foreground of the drawable  
  
  


## Methods

**wibox.drawable:find_widgets (x, y)**
     Find a widget by a point. The drawable must have drawn itself at least once for this to work. 

  * x X coordinate of the point 
  * y Y coordinate of the point 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table containing a description of all the widgets that contain the given point. Each entry is a table containing this drawable as its `.drawable` entry, the widget under `.widget` and the instance of [wibox.hierarchy](<../libraries/wibox.hierarchy.html#>) describing the size and position of the widget under `.hierarchy`. For convenience, `.x`, `.y`, `.width` and `.height` contain an approximation of the widget’s extents on the surface. `widget_width` and `widget_height` contain the exact size of the widget in its own, local coordinate system (which may e.g. be rotated and scaled). 

**wibox.drawable:set_widget (widget)**
     Set the widget that the drawable displays 

  * widget


**wibox.drawable:set_bg (c)**
     Set the background of the drawable 

  * c The background to use. This must either be a cairo pattern object, nil or a string that gears.color() understands. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**wibox.drawable:set_bgimage (image)**
     Set the background image of the drawable If `image` is a function, it will be called with `(context, cr, width, height)` as arguments. Any other arguments passed to this method will be appended. 

  * image A background image or a function 


**wibox.drawable:set_fg (c)**
     Set the foreground of the drawable 

  * c The foreground to use. This must either be a cairo pattern object, nil or a string that gears.color() understands. 


### See also:

[gears.color](<../libraries/gears.color.html#>)