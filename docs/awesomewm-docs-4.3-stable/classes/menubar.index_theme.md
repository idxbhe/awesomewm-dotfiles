# Class menubar.index_theme - awesome API documentation

**Module:** `classes.menubar.index_theme`  

> Source: [classes/menubar.index_theme.html](https://awesomewm.org/doc/api/classes/menubar.index_theme.html)

---

# Class `menubar.index_theme`

(Deprecated) class module for parsing an index.theme file

### Info:

  * **Copyright** : 2015 Kazunobu Kuriyama
  * **Author** : Kazunobu Kuriyama


## [Deprecated functions](<#Deprecated_functions>)

[menubar.index_theme.new](<#menubar.index_theme.new>) _[deprecated]_ | Class constructor of [index_theme](<../classes/menubar.index_theme.html>)  
---|---  
[menubar.index_theme:get_subdirectories](<#menubar.index_theme:get_subdirectories>) _[deprecated]_ | Table of the values of the `Directories` key  
[menubar.index_theme:get_inherits](<#menubar.index_theme:get_inherits>) _[deprecated]_ | Table of the values of the `Inherits` key  
[menubar.index_theme:get_per_directory_keys](<#menubar.index_theme:get_per_directory_keys>) _[deprecated]_ | Query (part of) per-directory keys of a given subdirectory name.  
  
  


## Deprecated functions

**menubar.index_theme.new _[deprecated]_**
     Class constructor of [index_theme](<../classes/menubar.index_theme.html>) param:

  * cls [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Metatable that will be used. Should always be `index_theme.mt`. 
  * icon_theme_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Internal name of icon theme 
  * base_directories [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Paths used for lookup 


**menubar.index_theme:get_subdirectories _[deprecated]_**
     Table of the values of the `Directories` key 
**menubar.index_theme:get_inherits _[deprecated]_**
     Table of the values of the `Inherits` key 
**menubar.index_theme:get_per_directory_keys _[deprecated]_**
     Query (part of) per-directory keys of a given subdirectory name. param:

  * subdirectory [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Icon theme’s subdirectory