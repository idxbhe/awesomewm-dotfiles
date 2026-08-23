# Class key - awesome API documentation

**Module:** `classes.key`  

> Source: [classes/key.html](https://awesomewm.org/doc/api/classes/key.html)

---

# Class `key`

awesome key API

Furthermore to the classes described here, one can also use signals as described in [signals](<../classes/signals.html#>).

Some signal names are starting with a dot. These dots are artefacts from the documentation generation, you get the real signal name by removing the starting dot.

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Signals](<#Signals>)

[press](<#key.press>) |   
---|---  
[property::key](<#property::key>) |   
[property::modifiers](<#property::modifiers>) |   
[release](<#key.release>) |   
  
## [Tables](<#Tables>)

[key.key](<#key.key>) | Key object.  
---|---  
  
## [Methods](<#Methods>)

[key:instances ()](<#key:instances>) | Get the number of instances.  
---|---  
[key:set_index_miss_handler (cb)](<#key:set_index_miss_handler>) | Set a __index metamethod for all key instances.  
[key:set_newindex_miss_handler (cb)](<#key:set_newindex_miss_handler>) | Set a __newindex metamethod for all key instances.  
[key:disconnect_signal (name, func)](<#key:disconnect_signal>) | Disconnect from a signal.  
[key:emit_signal (name, ...)](<#key:emit_signal>) | Emit a signal.  
[key:connect_signal (name, func)](<#key:connect_signal>) | Connect to a signal.  
  
  


## Signals

**press**
    
**property::key**
    
**property::modifiers**
    
**release**
    

## Tables

**key.key**
     Key object. 

### Fields:

  * key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key to trigger an event. 
  * keysym [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Same as key, but return the name of the key symbol. It can be identical to key, but for characters like ‘.’ it will return ‘period’. 
  * modifiers [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifier key that should be pressed while the key is pressed. An array with all the modifiers. Valid modifiers are: Any, Mod1, Mod2, Mod3, Mod4, Mod5, Shift, Lock and Control. 


## Methods

**key:instances ()**
     Get the number of instances. 

### Returns:

The number of key objects alive. 

**key:set_index_miss_handler (cb)**
     Set a __index metamethod for all key instances. 

  * cb function The meta-method 


**key:set_newindex_miss_handler (cb)**
     Set a __newindex metamethod for all key instances. 

  * cb function The meta-method 


**key:disconnect_signal (name, func)**
     Disconnect from a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback that should be disconnected. 


**key:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**key:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.