# Module naughty.dbus - awesome API documentation

**Module:** `libraries.naughty.dbus`  

> Source: [libraries/naughty.dbus.html](https://awesomewm.org/doc/api/libraries/naughty.dbus.html)

---

# Module `naughty.dbus`

DBUS/Notification support Notify

### Info:

  * **Copyright** : 2008 koniu
  * **Author** : koniu <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Tables](<#Tables>)

[config.mapping](<#config.mapping>) | DBUS notification to preset mapping.  
---|---  
  
  


## Tables

**config.mapping**
     DBUS notification to preset mapping. The first element is an object containing the filter. If the rules in the filter match, the associated preset will be applied. The rules object can contain the following keys: urgency, category, appname. The second element is the preset. 

### Fields:

  * 1 [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) low urgency 
  * 2 [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) normal urgency 
  * 3 [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) critical urgency