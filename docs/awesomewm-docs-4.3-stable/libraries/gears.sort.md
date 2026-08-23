# Module gears.sort - awesome API documentation

**Module:** `libraries.gears.sort`  

> Source: [libraries/gears.sort.html](https://awesomewm.org/doc/api/libraries/gears.sort.html)

---

# Module `gears.sort`

Extra sorting algorithms.

## [lib.gears.sort.topological Functions](<#lib_gears_sort_topological_Functions>)

[tsort:append (node, dependencies)](<#tsort:append>) | Ensure that `node` appears after all `dependencies`.  
---|---  
[tsort:prepend (node, subordinates)](<#tsort:prepend>) | Ensure that `node` appears before all `subordinates`.  
[tsort:clone ()](<#tsort:clone>) | Create a copy of this topological sort.  
[tsort:remove (node)](<#tsort:remove>) | Remove a node from the topological map.  
[tsort:sort ()](<#tsort:sort>) | Try to sort the nodes.  
[gears.sort.topological ()](<#gears.sort.topological>) | A topological sorting class.  
  
  


## lib.gears.sort.topological Functions

**tsort:append (node, dependencies)**
     Ensure that `node` appears after all `dependencies`. 

  * node The node that edges are added to. 
  * dependencies [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) List of nodes that have to appear before `node`. 


**tsort:prepend (node, subordinates)**
     Ensure that `node` appears before all `subordinates`. 

  * node The node that edges are added to. 
  * subordinates [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) List of nodes that have to appear after `node`. 


**tsort:clone ()**
     Create a copy of this topological sort. This is useful to backup it before adding elements that can potentially have circular dependencies and thus render the original useless. 
**tsort:remove (node)**
     Remove a node from the topological map. 

  * node The node 


**tsort:sort ()**
     Try to sort the nodes. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A sorted list of nodes 


### Or

  1. nil
  2. A node around which a loop exists


**gears.sort.topological ()**
    

A topological sorting class.

The object returned by this function allows to create simple dependency graphs. It can be used for decision making or ordering of complex sequences.

**Usage example output** :
    
    
    The position #1 is: a
    The position #2 is: b
    The position #3 is: c
    The position #4 is: d
    The position #5 is: e
    The position #6 is: f
    

### Usage:
    
    local tsort = gears.sort.topological()
    tsort:prepend('a', { 'b' })
    tsort:prepend('b', { 'c' })
    tsort:prepend('c', { 'd' })
    tsort:append('e', { 'd' })
    tsort:append('f', { 'e', 'd' })
    local res = assert(tsort:sort())
    for k, v in ipairs(res) do
        print('The position #'..k..' is: '..v)
    end