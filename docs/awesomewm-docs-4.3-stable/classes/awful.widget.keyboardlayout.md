# Class awful.widget.keyboardlayout - awesome API documentation

**Module:** `classes.awful.widget.keyboardlayout`  

> Source: [classes/awful.widget.keyboardlayout.html](https://awesomewm.org/doc/api/classes/awful.widget.keyboardlayout.html)

---

# Class `awful.widget.keyboardlayout`

### Info:

  * **Copyright** : 2015 Aleksey Fedotov
  * **Author** : Aleksey Fedotov <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Methods](<#Methods>)

[awful.widget.keyboardlayout:get_groups_from_group_names (group_names)](<#awful.widget.keyboardlayout:get_groups_from_group_names>) | Auxiliary function for the local function update_layout().  
---|---  
[awful.widget.keyboardlayout:new ()](<#awful.widget.keyboardlayout:new>) | Create a keyboard layout widget.  
  
  


## Methods

**awful.widget.keyboardlayout:get_groups_from_group_names (group_names)**
     Auxiliary function for the local function update_layout(). Create an array whose element is a table consisting of the four fields: vendor, file, section and group_idx, which all correspond to the xkb_symbols pattern “vendor/file(section):group_idx”. 

  * group_names [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The string awesome.xkb_get_group_names() returns. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) An array of tables whose keys are vendor, file, section, and group_idx. 

**awful.widget.keyboardlayout:new ()**
     Create a keyboard layout widget. It shows current keyboard layout name in a textbox. 

### Returns:

A keyboard layout widget.