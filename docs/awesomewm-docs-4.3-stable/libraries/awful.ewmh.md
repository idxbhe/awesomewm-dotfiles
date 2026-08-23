# Module awful.ewmh - awesome API documentation

**Module:** `libraries.awful.ewmh`  

> Source: [libraries/awful.ewmh.html](https://awesomewm.org/doc/api/libraries/awful.ewmh.html)

---

# Module `awful.ewmh`

Implements EWMH requests handling.

### Info:

  * **Copyright** : 2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[add_activate_filter (f[, context])](<#add_activate_filter>) | Add an activate (focus stealing) filter function.  
---|---  
[remove_activate_filter (f[, context])](<#remove_activate_filter>) | Remove an activate (focus stealing) filter function.  
  
## [Request handlers](<#Request_handlers>)

[awful.ewmh.activate](<#awful.ewmh.activate>) | Activate a window.  
---|---  
[awful.ewmh.tag](<#awful.ewmh.tag>) | Tag a window with its requested tag.  
[awful.ewmh.urgent](<#awful.ewmh.urgent>) | Handle client urgent request  
[awful.ewmh.geometry](<#awful.ewmh.geometry>) | Move and resize the client.  
[awful.ewmh.merge_maximization](<#awful.ewmh.merge_maximization>) | Merge the 2 requests sent by clients wanting to be maximized.  
[awful.ewmh.client_geometry_requests](<#awful.ewmh.client_geometry_requests>) | Allow the client to move itself.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.maximized_honor_padding](<#beautiful.maximized_honor_padding>) | Honor the screen padding when maximizing.  
---|---  
[beautiful.fullscreen_hide_border](<#beautiful.fullscreen_hide_border>) | Hide the border on fullscreen clients.  
[beautiful.maximized_hide_border](<#beautiful.maximized_hide_border>) | Hide the border on maximized clients.  
  
## [Tables](<#Tables>)

[generic_activate_filters](<#generic_activate_filters>) | The list of all registered generic request::activate (focus stealing) filters.  
---|---  
[contextual_activate_filters](<#contextual_activate_filters>) | The list of all registered contextual request::activate (focus stealing) filters.  
  
  


## Functions

Methods 

**add_activate_filter (f[, context])**
    

Add an activate (focus stealing) filter function.

The callback takes the following parameters:

  * **c** (_client_) The client requesting the activation
  * **context** (_string_) The activation context.
  * **hints** (_table_) Some additional hints (depending on the context)


If the callback returns `true`, the client will be activated. If the callback returns `false`, the activation request is cancelled unless the `force` hint is set. If the callback returns `nil`, the previous callback will be executed. This will continue until either a callback handles the request or when it runs out of callbacks. In that case, the request will be granted if the client is visible.

For example, to block Firefox from stealing the focus, use:
    
    
    awful.ewmh.add_activate_filter(function(c)
        if c.class == "Firefox" then return false end
    end, "ewmh")
    

  * f function The callback 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The `request::activate` context (_optional_) 


### See also:

  * [generic_activate_filters](<../libraries/awful.ewmh.html#generic_activate_filters>)
  * [contextual_activate_filters](<../libraries/awful.ewmh.html#contextual_activate_filters>)
  * [remove_activate_filter](<../libraries/awful.ewmh.html#remove_activate_filter>)


**remove_activate_filter (f[, context])**
     Remove an activate (focus stealing) filter function. This is an helper to avoid dealing with [ewmh.add_activate_filter](<../libraries/awful.ewmh.html#add_activate_filter>) directly. 

  * f function The callback 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The `request::activate` context (_optional_) 


### Returns:

boolean If the callback existed 


### See also:

  * [generic_activate_filters](<../libraries/awful.ewmh.html#generic_activate_filters>)
  * [contextual_activate_filters](<../libraries/awful.ewmh.html#contextual_activate_filters>)
  * [add_activate_filter](<../libraries/awful.ewmh.html#add_activate_filter>)


## Request handlers

**awful.ewmh.activate**
     Activate a window.

This sets the focus only if the client is visible.

It is the default signal handler for `request::activate` on a [client](<../classes/client.html#>). 

### Arguments:

  * c [client.object](<../classes/client.html#awful.object>) A client to use 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context where this signal was used. 
  * hints A table with additional hints: 
    * raise boolean should the client be raised? (_default_ false) 
    * switch_to_tag boolean should the client’s first tag be selected if none of the client’s tags are selected? (_default_ false) 
    * switch_to_tags boolean Select all tags associated with the client. (_default_ false) 


**awful.ewmh.tag**
     Tag a window with its requested tag.

It is the default signal handler for `request::tag` on a [client](<../classes/client.html#>). 

### Arguments:

  * c [client.object](<../classes/client.html#awful.object>) A client to tag 
  * t [tag](<../classes/tag.html#>) or boolean A tag to use. If true, then the client is made sticky. (_optional_) 
  * hints [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Extra information (_default_ {}) 


**awful.ewmh.urgent**
     Handle client urgent request 

### Arguments:

  * c [client.object](<../classes/client.html#awful.object>) A client 
  * urgent boolean If the client should be urgent 


**awful.ewmh.geometry**
     Move and resize the client.

This is the default geometry request handler. 

### Arguments:

  * c [client](<../classes/client.html#>) The client 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context 
  * hints [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The hints to pass to the handler (_default_ {}) 


**awful.ewmh.merge_maximization**
     Merge the 2 requests sent by clients wanting to be maximized.

The X clients set 2 flags (atoms) when they want to be maximized. This caused 2 request::geometry to be sent. This code gives some time for them to arrive and send a new `request::geometry` (through the property change) with the combined state. 

### Arguments:

  * c [client](<../classes/client.html#>) The client 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context 
  * hints [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The hints to pass to the handler (_default_ {}) 


**awful.ewmh.client_geometry_requests**
     Allow the client to move itself.

This is the default geometry request handler when the context is [ewmh](<../libraries/awful.ewmh.html>). 

### Arguments:

  * c [client](<../classes/client.html#>) The client 
  * context [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The context 
  * hints [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The hints to pass to the handler (_default_ {}) 


## Theme variables

**beautiful.maximized_honor_padding**
     Honor the screen padding when maximizing. 

### Type:

  * maximized_honor_padding boolean (_default_ true) 


**beautiful.fullscreen_hide_border**
     Hide the border on fullscreen clients. 

### Type:

  * fullscreen_hide_border boolean (_default_ true) 


**beautiful.maximized_hide_border**
     Hide the border on maximized clients. 

### Type:

  * maximized_hide_border boolean (_default_ false) 


## Tables

**generic_activate_filters**
     The list of all registered generic request::activate (focus stealing) filters. If a filter is added to only one context, it will be in [ewmh.contextual_activate_filters](<../libraries/awful.ewmh.html#contextual_activate_filters>)[“context_name”]. 

### See also:

  * [ewmh.activate](<../libraries/awful.ewmh.html#awful.ewmh.activate>)
  * [ewmh.add_activate_filter](<../libraries/awful.ewmh.html#add_activate_filter>)
  * [ewmh.remove_activate_filter](<../libraries/awful.ewmh.html#remove_activate_filter>)


**contextual_activate_filters**
     The list of all registered contextual request::activate (focus stealing) filters. If a filter is added to only one context, it will be in [ewmh.generic_activate_filters](<../libraries/awful.ewmh.html#generic_activate_filters>). 

### See also:

  * [ewmh.activate](<../libraries/awful.ewmh.html#awful.ewmh.activate>)
  * [ewmh.add_activate_filter](<../libraries/awful.ewmh.html#add_activate_filter>)
  * [ewmh.remove_activate_filter](<../libraries/awful.ewmh.html#remove_activate_filter>)