# Module menubar - awesome API documentation

**Module:** `libraries.menubar`  

> Source: [libraries/menubar.html](https://awesomewm.org/doc/api/libraries/menubar.html)

---

# Module `menubar`

Menubar module, which aims to provide a freedesktop menu alternative

##  List of menubar keybindings:

  * “Left” | “C-j” select an item on the left
  * “Right” | “C-k” select an item on the right
  * “Backspace” exit the current category if we are in any
  * “Escape” exit the current directory or exit menubar
  * “Home” select the first item
  * “End” select the last
  * “Return” execute the entry
  * “C-Return” execute the command with awful.spawn
  * “C-M-Return” execute the command in a terminal


### Info:

  * **Copyright** : 2011-2012 Alexander Yakushev
  * **Author** : Alexander Yakushev <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[refresh ([scr])](<#refresh>) | Refresh menubar’s cache by reloading .desktop files.  
---|---  
[show ([scr])](<#show>) | Show the menubar on the given screen.  
[hide ()](<#hide>) | Hide the menubar.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.menubar_fg_normal](<#beautiful.menubar_fg_normal>) | Menubar normal text color.  
---|---  
[beautiful.menubar_bg_normal](<#beautiful.menubar_bg_normal>) | Menubar normal background color.  
[beautiful.menubar_border_width](<#beautiful.menubar_border_width>) | Menubar border width.  
[beautiful.menubar_border_color](<#beautiful.menubar_border_color>) | Menubar border color.  
[beautiful.menubar_fg_normal](<#beautiful.menubar_fg_normal>) | Menubar selected item text color.  
[beautiful.menubar_bg_normal](<#beautiful.menubar_bg_normal>) | Menubar selected item background color.  
  
## [Deprecated functions](<#Deprecated_functions>)

[get](<#get>) _[deprecated]_ | Get a menubar wibox.  
---|---  
  
## [Tables](<#Tables>)

[geometry](<#geometry>) | Specifies the geometry of the menubar.  
---|---  
[prompt_args](<#prompt_args>) | Allows user to specify custom parameters for prompt.run function (like colors).  
  
## [Fields](<#Fields>)

[cache_entries](<#cache_entries>) | When true the .desktop files will be reparsed only when the extension is initialized.  
---|---  
[show_categories](<#show_categories>) | When true the categories will be shown alongside application entries.  
[right_margin](<#right_margin>) | Width of blank space left in the right side.  
[right_label](<#right_label>) | Label used for “Next page”, default “▶▶”.  
[left_label](<#left_label>) | Label used for “Previous page”, default “◀◀”.  
  
  


## Functions

Methods 

**refresh ([scr])**
     Refresh menubar’s cache by reloading .desktop files. 

  * scr [screen](<../classes/screen.html#>) Screen. (_optional_) 


**show ([scr])**
     Show the menubar on the given screen. 

  * scr Screen. (_optional_) 


**hide ()**
     Hide the menubar. 

## Theme variables

**beautiful.menubar_fg_normal**
     Menubar normal text color. 
**beautiful.menubar_bg_normal**
     Menubar normal background color. 
**beautiful.menubar_border_width**
     Menubar border width. 

### Type:

  * menubar_border_width number (_default_ 0) 


**beautiful.menubar_border_color**
     Menubar border color. 
**beautiful.menubar_fg_normal**
     Menubar selected item text color. 
**beautiful.menubar_bg_normal**
     Menubar selected item background color. 

## Deprecated functions

**get _[deprecated]_**
     Get a menubar wibox. param:

  * scr [screen](<../classes/screen.html#>) Screen. (_optional_) 


Tables

**geometry**
     Specifies the geometry of the menubar. This is a table with the keys x, y, width and height. Missing values are replaced via the screen’s geometry. However, missing height is replaced by the font size. 
**prompt_args**
     Allows user to specify custom parameters for prompt.run function (like colors). See also:

[awful.prompt](<../libraries/awful.prompt.html#>) 

Fields

**cache_entries**
     When true the .desktop files will be reparsed only when the extension is initialized. Use this if menubar takes much time to open. 

  * cache_entries boolean (_default_ true) 


**show_categories**
     When true the categories will be shown alongside application entries. 

  * show_categories boolean (_default_ true) 


**right_margin**
     Width of blank space left in the right side. 

  * right_margin number


**right_label**
     Label used for “Next page”, default “▶▶”. 

  * right_label [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ "▶▶") 


**left_label**
     Label used for “Previous page”, default “◀◀”. 

  * left_label [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ "◀◀")