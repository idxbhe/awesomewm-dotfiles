# Module awful.completion - awesome API documentation

**Module:** `libraries.awful.completion`  

> Source: [libraries/awful.completion.html](https://awesomewm.org/doc/api/libraries/awful.completion.html)

---

# Module `awful.completion`

Completion module.

This module store a set of function using shell to complete commands name.

### Info:

  * **Copyright** : 2008 Julien Danjou, Sébastien Gross
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>,Sébastien Gross <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[bashcomp_load (src)](<#bashcomp_load>) | Enable programmable bash completion in awful.completion.bash at the price of a slight overhead.  
---|---  
[shell (command, cur_pos, ncomp[, shell=based on SHELL])](<#shell>) | Use shell completion system to complete commands and filenames.  
[generic (text, cur_pos, ncomp, keywords)](<#generic>) | Run a generic completion.  
  
  


## Functions

Methods 

**bashcomp_load (src)**
     Enable programmable bash completion in awful.completion.bash at the price of a slight overhead. 

  * src The bash completion source file, /etc/bash_completion by default. 


**shell (command, cur_pos, ncomp[, shell=based on SHELL])**
     Use shell completion system to complete commands and filenames. 

  * command [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The command line. 
  * cur_pos number The cursor position. 
  * ncomp number The element number to complete. 
  * shell [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The shell to use for completion. Supports “bash” and “zsh”. (_default_ based on SHELL) 


### Returns:

  1. [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The new command.
  2. number The new cursor position.
  3. [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The table with all matches.


**generic (text, cur_pos, ncomp, keywords)**
     Run a generic completion. For this function to run properly the awful.completion.keyword table should be fed up with all keywords. The completion is run against these keywords. 

  * text The current text the user had typed yet. 
  * cur_pos The current cursor position. 
  * ncomp The number of yet requested completion using current text. 
  * keywords The keywords table uised for completion. 


### Returns:

The new match, the new cursor position, the table of all matches.