# Module root - awesome API documentation

**Module:** `libraries.root`  

> Source: [libraries/root.html](https://awesomewm.org/doc/api/libraries/root.html)

---

# Module `root`

awesome root window API

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[fake_input (event_type, detail, x, y)](<#fake_input>) | Send fake keyboard or mouse events.  
---|---  
[keys (keys_array)](<#keys>) | Get or set global key bindings.  
[buttons (button_table)](<#buttons>) | Get or set global mouse bindings.  
[cursor (cursor_name)](<#cursor>) | Set the root cursor  
[drawins ()](<#drawins>) | Get the drawins attached to a screen.  
[wallpaper (pattern)](<#wallpaper>) | Get the wallpaper as a cairo surface or set it as a cairo pattern.  
[size ()](<#size>) | Get the size of the root window.  
[size_mm ()](<#size_mm>) | Get the physical size of the root window, in millimeter.  
[tags ()](<#tags>) | Get the attached tags.  
  
  


## Functions

Methods 

**fake_input (event_type, detail, x, y)**
    

Send fake keyboard or mouse events.

Usually the currently focused client or the keybindings will receive those events. If a `keygrabber` or [mousegrabber](<../libraries/mousegrabber.html#>) is running, then it will get them.

Some keys have different names compared to the ones generally used in Awesome. For example, Awesome uses “modifier keys” for keybindings using their X11 names such as “Control” or “Mod1” (for “Alt”). These are not the name of the key but is only the name of the modifier they represent. Some modifiers are even present twice on some keyboard like the left and right “Shift”. Here is a list of the “real” key names matching the modifiers in [fake_input](<../libraries/root.html#fake_input>):

Modifier name  | Key name | Other key name  
---|---|---  
Mod4|  Super_L |  Super_R   
Control |  Control_L |  Control_R   
Shift |  Shift_L |  Shift_R   
Mod1|  Alt_L |  Alt_R   
  
Note that this is valid for most of the modern “western” keyboard layouts. Some older, custom or foreign layouts may break this convention.

This function is very low level, to be more useful, it can be wrapped into higher level constructs such as:

**Sending strings:**
    
    
    local function send_string_to_client(s, c)
        local old_c = client.focus
        client.focus = c
        for i=1, #s do
            local char = s:sub(i,i)
            root.fake_input('key_press'  , char)
            root.fake_input('key_release', char)
        end
        client.focus = old_c
    end
    
    send_string_to_client('Hello world!')
    

Note that this example works for most ASCII inputs but may fail depending on how the string is encoded. Some multi-byte characters may not represent keys and some UTF-8 encoding format create characters by combining multiple elements such as accent + base character or various escape sequences. If you wish to use this example for “real world” i18n use cases, learning about XKB event and UTF-8 encoding is a prerequisites.

**Clicking:**

![Client geometry](../images/mouse.svg)
    
    
    local function click(button_id, x, y)
        mouse.coords {x = x, y = y}
        root.fake_input('button_press' , button_id)
        root.fake_input('button_release', button_id)
    end
    
    click(1, 42, 42)
    

  * event_type The event type: key_press, key_release, button_press, button_release or motion_notify. 
  * detail The detail: in case of a key event, this is the keycode to send, in case of a button event this is the number of the button. In case of a motion event, this is a boolean value which if true makes the coordinates relatives. 
  * x In case of a motion event, this is the X coordinate. 
  * y In case of a motion event, this is the Y coordinate. 


**keys (keys_array)**
     Get or set global key bindings. These bindings will be available when you press keys on the root window. 

  * keys_array [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or nil An array of key binding objects, or nothing. 


### Returns:

The array of key bindings objects of this client. 

**buttons (button_table)**
     Get or set global mouse bindings. This binding will be available when you click on the root window. 

  * button_table An array of mouse button bindings objects, or nothing. 


### Returns:

The array of mouse button bindings objects. 

**cursor (cursor_name)**
    

Set the root cursor The possible values are:

  * num_glyphs   
---  
cursor   
arrow   
based_arrow_down   
based_arrow_up   
boat   
bogosity   
bottom_left_corner   
bottom_right_corner   
bottom_side   
bottom_tee   
box_spiral   
center_ptr   
circle   
clock   
coffee_mug   
cross   
cross_reverse   
crosshair   
diamond_cross   
dot   
dotbox   
double_arrow   
draft_large   
draft_small   
draped_box   
exchange   
fleur   
gobbler   
gumby   
hand   
hand   
heart   
icon   
iron_cross   
left_ptr   
left_side   
left_tee   
leftbutton   
ll_angle   
lr_angle   
man   
middlebutton   
mouse   
pencil   
pirate   
plus   
question_arrow   
right_ptr   
right_side   
right_tee   
rightbutton   
rtl_logo   
sailboat   
sb_down_arrow   
sb_h_double_arrow   
sb_left_arrow   
sb_right_arrow   
sb_up_arrow   
sb_v_double_arrow   
shuttle   
sizing   
spider   
spraycan   
star   
target   
tcross   
top_left_arrow   
top_left_corner   
top_right_corner   
top_side   
top_tee   
trek   
ul_angle   
umbrella   
ur_angle   
watch   
xterm   


  * cursor_name A X cursor name. 


**drawins ()**
     Get the drawins attached to a screen. 

### Returns:

A table with all drawins. 

**wallpaper (pattern)**
     Get the wallpaper as a cairo surface or set it as a cairo pattern. 

  * pattern A cairo pattern as light userdata 


### Returns:

A cairo surface or nothing. 

**size ()**
     Get the size of the root window. 

### Returns:

  1. Width of the root window.
  2. height of the root window.


**size_mm ()**
     Get the physical size of the root window, in millimeter. 

### Returns:

  1. Width of the root window, in millimeters.
  2. height of the root window, in millimeters.


**tags ()**
     Get the attached tags. 

### Returns:

A table with all tags.