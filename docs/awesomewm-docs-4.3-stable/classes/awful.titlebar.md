# Class awful.titlebar - awesome API documentation

**Module:** `classes.awful.titlebar`  

> Source: [classes/awful.titlebar.html](https://awesomewm.org/doc/api/classes/awful.titlebar.html)

---

# Class `awful.titlebar`

Titlebars for awful.

**Create a titlebar:**

This example reproduces what the default [rc.lua](<../sample files/rc.lua.html#>) does. It shows how to handle the titlebars on a lower level.

![Usage example](../images/AUTOGEN_awful_titlebar_default.svg)
    
    
    -- Create a titlebar for the client.
    -- By default, [awful.rules](<../libraries/awful.rules.html#>) will create one, but all it does is to call this
    -- function.
    local top_titlebar = awful.titlebar(c, {
        height    = 20,
        bg_normal = '#ff0000',
    })
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )
    top_titlebar : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = 'center',
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
    

### Info:

  * **Copyright** : 2012 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[awful.titlebar (c[, args={}])](<#awful.titlebar>) | Get a client’s titlebar.  
---|---  
[titlebar.widget.titlewidget (c)](<#titlebar.widget.titlewidget>) | Create a new titlewidget.  
[titlebar.widget.iconwidget (c)](<#titlebar.widget.iconwidget>) | Create a new icon widget.  
[titlebar.widget.button (c, name, selector, action)](<#titlebar.widget.button>) | Create a new button widget.  
[titlebar.widget.floatingbutton (c)](<#titlebar.widget.floatingbutton>) | Create a new float button for a client.  
[titlebar.widget.maximizedbutton (c)](<#titlebar.widget.maximizedbutton>) | Create a new maximize button for a client.  
[titlebar.widget.minimizebutton (c)](<#titlebar.widget.minimizebutton>) | Create a new minimize button for a client.  
[titlebar.widget.closebutton (c)](<#titlebar.widget.closebutton>) | Create a new closing button for a client.  
[titlebar.widget.ontopbutton (c)](<#titlebar.widget.ontopbutton>) | Create a new ontop button for a client.  
[titlebar.widget.stickybutton (c)](<#titlebar.widget.stickybutton>) | Create a new sticky button for a client.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.titlebar_fg_normal](<#beautiful.titlebar_fg_normal>) | The titlebar foreground (text) color.  
---|---  
[beautiful.titlebar_bg_normal](<#beautiful.titlebar_bg_normal>) | The titlebar background color.  
[beautiful.titlebar_bgimage_normal](<#beautiful.titlebar_bgimage_normal>) | The titlebar background image image.  
[beautiful.titlebar_fg](<#beautiful.titlebar_fg>) | The titlebar foreground (text) color.  
[beautiful.titlebar_bg](<#beautiful.titlebar_bg>) | The titlebar background color.  
[beautiful.titlebar_bgimage](<#beautiful.titlebar_bgimage>) | The titlebar background image image.  
[beautiful.titlebar_fg_focus](<#beautiful.titlebar_fg_focus>) | The focused titlebar foreground (text) color.  
[beautiful.titlebar_bg_focus](<#beautiful.titlebar_bg_focus>) | The focused titlebar background color.  
[beautiful.titlebar_bgimage_focus](<#beautiful.titlebar_bgimage_focus>) | The focused titlebar background image image.  
[beautiful.titlebar_floating_button_normal](<#beautiful.titlebar_floating_button_normal>) | floating_button_normal.  
[beautiful.titlebar_maximized_button_normal](<#beautiful.titlebar_maximized_button_normal>) | maximized_button_normal.  
[beautiful.titlebar_minimize_button_normal](<#beautiful.titlebar_minimize_button_normal>) | minimize_button_normal.  
[beautiful.titlebar_minimize_button_normal_hover](<#beautiful.titlebar_minimize_button_normal_hover>) | minimize_button_normal_hover.  
[beautiful.titlebar_minimize_button_normal_press](<#beautiful.titlebar_minimize_button_normal_press>) | minimize_button_normal_press.  
[beautiful.titlebar_close_button_normal](<#beautiful.titlebar_close_button_normal>) | close_button_normal.  
[beautiful.titlebar_close_button_normal_hover](<#beautiful.titlebar_close_button_normal_hover>) | close_button_normal_hover.  
[beautiful.titlebar_close_button_normal_press](<#beautiful.titlebar_close_button_normal_press>) | close_button_normal_press.  
[beautiful.titlebar_ontop_button_normal](<#beautiful.titlebar_ontop_button_normal>) | ontop_button_normal.  
[beautiful.titlebar_sticky_button_normal](<#beautiful.titlebar_sticky_button_normal>) | sticky_button_normal.  
[beautiful.titlebar_floating_button_focus](<#beautiful.titlebar_floating_button_focus>) | floating_button_focus.  
[beautiful.titlebar_maximized_button_focus](<#beautiful.titlebar_maximized_button_focus>) | maximized_button_focus.  
[beautiful.titlebar_minimize_button_focus](<#beautiful.titlebar_minimize_button_focus>) | minimize_button_focus.  
[beautiful.titlebar_minimize_button_focus_hover](<#beautiful.titlebar_minimize_button_focus_hover>) | minimize_button_focus_hover.  
[beautiful.titlebar_minimize_button_focus_press](<#beautiful.titlebar_minimize_button_focus_press>) | minimize_button_focus_press.  
[beautiful.titlebar_close_button_focus](<#beautiful.titlebar_close_button_focus>) | close_button_focus.  
[beautiful.titlebar_close_button_focus_hover](<#beautiful.titlebar_close_button_focus_hover>) | close_button_focus_hover.  
[beautiful.titlebar_close_button_focus_press](<#beautiful.titlebar_close_button_focus_press>) | close_button_focus_press.  
[beautiful.titlebar_ontop_button_focus](<#beautiful.titlebar_ontop_button_focus>) | ontop_button_focus.  
[beautiful.titlebar_sticky_button_focus](<#beautiful.titlebar_sticky_button_focus>) | sticky_button_focus.  
[beautiful.titlebar_floating_button_normal_active](<#beautiful.titlebar_floating_button_normal_active>) | floating_button_normal_active.  
[beautiful.titlebar_floating_button_normal_active_hover](<#beautiful.titlebar_floating_button_normal_active_hover>) | floating_button_normal_active_hover.  
[beautiful.titlebar_floating_button_normal_active_press](<#beautiful.titlebar_floating_button_normal_active_press>) | floating_button_normal_active_press.  
[beautiful.titlebar_maximized_button_normal_active](<#beautiful.titlebar_maximized_button_normal_active>) | maximized_button_normal_active.  
[beautiful.titlebar_maximized_button_normal_active_hover](<#beautiful.titlebar_maximized_button_normal_active_hover>) | maximized_button_normal_active_hover.  
[beautiful.titlebar_maximized_button_normal_active_press](<#beautiful.titlebar_maximized_button_normal_active_press>) | maximized_button_normal_active_press.  
[beautiful.titlebar_ontop_button_normal_active](<#beautiful.titlebar_ontop_button_normal_active>) | ontop_button_normal_active.  
[beautiful.titlebar_ontop_button_normal_active_hover](<#beautiful.titlebar_ontop_button_normal_active_hover>) | ontop_button_normal_active_hover.  
[beautiful.titlebar_ontop_button_normal_active_press](<#beautiful.titlebar_ontop_button_normal_active_press>) | ontop_button_normal_active_press.  
[beautiful.titlebar_sticky_button_normal_active](<#beautiful.titlebar_sticky_button_normal_active>) | sticky_button_normal_active.  
[beautiful.titlebar_sticky_button_normal_active_hover](<#beautiful.titlebar_sticky_button_normal_active_hover>) | sticky_button_normal_active_hover.  
[beautiful.titlebar_sticky_button_normal_active_press](<#beautiful.titlebar_sticky_button_normal_active_press>) | sticky_button_normal_active_press.  
[beautiful.titlebar_floating_button_focus_active](<#beautiful.titlebar_floating_button_focus_active>) | floating_button_focus_active.  
[beautiful.titlebar_floating_button_focus_active_hover](<#beautiful.titlebar_floating_button_focus_active_hover>) | floating_button_focus_active_hover.  
[beautiful.titlebar_floating_button_focus_active_press](<#beautiful.titlebar_floating_button_focus_active_press>) | floating_button_focus_active_press.  
[beautiful.titlebar_maximized_button_focus_active](<#beautiful.titlebar_maximized_button_focus_active>) | maximized_button_focus_active.  
[beautiful.titlebar_maximized_button_focus_active_hover](<#beautiful.titlebar_maximized_button_focus_active_hover>) | maximized_button_focus_active_hover.  
[beautiful.titlebar_maximized_button_focus_active_press](<#beautiful.titlebar_maximized_button_focus_active_press>) | maximized_button_focus_active_press.  
[beautiful.titlebar_ontop_button_focus_active](<#beautiful.titlebar_ontop_button_focus_active>) | ontop_button_focus_active.  
[beautiful.titlebar_ontop_button_focus_active_hover](<#beautiful.titlebar_ontop_button_focus_active_hover>) | ontop_button_focus_active_hover.  
[beautiful.titlebar_ontop_button_focus_active_press](<#beautiful.titlebar_ontop_button_focus_active_press>) | ontop_button_focus_active_press.  
[beautiful.titlebar_sticky_button_focus_active](<#beautiful.titlebar_sticky_button_focus_active>) | sticky_button_focus_active.  
[beautiful.titlebar_sticky_button_focus_active_hover](<#beautiful.titlebar_sticky_button_focus_active_hover>) | sticky_button_focus_active_hover.  
[beautiful.titlebar_sticky_button_focus_active_press](<#beautiful.titlebar_sticky_button_focus_active_press>) | sticky_button_focus_active_press.  
[beautiful.titlebar_floating_button_normal_inactive](<#beautiful.titlebar_floating_button_normal_inactive>) | floating_button_normal_inactive.  
[beautiful.titlebar_floating_button_normal_inactive_hover](<#beautiful.titlebar_floating_button_normal_inactive_hover>) | floating_button_normal_inactive_hover.  
[beautiful.titlebar_floating_button_normal_inactive_press](<#beautiful.titlebar_floating_button_normal_inactive_press>) | floating_button_normal_inactive_press.  
[beautiful.titlebar_maximized_button_normal_inactive](<#beautiful.titlebar_maximized_button_normal_inactive>) | maximized_button_normal_inactive.  
[beautiful.titlebar_maximized_button_normal_inactive_hover](<#beautiful.titlebar_maximized_button_normal_inactive_hover>) | maximized_button_normal_inactive_hover.  
[beautiful.titlebar_maximized_button_normal_inactive_press](<#beautiful.titlebar_maximized_button_normal_inactive_press>) | maximized_button_normal_inactive_press.  
[beautiful.titlebar_ontop_button_normal_inactive](<#beautiful.titlebar_ontop_button_normal_inactive>) | ontop_button_normal_inactive.  
[beautiful.titlebar_ontop_button_normal_inactive_hover](<#beautiful.titlebar_ontop_button_normal_inactive_hover>) | ontop_button_normal_inactive_hover.  
[beautiful.titlebar_ontop_button_normal_inactive_press](<#beautiful.titlebar_ontop_button_normal_inactive_press>) | ontop_button_normal_inactive_press.  
[beautiful.titlebar_sticky_button_normal_inactive](<#beautiful.titlebar_sticky_button_normal_inactive>) | sticky_button_normal_inactive.  
[beautiful.titlebar_sticky_button_normal_inactive_hover](<#beautiful.titlebar_sticky_button_normal_inactive_hover>) | sticky_button_normal_inactive_hover.  
[beautiful.titlebar_sticky_button_normal_inactive_press](<#beautiful.titlebar_sticky_button_normal_inactive_press>) | sticky_button_normal_inactive_press.  
[beautiful.titlebar_floating_button_focus_inactive](<#beautiful.titlebar_floating_button_focus_inactive>) | floating_button_focus_inactive.  
[beautiful.titlebar_floating_button_focus_inactive_hover](<#beautiful.titlebar_floating_button_focus_inactive_hover>) | floating_button_focus_inactive_hover.  
[beautiful.titlebar_floating_button_focus_inactive_press](<#beautiful.titlebar_floating_button_focus_inactive_press>) | floating_button_focus_inactive_press.  
[beautiful.titlebar_maximized_button_focus_inactive](<#beautiful.titlebar_maximized_button_focus_inactive>) | maximized_button_focus_inactive.  
[beautiful.titlebar_maximized_button_focus_inactive_hover](<#beautiful.titlebar_maximized_button_focus_inactive_hover>) | maximized_button_focus_inactive_hover.  
[beautiful.titlebar_maximized_button_focus_inactive_press](<#beautiful.titlebar_maximized_button_focus_inactive_press>) | maximized_button_focus_inactive_press.  
[beautiful.titlebar_ontop_button_focus_inactive](<#beautiful.titlebar_ontop_button_focus_inactive>) | ontop_button_focus_inactive.  
[beautiful.titlebar_ontop_button_focus_inactive_hover](<#beautiful.titlebar_ontop_button_focus_inactive_hover>) | ontop_button_focus_inactive_hover.  
[beautiful.titlebar_ontop_button_focus_inactive_press](<#beautiful.titlebar_ontop_button_focus_inactive_press>) | ontop_button_focus_inactive_press.  
[beautiful.titlebar_sticky_button_focus_inactive](<#beautiful.titlebar_sticky_button_focus_inactive>) | sticky_button_focus_inactive.  
[beautiful.titlebar_sticky_button_focus_inactive_hover](<#beautiful.titlebar_sticky_button_focus_inactive_hover>) | sticky_button_focus_inactive_hover.  
[beautiful.titlebar_sticky_button_focus_inactive_press](<#beautiful.titlebar_sticky_button_focus_inactive_press>) | sticky_button_focus_inactive_press.  
  
## [Fields](<#Fields>)

[awful.titlebar.enable_tooltip](<#awful.titlebar.enable_tooltip>) | Show tooltips when hover on titlebar buttons.  
---|---  
[awful.titlebar.fallback_name](<#awful.titlebar.fallback_name>) | Title to display if client name is not set.  
  
## [Methods](<#Methods>)

[awful.titlebar:setup (args)](<#awful.titlebar:setup>) | Set a declarative widget hierarchy description.  
---|---  
[awful.titlebar:show (c[, position])](<#awful.titlebar:show>) | Show a client’s titlebar.  
[awful.titlebar:hide (c[, position])](<#awful.titlebar:hide>) | Hide a client’s titlebar.  
[awful.titlebar:toggle (c[, position])](<#awful.titlebar:toggle>) | Toggle a client’s titlebar, hiding it if it is visible, otherwise showing it.  
  
  


## Functions

Methods 

**awful.titlebar (c[, args={}])**
     Get a client’s titlebar. 

  * c [client](<../classes/client.html#>) The client for which a titlebar is wanted. 
  * args A table with extra arguments for the titlebar. 
    * size number The height of the titlebar. (_default_ font.height*1.5) 
    * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) “ values are `top`, `left`, `right` and `bottom`. (_default_ top) 
    * bg_normal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ top) 
    * bg_focus [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ top) 
    * bgimage_normal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ top) 
    * bgimage_focus [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ top) 
    * fg_normal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ top) 
    * fg_focus [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ top) 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ top) 


**titlebar.widget.titlewidget (c)**
     Create a new titlewidget. A title widget displays the name of a client. Please note that this returns a textbox and all of textbox' API is available. This way, you can e.g. modify the font that is used. 

  * c The client for which a titlewidget should be created. 


### Returns:

The title widget. 

**titlebar.widget.iconwidget (c)**
     Create a new icon widget. An icon widget displays the icon of a client. Please note that this returns an imagebox and all of the imagebox' API is available. This way, you can e.g. disallow resizes. 

  * c The client for which an icon widget should be created. 


### Returns:

The icon widget. 

**titlebar.widget.button (c, name, selector, action)**
     Create a new button widget. A button widget displays an image and reacts to mouse clicks. Please note that the caller has to make sure that this widget gets redrawn when needed by calling the returned widget’s update() function. The selector function should return a value describing a state. If the value is a boolean, either “active” or “inactive” are used. The actual image is then found in the theme as “titlebar _[name]_ button _[normal/focus]_[state]”. If that value does not exist, the focused state is ignored for the next try. 

  * c The client for which a button is created. 
  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Name of the button, used for accessing the theme and in the tooltip. 
  * selector A function that selects the image that should be displayed. 
  * action Function that is called when the button is clicked. 


### Returns:

The widget 

**titlebar.widget.floatingbutton (c)**
     Create a new float button for a client. 

  * c The client for which the button is wanted. 


**titlebar.widget.maximizedbutton (c)**
     Create a new maximize button for a client. 

  * c The client for which the button is wanted. 


**titlebar.widget.minimizebutton (c)**
     Create a new minimize button for a client. 

  * c The client for which the button is wanted. 


**titlebar.widget.closebutton (c)**
     Create a new closing button for a client. 

  * c The client for which the button is wanted. 


**titlebar.widget.ontopbutton (c)**
     Create a new ontop button for a client. 

  * c The client for which the button is wanted. 


**titlebar.widget.stickybutton (c)**
     Create a new sticky button for a client. 

  * c The client for which the button is wanted. 


## Theme variables

**beautiful.titlebar_fg_normal**
     The titlebar foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.titlebar_bg_normal**
     The titlebar background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.titlebar_bgimage_normal**
     The titlebar background image image. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_fg**
     The titlebar foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.titlebar_bg**
     The titlebar background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.titlebar_bgimage**
     The titlebar background image image. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_fg_focus**
     The focused titlebar foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.titlebar_bg_focus**
     The focused titlebar background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.titlebar_bgimage_focus**
     The focused titlebar background image image. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_normal**
     floating_button_normal. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_normal**
     maximized_button_normal. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_minimize_button_normal**
     minimize_button_normal. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_minimize_button_normal_hover**
     minimize_button_normal_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_minimize_button_normal_press**
     minimize_button_normal_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_close_button_normal**
     close_button_normal. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_close_button_normal_hover**
     close_button_normal_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_close_button_normal_press**
     close_button_normal_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_normal**
     ontop_button_normal. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_normal**
     sticky_button_normal. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_focus**
     floating_button_focus. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_focus**
     maximized_button_focus. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_minimize_button_focus**
     minimize_button_focus. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_minimize_button_focus_hover**
     minimize_button_focus_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_minimize_button_focus_press**
     minimize_button_focus_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_close_button_focus**
     close_button_focus. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_close_button_focus_hover**
     close_button_focus_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_close_button_focus_press**
     close_button_focus_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_focus**
     ontop_button_focus. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_focus**
     sticky_button_focus. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_normal_active**
     floating_button_normal_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_normal_active_hover**
     floating_button_normal_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_normal_active_press**
     floating_button_normal_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_normal_active**
     maximized_button_normal_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_normal_active_hover**
     maximized_button_normal_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_normal_active_press**
     maximized_button_normal_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_normal_active**
     ontop_button_normal_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_normal_active_hover**
     ontop_button_normal_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_normal_active_press**
     ontop_button_normal_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_normal_active**
     sticky_button_normal_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_normal_active_hover**
     sticky_button_normal_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_normal_active_press**
     sticky_button_normal_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_focus_active**
     floating_button_focus_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_focus_active_hover**
     floating_button_focus_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_focus_active_press**
     floating_button_focus_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_focus_active**
     maximized_button_focus_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_focus_active_hover**
     maximized_button_focus_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_focus_active_press**
     maximized_button_focus_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_focus_active**
     ontop_button_focus_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_focus_active_hover**
     ontop_button_focus_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_focus_active_press**
     ontop_button_focus_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_focus_active**
     sticky_button_focus_active. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_focus_active_hover**
     sticky_button_focus_active_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_focus_active_press**
     sticky_button_focus_active_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_normal_inactive**
     floating_button_normal_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_normal_inactive_hover**
     floating_button_normal_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_normal_inactive_press**
     floating_button_normal_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_normal_inactive**
     maximized_button_normal_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_normal_inactive_hover**
     maximized_button_normal_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_normal_inactive_press**
     maximized_button_normal_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_normal_inactive**
     ontop_button_normal_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_normal_inactive_hover**
     ontop_button_normal_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_normal_inactive_press**
     ontop_button_normal_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_normal_inactive**
     sticky_button_normal_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_normal_inactive_hover**
     sticky_button_normal_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_normal_inactive_press**
     sticky_button_normal_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_focus_inactive**
     floating_button_focus_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_focus_inactive_hover**
     floating_button_focus_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_floating_button_focus_inactive_press**
     floating_button_focus_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_focus_inactive**
     maximized_button_focus_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_focus_inactive_hover**
     maximized_button_focus_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_maximized_button_focus_inactive_press**
     maximized_button_focus_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_focus_inactive**
     ontop_button_focus_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_focus_inactive_hover**
     ontop_button_focus_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_ontop_button_focus_inactive_press**
     ontop_button_focus_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_focus_inactive**
     sticky_button_focus_inactive. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_focus_inactive_hover**
     sticky_button_focus_inactive_hover. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.titlebar_sticky_button_focus_inactive_press**
     sticky_button_focus_inactive_press. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 


## Fields

**awful.titlebar.enable_tooltip**
     Show tooltips when hover on titlebar buttons. 
**awful.titlebar.fallback_name**
     Title to display if client name is not set. 

## Methods

**awful.titlebar:setup (args)**
     Set a declarative widget hierarchy description. See [The declarative layout system](<../documentation/03-declarative-layout.md.html>)

  * args An array containing the widgets disposition 


**awful.titlebar:show (c[, position])**
     Show a client’s titlebar. 

  * c The client whose titlebar is modified 
  * position The position of the titlebar. Must be one of “left”, “right”, “top”, “bottom”. Default is “top”. (_optional_) 


**awful.titlebar:hide (c[, position])**
     Hide a client’s titlebar. 

  * c The client whose titlebar is modified 
  * position The position of the titlebar. Must be one of “left”, “right”, “top”, “bottom”. Default is “top”. (_optional_) 


**awful.titlebar:toggle (c[, position])**
     Toggle a client’s titlebar, hiding it if it is visible, otherwise showing it. 

  * c The client whose titlebar is modified 
  * position The position of the titlebar. Must be one of “left”, “right”, “top”, “bottom”. Default is “top”. (_optional_)