# Module beautiful - awesome API documentation

**Module:** `libraries.beautiful`  

> Source: [libraries/beautiful.html](https://awesomewm.org/doc/api/libraries/beautiful.html)

---

# Module `beautiful`

Theme library.

### Info:

  * **Copyright** : 2008-2009 Damien Leone, Julien Danjou
  * **Author** : Damien Leone <[[email protected]](</cdn-cgi/l/email-protection>)>,Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[get_font (name)](<#get_font>) | Get a font description.  
---|---  
[get_merged_font (name, merge)](<#get_merged_font>) | Get a new font with merged attributes, based on another one.  
[get_font_height (name)](<#get_font_height>) | Get the height of a font.  
[init (config)](<#init>) | Function that initializes the theme settings.  
[get ()](<#get>) | Get the current theme.  
  
## [Theme variables](<#Theme_variables>)

[font](<#font>) | The default font.  
---|---  
[useless_gap](<#useless_gap>) | The gap between clients.  
[border_width](<#border_width>) | The client border width.  
[border_normal](<#border_normal>) | The default clients border color.  
[border_focus](<#border_focus>) | The focused client border color.  
[border_marked](<#border_marked>) | The marked clients border color.  
[wallpaper](<#wallpaper>) | The wallpaper path.  
[awesome_icon](<#awesome_icon>) | The Awesome icon path.  
  
## [Fields](<#Fields>)

[theme_path](<#theme_path>) | The current theme path (if any)  
---|---  
  
## [lib.beautiful.theme_assets Functions](<#lib_beautiful_theme_assets_Functions>)

[theme_assets.taglist_squares_sel (size, fg)](<#theme_assets.taglist_squares_sel>) | Generate selected taglist square.  
---|---  
[theme_assets.taglist_squares_unsel (size, fg)](<#theme_assets.taglist_squares_unsel>) | Generate unselected taglist square.  
[theme_assets.gen_awesome_name (cr, height, bg, fg, alt_fg)](<#theme_assets.gen_awesome_name>) | Put Awesome WM name onto cairo surface.  
[theme_assets.gen_logo (cr, width, height, bg, fg)](<#theme_assets.gen_logo>) | Put Awesome WM logo onto cairo surface.  
[theme_assets.awesome_icon (size, bg, fg)](<#theme_assets.awesome_icon>) | Generate Awesome WM logo.  
[theme_assets.wallpaper (bg, fg, alt_fg, s)](<#theme_assets.wallpaper>) | Generate Awesome WM wallpaper.  
[theme_assets.recolor_titlebar (theme, color, state, postfix)](<#theme_assets.recolor_titlebar>) | Recolor titlebar icons.  
[recolor_titlebar_normal](<#recolor_titlebar_normal>) _[deprecated]_ | Recolor unfocused titlebar icons.  
[recolor_titlebar_focus](<#recolor_titlebar_focus>) _[deprecated]_ | Recolor focused titlebar icons.  
[theme_assets.recolor_layout (theme, color)](<#theme_assets.recolor_layout>) | Recolor layout icons.  
  
## [lib.beautiful.xresources Functions](<#lib_beautiful_xresources_Functions>)

[xresources.get_current_theme ()](<#xresources.get_current_theme>) | Get current base colorscheme from xrdb.  
---|---  
[xresources.get_dpi](<#xresources.get_dpi>) _[deprecated]_ | Get global or per-screen DPI value falling back to xrdb.  
[xresources.set_dpi (dpi[, s])](<#xresources.set_dpi>) | Set DPI for a given screen (defaults to global).  
[xresources.apply_dpi (size[, s])](<#xresources.apply_dpi>) | Compute resulting size applying current DPI value (optionally per screen).  
  
  


## Functions

Methods 

**get_font (name)**
     Get a font description.

See https://developer.gnome.org/pango/stable/pango-Fonts.html#PangoFontDescription. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or lgi.Pango.FontDescription The name of the font. 


### Returns:

lgi.Pango.FontDescription 

**get_merged_font (name, merge)**
     Get a new font with merged attributes, based on another one.

See https://developer.gnome.org/pango/stable/pango-Fonts.html#pango-font-description-from-string. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or Pango.FontDescription The base font. 
  * merge [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Attributes that should be merged, e.g. “bold”. 


### Returns:

lgi.Pango.FontDescription 

**get_font_height (name)**
     Get the height of a font. 

  * name Name of the font 


**init (config)**
    

Function that initializes the theme settings. Should be run at the beginning of the awesome configuration file (normally rc.lua).

Example usages:
    
    
    -- Using a table
    beautiful.init({font = 'Monospace Bold 10'})
    
    -- From a config file
    beautiful.init("<path>/theme.lua")
    

Example “/theme.lua” (see [05-awesomerc.md:Variable_definitions](<../documentation/05-awesomerc.md.html#Variable_definitions>)):
    
    
    theme = {}
        theme.font = 'Monospace Bold 10'
    return theme
    

Example using the return value:
    
    
    local beautiful = require("beautiful")
    if not beautiful.init("<path>/theme.lua") then
        beautiful.init("<path>/.last.theme.lua") -- a known good fallback
    end
    

  * config [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The theme to load. It can be either the path to the theme file (which should return a table) or directly a table containing all the theme values. 


### Returns:

true or nil True if successful, nil in case of error. 

**get ()**
     Get the current theme. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current theme table. 


## Theme variables

**font**
     The default font. 
**useless_gap**
     The gap between clients. 

### Type:

  * number (_default_ 0) 


**border_width**
     The client border width. 
**border_normal**
     The default clients border color. Note that only solid colors are supported. 
**border_focus**
     The focused client border color. Note that only solid colors are supported. 
**border_marked**
     The marked clients border color. Note that only solid colors are supported. 
**wallpaper**
     The wallpaper path. 
**awesome_icon**
     The Awesome icon path. 

## Fields

**theme_path**
     The current theme path (if any) 

## lib.beautiful.theme_assets Functions

**theme_assets.taglist_squares_sel (size, fg)**
     Generate selected taglist square. 

  * size number Size. 
  * fg color Background color. 


### Returns:

Image with the square. 

**theme_assets.taglist_squares_unsel (size, fg)**
     Generate unselected taglist square. 

  * size number Size. 
  * fg color Background color. 


### Returns:

Image with the square. 

**theme_assets.gen_awesome_name (cr, height, bg, fg, alt_fg)**
     Put Awesome WM name onto cairo surface. 

  * cr Cairo surface. 
  * height number Height. 
  * bg color Background color. 
  * fg color Main foreground color. 
  * alt_fg color Accent foreground color. 


**theme_assets.gen_logo (cr, width, height, bg, fg)**
     Put Awesome WM logo onto cairo surface. 

  * cr Cairo surface. 
  * width number Width. 
  * height number Height. 
  * bg color Background color. 
  * fg color Foreground color. 


**theme_assets.awesome_icon (size, bg, fg)**
     Generate Awesome WM logo. 

  * size number Size. 
  * bg color Background color. 
  * fg color Background color. 


### Returns:

Image with the logo. 

**theme_assets.wallpaper (bg, fg, alt_fg, s)**
     Generate Awesome WM wallpaper. 

  * bg color Background color. 
  * fg color Main foreground color. 
  * alt_fg color Accent foreground color. 
  * s [screen](<../classes/screen.html#>) Screen (to get wallpaper size). 


### Returns:

Wallpaper image. 

**theme_assets.recolor_titlebar (theme, color, state, postfix)**
     Recolor titlebar icons. 

  * theme [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Beautiful theme table. 
  * color color Icons' color. 
  * state [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) `"normal"` or `"focus"`. 
  * postfix [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) `nil`, `"hover"` or `"press"`. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Beautiful theme table with the images recolored. 

**recolor_titlebar_normal _[deprecated]_**
     Recolor unfocused titlebar icons. This method is deprecated. Use a `beautiful.theme_assets.recolor_titlebar`. param:

  * theme [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Beautiful theme table 
  * color color Icons' color. 


**recolor_titlebar_focus _[deprecated]_**
     Recolor focused titlebar icons. This method is deprecated. Use a `beautiful.theme_assets.recolor_titlebar`. param:

  * theme [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Beautiful theme table 
  * color color Icons' color. 


**theme_assets.recolor_layout (theme, color)**
     Recolor layout icons. 

  * theme [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Beautiful theme table 
  * color color Icons' color. 

Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Beautiful theme table with the images recolored. 

lib.beautiful.xresources Functions

**xresources.get_current_theme ()**
     Get current base colorscheme from xrdb. Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Color table with keys ‘background’, ‘foreground’ and ‘color0’..‘color15’ 

**xresources.get_dpi _[deprecated]_**
     Get global or per-screen DPI value falling back to xrdb. This function is deprecated. Use `s.dpi` and avoid getting the DPI without a screen. param:

  * s integer or [screen](<../classes/screen.html#>) The screen. (_optional_) 


**xresources.set_dpi (dpi[, s])**
     Set DPI for a given screen (defaults to global). 

  * dpi number DPI value. 
  * s integer Screen. (_optional_) 


**xresources.apply_dpi (size[, s])**
     Compute resulting size applying current DPI value (optionally per screen). 

  * size number Size 
  * s integer or [screen](<../classes/screen.html#>) The screen. (_optional_) 

Returns:

integer Resulting size (rounded to integer).