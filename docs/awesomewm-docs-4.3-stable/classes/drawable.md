# Class drawable - awesome API documentation

**Module:** `classes.drawable`  

> Source: [classes/drawable.html](https://awesomewm.org/doc/api/classes/drawable.html)

---

# Class `drawable`

awesome drawable API

Furthermore to the classes described here, one can also use signals as described in [signals](<../classes/signals.html#>).

### Info:

  * **Copyright** : 2012 Uli Schlachter
  * **Author** : Uli Schlachter <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Signals](<#Signals>)

[button::press](<#button::press>) |   
---|---  
[button::release](<#button::release>) |   
[mouse::enter](<#mouse::enter>) |   
[mouse::leave](<#mouse::leave>) |   
[mouse::move](<#mouse::move>) |   
[property::geometry](<#property::geometry>) |   
[property::height](<#property::height>) |   
[property::width](<#property::width>) |   
[property::x](<#property::x>) |   
[property::y](<#property::y>) |   
[property::surface](<#property::surface>) |   
  
## [Methods](<#Methods>)

[drawable:drawable ()](<#drawable:drawable>) | Drawable object.  
---|---  
[drawable:instances ()](<#drawable:instances>) | Get the number of instances.  
[drawable:set_index_miss_handler (cb)](<#drawable:set_index_miss_handler>) | Set a __index metamethod for all drawable instances.  
[drawable:set_newindex_miss_handler (cb)](<#drawable:set_newindex_miss_handler>) | Set a __newindex metamethod for all drawable instances.  
[drawable:refresh ()](<#drawable:refresh>) | Refresh a drawable’s content.  
[drawable:geometry ()](<#drawable:geometry>) | Get drawable geometry.  
  
  


## Signals

**button::press**
    
**button::release**
    
**mouse::enter**
    
**mouse::leave**
    
**mouse::move**
    
**property::geometry**
    
**property::height**
    
**property::width**
    
**property::x**
    
**property::y**
    
**property::surface**
    

## Methods

**drawable:drawable ()**
     Drawable object. 
**drawable:instances ()**
     Get the number of instances. 

### Returns:

The number of drawable objects alive. 

**drawable:set_index_miss_handler (cb)**
     Set a __index metamethod for all drawable instances. 

  * cb function The meta-method 


**drawable:set_newindex_miss_handler (cb)**
     Set a __newindex metamethod for all drawable instances. 

  * cb function The meta-method 


**drawable:refresh ()**
     Refresh a drawable’s content. This has to be called whenever some drawing to the drawable’s surface has been done and should become visible. 
**drawable:geometry ()**
     Get drawable geometry. The geometry consists of x, y, width and height. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with drawable coordinates and geometry.