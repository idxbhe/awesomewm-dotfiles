# Module gears.math - awesome API documentation

**Module:** `libraries.gears.math`  

> Source: [libraries/gears.math.html](https://awesomewm.org/doc/api/libraries/gears.math.html)

---

# Module `gears.math`

Math module for gears

## [Functions](<#Functions>)

[subsets (set)](<#subsets>) | Return all subsets of a specific set.  
---|---  
[cycle (t, i)](<#cycle>) | Make i cycle.  
[round (x)](<#round>) | Round a number to an integer.  
  
  


## Functions

Methods 

**subsets (set)**
     Return all subsets of a specific set. This function, giving a set, will return all subset it. For example, if we consider a set with value { 10, 15, 34 }, it will return a table containing 2n set: { }, { 10 }, { 15 }, { 34 }, { 10, 15 }, { 10, 34 }, etc. 

  * set A set. 


### Returns:

A table with all subset. 

**cycle (t, i)**
     Make i cycle. 

  * t A length. Must be greater than zero. 
  * i An absolute index to fit into #t. 


### Returns:

An integer in (1, t) or nil if t is less than or equal to zero. 

**round (x)**
     Round a number to an integer. 

  * x number


### Returns:

integer