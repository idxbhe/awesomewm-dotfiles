-- themes/mocha/gen-gtk-colors.lua — generate GTK CSS with inlined colors from colors.lua
-- Usage: lua gen-gtk-colors.lua <output.css>
-- Example: lua gen-gtk-colors.lua ../../gtk-3.0/gtk.css
local colors = require("colors")

local c = {
    surface0   = colors.mocha.surface0,
    surface1   = colors.mocha.surface1,
    surface2   = colors.mocha.surface2,
    base       = colors.mocha.base,
    mantle     = colors.mocha.mantle,
    crust      = colors.mocha.crust,
    text       = colors.mocha.text,
    subtext0   = colors.mocha.subtext0,
    subtext1   = colors.mocha.subtext1,
    overlay0   = colors.mocha.overlay0,
    overlay1   = colors.mocha.overlay1,
    overlay2   = colors.mocha.overlay2,
    accent     = colors.accent,
    accent_h   = colors.accent_hover,
    danger     = colors.danger,
    green      = colors.mocha.green,
    red        = colors.mocha.red,
    blue       = colors.mocha.blue,
    peach      = colors.mocha.peach,
    yellow     = colors.mocha.yellow,
    pink       = colors.mocha.pink,
    mauve      = colors.mocha.mauve,
    teal       = colors.mocha.teal,
}

local css = string.format([[
/* ===== Thunar Custom Styling (Catppuccin Mocha) ===== */

/* Override system theme selection color (pink #F5C2E7 → accent) */
@define-color theme_selected_bg_color %s;
@define-color theme_selected_fg_color %s;

/* --- Global --- */
ThunarWindow {
    background-color: %s;
    color: %s;
}

/* --- Toolbar --- */
ThunarWindow .toolbar {
    background-color: %s;
    padding: 4px 8px;
    border-bottom: 1px solid %s;
}

ThunarWindow .toolbar button {
    background-color: transparent;
    color: %s;
    border-radius: 6px;
    padding: 4px 8px;
    margin: 2px;
    min-height: 24px;
}

ThunarWindow .toolbar button:hover {
    background-color: %s;
}

ThunarWindow .toolbar button:active,
ThunarWindow .toolbar button:checked {
    background-color: %s;
}

/* --- Path bar --- */
.thunar-path-bar {
    background-color: %s;
    border-radius: 6px;
    padding: 2px 6px;
    margin: 2px 4px;
}

.thunar-path-bar button {
    background-color: transparent;
    color: %s;
    border-radius: 4px;
    padding: 2px 6px;
    min-height: 20px;
}

.thunar-path-bar button:hover {
    background-color: %s;
}

/* --- Sidebar --- */
.thunar-sidebar {
    background-color: %s;
    padding: 4px 0;
    border-right: 1px solid %s;
}

.thunar-sidebar .view {
    background-color: transparent;
    color: %s;
    font-size: 13px;
}

.thunar-sidebar .view row {
    border-radius: 6px;
    margin: 1px 6px;
    padding: 4px 8px;
    min-height: 28px;
}

.thunar-sidebar .view row:hover {
    background-color: %s;
}

.thunar-sidebar .view row:selected {
    background-color: %s !important;
    color: %s !important;
}

.thunar-sidebar .view row:selected:hover {
    background-color: %s;
}

/* --- File list / Tree view --- */
.thunar-window treeview.view {
    background-color: %s;
    color: %s;
    font-size: 13px;
}

.thunar-window treeview.view row {
    border-radius: 6px;
    margin: 1px 6px;
    padding: 2px 8px;
    min-height: 28px;
}

.thunar-window treeview.view row:hover {
    background-color: %s;
}

.thunar-window treeview.view row:selected {
    background-color: %s;
    color: %s;
}

.thunar-window treeview.view row:selected:hover {
    background-color: %s;
}

/* --- Context menu --- */
.thunar-window menu {
    background-color: %s;
    color: %s;
    border: 1px solid %s;
    border-radius: 8px;
    padding: 4px 0;
}

.thunar-window menu menuitem {
    padding: 6px 12px;
    border-radius: 4px;
    margin: 1px 4px;
}

.thunar-window menu menuitem:hover {
    background-color: %s;
}

/* --- Scrollbar --- */
.thunar-window scrollbar {
    background-color: transparent;
    border-radius: 8px;
}

.thunar-window scrollbar slider {
    background-color: %s;
    border-radius: 8px;
    min-width: 8px;
    min-height: 8px;
    margin: 2px;
}

.thunar-window scrollbar slider:hover {
    background-color: %s;
}

/* --- Entry (search, location bar) --- */
.thunar-window entry {
    background-color: %s;
    color: %s;
    border-radius: 6px;
    padding: 4px 8px;
    border: 1px solid %s;
}

.thunar-window entry:focus {
    border-color: %s;
}

/* --- Status bar --- */
.thunar-window statusbar {
    background-color: %s;
    color: %s;
    border-top: 1px solid %s;
    padding: 2px 8px;
}

/* --- Menubar --- */
ThunarWindow menubar {
    background-color: %s;
    color: %s;
}

ThunarWindow menubar > menuitem {
    padding: 4px 8px;
    border-radius: 4px;
}

ThunarWindow menubar > menuitem:hover {
    background-color: %s;
}

/* --- Override system theme generic selection (pink #F5C2E7 → accent) --- */
treeview.view:selected,
treeview.view:selected:focus,
row:selected,
.view row:selected,
entry selection,
textview text selection,
calendar:selected,
flowbox flowboxchild:selected {
    background-color: %s !important;
    color: %s !important;
}

treeview.view:selected:hover,
row:selected:hover,
.view row:selected:hover {
    background-color: %s !important;
}
]],
    c.accent, c.base,                  -- theme_selected_bg/fg override
    c.base, c.text,                    -- ThunarWindow
    c.mantle, c.surface0,              -- toolbar bg, border
    c.text,                            -- toolbar button fg
    c.surface0,                        -- toolbar button hover
    c.surface1,                        -- toolbar button active
    c.base,                            -- path bar bg
    c.text,                            -- path bar button fg
    c.surface0,                        -- path bar button hover
    c.mantle, c.surface0,              -- sidebar bg, border
    c.text,                            -- sidebar view fg
    c.surface0,                        -- sidebar row hover
    c.accent, c.base,                  -- sidebar row selected (accent)
    c.accent_h,                        -- sidebar row selected hover
    c.base, c.text,                    -- treeview bg, fg
    c.surface0,                        -- treeview row hover
    c.accent, c.text,                  -- treeview row selected (green)
    c.accent_h,                        -- treeview row selected hover
    c.base, c.text, c.surface0,        -- menu
    c.surface0,                        -- menuitem hover
    c.overlay0,                        -- scrollbar slider
    c.overlay1,                        -- scrollbar slider hover
    c.surface0, c.text, c.surface1,    -- entry
    c.accent,                          -- entry focus border
    c.mantle, c.subtext0, c.surface0,  -- statusbar
    c.mantle, c.text,                  -- menubar
    c.surface0,                        -- menubar item hover
    c.accent, c.base,                  -- generic selection bg/fg
    c.accent_h,                        -- generic selection hover
    -- Remaining args for safety (not used)
    c.accent, c.accent_h, c.danger
)

local out_path = arg[1]
if not out_path then
    error("Usage: lua gen-gtk-colors.lua <output.css>")
end

local out = io.open(out_path, "w")
out:write(css)
out:close()
print("Generated " .. out_path)
