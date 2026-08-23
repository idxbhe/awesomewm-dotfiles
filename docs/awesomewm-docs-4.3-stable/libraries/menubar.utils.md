# Module menubar.utils - awesome API documentation

**Module:** `libraries.menubar.utils`  

> Source: [libraries/menubar.utils.html](https://awesomewm.org/doc/api/libraries/menubar.utils.html)

---

# Module `menubar.utils`

Utility module for menubar

### Info:

  * **Copyright** : 2009, 2011-2012 Antonio Terceiro, Alexander Yakushev
  * **Author** : Antonio Terceiro


## [Functions](<#Functions>)

[rtrim (s)](<#rtrim>) | Remove CR newline from the end of the string.  
---|---  
[lookup_icon_uncached (icon_file)](<#lookup_icon_uncached>) | Lookup an icon in different folders of the filesystem.  
[lookup_icon (icon)](<#lookup_icon>) | Lookup an icon in different folders of the filesystem (cached).  
[parse_desktop_file (file)](<#parse_desktop_file>) | Parse a .desktop file.  
[parse_dir (dir_path, callback)](<#parse_dir>) | Parse a directory with .desktop files recursively.  
[compute_text_width (text, s)](<#compute_text_width>) | Compute text width.  
  
## [Fields](<#Fields>)

[terminal](<#terminal>) | Terminal which applications that need terminal would open in.  
---|---  
[wm_name](<#wm_name>) | Name of the WM for the OnlyShowIn entry in the .desktop file.  
  
  


## Functions

Methods 

**rtrim (s)**
     Remove CR newline from the end of the string. 

  * s string to trim 


**lookup_icon_uncached (icon_file)**
     Lookup an icon in different folders of the filesystem. 

  * icon_file [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Short or full name of the icon. 


### Returns:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or boolean Full name of the icon, or false on failure. 

**lookup_icon (icon)**
     Lookup an icon in different folders of the filesystem (cached). 

  * icon Short or full name of the icon. 


### Returns:

full name of the icon. 

**parse_desktop_file (file)**
     Parse a .desktop file. 

  * file The .desktop file. 


### Returns:

A table with file entries. 

**parse_dir (dir_path, callback)**
     Parse a directory with .desktop files recursively. 

  * dir_path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The directory path. 
  * callback Will be fired when all the files were parsed with the resulting list of menu entries as argument. 
    * programs [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Paths of found .desktop files. 


**compute_text_width (text, s)**
     Compute text width. 

  * text str Text. 
  * s number or [screen](<../classes/screen.html#>) Screen 


### Returns:

int Text width. 


## Fields

**terminal**
     Terminal which applications that need terminal would open in. 
**wm_name**
     Name of the WM for the OnlyShowIn entry in the .desktop file.