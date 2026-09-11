# AwesomeWM 4.3 — Debugging Notes

Findings collected while fixing the titlebar visibility bug and the titlebar minimize
button (2026-09-10/11). Setup: AwesomeWM **4.3**; config lives at `config/awesome/`
(also loaded as `~/.config/awesome` via symlink).

## 1. Query the running session with `awesome-client` (read-only)

The live Awesome instance can be inspected **without restarting it**, over D-Bus.
Export the session bus address first:

```sh
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus

# sanity check
timeout 8 awesome-client 'return "ok " .. tostring(awesome.version)'
```

Useful queries:

```sh
# global titlebar flag + client count
timeout 8 awesome-client 'return "hidden=" .. tostring(_G._titlebar_hidden) .. " n=" .. tostring(#client.get())'

# per-client titlebar status (sz = 0 means the top titlebar is collapsed/hidden)
timeout 8 awesome-client 'local o = {}; for i, c in ipairs(client.get()) do local _, sz = c:titlebar_top(); o[#o+1] = tostring(i) .. ":" .. tostring(c.type) .. ":sz=" .. tostring(sz) end; return table.concat(o, " | ")'
```

Caveats:

- Read-only use — diagnose state, don't mutate the running session.
- `awesome-client "awesome.restart()"` may end with
  `org.freedesktop.DBus.Error.NoReply: Remote peer disconnected` (the peer
  disconnects as part of restarting). Read queries keep working fine;
  restart safely with **Mod+Ctrl+R**.
- There is no readable Awesome log file on this box and runtime `print()` output
  is not inspectable. Query state instead of printing from the config.

## 2. Titlebar visibility — what actually works

Verified live against the running session:

| Attempt | Result |
|---|---|
| `c.titlebar` | `nil` — the attribute does not exist in AW 4.3 |
| `tb.visible = false` on an `awful.titlebar(c)` object | silent no-op (no public `visible` property) |
| `awful.titlebar.hide(c)` / `awful.titlebar.show(c)` | **works** — control is size-based |

- `awful.titlebar.hide(c)` collapses the top titlebar to size 0.
- `awful.titlebar.show(c)` restores it (re-runs titlebar creation if needed).
- Read current state: `local _, size = c:titlebar_top()` → `size == 0` means
  hidden. (`awful/client/shape.lua` uses the same call to compute decoration shapes.)

This is why the old bug appeared: existing windows collapsed correctly, but new
windows opened while the flag was set still showed a titlebar — the enforcement
paths used the two dead APIs above.

### The global flag pattern used in this config

`_G._titlebar_hidden` is owned by the Settings toggle: `toggle_titlebar(on)` in
`config/awesome/modules/settings.lua` sets `_G._titlebar_hidden = not on` and
shows/hides titlebars on existing normal/dialog clients.

Enforcement for new clients lives in `config/awesome/modules/signals.lua`:

```lua
-- request::titlebars handler — after the titlebar is created:
if hide_tb then awful.titlebar.hide(c) end

-- manage — apply the flag to newly opened clients
-- (timer so the rules-emitted titlebar creation has already run)
client.connect_signal("manage", function(c)
    gears.timer.start_new(0.1, function()
        if c.valid and _G._titlebar_hidden then
            awful.titlebar.hide(c)
        end
        return false
    end)
end)
```

Do **not** call `awful.titlebar(c, { size = 22 })` from property/manage handlers to
"ensure" a bar: it *creates* one for clients that never requested it and resets a
collapsed bar back to visible — that caused the old "titlebar reappears after
maximize/unmaximize" bug.

## 3. Titlebar minimize button — two traps

1. **Bind on release, not press.** Stock `awful.titlebar.widget.button` and the
   reference configs (`external/example0|1`) bind on release:
   `awful.button({}, 1, nil, fn)`. A press binding (`awful.button({}, 1, fn)`)
   on the titlebar row did not work here; switching to release fixed it.
2. **Never emit `request::activate` with `raise = true` from a minimize handler.**
   The default activate handler clears the minimized state when the raise hint is
   set (`awful/ewmh.lua`: `if hints.raise then c.minimized = false end`),
   undoing the minimize.

Working minimize handler — set `c.minimized = true` and nothing else:

```lua
-- titlebar button row: release binding
box:buttons(gears.table.join(
    awful.button({ }, 1, nil, function() action(c) end)
))

-- action:
function(c) c.minimized = true end
```

(`client.minimize(c)` is not an API in AW 4.3 — use the `c.minimized` property.)

## 4. Where things live

- `config/awesome/modules/signals.lua` — `request::titlebars` handler (builds the
  bar, hides it when `_G._titlebar_hidden`), `manage` enforcement, titlebar icon
  buttons (minimize/maximize/close), drag/resize bindings.
- `config/awesome/modules/settings.lua` — `toggle_titlebar`, `_G._titlebar_hidden`
  flag init, Display-tab toggle button.
- Legacy no-op handlers still present in `signals.lua`
  (`property::fullscreen`, `property::maximized`, `property::floating`, tag
  `property::layout`, `ensure_titlebars`) rely on the dead `c.titlebar` /
  `tb.visible` APIs and do nothing — safe to delete.
