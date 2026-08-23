# Module gears.table - awesome API documentation

**Module:** `libraries.gears.table`  

> Source: [libraries/gears.table.html](https://awesomewm.org/doc/api/libraries/gears.table.html)

---

# Module `gears.table`

Table module for gears

## [Functions](<#Functions>)

[join (...)](<#join>) | Join all tables given as arguments.  
---|---  
[crush (t, set[, raw=false])](<#crush>) | Override elements in the first table by the one in the second.  
[from_sparse (t)](<#from_sparse>) | Pack all elements with an integer key into a new table.  
[hasitem (t, item)](<#hasitem>) | Check if a table has an item and return its key.  
[gtable.find_keys (t, matcher[, ordered=false[, max=nil]])](<#gtable.find_keys>) | Get all matching table keys for a `matcher` function.  
[gtable.find_first_key (t, matcher[, ordered=false])](<#gtable.find_first_key>) | Find the first key that matches a function.  
[keys (t)](<#keys>) | Get a sorted table with all integer keys from a table.  
[keys_filter (t, ...)](<#keys_filter>) | Filter a table’s keys for certain content type.  
[reverse (t)](<#reverse>) | Reverse a table.  
[clone (t[, deep=true])](<#clone>) | Clone a table.  
[iterate (t, filter, start)](<#iterate>) | Iterate over a table.  
[merge (t, set)](<#merge>) | Merge items from one table to another one.  
[map (f, tbl)](<#map>) | Map a function to a table.  
  
  


## Functions

Methods 

**join (...)**
     Join all tables given as arguments. This will iterate over all tables and insert their entries into a new table. 

  * ... [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Tables to join. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A new table containing all entries from the arguments. 

**crush (t, set[, raw=false])**
     Override elements in the first table by the one in the second.

Note that this method doesn’t copy entries found in `__index`. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) the table to be overriden 
  * set [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) the table used to override members of `t`
  * raw bool Use rawset (avoid the metatable) (_default_ false) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) t (for convenience) 

**from_sparse (t)**
     Pack all elements with an integer key into a new table. While both lua and luajit implement __len over sparse tables, the standard defines it as an implementation detail.

This function removes any entries with non-numeric keys. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A potentially sparse table. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A packed table with only numeric keys. 

**hasitem (t, item)**
     Check if a table has an item and return its key. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table. 
  * item The item to look for in values of the table. 


### Returns:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or number The key of the item. 


### Or

nil 

**gtable.find_keys (t, matcher[, ordered=false[, max=nil]])**
     Get all matching table keys for a `matcher` function. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table. 
  * matcher function A function taking the key and value as arguments and returning a boolean. 
  * ordered boolean If true, only look for continuous numeric keys. (_default_ false) 
  * max number The maximum number of entries to find. (_default_ nil) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or nil An ordered table with all the keys or `nil` if none were found. 

**gtable.find_first_key (t, matcher[, ordered=false])**
     Find the first key that matches a function. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table. 
  * matcher function A function taking the key and value as arguments and returning a boolean. 
  * ordered boolean If true, only look for continuous numeric keys. (_default_ false) 


### Returns:

The table key or nil 

**keys (t)**
     Get a sorted table with all integer keys from a table. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table for which the keys to get. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with keys 

**keys_filter (t, ...)**
     Filter a table’s keys for certain content type. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table to retrieve the keys for. 
  * ... [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The types to look for. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A filtered table. 

**reverse (t)**
     Reverse a table. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table to reverse. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A reversed table. 

**clone (t[, deep=true])**
     Clone a table. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table to clone. 
  * deep bool Create a deep clone? (_default_ true) 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A clone of `t`. 

**iterate (t, filter, start)**
     Iterate over a table. Returns an iterator to cycle through all elements of a table that match a given criteria, starting from the first element or the given index. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table to iterate. 
  * filter func A function that returns true to indicate a positive match. 
  * start int Index to start iterating from. Default is 1 (=> start of the table). (_default_ 1) 


### Returns:

func 

**merge (t, set)**
     Merge items from one table to another one. 

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The container table 
  * set [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The mixin table. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) (for convenience) 

**map (f, tbl)**
     Map a function to a table. The function is applied to each value on the table, returning a modified table. 

  * f function The function to be applied to each value in the table. 
  * tbl [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The container table whose values will be operated on. 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>)