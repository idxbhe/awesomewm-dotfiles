# Class tag - awesome API documentation

**Module:** `classes.tag`  

> Source: [classes/tag.html](https://awesomewm.org/doc/api/classes/tag.html)

---

# Class `tag`

awesome tag API

Furthermore to the classes described here, one can also use signals as described in [signals](<../classes/signals.html#>).

![Client geometry](../images/tag_props.svg)

**Creating tags** :

The default config initializes tags like this:
    
    
    awful.tag(
      { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
      s,
      awful.layout.layouts[1]
    )
    

If you wish to have tags with different properties, then [awful.tag.add](<../classes/tag.html#awful.tag.add>) is a better choice:
    
    
    awful.tag.add("First tag", {
        icon               = "/path/to/icon1.png",
        layout             = awful.layout.suit.tile,
        master_fill_policy = "master_width_factor",
        gap_single_client  = true,
        gap                = 15,
        screen             = s,
        selected           = true,
    })
    
    awful.tag.add("Second tag", {
        icon = "/path/to/icon2.png",
        layout = awful.layout.suit.max,
        screen = s,
    })
    

Note: the example above sets “First tag” to be selected explicitly, because otherwise you will find yourself without any selected tag.

**Accessing tags** :

To access the “current tags”, use
    
    
    local tags = awful.screen.focused().selected_tags
    

See: `awful.screen.focused`

See: [screen.selected_tags](<../classes/screen.html#screen.selected_tags>)

To ignore the corner case where multiple tags are selected:
    
    
    local t = awful.screen.focused().selected_tag
    

See: [screen.selected_tag](<../classes/screen.html#screen.selected_tag>)

To get all tags for the focused screen:
    
    
    local tags = awful.screen.focused().tags
    

See: [screen.tags](<../classes/screen.html#screen.tags>)

To get all tags:
    
    
    local tags = root.tags()
    

To get the current tag of the focused client:
    
    
    local t = client.focus and client.focus.first_tag or nil
    

See: [client.focus](<../classes/client.html#client.focus>) See: [client.first_tag](<../classes/client.html#client.first_tag>)

To get a tag from its name:
    
    
    local t = awful.tag.find_by_name(awful.screen.focused(), "name")
    

**Common shortcuts** :

Here is a few useful shortcuts not part of the default [rc.lua](<../sample files/rc.lua.html#>). Add these functions above `– {{{ Key bindings`:

Delete the current tag
    
    
    local function delete_tag()
        local t = awful.screen.focused().selected_tag
        if not t then return end
        t:delete()
    end
    

Create a new tag at the end of the list
    
    
    local function add_tag()
        awful.tag.add("NewTag", {
            screen = awful.screen.focused(),
            layout = awful.layout.suit.floating }):view_only()
    end
    

Rename the current tag
    
    
    local function rename_tag()
        awful.prompt.run {
            prompt       = "New tag name: ",
            textbox      = awful.screen.focused().mypromptbox.widget,
            exe_callback = function(new_name)
                if not new_name or #new_name == 0 then return end
    
                local t = awful.screen.focused().selected_tag
                if t then
                    t.name = new_name
                end
            end
        }
    end
    

Move the focused client to a new tag
    
    
    local function move_to_new_tag()
        local c = client.focus
        if not c then return end
    
        local t = awful.tag.add(c.class,{screen= c.screen })
        c:tags({t})
        t:view_only()
    end
    

Copy the current tag at the end of the list
    
    
    local function copy_tag()
        local t = awful.screen.focused().selected_tag
        if not t then return end
    
        local clients = t:clients()
        local t2 = awful.tag.add(t.name, awful.tag.getdata(t))
        t2:clients(clients)
        t2:view_only()
    end
    

And, in the `globalkeys` table:
    
    
    awful.key({ modkey,           }, "a", add_tag,
              {description = "add a tag", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "a", delete_tag,
              {description = "delete the current tag", group = "tag"}),
    awful.key({ modkey, "Control"   }, "a", move_to_new_tag,
              {description = "add a tag with the focused client", group = "tag"}),
    awful.key({ modkey, "Mod1"   }, "a", copy_tag,
              {description = "create a copy of the current tag", group = "tag"}),
    awful.key({ modkey, "Shift"   }, "r", rename_tag,
              {description = "rename the current tag", group = "tag"}),
    

See the [ global keybindings ](<../documentation/05-awesomerc.md.html#global_keybindings>) for more information about the keybindings.

Some signal names are starting with a dot. These dots are artefacts from the documentation generation, you get the real signal name by removing the starting dot.

### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.tag.add (name, props)](<#awful.tag.add>) | Add a tag.  
---|---  
[awful.tag.new (names, screen, layout)](<#awful.tag.new>) | Create a set of tags and attach it to a screen.  
[awful.tag.find_fallback (screen, invalids)](<#awful.tag.find_fallback>) | Find a suitable fallback tag.  
[awful.tag.history.update (obj)](<#awful.tag.history.update>) | Update the tag history.  
[awful.tag.history.restore (screen, idx)](<#awful.tag.history.restore>) | Revert tag history.  
[awful.tag.incmwfact (add, t)](<#awful.tag.incmwfact>) | Increase master width factor.  
[awful.tag.incgap (add, t)](<#awful.tag.incgap>) | Increase the spacing between clients  
[awful.tag.togglemfpol (t)](<#awful.tag.togglemfpol>) | Toggle size fill policy for the master client(s) between “expand” and “master_width_factor”.  
[awful.tag.incnmaster (add[, t[, sensible=false]])](<#awful.tag.incnmaster>) | Increase the number of master windows.  
[awful.tag.incncol (add[, t[, sensible=false]])](<#awful.tag.incncol>) | Increase number of column windows.  
[awful.tag.viewnone ([screen])](<#awful.tag.viewnone>) | View no tag.  
[awful.tag.viewidx (i[, screen])](<#awful.tag.viewidx>) | View a tag by its taglist index.  
[awful.tag.viewnext (screen)](<#awful.tag.viewnext>) | View next tag.  
[awful.tag.viewprev (screen)](<#awful.tag.viewprev>) | View previous tag.  
[awful.tag.viewmore (tags[, screen[, maximum=#tags]])](<#awful.tag.viewmore>) | View only a set of tags.  
[awful.tag.viewtoggle (t)](<#awful.tag.viewtoggle>) | Toggle selection of a tag  
[awful.tag.attached_connect_signal (screen[, signal[, Callback]])](<#awful.tag.attached_connect_signal>) | Add a signal to all attached tags and all tags that will be attached in the future.  
  
## [Object properties](<#Object_properties>)

[name](<#tag.name>) | Tag name.  
---|---  
[selected](<#tag.selected>) | True if the tag is selected to be viewed.  
[activated](<#tag.activated>) | True if the tag is active and can be used.  
[index](<#tag.index>) | The tag index.  
[screen](<#tag.screen>) | The tag screen.  
[master_width_factor](<#tag.master_width_factor>) | The tag master width factor.  
[layout](<#tag.layout>) | The tag client layout.  
[layouts](<#tag.layouts>) | The (proposed) list of available layouts for this tag.  
[volatile](<#tag.volatile>) | Define if the tag must be deleted when the last client is untagged.  
[gap](<#tag.gap>) | The gap (spacing, also called [useless_gap](<../classes/tag.html#beautiful.useless_gap>)) between clients.  
[gap_single_client](<#tag.gap_single_client>) | Enable gaps for a single client.  
[master_fill_policy](<#tag.master_fill_policy>) | Set size fill policy for the master client(s).  
[master_count](<#tag.master_count>) | Set the number of master windows.  
[icon](<#tag.icon>) | Set the tag icon.  
[column_count](<#tag.column_count>) | Set the number of columns.  
  
## [Signals](<#Signals>)

[request::select](<#request::select>) |   
---|---  
[tagged](<#tag.tagged>) | When a client gets tagged with this tag.  
[untagged](<#tag.untagged>) | When a client gets untagged with this tag.  
[property::urgent](<#property::urgent>) | True when a tagged client is urgent  
[property::urgent_count](<#property::urgent_count>) | The number of urgent tagged clients  
[request::screen](<#request::screen>) | Emitted when a screen is removed.  
[removal-pending](<#tag.removal-pending>) | Emitted after [request::screen](<../classes/tag.html#request::screen>) if no new screen has been set.  
  
## [Theme variables](<#Theme_variables>)

[beautiful.master_width_factor](<#beautiful.master_width_factor>) | The default master width factor  
---|---  
[beautiful.useless_gap](<#beautiful.useless_gap>) | The default gap.  
[beautiful.gap_single_client](<#beautiful.gap_single_client>) | Enable gaps for a single client.  
[beautiful.master_fill_policy](<#beautiful.master_fill_policy>) | The default fill policy.  
[beautiful.master_count](<#beautiful.master_count>) | The default number of master windows.  
[beautiful.column_count](<#beautiful.column_count>) | The default number of columns.  
  
## [Deprecated functions](<#Deprecated_functions>)

[awful.tag.move](<#awful.tag.move>) _[deprecated]_ | Move a tag to an absolute position in the screen[]:tags() table.  
---|---  
[awful.tag.swap](<#awful.tag.swap>) _[deprecated]_ | Swap 2 tags  
[awful.tag.delete](<#awful.tag.delete>) _[deprecated]_ | Delete a tag.  
[awful.tag.gettags](<#awful.tag.gettags>) _[deprecated]_ | Get a list of all tags on a screen  
[awful.tag.setscreen](<#awful.tag.setscreen>) _[deprecated]_ | Set a tag’s screen  
[awful.tag.getscreen](<#awful.tag.getscreen>) _[deprecated]_ | Get a tag’s screen  
[awful.tag.selectedlist](<#awful.tag.selectedlist>) _[deprecated]_ | Return a table with all visible tags  
[awful.tag.selected](<#awful.tag.selected>) _[deprecated]_ | Return only the first visible tag.  
[awful.tag.setmwfact](<#awful.tag.setmwfact>) _[deprecated]_ | Set master width factor.  
[awful.tag.getmwfact](<#awful.tag.getmwfact>) _[deprecated]_ | Get master width factor.  
[awful.tag.setlayout](<#awful.tag.setlayout>) _[deprecated]_ | Set layout.  
[awful.tag.setvolatile](<#awful.tag.setvolatile>) _[deprecated]_ | Set if the tag must be deleted when the last client is untagged  
[awful.tag.getvolatile](<#awful.tag.getvolatile>) _[deprecated]_ | Get if the tag must be deleted when the last client closes  
[awful.tag.setgap](<#awful.tag.setgap>) _[deprecated]_ | Set the spacing between clients  
[awful.tag.getgap](<#awful.tag.getgap>) _[deprecated]_ | Get the spacing between clients.  
[awful.tag.setmfpol](<#awful.tag.setmfpol>) _[deprecated]_ | Set size fill policy for the master client(s)  
[awful.tag.getmfpol](<#awful.tag.getmfpol>) _[deprecated]_ | Get size fill policy for the master client(s)  
[awful.tag.setnmaster](<#awful.tag.setnmaster>) _[deprecated]_ |   
[awful.tag.getnmaster](<#awful.tag.getnmaster>) _[deprecated]_ | Get the number of master windows.  
[awful.tag.seticon](<#awful.tag.seticon>) _[deprecated]_ | Set the tag icon  
[awful.tag.geticon](<#awful.tag.geticon>) _[deprecated]_ | Get the tag icon  
[awful.tag.setncol](<#awful.tag.setncol>) _[deprecated]_ | Set number of column windows.  
[awful.tag.getncol](<#awful.tag.getncol>) _[deprecated]_ | Get number of column windows.  
[awful.tag.getidx](<#awful.tag.getidx>) _[deprecated]_ | Get a tag’s index in the gettags() table.  
[awful.tag.viewonly](<#awful.tag.viewonly>) _[deprecated]_ | View only a tag.  
[awful.tag.getdata](<#awful.tag.getdata>) _[deprecated]_ | Get tag data table.  
[awful.tag.getproperty](<#awful.tag.getproperty>) _[deprecated]_ | Get a tag property.  
[awful.tag.setproperty](<#awful.tag.setproperty>) _[deprecated]_ | Set a tag property.  
[awful.tag.withcurrent](<#awful.tag.withcurrent>) _[deprecated]_ | Tag a client with the set of current tags.  
  
## [Fields](<#Fields>)

[awful.tag.history.limit](<#awful.tag.history.limit>) | The number of elements kept in the history.  
---|---  
[awful.tag.layouts](<#awful.tag.layouts>) | An ordered list of layouts.  
  
## [Methods](<#Methods>)

[tag:instances ()](<#tag:instances>) | Get the number of instances.  
---|---  
[tag:clients (clients_table)](<#tag:clients>) | Get or set the clients attached to this tag.  
[tag:disconnect_signal (name, func)](<#tag:disconnect_signal>) | Disconnect from a signal.  
[tag:emit_signal (name, ...)](<#tag:emit_signal>) | Emit a signal.  
[tag:connect_signal (name, func)](<#tag:connect_signal>) | Connect to a signal.  
[tag:swap (tag2)](<#tag:swap>) | Swap 2 tags  
[tag:delete ([fallback_tag=awful.tag.find_fallback()[, force=false]])](<#tag:delete>) | Delete a tag.  
[tag:find_by_name (s, name)](<#tag:find_by_name>) | Find a tag by name.  
[tag:view_only ()](<#tag:view_only>) | View only a tag.  
  
  


## Functions

Methods 

**awful.tag.add (name, props)**
    

Add a tag.

This function allow to create tags from a set of properties:
    
    
    local t = awful.tag.add("my new tag", {
        screen = screen.primary,
        layout = awful.layout.suit.max,
    })
    

  * name The tag name, a string 
  * props The tags inital properties, a table 


### Returns:

The created tag 


### See also:

[tag.delete](<../classes/tag.html#tag:delete>) 

**awful.tag.new (names, screen, layout)**
     Create a set of tags and attach it to a screen. 

  * names The tag name, in a table 
  * screen The tag screen, or 1 if not set. 
  * layout The layout or layout table to set for this tags by default. 


### Returns:

A table with all created tags. 

**awful.tag.find_fallback (screen, invalids)**
     Find a suitable fallback tag. 

  * screen The screen to look for a tag on. [awful.screen.focused()] 
  * invalids A table of tags we consider unacceptable. [selectedlist(scr)] 


**awful.tag.history.update (obj)**
     Update the tag history. 

  * obj Screen object. 


**awful.tag.history.restore (screen, idx)**
     Revert tag history. 

  * screen The screen. 
  * idx Index in history. Defaults to “previous” which is a special index toggling between last two selected sets of tags. Number (eg 1) will go back to the given index in history. 


**awful.tag.incmwfact (add, t)**
     Increase master width factor. 

  * add Value to add to master width factor. 
  * t The tag to modify, if null tag.selected() is used. 


### See also:

[master_width_factor](<../classes/tag.html#beautiful.master_width_factor>) 

**awful.tag.incgap (add, t)**
     Increase the spacing between clients 

  * add Value to add to the spacing between clients 
  * t The tag to modify, if null tag.selected() is used. 


### See also:

[gap](<../classes/tag.html#tag.gap>) 

**awful.tag.togglemfpol (t)**
     Toggle size fill policy for the master client(s) between “expand” and “master_width_factor”. 

  * t [tag](<../classes/tag.html#>) The tag to modify, if null tag.selected() is used. 


### See also:

[master_fill_policy](<../classes/tag.html#beautiful.master_fill_policy>) 

**awful.tag.incnmaster (add[, t[, sensible=false]])**
     Increase the number of master windows. 

  * add Value to add to number of master windows. 
  * t The tag to modify, if null tag.selected() is used. (_optional_) 
  * sensible boolean Limit nmaster based on the number of visible tiled windows? (_default_ false) 


### See also:

[master_count](<../classes/tag.html#tag.master_count>) 

**awful.tag.incncol (add[, t[, sensible=false]])**
     Increase number of column windows. 

  * add Value to add to number of column windows. 
  * t The tag to modify, if null tag.selected() is used. (_optional_) 
  * sensible boolean Limit column_count based on the number of visible tiled windows? (_default_ false) 


**awful.tag.viewnone ([screen])**
     View no tag. 

  * screen int or [screen](<../classes/screen.html#>) The screen. (_optional_) 


**awful.tag.viewidx (i[, screen])**
     View a tag by its taglist index.

This is equivalent to `screen.tags[i]:view_only()`

  * i The **relative** index to see. 
  * screen The screen. (_optional_) 


### See also:

[screen.tags](<../classes/screen.html#screen.tags>) 

**awful.tag.viewnext (screen)**
     View next tag. This is the same as tag.viewidx(1). 

  * screen The screen. 


**awful.tag.viewprev (screen)**
     View previous tag. This is the same a tag.viewidx(-1). 

  * screen The screen. 


**awful.tag.viewmore (tags[, screen[, maximum=#tags]])**
     View only a set of tags.

If `maximum` is set, there will be a limit on the number of new tag being selected. The tags already selected do not count. To do nothing if one or more of the tags are already selected, set `maximum` to zero. 

  * tags A table with tags to view only. 
  * screen The screen of the tags. (_optional_) 
  * maximum number The maximum number of tags to select. (_default_ #tags) 


**awful.tag.viewtoggle (t)**
     Toggle selection of a tag 

  * t [tag](<../classes/tag.html#>) Tag to be toggled 


### See also:

[selected](<../classes/tag.html#tag.selected>) 

**awful.tag.attached_connect_signal (screen[, signal[, Callback]])**
     Add a signal to all attached tags and all tags that will be attached in the future. When a tag is detached from the screen, its signal is removed. 

  * screen [screen](<../classes/screen.html#>) The screen concerned, or all if nil. 
  * signal [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The signal name. (_optional_) 
  * Callback function (_optional_) 


## Object properties

**name**
    

Tag name.

**Signal:**

  * _property::name_


### Type:

  * string


**selected**
    

True if the tag is selected to be viewed.

**Signal:**

  * _property::selected_


### Type:

  * boolean


**activated**
    

True if the tag is active and can be used.

**Signal:**

  * _property::activated_


### Type:

  * boolean


**index**
    

The tag index.

The index is the position as shown in the [awful.widget.taglist](<../classes/awful.widget.taglist.html#>).

**Signal:**

  * _property::index_


### Type:

  * integer


**screen**
    

The tag screen.

**Signal:**

  * _property::screen_


### Type:

  * screen


### See also:

[screen](<../classes/screen.html#>) 

**master_width_factor**
    

The tag master width factor.

The master width factor is one of the 5 main properties used to configure the [layout](<../classes/tag.html#tag.layout>). Each layout interpret (or ignore) this property differenly.

See the layout suit documentation for information about how the master width factor is used.

**Signal:**

  * _property::mwfact_ (deprecated)
  * _property::master_width_factor_


### Type:

  * number Between 0 and 1 


### See also:

  * [master_count](<../classes/tag.html#tag.master_count>)
  * [column_count](<../classes/tag.html#tag.column_count>)
  * [master_fill_policy](<../classes/tag.html#beautiful.master_fill_policy>)
  * [gap](<../classes/tag.html#tag.gap>)


**layout**
    

The tag client layout.

This property hold the layout. A layout can be either stateless or stateful. Stateless layouts are used by default by Awesome. They tile clients without any other overhead. They take an ordered list of clients and place them on the screen. Stateful layouts create an object instance for each tags and can store variables and metadata. Because of this, they are able to change over time and be serialized (saved).

Both types of layouts have valid usage scenarios.

**Stateless layouts:**

These layouts are stored in `awful.layout.suit`. They expose a table with 2 fields:

  * **name** (_string_): The layout name. This should be unique.
  * **arrange** (_function_): The function called when the clients need to be placed. The only parameter is a table or arguments returned by [awful.layout.parameters](<../libraries/awful.layout.html#parameters>)


**Stateful layouts:**

The stateful layouts API is the same as stateless, but they are a function returining a layout instead of a layout itself. They also should have an `is_dynamic = true` property. If they don’t, [awful.tag](<../libraries/awful.tag.html#>) will create a new instance everytime the layout is set. If they do, the instance will be cached and re-used.

**Signal:**

  * _property::layout_


### Type:

  * layout [layout](<../classes/tag.html#tag.layout>) or function A layout table or a constructor function 


### See also:

[awful.tag.layouts](<../classes/tag.html#awful.tag.layouts>) 

**layouts**
     The (proposed) list of available layouts for this tag.

This property allows to define a subset (or superset) of layouts available in the “rotation table”. In the default configuration file, `Mod4+Space` and `Mod4+Shift+Space` are used to switch between tags. The [awful.widget.layoutlist](<../classes/awful.widget.layoutlist.html#>) also uses this as its default layout filter.

By default, it will be the same as [awful.layout.layouts](<../libraries/awful.layout.html#layouts>) unless there the a layout not present is used. If that’s the case they will be added at the front of the list. 

### Type:

  * table


### See also:

  * [awful.layout.layouts](<../libraries/awful.layout.html#layouts>)
  * [layout](<../classes/tag.html#tag.layout>)


**volatile**
    

Define if the tag must be deleted when the last client is untagged.

This is useful to create “throw-away” tags for operation like 50/50 side-by-side views.
    
    
    local t = awful.tag.add("Temporary", {
         screen   = client.focus.screen,
         volatile = true,
         clients  = {
             client.focus,
             awful.client.focus.history.get(client.focus.screen, 1)
         }
    }
    

**Signal:**

  * _property::volatile_


### Type:

  * boolean


**gap**
    

The gap (spacing, also called [useless_gap](<../classes/tag.html#beautiful.useless_gap>)) between clients.

This property allow to waste space on the screen in the name of style, unicorns and readability.

**Signal:**

  * _property::useless_gap_


### Type:

  * number The value has to be greater than zero. 


### See also:

[gap_single_client](<../classes/tag.html#tag.gap_single_client>) 

**gap_single_client**
    

Enable gaps for a single client.

**Signal:**

  * _property::gap_single_client_


### Type:

  * boolean Enable gaps for a single client 


**master_fill_policy**
    

Set size fill policy for the master client(s).

**Possible values** :

  * _expand_ : Take all the space
  * _master_width_factor_ : Only take the ratio defined by the [master_width_factor](<../classes/tag.html#beautiful.master_width_factor>)


**Signal:**

  * _property::master_fill_policy_


### Type:

  * string “expand” or “master_width_factor”


**master_count**
    

Set the number of master windows.

**Signal:**

  * _property::nmaster_ (deprecated)
  * _property::master_count_


### Type:

  * integer nmaster Only positive values are accepted 


**icon**
    

Set the tag icon.

**Signal:**

  * _property::icon_


### Type:

  * icon path or surface The icon 


**column_count**
    

Set the number of columns.

**Signal:**

  * _property::ncol_ (deprecated)
  * _property::column_count_


### Type:

  * ncol integer Has to be greater than 1 


## Signals

**request::select**
    
**tagged**
     When a client gets tagged with this tag. 

### Arguments:

  * c [client.object](<../classes/client.html#awful.object>) The tagged client. 


**untagged**
     When a client gets untagged with this tag. 

### Arguments:

  * c [client.object](<../classes/client.html#awful.object>) The untagged client. 


**property::urgent**
     True when a tagged client is urgent 

### See also:

[client.urgent](<../classes/client.html#request::urgent>) 

**property::urgent_count**
     The number of urgent tagged clients 

### See also:

[client.urgent](<../classes/client.html#request::urgent>) 

**request::screen**
     Emitted when a screen is removed. This can be used to salvage existing tags by moving them to a new screen (or creating a virtual screen). By default, there is no handler for this request. The tags will be deleted. To prevent this, an handler for this request must simply set a new screen for the tag. 
**removal-pending**
     Emitted after [request::screen](<../classes/tag.html#request::screen>) if no new screen has been set. The tag will be deleted, this is a last chance to move its clients before they are sent to a fallback tag. Connect to [request::screen](<../classes/tag.html#request::screen>) if you wish to salvage the tag. 

## Theme variables

**beautiful.master_width_factor**
     The default master width factor 

### Type:

  * number (default: 0.5) 


### See also:

  * [master_width_factor](<../classes/tag.html#beautiful.master_width_factor>)
  * [gap](<../classes/tag.html#tag.gap>)


**beautiful.useless_gap**
     The default gap. 

### Type:

  * number (default: 0) 


### See also:

  * [gap](<../classes/tag.html#tag.gap>)
  * [gap_single_client](<../classes/tag.html#tag.gap_single_client>)


**beautiful.gap_single_client**
     Enable gaps for a single client. 

### Type:

  * boolean (default: true) 


### See also:

  * [gap](<../classes/tag.html#tag.gap>)
  * [gap_single_client](<../classes/tag.html#tag.gap_single_client>)


**beautiful.master_fill_policy**
    

The default fill policy.

**Possible values** :

  * _expand_ : Take all the space
  * _master_width_factor_ : Only take the ratio defined by the [master_width_factor](<../classes/tag.html#beautiful.master_width_factor>)


### Type:

  * string (default: “expand”) 


### See also:

[master_fill_policy](<../classes/tag.html#beautiful.master_fill_policy>) 

**beautiful.master_count**
     The default number of master windows. 

### Type:

  * integer (default: 1) 


### See also:

[master_count](<../classes/tag.html#tag.master_count>) 

**beautiful.column_count**
     The default number of columns. 

### Type:

  * integer (default: 1) 


### See also:

[column_count](<../classes/tag.html#tag.column_count>) 


## Deprecated functions

**awful.tag.move _[deprecated]_**
     Move a tag to an absolute position in the screen[]:tags() table. param:

  * new_index Integer absolute position in the table to insert. 
  * target_tag The tag that should be moved. If null, the currently selected tag is used. 

See also:

[index](<../classes/tag.html#tag.index>) 

**awful.tag.swap _[deprecated]_**
     Swap 2 tags param:

  * tag1 The first tag 
  * tag2 The second tag 

See also:

[tag.swap](<../classes/tag.html#tag:swap>) 

**awful.tag.delete _[deprecated]_**
     Delete a tag. param:

  * target_tag Optional tag object to delete. [selected()] 
  * fallback_tag Tag to assign stickied tags to. [~selected()] 

See also:

[tag.delete](<../classes/tag.html#tag:delete>) 

**awful.tag.gettags _[deprecated]_**
     Get a list of all tags on a screen param:

  * s [screen](<../classes/screen.html#>) Screen 

See also:

[screen.tags](<../classes/screen.html#screen.tags>) 

**awful.tag.setscreen _[deprecated]_**
     Set a tag’s screen param:

  * s Screen 
  * t tag object 

See also:

[screen](<../classes/screen.html#>) 

**awful.tag.getscreen _[deprecated]_**
     Get a tag’s screen param:

  * t tag object (_optional_) 

See also:

[screen](<../classes/screen.html#>) 

**awful.tag.selectedlist _[deprecated]_**
     Return a table with all visible tags param:

  * s Screen. 

See also:

[screen.selected_tags](<../classes/screen.html#screen.selected_tags>) 

**awful.tag.selected _[deprecated]_**
     Return only the first visible tag. param:

  * s Screen. 

See also:

[screen.selected_tag](<../classes/screen.html#screen.selected_tag>) 

**awful.tag.setmwfact _[deprecated]_**
     Set master width factor. param:

  * mwfact Master width factor. 
  * t The tag to modify, if null tag.selected() is used. 

See also:

  * [master_fill_policy](<../classes/tag.html#beautiful.master_fill_policy>)
  * [master_width_factor](<../classes/tag.html#beautiful.master_width_factor>)


**awful.tag.getmwfact _[deprecated]_**
     Get master width factor. param:

  * t The tag. (_optional_) 

See also:

  * [master_width_factor](<../classes/tag.html#beautiful.master_width_factor>)
  * [master_fill_policy](<../classes/tag.html#beautiful.master_fill_policy>)


**awful.tag.setlayout _[deprecated]_**
     Set layout. param:

  * layout a layout table or a constructor function 
  * t The tag to modify 

See also:

[layout](<../classes/tag.html#tag.layout>) 

**awful.tag.setvolatile _[deprecated]_**
     Set if the tag must be deleted when the last client is untagged param:

  * volatile boolean If the tag must be deleted when the last client is untagged 
  * t The tag to modify, if null tag.selected() is used. 

See also:

[volatile](<../classes/tag.html#tag.volatile>) 

**awful.tag.getvolatile _[deprecated]_**
     Get if the tag must be deleted when the last client closes param:

  * t The tag to modify, if null tag.selected() is used. 

See also:

[volatile](<../classes/tag.html#tag.volatile>) 

**awful.tag.setgap _[deprecated]_**
     Set the spacing between clients param:

  * useless_gap The spacing between clients 
  * t The tag to modify, if null tag.selected() is used. 

See also:

[gap](<../classes/tag.html#tag.gap>) 

**awful.tag.getgap _[deprecated]_**
     Get the spacing between clients. param:

  * t [tag](<../classes/tag.html#>) The tag. (_default_ tag.selected()) 
  * numclients int Number of (tiled) clients. Passing this will return 0 for a single client. You can override this function to change this behavior. (_optional_) 

See also:

[gap](<../classes/tag.html#tag.gap>) 

**awful.tag.setmfpol _[deprecated]_**
     Set size fill policy for the master client(s) param:

  * policy [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Can be set to “expand” (fill all the available workarea) or “master_width_factor” (fill only an area inside the master width factor) 
  * t [tag](<../classes/tag.html#>) The tag to modify (_default_ tag.selected()) 

See also:

[master_fill_policy](<../classes/tag.html#beautiful.master_fill_policy>) 

**awful.tag.getmfpol _[deprecated]_**
     Get size fill policy for the master client(s) param:

  * t [tag](<../classes/tag.html#>) The tag (_default_ tag.selected()) 

See also:

[master_fill_policy](<../classes/tag.html#beautiful.master_fill_policy>) 

**awful.tag.setnmaster _[deprecated]_**
     param:

  * nmaster The number of master windows. 
  * t The tag. (_optional_) 

See also:

[master_count](<../classes/tag.html#tag.master_count>) 

**awful.tag.getnmaster _[deprecated]_**
     Get the number of master windows. param:

  * t The tag. (_optional_) 

See also:

[master_count](<../classes/tag.html#tag.master_count>) 

**awful.tag.seticon _[deprecated]_**
     Set the tag icon param:

  * icon the icon to set, either path or image object 
  * _tag the tag 

See also:

[icon](<../classes/tag.html#tag.icon>) 

**awful.tag.geticon _[deprecated]_**
     Get the tag icon param:

  * _tag the tag 

See also:

[icon](<../classes/tag.html#tag.icon>) 

**awful.tag.setncol _[deprecated]_**
     Set number of column windows. param:

  * ncol The number of column. 
  * t The tag to modify, if null tag.selected() is used. 

See also:

[column_count](<../classes/tag.html#tag.column_count>) 

**awful.tag.getncol _[deprecated]_**
     Get number of column windows. param:

  * t The tag. (_optional_) 

See also:

[column_count](<../classes/tag.html#tag.column_count>) 

**awful.tag.getidx _[deprecated]_**
     Get a tag’s index in the gettags() table. param:

  * query_tag The tag object to find. [selected()] 

See also:

[index](<../classes/tag.html#tag.index>) 

**awful.tag.viewonly _[deprecated]_**
     View only a tag. param:

  * t The tag object. 

See also:

[tag.view_only](<../classes/tag.html#tag:view_only>) 

**awful.tag.getdata _[deprecated]_**
     Get tag data table. Do not use. param:

  * _tag [tag](<../classes/tag.html#>) The tag. 


**awful.tag.getproperty _[deprecated]_**
     Get a tag property. Use `_tag.prop` directly. param:

  * _tag [tag](<../classes/tag.html#>) The tag. 
  * prop [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The property name. 


**awful.tag.setproperty _[deprecated]_**
     Set a tag property. This properties are internal to awful. Some are used to draw taglist, or to handle layout, etc. Use `_tag.prop = value` param:

  * _tag The tag. 
  * prop The property name. 
  * value The value. 


**awful.tag.withcurrent _[deprecated]_**
     Tag a client with the set of current tags. param:

  * c The client to tag. 


Fields

**awful.tag.history.limit**
     The number of elements kept in the history. 

  * limit integer (_default_ 20) 


**awful.tag.layouts**
     An ordered list of layouts. `awful.tag.layout` Is usually defined in [rc.lua](<../sample files/rc.lua.html#>). It store the list of layouts used when selecting the previous and next layouts. This is the default:
    
    
     -- Table of layouts to cover with awful.layout.inc, order matters.
     awful.layout.layouts = {
         awful.layout.suit.floating,
         awful.layout.suit.tile,
         awful.layout.suit.tile.left,
         awful.layout.suit.tile.bottom,
         awful.layout.suit.tile.top,
         awful.layout.suit.fair,
         awful.layout.suit.fair.horizontal,
         awful.layout.suit.spiral,
         awful.layout.suit.spiral.dwindle,
         awful.layout.suit.max,
         awful.layout.suit.max.fullscreen,
         awful.layout.suit.magnifier,
         awful.layout.suit.corner.nw,
         -- awful.layout.suit.corner.ne,
         -- awful.layout.suit.corner.sw,
         -- awful.layout.suit.corner.se,
     }
    

Methods

**tag:instances ()**
     Get the number of instances. Returns:

The number of tag objects alive. 

**tag:clients (clients_table)**
     Get or set the clients attached to this tag. 

  * clients_table None or a table of clients to set as being tagged with this tag. 

Returns:

A table with the clients attached to this tags. 

**tag:disconnect_signal (name, func)**
     Disconnect from a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback that should be disconnected. 


**tag:emit_signal (name, ...)**
     Emit a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * ... Extra arguments for the callback functions. Each connected function receives the object as first argument and then any extra arguments that are given to emit_signal(). 


**tag:connect_signal (name, func)**
     Connect to a signal. 

  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the signal. 
  * func function The callback to call when the signal is emitted. 


**tag:swap (tag2)**
     Swap 2 tags 

  * tag2 The second tag 

See also:

[client.swap](<../classes/client.html#client:swap>) 

**tag:delete ([fallback_tag=awful.tag.find_fallback()[, force=false]])**
     Delete a tag. To delete the current tag:
    
    
    mouse.screen.selected_tag:delete()
    

  * fallback_tag [tag](<../classes/tag.html#>) Tag to assign stickied tags to. (_default_ awful.tag.find_fallback()) 
  * force boolean Move even non-sticky clients to the fallback tag. (_default_ false) 

Returns:

Returns true if the tag is successfully deleted. If there are no clients exclusively on this tag then delete it. Any stickied clients are assigned to the optional ‘fallback_tag’. If after deleting the tag there is no selected tag, try and restore from history or select the first tag on the screen. 
See also:

  * [awful.tag.add](<../classes/tag.html#awful.tag.add>)
  * [awful.tag.find_fallback](<../classes/tag.html#awful.tag.find_fallback>)


**tag:find_by_name (s, name)**
     Find a tag by name. 

  * s [screen](<../classes/screen.html#>) The screen of the tag 
  * name [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The name of the tag 

Returns:

The tag found, or `nil` 
Usage:
    
    -- For the current screen
    local t = awful.tag.find_by_name(awful.screen.focused(), "name")
    
    -- For a screen index
    local t = awful.tag.find_by_name(screen[1], "name")
    
    -- For all screens
    local t = awful.tag.find_by_name(nil, "name")


**tag:view_only ()**
     View only a tag. See also:

[selected](<../classes/tag.html#tag.selected>)