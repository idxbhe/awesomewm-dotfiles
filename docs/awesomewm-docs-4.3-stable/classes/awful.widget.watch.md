# Class awful.widget.watch - awesome API documentation

**Module:** `classes.awful.widget.watch`  

> Source: [classes/awful.widget.watch.html](https://awesomewm.org/doc/api/classes/awful.widget.watch.html)

---

# Class `awful.widget.watch`

Watch widget.

Here is an example of simple temperature widget which will update each 15 seconds implemented in two different ways. The first, simpler one, will just display the return command output (so output is stripped by shell commands). In the other example `sensors` returns to the widget its full output and it’s trimmed in the widget callback function:
    
    
    211             mytextclock,
    212             wibox.widget.textbox('  |  '),
    213             -- one way to do that:
    214             awful.widget.watch('bash -c "sensors | grep temp1"', 15),
    215             -- another way:
    216             awful.widget.watch('sensors', 15, function(widget, stdout)
    217               for line in stdout:gmatch("[^\r\n]+") do
    218                 if line:match("temp1") then
    219                   widget:set_text(line)
    220                   return
    221                 end
    222               end
    223             end),
    224             s.mylayoutbox,
    

![Example screenshot](../images/awful_widget_watch.png)

### Info:

  * **Copyright** : 2015, 2016 Benjamin Petrenko, Yauheni Kirylau
  * **Author** : Benjamin Petrenko,Yauheni Kirylau


## [Methods](<#Methods>)

[awful.widget.watch:new (command[, timeout=5][, callback], base_widget)](<#awful.widget.watch:new>) | Create a textbox that shows the output of a command and updates it at a given time interval.  
---|---  
  
  


## Methods

**awful.widget.watch:new (command[, timeout=5][, callback], base_widget)**
     Create a textbox that shows the output of a command and updates it at a given time interval. 

  * command [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The command. 
  * timeout integer The time interval at which the textbox will be updated. (_default_ 5) 
  * callback The function that will be called after the command output will be received. it is shown in the textbox. Defaults to: function(widget, stdout, stderr, exitreason, exitcode) widget:set_text(stdout) end 
    * widget Base widget instance. 
    * stdout [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Output on stdout. 
    * stderr [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Output on stderr. 
    * exitreason [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Exit Reason. The reason can be “exit” or “signal”. 
    * exitcode integer Exit code. For “exit” reason it’s the exit code. For “signal” reason — the signal causing process termination. 
  * base_widget Base widget. (_default_ wibox.widget.textbox()) 


### Returns:

  1. The widget used by this watch.
  2. Its gears.timer.