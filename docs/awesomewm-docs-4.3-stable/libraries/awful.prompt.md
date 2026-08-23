# Module awful.prompt - awesome API documentation

**Module:** `libraries.awful.prompt`  

> Source: [libraries/awful.prompt.html](https://awesomewm.org/doc/api/libraries/awful.prompt.html)

---

# Module `awful.prompt`

Prompt module for awful.

**Keyboard navigation** :

The following readline keyboard shortcuts are implemented as expected:  Name| Usage  
---|---  
`CTRL+A`| beginning-of-line  
`CTRL+B`| backward-char  
`CTRL+C`| cancel  
`CTRL+D`| delete-char  
`CTRL+E`| end-of-line  
`CTRL+J`| accept-line  
`CTRL+M`| accept-line  
`CTRL+F`| move-cursor-right  
`CTRL+H`| backward-delete-char  
`CTRL+K`| kill-line  
`CTRL+U`| unix-line-discard  
`CTRL+W`| unix-word-rubout  
`CTRL+BACKSPACE`| unix-word-rubout  
`SHIFT+INSERT`| paste  
`HOME`| beginning-of-line  
`END`| end-of-line  
  
The following shortcuts implement additional history manipulation commands where the search term is defined as the substring of the command from first character to cursor position.

  * `CTRL+R`: reverse history search, matches any history entry containing search term.
  * `CTRL+S`: forward history search, matches any history entry containing search term.
  * `CTRL+UP`: ZSH up line or search, matches any history entry starting with search term.
  * `CTRL+DOWN`: ZSH down line or search, matches any history entry starting with search term.
  * `CTRL+DELETE`: delete the currently visible history entry from history file. This does not delete new commands or history entries under user editing.


**Basic usage** :

By default, [rc.lua](<../sample files/rc.lua.html#>) will create one [awful.widget.prompt](<../classes/awful.widget.prompt.html#>) per screen called `mypromptbox`. It is used for both the command execution (`mod4+r`) and Lua prompt (`mod4+x`). It can be re-used for random inputs using:

![Usage example](../images/AUTOGEN_wibox_awidget_prompt_simple.svg)
    
    
    local atextbox = wibox.widget.textbox()
    -- Create a shortcut function
    local function echo_test()
        awful.prompt.run {
            prompt       = '<b>Echo: </b>',
            text         = 'default command',
            bg_cursor    = '#ff0000',
            -- To use the default [rc.lua](<../sample files/rc.lua.html#>) prompt:
            --textbox      = mouse.screen.mypromptbox.widget,
            textbox      = atextbox,
            exe_callback = function(input)
                if not input or #input == 0 then return end
                naughty.notify{ text = 'The input was: '..input }
            end
        }
    end
    
    -- Then **IN THE globalkeys TABLE** add a new shortcut
    awful.key({ modkey }, "e", echo_test,
        {description = "Echo a string", group = "custom"}),
    

Note that this assumes an [rc.lua](<../sample files/rc.lua.html#>) file based on the default one. The way to access the screen prompt may vary.

**Extra key hooks** :

The Awesome prompt also supports adding custom extensions to specific keyboard keybindings. Those keybindings have precedence over the built-in ones. Therefor, they can be used to override the default ones.

_[Example one] Adding pre-configured[awful.spawn](<../libraries/awful.spawn.html#>) commands:_

![Usage example](../images/AUTOGEN_wibox_awidget_prompt_hooks.svg)
    
    
    local atextbox = wibox.widget.textbox()
    -- Custom handler for the return value. This implementation does nothing,
    -- but you might want be notified of the failure, so it is part of this
    -- example.
    local function clear(result)
        atextbox.widget.text =
            type(result) == 'string' and result or ''
    end
    local hooks = {
        -- Replace the 'normal' Return with a custom one
        {{         }, 'Return', awful.spawn},
        -- Spawn method to spawn in the current tag
        {{'Mod1'   }, 'Return', function(command)
            clear(awful.spawn(command,{
                intrusive = true,
                tag       = mouse.screen.selected_tag
            }))
        end},
        -- Spawn in the current tag as floating and on top
        {{'Shift'  }, 'Return', function(command)
            clear(awful.spawn(command,{
                ontop     = true,
                floating  = true,
                tag       = mouse.screen.selected_tag
            }))
        end},
        -- Spawn in a new tag
        {{'Control'}, 'Return', function(command)
            clear(awful.spawn(command,{
                new_tag = true
            }))
        end},
        -- Cancel
        {{         }, 'Escape', function(_)
            clear()
        end},
    }
    awful.prompt.run {
        prompt        = '<b>Run: </b>',
        hooks         = hooks,
        textbox       = atextbox,
        history_path  = gfs.get_cache_dir() .. '/history',
        done_callback = clear,
    }
    

_[Example two] Modifying the command (+ vi like input)_ :

The hook system also allows to modify the command before interpreting it in the [exe_callback](<../libraries/awful.prompt.html#exe_callback>).

![Usage example](../images/AUTOGEN_wibox_awidget_prompt_vilike.svg)
    
    
    local atextbox = wibox.widget.textbox()
    -- Store a list of verbs characters in a hash
    local verbs = {
        -- Spawn in a terminal
        t = function(adjs, count, cmd) return {terminal, '-e', cmd} end,  --luacheck: no unused args
        -- Spawn with a shell
        s = function(adjs, count, cmd) return {awful.util.shell, '-c', cmd} end, --luacheck: no unused args
    }
    local function vi_parse(action, command)
        local req, ret = {count={}, adjectives={}}
        -- Quite dumb, don't do something like <num>+<adj>+<num>+<verb>
        for char in action:gmatch('(.)') do
            if     tonumber(char)  then table.insert(req.count, char)
            elseif verbs[char]     then req.verb = char
            else   table.insert(ret.adjectives, char) end
            if req.verb then
                req.count = tonumber(table.concat(req.count)) or 1
                ret = ret or verbs[req.verb](req.adjectives, req.count, command)
                req = {count={}, adjectives={}}
            end
        end
        return ret
    end
    awful.prompt.run {
        prompt       = '<b>Run: </b>',
        hooks        = {
            {{},'Return', function(cmd)
                if (not cmd) or cmd:sub(1,1) ~= ':' then return cmd end
                local act, cmd2 = cmd:gmatch(':([a-zA-Z1-9]+)[ ]+(.*)')()
                if not act then return cmd end
                return vi_parse(act, cmd2)
            end},
        },
        textbox      = atextbox,
        history_path = gfs.get_cache_dir() .. '/history',
        exe_callback = function(cmd) awful.spawn(cmd) end
    }
    

_[Example three] Key listener_ :

The 2 previous examples were focused on changing the prompt behavior. This one explains how to “spy” on the prompt events. This can be used for

  * Implementing more complex mutator
  * Synchronising other widgets
  * Showing extra tips to the user


![Usage example](../images/AUTOGEN_wibox_awidget_prompt_keypress.svg)
    
    
    local atextbox = wibox.widget.textbox()
    local notif = nil
    awful.prompt.run {
        prompt               = '<b>Run: </b>',
        keypressed_callback  = function(mod, key, cmd) --luacheck: no unused args
            if key == 'Shift_L' then
                notif = naughty.notify { text = 'Shift pressed' }
            end
        end,
        keyreleased_callback = function(mod, key, cmd) --luacheck: no unused args
            if notif then
                naughty.destroy(notif)
                notif = nil
            end
        end,
        textbox              = atextbox,
        history_path         = gfs.get_cache_dir() .. '/history',
    }
    

**highlighting** :

The prompt also support custom highlighters:

![Usage example](../images/AUTOGEN_wibox_awidget_prompt_highlight.svg)
    
    
    local amp = '&amp'..string.char(0x3B)
    local quot = '&quot'..string.char(0x3B)
    local atextbox = wibox.widget.textbox()
    -- Create a shortcut function
    local function echo_test()
        awful.prompt.run {
            prompt       = '<b>Echo: </b>',
            bg_cursor    = '#ff0000',
            -- To use the default [rc.lua](<../sample files/rc.lua.html#>) prompt:
            --textbox      = mouse.screen.mypromptbox.widget,
            textbox      = atextbox,
            highlighter  = function(b, a)
                -- Add a random marker to delimitate the cursor
                local cmd = b..'ZZZCURSORZZZ'..a
                -- Find shell variables
                local sub = '<span foreground='#CFBA5D'>%1</span>'
                cmd = cmd:gsub('($[A-Za-z][a-zA-Z0-9]*)', sub)
                -- Highlight ' && '
                sub = '<span foreground='#159040'>%1</span>'
                cmd = cmd:gsub('( '..amp..amp..')', sub)
                -- Highlight double quotes
                local quote_pos = cmd:find('[^\\]'..quot)
                while quote_pos do
                    local old_pos = quote_pos
                    quote_pos = cmd:find('[^\\]'..quot, old_pos+2)
                    if quote_pos then
                        local content = cmd:sub(old_pos+1, quote_pos+6)
                        cmd = table.concat({
                                cmd:sub(1, old_pos),
                                '<span foreground='#2977CF'>',
                                content,
                                '</span>',
                                cmd:sub(quote_pos+7, #cmd)
                        }, '')
                        quote_pos = cmd:find('[^\\]'..quot, old_pos+38)
                    end
                end
                -- Split the string back to the original content
                -- (ignore the recursive and escaped ones)
                local pos = cmd:find('ZZZCURSORZZZ')
                b,a = cmd:sub(1, pos-1), cmd:sub(pos+12, #cmd)
                return b,a
            end,
        }
    end
    

### Info:

  * **Copyright** : 2008 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[run ([args={}[, textbox[, exe_callback[, completion_callback[, history_path[, history_max[, done_callback[, changed_callback[, keypressed_callback]]]]]]]]])](<#run>) | Run a prompt in a box.  
---|---  
  
## [Theme variables](<#Theme_variables>)

[beautiful.prompt_fg_cursor](<#beautiful.prompt_fg_cursor>) | The prompt cursor foreground color.  
---|---  
[beautiful.prompt_bg_cursor](<#beautiful.prompt_bg_cursor>) | The prompt cursor background color.  
[beautiful.prompt_font](<#beautiful.prompt_font>) | The prompt text font.  
  
## [Callback functions prototype](<#Callback_functions_prototype>)

[exe_callback](<#exe_callback>) | The callback function to call with command as argument when finished.  
---|---  
[completion_callback](<#completion_callback>) | The callback function to get completions.  
[done_callback](<#done_callback>) | The callback function to always call without arguments, regardless of whether the prompt was cancelled.  
[changed_callback](<#changed_callback>) | The callback function to call with command as argument when a command was changed.  
[keypressed_callback](<#keypressed_callback>) | The callback function to call with mod table, key and command as arguments when a key was pressed.  
[keyreleased_callback](<#keyreleased_callback>) | The callback function to call with mod table, key and command as arguments when a key was released.  
[highlighter](<#highlighter>) | A function to add syntax highlighting to the command.  
[hook](<#hook>) | A callback when a key combination is triggered.  
  
  


## Functions

Methods 

**run ([args={}[, textbox[, exe_callback[, completion_callback[, history_path[, history_max[, done_callback[, changed_callback[, keypressed_callback]]]]]]]]])**
     Run a prompt in a box. 

  * args A table with optional arguments 
    * fg_cursor gears.color (_optional_) 
    * bg_cursor gears.color (_optional_) 
    * ul_cursor gears.color (_optional_) 
    * prompt widget (_optional_) 
    * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_optional_) 
    * selectall boolean (_optional_) 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_optional_) 
    * autoexec boolean (_optional_) 
    * textbox widget The textbox to use for the prompt. 
    * highlighter function A function to add syntax highlighting to the command. (_optional_) 
    * exe_callback function The callback function to call with command as argument when finished. 
    * completion_callback function The callback function to call to get completion. 
    * history_path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) File path where the history should be saved, set nil to disable history (_optional_) 
    * history_max function Set the maximum entries in history file, 50 by default (_optional_) 
    * done_callback function The callback function to always call without arguments, regardless of whether the prompt was cancelled. (_optional_) 
    * changed_callback function The callback function to call with command as argument when a command was changed. (_optional_) 
    * keypressed_callback function The callback function to call with mod table, key and command as arguments when a key was pressed. (_optional_) 
    * keyreleased_callback function The callback function to call with mod table, key and command as arguments when a key was pressed. (_optional_) 
    * hooks [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The “hooks” argument uses a syntax similar to [awful.key](<../libraries/awful.key.html#>). It will call a function for the matching modifiers + key. It receives the command (widget text/input) as an argument. If the callback returns a command, this will be passed to the [exe_callback](<../libraries/awful.prompt.html#exe_callback>), otherwise nothing gets executed by default, and the hook needs to handle it. hooks = { – Apply startup notification properties with Shift-Return. {{“Shift” }, “Return”, function(command) awful.screen.focused().mypromptbox:spawn_and_handle_error( command, {floating=true}) end}, – Override default behavior of “Return”: launch commands prefixed – with “:” in a terminal. {{}, “Return”, function(command) if command:sub(1,1) == “:” then return terminal .. ‘ -e ’ .. command:sub(2) end return command end} } (_optional_) 
  * textbox The textbox to use for the prompt. [**DEPRECATED**] 
  * exe_callback The callback function to call with command as argument when finished. [**DEPRECATED**] 
  * completion_callback The callback function to call to get completion. [**DEPRECATED**] 
  * history_path File path where the history should be saved, set nil to disable history [**DEPRECATED**] (_optional_) 
  * history_max Set the maximum entries in history file, 50 by default [**DEPRECATED**] (_optional_) 
  * done_callback The callback function to always call without arguments, regardless of whether the prompt was cancelled. [**DEPRECATED**] (_optional_) 
  * changed_callback The callback function to call with command as argument when a command was changed. [**DEPRECATED**] (_optional_) 
  * keypressed_callback The callback function to call with mod table, key and command as arguments when a key was pressed. [**DEPRECATED**] (_optional_) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 


## Theme variables

**beautiful.prompt_fg_cursor**
     The prompt cursor foreground color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.prompt_bg_cursor**
     The prompt cursor background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.prompt_font**
     The prompt text font. 

### Type:

  * string


### See also:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) 


## Callback functions prototype

**exe_callback**
     The callback function to call with command as argument when finished. 

### Parameters:

  * command [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The command (as entered). 


### Usage:
    
    local function my_exe_cb(command)
       -- do something
    end


**completion_callback**
     The callback function to get completions. 

### Parameters:

  * command_before_comp [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The current command. 
  * cur_pos_before_comp number The current cursor position. 
  * ncomp number The number of the currently completed element. 


### Usage:
    
    local function my_completion_cb(command_before_comp, cur_pos_before_comp, ncomp)
       return command_before_comp.."foo", cur_pos_before_comp+3, 1
    end


**done_callback**
     The callback function to always call without arguments, regardless of whether the prompt was cancelled. 

### Usage:
    
    local function my_done_cb()
       -- do something
    end


**changed_callback**
     The callback function to call with command as argument when a command was changed. 

### Parameters:

  * command [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The current command. 


### Usage:
    
    local function my_changed_cb(command)
       -- do something
    end


**keypressed_callback**
     The callback function to call with mod table, key and command as arguments when a key was pressed. 

### Parameters:

  * mod [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current modifiers (like “Control” or “Shift”). 
  * key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key name. 
  * command [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The current command. 


### Usage:
    
    local function my_keypressed_cb(mod, key, command)
       -- do something
    end


**keyreleased_callback**
     The callback function to call with mod table, key and command as arguments when a key was released. 

### Parameters:

  * mod [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current modifiers (like “Control” or “Shift”). 
  * key [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The key name. 
  * command [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The current command. 


### Usage:
    
    local function my_keyreleased_cb(mod, key, command)
       -- do something
    end


**highlighter**
     A function to add syntax highlighting to the command. 

### Parameters:

  * before_cursor [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)
  * after_cursor [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)


### Usage:
    
    local function my_highlighter(before_cursor, after_cursor)
       -- do something
       return before_cursor, after_cursor
    end


**hook**
     A callback when a key combination is triggered. This callback can return many things:

  * a modified command
  * `true` If the command is successful (then it won’t exit)
  * nothing or `nil` to execute the [exe_callback](<../libraries/awful.prompt.html#exe_callback>) and [done_callback](<../libraries/awful.prompt.html#done_callback>) and exit


An optional second return value controls if the prompt should exit or simply update the command (from the first return value) and keep going. The default is to execute the [exe_callback](<../libraries/awful.prompt.html#exe_callback>) and [done_callback](<../libraries/awful.prompt.html#done_callback>) before exiting. 

### Parameters:

  * command [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The current command. 


### Usage:
    
    local function my_hook(command)
       return command.."foo", false
    end