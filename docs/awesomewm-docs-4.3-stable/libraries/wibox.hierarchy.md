# Module wibox.hierarchy - awesome API documentation

**Module:** `libraries.wibox.hierarchy`  

> Source: [libraries/wibox.hierarchy.html](https://awesomewm.org/doc/api/libraries/wibox.hierarchy.html)

---

# Module `wibox.hierarchy`

Management of widget hierarchies.

Each widget hierarchy object has a widget for which it saves e.g. size and transformation in its parent. Also, each widget has a number of children.

### Info:

  * **Copyright** : 2015 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[count_widget (widget)](<#count_widget>) | Add a widget to the list of widgets for which hierarchies should count their occurrences.  
---|---  
[new (context, widget, width, height, redraw_callback, layout_callback, callback_arg)](<#new>) | Create a new widget hierarchy that has no parent.  
[update (context, widget, width, height[, region])](<#update>) | Update a widget hierarchy with some new state.  
[get_widget ()](<#get_widget>) | Get the widget that this hierarchy manages.  
[get_matrix_to_parent ()](<#get_matrix_to_parent>) | Get a matrix that transforms to the parent’s coordinate space from this hierarchy’s coordinate system.  
[get_matrix_to_device ()](<#get_matrix_to_device>) | Get a matrix that transforms to the base of this hierarchy’s coordinate system (aka the coordinate system of the device that this hierarchy is applied upon) from this hierarchy’s coordinate system.  
[get_matrix_from_parent ()](<#get_matrix_from_parent>) | Get a matrix that transforms from the parent’s coordinate space into this hierarchy’s coordinate system.  
[get_matrix_from_device ()](<#get_matrix_from_device>) | Get a matrix that transforms from the base of this hierarchy’s coordinate system (aka the coordinate system of the device that this hierarchy is applied upon) into this hierarchy’s coordinate system.  
[get_draw_extents ()](<#get_draw_extents>) | Get the extents that this hierarchy possibly draws to (in the current coordinate space).  
[get_size ()](<#get_size>) | Get the size that this hierarchy logically covers (in the current coordinate space).  
[get_children ()](<#get_children>) | Get a list of all children.  
[get_count (widget)](<#get_count>) | Count how often this widget is visible inside this hierarchy.  
[draw (context, cr)](<#draw>) | Draw a hierarchy to some cairo context.  
  
  


## Functions

Methods 

**count_widget (widget)**
     Add a widget to the list of widgets for which hierarchies should count their occurrences. Note that for correct operations, the widget must not yet be visible in any hierarchy. 

  * widget The widget that should be counted. 


**new (context, widget, width, height, redraw_callback, layout_callback, callback_arg)**
     Create a new widget hierarchy that has no parent. 

  * context The context in which we are laid out. 
  * widget The widget that is at the base of the hierarchy. 
  * width The available width for this hierarchy. 
  * height The available height for this hierarchy. 
  * redraw_callback Callback that is called with the corresponding widget hierarchy on widget::redraw_needed on some widget. 
  * layout_callback Callback that is called with the corresponding widget hierarchy on widget::layout_changed on some widget. 
  * callback_arg A second argument that is given to the above callbacks. 


### Returns:

A new widget hierarchy 

**update (context, widget, width, height[, region])**
     Update a widget hierarchy with some new state. 

  * context The context in which we are laid out. 
  * widget The widget that is at the base of the hierarchy. 
  * width The available width for this hierarchy. 
  * height The available height for this hierarchy. 
  * region A region to use for accumulating changed parts (_optional_) 


### Returns:

A cairo region describing the changed parts (either the `region` argument or a new, internally created region). 

**get_widget ()**
     Get the widget that this hierarchy manages. 
**get_matrix_to_parent ()**
     Get a matrix that transforms to the parent’s coordinate space from this hierarchy’s coordinate system. 

### Returns:

A matrix describing the transformation. 

**get_matrix_to_device ()**
     Get a matrix that transforms to the base of this hierarchy’s coordinate system (aka the coordinate system of the device that this hierarchy is applied upon) from this hierarchy’s coordinate system. 

### Returns:

A matrix describing the transformation. 

**get_matrix_from_parent ()**
     Get a matrix that transforms from the parent’s coordinate space into this hierarchy’s coordinate system. 

### Returns:

A matrix describing the transformation. 

**get_matrix_from_device ()**
     Get a matrix that transforms from the base of this hierarchy’s coordinate system (aka the coordinate system of the device that this hierarchy is applied upon) into this hierarchy’s coordinate system. 

### Returns:

A matrix describing the transformation. 

**get_draw_extents ()**
     Get the extents that this hierarchy possibly draws to (in the current coordinate space). This includes the size of this element plus the size of all children (after applying the corresponding transformation). 

### Returns:

x, y, width, height 

**get_size ()**
     Get the size that this hierarchy logically covers (in the current coordinate space). 

### Returns:

width, height 

**get_children ()**
     Get a list of all children. 

### Returns:

List of all children hierarchies. 

**get_count (widget)**
     Count how often this widget is visible inside this hierarchy. This function only works with widgets registered via [count_widget](<../libraries/wibox.hierarchy.html#count_widget>). 

  * widget The widget that should be counted 


### Returns:

The number of times that this widget is contained in this hierarchy. 

**draw (context, cr)**
     Draw a hierarchy to some cairo context. This function draws the widgets in this widget hierarchy to the given cairo context. The context’s clip is used to skip parts that aren’t visible. 

  * context The context in which widgets are drawn. 
  * cr The cairo context that is used for drawing.