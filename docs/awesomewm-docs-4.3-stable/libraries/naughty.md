# Module naughty - awesome API documentation

**Module:** `libraries.naughty`  

> Source: [libraries/naughty.html](https://awesomewm.org/doc/api/libraries/naughty.html)

---

# Module `naughty`

Notification library

### Info:

  * **Copyright** : 2008 koniu
  * **Author** : koniu <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[is_suspended ()](<#is_suspended>) | Notification state  
---|---  
[suspend ()](<#suspend>) | Suspend notifications  
[resume ()](<#resume>) | Resume notifications  
[toggle ()](<#toggle>) | Toggle notification state  
[destroy (notification, reason[, keep_visible=false])](<#destroy>) | Destroy notification by notification object  
[destroy_all_notifications (screens, reason)](<#destroy_all_notifications>) | Destroy all notifications on given screens.  
[getById (id)](<#getById>) | Get notification by ID  
[get_next_notification_id ()](<#get_next_notification_id>) | Increase notification ID by one  
[reset_timeout (notification, new_timeout)](<#reset_timeout>) | Set new notification timeout.  
[replace_text (notification, new_title, new_text)](<#replace_text>) | Replace title and text of an existing notification.  
[notify (args)](<#notify>) | Create a notification.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.notification_font](<#beautiful.notification_font>) | Notifications font.  
---|---  
[beautiful.notification_bg](<#beautiful.notification_bg>) | Notifications background color.  
[beautiful.notification_fg](<#beautiful.notification_fg>) | Notifications foreground color.  
[beautiful.notification_border_width](<#beautiful.notification_border_width>) | Notifications border width.  
[beautiful.notification_border_color](<#beautiful.notification_border_color>) | Notifications border color.  
[beautiful.notification_shape](<#beautiful.notification_shape>) | Notifications shape.  
[beautiful.notification_opacity](<#beautiful.notification_opacity>) | Notifications opacity.  
[beautiful.notification_margin](<#beautiful.notification_margin>) | Notifications margin.  
[beautiful.notification_width](<#beautiful.notification_width>) | Notifications width.  
[beautiful.notification_height](<#beautiful.notification_height>) | Notifications height.  
[beautiful.notification_max_width](<#beautiful.notification_max_width>) | Notifications maximum width.  
[beautiful.notification_max_height](<#beautiful.notification_max_height>) | Notifications maximum height.  
[beautiful.notification_icon_size](<#beautiful.notification_icon_size>) | Notifications icon size.  
  
## [Tables](<#Tables>)

[config](<#config>) | Naughty configuration - a table containing common popup settings.  
---|---  
[config.presets](<#config.presets>) | Notification presets for [naughty.notify](<../libraries/naughty.html#notify>).  
[config.defaults](<#config.defaults>) | Defaults for [naughty.notify](<../libraries/naughty.html#notify>).  
[notifications](<#notifications>) | Index of notifications per screen and position.  
  
  


## Functions

Methods 

**is_suspended ()**
     Notification state 
**suspend ()**
     Suspend notifications 
**resume ()**
     Resume notifications 
**toggle ()**
     Toggle notification state 
**destroy (notification, reason[, keep_visible=false])**
     Destroy notification by notification object 

  * notification Notification object to be destroyed 
  * reason One of the reasons from notificationClosedReason 
  * keep_visible If true, keep the notification visible (_default_ false) 


### Returns:

True if the popup was successfully destroyed, nil otherwise 

**destroy_all_notifications (screens, reason)**
     Destroy all notifications on given screens. 

  * screens [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Table of screens on which notifications should be destroyed. If nil, destroy notifications on all screens. 
  * reason naughty.notificationClosedReason Reason for closing notifications. 


### Returns:

true or nil True if all notifications were successfully destroyed, nil otherwise. 

**getById (id)**
     Get notification by ID 

  * id ID of the notification 


### Returns:

notification object if it was found, nil otherwise 

**get_next_notification_id ()**
     Increase notification ID by one 
**reset_timeout (notification, new_timeout)**
     Set new notification timeout. 

  * notification notification Notification object, which timer is to be reset. 
  * new_timeout number Time in seconds after which notification disappears. 


### Returns:

None. 

**replace_text (notification, new_title, new_text)**
     Replace title and text of an existing notification. 

  * notification notification Notification object, which contents are to be replaced. 
  * new_title [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) New title of notification. If not specified, old title remains unchanged. 
  * new_text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) New text of notification. If not specified, old text remains unchanged. 


### Returns:

None. 

**notify (args)**
     Create a notification. 

  * args The argument table containing any of the arguments below. 
    * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Text of the notification. (_default_ "") 
    * title [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Title of the notification. (_optional_) 
    * timeout int Time in seconds after which popup expires. Set 0 for no timeout. (_default_ 5) 
    * hover_timeout int Delay in seconds after which hovered popup disappears. (_optional_) 
    * screen integer or [screen](<../classes/screen.html#>) Target screen for the notification. (_default_ focused) 
    * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Corner of the workarea displaying the popups. Values: `"top_right"`, `"top_left"`, `"bottom_left"`, `"bottom_right"`, `"top_middle"`, `"bottom_middle"`. (_default_ "top_right") 
    * ontop bool Boolean forcing popups to display on top. (_default_ true) 
    * height int Popup height. (_default_ `beautiful.notification_height` or auto) 
    * width int Popup width. (_default_ `beautiful.notification_width` or auto) 
    * max_height int Popup maximum height. (_default_ `beautiful.notification_max_height` or auto) 
    * max_width int Popup maximum width. (_default_ `beautiful.notification_max_width` or auto) 
    * font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Notification font. (_default_ `beautiful.notification_font` or `beautiful.font` or `awesome.font`) 
    * icon [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Path to icon. (_optional_) 
    * icon_size int Desired icon size in px. (_optional_) 
    * fg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Foreground color. (_default_ `beautiful.notification_fg` or `beautiful.fg_focus` or `'#ffffff'`) 
    * bg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Background color. (_default_ `beautiful.notification_fg` or `beautiful.bg_focus` or `'#535d6c'`) 
    * border_width int Border width. (_default_ `beautiful.notification_border_width` or 1) 
    * border_color [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Border color. (_default_ `beautiful.notification_border_color` or `beautiful.border_focus` or `'#535d6c'`) 
    * shape gears.shape Widget shape. (_default_ `beautiful.notification_shape`) 
    * opacity gears.opacity Widget opacity. (_default_ `beautiful.notification_opacity`) 
    * margin gears.margin Widget margin. (_default_ `beautiful.notification_margin`) 
    * run func Function to run on left click. The notification object will be passed to it as an argument. You need to call e.g. `notification.die(naughty.notificationClosedReason.dismissedByUser)` from there to dismiss the notification yourself. (_optional_) 
    * destroy func Function to run when notification is destroyed. (_optional_) 
    * preset [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Table with any of the above parameters. Note: Any parameters specified directly in args will override ones defined in the preset. (_optional_) 
    * replaces_id int Replace the notification with the given ID. (_optional_) 
    * callback func Function that will be called with all arguments. The notification will only be displayed if the function returns true. Note: this function is only relevant to notifications sent via dbus. (_optional_) 
    * actions [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Mapping that maps a string to a callback when this action is selected. (_optional_) 
    * ignore_suspend bool If set to true this notification will be shown even if notifications are suspended via [naughty.suspend](<../libraries/naughty.html#suspend>). (_default_ false) 


### Returns:

optional [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The notification object, or nil in case a notification was not displayed. 


### Usage:
    
    naughty.notify({ title = "Achtung!", text = "You're idling", timeout = 0 })


## Theme variables

**beautiful.notification_font**
     Notifications font. 

### Type:

  * notification_font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or lgi.Pango.FontDescription


**beautiful.notification_bg**
     Notifications background color. 

### Type:

  * notification_bg color


**beautiful.notification_fg**
     Notifications foreground color. 

### Type:

  * notification_fg color


**beautiful.notification_border_width**
     Notifications border width. 

### Type:

  * notification_border_width int


**beautiful.notification_border_color**
     Notifications border color. 

### Type:

  * notification_border_color color


**beautiful.notification_shape**
     Notifications shape. 

### Type:

  * notification_shape gears.shape (_optional_) 


### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.notification_opacity**
     Notifications opacity. 

### Type:

  * notification_opacity int (_optional_) 


**beautiful.notification_margin**
     Notifications margin. 

### Type:

  * notification_margin int


**beautiful.notification_width**
     Notifications width. 

### Type:

  * notification_width int


**beautiful.notification_height**
     Notifications height. 

### Type:

  * notification_height int


**beautiful.notification_max_width**
     Notifications maximum width. 

### Type:

  * notification_max_width int


**beautiful.notification_max_height**
     Notifications maximum height. 

### Type:

  * notification_max_height int


**beautiful.notification_icon_size**
     Notifications icon size. 

### Type:

  * notification_icon_size int


## Tables

**config**
     Naughty configuration - a table containing common popup settings. 

### Fields:

  * padding int Space between popups and edge of the workarea. (_default_ apply_dpi(4)) 
  * spacing int Spacing between popups. (_default_ apply_dpi(1)) 
  * icon_dirs [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) List of directories that will be checked by `getIcon()`. (_default_ {"/usr/share/pixmaps/"}) 
  * icon_formats [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) List of formats that will be checked by `getIcon()`. (_default_ { "png") 
  * notify_callback function Callback used to modify or reject notifications, e.g. naughty.config.notify_callback = function(args) args.text = ‘prefix: ’ .. args.text return args end To reject a notification return `nil` from the callback. If the notification is a freedesktop notification received via DBUS, you can access the freedesktop hints via `args.freedesktop_hints` if any where specified. (_optional_) 
  * presets [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Notification presets. See [config.presets](<../libraries/naughty.html#config.presets>). 
  * defaults [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) Default values for the params to `notify()`. These can optionally be overridden by specifying a preset. See [config.defaults](<../libraries/naughty.html#config.defaults>). 


**config.presets**
     Notification presets for [naughty.notify](<../libraries/naughty.html#notify>). This holds presets for different purposes. A preset is a table of any parameters for `notify()`, overriding the default values (`naughty.config.defaults`).

You have to pass a reference of a preset in your `notify()` as the `preset` argument.

The presets `"low"`, `"normal"` and `"critical"` are used for notifications over DBUS. 

### Fields:

  * low The preset for notifications with low urgency level. 
    * timeout int (_default_ 5) 
  * normal [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The default preset for every notification without a preset that will also be used for normal urgency level. (_default_ empty) 
  * critical The preset for notifications with a critical urgency level. 
    * bg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ "#ff0000") 
    * fg [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ "#ffffff") 
    * timeout [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ 0) 


**config.defaults**
     Defaults for [naughty.notify](<../libraries/naughty.html#notify>). 

### Fields:

  * timeout int (_default_ 5) 
  * text [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ "") 
  * screen int Defaults to `awful.screen.focused`. (_optional_) 
  * ontop boolean (_default_ true) 
  * margin int (_default_ apply_dpi(5)) 
  * border_width int (_default_ apply_dpi(1)) 
  * position [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ "top_right") 


**notifications**
     Index of notifications per screen and position. See config table for valid ‘position’ values. Each element is a table consisting of: 

### Fields:

  * box Wibox object containing the popup 
  * height Popup height 
  * width Popup width 
  * die Function to be executed on timeout 
  * id Unique notification id based on a counter