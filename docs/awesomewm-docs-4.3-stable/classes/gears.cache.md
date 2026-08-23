# Class gears.cache - awesome API documentation

**Module:** `classes.gears.cache`  

> Source: [classes/gears.cache.html](https://awesomewm.org/doc/api/classes/gears.cache.html)

---

# Class `gears.cache`

### Info:

  * **Copyright** : 2015 Uli Schlachter
  * **Author** : Uli Schlachter


## [Methods](<#Methods>)

[gears.cache:get (...)](<#gears.cache:get>) | Get an entry from the cache, creating it if it’s missing.  
---|---  
[gears.cache:new (creation_cb)](<#gears.cache:new>) | Create a new cache object.  
  
  


## Methods

**gears.cache:get (...)**
     Get an entry from the cache, creating it if it’s missing. 

  * ... Arguments for the creation callback. These are checked against the cache contents for equality. 


### Returns:

The entry from the cache 

**gears.cache:new (creation_cb)**
     Create a new cache object. A cache keeps some data that can be garbage-collected at any time, but might be useful to keep. 

  * creation_cb Callback that is used for creating missing cache entries. 


### Returns:

A new cache object.