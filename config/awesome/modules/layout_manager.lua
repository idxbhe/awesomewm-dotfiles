-- modules/layout_manager.lua
-- Makes a tag layout change a clean, hard mode switch for every normal window
-- on the tag.
--
-- Awesome only tiles clients that are not floating/maximized/fullscreen
-- (see awful.client.tiled), so without help a maximized window stays put when
-- the layout changes and must be un-maximized by hand. Here, on every layout
-- change we:
--   * clear fullscreen / maximize so the client re-enters the layout
--     (minimized windows stay minimized; their flags are still reset so they
--     follow the new layout once restored),
--   * for a tiling target, drop the floating flag so the window is arranged,
--   * for the floating target, restore the window's last floating geometry
--     (or a centered default) and cascade colliding geometries so several
--     windows of the same app never land exactly on top of each other.
--
-- User overrides (maximize / float) made *after* the switch are left untouched
-- until the next layout change.

local m = require("modules")
local awful = m.awful
local window_state = require("modules.window_state")

local M = {}

-- Pixels to shift each colliding window, and how many times to try before
-- giving up (workarea is small; 10 cascades is more than enough).
local CASCADE_STEP = 32
local CASCADE_MAX = 10

local function tag_is_floating(t)
    return t and t.layout and t.layout.name == "floating"
end

-- Only normal windows participate in the hard switch. Dialogs, utilities and
-- splash windows are transient UI and stay floating by nature.
local function switchable(c)
    return c.type == "normal"
end

local function clear_transient_states(c)
    if c.fullscreen then c.fullscreen = false end
    if c.maximized then c.maximized = false end
    if c.maximized_horizontal then c.maximized_horizontal = false end
    if c.maximized_vertical then c.maximized_vertical = false end
end

local function workarea_of(c)
    local s = c.screen or awful.screen.focused()
    return s and s.workarea or screen.primary.workarea
end

-- Keep a geometry inside the workarea (size first, then position).
local function clamp_to_workarea(geo, wa)
    geo.width = math.min(geo.width, wa.width)
    geo.height = math.min(geo.height, wa.height)
    if geo.x < wa.x then geo.x = wa.x end
    if geo.y < wa.y then geo.y = wa.y end
    if geo.x + geo.width > wa.x + wa.width then
        geo.x = wa.x + wa.width - geo.width
    end
    if geo.y + geo.height > wa.y + wa.height then
        geo.y = wa.y + wa.height - geo.height
    end
end

-- Desired floating geometry: last saved floating geometry, else a centered
-- default sized from the workarea.
local function desired_geometry(c)
    local st = window_state.lookup(c)
    local f = st and st.floating
    if f and f.width and f.width > 0 and f.height and f.height > 0 then
        return {
            x = f.x or 0,
            y = f.y or 0,
            width = f.width,
            height = f.height,
        }
    end
    return window_state.default_geometry(workarea_of(c))
end

-- Place one floating window, cascading it away from spots already taken this
-- pass so identical saved geometries (e.g. two windows of the same app) do not
-- stack exactly.
local function place_floating(c, used)
    local wa = workarea_of(c)
    local geo = desired_geometry(c)
    clamp_to_workarea(geo, wa)

    local key = geo.x .. ":" .. geo.y
    local tries = 0
    while used[key] and tries < CASCADE_MAX do
        geo.x = geo.x + CASCADE_STEP
        geo.y = geo.y + CASCADE_STEP
        clamp_to_workarea(geo, wa)
        key = geo.x .. ":" .. geo.y
        tries = tries + 1
    end
    used[key] = true
    return geo
end

local function enforce(t)
    -- Never fight the initial layout assignment while clients are still being
    -- scanned on startup/restart.
    if awesome.startup then return end
    if not t or not t.valid then return end

    local floating_target = tag_is_floating(t)

    -- Stable order so the cascade is deterministic across reloads.
    local clients = t:clients() or {}
    table.sort(clients, function(a, b)
        return (a.window or 0) < (b.window or 0)
    end)

    -- Seed with positions of windows we are NOT moving (e.g. dialogs) so a
    -- restored window does not land exactly on top of them.
    local moving = {}
    for _, c in ipairs(clients) do
        if c.window then moving[c.window] = true end
    end
    local used = window_state.floating_positions(moving)
    for _, c in ipairs(clients) do
        if c.valid and switchable(c) then
            clear_transient_states(c)
            if floating_target then
                -- Set floating before geometry so the resulting geometry is
                -- recorded as the floating geometry, not the tiled one.
                c.floating = true
                c:geometry(place_floating(c, used))
                awful.placement.no_offscreen(c, { honor_workarea = true })
            else
                c.floating = false
            end
        end
    end
end

tag.connect_signal("property::layout", enforce)

M.enforce = enforce

return M
