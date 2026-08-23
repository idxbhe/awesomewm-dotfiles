# Module gears.filesystem - awesome API documentation

**Module:** `libraries.gears.filesystem`  

> Source: [libraries/gears.filesystem.html](https://awesomewm.org/doc/api/libraries/gears.filesystem.html)

---

# Module `gears.filesystem`

Filesystem module for gears

## [Functions](<#Functions>)

[make_directories (dir)](<#make_directories>) | Create a directory, including all missing parent directories.  
---|---  
[make_parent_directories (path)](<#make_parent_directories>) | Create all parent directories for a given path.  
[file_readable (filename)](<#file_readable>) | Check if a file exists, is readable and not a directory.  
[file_executable (filename)](<#file_executable>) | Check if a file exists, is executable and not a directory.  
[dir_readable (path)](<#dir_readable>) | Check if a path exists, is readable and a directory.  
[is_dir (path)](<#is_dir>) | Check if a path is a directory.  
[get_xdg_config_home ()](<#get_xdg_config_home>) | Get the config home according to the XDG basedir specification.  
[get_xdg_cache_home ()](<#get_xdg_cache_home>) | Get the cache home according to the XDG basedir specification.  
[get_xdg_data_home ()](<#get_xdg_data_home>) | Get the data home according to the XDG basedir specification.  
[get_xdg_data_dirs ()](<#get_xdg_data_dirs>) | Get the data dirs according to the XDG basedir specification.  
[get_configuration_dir ()](<#get_configuration_dir>) | Get the path to the user’s config dir.  
[get_cache_dir ()](<#get_cache_dir>) | Get the path to a directory that should be used for caching data.  
[get_themes_dir ()](<#get_themes_dir>) | Get the path to the directory where themes are installed.  
[get_awesome_icon_dir ()](<#get_awesome_icon_dir>) | Get the path to the directory where our icons are installed.  
[get_dir (d)](<#get_dir>) | Get the user’s config or cache dir.  
  
  


## Functions

Methods 

**make_directories (dir)**
     Create a directory, including all missing parent directories. 

  * dir [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The directory. 


### Returns:

(true, nil) on success, (false, err) on failure 

**make_parent_directories (path)**
     Create all parent directories for a given path. 

  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The path whose parents should be created. 


### Returns:

(true, nil) on success, (false, err) on failure 

**file_readable (filename)**
     Check if a file exists, is readable and not a directory. 

  * filename [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The file path. 


### Returns:

boolean True if file exists and is readable. 

**file_executable (filename)**
     Check if a file exists, is executable and not a directory. 

  * filename [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The file path. 


### Returns:

boolean True if file exists and is executable. 

**dir_readable (path)**
     Check if a path exists, is readable and a directory. 

  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The directory path. 


### Returns:

boolean True if path exists and is readable. 

**is_dir (path)**
     Check if a path is a directory. 

  * path [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The directory path 


### Returns:

boolean True if path exists and is a directory. 

**get_xdg_config_home ()**
     Get the config home according to the XDG basedir specification. 

### Returns:

the config home (XDG_CONFIG_HOME) with a slash at the end. 

**get_xdg_cache_home ()**
     Get the cache home according to the XDG basedir specification. 

### Returns:

the cache home (XDG_CACHE_HOME) with a slash at the end. 

**get_xdg_data_home ()**
     Get the data home according to the XDG basedir specification. 

### Returns:

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) the data home (XDG_DATA_HOME) with a slash at the end. 

**get_xdg_data_dirs ()**
     Get the data dirs according to the XDG basedir specification. 

### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) the data dirs (XDG_DATA_DIRS) with a slash at the end of each entry. 

**get_configuration_dir ()**
     Get the path to the user’s config dir. This is the directory containing the configuration file (“rc.lua”). 

### Returns:

A string with the requested path with a slash at the end. 

**get_cache_dir ()**
     Get the path to a directory that should be used for caching data. 

### Returns:

A string with the requested path with a slash at the end. 

**get_themes_dir ()**
     Get the path to the directory where themes are installed. 

### Returns:

A string with the requested path with a slash at the end. 

**get_awesome_icon_dir ()**
     Get the path to the directory where our icons are installed. 

### Returns:

A string with the requested path with a slash at the end. 

**get_dir (d)**
     Get the user’s config or cache dir. It first checks XDG_CONFIG_HOME / XDG_CACHE_HOME, but then goes with the default paths. 

  * d The directory to get (either “config” or “cache”). 


### Returns:

A string containing the requested path.