local p = require("programs")

local mainMod = "SUPER"

local function key(mods, k)
    if mods == "" then
        return k
    end
    return mods .. " + " .. k
end

local function bind(mods, k, dispatcher, opts)
    return hl.bind(key(mods, k), dispatcher, opts)
end

local main      = mainMod
local mainShift = mainMod .. " + SHIFT"
local mainCtrl  = mainMod .. " + CTRL"
local mainAlt   = mainMod .. " + ALT"

local repeating     = { repeating = true }
local locked        = { locked = true }
local lockedRepeat  = { locked = true, repeating = true }
local mouse         = { mouse = true }

---------------------------
---- Window Management ----
---------------------------
bind(main,             "Q",      hl.dsp.window.close())
bind("ALT",            "F4",     hl.dsp.window.close())
bind(main,             "Delete", hl.dsp.exit())
bind(main,             "W",      hl.dsp.window.float())
bind(main,             "G",      hl.dsp.group.toggle())
bind("SHIFT",          "F11",    hl.dsp.window.fullscreen({ mode = "fullscreen" }))
-- bind(main, "L", hl.dsp.exec_cmd("lockscreen.sh"))
bind("CTRL + ALT",     "Delete", hl.dsp.exec_cmd("gnome-system-monitor"))
-- toggle waybar without reloading, this is faster
bind("ALT",            "Control_R", hl.dsp.exec_cmd("pkill -x waybar || waybar"))

-- Group Navigation
bind(mainCtrl, "H", hl.dsp.group.prev())
bind(mainCtrl, "L", hl.dsp.group.next())

-- Change focus
bind(main,  "Left",  hl.dsp.focus({ direction = "left" }))
bind(main,  "Right", hl.dsp.focus({ direction = "right" }))
bind(main,  "Up",    hl.dsp.focus({ direction = "up" }))
bind(main,  "Down",  hl.dsp.focus({ direction = "down" }))
bind("ALT", "Tab",   hl.dsp.window.cycle_next())

-- Resize Active Window
bind(mainShift, "Right", hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }), repeating)
bind(mainShift, "Left",  hl.dsp.window.resize({ x = -30, y = 0,   relative = true }), repeating)
bind(mainShift, "Up",    hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), repeating)
bind(mainShift, "Down",  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), repeating)

-- Move active window around current workspace with mainMod + Shift + Control [←→↑↓]:
-- плавающее окно сдвигается на 30px, тайловое меняется местами с соседом
local function moveActive(dx, dy, direction)
    return function()
        local w = hl.get_active_window()
        if w and w.floating then
            hl.dispatch(hl.dsp.window.move({ x = dx, y = dy, relative = true }))
        else
            hl.dispatch(hl.dsp.window.move({ direction = direction }))
        end
    end
end

local mainShiftCtrl = mainMod .. " + SHIFT + CTRL"
bind(mainShiftCtrl, "left",  moveActive(-30, 0, "left"),  repeating)
bind(mainShiftCtrl, "right", moveActive(30, 0, "right"),  repeating)
bind(mainShiftCtrl, "up",    moveActive(0, -30, "up"),    repeating)
bind(mainShiftCtrl, "down",  moveActive(0, 30, "down"),   repeating)

-- Move & Resize with mouse
bind(main, "mouse:272", hl.dsp.window.drag(),   mouse)
bind(main, "mouse:273", hl.dsp.window.resize(), mouse)
bind(main, "Z",         hl.dsp.window.drag(),   mouse)
bind(main, "X",         hl.dsp.window.resize(), mouse)

-- Toggle focused window split
bind(main, "J", hl.dsp.layout("togglesplit"))

------------------
---- Launcher ----
------------------
bind(main,    "T", hl.dsp.exec_cmd(p.terminal))
bind(mainAlt, "T", hl.dsp.exec_cmd(p.terminal, {
    float = true,
    move  = { "monitor_w*0.2", "monitor_h*0.05" },
    size  = { "monitor_w*0.6", "monitor_h*0.6" },
}))
bind(main,    "E", hl.dsp.exec_cmd(p.fileManager))
bind(main,    "C", hl.dsp.exec_cmd(p.editor))
bind(main,    "B", hl.dsp.exec_cmd(p.browser))

-- Rofi menus
bind(main,      "A",   hl.dsp.exec_cmd("rofi -show drun"))
bind(main,      "TAB", hl.dsp.exec_cmd("rofi -show window"))
bind(mainShift, "E",   hl.dsp.exec_cmd("pkill -x rofi || rofi -show filebrowser"))
bind(main,      "V",   hl.dsp.exec_cmd("cliphist list | rofi -dmenu | cliphist decode | wl-copy"))

---------------------------
---- Hardware Controls ----
---------------------------
-- Audio
-- swayosd-client сам меняет громкость/яркость и показывает OSD
local volumeDown = hl.dsp.exec_cmd("swayosd-client --output-volume -5 --max-volume 100")
local volumeUp   = hl.dsp.exec_cmd("swayosd-client --output-volume +5 --max-volume 100")
bind("", "XF86AudioMute",        hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), locked)
bind("", "F11",                  volumeDown, lockedRepeat)
bind("", "F12",                  volumeUp,   lockedRepeat)
bind("", "XF86AudioLowerVolume", volumeDown, lockedRepeat)
bind("", "XF86AudioRaiseVolume", volumeUp,   lockedRepeat)

-- Media
bind("", "XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), locked)
bind("", "XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
bind("", "XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       locked)
bind("", "XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   locked)

-- Brightness
bind("", "XF86MonBrightnessUp",   hl.dsp.exec_cmd("swayosd-client --brightness raise"), lockedRepeat)
bind("", "XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), lockedRepeat)

-- Screen Capture
bind(mainShiftCtrl, "P",     hl.dsp.exec_cmd("hyprpicker -an"))           -- Pick color (Hex) >> clipboard
bind(main,          "Print", hl.dsp.exec_cmd("hyprshot -m output"))       -- full monitor capture
bind(mainAlt,       "Print", hl.dsp.exec_cmd("hyprshot -m window"))       -- window capture
bind("",            "Print", hl.dsp.exec_cmd("hyprshot -m region"))       -- partial screenshot

--------------------
---- Workspaces ----
--------------------
for i = 1, 10 do
    local k = tostring(i % 10) -- 10 -> клавиша 0
    bind(main,      k, hl.dsp.focus({ workspace = i }))
    bind(mainShift, k, hl.dsp.window.move({ workspace = i, follow = true }))
    bind(mainAlt,   k, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Relative workspace
bind(mainCtrl, "Right", hl.dsp.focus({ workspace = "r+1" }))
bind(mainCtrl, "Left",  hl.dsp.focus({ workspace = "r-1" }))
bind(mainCtrl, "Down",  hl.dsp.focus({ workspace = "empty" }))

-- Move focused window to a relative workspace
bind(mainMod .. " + CTRL + ALT", "Right", hl.dsp.window.move({ workspace = "r+1", follow = true }))
bind(mainMod .. " + CTRL + ALT", "Left",  hl.dsp.window.move({ workspace = "r-1", follow = true }))

-- Scroll through existing workspaces
bind(main, "mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(main, "mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace (scratchpad)
bind(mainShift, "S", hl.dsp.window.move({ workspace = "special:special", follow = true }))
bind(mainAlt,   "S", hl.dsp.window.move({ workspace = "special:special", follow = false }))
bind(main,      "S", hl.dsp.workspace.toggle_special("special"))

-- Locker
bind(main, "L", hl.dsp.exec_cmd("hyprlock"))

-- Restart waybar
bind(mainShift, "W", hl.dsp.exec_cmd("pkill waybar && waybar &"))
