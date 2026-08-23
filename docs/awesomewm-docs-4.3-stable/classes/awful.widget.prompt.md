# Class awful.widget.prompt - awesome API documentation

**Module:** `classes.awful.widget.prompt`  

> Source: [classes/awful.widget.prompt.html](https://awesomewm.org/doc/api/classes/awful.widget.prompt.html)

---

# Class `awful.widget.prompt`

The widget version of [awful.prompt](<../libraries/awful.prompt.html#>).

![Usage example](../images/AUTOGEN_wibox_awidget_defaults_prompt.svg)
    
    
    local myprompt = awful.widget.prompt {
        prompt = 'Execute: '
    }
    myprompt:run()
    

### Info:

  * **Copyright** : 2009 Julien Danjou,2018 Aire-One
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.widget.prompt (args)](<#awful.widget.prompt>) | Create a prompt widget which will launch a command.  
---|---  
  
## [Object properties](<#Object_properties>)

[with_shell](<#awful.widget.prompt.with_shell>) | Always spawn using a shell.  
---|---  
  
## [Theme variables](<#Theme_variables>)

[beautiful.prompt_fg](<#beautiful.prompt_fg>) | The prompt foreground color.  
---|---  
[beautiful.prompt_bg](<#beautiful.prompt_bg>) | The prompt background color.  
  
  


## Functions

Methods 

**awful.widget.prompt (args)**
     Create a prompt widget which will launch a command. For additional documentation about `args` parameter, please refer to [awful.prompt](<../libraries/awful.prompt.html#>) and [awful.prompt.run](<../libraries/awful.prompt.html#run>). 

  * args Prompt arguments. 
    * prompt [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Prompt text. (_default_ "Run: ") 
    * bg color Prompt background color. (_default_ `beautiful.prompt_bg` or `beautiful.bg_normal`) 
    * fg color Prompt foreground color. (_default_ `beautiful.prompt_fg` or `beautiful.fg_normal`) 
    * fg_cursor gears.color (_optional_) 
    * bg_cursor gears.color (_optional_) 
    * ul_cursor gears.color (_optional_) 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_optional_) 
    * autoexec boolean (_optional_) 
    * highlighter function A function to add syntax highlighting to the command. (_optional_) 
    * exe_callback function The callback function to call with command as argument when finished. (_optional_) 
    * with_shell boolean Use a (terminal) shell to execute this. (_default_ false) 
    * completion_callback function The callback function to call to get completion. See [awful.prompt.run](<../libraries/awful.prompt.html#run>) for details. (_default_ `awful.completion.shell`) 
    * history_path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) File path where the history should be saved. (_default_ `gears.filesystem.get_cache_dir() .. '/history'`) 
    * history_max integer Set the maximum entries in history file. (_default_ 50) 
    * done_callback function The callback function to always call without arguments, regardless of whether the prompt was cancelled. See [awful.prompt.run](<../libraries/awful.prompt.html#run>) for details. (_optional_) 
    * changed_callback function The callback function to call with command as argument when a command was changed. (_optional_) 
    * keypressed_callback function The callback function to call with mod table, key and command as arguments when a key was pressed. (_optional_) 
    * keyreleased_callback function The callback function to call with mod table, key and command as arguments when a key was pressed. (_optional_) 
    * hook [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Similar to [awful.key](<../libraries/awful.key.html#>). It will call a function for the matching modifiers + key. See [awful.prompt.run](<../libraries/awful.prompt.html#run>) for details. (_optional_) 


### Returns:

An instance of prompt widget, inherits from [wibox.container.background](<../classes/wibox.container.background.html#>). 


## Object properties

**with_shell**
     Always spawn using a shell.

When using the default `exe_callback`, use [awful.spawn.with_shell](<../libraries/awful.spawn.html#with_shell>) instead of [awful.spawn](<../libraries/awful.spawn.html#>). Depending on the ammount of customization to your shell environment, this can increase startup time. 

### Type:

  * boolean (_default_ false) 


## Theme variables

**beautiful.prompt_fg**
     The prompt foreground color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.prompt_bg**
     The prompt background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>)