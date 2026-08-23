# Class xproperties - awesome API documentation

**Module:** `classes.xproperties`  

> Source: [classes/xproperties.html](https://awesomewm.org/doc/api/classes/xproperties.html)

---

# Class `xproperties`

Handling of X properties.

This can not be used as a standalone class, but is instead referenced explicitely in the classes, where it can be used. In the respective classes,it then can be used via `classname:get_xproperty(…)` etc.

## [Signals](<#Signals>)

[property::border_color](<#property::border_color>) |   
---|---  
[property::border_width](<#property::border_width>) |   
[property::buttons](<#property::buttons>) |   
[property::opacity](<#property::opacity>) |   
[property::struts](<#property::struts>) |   
[property::type](<#property::type>) |   
  
## [Methods](<#Methods>)

[xproperties:set_xproperty (name, value)](<#xproperties:set_xproperty>) | Change a xproperty.  
---|---  
[xproperties:get_xproperty (name)](<#xproperties:get_xproperty>) | Get the value of a xproperty.  
  
  


## Signals

**property::border_color**
    
**property::border_width**
    
**property::buttons**
    
**property::opacity**
    
**property::struts**
    
**property::type**
    

## Methods

**xproperties:set_xproperty (name, value)**
     Change a xproperty. 

  * name The name of the X11 property 
  * value The new value for the property 


**xproperties:get_xproperty (name)**
     Get the value of a xproperty. 

  * name The name of the X11 property