# Class awful.popup - awesome API documentation

**Module:** `classes.awful.popup`  

> Source: [classes/awful.popup.html](https://awesomewm.org/doc/api/classes/awful.popup.html)

---

# Class `awful.popup`

An auto-resized, free floating or modal wibox built around a widget.

This type of widget box (wibox) is auto closed when being clicked on and is automatically resized to the size of its main widget.

Note that the widget itself should have a finite size. If something like a [wibox.layout.flex](<../classes/wibox.layout.flex.html#>) is used, then the size would be unlimited and an error will be printed. The [wibox.layout.fixed](<../classes/wibox.layout.fixed.html#>), [wibox.container.constraint](<../classes/wibox.container.constraint.html#>), `forced_width` and `forced_height` are recommended.

![Usage example](../images/AUTOGEN_awful_popup_simple.svg)
    
    
    awful.popup {
        widget = {
            {
                {
                    text   = 'foobar',
                    widget = wibox.widget.textbox
                },
                {
                    {
                        text   = 'foobar',
                        widget = wibox.widget.textbox
                    },
                    bg     = '#ff00ff',
                    clip   = true,
                    shape  = gears.shape.rounded_bar,
                    widget = wibox.widget.background
                },
                {
                    value         = 0.5,
                    forced_height = 30,
                    forced_width  = 100,
                    widget        = wibox.widget.progressbar
                },
                layout = wibox.layout.fixed.vertical,
            },
            margins = 10,
            widget  = wibox.container.margin
        },
        border_color = '#00ff00',
        border_width = 5,
        placement    = awful.placement.top_left,
        shape        = gears.shape.rounded_rect,
        visible      = true,
    }
    

Here is an example of how to create an alt-tab like dialog by leveraging the [awful.widget.tasklist](<../classes/awful.widget.tasklist.html#>).

![Usage example](../images/AUTOGEN_awful_popup_alttab.svg)
    
    
    awful.popup {
        widget = awful.widget.tasklist {
            screen   = screen[1],
            filter   = awful.widget.tasklist.filter.allscreen,
            buttons  = tasklist_buttons,
            style    = {
                shape = gears.shape.rounded_rect,
            },
            layout   = {
                spacing = 5,
                forced_num_rows = 2,
                layout = wibox.layout.grid.horizontal
            },
            widget_template = {
                {
                    {
                        id     = 'clienticon',
                        widget = awful.widget.clienticon,
                    },
                    margins = 4,
                    widget  = wibox.container.margin,
                },
                id              = 'background_role',
                forced_width    = 48,
                forced_height   = 48,
                widget          = wibox.container.background,
                create_callback = function(self, c, index, objects) --luacheck: no unused
                    self:get_children_by_id('clienticon')[1].client = c
                end,
            },
        },
        border_color = '#777777',
        border_width = 2,
        ontop        = true,
        placement    = awful.placement.centered,
        shape        = gears.shape.rounded_rect
    }
    

### Info:

  * **Copyright** : 2016 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee


## [Functions](<#Functions>)

[awful.popup ([args=nil])](<#awful.popup>) | Create a new popup build around a passed in widget.  
---|---  
  
## [Object properties](<#Object_properties>)

[preferred_positions](<#awful.popup.preferred_positions>) | Set the preferred popup position relative to its parent.  
---|---  
[preferred_anchors](<#awful.popup.preferred_anchors>) | Set the preferred popup anchors relative to the parent.  
[current_position](<#awful.popup.current_position>) | The current position relative to the parent object.  
[current_anchor](<#awful.popup.current_anchor>) | Get the current anchor relative to the parent object.  
[hide_on_right_click](<#awful.popup.hide_on_right_click>) | Hide the popup when right clicked.  
[minimum_width](<#awful.popup.minimum_width>) | The popup minimum width.  
[minimum_height](<#awful.popup.minimum_height>) | The popup minimum height.  
[maxmimum_width](<#awful.popup.maxmimum_width>) | The popup minimum width.  
[maximum_height](<#awful.popup.maximum_height>) | The popup maximum height.  
[offset](<#awful.popup.offset>) | The distance between the popup and its parent (if any).  
[placement](<#awful.popup.placement>) | Set the placement function.  
[border_width](<#awful.popup.border_width>) | Border width.  
[border_color](<#awful.popup.border_color>) | Border color.  
[ontop](<#awful.popup.ontop>) | On top of other windows.  
[cursor](<#awful.popup.cursor>) | The mouse cursor.  
[visible](<#awful.popup.visible>) | Visibility.  
[opacity](<#awful.popup.opacity>) | The opacity of the wibox, between 0 and 1.  
[type](<#awful.popup.type>) | The window type (desktop, normal, dock, …).  
[x](<#awful.popup.x>) | The x coordinates.  
[y](<#awful.popup.y>) | The y coordinates.  
[width](<#awful.popup.width>) | The width of the wibox.  
[height](<#awful.popup.height>) | The height of the wibox.  
[screen](<#awful.popup.screen>) | The wibox screen.  
[drawable](<#awful.popup.drawable>) | The wibox’s [drawable](<../classes/drawable.html#>).  
[widget](<#awful.popup.widget>) | The widget that the [wibox](<../classes/wibox.html#>) displays.  
[window](<#awful.popup.window>) | The X window id.  
[shape_bounding](<#awful.popup.shape_bounding>) | The wibox’s bounding shape as a (native) cairo surface.  
[shape_clip](<#awful.popup.shape_clip>) | The wibox’s clip shape as a (native) cairo surface.  
[shape_input](<#awful.popup.shape_input>) | The wibox’s input shape as a (native) cairo surface.  
[shape](<#awful.popup.shape>) | The wibar’s shape.  
[input_passthrough](<#awful.popup.input_passthrough>) | Forward the inputs to the client below the wibox.  
[bg](<#awful.popup.bg>) | The background of the wibox.  
[bgimage](<#awful.popup.bgimage>) | The background image of the drawable.  
[fg](<#awful.popup.fg>) | The foreground (text) of the wibox.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.bg_normal](<#beautiful.bg_normal>) | The default background color.  
---|---  
[beautiful.fg_normal](<#beautiful.fg_normal>) | The default foreground (text) color.  
  
## [Methods](<#Methods>)

[awful.popup:move_next_to ([obj=mouse])](<#awful.popup:move_next_to>) | Move the wibox to a position relative to `geo`.  
---|---  
[awful.popup:bind_to_widget (widget[, button=1])](<#awful.popup:bind_to_widget>) | Bind the popup to a widget button press.  
[awful.popup:unbind_to_widget (widget)](<#awful.popup:unbind_to_widget>) | Unbind the popup from a widget button.  
[awful.popup:buttons (buttons_table)](<#awful.popup:buttons>) | Get or set mouse buttons bindings to a wibox.  
[awful.popup:geometry (A)](<#awful.popup:geometry>) | Get or set wibox geometry.  
[awful.popup:struts (strut)](<#awful.popup:struts>) | Get or set wibox struts.  
[awful.popup:setup (args)](<#awful.popup:setup>) | Set a declarative widget hierarchy description.  
[awful.popup:find_widgets (x, y)](<#awful.popup:find_widgets>) | Find a widget by a point.  
  
  


## Functions

Methods 

**awful.popup ([args=nil])**
     Create a new popup build around a passed in widget. 

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
    * placement function The [awful.placement](<../libraries/awful.placement.html#>) function 
    * preferred_positions [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>)
    * preferred_anchors [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>)
    * offset [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or number The X and Y offset compared to the parent object 
    * hide_on_right_click boolean Whether or not to hide the popup on right clicks. 


## Object properties

**preferred_positions**
    

Set the preferred popup position relative to its parent.

This allows, for example, to have a submenu that goes on the right of the parent menu. If there is no space on the right, it tries on the left and so on.

Valid directions are:

  * left
  * right
  * top
  * bottom


The basic use case for this method is to give it a parent wibox:

![Usage example](../images/AUTOGEN_awful_popup_position1.svg)
    
    
    for _, v in ipairs {'left', 'right', 'bottom', 'top'} do
        local p2 = awful.popup {
            widget = wibox.widget {
                text   = 'On the '..v,
                widget = wibox.widget.textbox
            },
            border_color        = '#777777',
            border_width        = 2,
            preferred_positions = v,
            ontop               = true,
        }
        p2:move_next_to(p)
    end
    

As demonstrated by this second example, it is also possible to use a widget as a parent object:

![Usage example](../images/AUTOGEN_awful_popup_position2.svg)
    
    
    for _, v in ipairs {'left', 'right'} do
        local p2 = awful.popup {
            widget = wibox.widget {
                text = 'On the '..v,
                forced_height = 100,
                widget = wibox.widget.textbox
            },
            border_color  = '#0000ff',
            preferred_positions = v,
            border_width  = 2,
        }
        p2:move_next_to(textboxinstance, v)
    end
    

### Type:

  * preferred_positions [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A position name or an ordered table of positions 


### See also:

  * [awful.placement.next_to](<../libraries/awful.placement.html#next_to>)
  * [awful.popup.preferred_anchors](<../classes/awful.popup.html#awful.popup.preferred_anchors>)


**preferred_anchors**
    

Set the preferred popup anchors relative to the parent.

The possible values are:

  * front
  * middle
  * back


For details information, see the [awful.placement.next_to](<../libraries/awful.placement.html#next_to>) documentation.

In this example, it is possible to see the effect of having a fallback preferred anchors when the popup would otherwise not fit:

![Usage example](../images/AUTOGEN_awful_popup_anchors.svg)
    
    
     local p2 = awful.popup {
         widget = wibox.widget {
             text   = 'A popup',
             forced_height = 100,
             widget = wibox.widget.textbox
         },
         border_color        = '#777777',
         border_width        = 2,
         preferred_positions = 'right',
         preferred_anchors   = {'front', 'back'},
     }
     local p4 = awful.popup {
         widget = wibox.widget {
             text   = 'A popup2',
             forced_height = 100,
             widget = wibox.widget.textbox
         },
         border_color        = '#777777',
         border_width        = 2,
         preferred_positions = 'right',
         preferred_anchors   = {'front', 'back'},
     }
    

### Type:

  * preferred_anchors [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Either a single anchor name or a table ordered by priority. 


### See also:

  * [awful.placement.next_to](<../libraries/awful.placement.html#next_to>)
  * [awful.popup.preferred_positions](<../classes/awful.popup.html#awful.popup.preferred_positions>)


**current_position**
     The current position relative to the parent object.

If there is a parent object (widget, wibox, wibar, client or the mouse), then this property returns the current position. This is determined using [preferred_positions](<../classes/awful.popup.html#awful.popup.preferred_positions>). It is usually the preferred position, but when there isn’t enough space, it can also be one of the fallback. 

### Type:

  * current_position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Either “left”, “right”, “top” or “bottom”


**current_anchor**
     Get the current anchor relative to the parent object.

If there is a parent object (widget, wibox, wibar, client or the mouse), then this property returns the current anchor. The anchor is the “side” of the parent object on which the popup is based on. It will “grow” in the opposite direction from the anchor. 

### Type:

  * current_anchor [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Either “front”, “middle”, “back”


**hide_on_right_click**
     Hide the popup when right clicked. 

### Type:

  * hide_on_right_click boolean (_default_ false) 


**minimum_width**
     The popup minimum width. 

### Type:

  * The number minimum width (_default_ 1) 


**minimum_height**
     The popup minimum height. 

### Type:

  * The number minimum height (_default_ 1) 


**maxmimum_width**
     The popup minimum width. 

### Type:

  * The number maxmimum width (_default_ 1) 


**maximum_height**
     The popup maximum height. 

### Type:

  * The number maximum height (_default_ 1) 


**offset**
    

The distance between the popup and its parent (if any).

Here is an example of 5 popups stacked one below the other with an y axis offset (spacing).

![Usage example](../images/AUTOGEN_awful_popup_position3.svg)
    
    
    local previous = nil
    for i=1, 5 do
        local p2 = awful.popup {
            widget = wibox.widget {
                text   = 'Hello world!  '..i..'  aaaa.',
                widget = wibox.widget.textbox
            },
            border_color        = beautiful.border_color,
            preferred_positions = 'bottom',
            border_width        = 2,
            preferred_anchors   = 'back',
            placement           = (not previous) and awful.placement.top or nil,
            offset = {
                 y = 10,
            },
        }
        p2:move_next_to(previous)
        previous = p2
    end
    

### Type:

  * offset An integer value or a `{x=, y=}` table. 
    * x number The horizontal distance. (_default_ offset) 
    * y number The vertical distance. (_default_ offset) 


**placement**
     Set the placement function. 

### Type:

  * The function, [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or boolean placement function or name (or false to disable placement) (_default_ next_to) 
  * function


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

This replace the [shape_input](<../classes/awful.popup.html#awful.popup.shape_input>) mask with an empty area. All mouse and keyboard events are sent to the object (such as a client) positioned below this wibox. When used alongside compositing, it allows, for example, to have a subtle transparent wibox on top a fullscreen client to display important data such as a low battery warning.

**Signal:**

  * _property::input_passthrough_


### Type:

  * boolean (_default_ false) 


### See also:

[shape_input](<../classes/awful.popup.html#awful.popup.shape_input>) 

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

[bg](<../classes/awful.popup.html#awful.popup.bg>) 

**beautiful.fg_normal**
     The default foreground (text) color. 

### See also:

[fg](<../classes/awful.popup.html#awful.popup.fg>) 


## Methods

**awful.popup:move_next_to ([obj=mouse])**
     Move the wibox to a position relative to `geo`. This will try to avoid overlapping the source wibox and auto-detect the right direction to avoid going off-screen. 

  * obj An object such as a wibox, client or a table entry returned by `wibox:find_widgets()`. (_default_ mouse) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new geometry 


### See also:

  * [awful.placement.next_to](<../libraries/awful.placement.html#next_to>)
  * [awful.popup.preferred_positions](<../classes/awful.popup.html#awful.popup.preferred_positions>)
  * [awful.popup.preferred_anchors](<../classes/awful.popup.html#awful.popup.preferred_anchors>)


**awful.popup:bind_to_widget (widget[, button=1])**
     Bind the popup to a widget button press. 

  * widget [widget](<../classes/awful.popup.html#awful.popup.widget>) The widget 
  * button number The button index (_default_ 1) 


**awful.popup:unbind_to_widget (widget)**
     Unbind the popup from a widget button. 

  * widget [widget](<../classes/awful.popup.html#awful.popup.widget>) The widget 


**awful.popup:buttons (buttons_table)**
     Get or set mouse buttons bindings to a wibox. 

  * buttons_table A table of buttons objects, or nothing. 


**awful.popup:geometry (A)**
     Get or set wibox geometry. That’s the same as accessing or setting the x, y, width or height properties of a wibox. 

  * A table with coordinates to modify. 


### Returns:

A table with wibox coordinates and geometry. 

**awful.popup:struts (strut)**
     Get or set wibox struts. 

  * strut A table with new strut, or nothing 


### Returns:

The wibox strut in a table. 


### See also:

[client.struts](<../classes/client.html#client:struts>) 

**awful.popup:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**awful.popup:find_widgets (x, y)**
     Find a widget by a point. The wibox must have drawn itself at least once for this to work. 

  * x number X coordinate of the point 
  * y number Y coordinate of the point 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A sorted table of widgets positions. The first element is the biggest container while the last is the topmost widget. The table contains _x_ , _y_ , _width_ , _height_ and _widget_.