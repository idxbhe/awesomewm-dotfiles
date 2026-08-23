# Class wibox.widget.textbox - awesome API documentation

**Module:** `classes.wibox.widget.textbox`  

> Source: [classes/wibox.widget.textbox.html](https://awesomewm.org/doc/api/classes/wibox.widget.textbox.html)

---

# Class `wibox.widget.textbox`

![Usage example](../images/AUTOGEN_wibox_widget_defaults_textbox.svg)

### Usage:
    
    wibox.widget{
        markup = 'This <i>is</i> a <b>textbox</b>!!!',
        align  = 'center',
        valign = 'center',
        widget = wibox.widget.textbox
    }
    


### Info:

  * **Copyright** : 2010, 2011 Uli Schlachter, dodo
  * **Author** : Uli Schlachter,dodo


## [Functions](<#Functions>)

[wibox.widget.textbox ([text=""[, ignore_markup=false]])](<#wibox.widget.textbox>) | Create a new textbox.  
---|---  
  
## [Object properties](<#Object_properties>)

[markup](<#wibox.widget.textbox.markup>) | Set the text of the textbox (with [Pango markup](<https://developer.gnome.org/pango/stable/PangoMarkupFormat.html>)).  
---|---  
[text](<#wibox.widget.textbox.text>) | Set a textbox' text.  
[ellipsize](<#wibox.widget.textbox.ellipsize>) | Set a textbox' ellipsize mode.  
[wrap](<#wibox.widget.textbox.wrap>) | Set a textbox' wrap mode.  
[valign](<#wibox.widget.textbox.valign>) | The textbox' vertical alignment  
[align](<#wibox.widget.textbox.align>) | Set a textbox' horizontal alignment.  
[font](<#wibox.widget.textbox.font>) | Set a textbox' font  
[forced_height](<#wibox.widget.textbox.forced_height>) | Force a widget height.  
[forced_width](<#wibox.widget.textbox.forced_width>) | Force a widget width.  
[opacity](<#wibox.widget.textbox.opacity>) | The widget opacity (transparency).  
[visible](<#wibox.widget.textbox.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.font](<#beautiful.font>) | The textbox font.  
---|---  
  
## [Methods](<#Methods>)

[wibox.widget.textbox:get_preferred_size (s)](<#wibox.widget.textbox:get_preferred_size>) | Get the preferred size of a textbox.  
---|---  
[wibox.widget.textbox:get_height_for_width (width, s)](<#wibox.widget.textbox:get_height_for_width>) | Get the preferred height of a textbox at a given width.  
[wibox.widget.textbox:get_preferred_size_at_dpi (dpi)](<#wibox.widget.textbox:get_preferred_size_at_dpi>) | Get the preferred size of a textbox.  
[wibox.widget.textbox:get_height_for_width_at_dpi (width, dpi)](<#wibox.widget.textbox:get_height_for_width_at_dpi>) | Get the preferred height of a textbox at a given width.  
[wibox.widget.textbox:set_markup_silently (text)](<#wibox.widget.textbox:set_markup_silently>) | Set the text of the textbox (with [Pango markup](<https://developer.gnome.org/pango/stable/PangoMarkupFormat.html>)).  
[wibox.widget.textbox:get_all_children ()](<#wibox.widget.textbox:get_all_children>) | Get all direct and indirect children widgets.  
[wibox.widget.textbox:setup (args)](<#wibox.widget.textbox:setup>) | Set a declarative widget hierarchy description.  
[wibox.widget.textbox:buttons (_buttons)](<#wibox.widget.textbox:buttons>) | Set/get a widget’s buttons.  
[wibox.widget.textbox:emit_signal_recursive (signal_name, ...)](<#wibox.widget.textbox:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[wibox.widget.textbox:emit_signal (name, ...)](<#wibox.widget.textbox:emit_signal>) | Emit a signal.  
[wibox.widget.textbox:connect_signal (name, func)](<#wibox.widget.textbox:connect_signal>) | Connect to a signal.  
[wibox.widget.textbox:weak_connect_signal (name, func)](<#wibox.widget.textbox:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**wibox.widget.textbox ([text=""[, ignore_markup=false]])**
     Create a new textbox. 

  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The textbox content (_default_ "") 
  * ignore_markup boolean Ignore the pango/HTML markup (_default_ false) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new textbox widget 


## Object properties

**markup**
     Set the text of the textbox (with [Pango markup](<https://developer.gnome.org/pango/stable/PangoMarkupFormat.html>)). 

### Type:

  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The text to set. This can contain pango markup (e.g. `<b>bold</b>`). You can use `gears.string.escape` to escape parts of it. 


### See also:

[text](<../classes/wibox.widget.textbox.html#wibox.widget.textbox.text>) 

**text**
     Set a textbox' text. 

### Type:

  * text The text to display. Pango markup is ignored and shown as-is. 


### See also:

[markup](<../classes/wibox.widget.textbox.html#wibox.widget.textbox.markup>) 

**ellipsize**
     Set a textbox' ellipsize mode. 

### Type:

  * mode Where should long lines be shortened? “start”, “middle” or “end”


**wrap**
     Set a textbox' wrap mode. 

### Type:

  * mode Where to wrap? After “word”, “char” or “word_char”


**valign**
     The textbox' vertical alignment 

### Type:

  * mode Where should the textbox be drawn? “top”, “center” or “bottom”


**align**
     Set a textbox' horizontal alignment. 

### Type:

  * mode Where should the textbox be drawn? “left”, “center” or “right”


**font**
     Set a textbox' font 

### Type:

  * font The font description as string 


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

**widget::layout_changed**
     When the layout (size) change. This signal is emitted when the previous results of `:layout()` and `:fit()` are no longer valid. Unless this signal is emitted, `:layout()` and `:fit()` must return the same result when called with the same arguments. 

### See also:

[widget::redraw_needed](<../classes/wibox.widget.textbox.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/wibox.widget.textbox.html#widget::layout_changed>) 

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


## Theme variables

**beautiful.font**
     The textbox font. 

## Methods

**wibox.widget.textbox:get_preferred_size (s)**
     Get the preferred size of a textbox. This returns the size that the textbox would use if infinite space were available. 

  * s integer or [screen](<../classes/screen.html#>) The screen on which the textbox will be displayed. 


### Returns:

  1. number The preferred width.
  2. number The preferred height.


**wibox.widget.textbox:get_height_for_width (width, s)**
     Get the preferred height of a textbox at a given width. This returns the height that the textbox would use when it is limited to the given width. 

  * width number The available width. 
  * s integer or [screen](<../classes/screen.html#>) The screen on which the textbox will be displayed. 


### Returns:

number The needed height. 

**wibox.widget.textbox:get_preferred_size_at_dpi (dpi)**
     Get the preferred size of a textbox. This returns the size that the textbox would use if infinite space were available. 

  * dpi number The DPI value to render at. 


### Returns:

  1. number The preferred width.
  2. number The preferred height.


**wibox.widget.textbox:get_height_for_width_at_dpi (width, dpi)**
     Get the preferred height of a textbox at a given width. This returns the height that the textbox would use when it is limited to the given width. 

  * width number The available width. 
  * dpi number The DPI value to render at. 


### Returns:

number The needed height. 

**wibox.widget.textbox:set_markup_silently (text)**
     Set the text of the textbox (with [Pango markup](<https://developer.gnome.org/pango/stable/PangoMarkupFormat.html>)). 

  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The text to set. This can contain pango markup (e.g. `<b>bold</b>`). You can use `gears.string.escape` to escape parts of it. 


### Returns:

boolean true 


### Or

  1. boolean false
  2. [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Error message explaining why the markup was invalid.


**wibox.widget.textbox:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**wibox.widget.textbox:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**wibox.widget.textbox:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**wibox.widget.textbox:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**wibox.widget.textbox:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**wibox.widget.textbox:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**wibox.widget.textbox:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.