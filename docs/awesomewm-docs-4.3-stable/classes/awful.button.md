# Class awful.button - awesome API documentation

**Module:** `classes.awful.button`  

> Source: [classes/awful.button.html](https://awesomewm.org/doc/api/classes/awful.button.html)

---

# Class `awful.button`

Create easily new buttons objects ignoring certain modifiers.

### Info:

  * **Copyright** : 2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Tables](<#Tables>)

[awful.button.ignore_modifiers](<#awful.button.ignore_modifiers>) | Modifiers to ignore.  
---|---  
  
## [Methods](<#Methods>)

[awful.button:new (mod, _button, press, release)](<#awful.button:new>) | Create a new button to use as binding.  
---|---  
  
  


## Tables

**awful.button.ignore_modifiers**
     Modifiers to ignore.

By default this is initialized as `{ "Lock", "Mod2" }` so the `Caps Lock` or `Num Lock` modifier are not taking into account by awesome when pressing keys. 

### Fields:

  * Lock
  * Mod2


## Methods

**awful.button:new (mod, _button, press, release)**
     Create a new button to use as binding.

This function is useful to create several buttons from one, because it will use the ignore_modifier variable to create more button with or without the ignored modifiers activated.

For example if you want to ignore CapsLock in your buttonbinding (which is ignored by default by this function), creating button binding with this function will return 2 button objects: one with CapsLock on, and the other one with CapsLock off. 

  * mod
  * _button
  * press
  * release


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with one or several button objects. 


### See also:

[button](<../classes/button.html#>)