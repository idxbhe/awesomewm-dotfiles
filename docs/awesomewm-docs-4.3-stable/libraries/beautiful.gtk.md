# Module beautiful.gtk - awesome API documentation

**Module:** `libraries.beautiful.gtk`  

> Source: [libraries/beautiful.gtk.html](https://awesomewm.org/doc/api/libraries/beautiful.gtk.html)

---

# Module `beautiful.gtk`

Querying current GTK+ 3 theme via GtkStyleContext.

### Info:

  * **Copyright** : 2016-2017 Yauheni Kirylau
  * **Author** : Yauheni Kirylau <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[get_theme_variables ()](<#get_theme_variables>) | Get GTK+3 theme variables from GtkStyleContext  
---|---  
  
  


## Functions

Methods 

**get_theme_variables ()**
     Get GTK+3 theme variables from GtkStyleContext 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Key-value table with the following structure:  Result key | StyleContext key | StyleContext fallback #1 | StyleContext fallback #2 | GTK Widget fallback  
---|---|---|---|---  
`font_size` |  |  |  | Label font-size  
`font_family` |  |  |  | Label font-family  
`bg_color` | `theme_bg_color` |  |  | Window bg  
`fg_color` | `theme_fg_color` |  |  | Window fg  
`base_color` | `theme_base_color` |  |  | Entry bg  
`text_color` | `theme_text_color` |  |  | Entry fg  
`button_bg_color` | `theme_button_bg_color` | `theme_bg_color` |  | Button bg  
`button_fg_color` | `theme_button_fg_color` | `theme_fg_color` |  | Button fg  
`button_border_color` |  |  |  | Button border-color  
`button_border_radius` |  |  |  | Button border-radius  
`button_border_width` |  |  |  | Button border-top-width  
`selected_bg_color` | `theme_selected_bg_color` |  |  | ToggleButton bg  
`selected_fg_color` | `theme_selected_fg_color` |  |  | ToggleButton fg  
`menubar_bg_color` | `menubar_bg_color` | `theme_bg_color` |  | HeaderBar bg  
`menubar_fg_color` | `menubar_fg_color` | `theme_fg_color` |  | HeaderBar fg  
`header_button_bg_color` | `header_button_bg_color` | `menubar_bg_color` | `theme_bg_color` | HeaderBar > Button bg  
`header_button_fg_color` | `header_button_fg_color` | `menubar_fg_color` | `theme_fg_color` | HeaderBar > Button fg  
`header_button_border_color` |  |  |  | HeaderBar > Button border-color  
`error_color` | `error_color` | `error_bg_color` |  | destructive Button bg  
`error_bg_color` | `error_bg_color` | `error_color` |  | destructive Button bg  
`error_fg_color` | `error_fg_color` | `theme_selected_fg_color` |  | destructive Button fg  
`warning_color` | `warning_color` | `warning_bg_color` |  |   
`warning_bg_color` | `warning_bg_color` | `warning_color` |  |   
`warning_fg_color` | `warning_fg_color` | `theme_selected_fg_color` |  |   
`success_color` | `success_color` | `success_bg_color` |  |   
`success_bg_color` | `success_bg_color` | `success_color` |  |   
`success_fg_color` | `success_fg_color` | `theme_selected_fg_color` |  |   
`tooltip_bg_color` | `theme_tooltip_bg_color` | `theme_bg_color` |  |   
`tooltip_fg_color` | `theme_tooltip_fg_color` | `theme_fg_color` |  |   
`osd_bg_color` | `osd_bg` | `theme_tooltip_bg_color` | `theme_bg_color` |   
`osd_fg_color` | `osd_fg` | `theme_tooltip_fg_color` | `theme_fg_color` |   
`osd_border_color` | `osd_borders_color` | `osd_fg_color` |  |   
`wm_bg_color` | `wm_bg` | `menubar_bg_color` | `theme_bg_color` | HeaderBar bg  
`wm_border_focused_color` | `wm_border_focused` | `theme_selected_bg_color` |  | ToggleButton bg  
`wm_border_unfocused_color` | `wm_border_unfocused` | `wm_border` | `menubar_bg_color`