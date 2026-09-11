-- modules/state.lua
-- Central location for persistent awesome state (settings, layout, geometry,
-- alarms, clipboard).
--
-- Lives in the XDG data home (~/.local/share/awesome) rather than the cache:
-- state the user changes deliberately must survive cache cleaners and reboots.
-- The config dir is version-controlled and reserved for configuration; only
-- regenerable output (theme-gen) stays in the cache.
--
-- State is plain key=value files (one per concern). They are simple to read
-- back synchronously at startup, which is what restore needs. A single
-- consolidated JSON is possible later if desired, but separate files keep one
-- broken/partial file from taking everything else down.

local gears = require("gears")

local M = {}

M.dir = gears.filesystem.get_xdg_data_home() .. "awesome/"
gears.filesystem.make_directories(M.dir)

-- One-time migration of files written by older versions into the cache.
local legacy_dir = gears.filesystem.get_cache_dir()
local legacy_files = {
    "session_state", "display_state", "layout_state", "window_state",
    "tag_state", "theme_state", "alarms.json", "clipboard.json",
}
for _, name in ipairs(legacy_files) do
    local new_path = M.dir .. name
    local old_path = legacy_dir .. name
    if not gears.filesystem.file_readable(new_path)
        and gears.filesystem.file_readable(old_path) then
        local src = io.open(old_path, "rb")
        if src then
            local data = src:read("*a")
            src:close()
            local dst = io.open(new_path, "wb")
            if dst then
                dst:write(data)
                dst:close()
            end
        end
    end
end

--- Absolute path for a named state file.
function M.path(name)
    return M.dir .. name
end

return M
