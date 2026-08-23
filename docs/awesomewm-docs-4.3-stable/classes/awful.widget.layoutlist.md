# Class awful.widget.layoutlist - awesome API documentation

**Module:** `classes.awful.widget.layoutlist`  

> Source: [classes/awful.widget.layoutlist.html](https://awesomewm.org/doc/api/classes/awful.widget.layoutlist.html)

---

# Class `awful.widget.layoutlist`

Display the available client layouts for a screen.

This is what the layoutlist looks like by default with a vertical layout:

![Usage example](../images/AUTOGEN_awful_widget_layoutlist_default.svg)
    
    
    awful.popup {
        widget = awful.widget.layoutlist {
            screen      = 1,
            base_layout = wibox.layout.flex.vertical
        },
        maximum_height = #awful.layout.layouts * 24,
        minimum_height = #awful.layout.layouts * 24,
        placement      = awful.placement.centered,
    }
    

In the second example, it is shown how to create a popup in the center of the screen:

![Usage example](../images/AUTOGEN_awful_widget_layoutlist_popup.svg)
    
    
    local ll = awful.widget.layoutlist {
        base_layout = wibox.widget {
            spacing         = 5,
            forced_num_cols = 5,
            layout          = wibox.layout.grid.vertical,
        },
        widget_template = {
            {
                {
                    id            = 'icon_role',
                    forced_height = 22,
                    forced_width  = 22,
                    widget        = wibox.widget.imagebox,
                },
                margins = 4,
                widget  = wibox.container.margin,
            },
            id              = 'background_role',
            forced_width    = 24,
            forced_height   = 24,
            shape           = gears.shape.rounded_rect,
            widget          = wibox.container.background,
        },
    }
    
    local layout_popup = awful.popup {
        widget = wibox.widget {
            ll,
            margins = 4,
            widget  = wibox.container.margin,
        },
        border_color = beautiful.border_color,
        border_width = beautiful.border_width,
        placement    = awful.placement.centered,
        ontop        = true,
        visible      = false,
        shape        = gears.shape.rounded_rect
    }
    
    -- Make sure you remove the default Mod4+Space and Mod4+Shift+Space
    -- keybindings before adding this.
    awful.keygrabber {
        start_callback = function() layout_popup.visible = true  end,
        stop_callback  = function() layout_popup.visible = false end,
        export_keybindings = true,
        release_event = 'release',
        stop_key = {'Escape', 'Super_L', 'Super_R'},
        keybindings = {
            {{ modkey          } , ' ' , function()
                awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, 1))
            end},
            {{ modkey, 'Shift' } , ' ' , function()
                awful.layout.set(gears.table.iterate_value(ll.layouts, ll.current_layout, -1), nil)
            end},
        }
    }
    

This example extends ‘awful.widget.layoutbox’ to show a layout list popup:

![Usage example](../images/AUTOGEN_awful_widget_layoutlist_bar.svg)
    
    
    -- Normally you would use your existing bars, but for this example, we add one
    local lb = awful.widget.layoutbox(screen[1])
    local l = wibox.layout.align.horizontal(nil, lb, nil)
    l.expand = 'outside'
    awful.wibar { widget = l }
    
    local p = awful.popup {
        widget = wibox.widget {
            awful.widget.layoutlist {
                source      = awful.widget.layoutlist.source.default_layouts,
                screen      = 1,
                base_layout = wibox.widget {
                    spacing         = 5,
                    forced_num_cols = 3,
                    layout          = wibox.layout.grid.vertical,
                },
                widget_template = {
                    {
                        {
                            id            = 'icon_role',
                            forced_height = 22,
                            forced_width  = 22,
                            widget        = wibox.widget.imagebox,
                        },
                        margins = 4,
                        widget  = wibox.container.margin,
                    },
                    id              = 'background_role',
                    forced_width    = 24,
                    forced_height   = 24,
                    shape           = gears.shape.rounded_rect,
                    widget          = wibox.container.background,
                },
            },
            margins = 4,
            widget  = wibox.container.margin,
        },
        preferred_anchors = 'middle',
        border_color      = beautiful.border_color,
        border_width      = beautiful.border_width,
        shape             = gears.shape.infobubble,
    }
    p:bind_to_widget(lb)
    

This example shows how to add a layout subset to the default wibar:

![Usage example](../images/AUTOGEN_awful_widget_layoutlist_wibar.svg)
    
    
    wb:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            mytaglist,
            awful.widget.layoutlist {
                screen = 1,
                style = {
                    disable_name = true,
                    spacing      = 3,
                },
                source = function() return {
                    awful.layout.suit.floating,
                    awful.layout.suit.tile,
                    awful.layout.suit.tile.left,
                    awful.layout.suit.tile.bottom,
                    awful.layout.suit.tile.top,
                } end
            },
            layout = wibox.layout.fixed.horizontal,
        },
        mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            mytextclock,
            mylayoutbox,
        },
    }
    

### Info:

  * **Copyright** : 2010, 2018 Emmanuel Lepage Vallee
  * **Author** : Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.widget.layoutlist (args)](<#awful.widget.layoutlist>) | Create a layout list.  
---|---  
  
## [Object properties](<#Object_properties>)

[base_layout](<#awful.widget.layoutlist.base_layout>) | The layoutlist default widget layout.  
---|---  
[widget_template](<#awful.widget.layoutlist.widget_template>) | The delegate widget template.  
[screen](<#awful.widget.layoutlist.screen>) | The layoutlist screen.  
[source](<#awful.widget.layoutlist.source>) | A function that returns the list of layout to display.  
[filter](<#awful.widget.layoutlist.filter>) | The layoutlist filter function.  
[buttons](<#awful.widget.layoutlist.buttons>) | The layoutlist buttons.  
[layouts](<#awful.widget.layoutlist.layouts>) | The currenly displayed layouts.  
[current_layout](<#awful.widget.layoutlist.current_layout>) | The currently selected layout.  
[forced_height](<#awful.widget.layoutlist.forced_height>) | Force a widget height.  
[forced_width](<#awful.widget.layoutlist.forced_width>) | Force a widget width.  
[opacity](<#awful.widget.layoutlist.opacity>) | The widget opacity (transparency).  
[visible](<#awful.widget.layoutlist.visible>) | The widget visibility.  
  
## [Signals](<#Signals>)

[widget::layout_changed](<#widget::layout_changed>) | When the layout (size) change.  
---|---  
[widget::redraw_needed](<#widget::redraw_needed>) | When the widget content changed.  
[button::press](<#button::press>) | When a mouse button is pressed over the widget.  
[button::release](<#button::release>) | When a mouse button is released over the widget.  
[mouse::enter](<#mouse::enter>) | When the mouse enter a widget.  
[mouse::leave](<#mouse::leave>) | When the mouse leave a widget.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.layoutlist_fg_normal](<#beautiful.layoutlist_fg_normal>) | The default foreground (text) color.  
---|---  
[beautiful.layoutlist_bg_normal](<#beautiful.layoutlist_bg_normal>) | The default background color.  
[beautiful.layoutlist_fg_selected](<#beautiful.layoutlist_fg_selected>) | The selected layout foreground (text) color.  
[beautiful.layoutlist_bg_selected](<#beautiful.layoutlist_bg_selected>) | The selected layout background color.  
[beautiful.layoutlist_disable_icon](<#beautiful.layoutlist_disable_icon>) | Disable the layout icons (only show the name label).  
[beautiful.layoutlist_disable_name](<#beautiful.layoutlist_disable_name>) | Disable the layout name label (only show the icon).  
[beautiful.layoutlist_font](<#beautiful.layoutlist_font>) | The layoutlist font.  
[beautiful.layoutlist_align](<#beautiful.layoutlist_align>) | The selected layout alignment.  
[beautiful.layoutlist_font_selected](<#beautiful.layoutlist_font_selected>) | The selected layout title font.  
[beautiful.layoutlist_spacing](<#beautiful.layoutlist_spacing>) | The space between the layouts.  
[beautiful.layoutlist_shape](<#beautiful.layoutlist_shape>) | The default layoutlist elements shape.  
[beautiful.layoutlist_shape_border_width](<#beautiful.layoutlist_shape_border_width>) | The default layoutlist elements border width.  
[beautiful.layoutlist_shape_border_color](<#beautiful.layoutlist_shape_border_color>) | The default layoutlist elements border color.  
[beautiful.layoutlist_shape_selected](<#beautiful.layoutlist_shape_selected>) | The selected layout shape.  
[beautiful.layoutlist_shape_border_width_selected](<#beautiful.layoutlist_shape_border_width_selected>) | The selected layout border width.  
[beautiful.layoutlist_shape_border_color_selected](<#beautiful.layoutlist_shape_border_color_selected>) | The selected layout border color.  
  
## [List source functions](<#List_source_functions>)

[awful.widget.layoutlist.source.for_screen](<#awful.widget.layoutlist.source.for_screen>) | The layout list for the first selected tag of a screen.  
---|---  
[awful.widget.layoutlist.source.current_screen](<#awful.widget.layoutlist.source.current_screen>) | The layouts available for the first selected tag of `awful.screen.focused()`.  
[awful.widget.layoutlist.source.default_layouts](<#awful.widget.layoutlist.source.default_layouts>) | The default layout list.  
  
## [Methods](<#Methods>)

[awful.widget.layoutlist:get_all_children ()](<#awful.widget.layoutlist:get_all_children>) | Get all direct and indirect children widgets.  
---|---  
[awful.widget.layoutlist:setup (args)](<#awful.widget.layoutlist:setup>) | Set a declarative widget hierarchy description.  
[awful.widget.layoutlist:buttons (_buttons)](<#awful.widget.layoutlist:buttons>) | Set/get a widget’s buttons.  
[awful.widget.layoutlist:emit_signal_recursive (signal_name, ...)](<#awful.widget.layoutlist:emit_signal_recursive>) | Emit a signal and ensure all parent widgets in the hierarchies also forward the signal.  
[awful.widget.layoutlist:emit_signal (name, ...)](<#awful.widget.layoutlist:emit_signal>) | Emit a signal.  
[awful.widget.layoutlist:connect_signal (name, func)](<#awful.widget.layoutlist:connect_signal>) | Connect to a signal.  
[awful.widget.layoutlist:weak_connect_signal (name, func)](<#awful.widget.layoutlist:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**awful.widget.layoutlist (args)**
     Create a layout list. 

  * args
    * layout widget The widget layout (not to be confused with client layout). 
    * buttons [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The list of `awful.buttons`. (_default_ nil) 
    * source function A function to generate the list of layouts. (_default_ awful.widget.layoutlist.source.for_screen) 
    * widget_template [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A custom widget to be used for each action. (_optional_) 
    * screen [screen](<../classes/screen.html#>) A screen (_default_ ascreen.focused()) 
    * buttons [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The list of `awful.buttons`. (_default_ nil) 
    * style [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Extra look and feel parameters (_default_ {}) 
    * style.disable_icon boolean
    * style.disable_name boolean
    * style.fg_normal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern
    * style.bg_normal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern
    * style.fg_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern
    * style.bg_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern
    * style.font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
    * style.font_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
    * style.align [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) _left_ , _right_ or _center_
    * style.spacing number
    * style.shape gears.shape
    * style.shape_border_width number
    * style.shape_border_color [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern
    * style.shape_selected gears.shape
    * style.shape_border_width_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern
    * style.shape_border_color_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern


### Returns:

widget The action widget. 


## Object properties

**base_layout**
     The layoutlist default widget layout. If no layout is specified, a [wibox.layout.fixed.vertical](<../classes/wibox.layout.fixed.html#wibox.layout.fixed.vertical>) will be created automatically. 

### Type:

  * widget


### See also:

  * [wibox.layout.fixed.vertical](<../classes/wibox.layout.fixed.html#wibox.layout.fixed.vertical>)
  * [base_layout](<../classes/awful.widget.layoutlist.html#awful.widget.layoutlist.base_layout>)


**widget_template**
     The delegate widget template. 

### Type:

  * table


**screen**
     The layoutlist screen. 

### Type:

  * screen


**source**
     A function that returns the list of layout to display. 

### Type:

  * function (_default_ awful.widget.layoutlist.source.for_screen) 


**filter**
     The layoutlist filter function. 

### Type:

  * function (_default_ awful.widget.layoutlist.source.for_screen) 


**buttons**
    

The layoutlist buttons.

The default is:
    
    
    gears.table.join(
        awful.button({ }, 1, awful.layout.set)
    )
    

### Type:

  * table


**layouts**
     The currenly displayed layouts. 

### Type:

  * table


**current_layout**
     The currently selected layout. 

### Type:

  * layout


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

[widget::redraw_needed](<../classes/awful.widget.layoutlist.html#widget::redraw_needed>) 

**widget::redraw_needed**
     When the widget content changed. This signal is emitted when the content of the widget changes. The widget will be redrawn, it is not re-layouted. Put differently, it is assumed that `:layout()` and `:fit()` would still return the same results as before. 

### See also:

[widget::layout_changed](<../classes/awful.widget.layoutlist.html#widget::layout_changed>) 

**button::press**
     When a mouse button is pressed over the widget. 

### Arguments:

  * lx number The horizontal position relative to the (0,0) position in the widget. 
  * ly number The vertical position relative to the (0,0) position in the widget. 
  * button number The button number. 
  * mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifiers (mod4, mod1 (alt), Control, Shift) 
  * find_widgets_result The entry from the result of [wibox.drawable:find_widgets](<../classes/wibox.drawable.html#wibox.drawable:find_widgets>) for the position that the mouse hit. 
    * drawable [wibox.drawable](<../classes/wibox.drawable.html#>) The drawable containing the widget. 
    * widget widget The widget being displayed. 
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
    * widget widget The widget being displayed. 
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
    * widget widget The widget being displayed. 
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
    * widget widget The widget being displayed. 
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

**beautiful.layoutlist_fg_normal**
     The default foreground (text) color. 

### Type:

  * fg_normal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.layoutlist_bg_normal**
     The default background color. 

### Type:

  * bg_normal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.layoutlist_fg_selected**
     The selected layout foreground (text) color. 

### Type:

  * fg_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.layoutlist_bg_selected**
     The selected layout background color. 

### Type:

  * bg_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.layoutlist_disable_icon**
     Disable the layout icons (only show the name label). 

### Type:

  * layoutlist_disable_icon boolean (_default_ false) 


**beautiful.layoutlist_disable_name**
     Disable the layout name label (only show the icon). 

### Type:

  * layoutlist_disable_name boolean (_default_ false) 


**beautiful.layoutlist_font**
     The layoutlist font. 

### Type:

  * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ nil) 


**beautiful.layoutlist_align**
     The selected layout alignment. 

### Type:

  * align [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) _left_ , _right_ or _center_ (_default_ left) 


**beautiful.layoutlist_font_selected**
     The selected layout title font. 

### Type:

  * font_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ nil) 


**beautiful.layoutlist_spacing**
     The space between the layouts. 

### Type:

  * spacing number The spacing between tasks. (_default_ 0) 


**beautiful.layoutlist_shape**
     The default layoutlist elements shape. 

### Type:

  * shape gears.shape (_default_ nil) 


**beautiful.layoutlist_shape_border_width**
     The default layoutlist elements border width. 

### Type:

  * shape_border_width number (_default_ 0) 


**beautiful.layoutlist_shape_border_color**
     The default layoutlist elements border color. 

### Type:

  * shape_border_color [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or color (_default_ nil) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.layoutlist_shape_selected**
     The selected layout shape. 

### Type:

  * shape_selected gears.shape (_default_ nil) 


**beautiful.layoutlist_shape_border_width_selected**
     The selected layout border width. 

### Type:

  * shape_border_width_selected number (_default_ 0) 


**beautiful.layoutlist_shape_border_color_selected**
     The selected layout border color. 

### Type:

  * shape_border_color_selected [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or color (_default_ nil) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 


## List source functions

**awful.widget.layoutlist.source.for_screen**
     The layout list for the first selected tag of a screen. 

  * s [screen](<../classes/screen.html#>) The screen. 


**awful.widget.layoutlist.source.current_screen**
     The layouts available for the first selected tag of `awful.screen.focused()`. 
**awful.widget.layoutlist.source.default_layouts**
     The default layout list. 

### See also:

[awful.layout.layouts](<../libraries/awful.layout.html#layouts>) 


## Methods

**awful.widget.layoutlist:get_all_children ()**
     Get all direct and indirect children widgets. This will scan all containers recursively to find widgets Warning: This method it prone to stack overflow id the widget, or any of its children, contain (directly or indirectly) itself. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The children 

**awful.widget.layoutlist:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**awful.widget.layoutlist:buttons (_buttons)**
     Set/get a widget’s buttons. 

  * _buttons The table of buttons that should bind to the widget. 


**awful.widget.layoutlist:emit_signal_recursive (signal_name, ...)**
     Emit a signal and ensure all parent widgets in the hierarchies also forward the signal. This is useful to track signals when there is a dynamic set of containers and layouts wrapping the widget. 

  * signal_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * ... Other arguments 


**awful.widget.layoutlist:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**awful.widget.layoutlist:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**awful.widget.layoutlist:weak_connect_signal (name, func)**
     Connect to a signal weakly.

This allows the callback function to be garbage collected and automatically disconnects the signal when that happens.

**Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.