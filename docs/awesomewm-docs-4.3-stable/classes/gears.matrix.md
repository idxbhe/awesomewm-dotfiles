# Class gears.matrix - awesome API documentation

**Module:** `classes.gears.matrix`  

> Source: [classes/gears.matrix.html](https://awesomewm.org/doc/api/classes/gears.matrix.html)

---

# Class `gears.matrix`

An implementation of matrices for describing and working with affine transformations.

### Info:

  * **Copyright** : 2015 Uli Schlachter
  * **Author** : Uli Schlachter


## [Fields](<#Fields>)

[gears.matrix.identity](<#gears.matrix.identity>) | A constant for the identity matrix.  
---|---  
  
## [Methods](<#Methods>)

[gears.matrix:create (xx, yx, xy, yy, x0, y0)](<#gears.matrix:create>) | Create a new matrix instance  
---|---  
[gears.matrix:create_translate (x, y)](<#gears.matrix:create_translate>) | Create a new translation matrix  
[gears.matrix:create_scale (sx, sy)](<#gears.matrix:create_scale>) | Create a new scaling matrix  
[gears.matrix:create_rotate (angle)](<#gears.matrix:create_rotate>) | Create a new rotation matrix  
[gears.matrix:create_rotate_at (x, y, angle)](<#gears.matrix:create_rotate_at>) | Create a new rotation matrix rotating around a custom point  
[gears.matrix:translate (x, y)](<#gears.matrix:translate>) | Translate this matrix  
[gears.matrix:scale (sx, sy)](<#gears.matrix:scale>) | Scale this matrix  
[gears.matrix:rotate (angle)](<#gears.matrix:rotate>) | Rotate this matrix  
[gears.matrix:rotate_at (x, y, angle)](<#gears.matrix:rotate_at>) | Rotate a shape from a custom point  
[gears.matrix:invert ()](<#gears.matrix:invert>) | Invert this matrix  
[gears.matrix:multiply (other)](<#gears.matrix:multiply>) | Multiply this matrix with another matrix.  
[gears.matrix:equals (other)](<#gears.matrix:equals>) | Check if two matrices are equal.  
[gears.matrix:tostring ()](<#gears.matrix:tostring>) | Get a string representation of this matrix  
[gears.matrix:transform_distance (x, y)](<#gears.matrix:transform_distance>) | Transform a distance by this matrix.  
[gears.matrix:transform_point (x, y)](<#gears.matrix:transform_point>) | Transform a point by this matrix.  
[gears.matrix:transform_rectangle (x, y, width, height)](<#gears.matrix:transform_rectangle>) | Calculate a bounding rectangle for transforming a rectangle by a matrix.  
[gears.matrix:to_cairo_matrix ()](<#gears.matrix:to_cairo_matrix>) | Convert to a cairo matrix  
[gears.matrix:from_cairo_matrix (mat)](<#gears.matrix:from_cairo_matrix>) | Convert to a cairo matrix  
  
  


## Fields

**gears.matrix.identity**
     A constant for the identity matrix. 

## Methods

**gears.matrix:create (xx, yx, xy, yy, x0, y0)**
     Create a new matrix instance 

  * xx number The xx transformation part. 
  * yx number The yx transformation part. 
  * xy number The xy transformation part. 
  * yy number The yy transformation part. 
  * x0 number The x0 transformation part. 
  * y0 number The y0 transformation part. 


### Returns:

A new matrix describing the given transformation. 

**gears.matrix:create_translate (x, y)**
     Create a new translation matrix 

  * x number The translation in x direction. 
  * y number The translation in y direction. 


### Returns:

A new matrix describing the given transformation. 

**gears.matrix:create_scale (sx, sy)**
     Create a new scaling matrix 

  * sx number The scaling in x direction. 
  * sy number The scaling in y direction. 


### Returns:

A new matrix describing the given transformation. 

**gears.matrix:create_rotate (angle)**
     Create a new rotation matrix 

  * angle number The angle of the rotation in radians. 


### Returns:

A new matrix describing the given transformation. 

**gears.matrix:create_rotate_at (x, y, angle)**
     Create a new rotation matrix rotating around a custom point 

  * x number The horizontal rotation point 
  * y number The vertical rotation point 
  * angle number The angle of the rotation in radians. 


### Returns:

A new matrix describing the given transformation. 

**gears.matrix:translate (x, y)**
     Translate this matrix 

  * x number The translation in x direction. 
  * y number The translation in y direction. 


### Returns:

A new matrix describing the new transformation. 

**gears.matrix:scale (sx, sy)**
     Scale this matrix 

  * sx number The scaling in x direction. 
  * sy number The scaling in y direction. 


### Returns:

A new matrix describing the new transformation. 

**gears.matrix:rotate (angle)**
     Rotate this matrix 

  * angle number The angle of the rotation in radians. 


### Returns:

A new matrix describing the new transformation. 

**gears.matrix:rotate_at (x, y, angle)**
     Rotate a shape from a custom point 

  * x number The horizontal rotation point 
  * y number The vertical rotation point 
  * angle number The angle (in radiant: -2 _math.pi to 2_ math.pi) 


### Returns:

A transformation object 

**gears.matrix:invert ()**
     Invert this matrix 

### Returns:

A new matrix describing the inverse transformation. 

**gears.matrix:multiply (other)**
     Multiply this matrix with another matrix. The resulting matrix describes a transformation that is equivalent to first applying this transformation and then the transformation from `other`. Note that this function can also be called by directly multiplicating two matrix instances: `a * b == a:multiply(b)`. 

  * other [gears.matrix](<../classes/gears.matrix.html#>) or cairo.Matrix The other matrix to multiply with. 


### Returns:

The multiplication result. 

**gears.matrix:equals (other)**
     Check if two matrices are equal. Note that this function cal also be called by directly comparing two matrix instances: `a == b`. 

  * other [gears.matrix](<../classes/gears.matrix.html#>) or cairo.Matrix The matrix to compare with. 


### Returns:

True if this and the other matrix are equal. 

**gears.matrix:tostring ()**
     Get a string representation of this matrix 

### Returns:

A string showing this matrix in column form. 

**gears.matrix:transform_distance (x, y)**
     Transform a distance by this matrix. The difference to [matrix:transform_point](<../classes/gears.matrix.html#gears.matrix:transform_point>) is that the translation part of this matrix is ignored. 

  * x number The x coordinate of the point. 
  * y number The y coordinate of the point. 


### Returns:

  1. number The x coordinate of the transformed point.
  2. number The x coordinate of the transformed point.


**gears.matrix:transform_point (x, y)**
     Transform a point by this matrix. 

  * x number The x coordinate of the point. 
  * y number The y coordinate of the point. 


### Returns:

  1. number The x coordinate of the transformed point.
  2. number The y coordinate of the transformed point.


**gears.matrix:transform_rectangle (x, y, width, height)**
     Calculate a bounding rectangle for transforming a rectangle by a matrix. 

  * x number The x coordinate of the rectangle. 
  * y number The y coordinate of the rectangle. 
  * width number The width of the rectangle. 
  * height number The height of the rectangle. 


### Returns:

  1. number X coordinate of the bounding rectangle.
  2. number Y coordinate of the bounding rectangle.
  3. number Width of the bounding rectangle.
  4. number Height of the bounding rectangle.


**gears.matrix:to_cairo_matrix ()**
     Convert to a cairo matrix 

### Returns:

cairo.Matrix A cairo matrix describing the same transformation. 

**gears.matrix:from_cairo_matrix (mat)**
     Convert to a cairo matrix 

  * mat cairo.Matrix A cairo matrix describing the sought transformation 


### Returns:

[gears.matrix](<../classes/gears.matrix.html#>) A matrix instance describing the same transformation.