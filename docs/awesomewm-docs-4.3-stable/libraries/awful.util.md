# Module awful.util - awesome API documentation

**Module:** `libraries.awful.util`  

> Source: [libraries/awful.util.html](https://awesomewm.org/doc/api/libraries/awful.util.html)

---

# Module `awful.util`

Utility module for awful

### Info:

  * **Copyright** : 2008 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[eval (s)](<#eval>) | Eval Lua code.  
---|---  
[checkfile (path)](<#checkfile>) | Check if a file is a Lua valid file.  
[restart ()](<#restart>) | Try to restart awesome.  
[geticonpath (iconname, exts, dirs[, size])](<#geticonpath>) | Search for an icon and return the full path.  
  
## [Deprecated functions](<#Deprecated_functions>)

[awful.util.pread](<#awful.util.pread>) _[deprecated]_ | Execute a system command and road the output.  
---|---  
[deprecate](<#deprecate>) _[deprecated]_ | Display a deprecation notice, but only once per traceback.  
[deprecate_class](<#deprecate_class>) _[deprecated]_ | Create a class proxy with deprecation messages.  
[ensure_pango_color](<#ensure_pango_color>) _[deprecated]_ | Get a valid color for Pango markup  
[cycle](<#cycle>) _[deprecated]_ | Make i cycle.  
[mkdir](<#mkdir>) _[deprecated]_ | Create a directory  
[escape](<#escape>) _[deprecated]_ | Escape a string from XML char.  
[unescape](<#unescape>) _[deprecated]_ | Unescape a string from entities.  
[get_xdg_config_home](<#get_xdg_config_home>) _[deprecated]_ | Get the config home according to the XDG basedir specification.  
[get_xdg_cache_home](<#get_xdg_cache_home>) _[deprecated]_ | Get the cache home according to the XDG basedir specification.  
[get_configuration_dir](<#get_configuration_dir>) _[deprecated]_ | Get the path to the user’s config dir.  
[get_cache_dir](<#get_cache_dir>) _[deprecated]_ | Get the path to a directory that should be used for caching data.  
[get_themes_dir](<#get_themes_dir>) _[deprecated]_ | Get the path to the directory where themes are installed.  
[get_awesome_icon_dir](<#get_awesome_icon_dir>) _[deprecated]_ | Get the path to the directory where our icons are installed.  
[getdir](<#getdir>) _[deprecated]_ | Get the user’s config or cache dir.  
[file_readable](<#file_readable>) _[deprecated]_ | Check if a file exists, is readable and not a directory.  
[dir_readable](<#dir_readable>) _[deprecated]_ | Check if a path exists, is readable and is a directory.  
[is_dir](<#is_dir>) _[deprecated]_ | Check if a path is a directory.  
[subsets](<#subsets>) _[deprecated]_ | Return all subsets of a specific set.  
[awful.util.get_rectangle_in_direction](<#awful.util.get_rectangle_in_direction>) _[deprecated]_ | Get the nearest rectangle in the given direction.  
[util.table.join](<#util.table.join>) _[deprecated]_ | Join all tables given as parameters.  
[util.table.crush](<#util.table.crush>) _[deprecated]_ | Override elements in the first table by the one in the second.  
[util.table.from_sparse](<#util.table.from_sparse>) _[deprecated]_ | Pack all elements with an integer key into a new table While both lua and luajit implement __len over sparse table, the standard define it as an implementation detail.  
[util.table.hasitem](<#util.table.hasitem>) _[deprecated]_ | Check if a table has an item and return its key.  
[linewrap](<#linewrap>) _[deprecated]_ | Split a string into multiple lines  
[linecount](<#linecount>) _[deprecated]_ | Count number of lines in a string  
[util.table.keys](<#util.table.keys>) _[deprecated]_ | Get a sorted table with all integer keys from a table  
[util.table.keys_filter](<#util.table.keys_filter>) _[deprecated]_ | Filter a tables keys for certain content types  
[util.table.reverse](<#util.table.reverse>) _[deprecated]_ | Reverse a table  
[util.table.clone](<#util.table.clone>) _[deprecated]_ | Clone a table  
[util.table.iterate](<#util.table.iterate>) _[deprecated]_ | Returns an iterator to cycle through, starting from the first element or the given index, all elements of a table that match a given criteria.  
[util.table.merge](<#util.table.merge>) _[deprecated]_ | Merge items from the one table to another one  
[round](<#round>) _[deprecated]_ | Round a number to an integer.  
  
## [Fields](<#Fields>)

[shell](<#shell>) | The default shell used when spawing processes.  
---|---  
  
  


## Functions

Methods 

**eval (s)**
     Eval Lua code. 

  * s


### Returns:

The return value of Lua code. 

**checkfile (path)**
     Check if a file is a Lua valid file. This is done by loading the content and compiling it with loadfile(). 

  * path The file path. 


### Returns:

A function if everything is alright, a string with the error otherwise. 

**restart ()**
     Try to restart awesome. It checks if the configuration file is valid, and then restart if it’s ok. If it’s not ok, the error will be returned. 

### Returns:

Never return if awesome restart, or return a string error. 

**geticonpath (iconname, exts, dirs[, size])**
     Search for an icon and return the full path. It searches for the icon path under the given directories with respect to the given extensions for the icon filename. 

  * iconname The name of the icon to search for. 
  * exts Table of image extensions allowed, otherwise { ‘png’, gif' } 
  * dirs Table of dirs to search, otherwise { ‘/usr/share/pixmaps/’ } 
  * size [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The size. If this is specified, subdirectories `x` of the dirs are searched first. (_optional_) 


## Deprecated functions

**awful.util.pread _[deprecated]_**
     Execute a system command and road the output. This function implementation **has been removed** and no longer do anything. Use [awful.spawn.easy_async](<../libraries/awful.spawn.html#easy_async>). 
**deprecate _[deprecated]_**
     Display a deprecation notice, but only once per traceback. param:

  * see The message to a new method / function to use. (_optional_) 
  * args Extra arguments 
    * raw boolean Print the message as-is without the automatic context (but only append a leading dot). 
    * deprecated_in integer Print the message only when Awesome’s version is equal to or greater than deprecated_in. 

See also:

[gears.debug](<../libraries/gears.debug.html#>) 

**deprecate_class _[deprecated]_**
     Create a class proxy with deprecation messages. This is useful when a class has moved somewhere else. param:

  * fallback [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The new class 
  * old_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The old class name 
  * new_name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The new class name 

See also:

[gears.debug](<../libraries/gears.debug.html#>) 

**ensure_pango_color _[deprecated]_**
     Get a valid color for Pango markup param:

  * color The color. 
  * fallback [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The color to return if the first is invalid. (default: black) 

See also:

[gears.color](<../libraries/gears.color.html#>) 

**cycle _[deprecated]_**
     Make i cycle. param:

  * t A length. Must be greater than zero. 
  * i An absolute index to fit into #t. 

See also:

[gears.math](<../libraries/gears.math.html#>) 

**mkdir _[deprecated]_**
     Create a directory param:

  * dir The directory. 

See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**escape _[deprecated]_**
     Escape a string from XML char. Useful to set raw text in textbox. param:

  * text Text to escape. 

See also:

[gears.string](<../libraries/gears.string.html#>) 

**unescape _[deprecated]_**
     Unescape a string from entities. param:

  * text Text to unescape. 

See also:

[gears.string](<../libraries/gears.string.html#>) 

**get_xdg_config_home _[deprecated]_**
     Get the config home according to the XDG basedir specification. See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**get_xdg_cache_home _[deprecated]_**
     Get the cache home according to the XDG basedir specification. See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**get_configuration_dir _[deprecated]_**
     Get the path to the user’s config dir. This is the directory containing the configuration file (“rc.lua”). See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**get_cache_dir _[deprecated]_**
     Get the path to a directory that should be used for caching data. See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**get_themes_dir _[deprecated]_**
     Get the path to the directory where themes are installed. See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**get_awesome_icon_dir _[deprecated]_**
     Get the path to the directory where our icons are installed. See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**getdir _[deprecated]_**
     Get the user’s config or cache dir. It first checks XDG_CONFIG_HOME / XDG_CACHE_HOME, but then goes with the default paths. param:

  * d The directory to get (either “config” or “cache”). 

See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**file_readable _[deprecated]_**
     Check if a file exists, is readable and not a directory. param:

  * filename The file path. 

See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**dir_readable _[deprecated]_**
     Check if a path exists, is readable and is a directory. param:

  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The directory path. 

See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**is_dir _[deprecated]_**
     Check if a path is a directory. param:

  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>)

See also:

[gears.filesystem](<../libraries/gears.filesystem.html#>) 

**subsets _[deprecated]_**
     Return all subsets of a specific set. This function, giving a set, will return all subset it. For example, if we consider a set with value { 10, 15, 34 }, it will return a table containing 2n set: { }, { 10 }, { 15 }, { 34 }, { 10, 15 }, { 10, 34 }, etc. param:

  * set A set. 

See also:

[gears.math](<../libraries/gears.math.html#>) 

**awful.util.get_rectangle_in_direction _[deprecated]_**
     Get the nearest rectangle in the given direction. Every rectangle is specified as a table with ‘x’, ‘y’, ‘width’, ‘height’ keys, the same as client or screen geometries. param:

  * dir The direction, can be either “up”, “down”, “left” or “right”. 
  * recttbl A table of rectangle specifications. 
  * cur The current rectangle. 

See also:

[gears.geometry](<../libraries/gears.geometry.html#>) 

**util.table.join _[deprecated]_**
     Join all tables given as parameters. This will iterate all tables and insert all their keys into a new table. param:

  * args A list of tables to join 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.crush _[deprecated]_**
     Override elements in the first table by the one in the second. Note that this method doesn’t copy entries found in `__index`. param:

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) the table to be overriden 
  * set [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) the table used to override members of `t`
  * raw boolean Use rawset (avoid the metatable) (_default_ false) 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.from_sparse _[deprecated]_**
     Pack all elements with an integer key into a new table While both lua and luajit implement __len over sparse table, the standard define it as an implementation detail. This function remove any non numeric keys from the value set param:

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A potentially sparse table 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.hasitem _[deprecated]_**
     Check if a table has an item and return its key. param:

  * t The table. 
  * item The item to look for in values of the table. 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**linewrap _[deprecated]_**
     Split a string into multiple lines param:

  * text String to wrap. 
  * width Maximum length of each line. Default: 72. 
  * indent Number of spaces added before each wrapped line. Default: 0. 

See also:

[gears.string](<../libraries/gears.string.html#>) 

**linecount _[deprecated]_**
     Count number of lines in a string param:

  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Input string. 

See also:

[gears.string](<../libraries/gears.string.html#>) 

**util.table.keys _[deprecated]_**
     Get a sorted table with all integer keys from a table param:

  * t the table for which the keys to get 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.keys_filter _[deprecated]_**
     Filter a tables keys for certain content types param:

  * t The table to retrieve the keys for 
  * ... the types to look for 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.reverse _[deprecated]_**
     Reverse a table param:

  * t the table to reverse 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.clone _[deprecated]_**
     Clone a table param:

  * t the table to clone 
  * deep Create a deep clone? (default: true) 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.iterate _[deprecated]_**
     Returns an iterator to cycle through, starting from the first element or the given index, all elements of a table that match a given criteria. param:

  * t
        
        the table to iterate
        

  * filter a function that returns true to indicate a positive match 
  * start what index to start iterating from. Default is 1 (=> start of the table) 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**util.table.merge _[deprecated]_**
     Merge items from the one table to another one param:

  * t [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) the container table 
  * set [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) the mixin table 

See also:

[gears.table](<../libraries/gears.table.html#>) 

**round _[deprecated]_**
     Round a number to an integer. param:

  * x number

See also:

[gears.math](<../libraries/gears.math.html#>) 

Fields

**shell**
     The default shell used when spawing processes.