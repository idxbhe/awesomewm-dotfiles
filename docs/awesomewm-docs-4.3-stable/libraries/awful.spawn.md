# Module awful.spawn - awesome API documentation

**Module:** `libraries.awful.spawn`  

> Source: [libraries/awful.spawn.html](https://awesomewm.org/doc/api/libraries/awful.spawn.html)

---

# Module `awful.spawn`

Spawning of programs.

This module provides methods to start programs and supports startup notifications, which allows for callbacks and applying properties to the program after it has been launched. This requires currently that the applicaton supports them.

##  Frequently asked questions

**Rules of thumb when a shell is needed** :

  * A shell is required when the commands contain `&&`, `;`, `||`, `&` or any other unix shell language syntax
  * When shell variables are defined as part of the command
  * When the command is a shell alias


Note that a shell is **not** a terminal emulator. A terminal emulator is something like XTerm, Gnome-terminal or Konsole. A shell is something like `bash`, `zsh`, `busybox sh` or `Debian ash`.

If you wish to open a process in a terminal window, check that your terminal emulator supports the common [-e](<../libraries/awful.spawn.html#single_instance>) option. If it does, then something like this should work:
    
    
    awful.spawn(terminal.." -e my_command")
    

Note that some terminals, such as rxvt-unicode (urxvt) support full commands using quotes, while other terminal emulators require to use quoting.

**Understanding clients versus PID versus commands versus class** :

A _process_ has a _PID_ (process identifier). It can have 0, 1 or many _window_ s.

A _command_ is what is used to start _process_(es). It has no direct relation with _process_ , _client_ or _window_. When a command is executed, it will usually start a _process_ which keeps running until it exits. This however is not always the case as some applications use scripts as command and others use various single-instance mechanisms (usually client/server) and merge with an existing process.

A _client_ corresponds to a _window_. It is owned by a process. It can have both a parent and one or many children. A _client_ has a _class_ , an _instance_ , a _role_ , and a _type_. See [client.class](<../classes/client.html#client.class>), [client.instance](<../classes/client.html#client.instance>), [client.role](<../classes/client.html#client.role>) and [client.type](<../classes/client.html#client.type>) for more information about these properties.

**Understanding blocking versus asynchronous execution** :

Awesome is single threaded, it means only one thing is executed at any time. But Awesome isn’t doomed to be slow. It may not have multiple threads, but it has something called coroutine and also has callbacks. This means things that take time to execute can still do so in the background (using C threads or external process + sockets). When they are done, they can notify the Awesome thread. This works perfectly and avoid blocking Awesome.

If you want to update the text of a [wibox.widget.textbox](<../classes/wibox.widget.textbox.html#>) with the output of a shell command, you should use the [awful.spawn.easy_async_with_shell](<../libraries/awful.spawn.html#easy_async_with_shell>) command. It is strongly recommanded not to use [io.popen](<https://www.lua.org/manual/5.1/manual.html#pdf-io.popen>) is explained in the “Getting a command’s output” section. Asynchronous execution is at first a bit tricky to understand if you never used that before. The example below should demonstrate how it works.

If we do (but _really_ , don’t do that):
    
    
    -- **NEVER, EVER, DO THIS**: your computer will freeze
    os.execute("sleep 1; echo foo > /tmp/foo.txt")
    mylabel.text = io.popen("cat /tmp/foo.txt"):read("*all")
    

The label will display `foo`. But If we do:
    
    
    -- Don't do this, it wont work.
    -- Assumes /tmp/foo.txt does not exist
    awful.spawn.with_shell("sleep 1; echo foo > /tmp/foo.txt")
    mylabel.text = io.popen("cat /tmp/foo.txt"):read("*all")
    

Then the label will be **empty**. [awful.spawn](<../libraries/awful.spawn.html#>) and [awful.spawn.with_shell](<../libraries/awful.spawn.html#with_shell>) will **not** block and thus the [io.popen](<https://www.lua.org/manual/5.1/manual.html#pdf-io.popen>) will be executed before `sleep 1` finishes. This is why we have async functions to execute shell commands. There are many variants with difference characteristics and complexity. [awful.spawn.easy_async](<../libraries/awful.spawn.html#easy_async>) is the most common as it is good enough for the general “I want to execute a command and do something with the output when it finishes”.
    
    
    -- This is the correct way
    local command = "sleep 1; echo foo > /tmp/foo.txt"
    
    awful.spawn.easy_async_with_shell(command, function()
        awful.spawn.easy_async_with_shell("cat /tmp/foo.txt", function(out)
            mylabel.text = out
        end)
    end)
    

In this variant, Awesome will not block. Again, like other spawn, you cannot add code outside of the callback function to use the result of the command. The code will be executed before the command is finished so the result wont yet be available.

**Getting a command ’s output**:

First, do **not** use [io.popen](<https://www.lua.org/manual/5.1/manual.html#pdf-io.popen>) **ever**. It is synchronous. Synchronous functions **block everything** until they are done. All visual applications lock (as Awesome no longer responds), you will probably lose some keyboard and mouse events and will have higher latency when playing games. This is also true when reading files synchronously, but this is another topic.

Awesome provides a few ways to get output from commands. One is to use the `Gio` libraries directly. This is usually very complicated, but gives a lot of control on the command execution.

This modules provides [with_line_callback](<../libraries/awful.spawn.html#with_line_callback>) and [easy_async](<../libraries/awful.spawn.html#easy_async>) for convenience. First, lets add this bash command to [rc.lua](<../sample files/rc.lua.html#>):
    
    
    local noisy = [[bash -c '
      for I in $(seq 1 5); do
        date
        echo err >&2
        sleep 2
      done
    ']]
    

It prints a bunch of junk on the standard output (_stdout_) and error (_stderr_) streams. This command would block Awesome for 10 seconds if it were executed synchronously, but will not block it at all using the asynchronous functions.

[with_line_callback](<../libraries/awful.spawn.html#with_line_callback>) will execute the callbacks every time a new line is printed by the command:
    
    
    awful.spawn.with_line_callback(noisy, {
        stdout = function(line)
            naughty.notify { text = "LINE:"..line }
        end,
        stderr = function(line)
            naughty.notify { text = "ERR:"..line}
        end,
    })
    

If only the full output is needed, then [easy_async](<../libraries/awful.spawn.html#easy_async>) is the right choice:
    
    
    awful.spawn.easy_async(noisy, function(stdout, stderr, reason, exit_code)
        naughty.notify { text = stdout }
    end)
    

**Default applications** :

If the intent is to open a file/document, then it is recommended to use the following standard command. The default application will be selected according to the [Shared MIME-info Database](<https://specifications.freedesktop.org/shared-mime-info-spec/shared-mime-info-spec-latest.html>) specification. The `xdg-utils` package provided by most distributions includes the `xdg-open` command:
    
    
    awful.spawn({"xdg-open", "/path/to/file"})
    

Awesome **does not** manage, modify or otherwise influence the database for default applications. For information about how to do this, consult the [ARCH Linux Wiki](<https://wiki.archlinux.org/index.php/default_applications>).

If you wish to change how the default applications behave, then consult the [Desktop Entry](<https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html>) specification.

##  Spawning applications with specific properties

**The startup notification protocol** :

The startup notification protocol is an optional specification implemented by X11 applications to bridge the chain of knowledge between the moment a program is launched to the moment its window (client) is shown. It can be found [on the FreeDesktop.org website](<https://www.freedesktop.org/wiki/Specifications/startup-notification-spec/>).

Awesome has support for the various events that are part of the protocol, but the most useful is the identifier, usually identified by its `SNID` acronym in the documentation. It isn’t usually necessary to even know it exists, as it is all done automatically. However, if more control is required, the identifier can be specified by an environment variable called `DESKTOP_STARTUP_ID`. For example, let us consider execution of the following command:
    
    
    DESKTOP_STARTUP_ID="something_TIME$(date '+%s')" my_command
    

This should (if the program correctly implements the protocol) result in `c.startup_id` to at least match `something`. This identifier can then be used in [awful.rules](<../libraries/awful.rules.html#>) to configure the client.

Awesome can automatically set the `DESKTOP_STARTUP_ID` variable. This is used by [awful.spawn](<../libraries/awful.spawn.html#>) to specify additional rules for the startup. For example:
    
    
    awful.spawn("urxvt -e maxima -name CALCULATOR", {
        floating  = true,
        tag       = mouse.screen.selected_tag,
        placement = awful.placement.bottom_right,
    })
    

This can also be used from the command line:
    
    
    awesome-client 'awful=require("awful");
      awful.spawn("urxvt -e maxima -name CALCULATOR", {
        floating  = true,
        tag       = mouse.screen.selected_tag,
        placement = awful.placement.bottom_right,
      })'
    

This table contains the client properties that are valid when used the `sn_rules` or `prop` function argument. They are the same as in [awful.rules](<../libraries/awful.rules.html#>).

Name | Description  
---|---  
[placement](<../classes/client.html#client.placement>)| The client default placement on the screen  
[honor\\_padding](<../classes/client.html#client.honor_padding>)| When applying the placement, honor the screen padding  
[honor\\_workarea](<../classes/client.html#client.honor_workarea>)| When applying the placement, honor the screen work area  
[tag](<../classes/client.html#client.tag>)| The client default tag  
[tags](<../classes/client.html#client.tags>)| The client default tags  
[new\\_tag](<../classes/client.html#client.new_tag>)| Create a new tag for this client  
[switch\\_to\\_tags](<../classes/client.html#client.switch_to_tags>)| Unselect the current tags and select this client tags  
[focus](<../classes/client.html#client.focus>)| Define if the client should grab focus by default  
[titlebars\\_enabled](<../classes/client.html#client.titlebars_enabled>)| Should this client have a titlebar by default  
[callback](<../classes/client.html#client.callback>)| A function to call when this client is ready  
[marked](<../classes/client.html#client.marked>)| If a client is marked or not  
[is\\_fixed](<../classes/client.html#client.is_fixed>)| Return if a client has a fixed size or not  
[immobilized](<../classes/client.html#client.immobilized>)| Is the client immobilized horizontally?  
[immobilized](<../classes/client.html#client.immobilized>)| Is the client immobilized vertically?  
[floating](<../classes/client.html#client.floating>)| The client floating state  
[x](<../classes/client.html#client.x>)| The x coordinates  
[y](<../classes/client.html#client.y>)| The y coordinates  
[width](<../classes/client.html#client.width>)| The width of the client  
[height](<../classes/client.html#client.height>)| The height of the client  
[dockable](<../classes/client.html#client.dockable>)| If the client is dockable  
[requests\\_no\\_titlebar](<../classes/client.html#client.requests_no_titlebar>)| If the client requests not to be decorated with a titlebar  
[shape](<../classes/client.html#client.shape>)| Set the client shape  
[window](<../classes/client.html#client.window>)| The X window id  
[name](<../classes/client.html#client.name>)| The client title  
[skip\\_taskbar](<../classes/client.html#client.skip_taskbar>)| True if the client does not want to be in taskbar  
[type](<../classes/client.html#client.type>)| The window type  
[class](<../classes/client.html#client.class>)| The client class  
[instance](<../classes/client.html#client.instance>)| The client instance  
[pid](<../classes/client.html#client.pid>)| The client PID, if available  
[role](<../classes/client.html#client.role>)| The window role, if available  
[machine](<../classes/client.html#client.machine>)| The machine client is running on  
[icon\\_name](<../classes/client.html#client.icon_name>)| The client name when iconified  
[icon](<../classes/client.html#client.icon>)| The client icon as a surface  
[icon\\_sizes](<../classes/client.html#client.icon_sizes>)| The available sizes of client icons  
[screen](<../classes/client.html#client.screen>)| Client screen  
[hidden](<../classes/client.html#client.hidden>)| Define if the client must be hidden, i  
[minimized](<../classes/client.html#client.minimized>)| Define it the client must be iconify, i  
[size\\_hints\\_honor](<../classes/client.html#client.size_hints_honor>)| Honor size hints, e  
[border\\_width](<../classes/client.html#client.border_width>)| The client border width  
[border\\_color](<../classes/client.html#client.border_color>)| The client border color  
[urgent](<../classes/client.html#client.urgent>)| The client urgent state  
[content](<../classes/client.html#client.content>)| A cairo surface for the client window content  
[opacity](<../classes/client.html#client.opacity>)| The client opacity  
[ontop](<../classes/client.html#client.ontop>)| The client is on top of every other windows  
[above](<../classes/client.html#client.above>)| The client is above normal windows  
[below](<../classes/client.html#client.below>)| The client is below normal windows  
[fullscreen](<../classes/client.html#client.fullscreen>)| The client is fullscreen or not  
[maximized](<../classes/client.html#client.maximized>)| The client is maximized (horizontally and vertically) or not  
[maximized\\_horizontal](<../classes/client.html#client.maximized_horizontal>)| The client is maximized horizontally or not  
[maximized\\_vertical](<../classes/client.html#client.maximized_vertical>)| The client is maximized vertically or not  
[transient\\_for](<../classes/client.html#client.transient_for>)| The client the window is transient for  
[group\\_window](<../classes/client.html#client.group_window>)| Window identification unique to a group of windows  
[leader\\_window](<../classes/client.html#client.leader_window>)| Identification unique to windows spawned by the same command  
[size\\_hints](<../classes/client.html#client.size_hints>)| A table with size hints of the client  
[motif\\_wm\\_hints](<../classes/client.html#client.motif_wm_hints>)| The motif WM hints of the client  
[sticky](<../classes/client.html#client.sticky>)| Set the client sticky, i  
[modal](<../classes/client.html#client.modal>)| Indicate if the client is modal  
[focusable](<../classes/client.html#client.focusable>)| True if the client can receive the input focus  
[shape\\_bounding](<../classes/client.html#client.shape_bounding>)| The client's bounding shape as set by awesome as a (native) cairo surface  
[shape\\_clip](<../classes/client.html#client.shape_clip>)| The client's clip shape as set by awesome as a (native) cairo surface  
[shape\\_input](<../classes/client.html#client.shape_input>)| The client's input shape as set by awesome as a (native) cairo surface  
[client\\_shape\\_bounding](<../classes/client.html#client.client_shape_bounding>)| The client's bounding shape as set by the program as a (native) cairo surface  
[client\\_shape\\_clip](<../classes/client.html#client.client_shape_clip>)| The client's clip shape as set by the program as a (native) cairo surface  
[startup\\_id](<../classes/client.html#client.startup_id>)| The FreeDesktop StartId  
[valid](<../classes/client.html#client.valid>)| If the client that this object refers to is still managed by awesome  
[first\\_tag](<../classes/client.html#client.first_tag>)| The first tag of the client  
  
### Info:

  * **Copyright** : 2008 Julien Danjou,2014 Emmanuel Lepage Vallee
  * **Author** : Julien Danjou <[[email protected]](</cdn-cgi/l/email-protection>)>,Emmanuel Lepage Vallee <[[email protected]](</cdn-cgi/l/email-protection>)>


## [Functions](<#Functions>)

[spawn (cmd[, sn_rules=true[, callback]])](<#spawn>) | Spawn a program, and optionally apply properties and/or run a callback.  
---|---  
[with_shell (cmd)](<#with_shell>) | Spawn a program using the shell.  
[with_line_callback (cmd, callbacks)](<#with_line_callback>) | Spawn a program and asynchronously capture its output line by line.  
[easy_async (cmd, callback)](<#easy_async>) | Asynchronously spawn a program and capture its output.  
[easy_async_with_shell (cmd, callback)](<#easy_async_with_shell>) | Call [spawn.easy_async](<../libraries/awful.spawn.html#easy_async>) with a shell.  
[read_lines (input_stream, line_callback[, done_callback[, close=false]])](<#read_lines>) | Read lines from a Gio input stream  
[once (cmd, rules[, matcher[, unique_id[, callback]]])](<#once>) | Spawn a command if it has not been spawned before.  
[single_instance (cmd, rules[, matcher[, unique_id[, callback]]])](<#single_instance>) | Spawn a command if an instance is not already running.  
[raise_or_spawn (cmd, rules[, matcher[, unique_id[, callback]]])](<#raise_or_spawn>) | Raise a client if it exists or spawn a new one then raise it.  
  
  


## Functions

Methods 

**spawn (cmd[, sn_rules=true[, callback]])**
     Spawn a program, and optionally apply properties and/or run a callback.

Applying properties or running a callback requires the program/client to support startup notifications.

See [awful.rules.execute](<../libraries/awful.rules.html#execute>) for more details about the format of `sn_rules`. 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The command. 
  * sn_rules [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) or boolean A table of properties to be applied after startup; `false` to disable startup notifications. (_default_ true) 
  * callback function A callback function to be run after startup. (_optional_) 


### Returns:

  1. integer The forked PID.
  2. optional [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The startup notification ID, if `sn` is not false, or a `callback` is provided.


### Or

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Error message. 

**with_shell (cmd)**
     Spawn a program using the shell. This calls `cmd` with `$SHELL -c` (via [awful.util.shell](<../libraries/awful.util.html#shell>)). 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The command. 


**with_line_callback (cmd, callbacks)**
     Spawn a program and asynchronously capture its output line by line. 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The command. 
  * callbacks Table containing callbacks that should be invoked on various conditions. 
    * stdout function Function that is called with each line of output on stdout, e.g. `stdout(line)`. (_optional_) 
    * stderr function Function that is called with each line of output on stderr, e.g. `stderr(line)`. (_optional_) 
    * output_done function Function to call when no more output is produced. (_optional_) 
    * exit function Function to call when the spawned process exits. This function gets the exit reason and code as its arguments. The reason can be “exit” or “signal”. For “exit”, the second argument is the exit code. For “signal”, the second argument is the signal causing process termination. (_optional_) 


### Returns:

Integer the PID of the forked process. 


### Or

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Error message. 

**easy_async (cmd, callback)**
     Asynchronously spawn a program and capture its output. (wraps [spawn.with_line_callback](<../libraries/awful.spawn.html#with_line_callback>)). 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The command. 
  * callback Function with the following arguments 
    * stdout [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Output on stdout. 
    * stderr [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Output on stderr. 
    * exitreason [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Exit reason (“exit” or “signal”). 
    * exitcode integer Exit code (exit code or signal number, depending on “exitreason”). 


### Returns:

Integer the PID of the forked process. 


### Or

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Error message. 


### See also:

[spawn.with_line_callback](<../libraries/awful.spawn.html#with_line_callback>) 

**easy_async_with_shell (cmd, callback)**
     Call [spawn.easy_async](<../libraries/awful.spawn.html#easy_async>) with a shell. This calls `cmd` with `$SHELL -c` (via [awful.util.shell](<../libraries/awful.util.html#shell>)). 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) The command. 
  * callback Function with the following arguments 
    * stdout [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Output on stdout. 
    * stderr [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Output on stderr. 
    * exitreason [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Exit reason (“exit” or “signal”). 
    * exitcode integer Exit code (exit code or signal number, depending on “exitreason”). 


### Returns:

Integer the PID of the forked process. 


### Or

[string](<https://www.lua.org/manual/5.1/manual.html#5.4>) Error message. 


### See also:

[spawn.with_line_callback](<../libraries/awful.spawn.html#with_line_callback>) 

**read_lines (input_stream, line_callback[, done_callback[, close=false]])**
     Read lines from a Gio input stream 

  * input_stream Gio.InputStream The input stream to read from. 
  * line_callback function Function that is called with each line read, e.g. `line_callback(line_from_stream)`. 
  * done_callback function Function that is called when the operation finishes (e.g. due to end of file). (_optional_) 
  * close boolean Should the stream be closed after end-of-file? (_default_ false) 


**once (cmd, rules[, matcher[, unique_id[, callback]]])**
     Spawn a command if it has not been spawned before.

This function tries its best to preserve the state across `awesome.restart()`.

By default, when no `unique_id` is specified, this function will generate one by hashing the command and its rules. If you have multiple instance of the same command and rules, you need to specify an UID or only the first one will be executed.

The [rules](<../libraries/awful.rules.html>) are standard [awful.rules](<../libraries/awful.rules.html#>).

This function depends on the startup notification protocol to be correctly implemented by the command. See [client.startup_id](<../classes/client.html#client.startup_id>) for more information. Note that this also wont work with shell or terminal commands. 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The command. 
  * rules [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The properties that need to be applied to the client. 
  * matcher function A matching function to find the instance among running clients. (_optional_) 
  * unique_id [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A string to identify the client so it isn’t executed multiple time. (_optional_) 
  * callback function A callback function when the client is created. (_optional_) 


### See also:

[awful.rules](<../libraries/awful.rules.html#>) 

**single_instance (cmd, rules[, matcher[, unique_id[, callback]]])**
     Spawn a command if an instance is not already running.

This is like [awful.spawn.once](<../libraries/awful.spawn.html#once>), but will spawn new instances if the previous has finished.

The [rules](<../libraries/awful.rules.html>) are standard [awful.rules](<../libraries/awful.rules.html#>).

This function depends on the startup notification protocol to be correctly implemented by the command. See [client.startup_id](<../classes/client.html#client.startup_id>) for more information. Note that this also wont work with shell or terminal commands.

Note that multiple instances can still be spawned if the command is called faster than the client has time to start. 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The command. 
  * rules [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The properties that need to be applied to the client. 
  * matcher function A matching function to find the instance among running clients. (_optional_) 
  * unique_id [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A string to identify the client so it isn’t executed multiple time. (_optional_) 
  * callback function A callback function when the client is created. (_optional_) 


### See also:

[awful.rules](<../libraries/awful.rules.html#>) 

**raise_or_spawn (cmd, rules[, matcher[, unique_id[, callback]]])**
     Raise a client if it exists or spawn a new one then raise it.

This function depends on the startup notification protocol to be correctly implemented by the command. See [client.startup_id](<../classes/client.html#client.startup_id>) for more information. Note that this also wont work with shell or terminal commands. 

  * cmd [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) or [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The command. 
  * rules [table](<https://www.lua.org/manual/5.1/manual.html#5.5>) The properties that need to be applied to the client. 
  * matcher function A matching function to find the instance among running clients. (_optional_) 
  * unique_id [string](<https://www.lua.org/manual/5.1/manual.html#5.4>) A string to identify the client so it isn’t executed multiple time. (_optional_) 
  * callback function A callback function when the client is created. (_optional_) 


### Returns:

[client](<../classes/client.html#>) The client if it already exists. 


### See also:

[awful.rules](<../libraries/awful.rules.html#>)