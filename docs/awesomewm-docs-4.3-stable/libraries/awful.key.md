# Module awful.key - awesome API documentation

**Module:** `libraries.awful.key`  

> Source: [libraries/awful.key.html](https://awesomewm.org/doc/api/libraries/awful.key.html)

---

# Module `awful.key`

Create easily new key objects ignoring certain modifiers.

### Info:

  * **Copyright** : 2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[execute (mod, k)](<#execute>) | Execute a key combination.  
---|---  
[new (mod, _key, press[, release], data)](<#new>) | Create a new key to use as binding.  
[match (_key, pressed_mod, pressed_key)](<#match>) | Compare a key object with modifiers and key.  
  
## [Tables](<#Tables>)

[awful.key.ignore_modifiers](<#awful.key.ignore_modifiers>) | Modifiers to ignore.  
---|---  
  
  


## Functions

Methods 

**execute (mod, k)**
     Execute a key combination. If an awesome keybinding is assigned to the combination, it should be executed.

To limit the chances of accidentally leaving a modifier key locked when calling this function from a keybinding, make sure is attached to the release event and not the press event. 

  * mod [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A modified table. Valid modifiers are: Any, Mod1, Mod2, Mod3, Mod4, Mod5, Shift, Lock and Control. 
  * k [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key 


### See also:

[root.fake_input](<../libraries/root.html#fake_input>) 

**new (mod, _key, press[, release], data)**
     Create a new key to use as binding. This function is useful to create several keys from one, because it will use the ignore_modifier variable to create several keys with and without the ignored modifiers activated. For example if you want to ignore CapsLock in your keybinding (which is ignored by default by this function), creating a key binding with this function will return 2 key objects: one with CapsLock on, and another one with CapsLock off. 

  * mod [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A list of modifier keys. Valid modifiers are: Any, Mod1, Mod2, Mod3, Mod4, Mod5, Shift, Lock and Control. 
  * _key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key to trigger an event. 
  * press function Callback for when the key is pressed. 
  * release function Callback for when the key is released. (_optional_) 
  * data [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) User data for key, for example {description=“select next tag”, group=“tag”}. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with one or several key objects. 


### See also:

[key.key](<../classes/key.html#property::key>) 

**match (_key, pressed_mod, pressed_key)**
     Compare a key object with modifiers and key. 

  * _key The key object. 
  * pressed_mod The modifiers to compare with. 
  * pressed_key The key to compare with. 


## Tables

**awful.key.ignore_modifiers**
     Modifiers to ignore. By default this is initialized as { “Lock”, “Mod2” } so the Caps Lock or Num Lock modifier are not taking into account by awesome when pressing keys. 

### Fields:

  * Lock
  * Mod2