# Module gears.wallpaper - awesome API documentation

**Module:** `libraries.gears.wallpaper`  

> Source: [libraries/gears.wallpaper.html](https://awesomewm.org/doc/api/libraries/gears.wallpaper.html)

---

# Module `gears.wallpaper`

Functions for setting the wallpaper.

There are two levels of functionality provided by this module:

The low-level functionality consists of two functions. [set](<../libraries/gears.wallpaper.html#set>) an already-prepared wallpaper on all screens and [prepare_context](<../libraries/gears.wallpaper.html#prepare_context>) prepares things to draw a new wallpaper.

The low-level API can for example be used to set solid red as a wallpaper (see [gears.color](<../libraries/gears.color.html#>) for details on the supported syntax):
    
    
    gears.wallpaper.set("#ff0000")
    

Ontop of these low-level functions, the remaining functions implement more useful functionality. For example, given a screen object `s`, an image can be set as the wallpaper as follows:
    
    
    gears.wallpaper.maximized("path/to/image.png", s)
    

### Info:

  * **Copyright** : 2012 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[prepare_context (s)](<#prepare_context>) | Prepare the needed state for setting a wallpaper.  
---|---  
[set (pattern)](<#set>) | Set the current wallpaper.  
[centered (surf, s, background, scale)](<#centered>) | Set a centered wallpaper.  
[tiled (surf, s, offset)](<#tiled>) | Set a tiled wallpaper.  
[maximized (surf, s, ignore_aspect, offset)](<#maximized>) | Set a maximized wallpaper.  
[fit (surf, s, background)](<#fit>) | Set a fitting wallpaper.  
  
  


## Functions

Methods 

**prepare_context (s)**
     Prepare the needed state for setting a wallpaper. This function returns a cairo context through which a wallpaper can be drawn. The context is only valid for a short time and should not be saved in a global variable. 

  * s The screen to set the wallpaper on or nil for all screens 


### Returns:

  1. The available geometry (table with entries width and height)
  2. A cairo context that the wallpaper should be drawn to


**set (pattern)**
     Set the current wallpaper. 

  * pattern The wallpaper that should be set. This can be a cairo surface, a description for gears.color or a cairo pattern. 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**centered (surf, s, background, scale)**
     Set a centered wallpaper. 

  * surf The wallpaper to center. Either a cairo surface or a file name. 
  * s The screen whose wallpaper should be set. Can be nil, in which case all screens are set. 
  * background The background color that should be used. Gets handled via gears.color. The default is black. 
  * scale The scale factor for the wallpaper. Default is 1 (original size). 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**tiled (surf, s, offset)**
     Set a tiled wallpaper. 

  * surf The wallpaper to tile. Either a cairo surface or a file name. 
  * s The screen whose wallpaper should be set. Can be nil, in which case all screens are set. 
  * offset This can be set to a table with entries x and y. 


**maximized (surf, s, ignore_aspect, offset)**
     Set a maximized wallpaper. 

  * surf The wallpaper to set. Either a cairo surface or a file name. 
  * s The screen whose wallpaper should be set. Can be nil, in which case all screens are set. 
  * ignore_aspect If this is true, the image’s aspect ratio is ignored. The default is to honor the aspect ratio. 
  * offset This can be set to a table with entries x and y. 


**fit (surf, s, background)**
     Set a fitting wallpaper. 

  * surf The wallpaper to set. Either a cairo surface or a file name. 
  * s The screen whose wallpaper should be set. Can be nil, in which case all screens are set. 
  * background The background color that should be used. Gets handled via gears.color. The default is black. 


### See also:

[gears.color](<../libraries/gears.color.html#>)