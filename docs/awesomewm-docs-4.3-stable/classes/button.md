# Class button - awesome API documentation

**Module:** `classes.button`  

> Source: [classes/button.html](https://awesomewm.org/doc/api/classes/button.html)

---

# Class `button`

awesome button API

Furthermore to the classes described here, one can also use signals as described in [signals](<../classes/signals.html#>).

Some signal names are starting with a dot. These dots are artefacts from the documentation generation, you get the real signal name by removing the starting dot.

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Signals](<#Signals>)

[press](<#button.press>) | When bound mouse button + modifiers are pressed.  
---|---  
[property::button](<#property::button>) | When property changes.  
[property::modifiers](<#property::modifiers>) | When property changes.  
[release](<#button.release>) | When bound mouse button + modifiers are pressed.  
  
## [Tables](<#Tables>)

[button.button](<#button.button>) | Button object.  
---|---  
  
## [Methods](<#Methods>)

[button:instances ()](<#button:instances>) | Get the number of instances.  
---|---  
[button:set_index_miss_handler (cb)](<#button:set_index_miss_handler>) | Set a __index metamethod for all button instances.  
[button:set_newindex_miss_handler (cb)](<#button:set_newindex_miss_handler>) | Set a __newindex metamethod for all button instances.  
[button:disconnect_signal (name, func)](<#button:disconnect_signal>) | Disconnect from a signal.  
[button:emit_signal (name, ...)](<#button:emit_signal>) | Emit a signal.  
[button:connect_signal (name, func)](<#button:connect_signal>) | Connect to a signal.  
  
  


## Signals

**press**
     When bound mouse button + modifiers are pressed. 

### Arguments:

  * ... One or more arguments are possible 


**property::button**
     When property changes. 
**property::modifiers**
     When property changes. 
**release**
     When bound mouse button + modifiers are pressed. 

### Arguments:

  * ... One or more arguments are possible 


## Tables

**button.button**
     Button object. 

### Fields:

  * button int The mouse button number, or 0 for any button. 
  * modifiers [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifier key table that should be pressed while the button is pressed. 


## Methods

**button:instances ()**
     Get the number of instances. 

### Returns:

int The number of button objects alive. 

**button:set_index_miss_handler (cb)**
     Set a __index metamethod for all button instances. 

  * cb function The meta-method 


**button:set_newindex_miss_handler (cb)**
     Set a __newindex metamethod for all button instances. 

  * cb function The meta-method 


**button:disconnect_signal (name, func)**
     Disconnect from a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback that should be disconnected. 


**button:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**button:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.