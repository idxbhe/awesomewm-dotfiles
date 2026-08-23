# Class menubar.icon_theme - awesome API documentation

**Module:** `classes.menubar.icon_theme`  

> Source: [classes/menubar.icon_theme.html](https://awesomewm.org/doc/api/classes/menubar.icon_theme.html)

---

# Class `menubar.icon_theme`

(Deprecated) class module for icon lookup for menubar

### Info:

  * **Copyright** : 2015 Kazunobu Kuriyama
  * **Author** : Kazunobu Kuriyama


## [Deprecated functions](<#Deprecated_functions>)

[menubar.icon_theme.new](<#menubar.icon_theme.new>) _[deprecated]_ | Class constructor of [icon_theme](<../classes/menubar.icon_theme.html>)  
---|---  
[menubar.icon_theme:find_icon_path](<#menubar.icon_theme:find_icon_path>) _[deprecated]_ | Look up an image file based on a given icon name and/or a preferable size.  
  
  


## Deprecated functions

**menubar.icon_theme.new _[deprecated]_**
     Class constructor of [icon_theme](<../classes/menubar.icon_theme.html>) param:

  * icon_theme_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Internal name of icon theme 
  * base_directories [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Paths used for lookup 


**menubar.icon_theme:find_icon_path _[deprecated]_**
     Look up an image file based on a given icon name and/or a preferable size. param:

  * icon_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Icon name to be looked up 
  * icon_size number Prefereable icon size