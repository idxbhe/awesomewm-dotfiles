# Module awesome - awesome API documentation

**Module:** `libraries.awesome`  

> Source: [libraries/awesome.html](https://awesomewm.org/doc/api/libraries/awesome.html)

---

# Module `awesome`

awesome core API

Additionally to the classes described here, one can also use X properties as described in [xproperties](<../classes/xproperties.html#>).

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[register_xproperty (name, type)](<#register_xproperty>) | Register a new xproperty.  
---|---  
[quit ([code=0])](<#quit>) | Quit awesome.  
[exec (cmd)](<#exec>) | Execute another application, probably a window manager, to replace awesome.  
[restart ()](<#restart>) | Restart awesome.  
[kill (pid, sig)](<#kill>) | Send a signal to a process.  
[sync ()](<#sync>) | Synchronize with the X11 server.  
[pixbuf_to_surface (pixbuf, path)](<#pixbuf_to_surface>) | Translate a GdkPixbuf to a cairo image surface..  
[load_image (name)](<#load_image>) | Load an image from a given path.  
[set_preferred_icon_size (size)](<#set_preferred_icon_size>) | Set the preferred size for client icons.  
[connect_signal (name, func)](<#connect_signal>) | Add a global signal.  
[disconnect_signal (name, func)](<#disconnect_signal>) | Remove a global signal.  
[emit_signal (name, ...)](<#emit_signal>) | Emit a global signal.  
[spawn (cmd[, use_sn=true[, stdin=false[, stdout=false[, stderr=false[, exit_callback=nil[, cmd=nil]]]]]])](<#spawn>) | Spawn a program.  
[xkb_set_layout_group (num)](<#xkb_set_layout_group>) | Switch keyboard layout.  
[xkb_get_layout_group ()](<#xkb_get_layout_group>) | Get current layout number.  
[xkb_get_group_names ()](<#xkb_get_group_names>) | Get layout short names.  
  
## [Signals](<#Signals>)

[debug::error](<#debug::error>) | A call into the Lua code aborted with an error.  
---|---  
[debug::deprecation](<#debug::deprecation>) | A deprecated Lua function was called.  
[debug::index::miss](<#debug::index::miss>) | An invalid key was read from an object.  
[debug::newindex::miss](<#debug::newindex::miss>) | An invalid key was written to an object.  
[systray::update](<#systray::update>) | The systray should be updated.  
[wallpaper_changed](<#wallpaper_changed>) | The wallpaper has changed.  
[xkb::map_changed](<#xkb::map_changed>) | Keyboard map has changed.  
[xkb::group_changed.](<#xkb::group_changed.>) | Keyboard group has changed.  
[refresh](<#refresh>) | Refresh.  
[startup](<#startup>) | Awesome is about to enter the event loop.  
[exit](<#exit>) | Awesome is exiting / about to restart.  
[screen::change](<#screen::change>) | The output status of a screen has changed.  
[spawn::canceled](<#spawn::canceled>) | For some reason the application aborted startup  
[spawn::change](<#spawn::change>) | When one of the fields from the [spawn::initiated](<../libraries/awesome.html#spawn::initiated>) table changes  
[spawn::completed](<#spawn::completed>) | An application finished starting  
[spawn::initiated](<#spawn::initiated>) | When a new client is beginning to start  
[spawn::timeout](<#spawn::timeout>) | An application started a spawn event but didn’t start in time.  
  
## [Fields](<#Fields>)

[version](<#version>) | The version of awesome.  
---|---  
[release](<#release>) | The release name of awesome.  
[conffile](<#conffile>) | The configuration file which has been loaded.  
[startup](<#startup>) | True if we are still in startup, false otherwise.  
[startup_errors](<#startup_errors>) | Error message for errors that occured during startup.  
[composite_manager_running](<#composite_manager_running>) | True if a composite manager is running.  
[unix_signal](<#unix_signal>) | Table mapping between signal numbers and signal identifiers.  
[hostname](<#hostname>) | The hostname of the computer on which we are running.  
[themes_path](<#themes_path>) | The path where themes were installed to.  
[icon_path](<#icon_path>) | The path where icons were installed to.  
  
  


## Functions

Methods 

**register_xproperty (name, type)**
     Register a new xproperty. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the X11 property. 
  * type [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) One of “string”, “number” or “boolean”. 


**quit ([code=0])**
     Quit awesome. 

  * code integer The exit code to use when exiting. (_default_ 0) 


**exec (cmd)**
     Execute another application, probably a window manager, to replace awesome. 

  * cmd The command line to execute. 


**restart ()**
     Restart awesome. 
**kill (pid, sig)**
     Send a signal to a process. 

  * pid integer Process identifier. 0 and negative values have special meaning. See `man 3 kill`. 
  * sig integer Signal number. See [awesome.unix_signal](<../libraries/awesome.html#unix_signal>) for a list of signals. 


### Returns:

boolean true if the signal was successfully sent, else false 

**sync ()**
     Synchronize with the X11 server. This is needed in the test suite to avoid some race conditions. You should never need to use this function. 
**pixbuf_to_surface (pixbuf, path)**
     Translate a GdkPixbuf to a cairo image surface.. 

  * pixbuf The pixbuf as a light user datum. 
  * path The pixbuf origin path 


### Returns:

A cairo surface as light user datum. 

**load_image (name)**
     Load an image from a given path. 

  * name The file name. 


### Returns:

A cairo surface as light user datum. 


### Or

  1. nil
  2. [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Error message


**set_preferred_icon_size (size)**
     Set the preferred size for client icons.

The closest equal or bigger size is picked if present, otherwise the closest smaller size is picked. The default is 0 pixels, ie. the smallest icon. 

  * size The size of the icons in pixels. 


**connect_signal (name, func)**
     Add a global signal. 

  * name A string with the event name. 
  * func The function to call. 


**disconnect_signal (name, func)**
     Remove a global signal. 

  * name A string with the event name. 
  * func The function to call. 


**emit_signal (name, ...)**
     Emit a global signal. 

  * name A string with the event name. 
  * ... The signal arguments. 


**spawn (cmd[, use_sn=true[, stdin=false[, stdout=false[, stderr=false[, exit_callback=nil[, cmd=nil]]]]]])**
     Spawn a program. The program will be started on the default screen. 

  * cmd [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The environment to use for the spawned program. Without this the spawned process inherits awesome’s environment. (_default_ nil) 
  * use_sn boolean Use startup-notification? (_default_ true) 
  * stdin boolean Return a fd for stdin? (_default_ false) 
  * stdout boolean Return a fd for stdout? (_default_ false) 
  * stderr boolean Return a fd for stderr? (_default_ false) 
  * exit_callback function Function to call on process exit. The function arguments will be type of exit (“exit” or “signal”) and the exit code / the signal number causing process termination. (_default_ nil) 
  * cmd [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The environment to use for the spawned program. Without this the spawned process inherits awesome’s environment. (_default_ nil) 


### Returns:

  1. integer Process ID if everything is OK.
  2. [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Startup-notification ID, if `use_sn` is true.
  3. integer stdin, if `stdin` is true.
  4. integer stdout, if `stdout` is true.
  5. integer stderr, if `stderr` is true.


### Or

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) An error string if an error occurred. 

**xkb_set_layout_group (num)**
     Switch keyboard layout. 

  * num integer keyboard layout number, integer from 0 to 3 


**xkb_get_layout_group ()**
     Get current layout number. 

### Returns:

integer num Current layout number, integer from 0 to 3. 

**xkb_get_group_names ()**
     Get layout short names. 

### Returns:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A string describing the current layout settings, e.g.: ‘pc+us+de:2+inet(evdev)+group(alt_shift_toggle)+ctrl(nocaps)’ 


## Signals

**debug::error**
     A call into the Lua code aborted with an error.

This signal is used in the example configuration, [05-awesomerc.md](<../documentation/05-awesomerc.md.html#>), to let a notification box pop up. 

### Arguments:

  * err Table with the error object, can be converted to a string with `tostring(err)`. 


**debug::deprecation**
     A deprecated Lua function was called. 

### Arguments:

  * hint [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) String with a hint on what to use instead of the deprecated functionality. 
  * see [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or nil The name of the newer API (_default_ nil) 
  * args [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or nil The name of the newer API (_default_ nil) 


**debug::index::miss**
     An invalid key was read from an object.

This can happen if `foo` in an `c.foo` access does not exist. 

### Arguments:

  * unknown1 Class? 
  * unknown2 Key? 


**debug::newindex::miss**
     An invalid key was written to an object.

This can happen if `foo` in an `c.foo = "bar"` assignment doesn’t exist. 

### Arguments:

  * unknown1 Class? 
  * unknown2 Key? 
  * unknown3 Value? 


**systray::update**
     The systray should be updated.

This signal is used in [wibox.widget.systray](<../classes/wibox.widget.systray.html#>). 
**wallpaper_changed**
     The wallpaper has changed.

This signal is used for pseudo-transparency in [wibox.drawable](<../classes/wibox.drawable.html#>) if no composite manager is running. 
**xkb::map_changed**
     Keyboard map has changed.

This signal is sent after the new keymap has been loaded. It is used in [awful.widget.keyboardlayout](<../classes/awful.widget.keyboardlayout.html#>) to redraw the layout. 
**xkb::group_changed.**
     Keyboard group has changed.

It’s used in [awful.widget.keyboardlayout](<../classes/awful.widget.keyboardlayout.html#>) to redraw the layout. 

### Arguments:

  * group Integer containing the changed group 


**refresh**
     Refresh.

This signal is emitted as a kind of idle signal in the event loop. One example usage is in [gears.timer](<../classes/gears.timer.html#>) to executed delayed calls. 
**startup**
     Awesome is about to enter the event loop.

This means all initialization has been done. 
**exit**
     Awesome is exiting / about to restart.

This signal is emitted in the `atexit` handler as well when awesome restarts. 

### Arguments:

  * reason_restart Boolean value is true if the signal was sent because of a restart. 


**screen::change**
     The output status of a screen has changed. 

### Arguments:

  * output String containing which output has changed. 
  * connection_state String containing the connection status of the output: It will be either “Connected”, “Disconnected” or “Unknown”. 


**spawn::canceled**
     For some reason the application aborted startup 

### Arguments:

  * arg Table which only got the “id” key set 


**spawn::change**
     When one of the fields from the [spawn::initiated](<../libraries/awesome.html#spawn::initiated>) table changes 

### Arguments:

  * arg Table which describes the spawn event 


**spawn::completed**
     An application finished starting 

### Arguments:

  * arg Table which only got the “id” key set 


**spawn::initiated**
     When a new client is beginning to start 

### Arguments:

  * arg Table which describes the spawn event 


**spawn::timeout**
     An application started a spawn event but didn’t start in time. 

### Arguments:

  * arg Table which only got the “id” key set 


## Fields

**version**
     The version of awesome. 

  * version [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**release**
     The release name of awesome. 

  * release [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**conffile**
     The configuration file which has been loaded. 

  * conffile [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**startup**
     True if we are still in startup, false otherwise. 

  * startup boolean


**startup_errors**
     Error message for errors that occured during startup. 

  * startup_errors [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**composite_manager_running**
     True if a composite manager is running. 

  * composite_manager_running boolean


**unix_signal**
     Table mapping between signal numbers and signal identifiers. 

  * unix_signal [table](<https://www.lua.org/manual/5.1/manual.html#5.5>)


**hostname**
     The hostname of the computer on which we are running. 

  * hostname [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**themes_path**
     The path where themes were installed to. 

  * themes_path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


**icon_path**
     The path where icons were installed to. 

  * icon_path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)