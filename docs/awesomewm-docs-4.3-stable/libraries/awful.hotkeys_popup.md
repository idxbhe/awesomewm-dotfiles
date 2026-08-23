# Module awful.hotkeys_popup - awesome API documentation

**Module:** `libraries.awful.hotkeys_popup`  

> Source: [libraries/awful.hotkeys_popup.html](https://awesomewm.org/doc/api/libraries/awful.hotkeys_popup.html)

---

# Module `awful.hotkeys_popup`

Popup widget which shows current hotkeys and their descriptions.

### Info:

  * **Copyright** : 2014-2015 Yauheni Kirylau
  * **Author** : Yauheni Kirylau <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.hotkeys_popup.show_help ([c[, s]])](<#awful.hotkeys_popup.show_help>) | This is the same as awful.hotkeys_popup.widget.show_help.  
---|---  
  
## [lib.awful.hotkeys_popup.keys.tmux Functions](<#lib_awful_hotkeys_popup_keys_tmux_Functions>)

[add_rules_for_terminal (rule)](<#add_rules_for_terminal>) | Add rules to match tmux session.  
---|---  
  
  


## Functions

Methods 

**awful.hotkeys_popup.show_help ([c[, s]])**
     This is the same as awful.hotkeys_popup.widget.show_help.

example usage:
    
    
     local hotkeys_popup = require("awful.hotkeys_popup")
     myawesomemenu = {{ "hotkeys", function() hotkeys_popup.show_help() end },
                      -- <more entries>
     }
    

see [awful.hotkeys_popup.widget.show_help](<../libraries/awful.hotkeys_popup.widget.html#show_help>) for more information 

  * c [client](<../classes/client.html#>) The hostkeys for the client “c”. (_optional_) 
  * s [screen](<../classes/screen.html#>) The screen. (_optional_) 


### See also:

[awful.hotkeys_popup.widget.show_help](<../libraries/awful.hotkeys_popup.widget.html#show_help>) 


## lib.awful.hotkeys_popup.keys.tmux Functions

**add_rules_for_terminal (rule)**
     Add rules to match tmux session.

For example:
    
    
     tmux.add_rules_for_terminal({ rule = { name = { "tmux" }}})
    

will show tmux hotkeys for any window that has ‘tmux’ in its title. If no rules are provided then tmux hotkeys will be shown always! 

  * rule [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Rules to match a window containing a tmux session. 


### See also:

[awful.rules.rules](<../libraries/awful.rules.html#rules>)