-- Монитор: любое подключённое, предпочтительный режим
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

local wallpaper = os.getenv("HOME") .. "/.cache/wallpaper.jpg"

hl.on("hyprland.start", function()
    hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences button-layout ':'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface monospace-font-name 'Cascadia Code 11'")
    hl.exec_cmd("waybar")
    hl.exec_cmd(os.getenv("HOME") .. "/.config/waybar/scripts/happ-tray-fix.sh")
    hl.exec_cmd('hyprctl hyprpaper preload "' .. wallpaper .. '"')
    hl.exec_cmd('hyprctl hyprpaper wallpaper ",' .. wallpaper .. '"')
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("swaync")
    -- hl.exec_cmd("noctalia")
    hl.exec_cmd("numlockx on")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
end)
