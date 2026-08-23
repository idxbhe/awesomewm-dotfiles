# Module awful.rules - awesome API documentation

**Module:** `libraries.awful.rules`  

> Source: [libraries/awful.rules.html](https://awesomewm.org/doc/api/libraries/awful.rules.html)

---

# Module `awful.rules`

Rules for clients.

This module applies [rules](<../libraries/awful.rules.html>) to clients during startup (via [client.manage](<../classes/client.html#client.manage>), but its functions can be used for client matching in general.

All existing [client](<../classes/client.html#>) properties can be used in rules. It is also possible to add random properties that will be later accessible as `c.property_name` (where `c` is a valid client object)

##  Syntax

You should fill this table with your rule and properties to apply. For example, if you want to set xterm maximized at startup, you can add:
    
    
    { rule = { class = "xterm" },
      properties = { maximized_vertical = true, maximized_horizontal = true } }
    

If you want to set mplayer floating at startup, you can add:
    
    
    { rule = { name = "MPlayer" },
      properties = { floating = true } }
    

If you want to put Firefox on a specific tag at startup, you can add:
    
    
    { rule = { instance = "firefox" },
      properties = { tag = mytagobject } }
    

Alternatively, you can specify the tag by name:
    
    
    { rule = { instance = "firefox" },
      properties = { tag = "3" } }
    

If you want to put Thunderbird on a specific screen at startup, use:
    
    
    { rule = { instance = "Thunderbird" },
      properties = { screen = 1 } }
    

Assuming that your X11 server supports the RandR extension, you can also specify the screen by name:
    
    
    { rule = { instance = "Thunderbird" },
      properties = { screen = "VGA1" } }
    

If you want to put Emacs on a specific tag at startup, and immediately switch to that tag you can add:
    
    
    { rule = { class = "Emacs" },
      properties = { tag = mytagobject, switchtotag = true } }
    

If you want to apply a custom callback to execute when a rule matched, for example to pause playing music from mpd when you start dosbox, you can add:
    
    
    { rule = { class = "dosbox" },
      callback = function(c)
         awful.spawn('mpc pause')
      end }
    

Note that all “rule” entries need to match. If any of the entry does not match, the rule won’t be applied.

If a client matches multiple rules, they are applied in the order they are put in this global rules table. If the value of a rule is a string, then the match function is used to determine if the client matches the rule.

If the value of a property is a function, that function gets called and function’s return value is used for the property.

To match multiple clients to a rule one need to use slightly different syntax:
    
    
    { rule_any = { class = { "MPlayer", "Nitrogen" }, instance = { "xterm" } },
      properties = { floating = true } }
    

To match multiple clients with an exception one can couple `rules.except` or `rules.except_any` with the rules:
    
    
    { rule = { class = "Firefox" },
      except = { instance = "Navigator" },
      properties = {floating = true},
    },
    
    { rule_any = { class = { "Pidgin", "Xchat" } },
      except_any = { role = { "conversation" } },
      properties = { tag = "1" }
    }
    
    { rule = {},
      except_any = { class = { "Firefox", "Vim" } },
      properties = { floating = true }
    }
    

##  Applicable client properties

The table below holds the list of default client properties along with some extra properties that are specific to the rules. Note that any property can be set in the rules and interpreted by user provided code. This table only represent those offered by default.

Name | Description  
---|---  
[placement](<../classes/client.html#client.placement>)| The client default placement on the screen  
[honor\\_padding](<../classes/client.html#client.honor_padding>)| When applying the placement, honor the screen padding  
[honor\\_workarea](<../classes/client.html#client.honor_workarea>)| When applying the placement, honor the screen work area  
[tag](<../classes/client.html#client.tag>)| The client default tag  
[tags](<../classes/client.html#client.tags>)| The client default tags  
[new\\_tag](<../classes/client.html#client.new_tag>)| Create a new tag for this client  
[switch\\_to\\_tags](<../classes/client.html#client.switch_to_tags>)| Unselect the current tags and select this client tags  
[focus](<../classes/client.html#client.focus>)| Define if the client should grab focus by default  
[titlebars\\_enabled](<../classes/client.html#client.titlebars_enabled>)| Should this client have a titlebar by default  
[callback](<../classes/client.html#client.callback>)| A function to call when this client is ready  
[marked](<../classes/client.html#client.marked>)| If a client is marked or not  
[is\\_fixed](<../classes/client.html#client.is_fixed>)| Return if a client has a fixed size or not  
[immobilized](<../classes/client.html#client.immobilized>)| Is the client immobilized horizontally?  
[immobilized](<../classes/client.html#client.immobilized>)| Is the client immobilized vertically?  
[floating](<../classes/client.html#client.floating>)| The client floating state  
[x](<../classes/client.html#client.x>)| The x coordinates  
[y](<../classes/client.html#client.y>)| The y coordinates  
[width](<../classes/client.html#client.width>)| The width of the client  
[height](<../classes/client.html#client.height>)| The height of the client  
[dockable](<../classes/client.html#client.dockable>)| If the client is dockable  
[requests\\_no\\_titlebar](<../classes/client.html#client.requests_no_titlebar>)| If the client requests not to be decorated with a titlebar  
[shape](<../classes/client.html#client.shape>)| Set the client shape  
[window](<../classes/client.html#client.window>)| The X window id  
[name](<../classes/client.html#client.name>)| The client title  
[skip\\_taskbar](<../classes/client.html#client.skip_taskbar>)| True if the client does not want to be in taskbar  
[type](<../classes/client.html#client.type>)| The window type  
[class](<../classes/client.html#client.class>)| The client class  
[instance](<../classes/client.html#client.instance>)| The client instance  
[pid](<../classes/client.html#client.pid>)| The client PID, if available  
[role](<../classes/client.html#client.role>)| The window role, if available  
[machine](<../classes/client.html#client.machine>)| The machine client is running on  
[icon\\_name](<../classes/client.html#client.icon_name>)| The client name when iconified  
[icon](<../classes/client.html#client.icon>)| The client icon as a surface  
[icon\\_sizes](<../classes/client.html#client.icon_sizes>)| The available sizes of client icons  
[screen](<../classes/client.html#client.screen>)| Client screen  
[hidden](<../classes/client.html#client.hidden>)| Define if the client must be hidden, i  
[minimized](<../classes/client.html#client.minimized>)| Define it the client must be iconify, i  
[size\\_hints\\_honor](<../classes/client.html#client.size_hints_honor>)| Honor size hints, e  
[border\\_width](<../classes/client.html#client.border_width>)| The client border width  
[border\\_color](<../classes/client.html#client.border_color>)| The client border color  
[urgent](<../classes/client.html#client.urgent>)| The client urgent state  
[content](<../classes/client.html#client.content>)| A cairo surface for the client window content  
[opacity](<../classes/client.html#client.opacity>)| The client opacity  
[ontop](<../classes/client.html#client.ontop>)| The client is on top of every other windows  
[above](<../classes/client.html#client.above>)| The client is above normal windows  
[below](<../classes/client.html#client.below>)| The client is below normal windows  
[fullscreen](<../classes/client.html#client.fullscreen>)| The client is fullscreen or not  
[maximized](<../classes/client.html#client.maximized>)| The client is maximized (horizontally and vertically) or not  
[maximized\\_horizontal](<../classes/client.html#client.maximized_horizontal>)| The client is maximized horizontally or not  
[maximized\\_vertical](<../classes/client.html#client.maximized_vertical>)| The client is maximized vertically or not  
[transient\\_for](<../classes/client.html#client.transient_for>)| The client the window is transient for  
[group\\_window](<../classes/client.html#client.group_window>)| Window identification unique to a group of windows  
[leader\\_window](<../classes/client.html#client.leader_window>)| Identification unique to windows spawned by the same command  
[size\\_hints](<../classes/client.html#client.size_hints>)| A table with size hints of the client  
[motif\\_wm\\_hints](<../classes/client.html#client.motif_wm_hints>)| The motif WM hints of the client  
[sticky](<../classes/client.html#client.sticky>)| Set the client sticky, i  
[modal](<../classes/client.html#client.modal>)| Indicate if the client is modal  
[focusable](<../classes/client.html#client.focusable>)| True if the client can receive the input focus  
[shape\\_bounding](<../classes/client.html#client.shape_bounding>)| The client's bounding shape as set by awesome as a (native) cairo surface  
[shape\\_clip](<../classes/client.html#client.shape_clip>)| The client's clip shape as set by awesome as a (native) cairo surface  
[shape\\_input](<../classes/client.html#client.shape_input>)| The client's input shape as set by awesome as a (native) cairo surface  
[client\\_shape\\_bounding](<../classes/client.html#client.client_shape_bounding>)| The client's bounding shape as set by the program as a (native) cairo surface  
[client\\_shape\\_clip](<../classes/client.html#client.client_shape_clip>)| The client's clip shape as set by the program as a (native) cairo surface  
[startup\\_id](<../classes/client.html#client.startup_id>)| The FreeDesktop StartId  
[valid](<../classes/client.html#client.valid>)| If the client that this object refers to is still managed by awesome  
[first\\_tag](<../classes/client.html#client.first_tag>)| The first tag of the client  
  
### Info:

  * **Copyright** : 2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[match (c, rule)](<#match>) | Check if a client matches a rule.  
---|---  
[match_any (c, rule)](<#match_any>) | Check if a client matches any part of a rule.  
[matches (c, entry)](<#matches>) | Does a given rule entry match a client?  
[matching_rules (c, _rules)](<#matching_rules>) | Get list of matching rules for a client.  
[matches_list (c, _rules)](<#matches_list>) | Check if a client matches a given set of rules.  
[add_rule_source (name, callback, depends_on, precede)](<#add_rule_source>) | Add a new rule source.  
[remove_rule_source (name)](<#remove_rule_source>) | Remove a source.  
[apply (c)](<#apply>) | Apply awful.rules.rules to a client.  
[execute (c, props[, callbacks])](<#execute>) | Apply properties and callbacks to a client.  
  
## [Rule sources](<#Rule_sources>)

[awful.rules](<#awful.rules>) | The default [awful.rules](<../libraries/awful.rules.html#>) source.  
---|---  
[awful.spawn](<#awful.spawn>) | The rule source for clients spawned by [awful.spawn](<../libraries/awful.spawn.html#>).  
[awful.spawn_once](<#awful.spawn_once>) | The rule source for clients spawned by [awful.spawn.once](<../libraries/awful.spawn.html#once>) and `single_instance`.  
  
## [Tables](<#Tables>)

[rules](<#rules>) | This is the global rules table.  
---|---  
[extra_properties](<#extra_properties>) | Extra rules properties.  
[high_priority_properties](<#high_priority_properties>) | Extra high priority properties.  
[delayed_properties](<#delayed_properties>) | Delayed properties.  
  
  


## Functions

Methods 

**match (c, rule)**
     Check if a client matches a rule. 

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * rule [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The rule to check. 


### Returns:

bool True if it matches, false otherwise. 

**match_any (c, rule)**
     Check if a client matches any part of a rule. 

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * rule [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The rule to check. 


### Returns:

bool True if at least one rule is matched, false otherwise. 

**matches (c, entry)**
     Does a given rule entry match a client? 

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * entry [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Rule entry (with keys `rule`, `rule_any`, `except` and/or `except_any`). 


### Returns:

bool 

**matching_rules (c, _rules)**
     Get list of matching rules for a client. 

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * _rules [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The rules to check. List with “rule”, “rule_any”, “except” and “except_any” keys. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The list of matched rules. 

**matches_list (c, _rules)**
     Check if a client matches a given set of rules. 

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * _rules [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The rules to check. List of tables with `rule`, `rule_any`, `except` and `except_any` keys. 


### Returns:

bool True if at least one rule is matched, false otherwise. 

**add_rule_source (name, callback, depends_on, precede)**
     Add a new rule source.

A rule source is a provider called when a client is managed (started). It allows to configure the client by providing properties that should be applied. By default, Awesome provides 2 sources:

  * [awful.rules](<../libraries/awful.rules.html#>): A declarative matcher
  * [awful.spawn](<../libraries/awful.spawn.html#>): Launch clients with pre-defined properties


It is possible to register new callbacks to modify the properties table before it is applied. Each provider is executed sequentially and modifies the same table. If the first provider set a property, then the second can override it, then the third, etc. Once the providers are exhausted, the properties are applied on the client.

It is important to note that properties themselves have their own dependencies. For example, a [tag](<../classes/tag.html#>) property implies a [screen](<../classes/screen.html#>). Therefor, if a [screen](<../classes/screen.html#>) is already specified, then it will be ignored when the rule is executed. Properties also have their own priorities. For example, the [titlebar](<../classes/awful.titlebar.html>) and `border_width` need to be applied before the `x` and `y` positions are set. Otherwise, it will be off or the client will shift upward everytime Awesome is restarted. A rule source _cannot_ change this. It is up to the callback to be aware of the dependencies and avoid to introduce issues. For example, if the source wants to set a [screen](<../classes/screen.html#>), it has to check if the [tag](<../classes/tag.html#>), `tags` or `new_tag` are on that [screen](<../classes/screen.html#>) or remove those properties. Otherwise, they will be ignored once the rule is applied. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The provider name. It must be unique. 
  * callback The callback that is called to produce properties. 
    * c [client](<../classes/client.html#>) The client 
    * properties [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The current properties. The callback should add to and overwrite properties in this table 
    * callbacks [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table of all callbacks scheduled to be executed after the main properties are applied. 
  * depends_on [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A list of names of sources this source depends on (sources that must be executed _before_ `name`. (_default_ {}) 
  * precede [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A list of names of sources this source have a priority over. (_default_ {}) 


### Returns:

boolean Returns false if a dependency conflict was found. 

**remove_rule_source (name)**
     Remove a source. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The source name. 


### Returns:

boolean If the source was removed 

**apply (c)**
     Apply awful.rules.rules to a client. 

  * c [client.object](<../classes/client.html#awful.object>) The client. 


**execute (c, props[, callbacks])**
     Apply properties and callbacks to a client. 

  * c [client.object](<../classes/client.html#awful.object>) The client. 
  * props [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Properties to apply. 
  * callbacks [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Callbacks to apply. (_optional_) 


## Rule sources

**awful.rules**
     The default [awful.rules](<../libraries/awful.rules.html#>) source.

**Has priority over:**

_nothing_
**awful.spawn**
    

The rule source for clients spawned by [awful.spawn](<../libraries/awful.spawn.html#>).

**Has priority over:**

  * [awful.rules](<../libraries/awful.rules.html#>)


**awful.spawn_once**
    

The rule source for clients spawned by [awful.spawn.once](<../libraries/awful.spawn.html#once>) and `single_instance`.

**Has priority over:**

  * [awful.rules](<../libraries/awful.rules.html#>)


**Depends on:**

  * [awful.spawn](<../libraries/awful.spawn.html#>)


## Tables

**rules**
     This is the global rules table. 
**extra_properties**
    

Extra rules properties.

These properties are used in the rules only and are not sent to the client afterward.

To add a new properties, just do:
    
    
    function awful.rules.extra_properties.my_new_property(c, value, props)
        -- do something
    end
    

By default, the table has the following functions:

  * geometry
  * placement


**high_priority_properties**
    

Extra high priority properties.

Some properties, such as anything related to tags, geometry or focus, will cause a race condition if set in the main property section. This is why they have a section for them.

To add a new properties, just do:
    
    
    function awful.rules.high_priority_properties.my_new_property(c, value, props)
        -- do something
    end
    

By default, the table has the following functions:

  * tag
  * new_tag


**delayed_properties**
     Delayed properties. Properties applied after all other categories.