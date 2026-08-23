# Module dbus - awesome API documentation

**Module:** `libraries.dbus`  

> Source: [libraries/dbus.html](https://awesomewm.org/doc/api/libraries/dbus.html)

---

# Module `dbus`

awesome D-Bus API

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[request_name (bus, name)](<#request_name>) | Register a D-Bus name to receive messages from.  
---|---  
[release_name (bus, name)](<#release_name>) | Release a D-Bus name.  
[add_match (bus, name)](<#add_match>) | Add a match rule to match messages going through the message bus.  
[remove_match (bus, name)](<#remove_match>) | Remove a previously added match rule “by value” (the most recently-added identical rule gets removed).  
[connect_signal (interface, func)](<#connect_signal>) | Add a signal receiver on the D-Bus.  
[disconnect_signal (interface, func)](<#disconnect_signal>) | Remove a signal receiver on the D-Bus.  
[emit_signal (bus, path, interface, method, type_1st_arg, value_1st_arg, type_2nd_arg, value_2nd_arg)](<#emit_signal>) | Emit a signal on the D-Bus.  
  
  


## Functions

Methods 

**request_name (bus, name)**
     Register a D-Bus name to receive messages from. 

  * bus A string indicating if we are using system or session bus. 
  * name A string with the name of the D-Bus name to register. 


### Returns:

True if everything worked fine, false otherwise. 

**release_name (bus, name)**
     Release a D-Bus name. 

  * bus A string indicating if we are using system or session bus. 
  * name A string with the name of the D-Bus name to unregister. 


### Returns:

True if everything worked fine, false otherwise. 

**add_match (bus, name)**
     Add a match rule to match messages going through the message bus. 

  * bus A string indicating if we are using system or session bus. 
  * name A string with the name of the match rule. 


**remove_match (bus, name)**
     Remove a previously added match rule “by value” (the most recently-added identical rule gets removed). 

  * bus A string indicating if we are using system or session bus. 
  * name A string with the name of the match rule. 


**connect_signal (interface, func)**
     Add a signal receiver on the D-Bus. 

  * interface A string with the interface name. 
  * func The function to call. 


### Returns:

true on success, nil + error if the signal could not be connected because another function is already connected. 

**disconnect_signal (interface, func)**
     Remove a signal receiver on the D-Bus. 

  * interface A string with the interface name. 
  * func The function to call. 


**emit_signal (bus, path, interface, method, type_1st_arg, value_1st_arg, type_2nd_arg, value_2nd_arg)**
     Emit a signal on the D-Bus. 

  * bus A string indicating if we are using system or session bus. 
  * path A string with the dbus path. 
  * interface A string with the dbus interface. 
  * method A string with the dbus method name. 
  * type_1st_arg type of 1st argument 
  * value_1st_arg value of 1st argument 
  * type_2nd_arg type of 2nd argument 
  * value_2nd_arg value of 2nd argument … etc