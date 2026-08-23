# Module gears.string - awesome API documentation

**Module:** `libraries.gears.string`  

> Source: [libraries/gears.string.html](https://awesomewm.org/doc/api/libraries/gears.string.html)

---

# Module `gears.string`

String module for gears

## [Functions](<#Functions>)

[xml_escape (text)](<#xml_escape>) | Escape a string from XML char.  
---|---  
[xml_unescape (text)](<#xml_unescape>) | Unescape a string from entities.  
[linecount (text)](<#linecount>) | Count number of lines in a string  
[linewrap (text, width, indent)](<#linewrap>) | Split a string into multiple lines  
[quote_pattern ()](<#quote_pattern>) | Escape all special pattern-matching characters so that lua interprets them literally instead of as a character class.  
[query_to_pattern (s)](<#query_to_pattern>) | Generate a pattern matching expression that ignores case.  
[split (str, delimiter)](<#split>) | Split separates a string containing a delimiter into the list of substrings between that delimiter.  
[startswith (str, sub)](<#startswith>) | Check if a string starts with another string  
[endswith (str, sub)](<#endswith>) | Check if a string ends with another string  
  
  


## Functions

Methods 

**xml_escape (text)**
     Escape a string from XML char. Useful to set raw text in textbox. 

  * text Text to escape. 


### Returns:

Escape text. 

**xml_unescape (text)**
     Unescape a string from entities. 

  * text Text to unescape. 


### Returns:

Unescaped text. 

**linecount (text)**
     Count number of lines in a string 

  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Input string. 


### Returns:

int Number of lines. 

**linewrap (text, width, indent)**
     Split a string into multiple lines 

  * text String to wrap. 
  * width Maximum length of each line. Default: 72. 
  * indent Number of spaces added before each wrapped line. Default: 0. 


### Returns:

The string with lines wrapped to width. 

**quote_pattern ()**
     Escape all special pattern-matching characters so that lua interprets them literally instead of as a character class. Source: http://stackoverflow.com/a/20778724/15690 
**query_to_pattern (s)**
     Generate a pattern matching expression that ignores case. 

  * s Original pattern matching expression. 


**split (str, delimiter)**
     Split separates a string containing a delimiter into the list of substrings between that delimiter. 

  * str [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) String to be splitted 
  * delimiter [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Character where the string will be splitted 


### Returns:

[table](<https://www.lua.org/manual/5.1/manual.html#5.5>) list of the substrings 

**startswith (str, sub)**
     Check if a string starts with another string 

  * str [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) String to search 
  * sub [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) String to check for 


**endswith (str, sub)**
     Check if a string ends with another string 

  * str [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) String to search 
  * sub [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) String to check for