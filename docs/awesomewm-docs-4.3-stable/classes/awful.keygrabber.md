# Class awful.keygrabber - awesome API documentation

**Module:** `classes.awful.keygrabber`  

> Source: [classes/awful.keygrabber.html](https://awesomewm.org/doc/api/classes/awful.keygrabber.html)

---

# Class `awful.keygrabber`

A keyboard grabbing and transaction object.

This module allows to grab all keyboard inputs until stopped. It is used to gather input data (such as in [awful.prompt](<../libraries/awful.prompt.html#>)), implement VI-like keybindings or multi key transactions such as emulating the Alt+Tab behavior.

Note that this module has been redesigned in Awesome 4.3 to be object oriented and stateful. The use of the older global keygrabbing API is discouraged going forward since it had problem with recursive keygrabbers and required a lot of boiler plate code to get anything done.

##  Using keygrabber as transactions

The transactional keybindings are keybindings that start with a normal keybindings, but only end when a (mod)key is released. In the classic “Alt+Tab” transaction, first pressing “Alt+Tab” will display a popup listing all windows (clients). This popup will only disappear when “Alt” is released.
    
    
    awful.keygrabber {
        keybindings = {
            {{'Mod1'         }, 'Tab', awful.client.focus.history.select_previous},
            {{'Mod1', 'Shift'}, 'Tab', awful.client.focus.history.select_next    },
        },
        -- Note that it is using the key name and not the modifier name.
        stop_key           = 'Mod1',
        stop_event         = 'release',
        start_callback     = awful.client.focus.history.disable_tracking,
        stop_callback      = awful.client.focus.history.enable_tracking,
        export_keybindings = true,
    }
    

In that example, because [export_keybindings](<../classes/awful.keygrabber.html#awful.keygrabber.export_keybindings>) is set to `true`, pressing `alt+tab` or `alt+shift+tab` will start the transaction even if the keygrabber is not (yet) running.

##  Using keygrabber for modal keybindings (VI like)

VI-like modal keybindings are trigerred by a key, like `Escape`, followed by either a number, an adjective (or noun) and closed by a verb. For example `<Escape>+2+t+f` could mean “focus (f) the second (2) tag (t)”. `<Escape>+2+h+t+f` would “focus (f) two (2) tags (t) to the right (h)”.

Here is a basic implementation of such a system. Note that the action functions themselves are not implemented to keep the example size and complexity to a minimum. The implementation is just if/elseif of all action and the code can be found in the normal [rc.lua](<../sample files/rc.lua.html#>) keybindings section:
    
    
    local map, actions = {
        verbs = {
            m = 'move' , f = 'focus' , d = 'delete' , a = 'append',
            w = 'swap' , p = 'print' , n = 'new'    ,
        },
        adjectives = { h = 'left'  , j = 'down' , k = 'up'    , l = 'right' , },
        nouns      = { c = 'client', t = 'tag'  , s = 'screen', y = 'layout', },
    }, {}
    
    function actions.client(action, adj) print('IN CLIENT!') end --luacheck: no unused args
    function actions.tag   (action, adj) print('IN TAG!'   ) end --luacheck: no unused args
    function actions.screen(action, adj) print('IN SCREEN!') end --luacheck: no unused args
    function actions.layout(action, adj) print('IN LAYOUT!') end --luacheck: no unused args
    
    local function parse(_, stop_key, _, sequence)
        local parsed, count = { verbs = '', adjectives = '', nouns = '', }, ''
        sequence = sequence..stop_key
    
        for i=1, #sequence do
            local char = sequence:sub(i,i)
            if char >= '0' and char <= '9' then
                count = count .. char
            else
                for kind in pairs(parsed) do
                    parsed[kind] = map[kind][char] or parsed[kind]
                end
            end
        end
    
        if parsed.nouns == '' then return end
        for _=1, count == '' and 1 or tonumber(count) do
            actions[parsed.nouns](parsed.verbs, parsed.adjectives)
        end
    end
    
    awful.keygrabber {
        stop_callback = parse,
        stop_key   = gears.table.keys(map.verbs),
        root_keybingins = {
            {{'Mod4'}, 'v'}
        },
    }
    

##  Using signals

When the keygrabber is running, it will emit signals on each event. The format is “key_name”..“::”..“pressed_or_released”. For example, to attach a callback to `Escape` being pressed, do:
    
    
    mykeygrabber:connect_signal("Escape::pressed", function(self, modifiers, modset)
        print("Escape called!")
    end)
    

The `self` argument is the keygrabber instance. The `modifiers` is a list of all the currently pressed modifiers and the `modset` is the same table, but with the modifiers as keys instead of value. It allow to save time by checking `if modset.Mod4 then … end` instead of looping into the `modifiers` table or using [gears.table](<../libraries/gears.table.html#>).

### Info:

  * **Copyright** : 2012 dodo,2017 Emmanuel Lepage Vallee
  * **Author** : dodo,Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.keygrabber (args)](<#awful.keygrabber>) | A wrapper around the keygrabber to make it easier to add keybindings.  
---|---  
[awful.keygrabber.run (g)](<#awful.keygrabber.run>) | A lower level API to interact with the keygrabber directly.  
[awful.keygrabber.connect_signal (name, callback)](<#awful.keygrabber.connect_signal>) | Connect to a signal for all keygrabbers at once.  
[awful.keygrabber.disconnect_signal (name, callback)](<#awful.keygrabber.disconnect_signal>) | Disconnect to a signal for all keygrabbers at once.  
[awful.keygrabber.emit_signal (name, ...)](<#awful.keygrabber.emit_signal>) | Emit a signal on the keygrabber module itself.  
  
## [Object properties](<#Object_properties>)

[timeout](<#awful.keygrabber.timeout>) | The keygrabber timeout.  
---|---  
[stop_key](<#awful.keygrabber.stop_key>) | The key on which the keygrabber listen to terminate itself.  
[stop_event](<#awful.keygrabber.stop_event>) | The event on which the keygrabbing will be terminated.  
[mask_event_callback](<#awful.keygrabber.mask_event_callback>) | Whether or not to execute the key press/release callbacks when keybindings are called.  
[mask_modkeys](<#awful.keygrabber.mask_modkeys>) | Do not call the callbacks on modifier keys (like `Control` or `Mod4`) events.  
[export_keybindings](<#awful.keygrabber.export_keybindings>) | Export all keygrabber keybindings as root (global) keybindings.  
[root_keybindings](<#awful.keygrabber.root_keybindings>) | The root (global) keybinding to start this keygrabber.  
[keybindings](<#awful.keygrabber.keybindings>) | The keybindings associated with this keygrabber.  
[allowed_keys](<#awful.keygrabber.allowed_keys>) | If any key is pressed that is not in this list, the keygrabber is stopped.  
[sequence](<#awful.keygrabber.sequence>) | The sequence of keys recorded since the start of the keygrabber.  
  
## [Signals](<#Signals>)

[property::current_instance](<#property::current_instance>) | The global signal used to track the [current_instance](<../classes/awful.keygrabber.html#property::current_instance>).  
---|---  
[started](<#awful.keygrabber.started>) | When the keygrabber starts.  
[stopped](<#awful.keygrabber.stopped>) | When the keygrabber stops.  
  
## [Deprecated functions](<#Deprecated_functions>)

[awful.keygrabber.stop](<#awful.keygrabber.stop>) _[deprecated]_ | Stop grabbing the keyboard for the provided callback.  
---|---  
[awful.keygrabber.run](<#awful.keygrabber.run>) _[deprecated]_ | Run a grabbing function.  
  
## [Callback functions prototype](<#Callback_functions_prototype>)

[awful.keygrabber.start_callback](<#awful.keygrabber.start_callback>) | A function called when a keygrabber starts.  
---|---  
[awful.keygrabber.stop_callback](<#awful.keygrabber.stop_callback>) | The callback when the keygrabbing stops.  
[awful.keygrabber.timeout_callback](<#awful.keygrabber.timeout_callback>) | The function called when the keygrabber stops because of a [timeout](<../classes/awful.keygrabber.html#awful.keygrabber.timeout>).  
[awful.keygrabber.keypressed_callback](<#awful.keygrabber.keypressed_callback>) | The callback function to call with mod table, key and command as arguments when a key was pressed.  
[awful.keygrabber.keyreleased_callback](<#awful.keygrabber.keyreleased_callback>) | The callback function to call with mod table, key and command as arguments when a key was released.  
  
## [Fields](<#Fields>)

[awful.keygrabber.current_instance](<#awful.keygrabber.current_instance>) | The current (running) instance of this keygrabber.  
---|---  
[awful.keygrabber.is_running](<#awful.keygrabber.is_running>) | If a keygrabber is currently running.  
  
## [Methods](<#Methods>)

[awful.keygrabber:start ()](<#awful.keygrabber:start>) | Start the keygrabber.  
---|---  
[awful.keygrabber:stop ()](<#awful.keygrabber:stop>) | Stop the keygrabber.  
[awful.keygrabber:add_keybinding (mods, key, callback[, description])](<#awful.keygrabber:add_keybinding>) | Add a keybinding to this keygrabber.  
[awful.keygrabber:emit_signal (name, ...)](<#awful.keygrabber:emit_signal>) | Emit a signal.  
[awful.keygrabber:connect_signal (name, func)](<#awful.keygrabber:connect_signal>) | Connect to a signal.  
[awful.keygrabber:weak_connect_signal (name, func)](<#awful.keygrabber:weak_connect_signal>) | Connect to a signal weakly.  
  
  


## Functions

Methods 

**awful.keygrabber (args)**
     A wrapper around the keygrabber to make it easier to add keybindings.

This is similar to the [awful.prompt](<../libraries/awful.prompt.html#>), but without an actual widget. It can be used to implement custom transactions such as alt+tab or keyboard menu navigation.

Note that the object returned can be used as a client or global keybinding callback without modification. Make sure to set [stop_key](<../classes/awful.keygrabber.html#awful.keygrabber.stop_key>) and [stop_event](<../classes/awful.keygrabber.html#awful.keygrabber.stop_event>) to proper values to avoid permanently locking the keyboard. 

  * args
    * stop_event [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Release event (“press” or “release”) (_default_ "press") 
    * stop_key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The key that has to be kept pressed. (_default_ nil) 
    * keybindings [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) All keybindings. 
    * timeout number The maximum inactivity delay. (_default_ -1) 
    * mask_event_callback boolean Do not call [keypressed_callback](<../classes/awful.keygrabber.html#awful.keygrabber.keypressed_callback>) or [keyreleased_callback](<../classes/awful.keygrabber.html#awful.keygrabber.keyreleased_callback>) when a hook is called. (_default_ true) 
    * start_callback function (_optional_) 
    * stop_callback function (_optional_) 
    * timeout_callback function (_optional_) 
    * keypressed_callback function (_optional_) 
    * keyreleased_callback function (_optional_) 
    * allowed_keys [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or nil A table with all keys that **wont** stop the keygrabber. (_default_ nil) 
    * root_keybindings [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The root (global) keybindings. (_optional_) 
    * export_keybindings boolean Create root (global) keybindings. (_default_ false) 
    * autostart boolean Start the grabbing immediately (_default_ false) 
    * mask_modkeys boolean Do not call the callbacks on modifier keys (like `Control` or `Mod4`) events. (_default_ false) 


**awful.keygrabber.run (g)**
     A lower level API to interact with the keygrabber directly.

Grab keyboard input and read pressed keys, calling the least callback function from the stack at each keypress, until the stack is empty.

Calling run with the same callback again will bring the callback to the top of the stack.

The callback function receives three arguments:

  * a table containing modifiers keys
  * a string with the pressed key
  * a string with either “press” or “release” to indicate the event type.


Here is the content of the modifier table:

Modifier name  | Key name | Alternate key name  
---|---|---  
Mod4|  Super_L |  Super_R   
Control |  Control_L |  Control_R   
Shift |  Shift_L |  Shift_R   
Mod1|  Alt_L |  Alt_R   
  
A callback can return `false` to pass the events to the next keygrabber in the stack. 

  * g The key grabber callback that will get the key events until it will be deleted or a new grabber is added. 


### Returns:

the given callback `g`. 


### Usage:
    
    -- The following function can be bound to a key, and be used to resize a
    -- client using the keyboard.
    
    function resize(c)
      local grabber
      grabber = awful.keygrabber.run(function(mod, key, event)
        if event == "release" then return end
    
        if     key == 'Up'    then c:relative_move(0, 0, 0, 5)
        elseif key == 'Down'  then c:relative_move(0, 0, 0, -5)
        elseif key == 'Right' then c:relative_move(0, 0, 5, 0)
        elseif key == 'Left'  then c:relative_move(0, 0, -5, 0)
        else   awful.keygrabber.stop(grabber)
        end
      end)
    end


**awful.keygrabber.connect_signal (name, callback)**
     Connect to a signal for all keygrabbers at once. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The signal name. 
  * callback function The callback. 


**awful.keygrabber.disconnect_signal (name, callback)**
     Disconnect to a signal for all keygrabbers at once. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The signal name. 
  * callback function The callback. 


**awful.keygrabber.emit_signal (name, ...)**
     Emit a signal on the keygrabber module itself.

Warning, usually don’t use this directly, use `my_keygrabber:emit_signal(name, …)`. This function works on the whole keygrabber module, not one of its instance. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The signal name. 
  * ... Other arguments for the callbacks. 


## Object properties

**timeout**
     The keygrabber timeout. 

### See also:

  * [gears.timer](<../classes/gears.timer.html#>)
  * [timeout_callback](<../classes/awful.keygrabber.html#awful.keygrabber.timeout_callback>)


### Usage:
    
    awful.keygrabber {
        autostart      = true,
        timeout        = 1, -- second
        timeout_callback  = function()
            print('The keygrabber has expired')
        end,
    }


**stop_key**
     The key on which the keygrabber listen to terminate itself.

When this is set, the running keygrabber will quit when [one of] the stop key event occurs.

By default, the event is `press`. It is common for use case like the [awful.prompt](<../libraries/awful.prompt.html#>) where `return` (enter) will terminate the keygrabbing. Using `release` as an event is more appropriate when the keygrabber is tied to a modifier key. For example, an Alt+Tab implementation stops when `mod1` (Alt) is released.

It can also be a table containing many keys (as values).

Please note that modkeys are not accepted as [stop_key](<../classes/awful.keygrabber.html#awful.keygrabber.stop_key>)s. You have to use their corresponding key names such as `Control_L`. 

### Type:

  * string |table stop_key (_default_ nil) 


### See also:

[stop_event](<../classes/awful.keygrabber.html#awful.keygrabber.stop_event>) 

**stop_event**
    

The event on which the keygrabbing will be terminated.

the valid values are:

  * “press” (default)
  * “release”


### Type:

  * string


### See also:

[stop_key](<../classes/awful.keygrabber.html#awful.keygrabber.stop_key>) 

**mask_event_callback**
     Whether or not to execute the key press/release callbacks when keybindings are called.

When this property is set to false, the [keyreleased_callback](<../classes/awful.keygrabber.html#awful.keygrabber.keyreleased_callback>) and [keypressed_callback](<../classes/awful.keygrabber.html#awful.keygrabber.keypressed_callback>) callbacks will be executed even when the event was consumed by a `keybinding`.

By default, keybindings block those callbacks from being executed. 

### Type:

  * boolean (_default_ true) 


### See also:

  * [keybindings](<../classes/awful.keygrabber.html#awful.keygrabber.keybindings>)
  * [keyreleased_callback](<../classes/awful.keygrabber.html#awful.keygrabber.keyreleased_callback>)
  * [keypressed_callback](<../classes/awful.keygrabber.html#awful.keygrabber.keypressed_callback>)


**mask_modkeys**
     Do not call the callbacks on modifier keys (like `Control` or `Mod4`) events. 

### Type:

  * boolean (_default_ false) 


### See also:

[mask_event_callback](<../classes/awful.keygrabber.html#awful.keygrabber.mask_event_callback>) 

**export_keybindings**
     Export all keygrabber keybindings as root (global) keybindings.

When this is enabled, calling all of the keygrabber object `keybinding`s will will create root [awful.key](<../libraries/awful.key.html#>) and will automatically starts the grabbing.

Use this with caution. If many keygrabber or “real” root keybindings are set on the same key combination, they are all executed and there is almost no safe way to undo that. Make sure the [keygrabber](<../classes/awful.keygrabber.html>) that use this option have a single instance. 

### Type:

  * boolean (_default_ false) 


**root_keybindings**
    

The root (global) keybinding to start this keygrabber.

Instead of adding an entry to [root.keys](<../libraries/root.html#keys>) or [rc.lua](<../sample files/rc.lua.html#>) `globalkeys` section, this property can be used to take care of everything. This way, it becomes easier to package modules using keygrabbers.

**Usage example output** :
    
    
    Is now active!  nil
    A key was pressed:  a   with    0   modifier!
    A key was pressed:  i   with    1   modifier!
    Called again!
    

### See also:

  * [export_keybindings](<../classes/awful.keygrabber.html#awful.keygrabber.export_keybindings>)
  * [keybindings](<../classes/awful.keygrabber.html#awful.keygrabber.keybindings>)


### Usage:
    
    awful.keygrabber {
        mask_modkeys = true,
        root_keybindings = {
            {{'Mod4'}, 'i', function(self)
                print('Is now active!', self)
            end},
        },
        keybindings = {
            {{'Mod4', 'Shift'}, 'i', function(self)
                print('Called again!')
                self:stop()
            end},
        },
        keypressed_callback  = function(_, modifiers, key)
            print('A key was pressed:', key, 'with', #modifiers, 'modifier!')
        end,
    }
    
    -- The following will **NOT** trigger the keygrabbing because it isn't exported
    -- to the root (global) keys. Adding [export_keybindings](<../classes/awful.keygrabber.html#awful.keygrabber.export_keybindings>) would solve that
    root._execute_keybinding({'Mod4', 'Shift'}, 'i')
    assert(#keybinding_works == 0)
    
    -- But this will start the keygrabber because it is part of the root_keybindings
    root._execute_keybinding({'Mod4'}, 'i')
    
    -- Note that that keygrabber is running, all callbacks should work:
    root.fake_input('key_press'  , 'a')
    root.fake_input('key_release'  , 'a')
    
    -- Calling the root keybindings now wont work because they are not part of
    -- the keygrabber internal (own) keybindings, so [keypressed_callback](<../classes/awful.keygrabber.html#awful.keygrabber.keypressed_callback>) will
    -- be called.
    root._execute_keybinding({'Mod4'}, 'i')
    
    -- Now the keygrabber own keybindings will work
    root._execute_keybinding({'Mod4', 'Shift'}, 'i')


**keybindings**
    

The keybindings associated with this keygrabber.

The keybindings syntax is the same as [awful.key](<../libraries/awful.key.html#>) or `awful.prompt.hooks`. It consists of a table with 4 entries.

  * `mods` A table with modifier keys, such as `shift`, `mod4`, `mod1` (alt) or `control`.
  * [key](<../classes/key.html#>) The key name, such as `left` or `f`
  * `callback` A function that will be called when the key combination is pressed.
  * `description` A table various metadata to be used for [awful.hotkeys_popup](<../libraries/awful.hotkeys_popup.html#>).


### Type:

  * table


### See also:

  * [export_keybindings](<../classes/awful.keygrabber.html#awful.keygrabber.export_keybindings>)
  * [root_keybindings](<../classes/awful.keygrabber.html#awful.keygrabber.root_keybindings>)


**allowed_keys**
     If any key is pressed that is not in this list, the keygrabber is stopped.

When defined, this property allows to define an implicit way to release the keygrabber. It helps save some boilerplate code in the handler callbacks.

It is useful when a transaction only handle a limited number of keys. If a key unhandled by the transaction is trigerred, the transaction is canceled. 

### Type:

  * allowed_keys [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or nil The list of keys. (_default_ nil) 


### Usage:
    
    awful.keygrabber {
        autostart      = true,
        allowed_keys   = {'a', 'w', 'e', 's', 'o', 'm', 'e'},
    }


**sequence**
     The sequence of keys recorded since the start of the keygrabber.

In this example, the [stop_callback](<../classes/awful.keygrabber.html#awful.keygrabber.stop_callback>) is used to retrieve the final key sequence.

Please note that backspace will remove elements from the sequence and named keys and modifiers are ignored. 

### Type:

  * string


### Usage:
    
    awful.keygrabber {
        autostart      = true,
        stop_key    = 'Return',
        stop_callback  = function(_, _, _, sequence)
            naughty.notify{text='The keys were:'..sequence}
        end,
    }


## Signals

**property::current_instance**
     The global signal used to track the [current_instance](<../classes/awful.keygrabber.html#property::current_instance>). 
**started**
     When the keygrabber starts. 
**stopped**
     When the keygrabber stops. 

## Deprecated functions

**awful.keygrabber.stop _[deprecated]_**
     Stop grabbing the keyboard for the provided callback. When no callback is given, the last grabber gets removed (last one added to the stack). param:

  * g The key grabber that must be removed. (_optional_) 


**awful.keygrabber.run _[deprecated]_**
     Run a grabbing function. Calling this is equivalent to [keygrabber.run](<../classes/awful.keygrabber.html#awful.keygrabber.run>). param:

  * g The key grabber callback that will get the key events until it will be deleted or a new grabber is added. 

See also:

[keygrabber.run](<../classes/awful.keygrabber.html#awful.keygrabber.run>) 

Callback functions prototype

**awful.keygrabber.start_callback**
     A function called when a keygrabber starts. Parameters:

  * keygrabber [keygrabber](<../classes/awful.keygrabber.html>) The keygrabber. 


**awful.keygrabber.stop_callback**
     The callback when the keygrabbing stops. Parameters:

  * self [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current transaction object. 
  * stop_key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key(s) that stop the keygrabbing (if any) 
  * stop_mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The modifiers key (if any) 
  * sequence sting The recorded key sequence. 

See also:

  * [sequence](<../classes/awful.keygrabber.html#awful.keygrabber.sequence>)
  * [stop](<../classes/awful.keygrabber.html#awful.keygrabber.stop>)

Usage:
    
    local function my_done_cb(self, stop_key, stop_mods, sequence)
       -- do something
    end


**awful.keygrabber.timeout_callback**
     The function called when the keygrabber stops because of a [timeout](<../classes/awful.keygrabber.html#awful.keygrabber.timeout>). Note that the [stop_callback](<../classes/awful.keygrabber.html#awful.keygrabber.stop_callback>) is also called when the keygrabbers timeout. See also:

[timeout](<../classes/awful.keygrabber.html#awful.keygrabber.timeout>) 

**awful.keygrabber.keypressed_callback**
     The callback function to call with mod table, key and command as arguments when a key was pressed. Parameters:

  * self [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current transaction object. 
  * mod [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current modifiers (like “Control” or “Shift”). 
  * key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key name. 
  * event [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The event (“press” or “release”). 

Usage:
    
    local function my_keypressed_cb(mod, key, command)
       -- do something
    end


**awful.keygrabber.keyreleased_callback**
     The callback function to call with mod table, key and command as arguments when a key was released. Parameters:

  * self [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current transaction object. 
  * mod [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current modifiers (like “Control” or “Shift”). 
  * key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key name. 
  * event [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The event (“press” or “release”) 

Usage:
    
    local function my_keyreleased_cb(mod, key, command)
       -- do something
    end


Fields

**awful.keygrabber.current_instance**
     The current (running) instance of this keygrabber. The keygrabber instance is created when the keygrabber starts. It is an object mirroring this keygrabber object, but where extra properties can be added. It is useful to keep some contextual data part of the current transaction without poluting the original object of having extra boilerplate code. 

  * current_instance [keygrabber](<../classes/awful.keygrabber.html>)

See also:

[property::current_instance](<../classes/awful.keygrabber.html#property::current_instance>) 

**awful.keygrabber.is_running**
     If a keygrabber is currently running. 

  * is_running boolean


Methods

**awful.keygrabber:start ()**
     Start the keygrabber. Note that only a single keygrabber can be started at any one time. If another keygrabber (or this one) is currently running. This method returns false. Returns:

boolean If the keygrabber was successfully started. 

**awful.keygrabber:stop ()**
     Stop the keygrabber. 
**awful.keygrabber:add_keybinding (mods, key, callback[, description])**
     Add a keybinding to this keygrabber. Those keybindings will automatically start the keygrabbing when hit. 

  * mods [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with modifier keys, such as `shift`, `mod4`, `mod1` (alt) or `control`. 
  * key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key name, such as `left` or `f`
  * callback function A function that will be called when the key combination is pressed. 
  * description A table various metadata to be used for [awful.hotkeys_popup](<../libraries/awful.hotkeys_popup.html#>). 
    * description [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The keybinding description 
    * group [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The keybinding group 


**awful.keygrabber:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**awful.keygrabber:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**awful.keygrabber:weak_connect_signal (name, func)**
     Connect to a signal weakly. This allows the callback function to be garbage collected and automatically disconnects the signal when that happens. **Warning:** Only use this function if you really, really, really know what you are doing. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted.