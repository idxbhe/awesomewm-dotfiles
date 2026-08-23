# Class wibox.layout.grid - awesome API documentation

**Module:** `classes.wibox.layout.grid`  

> Source: [classes/wibox.layout.grid.html](https://awesomewm.org/doc/api/classes/wibox.layout.grid.html)

---

# Class `wibox.layout.grid`

A grid layout.

Widgets spanning several columns or rows cannot be included using the declarative system. Instead, create the grid layout and call the [add_widget_at](<../classes/wibox.layout.grid.html#wibox.layout.grid:add_widget_at>) method.

![Usage example](../images/AUTOGEN_wibox_layout_grid_imperative.svg)
    
    
    local l = wibox.widget {
        homogeneous   = true,
        spacing       = 5,
        min_cols_size = 10,
        min_rows_size = 10,
        layout        = wibox.layout.grid,
    }
    l:add_widget_at(first , 2, 1, 1, 2)
    l:add_widget_at(second, 3, 1, 1, 2)
    l:add_widget_at(third , 2, 3, 2, 1)
    l:add_widget_at(fourth, 4, 1, 1, 1)
    l:add_widget_at(fifth , 4, 2, 1, 2)
    l:insert_row(1)
    l:add_widget_at(lorem, 1, 1, 1, 3)
    

Using the declarative system, widgets are automatically added next to each other spanning only one cell.

![Usage example](../images/AUTOGEN_wibox_layout_defaults_grid.svg)

### Usage:
    
    wibox.widget {
        generic_widget( 'first'  ),
        generic_widget( 'second' ),
        generic_widget( 'third'  ),
        generic_widget( 'fourth' ),
        forced_num_cols = 2,
        forced_num_rows = 2,
        homogeneous     = true,
        expand          = true,
        layout = wibox.layout.grid
    }
    


### Info:

  * **Copyright** : 2017 getzze
  * **Author** : getzze


## [Functions](<#Functions>)

[wibox.layout.grid ([orientation="y"])](<#wibox.layout.grid>) | Return a new grid layout.  
---|---  
[wibox.layout.grid.horizontal (forced_num_rows, ...)](<#wibox.layout.grid.horizontal>) | Return a new horizontal grid layout.  
[wibox.layout.grid.vertical (forced_num_cols, ...)](<#wibox.layout.grid.vertical>) | Return a new vertical grid layout.  
  
## [Object properties](<#Object_properties>)

[orientation](<#wibox.layout.grid.orientation>) | Set the preferred orientation of the grid layout.  
---|---  
[superpose](<#wibox.layout.grid.superpose>) | Allow to superpose widgets in the same cell.  
[forced_num_rows](<#wibox.layout.grid.forced_num_rows>) | Force the number of rows of the layout.  
[forced_num_cols](<#wibox.layout.grid.forced_num_cols>) | Force the number of columns of the layout.  
[min_cols_size](<#wibox.layout.grid.min_cols_size>) | Set the minimum size for the columns.  
[min_rows_size](<#wibox.layout.grid.min_rows_size>) | Set the minimum size for the rows.  
[horizontal_spacing](<#wibox.layout.grid.horizontal_spacing>) | The spacing between columns.  
[vertical_spacing](<#wibox.layout.grid.vertical_spacing>) | The spacing between rows.  
[spacing](<#wibox.layout.grid.spacing>) | The spacing between rows and columns.  
[horizontal_expand](<#wibox.layout.grid.horizontal_expand>) | Controls if the columns are expanded to use all the available width.  
[vertical_expand](<#wibox.layout.grid.vertical_expand>) | Controls if the rows are expanded to use all the available height.  
[expand](<#wibox.layout.grid.expand>) | Controls if the columns/rows are expanded to use all the available space.  
[horizontal_homogeneous](<#wibox.layout.grid.horizontal_homogeneous>) | Controls if the columns all have the same width or if the width of each column depends on the content.  
[vertical_homogeneous](<#wibox.layout.grid.vertical_homogeneous>) | Controls if the rows all have the same height or if the height of each row depends on the content.  
[homogeneous](<#wibox.layout.grid.homogeneous>) | Controls if the columns/rows all have the same size or if the size depends on the content.  
[forced_height](<#wibox.layout.grid.forced_height>) | Force a widget height.  
[forced_width](<#wibox.layout.grid.forced_width>) | Force a widget width.  
[opacity](<#wibox.layout.grid.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.layout.grid.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::reset](<#widget::reset>) | When the layout is reset.  
---|---  
[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Tables](<#Tables>)

[wibox.layout.grid.position](<#wibox.layout.grid.position>) | Child widget position.  
---|---  
  
## [Methods](<#Methods>)

[wibox.layout.grid:get_dimension ()](<#wibox.layout.grid:get_dimension>) | Get the number of rows and columns occupied by the widgets in the grid.  
---|---  
[wibox.layout.grid:get_next_empty ([hint_row=1[, hint_column=1]])](<#wibox.layout.grid:get_next_empty>) | Find the next available cell to insert a widget.  
[wibox.layout.grid:add (...)](<#wibox.layout.grid:add>) | Add some widgets to the given grid layout.  
[wibox.layout.grid:add_widget_at (child, row, col[, row_span=1[, col_span=1]])](<#wibox.layout.grid:add_widget_at>) | Add a widget to the grid layout at specific coordinate.  
[wibox.layout.grid:remove (...)](<#wibox.layout.grid:remove>) | Remove one or more widgets from the layout.  
[wibox.layout.grid:remove_widgets_at (row, col[, row_span=1[, col_span=1]])](<#wibox.layout.grid:remove_widgets_at>) | Remove widgets at the coordinates.  
[wibox.layout.grid:get_widget_position (widget)](<#wibox.layout.grid:get_widget_position>) | Return the coordinates of the widget.  
[wibox.layout.grid:get_widgets_at (row, col[, row_span=1[, col_span=1]])](<#wibox.layout.grid:get_widgets_at>) | Return the widgets at the coordinates.  
[wibox.layout.grid:replace_widget (old, new)](<#wibox.layout.grid:replace_widget>) | Replace old widget by new widget, spanning the same columns and rows.  
[wibox.layout.grid:insert_column (index)](<#wibox.layout.grid:insert_column>) | Insert column at index.  
[wibox.layout.grid:extend_column (index)](<#wibox.layout.grid:extend_column>) | Extend column at index.  
[wibox.layout.grid:remove_column (index)](<#wibox.layout.grid:remove_column>) | Remove column at index.  
[wibox.layout.grid:insert_row (index)](<#wibox.layout.grid:insert_row>) | Insert row at index.  
[wibox.layout.grid:extend_row (index)](<#wibox.layout.grid:extend_row>) | Extend row at index.  
[wibox.layout.grid:remove_row (index)](<#wibox.layout.grid:remove_row>) | Remove row at index.  
[wibox.layout.grid:reset ()](<#wibox.layout.grid:reset>) | Reset the grid layout.  
[wibox.layout.grid:get_all_children ()](<#wibox.layout.grid:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.layout.grid:setup (args)](<#wibox.layout.grid:setup>) | Set a declarative widget hierarchy description.  
[wibox.layout.grid:buttons (_buttons)](<#wibox.layout.grid:buttons>) | Set/get a widget’s buttons.  
[wibox.layout.grid:emit_signal_recursive (signal_name, ...)](<#wibox.layout.grid:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.layout.grid:emit_signal (name, ...)](<#wibox.layout.grid:emit_signal>) | Emit a signal.  
[wibox.layout.grid:connect_signal (name, func)](<#wibox.layout.grid:connect_signal>) | Connect to a signal.  
[wibox.layout.grid:weak_connect_signal (name, func)](<#wibox.layout.grid:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.layout.grid ([orientation="y"])**
     Return a new grid layout.

A grid layout sets widgets in a grids of custom number of rows and columns. 

  * orientation [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The preferred grid extension direction. (_default_ "y") 


**wibox.layout.grid.horizontal (forced_num_rows, ...)**
     Return a new horizontal grid layout.

Each new widget is positioned below the last widget on the same column up to [forced_num_rows](<../classes/wibox.layout.grid.html#wibox.layout.grid.forced_num_rows>). Then the next column is filled, creating it if it doesn’t exist. 

  * forced_num_rows number or nil Forced number of rows (`nil` for automatic). 
  * ... [widget](<../classes/wibox.widget.html>) Widgets that should be added to the layout. 


**wibox.layout.grid.vertical (forced_num_cols, ...)**
     Return a new vertical grid layout.

Each new widget is positioned left of the last widget on the same row up to [forced_num_cols](<../classes/wibox.layout.grid.html#wibox.layout.grid.forced_num_cols>). Then the next row is filled, creating it if it doesn’t exist. 

  * forced_num_cols number or nil Forced number of columns (`nil` for automatic). 
  * ... [widget](<../classes/wibox.widget.html>) Widgets that should be added to the layout. 


## Object properties

**orientation**
    

Set the preferred orientation of the grid layout.

Allowed values are “horizontal” and “vertical”. When calling [get_next_empty](<../classes/wibox.layout.grid.html#wibox.layout.grid:get_next_empty>), empty cells are browsed differently:

  * for “horizontal”, the grid can be extended horizontally. The current column is filled first; if no empty cell is found up to [forced_num_rows](<../classes/wibox.layout.grid.html#wibox.layout.grid.forced_num_rows>), the next column is filled, creating it if it does not exist.

  * for “vertical”, the grid can be extended vertically. The current row is filled first; if no empty cell is found up to [forced_num_cols](<../classes/wibox.layout.grid.html#wibox.layout.grid.forced_num_cols>), the next row is filled, creating it if it does not exist.


![Usage example](../images/AUTOGEN_wibox_layout_grid_orientation.svg)

**Usage example output** :
    
    
    l = wibox.layout {
        forced_num_cols = 2,
        forced_num_rows = 2,
        homogeneous     = true,
        layout = wibox.layout.grid
    }
    l:set_orientation('vertical') -- change to 'horizontal'
    l:add(...)
    

### Type:

  * string Preferred orientation: “horizontal” or “vertical”. (_default_ "vertical") 


**superpose**
     Allow to superpose widgets in the same cell. If false, check before adding a new widget if it will superpose with another widget and prevent from adding it.

![Usage example](../images/AUTOGEN_wibox_layout_grid_superpose.svg)

### Type:

  * boolean (_default_ false) 


**forced_num_rows**
     Force the number of rows of the layout. 

### Type:

  * number number or nil Forced number of rows (`nil` for automatic). (_default_ nil) 


**forced_num_cols**
     Force the number of columns of the layout. 

### Type:

  * number number or nil Forced number of columns (`nil` for automatic). (_default_ nil) 


**min_cols_size**
     Set the minimum size for the columns.

![Usage example](../images/AUTOGEN_wibox_layout_grid_min_size.svg)

### Type:

  * number Minimum size of the columns. (_default_ 0) 


**min_rows_size**
     Set the minimum size for the rows. 

### Type:

  * number Minimum size of the rows. (_default_ 0) 


**horizontal_spacing**
     The spacing between columns.

see [spacing](<../classes/wibox.layout.grid.html#wibox.layout.grid.spacing>)

### Type:

  * number The spacing (_default_ 0) 


**vertical_spacing**
     The spacing between rows.

see [spacing](<../classes/wibox.layout.grid.html#wibox.layout.grid.spacing>)

### Type:

  * number The spacing (_default_ 0) 


**spacing**
     The spacing between rows and columns. Set both [horizontal_spacing](<../classes/wibox.layout.grid.html#wibox.layout.grid.horizontal_spacing>) and [vertical_spacing](<../classes/wibox.layout.grid.html#wibox.layout.grid.vertical_spacing>) to the same value. Get the value [horizontal_spacing](<../classes/wibox.layout.grid.html#wibox.layout.grid.horizontal_spacing>) or [vertical_spacing](<../classes/wibox.layout.grid.html#wibox.layout.grid.vertical_spacing>) defined by the preferred [orientation](<../classes/wibox.layout.grid.html#wibox.layout.grid.orientation>).

![Usage example](../images/AUTOGEN_wibox_layout_grid_spacing.svg)

### Type:

  * number The spacing (_default_ 0) 


**horizontal_expand**
     Controls if the columns are expanded to use all the available width.

see [expand](<../classes/wibox.layout.grid.html#wibox.layout.grid.expand>)

### Type:

  * boolean Expand the grid into the available space (_default_ false) 


**vertical_expand**
     Controls if the rows are expanded to use all the available height.

see [expand](<../classes/wibox.layout.grid.html#wibox.layout.grid.expand>)

### Type:

  * boolean Expand the grid into the available space (_default_ false) 


**expand**
     Controls if the columns/rows are expanded to use all the available space. Set both [horizontal_expand](<../classes/wibox.layout.grid.html#wibox.layout.grid.horizontal_expand>) and [vertical_expand](<../classes/wibox.layout.grid.html#wibox.layout.grid.vertical_expand>) to the same value. Get the value [horizontal_expand](<../classes/wibox.layout.grid.html#wibox.layout.grid.horizontal_expand>) or [vertical_expand](<../classes/wibox.layout.grid.html#wibox.layout.grid.vertical_expand>) defined by the preferred [orientation](<../classes/wibox.layout.grid.html#wibox.layout.grid.orientation>).

![Usage example](../images/AUTOGEN_wibox_layout_grid_expand.svg)

### Type:

  * boolean Expand the grid into the available space (_default_ false) 


**horizontal_homogeneous**
     Controls if the columns all have the same width or if the width of each column depends on the content.

see [homogeneous](<../classes/wibox.layout.grid.html#wibox.layout.grid.homogeneous>)

### Type:

  * boolean All the columns have the same width. (_default_ true) 


**vertical_homogeneous**
     Controls if the rows all have the same height or if the height of each row depends on the content.

see [homogeneous](<../classes/wibox.layout.grid.html#wibox.layout.grid.homogeneous>)

### Type:

  * boolean All the rows have the same height. (_default_ true) 


**homogeneous**
     Controls if the columns/rows all have the same size or if the size depends on the content. Set both [horizontal_homogeneous](<../classes/wibox.layout.grid.html#wibox.layout.grid.horizontal_homogeneous>) and [vertical_homogeneous](<../classes/wibox.layout.grid.html#wibox.layout.grid.vertical_homogeneous>) to the same value. Get the value [horizontal_homogeneous](<../classes/wibox.layout.grid.html#wibox.layout.grid.horizontal_homogeneous>) or [vertical_homogeneous](<../classes/wibox.layout.grid.html#wibox.layout.grid.vertical_homogeneous>) defined by the preferred [orientation](<../classes/wibox.layout.grid.html#wibox.layout.grid.orientation>).

![Usage example](../images/AUTOGEN_wibox_layout_grid_expand.svg)

### Type:

  * boolean All the columns/rows have the same size. (_default_ true) 


**forced_height**
     Force a widget height. 

### Type:

  * height number or nil The height (`nil` for automatic) 


**forced_width**
     Force a widget width. 

### Type:

  * width number or nil The width (`nil` for automatic) 


**opacity**
     The widget opacity (transparency). 

### Type:

  * opacity number The opacity (between 0 and 1) (_default_ 1) 


**visible**
     The widget visibility. 

### Type:

  * boolean


## Signals

**widget::reset**
     When the layout is reset. This signal is emitted when the layout has been reset, all the widgets removed and the row and column counts reset. 
**widget::layout_changed**
     When the layout (size) change. This signal is emitted when the previous results of `:layout()` and `:fit()` are no longer valid. Unless this signal is emitted, `:layout()` and `:fit()` must return the same result when called with the same arguments. 

### See also:

[widget::redraw_needed](<../classes/wibox.layout.grid.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.layout.grid.html#widget::layout_changed>) 

**button::press**
     When a mouse button is pressed over the widget. 

### Arguments:

  * lx number The horizontal position relative to the (0,0) position in the widget. 
  * ly number The vertical position relative to the (0,0) position in the widget. 
  * button number The button number. 
  * mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifiers (mod4, mod1 (alt), Control, Shift) 
  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 

**button::release**
     When a mouse button is released over the widget. 

### Arguments:

  * lx number The horizontal position relative to the (0,0) position in the widget. 
  * ly number The vertical position relative to the (0,0) position in the widget. 
  * button number The button number. 
  * mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifiers (mod4, mod1 (alt), Control, Shift) 
  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 

**mouse::enter**
     When the mouse enter a widget. 

### Arguments:

  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 

**mouse::leave**
     When the mouse leave a widget. 

### Arguments:

  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget [widget](<../classes/wibox.widget.html>) The widget being displayed. 
    * hierarchy wibox.hierarchy The hierarchy managing the widget’s geometry. 
    * x number An approximation of the X position that the widget is visible at on the surface. 
    * y number An approximation of the Y position that the widget is visible at on the surface. 
    * width number An approximation of the width that the widget is visible at on the surface. 
    * height number An approximation of the height that the widget is visible at on the surface. 
    * widget_width number The exact width of the widget in its local coordinate system. 
    * widget_height number The exact height of the widget in its local coordinate system. 


### See also:

[mouse](<../libraries/mouse.html#>) 


## Tables

**wibox.layout.grid.position**
     Child widget position. Return of [get_widget_position](<../classes/wibox.layout.grid.html#wibox.layout.grid:get_widget_position>). 

### Fields:

  * row Top row index 
  * col Left column index 
  * row_span Number of rows to span 
  * col_span Number of columns to span 


## Methods

**wibox.layout.grid:get_dimension ()**
     Get the number of rows and columns occupied by the widgets in the grid. 

### Returns:

number,number The number of rows and columns 

**wibox.layout.grid:get_next_empty ([hint_row=1[, hint_column=1]])**
     Find the next available cell to insert a widget. The grid is browsed according to the [orientation](<../classes/wibox.layout.grid.html#wibox.layout.grid.orientation>). 

  * hint_row number The row coordinate of the last occupied cell. (_default_ 1) 
  * hint_column number The column coordinate of the last occupied cell. (_default_ 1) 


### Returns:

number,number The row,column coordinate of the next empty cell 

**wibox.layout.grid:add (...)**
     Add some widgets to the given grid layout. The widgets are assumed to span one cell 

  * ... Widgets that should be added (must at least be one) 


**wibox.layout.grid:add_widget_at (child, row, col[, row_span=1[, col_span=1]])**
    

Add a widget to the grid layout at specific coordinate.

![Usage example](../images/AUTOGEN_wibox_layout_grid_add.svg)

**Usage example output** :
    
    
    l:add_widget_at(new, 1, 4, 1, 1)
    

  * child Widget that should be added 
  * row number Row number for the top left corner of the widget 
  * col number Column number for the top left corner of the widget 
  * row_span number The number of rows the widget spans. (_default_ 1) 
  * col_span number The number of columns the widget spans. (_default_ 1) 


### Returns:

boolean index If the operation is successful 

**wibox.layout.grid:remove (...)**
     Remove one or more widgets from the layout. 

  * ... Widgets that should be removed (must at least be one) 


### Returns:

boolean If the operation is successful 

**wibox.layout.grid:remove_widgets_at (row, col[, row_span=1[, col_span=1]])**
    

Remove widgets at the coordinates.

![Usage example](../images/AUTOGEN_wibox_layout_grid_remove.svg)

**Usage example output** :
    
    
    l:remove_widgets_at(1,1)
    

  * row number The row coordinate of the widget to remove 
  * col number The column coordinate of the widget to remove 
  * row_span number The number of rows the area to remove spans. (_default_ 1) 
  * col_span number The number of columns the area to remove spans. (_default_ 1) 


### Returns:

boolean If the operation is successful (widgets found) 

**wibox.layout.grid:get_widget_position (widget)**
     Return the coordinates of the widget. 

  * widget The widget 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The [position](<../classes/wibox.layout.grid.html#wibox.layout.grid.position>) table of the coordinates in the grid, with fields `row`, `col`, `row_span` and `col_span`. 

**wibox.layout.grid:get_widgets_at (row, col[, row_span=1[, col_span=1]])**
     Return the widgets at the coordinates. 

  * row number The row coordinate of the widget 
  * col number The column coordinate of the widget 
  * row_span number The number of rows to span. (_default_ 1) 
  * col_span number The number of columns to span. (_default_ 1) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The widget(s) found at the specific coordinates, nil if no widgets found 

**wibox.layout.grid:replace_widget (old, new)**
     Replace old widget by new widget, spanning the same columns and rows. 

  * old The widget to remove 
  * new The widget to add 


### Returns:

boolean If the operation is successful (widget found) 

**wibox.layout.grid:insert_column (index)**
    

Insert column at index.

![Usage example](../images/AUTOGEN_wibox_layout_grid_insert_column.svg)

**Usage example output** :
    
    
    l:insert_column(2)
    

  * index number or nil Insert the new column at index. If `nil`, the column is added at the end. 


### Returns:

number The index of the inserted column 

**wibox.layout.grid:extend_column (index)**
    

Extend column at index.

![Usage example](../images/AUTOGEN_wibox_layout_grid_extend_column.svg)

**Usage example output** :
    
    
    l:extend_column(2)
    

  * index number or nil Extend the column at index. If `nil`, the last column is extended. 


### Returns:

number The index of the extended column 

**wibox.layout.grid:remove_column (index)**
    

Remove column at index.

![Usage example](../images/AUTOGEN_wibox_layout_grid_remove_column.svg)

**Usage example output** :
    
    
    l:remove_column(2)
    

  * index number or nil Remove column at index. If `nil`, the last column is removed. 


### Returns:

number The index of the removed column 

**wibox.layout.grid:insert_row (index)**
     Insert row at index.

see [insert_column](<../classes/wibox.layout.grid.html#wibox.layout.grid:insert_column>)

  * index number or nil Insert the new row at index. If `nil`, the row is added at the end. 


### Returns:

number The index of the inserted row 

**wibox.layout.grid:extend_row (index)**
     Extend row at index.

see [extend_column](<../classes/wibox.layout.grid.html#wibox.layout.grid:extend_column>)

  * index number or nil Extend the row at index. If `nil`, the last row is extended. 


### Returns:

number The index of the extended row 

**wibox.layout.grid:remove_row (index)**
     Remove row at index.

see [remove_column](<../classes/wibox.layout.grid.html#wibox.layout.grid:remove_column>)

  * index number or nil Remove row at index. If `nil`, the last row is removed. 


### Returns:

number The index of the removed row 

**wibox.layout.grid:reset ()**
     Reset the grid layout. Remove all widgets and reset row and column counts

**Signal:** widget::reset 
**wibox.layout.grid:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.layout.grid:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.layout.grid:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.layout.grid:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.layout.grid:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.layout.grid:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.layout.grid:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.