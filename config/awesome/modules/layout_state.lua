-- modules/layout_state.lua
-- Persist each tag's layout and layout parameters across awesome restart.
--
-- Tags are recreated by rc.lua on every restart with the first configured
-- layout (tile), so without this a per-tag layout choice (and master count /
-- factors) is lost. State is keyed by screen index + tag name.

local m = require("modules")
local gears = m.gears
local awful = m.awful

local M = {}

local state_file = gears.filesystem.get_cache_dir() .. "/layout_state"
local saved = {}
local startup = true

local function find_layout(name)
    if not name or name == "" then return nil end
    for _, l in ipairs(awful.layout.layouts or {}) do
        if l.name == name then return l end
    end
    -- Also cover the full suit table (corner/fair/etc. not in the cycle list).
    for _, l in pairs(awful.layout.suit or {}) do
        if type(l) == "table" and l.name == name then return l end
    end
    return nil
end

local function load()
    local f = io.open(state_file, "r")
    if not f then return end
    for line in f:lines() do
        -- screen|name|layout|mwfact|nmaster|ncol|gap
        local scre, name, layout, mwfact, nmaster, ncol, gap =
            line:match("^(%d+)|([^|]*)|([^|]*)|(-?%d+%.?%d*)|(-?%d+)|(-?%d+)|(-?%d+)$")
        if scre then
            saved[scre .. "|" .. name] = {
                layout  = (layout ~= "" and layout) or nil,
                mwfact  = tonumber(mwfact),
                nmaster = tonumber(nmaster),
                ncol    = tonumber(ncol),
                gap     = tonumber(gap),
            }
        end
    end
    f:close()
end

local save_timer = gears.timer {
    timeout = 2,
    single_shot = true,
    callback = function()
        local f = io.open(state_file, "w")
        if not f then return end
        for _, s in ipairs(screen) do
            for _, t in ipairs(s.tags) do
                local st = saved[s.index .. "|" .. t.name]
                if st then
                    f:write(string.format("%d|%s|%s|%.2f|%d|%d|%d\n",
                        s.index, t.name, st.layout or "",
                        st.mwfact or 0.5, st.nmaster or 1, st.ncol or 1, st.gap or 0))
                end
            end
        end
        f:close()
    end,
}

local function capture(t)
    if startup then return end
    local s = t.screen
    if not s then return end
    saved[s.index .. "|" .. t.name] = {
        layout  = t.layout and t.layout.name or nil,
        mwfact  = t.master_width_factor,
        nmaster = t.master_count,
        ncol    = t.column_count,
        gap     = t.gap,
    }
    save_timer:again()
end

tag.connect_signal("property::layout", capture)
tag.connect_signal("property::master_width_factor", capture)
tag.connect_signal("property::master_count", capture)
tag.connect_signal("property::column_count", capture)
tag.connect_signal("property::gap", capture)

local function restore()
    for _, s in ipairs(screen) do
        for _, t in ipairs(s.tags) do
            local st = saved[s.index .. "|" .. t.name]
            if st then
                if st.mwfact then t.master_width_factor = st.mwfact end
                if st.nmaster then t.master_count = st.nmaster end
                if st.ncol then t.column_count = st.ncol end
                if st.gap then t.gap = st.gap end
                local l = find_layout(st.layout)
                if l then
                    t.layout = l
                    -- Ensure the hard mode switch runs even though this fires
                    -- just after startup (layout_manager skips during startup).
                    pcall(function()
                        require("modules.layout_manager").enforce(t)
                    end)
                end
            end
        end
    end
    startup = false
end

load()
gears.timer.start_new(1, function()
    restore()
    return false
end)

M.find_layout = find_layout
M.restore = restore

return M
