# Module gears.debug - awesome API documentation

**Module:** `libraries.gears.debug`  

> Source: [libraries/gears.debug.html](https://awesomewm.org/doc/api/libraries/gears.debug.html)

---

# Module `gears.debug`

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[dump_return (data, tag[, depth])](<#dump_return>) | Inspect the value in data.  
---|---  
[dump (data, tag[, depth])](<#dump>) | Print the table (or any other value) to the console.  
[print_warning (message)](<#print_warning>) | Print an warning message  
[print_error (message)](<#print_error>) | Print an error message  
[deprecate ([see], args)](<#deprecate>) | Display a deprecation notice, but only once per traceback.  
[deprecate_class (fallback, old_name, new_name)](<#deprecate_class>) | Create a class proxy with deprecation messages.  
  
  


## Functions

Methods 

**dump_return (data, tag[, depth])**
     Inspect the value in data. 

  * data Value to inspect. 
  * tag The name of the value. 
  * depth int Depth of recursion. (_optional_) 


### Returns:

string A string that contains the expanded value of data. 

**dump (data, tag[, depth])**
     Print the table (or any other value) to the console. 

  * data Table to print. 
  * tag The name of the table. 
  * depth int Depth of recursion. (_optional_) 


**print_warning (message)**
     Print an warning message 

  * message [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The warning message to print 


**print_error (message)**
     Print an error message 

  * message [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The error message to print 


**deprecate ([see], args)**
     Display a deprecation notice, but only once per traceback.

This function also emits the `debug::deprecate` signal on the [awesome](<../libraries/awesome.html#>) global object. 

  * see The message to a new method / function to use. (_optional_) 
  * args Extra arguments 
    * raw boolean Print the message as-is without the automatic context 
    * deprecated_in integer Print the message only when Awesome’s version is equal to or greater than deprecated_in. 


**deprecate_class (fallback, old_name, new_name)**
     Create a class proxy with deprecation messages. This is useful when a class has moved somewhere else. 

  * fallback [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new class 
  * old_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The old class name 
  * new_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The new class name 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A proxy class.