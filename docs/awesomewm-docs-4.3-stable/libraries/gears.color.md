# Module gears.color - awesome API documentation

**Module:** `libraries.gears.color`  

> Source: [libraries/gears.color.html](https://awesomewm.org/doc/api/libraries/gears.color.html)

---

# Module `gears.color`

This module simplifies the creation of cairo pattern objects.

In most places in awesome where a color is needed, the provided argument is passed to [gears.color](<../libraries/gears.color.html#>), which actually calls [create_pattern](<../libraries/gears.color.html#create_pattern>) and creates a pattern from a given string or table.

This function can create solid, linear, radial and png patterns.

A simple example for a solid pattern is a hexadecimal color specification. For example `#ff8000` creates a solid pattern with 100% red, 50% green and 0% blue. Limited support for named colors (`red`) is also provided.

In general, patterns are specified as strings formatted as `"type:arguments"`. `"arguments"` is specific to the pattern being used. For example, one can use:
    
    
    "radial:50,50,10:55,55,30:0,#ff0000:0.5,#00ff00:1,#0000ff"
    

The above will call [create_radial_pattern](<../libraries/gears.color.html#create_radial_pattern>) with the provided string, after stripping the `radial:` prefix.

Alternatively, patterns can be specified via tables. In this case, the table’s ‘type’ member specifies the type. For example:
    
    
    {
      type = "radial",
      from = { 50, 50, 10 },
      to = { 55, 55, 30 },
      stops = { { 0, "#ff0000" }, { 0.5, "#00ff00" }, { 1, "#0000ff" } }
    }
    

Any argument that cannot be understood is passed to [create_solid_pattern](<../libraries/gears.color.html#create_solid_pattern>).

Please note that you MUST NOT modify the returned pattern, for example by calling :set_matrix() on it, because this function uses a cache and your changes could thus have unintended side effects. Use [create_pattern_uncached](<../libraries/gears.color.html#create_pattern_uncached>) if you need to modify the returned pattern.

### See also:

  * [create_pattern_uncached](<../libraries/gears.color.html#create_pattern_uncached>)
  * [create_solid_pattern](<../libraries/gears.color.html#create_solid_pattern>)
  * [create_png_pattern](<../libraries/gears.color.html#create_png_pattern>)
  * [create_linear_pattern](<../libraries/gears.color.html#create_linear_pattern>)
  * [create_radial_pattern](<../libraries/gears.color.html#create_radial_pattern>)


### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[returns... (col)](<#returns...>) |   
---|---  
[parse_color (col)](<#parse_color>) | Parse a HTML-color.  
[create_solid_pattern (col)](<#create_solid_pattern>) | Create a solid pattern  
[create_png_pattern (file)](<#create_png_pattern>) | Create an image pattern from a png file  
[create_linear_pattern (arg)](<#create_linear_pattern>) | Create a linear pattern object.  
[create_radial_pattern (arg)](<#create_radial_pattern>) | Create a radial pattern object.  
[create_pattern_uncached (col)](<#create_pattern_uncached>) | Create a pattern from a given string.  
[create_pattern (col)](<#create_pattern>) | Create a pattern from a given string, same as [gears.color](<../libraries/gears.color.html#>).  
[create_opaque_pattern (col)](<#create_opaque_pattern>) | Check if a pattern is opaque.  
[recolor_image (image, new_color)](<#recolor_image>) | Fill non-transparent area of an image with a given color.  
[ensure_pango_color (check_color, fallback)](<#ensure_pango_color>) | Get a valid color for Pango markup  
  
## [Tables](<#Tables>)

[types](<#types>) | Mapping of all supported color types.  
---|---  
  
## [Fields](<#Fields>)

[transparent](<#transparent>) | No color  
---|---  
  
  


## Functions

Methods 

**returns... (col)**
    

  * col [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The string describing the pattern. 


### Returns:

a cairo pattern object 

**parse_color (col)**
     Parse a HTML-color. This function can parse colors like `#rrggbb` and `#rrggbbaa` and also `red`. Max 4 chars per channel. 

  * col The color to parse 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) 4 values representing color in RGBA format (each of them in [0, 1] range) or nil if input is incorrect. 


### Usage:
    
    -- This will return 0, 1, 0, 1
     gears.color.parse_color("#00ff00ff")


**create_solid_pattern (col)**
     Create a solid pattern 

  * col The color for the pattern 


### Returns:

A cairo pattern object 

**create_png_pattern (file)**
     Create an image pattern from a png file 

  * file The filename of the file 


### Returns:

a cairo pattern object 

**create_linear_pattern (arg)**
     Create a linear pattern object. The pattern is created from a string. This string should have the following form: `"x0, y0:x1, y1:<stops>"` Alternatively, the pattern can be specified as a table: { type = “linear”, from = { x0, y0 }, to = { x1, y1 }, stops = {  } } `x0,y0` and `x1,y1` are the start and stop point of the pattern. For the explanation of `<stops>`, see [color.create_pattern](<../libraries/gears.color.html#create_pattern>). 

  * arg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The argument describing the pattern. 


### Returns:

a cairo pattern object 

**create_radial_pattern (arg)**
     Create a radial pattern object. The pattern is created from a string. This string should have the following form: `"x0, y0, r0:x1, y1, r1:<stops>"` Alternatively, the pattern can be specified as a table: { type = “radial”, from = { x0, y0, r0 }, to = { x1, y1, r1 }, stops = {  } } `x0,y0` and `x1,y1` are the start and stop point of the pattern. `r0` and `r1` are the radii of the start / stop circle. For the explanation of `<stops>`, see [color.create_pattern](<../libraries/gears.color.html#create_pattern>). 

  * arg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The argument describing the pattern 


### Returns:

a cairo pattern object 

**create_pattern_uncached (col)**
     Create a pattern from a given string. For full documentation of this function, please refer to [color.create_pattern](<../libraries/gears.color.html#create_pattern>). The difference between [color.create_pattern](<../libraries/gears.color.html#create_pattern>) and this function is that this function does not insert the generated objects into the pattern cache. Thus, you are allowed to modify the returned object. 

  * col The string describing the pattern. 


### Returns:

a cairo pattern object 


### See also:

[create_pattern](<../libraries/gears.color.html#create_pattern>) 

**create_pattern (col)**
     Create a pattern from a given string, same as [gears.color](<../libraries/gears.color.html#>). 

  * col


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**create_opaque_pattern (col)**
     Check if a pattern is opaque. A pattern is transparent if the background on which it gets drawn (with operator OVER) doesn’t influence the visual result. 

  * col An argument that [create_pattern](<../libraries/gears.color.html#create_pattern>) accepts. 


### Returns:

The pattern if it is surely opaque, else nil 

**recolor_image (image, new_color)**
     Fill non-transparent area of an image with a given color. 

  * image Image or path to it. 
  * new_color New color. 


### Returns:

Recolored image. 

**ensure_pango_color (check_color, fallback)**
     Get a valid color for Pango markup 

  * check_color The color to check. 
  * fallback [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The color to return if the first is invalid. (default: black) 


### Returns:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) color if it is valid, else fallback. 


## Tables

**types**
     Mapping of all supported color types. New entries can be added. 

### Fields:

  * solid
  * png
  * linear
  * radial


## Fields

**transparent**
     No color