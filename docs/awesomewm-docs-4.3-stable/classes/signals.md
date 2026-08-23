# Class signals - awesome API documentation

**Module:** `classes.signals`  

> Source: [classes/signals.html](https://awesomewm.org/doc/api/classes/signals.html)

---

# Class `signals`

Handling of signals.

This can not be used as a standalone class, but is instead referenced explicitely in the classes, where it can be used. In the respective classes, it then can be used via `classname:connect_signal(…)` etc.

## [Methods](<#Methods>)

[signals:connect_signal (name, func)](<#signals:connect_signal>) | Add a signal.  
---|---  
[signals:disconnect_signal (name, func)](<#signals:disconnect_signal>) | Remove a signal.  
[signals:emit_signal (name[, ...])](<#signals:emit_signal>) | Emit a signal.  
  
  


## Methods

**signals:connect_signal (name, func)**
     Add a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A signal name. 
  * func func A function to call when the signal is emitted. 


**signals:disconnect_signal (name, func)**
     Remove a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A signal name. 
  * func func A function to remove. 


**signals:emit_signal (name[, ...])**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A signal name. 
  * ... Various arguments. (_optional_)