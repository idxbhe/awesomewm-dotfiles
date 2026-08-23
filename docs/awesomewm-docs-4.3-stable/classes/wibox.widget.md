# Class wibox.widget - awesome API documentation

**Module:** `classes.wibox.widget`  

> Source: [classes/wibox.widget.html](https://awesomewm.org/doc/api/classes/wibox.widget.html)

---

# Class `wibox.widget`

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Methods](<#Methods>)

[wibox.widget:draw_to_cairo_context (wdg, cr, width, height[, context={dpi=96}])](<#wibox.widget:draw_to_cairo_context>) | Draw a widget directly to a given cairo context.  
---|---  
[wibox.widget:draw_to_svg_file (wdg, path, width, height[, context={dpi=96}])](<#wibox.widget:draw_to_svg_file>) | Create an SVG file showing this widget.  
[wibox.widget:draw_to_image_surface (wdg, width, height[, format=cairo.Format.ARGB32[, context={dpi=96}]])](<#wibox.widget:draw_to_image_surface>) | Create a cairo image surface showing this widget.  
  
  


## Methods

**wibox.widget:draw_to_cairo_context (wdg, cr, width, height[, context={dpi=96}])**
     Draw a widget directly to a given cairo context. This function creates a temporary [wibox.hierarchy](<../libraries/wibox.hierarchy.html#>) instance and uses that to draw the given widget once to the given cairo context. 

  * wdg [widget](<../classes/wibox.widget.html>) A widget to draw 
  * cr cairo_context The cairo context to draw the widget on 
  * width number The width of the widget 
  * height number The height of the widget 
  * context [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The context information to give to the widget. (_default_ {dpi=96}) 


**wibox.widget:draw_to_svg_file (wdg, path, width, height[, context={dpi=96}])**
     Create an SVG file showing this widget. 

  * wdg [widget](<../classes/wibox.widget.html>) A widget 
  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The output file path 
  * width number The surface width 
  * height number The surface height 
  * context [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The context information to give to the widget. (_default_ {dpi=96}) 


**wibox.widget:draw_to_image_surface (wdg, width, height[, format=cairo.Format.ARGB32[, context={dpi=96}]])**
     Create a cairo image surface showing this widget. 

  * wdg [widget](<../classes/wibox.widget.html>) A widget 
  * width number The surface width 
  * height number The surface height 
  * format The surface format (_default_ cairo.Format.ARGB32) 
  * context [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The context information to give to the widget. (_default_ {dpi=96}) 


### Returns:

The cairo surface