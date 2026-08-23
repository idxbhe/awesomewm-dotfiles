# Module awful.menu - awesome API documentation

**Module:** `libraries.awful.menu`  

> Source: [libraries/awful.menu.html](https://awesomewm.org/doc/api/libraries/awful.menu.html)

---

# Module `awful.menu`

A menu for awful

### Info:

  * **Copyright** : 2008, 2011 Damien Leone, Julien Danjou, dodo
  * **Author** : Damien Leone <[[email protected]](</cdn-cgi/l/email-protection>)>,Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>,dodo


## [Functions](<#Functions>)

[show (args)](<#show>) | Show a menu.  
---|---  
[hide ()](<#hide>) | Hide a menu popup.  
[toggle (args)](<#toggle>) | Toggle menu visibility.  
[update ()](<#update>) | Update menu content  
[get_root ()](<#get_root>) | Get the elder parent so for example when you kill it, it will destroy the whole family.  
[add (args, index)](<#add>) | Add a new menu entry.  
[delete (num)](<#delete>) | Delete menu entry at given position  
[clients ([args[, item_args[, filter]]])](<#clients>) | Build a popup menu with running clients and show it.  
[client_list ([args[, item_args[, filter]]])](<#client_list>) | Use menu.clients to build and open the client menu if it isn’t already open.  
[entry (parent, args)](<#entry>) | Default awful.menu.entry constructor  
[new (args, parent)](<#new>) | Create a menu popup.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.menu_submenu_icon](<#beautiful.menu_submenu_icon>) | The icon used for sub-menus.  
---|---  
[beautiful.menu_font](<#beautiful.menu_font>) | The menu text font.  
[beautiful.menu_height](<#beautiful.menu_height>) | The item height.  
[beautiful.menu_width](<#beautiful.menu_width>) | The default menu width.  
[beautiful.menu_border_color](<#beautiful.menu_border_color>) | The menu item border color.  
[beautiful.menu_border_width](<#beautiful.menu_border_width>) | The menu item border width.  
[beautiful.menu_fg_focus](<#beautiful.menu_fg_focus>) | The default focused item foreground (text) color.  
[beautiful.menu_bg_focus](<#beautiful.menu_bg_focus>) | The default focused item background color.  
[beautiful.menu_fg_normal](<#beautiful.menu_fg_normal>) | The default foreground (text) color.  
[beautiful.menu_bg_normal](<#beautiful.menu_bg_normal>) | The default background color.  
[beautiful.menu_submenu](<#beautiful.menu_submenu>) | The default sub-menu indicator if no menu_submenu_icon is provided.  
  
## [Tables](<#Tables>)

[menu_keys](<#menu_keys>) | Key bindings for menu navigation.  
---|---  
  
  


## Functions

Methods 

**show (args)**
     Show a menu. 

  * args The arguments 
    * coords Menu position defaulting to mouse.coords() 


**hide ()**
     Hide a menu popup. 
**toggle (args)**
     Toggle menu visibility. 

  * args The arguments 
    * coords Menu position {x,y} 


**update ()**
     Update menu content 
**get_root ()**
     Get the elder parent so for example when you kill it, it will destroy the whole family. 
**add (args, index)**
     Add a new menu entry. args.* params needed for the menu entry constructor. 

  * args The item params 
    * new (Default: awful.menu.entry) The menu entry constructor. 
    * theme The menu entry theme. (_optional_) 
  * index The index where the new entry will inserted. (_optional_) 


**delete (num)**
     Delete menu entry at given position 

  * num The position in the table of the menu entry to be deleted; can be also the menu entry itself 


**clients ([args[, item_args[, filter]]])**
     Build a popup menu with running clients and show it. 

  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Menu table, see `new()` for more information. (_optional_) 
  * item_args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Table that will be merged into each item, see `new()` for more information. (_optional_) 
  * filter func A function taking a client as an argument and returning `true` or `false` to indicate whether the client should be included in the menu. (_optional_) 


### Returns:

The menu. 

**client_list ([args[, item_args[, filter]]])**
     Use menu.clients to build and open the client menu if it isn’t already open. Close the client menu if it is already open. See [awful.menu.clients](<../libraries/awful.menu.html#clients>) for more information. 

  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Menu table, see `new()` for more information. (_optional_) 
  * item_args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Table that will be merged into each item, see `new()` for more information. (_optional_) 
  * filter func A function taking a client as an argument and returning `true` or `false` to indicate whether the client should be included in the menu. (_optional_) 


### Returns:

The menu. 

**entry (parent, args)**
     Default awful.menu.entry constructor 

  * parent The parent menu (TODO: This is apparently unused) 
  * args the item params 


### Returns:

table with ‘widget’, ‘cmd’, ‘akey’ and all the properties the user wants to change 

**new (args, parent)**
     Create a menu popup. 

  * args

Table containing the menu informations.

    * Key items: Table containing the displayed items. Each element is a table by default (when element ‘new’ is awful.menu.entry) containing: item name, triggered action (submenu table or function), item icon (optional).
    * Keys theme.[fg|bg]_[focus|normal], theme.border_color, theme.border_width, theme.submenu_icon, theme.height and theme.width override the default display for your menu and/or of your menu entry, each of them are optional.
    * Key auto_expand controls the submenu auto expand behaviour by setting it to true (default) or false.
  * parent Specify the parent menu if we want to open a submenu, this value should never be set by the user. 


### Usage:
    
    -- The following function builds and shows a menu of clients that match
    -- a particular rule.
    -- Bound to a key, it can be used to select from dozens of terminals open on
    -- several tags.
    -- When using [rules.match_any](<../libraries/awful.rules.html#match_any>) instead of [rules.match](<../libraries/awful.rules.html#match>),
    -- a menu of clients with different classes could be build.
    
    function terminal_menu ()
      terms = {}
      for i, c in pairs(client.get()) do
        if awful.rules.match(c, {class = "URxvt"}) then
          terms[i] =
            {c.name,
             function()
               c.first_tag:view_only()
               client.focus = c
             end,
             c.icon
            }
        end
      end
      awful.menu(terms):show()
    end


## Theme variables

**beautiful.menu_submenu_icon**
     The icon used for sub-menus. 
**beautiful.menu_font**
     The menu text font. 

### Type:

  * string


### See also:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) 

**beautiful.menu_height**
     The item height. 

### Type:

  * menu_height number (_default_ 16) 


**beautiful.menu_width**
     The default menu width. 

### Type:

  * menu_width number (_default_ 100) 


**beautiful.menu_border_color**
     The menu item border color. 

### Type:

  * menu_border_color number (_default_ 0) 


**beautiful.menu_border_width**
     The menu item border width. 

### Type:

  * menu_border_width number (_default_ 0) 


**beautiful.menu_fg_focus**
     The default focused item foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.menu_bg_focus**
     The default focused item background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.menu_fg_normal**
     The default foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.menu_bg_normal**
     The default background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.menu_submenu**
     The default sub-menu indicator if no menu_submenu_icon is provided. 

### Type:

  * menu_submenu [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The sub-menu text. (_default_ "▶") 


### See also:

[beautiful.menu_submenu_icon](<../libraries/awful.menu.html#beautiful.menu_submenu_icon>) 


## Tables

**menu_keys**
     Key bindings for menu navigation. Keys are: up, down, exec, enter, back, close. Value are table with a list of valid keys for the action, i.e. menu_keys.up = { “j”, “k” } will bind ‘j’ and ‘k’ key to up action. This is common to all created menu. 

### Fields:

  * up
  * k