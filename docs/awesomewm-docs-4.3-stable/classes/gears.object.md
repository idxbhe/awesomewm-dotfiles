# Class gears.object - awesome API documentation

**Module:** `classes.gears.object`  

> Source: [classes/gears.object.html](https://awesomewm.org/doc/api/classes/gears.object.html)

---

# Class `gears.object`

The object oriented programming base class used by various Awesome widgets and components.

It provide basic observer pattern, signaling and dynamic properties.

### Info:

  * **Copyright** : 2010 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[gears.object ([args={}])](<#gears.object>) | Returns a new object.  
---|---  
  
## [Methods](<#Methods>)

[gears.object:connect_signal (name, func)](<#gears.object:connect_signal>) | Connect to a signal.  
---|---  
[gears.object:weak_connect_signal (name, func)](<#gears.object:weak_connect_signal>) | Connect to a signal weakly.  
[gears.object:disconnect_signal (name, func)](<#gears.object:disconnect_signal>) | Disonnect to a signal.  
[gears.object:emit_signal (name, ...)](<#gears.object:emit_signal>) | Emit a signal.  
[gears.object:modulename ([level=2])](<#gears.object:modulename>) | Helper function to get the module name out of `debug.getinfo`.  
  
## [lib.gears.object.properties Functions](<#lib_gears_object_properties_Functions>)

[gears.object.properties.capi_index_fallback (class[, args={}])](<#gears.object.properties.capi_index_fallback>) | Add the missing properties handler to a CAPI object such as client/tag/screen.  
---|---  
  
  


## Functions

Methods 

**gears.object ([args={}])**
    

Returns a new object. You can call `:emit_signal()`, `:disconnect_signal()` and `:connect_signal()` on the resulting object.

Note that `args.enable_auto_signals` is only supported when `args.enable_properties` is true.

**Usage example output** :
    
    
    In get foo  bar
    bar
    In set foo  42
    In get foo  42
    42
    In a method 1   2   3
    nil
    In the connection handler!  a cow
    a cow
    

  * args The arguments 
    * enable_properties boolean Automatically call getters and setters (_default_ false) 
    * enable_auto_signals boolean Generate “property::xxxx” signals when an unknown property is set. (_default_ false) 
    * class [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) (_default_ nil) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new object 


### Usage:
    
    -- Create a class for this object. It will be used as a backup source for
    -- methods and accessors. It is also possible to set them directly on the
    -- object.
    local class = {}
    function class:get_foo()
        print('In get foo', self._foo or 'bar')
        return self._foo or 'bar'
    end
    function class:set_foo(value)
        print('In set foo', value)
        -- In case it is necessary to bypass the object property system, use
        -- [rawset](<https://www.lua.org/manual/5.1/manual.html#pdf-rawset>)
        rawset(self, '_foo', value)
        -- When using custom accessors, the signals need to be handled manually
        self:emit_signal('property::foo', value)
    end
    function class:method(a, b, c)
        print('In a method', a, b, c)
    end
    local o = gears.object {
        class               = class,
        enable_properties   = true,
        enable_auto_signals = true,
    }
    print(o.foo)
    o.foo = 42
    print(o.foo)
    o:method(1, 2, 3)
    -- Random properties can also be added, the signal will be emitted automatically.
    o:connect_signal('property::something', function(obj, value)
        assert(obj == o)
        print('In the connection handler!', value)
    end)
    print(o.something)
    o.something = 'a cow'
    print(o.something)


## Methods

**gears.object:connect_signal (name, func)**
    

Connect to a signal.

**Usage example output** :
    
    
    In slot [obj]   nil nil nil
    In slot [obj]   foo bar 42
    

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal 
  * func function The callback to call when the signal is emitted 


### Usage:
    
    local o = gears.object{}
    -- Function can be attached to signals
    local function slot(obj, a, b, c)
        print('In slot', obj, a, b, c)
    end
    o:connect_signal('my_signal', slot)
    -- Emitting can be done without arguments. In that case, the object will be
    -- implicitly added as an argument.
    o:emit_signal 'my_signal'
    -- It is also possible to add as many random arguments are required.
    o:emit_signal('my_signal', 'foo', 'bar', 42)
    -- Finally, to allow the object to be garbage collected (the memory freed), it
    -- is necessary to disconnect the signal or use [weak_connect_signal](<../classes/gears.object.html#gears.object:weak_connect_signal>)
    o:disconnect_signal('my_signal', slot)
    -- This time, the slot wont be called as it is no longer connected.
    o:emit_signal 'my_signal'


**gears.object:weak_connect_signal (name, func)**
     Connect to a signal weakly. This allows the callback function to be garbage collected and automatically disconnects the signal when that happens. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal 
  * func function The callback to call when the signal is emitted 


**gears.object:disconnect_signal (name, func)**
     Disonnect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal 
  * func function The callback that should be disconnected 


**gears.object:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal() 


**gears.object:modulename ([level=2])**
     Helper function to get the module name out of `debug.getinfo`. 

  * level integer Level for `debug.getinfo(level, "S")`. Typically 2 or 3. (_default_ 2) 


### Returns:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The module name, e.g. “wibox.container.background”. 


### Usage:
    
    local mt = {}
    mt.__tostring = function(o)
        return require("gears.object").modulename(2)
    end
    return setmetatable(ret, mt)


## lib.gears.object.properties Functions

**gears.object.properties.capi_index_fallback (class[, args={}])**
    

Add the missing properties handler to a CAPI object such as client/tag/screen. Valid args:

  * **getter** : A smart getter (handle property getter itself)
  * **getter_fallback** : A dumb getter method (don’t handle individual property getter)
  * **getter_class** : A module with individual property getter/setter
  * **getter_prefix** : A special getter prefix (like “get” or “get_” (default))
  * **setter** : A smart setter (handle property setter itself)
  * **setter_fallback** : A dumb setter method (don’t handle individual property setter)
  * **setter_class** : A module with individual property getter/setter
  * **setter_prefix** : A special setter prefix (like “set” or “set_” (default))
  * **auto_emit** : Emit “property::___” automatically (default: false). This is ignored when setter_fallback is set or a setter is found


  * class A standard luaobject derived object 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A set of accessors configuration parameters (_default_ {})