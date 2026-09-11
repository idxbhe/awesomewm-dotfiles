-- modules/session_state.lua
-- Persist session-level audio/brightness values across awesome restart/reboot.
--
-- These are system values (pipewire / backlight), not WM state, but nothing on
-- this box restores them for us, so we snapshot on change and re-apply once the
-- session comes back up.

local m = require("modules")
local gears = m.gears
local awful = m.awful

local M = {}

local state_file = gears.filesystem.get_cache_dir() .. "/session_state"
local volume    -- 0..100
local muted     -- boolean
local brightness -- 0..100
-- Saves are ignored until restore() has run, otherwise the startup pollers
-- (volume/brightness) would overwrite the saved values with the pre-restore
-- system values.
local ready = false

local function load()
    local f = io.open(state_file, "r")
    if not f then return end
    for line in f:lines() do
        local k, v = line:match("^(%w+)=(-?%d+)$")
        if v then
            v = tonumber(v)
            if k == "volume" and v >= 0 then
                volume = v
            elseif k == "muted" then
                muted = (v == 1)
            elseif k == "brightness" and v >= 0 then
                brightness = v
            end
        end
    end
    f:close()
end

local function write()
    local f = io.open(state_file, "w")
    if not f then return end
    f:write("volume=" .. (volume and volume or -1) .. "\n")
    f:write("muted=" .. (muted and 1 or 0) .. "\n")
    f:write("brightness=" .. (brightness and brightness or -1) .. "\n")
    f:close()
end

-- Only write when something actually changed (callers may poll).
function M.save_volume(v)
    if not ready or not v then return end
    v = math.max(0, math.min(100, math.floor(v)))
    if v == volume then return end
    volume = v
    write()
end

function M.save_mute(b)
    if not ready or b == nil then return end
    b = not not b
    if b == muted then return end
    muted = b
    write()
end

function M.save_brightness(v)
    if not ready or not v then return end
    v = math.max(0, math.min(100, math.floor(v)))
    if v == brightness then return end
    brightness = v
    write()
end

load()

-- Re-apply saved values once the session is up (give daemons a moment).
gears.timer.start_new(3, function()
    if brightness then
        awful.spawn("brightnessctl set " .. brightness .. "%", false)
    end
    if volume then
        awful.spawn({ "pamixer", "--set-volume", tostring(volume) }, false)
    end
    if muted ~= nil then
        awful.spawn({ "pactl", "set-sink-mute", "@DEFAULT_SINK@", muted and "1" or "0" }, false)
    end
    ready = true
    return false
end)

return M
