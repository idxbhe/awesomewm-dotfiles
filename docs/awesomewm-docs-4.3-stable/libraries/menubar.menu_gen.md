# Module menubar.menu_gen - awesome API documentation

**Module:** `libraries.menubar.menu_gen`  

> Source: [libraries/menubar.menu_gen.html](https://awesomewm.org/doc/api/libraries/menubar.menu_gen.html)

---

# Module `menubar.menu_gen`

Menu generation module for menubar

### Info:

  * **Copyright** : 2009, 2011-2012 Antonio Terceiro, Alexander Yakushev
  * **Author** : Antonio Terceiro


## [Functions](<#Functions>)

[lookup_category_icons ()](<#lookup_category_icons>) | Find icons for category entries.  
---|---  
[generate (callback)](<#generate>) | Generate an array of all visible menu entries.  
  
## [Tables](<#Tables>)

[all_categories](<#all_categories>) | Specify the mapping of .desktop Categories section to the categories in the menubar.  
---|---  
  
## [Fields](<#Fields>)

[all_menu_dirs](<#all_menu_dirs>) | Specifies all directories where menubar should look for .desktop files.  
---|---  
  
  


## Functions

Methods 

**lookup_category_icons ()**
     Find icons for category entries. 
**generate (callback)**
     Generate an array of all visible menu entries. 

  * callback Will be fired when all menu entries were parsed with the resulting list of menu entries as argument. 
    * entries [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) All menu entries. 


## Tables

**all_categories**
     Specify the mapping of .desktop Categories section to the categories in the menubar. If “use” flag is set to false then any of the applications that fall only to this category will not be shown. 

### Fields:

  * multimedia
  * name
  * icon_name
  * use


## Fields

**all_menu_dirs**
     Specifies all directories where menubar should look for .desktop files. The search is recursive.