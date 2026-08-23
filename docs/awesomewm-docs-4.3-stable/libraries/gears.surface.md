# Module gears.surface - awesome API documentation

**Module:** `libraries.gears.surface`  

> Source: [libraries/gears.surface.html](https://awesomewm.org/doc/api/libraries/gears.surface.html)

---

# Module `gears.surface`

### Info:

  * **Copyright** : 2012 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[load_uncached_silently (_surface, default)](<#load_uncached_silently>) | Try to convert the argument into an lgi cairo surface.  
---|---  
[load_silently (_surface, default)](<#load_silently>) | Try to convert the argument into an lgi cairo surface.  
[load_uncached (_surface)](<#load_uncached>) | Try to convert the argument into an lgi cairo surface.  
[load (_surface)](<#load>) | Try to convert the argument into an lgi cairo surface.  
[get_size (surf)](<#get_size>) | Get the size of a cairo surface  
[duplicate_surface (s)](<#duplicate_surface>) | Create a copy of a cairo surface.  
[load_from_shape (width, height, shape[, shape_color=white[, bg_color=transparent]])](<#load_from_shape>) | Create a surface from a [gears.shape](<../libraries/gears.shape.html#>) Any additional parameters will be passed to the shape function  
[apply_shape_bounding (draw, shape[, Any])](<#apply_shape_bounding>) | Apply a shape to a client or a wibox.  
  
## [Deprecated functions](<#Deprecated_functions>)

[wibox.widget.draw_to_svg_file](<#wibox.widget.draw_to_svg_file>) _[deprecated]_ | Create an SVG file with this widget content.  
---|---  
[wibox.widget.draw_to_image_surface](<#wibox.widget.draw_to_image_surface>) _[deprecated]_ | Create a cairo surface with this widget content.  
  
  


## Functions

Methods 

**load_uncached_silently (_surface, default)**
     Try to convert the argument into an lgi cairo surface. This is usually needed for loading images by file name. 

  * _surface The surface to load or nil 
  * default The default value to return on error; when nil, then a surface in an error state is returned. 


### Returns:

  1. The loaded surface, or the replacement default
  2. An error message, or nil on success


**load_silently (_surface, default)**
     Try to convert the argument into an lgi cairo surface. This is usually needed for loading images by file name and uses a cache. In contrast to `load()`, errors are returned to the caller. 

  * _surface The surface to load or nil 
  * default The default value to return on error; when nil, then a surface in an error state is returned. 


### Returns:

  1. The loaded surface, or the replacement default, or nil if called with nil.
  2. An error message, or nil on success


**load_uncached (_surface)**
     Try to convert the argument into an lgi cairo surface. This is usually needed for loading images by file name. Errors are handled via [gears.debug.print_error](<../libraries/gears.debug.html#print_error>). 

  * _surface The surface to load or nil 


### Returns:

The loaded surface, or nil 

**load (_surface)**
     Try to convert the argument into an lgi cairo surface. This is usually needed for loading images by file name. Errors are handled via [gears.debug.print_error](<../libraries/gears.debug.html#print_error>). 

  * _surface The surface to load or nil 


### Returns:

The loaded surface, or nil 

**get_size (surf)**
     Get the size of a cairo surface 

  * surf The surface you are interested in 


### Returns:

The surface’s width and height 

**duplicate_surface (s)**
     Create a copy of a cairo surface. The surfaces returned by [surface.load](<../libraries/gears.surface.html#load>) are cached and must not be modified to avoid unintended side-effects. This function allows to create a copy of a cairo surface. This copy can then be freely modified. The surface returned will be as compatible as possible to the input surface. For example, it will likely be of the same surface type as the input. The details are explained in the `create_similar` function on a cairo surface. 

  * s Source surface. 


### Returns:

The surface’s duplicate. 

**load_from_shape (width, height, shape[, shape_color=white[, bg_color=transparent]])**
     Create a surface from a [gears.shape](<../libraries/gears.shape.html#>) Any additional parameters will be passed to the shape function 

  * width number The surface width 
  * height number The surface height 
  * shape A [gears.shape](<../libraries/gears.shape.html#>) compatible function 
  * shape_color The shape color or pattern (_default_ white) 
  * bg_color The surface background color (_default_ transparent) 


### Returns:

cairo.surface the new surface 

**apply_shape_bounding (draw, shape[, Any])**
     Apply a shape to a client or a wibox.

If the wibox or client size change, this function need to be called again. 

  * draw A wibox or a client 
  * shape or gears.shape function or a custom function with a context, width and height as parameter. 
  * Any additional parameters will be passed to the shape function (_optional_) 


## Deprecated functions

**wibox.widget.draw_to_svg_file _[deprecated]_**
     Create an SVG file with this widget content. This is dynamic, so the SVG will be updated along with the widget content. because of this, the painting may happen hover multiple event loop cycles. param:

  * widget widget A widget 
  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The output file path 
  * width number The surface width 
  * height number The surface height 


**wibox.widget.draw_to_image_surface _[deprecated]_**
     Create a cairo surface with this widget content. This is dynamic, so the SVG will be updated along with the widget content. because of this, the painting may happen hover multiple event loop cycles. param:

  * widget widget A widget 
  * width number The surface width 
  * height number The surface height 
  * format The surface format (_default_ cairo.Format.ARGB32)