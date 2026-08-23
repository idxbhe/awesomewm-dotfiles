# Module mousegrabber - awesome API documentation

**Module:** `libraries.mousegrabber`  

> Source: [libraries/mousegrabber.html](https://awesomewm.org/doc/api/libraries/mousegrabber.html)

---

# Module `mousegrabber`

awesome mousegrabber API

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[run (func, cursor)](<#run>) | Grab the mouse pointer and list motions, calling callback function at each motion.  
---|---  
[stop ()](<#stop>) | Stop grabbing the mouse pointer.  
[isrunning ()](<#isrunning>) | Check if mousegrabber is running.  
  
  


## Functions

Methods 

**run (func, cursor)**
    

Grab the mouse pointer and list motions, calling callback function at each motion. The callback function must return a boolean value: true to continue grabbing, false to stop. The function is called with one argument: a table containing modifiers pointer coordinates.

The list of valid cusrors are:

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


  * func A callback function as described above. 
  * cursor The name of a X cursor to use while grabbing. 


**stop ()**
     Stop grabbing the mouse pointer. 
**isrunning ()**
     Check if mousegrabber is running. 

### Returns:

boolean True if running, false otherwise.