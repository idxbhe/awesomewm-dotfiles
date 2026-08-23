# Class awful.widget.taglist - awesome API documentation

**Module:** `classes.awful.widget.taglist`  

> Source: [classes/awful.widget.taglist.html](https://awesomewm.org/doc/api/classes/awful.widget.taglist.html)

---

# Class `awful.widget.taglist`

Taglist widget module for awful

Here is a more advanced example of how to extent the [taglist](<../classes/awful.widget.taglist.html>).

It provides:

  * mouse “hover” color
  * an extra index field
  * a powerline look and feel


![Usage example](../images/AUTOGEN_wibox_awidget_taglist_indexed.svg)
    
    
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        style   = {
            shape = gears.shape.powerline
        },
        layout   = {
            spacing = -12,
            spacing_widget = {
                color  = '#dddddd',
                shape  = gears.shape.powerline,
                widget = wibox.widget.separator,
            },
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id     = 'index_role',
                                widget = wibox.widget.textbox,
                            },
                            margins = 4,
                            widget  = wibox.container.margin,
                        },
                        bg     = '#dddddd',
                        shape  = gears.shape.circle,
                        widget = wibox.container.background,
                    },
                    {
                        {
                            id     = 'icon_role',
                            widget = wibox.widget.imagebox,
                        },
                        margins = 2,
                        widget  = wibox.container.margin,
                    },
                    {
                        id     = 'text_role',
                        widget = wibox.widget.textbox,
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                left  = 18,
                right = 18,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
            -- Add support for hover colors and an index label
            create_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
                self:connect_signal('mouse::enter', function()
                    if self.bg ~= '#ff0000' then
                        self.backup     = self.bg
                        self.has_backup = true
                    end
                    self.bg = '#ff0000'
                end)
                self:connect_signal('mouse::leave', function()
                    if self.has_backup then self.bg = self.backup end
                end)
            end,
            update_callback = function(self, c3, index, objects) --luacheck: no unused args
                self:get_children_by_id('index_role')[1].markup = '<b> '..index..' </b>'
            end,
        },
        buttons = taglist_buttons
    }
    

As demonstrated in the example above, there are a few “shortcuts” to avoid re-inventing the wheel. By setting the predefined roles as widget `id`s, [awful.widget.common](<../classes/awful.widget.common.html#>) will do most of the work to update the values automatically. All of them are optional. The supported roles are:

  * `icon_role`: A [wibox.widget.imagebox](<../classes/wibox.widget.imagebox.html#>)
  * `text_role`: A [wibox.widget.textbox](<../classes/wibox.widget.textbox.html#>)
  * `background_role`: A [wibox.container.background](<../classes/wibox.container.background.html#>)
  * `text_margin_role`: A [wibox.container.margin](<../classes/wibox.container.margin.html#>)
  * `icon_margin_role`: A [wibox.container.margin](<../classes/wibox.container.margin.html#>)


[awful.widget.common](<../classes/awful.widget.common.html#>) also has 2 callbacks to give more control over the widget:

  * `create_callback`: Called once after the widget instance is created
  * `update_callback`: Called everytime the data is refreshed


Both callback have the same parameters:

  * `self`: The widget instance (_widget_).
  * `t`: The tag (_tag_)
  * `index`: The widget position in the list (_number_)
  * `tags`: The list of tag, in order (_table_)


### Info:

  * **Copyright** : 2008-2009 Julien Danjou
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[awful.taglist (args, filter, buttons, style[, update_function[, base_widget]])](<#awful.taglist>) | Create a new taglist widget.  
---|---  
  
## [Theme variables](<#Theme_variables>)

[beautiful.taglist_fg_focus](<#beautiful.taglist_fg_focus>) | The tag list main foreground (text) color.  
---|---  
[beautiful.taglist_bg_focus](<#beautiful.taglist_bg_focus>) | The tag list main background color.  
[beautiful.taglist_fg_urgent](<#beautiful.taglist_fg_urgent>) | The tag list urgent elements foreground (text) color.  
[beautiful.taglist_bg_urgent](<#beautiful.taglist_bg_urgent>) | The tag list urgent elements background color.  
[beautiful.taglist_bg_occupied](<#beautiful.taglist_bg_occupied>) | The tag list occupied elements background color.  
[beautiful.taglist_fg_occupied](<#beautiful.taglist_fg_occupied>) | The tag list occupied elements foreground (text) color.  
[beautiful.taglist_bg_empty](<#beautiful.taglist_bg_empty>) | The tag list empty elements background color.  
[beautiful.taglist_fg_empty](<#beautiful.taglist_fg_empty>) | The tag list empty elements foreground (text) color.  
[beautiful.taglist_bg_volatile](<#beautiful.taglist_bg_volatile>) | The tag list volatile elements background color.  
[beautiful.taglist_fg_volatile](<#beautiful.taglist_fg_volatile>) | The tag list volatile elements foreground (text) color.  
[beautiful.taglist_squares_sel](<#beautiful.taglist_squares_sel>) | The selected elements background image.  
[beautiful.taglist_squares_unsel](<#beautiful.taglist_squares_unsel>) | The unselected elements background image.  
[beautiful.taglist_squares_sel_empty](<#beautiful.taglist_squares_sel_empty>) | The selected empty elements background image.  
[beautiful.taglist_squares_unsel_empty](<#beautiful.taglist_squares_unsel_empty>) | The unselected empty elements background image.  
[beautiful.taglist_squares_resize](<#beautiful.taglist_squares_resize>) | If the background images can be resized.  
[beautiful.taglist_disable_icon](<#beautiful.taglist_disable_icon>) | Do not display the tag icons, even if they are set.  
[beautiful.taglist_font](<#beautiful.taglist_font>) | The taglist font.  
[beautiful.taglist_spacing](<#beautiful.taglist_spacing>) | The space between the taglist elements.  
[beautiful.taglist_shape](<#beautiful.taglist_shape>) | The main shape used for the elements.  
[beautiful.taglist_shape_border_width](<#beautiful.taglist_shape_border_width>) | The shape elements border width.  
[beautiful.taglist_shape_border_color](<#beautiful.taglist_shape_border_color>) | The elements shape border color.  
[beautiful.taglist_shape_empty](<#beautiful.taglist_shape_empty>) | The shape used for the empty elements.  
[beautiful.taglist_shape_border_width_empty](<#beautiful.taglist_shape_border_width_empty>) | The shape used for the empty elements border width.  
[beautiful.taglist_shape_border_color_empty](<#beautiful.taglist_shape_border_color_empty>) | The empty elements shape border color.  
[beautiful.taglist_shape_focus](<#beautiful.taglist_shape_focus>) | The shape used for the selected elements.  
[beautiful.taglist_shape_border_width_focus](<#beautiful.taglist_shape_border_width_focus>) | The shape used for the selected elements border width.  
[beautiful.taglist_shape_border_color_focus](<#beautiful.taglist_shape_border_color_focus>) | The selected elements shape border color.  
[beautiful.taglist_shape_urgent](<#beautiful.taglist_shape_urgent>) | The shape used for the urgent elements.  
[beautiful.taglist_shape_border_width_urgent](<#beautiful.taglist_shape_border_width_urgent>) | The shape used for the urgent elements border width.  
[beautiful.taglist_shape_border_color_urgent](<#beautiful.taglist_shape_border_color_urgent>) | The urgents elements shape border color.  
[beautiful.taglist_shape_volatile](<#beautiful.taglist_shape_volatile>) | The shape used for the volatile elements.  
[beautiful.taglist_shape_border_width_volatile](<#beautiful.taglist_shape_border_width_volatile>) | The shape used for the volatile elements border width.  
[beautiful.taglist_shape_border_color_volatile](<#beautiful.taglist_shape_border_color_volatile>) | The volatile elements shape border color.  
  
## [List source functions](<#List_source_functions>)

[awful.taglist.source.for_screen](<#awful.taglist.source.for_screen>) | All tags for the defined screen ordered by indices.  
---|---  
  
## [List filters](<#List_filters>)

[awful.taglist.filter.noempty](<#awful.taglist.filter.noempty>) | Filtering function to include all nonempty tags on the screen.  
---|---  
[awful.taglist.filter.selected](<#awful.taglist.filter.selected>) | Filtering function to include selected tags on the screen.  
[awful.taglist.filter.all](<#awful.taglist.filter.all>) | Filtering function to include all tags on the screen.  
  
  


## Functions

Methods 

**awful.taglist (args, filter, buttons, style[, update_function[, base_widget]])**
     Create a new taglist widget. The last two arguments (update_function and layout) serve to customize the layout of the taglist (eg. to make it vertical). For that, you will need to copy the awful.widget.common.list_update function, make your changes to it and pass it as update_function here. Also change the layout if the default is not what you want. 

  * args
    * screen [screen](<../classes/screen.html#>) The screen to draw taglist for. 
    * filter function[opt=nil] Filter function to define what clients will be listed. 
    * buttons [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A table with buttons binding to set. 
    * update_function function Function to create a tag widget on each update. See [awful.widget.common](<../classes/awful.widget.common.html#>). (_optional_) 
    * layout widget Optional layout widget for tag widgets. Default is wibox.layout.fixed.horizontal(). (_optional_) 
    * source function The function used to generate the list of tag. (_default_ awful.taglist.source.for_screen) 
    * widget_template [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) A custom widget to be used for each tag (_optional_) 
    * style [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The style overrides default theme. (_default_ {}) 
    * style.fg_focus [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The foreground color for focused client. 
    * style.bg_focus [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The background color for focused client. 
    * style.fg_urgent [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The foreground color for urgent clients. 
    * style.bg_urgent [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The background color for urgent clients. 
    * style.bg_occupied [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 
    * style.fg_occupied [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 
    * style.bg_empty [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 
    * style.fg_empty [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 
    * style.bg_volatile [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 
    * style.fg_volatile [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern (_default_ nil) 
    * style.squares_sel [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for selected squares. (_optional_) 
    * style.squares_unsel [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for unselected squares. (_optional_) 
    * style.squares_sel_empty [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for selected squares for empty tags. (_optional_) 
    * style.squares_unsel_empty [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for unselected squares for empty tags. (_optional_) 
    * style.squares_resize boolean True or false to resize squares. (_optional_) 
    * style.disable_icon [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) (_default_ nil) 
    * style.font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The font. 
    * style.spacing number The spacing between tags. (_default_ nil) 
    * style.squares_sel [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for selected squares. (_optional_) 
    * style.squares_unsel [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for unselected squares. (_optional_) 
    * style.squares_sel_empty [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for selected squares for empty tags. (_optional_) 
    * style.squares_unsel_empty [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A user provided image for unselected squares for empty tags. (_optional_) 
    * style.squares_resize boolean True or false to resize squares. (_optional_) 
    * style.bg_focus [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The background color for focused client. 
    * style.fg_focus [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The foreground color for focused client. 
    * style.bg_urgent [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The background color for urgent clients. 
    * style.fg_urgent [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or pattern The foreground color for urgent clients. 
    * style.font [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The font. 
  * filter **DEPRECATED** use args.filter 
  * buttons **DEPRECATED** use args.buttons 
  * style **DEPRECATED** use args.style 
  * update_function **DEPRECATED** use args.update_function 
  * base_widget **DEPRECATED** use args.base_widget 


## Theme variables

**beautiful.taglist_fg_focus**
     The tag list main foreground (text) color. 

### Type:

  * color (_default_ fg_focus) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_bg_focus**
     The tag list main background color. 

### Type:

  * color (_default_ bg_focus) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_fg_urgent**
     The tag list urgent elements foreground (text) color. 

### Type:

  * color (_default_ fg_urgent) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_bg_urgent**
     The tag list urgent elements background color. 

### Type:

  * color (_default_ bg_urgent) 


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_bg_occupied**
     The tag list occupied elements background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_fg_occupied**
     The tag list occupied elements foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_bg_empty**
     The tag list empty elements background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_fg_empty**
     The tag list empty elements foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_bg_volatile**
     The tag list volatile elements background color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_fg_volatile**
     The tag list volatile elements foreground (text) color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_squares_sel**
     The selected elements background image. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.taglist_squares_unsel**
     The unselected elements background image. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.taglist_squares_sel_empty**
     The selected empty elements background image. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.taglist_squares_unsel_empty**
     The unselected empty elements background image. 

### Type:

  * surface


### See also:

[gears.surface](<../libraries/gears.surface.html#>) 

**beautiful.taglist_squares_resize**
     If the background images can be resized. 

### Type:

  * boolean


**beautiful.taglist_disable_icon**
     Do not display the tag icons, even if they are set. 

### Type:

  * boolean


**beautiful.taglist_font**
     The taglist font. 

### Type:

  * string


**beautiful.taglist_spacing**
     The space between the taglist elements. 

### Type:

  * spacing number The spacing between tags. (_default_ 0) 


**beautiful.taglist_shape**
     The main shape used for the elements. This will be the fallback for state specific shapes. To get a shape for the whole taglist, use [wibox.container.background](<../classes/wibox.container.background.html#>). 

### See also:

  * [gears.shape](<../libraries/gears.shape.html#>)
  * [beautiful.taglist_shape_empty](<../classes/awful.widget.taglist.html#beautiful.taglist_shape_empty>)
  * [beautiful.taglist_shape_focus](<../classes/awful.widget.taglist.html#beautiful.taglist_shape_focus>)
  * [beautiful.taglist_shape_urgent](<../classes/awful.widget.taglist.html#beautiful.taglist_shape_urgent>)
  * [beautiful.taglist_shape_volatile](<../classes/awful.widget.taglist.html#beautiful.taglist_shape_volatile>)


**beautiful.taglist_shape_border_width**
     The shape elements border width. 

### Type:

  * number (_default_ 0) 


### See also:

[wibox.container.background](<../classes/wibox.container.background.html#>) 

**beautiful.taglist_shape_border_color**
     The elements shape border color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_shape_empty**
     The shape used for the empty elements. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.taglist_shape_border_width_empty**
     The shape used for the empty elements border width. 

### Type:

  * number (_default_ 0) 


### See also:

[wibox.container.background](<../classes/wibox.container.background.html#>) 

**beautiful.taglist_shape_border_color_empty**
     The empty elements shape border color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_shape_focus**
     The shape used for the selected elements. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.taglist_shape_border_width_focus**
     The shape used for the selected elements border width. 

### Type:

  * number (_default_ 0) 


### See also:

[wibox.container.background](<../classes/wibox.container.background.html#>) 

**beautiful.taglist_shape_border_color_focus**
     The selected elements shape border color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_shape_urgent**
     The shape used for the urgent elements. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.taglist_shape_border_width_urgent**
     The shape used for the urgent elements border width. 

### Type:

  * number (_default_ 0) 


### See also:

[wibox.container.background](<../classes/wibox.container.background.html#>) 

**beautiful.taglist_shape_border_color_urgent**
     The urgents elements shape border color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 

**beautiful.taglist_shape_volatile**
     The shape used for the volatile elements. 

### See also:

[gears.shape](<../libraries/gears.shape.html#>) 

**beautiful.taglist_shape_border_width_volatile**
     The shape used for the volatile elements border width. 

### Type:

  * number (_default_ 0) 


### See also:

[wibox.container.background](<../classes/wibox.container.background.html#>) 

**beautiful.taglist_shape_border_color_volatile**
     The volatile elements shape border color. 

### Type:

  * color


### See also:

[gears.color](<../libraries/gears.color.html#>) 


## List source functions

**awful.taglist.source.for_screen**
     All tags for the defined screen ordered by indices.

This is the default source. 

### See also:

[screen](<../classes/screen.html#>) 


## List filters

**awful.taglist.filter.noempty**
     Filtering function to include all nonempty tags on the screen. 

  * t The tag. 


**awful.taglist.filter.selected**
     Filtering function to include selected tags on the screen. 

  * t The tag. 


**awful.taglist.filter.all**
     Filtering function to include all tags on the screen.