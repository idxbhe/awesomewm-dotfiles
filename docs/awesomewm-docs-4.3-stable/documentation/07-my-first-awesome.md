# Topic 07-my-first-awesome.md - awesome API documentation

> Source: [documentation/07-my-first-awesome.md.html](https://awesomewm.org/doc/api/documentation/07-my-first-awesome.md.html)

---

# My first Awesome

This little tutorial is for people who never used a tiling window manager before and don’t have fancy hacking skills. We will explore the awesome world of Awesome step by step and finally come up with a working desktop, providing some basic knowledge on how to configure Awesome in the process. We will start with the default [rc.lua](<../sample files/rc.lua.html#>) that comes with Awesome, play around a little and try to make it more beautiful and useful with widgets. For this tutorial you don’t need any programming skills besides using a text editor.

## Explore Awesome

I will assume that you properly installed Awesome through your distribution’s package manager or compiled it from source. You should now add `exec awesome` to your `~/.xinitrc`. As already mentioned, Awesome provides a default config file which will be our starting point. You will usually find this [rc.lua](<../sample files/rc.lua.html#>) file in `/etc/xdg/awesome/`. Copy it to `~/.config/awesome/`, and then start X (for example by running `startx`).

Move your mouse to the upper left corner and click on the Awesome logo. A little menu opens. Browse through the menu, then click the logo again to close it. Next to the Awesome menu you see numbers 1-9. These are your tags (or desktops if you want). You can click on these to change them but nothing will happen because we have not opened any programs. On the top right you see the time/date and a symbol showing the current layout. You can also click on the symbol to change the active layout.

One of the big advantages of Awesome over other tiling window managers is its good mouse support. Awesome can act as a full floating window manager (almost like openbox) if you want. For this basic tutorial we will mainly focus on keyboard control, so let’s learn some key bindings now.

Let’s open a terminal: press _Mod4+Enter_. Mod4 is your “Windows key”, the key between Ctrl and Alt. You can change the modkey if you want, but we’ll get to that later. An `xterm` window will pop up. You can of course use your favourite terminal if you like. Again, more on that later. Now press _Mod4+Shift+c_ to close the terminal. This is the command which lets you close any application. Awesome has an elegant way to launch programs: press _Mod4+r_. Now you will see a **Run:** prompt in the status bar. Start anything you like, it also features Tab-completion!

Open more applications to see the tiling features. You can now press _Mod4+Space_ to cycle through all the possible tiling (and floating) layouts. Note that the icon in the upper right changes.

Also try _Mod4+h_ , _Mod4+l_ , _Mod4+Shift+h_ and _Mod4+Shift+l_ to resize windows. You can also resize with _Mod4+Button3_ (right click). _Mod4+f_ will make your current window fullscreen.

With _Mod4+Number_ (1-9) you can browse through your tags. With _Mod4+Shift+Number_ (1-9) you can send a window to a specific tag. _Mod4+Left_ and _Mod4+Right_ moves to the next tag in the specified direction.

Use _Mod4+k_ and _Mod4+j_ to change your focused client - moving your mouse will also do that.

_Mod4+Shift+q_ quits Awesome, but don’t do that now.

For an overview of all key bindings, press _Mod4+s_. Pressing any key closes this overview again.

If you are a Vim user, try this: Press _Mod4+r_ for the run prompt, enter `gvim` and press _Enter_ to start it. Now press _Mod4+s_ again. The key binding overview now also provides a cheat sheet for controlling Vim.

## Change the theme

Awesome has four themes you can choose from: _default_ , _sky_ , _xresources_ , and _zenburn_.

To change the theme, open your rc.lua and edit this line near the beginning of the file:
    
    
    beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
    

For this tutorial we will stick with the default theme.

Now we will customize the theme. Copy `/usr/share/awesome/themes/default/theme.lua` to `~/.config/awesome/` and change the above line in your theme like this (remember to replace `USER` with your user name):
    
    
    beautiful.init("/home/USER/.config/awesome/theme.lua")
    

### Change the background image

Your desktop background image is handled in your theme file. To change it, edit this line in your theme file:
    
    
    beautiful.get().wallpaper = "/usr/share/awesome/themes/default/background.png"
    

## Personalize your layouts

To optimize our workflow, we now want to give names to our tags and set the specific tiling or floating mode for each of them. Open your [rc.lua](<../sample files/rc.lua.html#>) and find the layouts section. It should look like this:
    
    
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
    

These are all possible tiling and floating layouts Awesome has. If you don’t find all of them useful, you can comment some of them out by adding “–” to the beginning of the line. Awesome already comes with three layouts which are not used in the default config, as you can see above.

## Personalize your tags

Next, we want to name our tags. This is the default tag creation with numbers from 1 to 9:
    
    
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    

Now we want to change the tag names and assign a specific layout to each of them. By default, each tag has a floating layout (the first entry in the `layouts` table). To change this, we define a specific layout for each tag.

Replace the above with this code:
    
    
    -- Each screen has its own tag table.
    local names = { "main", "www", "skype", "gimp", "office", "im", "7", "8", "9" }
    local l = awful.layout.suit  -- Just to save some typing: use an alias.
    local layouts = { l.floating, l.tile, l.floating, l.fair, l.max,
        l.floating, l.tile.left, l.floating, l.floating }
    awful.tag(names, s, layouts)
    

We use `layouts` to set the layout for each tag. Edit this as you like.

## Some global settings

While we are at it, we can also change the default terminal, editor and assign the modkey to a different key:
    
    
    terminal = "xterm"
    editor = os.getenv("EDITOR") or "nano"
    […]
    modkey = "Mod4"
    

Change these settings to your liking. They are pretty self-explanatory and well-documented in the comments.

## Wrapping up

Save your [rc.lua](<../sample files/rc.lua.html#>) and restart awesome (_Mod4+Ctrl+r_). Now the modifications done above should be applied.

Note that any mistakes in your [rc.lua](<../sample files/rc.lua.html#>) can cause problems. You can save yourself some trouble by using `Xephyr` to test your changes.

Open a terminal and run the following command:
    
    
    Xephyr :5 & sleep 1 ; DISPLAY=:5 awesome
    

A new window will appear and a new awesome instance runs inside of it.

## Add widgets

Before the following line:
    
    
    mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
    

Add this to create a new widget:
    
    
    praisewidget = wibox.widget.textbox()
    praisewidget.text = "You are great!"
    

The widget still needs to be added to a wibar. For this, find the definition of your wibar and change it as follows:
    
    
    { -- Left widgets
        layout = wibox.layout.fixed.horizontal,
        mylauncher,
        praisewidget, -- This line is new
        s.mytaglist,
        s.mypromptbox,
    },
    

This gives you a basic idea on how to add a widget. For an overview of available widgets and how to arrange them, please read [03-declarative-layout.md](<../documentation/03-declarative-layout.md.html#>).

## Further reading

To learn more about the individual parts of the default configuration file, please look at [05-awesomerc.md](<../documentation/05-awesomerc.md.html#>).