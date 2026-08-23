# Module gears.protected_call - awesome API documentation

**Module:** `libraries.gears.protected_call`  

> Source: [libraries/gears.protected_call.html](https://awesomewm.org/doc/api/libraries/gears.protected_call.html)

---

# Module `gears.protected_call`

### Info:

  * **Copyright** : 2016 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[call (func, ...)](<#call>) | Call a function in protected mode and handle error-reporting.  
---|---  
  
  


## Functions

Methods 

**call (func, ...)**
     Call a function in protected mode and handle error-reporting. If the function call succeeds, all results of the function are returned. Otherwise, an error message is printed and nothing is returned. 

  * func function The function to call 
  * ... Arguments to the function 


### Returns:

The result of the given function, or nothing if an error occurred.