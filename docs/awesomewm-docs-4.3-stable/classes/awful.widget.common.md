# Class awful.widget.common - awesome API documentation

**Module:** `classes.awful.widget.common`  

> Source: [classes/awful.widget.common.html](https://awesomewm.org/doc/api/classes/awful.widget.common.html)

---

# Class `awful.widget.common`

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Methods](<#Methods>)

[awful.widget.common:create_buttons (buttons, object)](<#awful.widget.common:create_buttons>) | Common method to create buttons.  
---|---  
[awful.widget.common:list_update (w, buttons, label, data, objects[, args={}])](<#awful.widget.common:list_update>) | Common update method.  
  
  


## Methods

**awful.widget.common:create_buttons (buttons, object)**
     Common method to create buttons. 

  * buttons [table](<https://www.lua.org/manual/5.1/manual.html#5.5>)
  * object


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) 

**awful.widget.common:list_update (w, buttons, label, data, objects[, args={}])**
     Common update method. 

  * w The widget. 
  * buttons [table](<https://www.lua.org/manual/5.1/manual.html#5.5>)
  * label func Function to generate label parameters from an object. The function gets passed an object from `objects`, and has to return `text`, `bg`, `bg_image`, `icon`. 
  * data [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Current data/cache, indexed by objects. 
  * objects [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Objects to be displayed / updated. 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) (_default_ {})