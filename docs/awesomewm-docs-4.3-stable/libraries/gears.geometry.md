# Module gears.geometry - awesome API documentation

**Module:** `libraries.gears.geometry`  

> Source: [libraries/gears.geometry.html](https://awesomewm.org/doc/api/libraries/gears.geometry.html)

---

# Module `gears.geometry`

Helper functions used to compute geometries.

When this module refer to a geometry table, this assume a table with at least an _x_ , _y_ , _width_ and _height_ keys and numeric values.

### Info:

  * **Copyright** : 2008 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[gears.geometry.rectangle.get_square_distance (geom, x, y)](<#gears.geometry.rectangle.get_square_distance>) | Get the square distance between a rectangle and a point.  
---|---  
[gears.geometry.rectangle.get_closest_by_coord (list, x, y)](<#gears.geometry.rectangle.get_closest_by_coord>) | Return the closest rectangle from `list` for a given point.  
[gears.geometry.rectangle.get_by_coord (list, x, y)](<#gears.geometry.rectangle.get_by_coord>) | Return the rectangle containing the [x, y] point.  
[gears.geometry.rectangle.get_in_direction (dir, recttbl, cur)](<#gears.geometry.rectangle.get_in_direction>) | Get the nearest rectangle in the given direction.  
[gears.geometry.rectangle.area_intersect_area (a, b)](<#gears.geometry.rectangle.area_intersect_area>) | Check if an area intersect another area.  
[gears.geometry.rectangle.get_intersection (a, b)](<#gears.geometry.rectangle.get_intersection>) | Get the intersect area between a and b.  
[gears.geometry.rectangle.area_remove (areas, elem)](<#gears.geometry.rectangle.area_remove>) | Remove an area from a list, splitting the space between several area that can overlap.  
  
  


## Functions

Methods 

**gears.geometry.rectangle.get_square_distance (geom, x, y)**
     Get the square distance between a rectangle and a point. 

  * geom A rectangle 
    * x number The horizontal coordinate 
    * y number The vertical coordinate 
    * width number The rectangle width 
    * height number The rectangle height 
  * x number X coordinate of point 
  * y number Y coordinate of point 


### Returns:

number The squared distance of the rectangle to the provided point 

**gears.geometry.rectangle.get_closest_by_coord (list, x, y)**
     Return the closest rectangle from `list` for a given point. 

  * list [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A list of geometry tables. 
  * x number The x coordinate 
  * y number The y coordinate 


### Returns:

The key from the closest geometry. 

**gears.geometry.rectangle.get_by_coord (list, x, y)**
     Return the rectangle containing the [x, y] point.

Note that if multiple element from the geometry list contains the point, the returned result is nondeterministic. 

  * list [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A list of geometry tables. 
  * x number The x coordinate 
  * y number The y coordinate 


### Returns:

The key from the closest geometry. In case no result is found, _nil_ is returned. 

**gears.geometry.rectangle.get_in_direction (dir, recttbl, cur)**
     Get the nearest rectangle in the given direction. Every rectangle is specified as a table with _x_ , _y_ , _width_ , _height_ keys, the same as client or screen geometries. 

  * dir [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The direction, can be either _up_ , _down_ , _left_ or _right_. 
  * recttbl [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table of rectangle specifications. 
  * cur [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current rectangle. 


### Returns:

The index for the rectangle in recttbl closer to cur in the given direction. nil if none found. 

**gears.geometry.rectangle.area_intersect_area (a, b)**
     Check if an area intersect another area. 

  * a The area. 
  * b The other area. 


### Returns:

True if they intersect, false otherwise. 

**gears.geometry.rectangle.get_intersection (a, b)**
     Get the intersect area between a and b. 

  * a The area. 
    * x number The horizontal coordinate 
    * y number The vertical coordinate 
    * width number The rectangle width 
    * height number The rectangle height 
  * b The other area. 
    * x number The horizontal coordinate 
    * y number The vertical coordinate 
    * width number The rectangle width 
    * height number The rectangle height 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The intersect area. 

**gears.geometry.rectangle.area_remove (areas, elem)**
     Remove an area from a list, splitting the space between several area that can overlap. 

  * areas [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Table of areas. 
  * elem Area to remove. 
    * x number The horizontal coordinate 
    * y number The vertical coordinate 
    * width number The rectangle width 
    * height number The rectangle height 


### Returns:

The new area list.