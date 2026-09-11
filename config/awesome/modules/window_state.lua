-- modules/window_state.lua
-- Per-window geometry memory (position + size) for floating and tiled modes.
--
-- Keyed by class + X window id so multiple windows of the same app keep their
-- own geometry. X window ids survive awesome.restart() (the X clients do not
-- restart), which is what makes restore reliable across config reloads. A
-- per-class fallback entry (xid 0) is kept so an app reopened later still lands
-- at its last used geometry.

local m = require("modules")
local gears = m.gears
local awful = m.awful

local M = {}

local state_file = gears.filesystem.get_cache_dir() .. "/window_state"

-- Format: class|xid|fx|fy|fw|fh|tx|ty|tw|th|last_mode   (xid 0 = class fallback)
-- Legacy: class|fx|fy|fw|fh|tx|ty|tw|th|last_mode        (no xid column)
local window_states = {}   -- class -> { [xid] = state }
local class_fallback = {}  -- class -> state (most recently recorded)

-- Flag to prevent recording during startup
local startup_phase = true
-- Flag to prevent recording while awesome is tearing down (restart/quit)
local exiting = false

-- Default floating geometry as a fraction of the workarea
M.FLOAT_W_RATIO = 0.6
M.FLOAT_H_RATIO = 0.7

-- {{{ Load persisted state
do
    local function geo4(x, y, w, h)
        local nx, ny = tonumber(x), tonumber(y)
        local nw, nh = tonumber(w), tonumber(h)
        return {
            x = nx ~= -999 and nx or nil,
            y = ny ~= -999 and ny or nil,
            width = nw ~= -999 and nw or nil,
            height = nh ~= -999 and nh or nil,
        }
    end

    local f = io.open(state_file, "r")
    if f then
        for line in f:lines() do
            local class, xid, fx, fy, fw, fh, tx, ty, tw, th, mode =
                line:match("^(.-)|(%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(.+)$")
            if not class then
                -- Legacy class-only line
                local lc, lfx, lfy, lfw, lfh, ltx, lty, ltw, lth, lmode =
                    line:match("^(.-)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(-?%d+)|(.+)$")
                class, xid = lc, "0"
                fx, fy, fw, fh = lfx, lfy, lfw, lfh
                tx, ty, tw, th = ltx, lty, ltw, lth
                mode = lmode
            end
            if class and class ~= "" then
                local s = {
                    floating = geo4(fx, fy, fw, fh),
                    tiled = geo4(tx, ty, tw, th),
                    last_mode = mode or "tiled",
                }
                local n = tonumber(xid) or 0
                if n == 0 then
                    class_fallback[class] = s
                else
                    window_states[class] = window_states[class] or {}
                    window_states[class][n] = s
                end
            end
        end
        f:close()
    end

    -- Make sure every class has a fallback (covers files written before the
    -- fallback line existed).
    for class, by_xid in pairs(window_states) do
        if not class_fallback[class] then
            for _, s in pairs(by_xid) do class_fallback[class] = s; break end
        end
    end
end
-- }}}

-- {{{ Persist
-- prune=true drops entries whose X window is no longer open (normal debounced
-- save). prune=false writes everything we know (exit flush, where clients may
-- already be unmanaged but their X ids will still exist after restart).
local function save_window_states(prune)
    local f = io.open(state_file, "w")
    if not f then return end

    local live = nil
    if prune then
        live = {}
        for _, c in ipairs(client.get()) do
            if c.class and c.window then live[c.class .. "|" .. tostring(c.window)] = true end
        end
    end

    local function write_state(class, xid, s)
        local fl = s.floating or {}
        local ti = s.tiled or {}
        f:write(string.format("%s|%d|%d|%d|%d|%d|%d|%d|%d|%d|%s\n",
            class, xid,
            fl.x and math.floor(fl.x) or -999,
            fl.y and math.floor(fl.y) or -999,
            fl.width and math.floor(fl.width) or -999,
            fl.height and math.floor(fl.height) or -999,
            ti.x and math.floor(ti.x) or -999,
            ti.y and math.floor(ti.y) or -999,
            ti.width and math.floor(ti.width) or -999,
            ti.height and math.floor(ti.height) or -999,
            s.last_mode or "tiled"))
    end

    for class, s in pairs(class_fallback) do write_state(class, 0, s) end
    for class, by_xid in pairs(window_states) do
        for xid, s in pairs(by_xid) do
            if not live or live[class .. "|" .. tostring(xid)] then
                write_state(class, xid, s)
            end
        end
    end
    f:close()
end

-- Debounced save (avoid writing on every pixel of resize)
local save_timer = gears.timer {
    timeout = 2,
    single_shot = true,
    callback = function() save_window_states(true) end,
}
-- }}}

-- {{{ Helpers
-- A client counts as visually floating when it is explicitly/implicitly
-- floating OR when its tag currently uses the floating layout. The latter is
-- important: on a floating-layout tag `c.floating` is false for normal windows,
-- yet their geometry must be remembered as the floating geometry.
local function is_floating(c)
    if c.floating then return true end
    local scr = c.screen
    local t = scr and scr.selected_tag
    return (t and t.layout and t.layout.name == "floating") or false
end

-- Centered default floating geometry for a workarea.
function M.default_geometry(wa)
    local w = math.floor(wa.width * M.FLOAT_W_RATIO)
    local h = math.floor(wa.height * M.FLOAT_H_RATIO)
    return {
        x = wa.x + math.floor((wa.width - w) / 2),
        y = wa.y + math.floor((wa.height - h) / 2),
        width = w,
        height = h,
    }
end

-- Resolve the state entry for a window: exact X-id match first, then the
-- per-class fallback. Returns state, exact_match.
function M.lookup(c)
    if not c.class then return nil, false end

    local by_xid = c.window and window_states[c.class]
    local exact = by_xid and by_xid[c.window]
    if exact then return exact, true end
    return class_fallback[c.class], false
end

function M.apply_default(c)
    local s = c.screen or awful.screen.focused()
    if not s then return end
    local g = M.default_geometry(s.workarea)
    M.avoid_overlap(c, g)
    c.width = g.width
    c.height = g.height
    c.x = g.x
    c.y = g.y
end

-- Set of "x:y" positions occupied by currently visible floating windows. Used
-- to cascade a newly placed window away from an existing one instead of
-- stacking two windows of the same app exactly on top of each other.
-- `exclude` may be a single client or a set of X window ids ({ [wid]=true }).
function M.floating_positions(exclude)
    local function excluded(o)
        if type(exclude) == "table" then return exclude[o.window] == true end
        return o == exclude
    end
    local used = {}
    for _, o in ipairs(client.get()) do
        if o.valid and not excluded(o) and o:isvisible() and is_floating(o) then
            local g = o:geometry()
            used[g.x .. ":" .. g.y] = true
        end
    end
    return used
end

-- Shift `geo` diagonally until it no longer lands exactly on an existing
-- floating window, wrapping back into the workarea. Mutates and returns geo.
function M.avoid_overlap(c, geo)
    local used = M.floating_positions(c)
    local s = c.screen or awful.screen.focused()
    local wa = s and s.workarea
    local step, max_tries = 32, 10

    local key = geo.x .. ":" .. geo.y
    local tries = 0
    while used[key] and tries < max_tries do
        geo.x = geo.x + step
        geo.y = geo.y + step
        if wa then
            if geo.x + geo.width > wa.x + wa.width then geo.x = wa.x end
            if geo.y + geo.height > wa.y + wa.height then geo.y = wa.y end
        end
        key = geo.x .. ":" .. geo.y
        tries = tries + 1
    end
    return geo
end

function M.record(c)
    if exiting then return end
    -- A window is not recordable until its initial manage restore/default has
    -- run. Rules/placement change geometry during manage, before our manage
    -- handler runs, so this must default to "not ready" for every new client.
    if not c._state_ready then return end
    if not (c.class and c.valid) then return end

    -- Ignore transient states: maximize/fullscreen geometry is not the window's own
    if c.fullscreen or c.maximized then return end

    local class = c.class
    local geo = c:geometry()
    local entry = {
        floating = {},
        tiled = {},
        last_mode = "tiled",
    }
    -- Carry over the other mode's last known geometry
    local prev, _ = M.lookup(c)
    if prev then
        entry.floating = prev.floating or {}
        entry.tiled = prev.tiled or {}
    end

    if is_floating(c) then
        entry.floating = { x = geo.x, y = geo.y, width = geo.width, height = geo.height }
        entry.last_mode = "floating"
    else
        entry.tiled = { x = geo.x, y = geo.y, width = geo.width, height = geo.height }
        entry.last_mode = "tiled"
    end

    if c.window then
        window_states[class] = window_states[class] or {}
        window_states[class][c.window] = entry
    end
    class_fallback[class] = entry
    save_timer:again()
end

local function restore_floating_state(c, state)
    local f = state.floating
    if not (f and f.width and f.width > 0 and f.height and f.height > 0) then
        return false
    end
    local geo = { x = f.x or 0, y = f.y or 0, width = f.width, height = f.height }
    -- Avoid landing exactly on another window that is already on screen (e.g.
    -- two windows of the same app opened at once sharing the class fallback).
    M.avoid_overlap(c, geo)
    c.floating = true
    c.width = geo.width
    c.height = geo.height
    c.x = geo.x
    c.y = geo.y
    -- Keep on a visible screen in case the monitor layout changed
    awful.placement.no_offscreen(c)
    return true
end

-- Flush pending state and stop recording (called on awesome exit/restart).
function M.flush()
    if save_timer.started then save_timer:stop() end
    save_window_states(false)
    exiting = true
end
-- }}}

-- {{{ Manage: restore state for newly opened clients
client.connect_signal("manage", function(c)
    -- Restore on both fresh start and awesome restart. Only floating state is
    -- meaningful to force; tiled geometry is decided by the layout. Recording
    -- stays off (c._state_ready unset) until this has run.
    gears.timer.start_new(0.1, function()
        if not c.valid then return false end

        local state, exact = M.lookup(c)
        if state and state.last_mode == "floating" then
            pcall(restore_floating_state, c, state)
        elseif c.floating and c.type == "normal" and not c.maximized and not c.fullscreen then
            -- No saved state: give plain floating windows a sane default size/position
            pcall(M.apply_default, c)
        end

        -- Now that geometry has settled, allow recording and persist the
        -- resolved state so it survives a restart even if never touched.
        c._state_ready = true
        M.record(c)
        return false
    end)
end)
-- }}}

-- {{{ Record on geometry / state changes after startup
client.connect_signal("property::geometry", function(c)
    if not startup_phase then M.record(c) end
end)
client.connect_signal("property::floating", function(c)
    if not startup_phase then M.record(c) end
end)
client.connect_signal("property::maximized", function(c)
    if not startup_phase then M.record(c) end
end)
client.connect_signal("property::fullscreen", function(c)
    if not startup_phase then M.record(c) end
end)
client.connect_signal("unmanage", function(c)
    -- During teardown/restart windows are unmanaged with transient geometry.
    -- On a real close, drop the instance entry but keep the class fallback so
    -- the app reopens where it last was.
    if not startup_phase and not exiting then
        M.record(c)
        if c.class and c.window and window_states[c.class] then
            window_states[c.class][c.window] = nil
        end
    end
end)

-- Mark startup as complete after a short delay
gears.timer.start_new(3, function()
    startup_phase = false
    return false
end)
-- }}}

return M
