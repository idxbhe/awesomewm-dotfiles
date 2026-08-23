# Module awful.hotkeys_popup.widget - awesome API documentation

**Module:** `libraries.awful.hotkeys_popup.widget`  

> Source: [libraries/awful.hotkeys_popup.widget.html](https://awesomewm.org/doc/api/libraries/awful.hotkeys_popup.widget.html)

---

# Module `awful.hotkeys_popup.widget`

Popup widget which shows current hotkeys and their descriptions.

### Info:

  * **Copyright** : 2014-2015 Yauheni Kirylau
  * **Author** : Yauheni Kirylau <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[new ([args])](<#new>) | Create an instance of widget with hotkeys help.  
---|---  
[widget_instance:show_help ([c[, s[, show_args]]])](<#widget_instance:show_help>) | Show popup with hotkeys help.  
[widget_instance:add_hotkeys (hotkeys)](<#widget_instance:add_hotkeys>) | Add hotkey descriptions for third-party applications.  
[widget_instance:add_group_rules (group, data)](<#widget_instance:add_group_rules>) | Add hotkey group rules for third-party applications.  
[show_help ([c[, s[, args]]])](<#show_help>) | Show popup with hotkeys help (default widget instance will be used).  
[add_hotkeys (hotkeys)](<#add_hotkeys>) | Add hotkey descriptions for third-party applications (default widget instance will be used).  
[add_group_rules (group, data)](<#add_group_rules>) | Add hotkey group rules for third-party applications (default widget instance will be used).  
  
## [Theme variables](<#Theme_variables>)

[beautiful.hotkeys_bg](<#beautiful.hotkeys_bg>) | Hotkeys widget background color.  
---|---  
[beautiful.hotkeys_fg](<#beautiful.hotkeys_fg>) | Hotkeys widget foreground color.  
[beautiful.hotkeys_border_width](<#beautiful.hotkeys_border_width>) | Hotkeys widget border width.  
[beautiful.hotkeys_border_color](<#beautiful.hotkeys_border_color>) | Hotkeys widget border color.  
[beautiful.hotkeys_shape](<#beautiful.hotkeys_shape>) | Hotkeys widget shape.  
[beautiful.hotkeys_modifiers_fg](<#beautiful.hotkeys_modifiers_fg>) | Foreground color used for hotkey modifiers (Ctrl, Alt, Super, etc).  
[beautiful.hotkeys_label_bg](<#beautiful.hotkeys_label_bg>) | Background color used for miscellaneous labels of hotkeys widget.  
[beautiful.hotkeys_label_fg](<#beautiful.hotkeys_label_fg>) | Foreground color used for hotkey groups and other labels.  
[beautiful.hotkeys_font](<#beautiful.hotkeys_font>) | Main hotkeys widget font.  
[beautiful.hotkeys_description_font](<#beautiful.hotkeys_description_font>) | Font used for hotkeys' descriptions.  
[beautiful.hotkeys_group_margin](<#beautiful.hotkeys_group_margin>) | Margin between hotkeys groups.  
  
## [Fields](<#Fields>)

[hide_without_description](<#hide_without_description>) | Don’t show hotkeys without descriptions.  
---|---  
[merge_duplicates](<#merge_duplicates>) | Merge hotkey records into one if they have the same modifiers and description.  
  
  


## Functions

Methods 

**new ([args])**
     Create an instance of widget with hotkeys help. 

  * args Configuration options for the widget. 
    * hide_without_description boolean Don’t show hotkeys without descriptions. (_optional_) 
    * merge_duplicates boolean Merge hotkey records into one if they have the same modifiers and description. (_optional_) 
    * width int Widget width. (_optional_) 
    * height int Widget height. (_optional_) 
    * bg color Widget background color. (_optional_) 
    * fg color Widget foreground color. (_optional_) 
    * border_width int Border width. (_optional_) 
    * border_color color Border color. (_optional_) 
    * shape gears.shape Widget shape. (_optional_) 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or lgi.Pango.FontDescription Main widget font. (_optional_) 
    * description_font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or lgi.Pango.FontDescription Font used for hotkeys' descriptions. (_optional_) 
    * modifiers_fg color Foreground color used for hotkey modifiers (Ctrl, Alt, Super, etc). (_optional_) 
    * label_bg color Background color used for miscellaneous labels. (_optional_) 
    * label_fg color Foreground color used for group and other labels. (_optional_) 
    * group_margin int Margin between hotkeys groups. (_optional_) 
    * labels [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Labels used for displaying human-readable keynames. (_optional_) 
    * group_rules [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Rules for showing 3rd-party hotkeys. @see `awful.hotkeys_popup.keys.vim`. (_optional_) 


### Returns:

Widget instance. 

**widget_instance:show_help ([c[, s[, show_args]]])**
     Show popup with hotkeys help. 

  * c [client](<../classes/client.html#>) Client. (_optional_) 
  * s [screen](<../classes/screen.html#>) Screen. (_optional_) 
  * show_args Additional arguments. 
    * show_awesome_keys boolean Show AwesomeWM hotkeys. When set to `false` only app-specific hotkeys will be shown. (_default_ true) 


**widget_instance:add_hotkeys (hotkeys)**
     Add hotkey descriptions for third-party applications. 

  * hotkeys [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Table with bindings, see `awful.hotkeys_popup.key.vim` as an example. 


**widget_instance:add_group_rules (group, data)**
     Add hotkey group rules for third-party applications. 

  * group [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) hotkeys group name, 
  * data [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) rule data for the group see `awful.hotkeys_popup.key.vim` as an example. 


**show_help ([c[, s[, args]]])**
     Show popup with hotkeys help (default widget instance will be used). 

  * c [client](<../classes/client.html#>) Client. (_optional_) 
  * s [screen](<../classes/screen.html#>) Screen. (_optional_) 
  * args Additional arguments. 
    * show_awesome_keys boolean Show AwesomeWM hotkeys. When set to `false` only app-specific hotkeys will be shown. (_default_ true) 


**add_hotkeys (hotkeys)**
     Add hotkey descriptions for third-party applications (default widget instance will be used). 

  * hotkeys [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Table with bindings, see `awful.hotkeys_popup.key.vim` as an example. 


**add_group_rules (group, data)**
     Add hotkey group rules for third-party applications (default widget instance will be used). 

  * group [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) rule group name, 
  * data [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) rule data for the group see `awful.hotkeys_popup.key.vim` as an example. 


## Theme variables

**beautiful.hotkeys_bg**
     Hotkeys widget background color. 

### Type:

  * hotkeys_bg color


**beautiful.hotkeys_fg**
     Hotkeys widget foreground color. 

### Type:

  * hotkeys_fg color


**beautiful.hotkeys_border_width**
     Hotkeys widget border width. 

### Type:

  * hotkeys_border_width int


**beautiful.hotkeys_border_color**
     Hotkeys widget border color. 

### Type:

  * hotkeys_border_color color


**beautiful.hotkeys_shape**
     Hotkeys widget shape. 

### Type:

  * hotkeys_shape gears.shape (_optional_) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.hotkeys_modifiers_fg**
     Foreground color used for hotkey modifiers (Ctrl, Alt, Super, etc). 

### Type:

  * hotkeys_modifiers_fg color


**beautiful.hotkeys_label_bg**
     Background color used for miscellaneous labels of hotkeys widget. 

### Type:

  * hotkeys_label_bg color


**beautiful.hotkeys_label_fg**
     Foreground color used for hotkey groups and other labels. 

### Type:

  * hotkeys_label_fg color


**beautiful.hotkeys_font**
     Main hotkeys widget font. 

### Type:

  * hotkeys_font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or lgi.Pango.FontDescription


**beautiful.hotkeys_description_font**
     Font used for hotkeys' descriptions. 

### Type:

  * hotkeys_description_font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or lgi.Pango.FontDescription


**beautiful.hotkeys_group_margin**
     Margin between hotkeys groups. 

### Type:

  * hotkeys_group_margin int


## Fields

**hide_without_description**
     Don’t show hotkeys without descriptions. 
**merge_duplicates**
     Merge hotkey records into one if they have the same modifiers and description.