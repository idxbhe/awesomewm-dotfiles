# Class gears.timer - awesome API documentation

**Module:** `classes.gears.timer`  

> Source: [classes/gears.timer.html](https://awesomewm.org/doc/api/classes/gears.timer.html)

---

# Class `gears.timer`

Timer objects and functions.

### Usage:
    
    -- Create a widget and update its content using the output of a shell
    -- command every 10 seconds:
    local mybatterybar = wibox.widget {
        {
            min_value    = 0,
            max_value    = 100,
            value        = 0,
            paddings     = 1,
            border_width = 1,
            forced_width = 50,
            border_color = "#0000ff",
            id           = "mypb",
            widget       = wibox.widget.progressbar,
        },
        {
            id           = "mytb",
            text         = "100%",
            widget       = wibox.widget.textbox,
        },
        layout      = wibox.layout.stack,
        set_battery = function(self, val)
            self.mytb.text  = tonumber(val).."%"
            self.mypb.value = tonumber(val)
        end,
    }
    
    gears.timer {
        timeout   = 10,
        call_now  = true,
        autostart = true,
        callback  = function()
            -- You should read it from `/sys/class/power_supply/` (on Linux)
            -- instead of spawning a shell. This is only an example.
            awful.spawn.easy_async(
                {"sh", "-c", "acpi | sed -n 's/^.*, \([0-9]*\)%/\1/p'"},
                function(out)
                    mybatterybar.battery = out
                end
            )
        end
    }
    


### Info:

  * **Copyright** : 2014 Uli Schlachter
  * **Author** : Uli Schlachter


## [Functions](<#Functions>)

[gears.timer (args)](<#gears.timer>) | Create a new timer object.  
---|---  
[gears.timer.start_new (timeout, callback)](<#gears.timer.start_new>) | Create a timeout for calling some callback function.  
[gears.timer.weak_start_new (timeout, callback)](<#gears.timer.weak_start_new>) | Create a timeout for calling some callback function.  
[gears.timer.delayed_call (callback, ...)](<#gears.timer.delayed_call>) | Call the given function at the end of the current main loop iteration  
  
## [Object properties](<#Object_properties>)

[started](<#gears.timer.started>) | The timer is started.  
---|---  
[timeout](<#gears.timer.timeout>) | The timer timeout value.  
  
## [Signals](<#Signals>)

[start](<#gears.timer.start>) | When the timer is started.  
---|---  
[stop](<#gears.timer.stop>) | When the timer is stopped.  
[timeout](<#gears.timer.timeout>) | When the timer had a timeout event.  
  
## [Tables](<#Tables>)

[gears.timer.timer](<#gears.timer.timer>) | Timer objects.  
---|---  
  
## [Methods](<#Methods>)

[gears.timer:start ()](<#gears.timer:start>) | Start the timer.  
---|---  
[gears.timer:stop ()](<#gears.timer:stop>) | Stop the timer.  
[gears.timer:again ()](<#gears.timer:again>) | Restart the timer.  
  
  


## Functions

Methods 

**gears.timer (args)**
     Create a new timer object. 

  * args Arguments. 
    * timeout number Timeout in seconds (e.g. 1.5). 
    * autostart boolean Automatically start the timer. (_default_ false) 
    * call_now boolean Call the callback at timer creation. (_default_ false) 
    * callback function Callback function to connect to the “timeout” signal. (_default_ nil) 
    * single_shot boolean Run only once then stop. (_default_ false) 


### Returns:

[timer](<../classes/gears.timer.html>) 

**gears.timer.start_new (timeout, callback)**
     Create a timeout for calling some callback function. When the callback function returns true, it will be called again after the same timeout. If false is returned, no more calls will be done. If the callback function causes an error, no more calls are done. 

  * timeout number Timeout in seconds (e.g. 1.5). 
  * callback function Function to run. 


### Returns:

[timer](<../classes/gears.timer.html>) The timer object that was set up. 


### See also:

[gears.timer.weak_start_new](<../classes/gears.timer.html#gears.timer.weak_start_new>) 

**gears.timer.weak_start_new (timeout, callback)**
     Create a timeout for calling some callback function. This function is almost identical to [gears.timer.start_new](<../classes/gears.timer.html#gears.timer.start_new>). The only difference is that this does not prevent the callback function from being garbage collected. After the callback function was collected, the timer returned will automatically be stopped. 

  * timeout number Timeout in seconds (e.g. 1.5). 
  * callback function Function to start. 


### Returns:

[timer](<../classes/gears.timer.html>) The timer object that was set up. 


### See also:

[gears.timer.start_new](<../classes/gears.timer.html#gears.timer.start_new>) 

**gears.timer.delayed_call (callback, ...)**
     Call the given function at the end of the current main loop iteration 

  * callback function The function that should be called 
  * ... Arguments to the callback function 


## Object properties

**started**
     The timer is started. 

### Type:

  * boolean


**timeout**
     The timer timeout value. **Signal:** property::timeout 

### Type:

  * number


## Signals

**start**
     When the timer is started. 
**stop**
     When the timer is stopped. 
**timeout**
     When the timer had a timeout event. 

## Tables

**gears.timer.timer**
     Timer objects. This type of object is useful when triggering events repeatedly. The timer will emit the “timeout” signal every N seconds, N being the timeout value. Note that a started timer will not be garbage collected. Call `:stop` to enable garbage collection. 

### Fields:

  * timeout number Interval in seconds to emit the timeout signal. Can be any value, including floating point ones (e.g. 1.5 seconds). 
  * started boolean Read-only boolean field indicating if the timer has been started. 


## Methods

**gears.timer:start ()**
     Start the timer. 
**gears.timer:stop ()**
     Stop the timer. 
**gears.timer:again ()**
     Restart the timer. This is equivalent to stopping the timer if it is running and then starting it.