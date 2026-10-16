local function rule(match, effects)
    effects.match = match
    hl.window_rule(effects)
end

---------------------
---- Idle inhibit ----
---------------------
rule({ class = "^(.*celluloid.*)$|^(.*mpv.*)$|^(.*vlc.*)$" }, { idle_inhibit = "fullscreen" })
rule({ class = "^(.*[Ss]potify.*)$" }, { idle_inhibit = "fullscreen" })
rule({ class = "^(.*LibreWolf.*)$|^(.*floorp.*)$|^(.*Brave.*)$|^(.*firefox.*)$|^(.*chromium.*)$|^(.*zen.*)$|^(.*vivaldi.*)$" },
     { idle_inhibit = "fullscreen" })

----------------------------
---- Picture-in-Picture ----
----------------------------
rule({ title = [[^([Pp]icture[-\s]?[Ii]n[-\s]?[Pp]icture)(.*)$]] }, {
    float             = true,
    keep_aspect_ratio = true,
    move              = { "monitor_w*0.73", "monitor_h*0.72" },
    size              = { "monitor_w*0.25", "monitor_h*0.25" },
    pin               = true,
})

-----------------
---- Opacity ----
-----------------
rule({ class = ".*" }, { opacity = "0.9 0.9" })

local opacityByClass = {
    { "^(firefox)$",                                     "0.90 0.90 1" },
    { "^(Brave-browser)$",                               "0.90 0.90 1" },
    { "^(code-oss)$",                                    "0.80 0.80 1" },
    { "^([Cc]ode)$",                                     "0.80 0.80 1" },
    { "^(code-url-handler)$",                            "0.90 0.90 1" },
    { "^(code-insiders-url-handler)$",                   "0.90 0.90 1" },
    { "^(kitty)$",                                       "0.90 0.90 1" },
    { "^(org.kde.dolphin)$",                             "0.90 0.90 1" },
    { "^(org.kde.ark)$",                                 "0.90 0.90 1" },
    { "^(nwg-look)$",                                    "0.90 0.90 1" },
    { "^(qt5ct)$",                                       "0.90 0.90 1" },
    { "^(qt6ct)$",                                       "0.90 0.90 1" },
    { "^(kvantummanager)$",                              "0.80 0.80 1" },
    { "^(org.pulseaudio.pavucontrol)$",                  "0.80 0.70 1" },
    { "^(blueman-manager)$",                             "0.80 0.70 1" },
    { "^(nm-applet)$",                                   "0.80 0.70 1" },
    { "^(nm-connection-editor)$",                        "0.80 0.70 1" },
    { "^(org.kde.polkit-kde-authentication-agent-1)$",   "0.80 0.70 1" },
    { "^(polkit-gnome-authentication-agent-1)$",         "0.80 0.70 1" },
    { "^(org.freedesktop.impl.portal.desktop.gtk)$",     "0.80 0.70 1" },
    { "^(org.freedesktop.impl.portal.desktop.hyprland)$", "0.80 0.70 1" },
    { "^([Ss]team)$",                                    "0.85 0.85 1" },
    { "^(steamwebhelper)$",                              "0.85 0.85 1" },
    { "^([Ss]potify)$",                                  "0.90 0.90 1" },
}
for _, r in ipairs(opacityByClass) do
    rule({ class = r[1] }, { opacity = r[2] })
end

rule({ initial_title = "^(Spotify Free)$" },    { opacity = "0.90 0.90 1" })
rule({ initial_title = "^(Spotify Premium)$" }, { opacity = "0.90 0.90 1" })

local opacityByClass2 = {
    { "^(com.github.rafostar.Clapper)$",          "0.90 0.90" }, -- Clapper-Gtk
    { "^(com.github.tchx84.Flatseal)$",           "0.80 0.80" }, -- Flatseal-Gtk
    { "^(hu.kramo.Cartridges)$",                  "0.80 0.80" }, -- Cartridges-Gtk
    { "^(com.obsproject.Studio)$",                "0.80 0.80" }, -- Obs-Qt
    { "^(gnome-boxes)$",                          "0.80 0.80" }, -- Boxes-Gtk
    { "^(vesktop)$",                              "0.80 0.80" }, -- Vesktop
    { "^(discord)$",                              "0.90 0.90" }, -- Discord-Electron
    { "^(WebCord)$",                              "0.90 0.90" }, -- WebCord-Electron
    { "^(ArmCord)$",                              "0.90 0.90" }, -- ArmCord-Electron
    { "^(app.drey.Warp)$",                        "0.80 0.80" }, -- Warp-Gtk
    { "^(net.davidotek.pupgui2)$",                "0.80 0.80" }, -- ProtonUp-Qt
    { "^(yad)$",                                  "0.80 0.80" }, -- Protontricks-Gtk
    { "^(Signal)$",                               "0.80 0.80" }, -- Signal-Gtk
    { "^(io.github.alainm23.planify)$",           "0.80 0.80" }, -- planify-Gtk
    { "^(io.gitlab.theevilskeleton.Upscaler)$",   "0.80 0.80" }, -- Upscaler-Gtk
    { "^(com.github.unrud.VideoDownloader)$",     "0.80 0.80" }, -- VideoDownloader-Gtk
    { "^(io.gitlab.adhami3310.Impression)$",      "0.80 0.80" }, -- Impression-Gtk
    { "^(io.missioncenter.MissionCenter)$",       "0.80 0.80" }, -- MissionCenter-Gtk
    { "^(io.github.flattool.Warehouse)$",         "0.80 0.80" }, -- Warehouse-Gtk

    { "^(org.gnome.Nautilus)$",                   "0.9 0.9" },
    { "^(org.gnome.TextEditor)$",                 "0.9 0.9" },
    { "^(org.gnome.SystemMonitor)$",              "0.9 0.9" },
    { "^(io.github.celluloid_player.Celluloid)$", "0.9 0.9" },
    { "^(de.haeckerfelix.Fragments)$",            "0.9 0.9" },
    { "^(org.gnome.Software)$",                   "0.9 0.9" },
    { "^(org.gnome.Loupe)$",                      "0.9 0.9" },
    { "^(org.gnome.baobab)$",                     "0.9 0.9" },
    { "^(org.gnome.Calendar)$",                   "0.9 0.9" },
    { "^(org.gnome.Calculator)$",                 "0.9 0.9" },
    { "^(org.gnome.Papers)$",                     "0.9 0.9" },
    { "^(org.gnome.Boxes)$",                      "0.9 0.9" },
    { "^(jetbrains-pycharm-ce)$",                 "0.9 0.9" },
    { "^(org.telegram.desktop)$",                 "0.9 0.9" },
    { "^(com.github.neithern.g4music)$",          "0.9 0.9" },
    { "^(yandex-music)$",                         "0.9 0.9" },
    { "^(io.github.kaii_lb.Overskride)$",         "0.9 0.9" },
    { "^(libreoffice-writer)$",                   "0.9 0.9" },
    { "^(nekoray)$",                              "0.9 0.9" },
    { "^(gimp)$",                                 "0.9 0.9" },
    { "^(throne)$",                               "0.9 0.9" },

    { "^(swaync-control-center)$",                "1.0 1.0" },
    { "^(swaync-notification-window)$",           "1.0 1.0" },
}
for _, r in ipairs(opacityByClass2) do
    rule({ class = r[1] }, { opacity = r[2] })
end

------------------
---- Floating ----
------------------
rule({ class = "^(org.kde.dolphin)$", title = "^(Progress Dialog — Dolphin)$" }, { float = true })
rule({ class = "^(org.kde.dolphin)$", title = "^(Copying — Dolphin)$" },         { float = true })
rule({ title = "^(About Mozilla Firefox)$" },                                   { float = true })
rule({ class = "^(firefox)$", title = "^(Picture-in-Picture)$" },               { float = true })
rule({ class = "^(firefox)$", title = "^(Library)$" },                          { float = true })
rule({ class = "^(kitty)$",   title = "^(top)$" },                              { float = true })
rule({ class = "^(kitty)$",   title = "^(btop)$" },                             { float = true })
rule({ class = "^(kitty)$",   title = "^(htop)$" },                             { float = true })
rule({ class = "^(kitty)$",   title = "^(nmtui)$" },                            { float = true, size = { 900, 600 }, center = true })

local floatByClass = {
    "^(vlc)$",
    "^(kvantummanager)$",
    "^(qt5ct)$",
    "^(qt6ct)$",
    "^(nwg-look)$",
    "^(org.kde.ark)$",
    "^(org.pulseaudio.pavucontrol)$",
    "^(blueman-manager)$",
    "^(nm-applet)$",
    "^(nm-connection-editor)$",
    "^(org.kde.polkit-kde-authentication-agent-1)$",

    "^(Signal)$",                             -- Signal-Gtk
    "^(com.github.rafostar.Clapper)$",        -- Clapper-Gtk
    "^(app.drey.Warp)$",                      -- Warp-Gtk
    "^(net.davidotek.pupgui2)$",              -- ProtonUp-Qt
    "^(yad)$",                                -- Protontricks-Gtk
    "^(eog)$",                                -- Imageviewer-Gtk
    "^(io.github.alainm23.planify)$",         -- planify-Gtk
    "^(io.gitlab.theevilskeleton.Upscaler)$", -- Upscaler-Gtk
    "^(com.github.unrud.VideoDownloader)$",   -- VideoDownloader-Gkk
    "^(io.gitlab.adhami3310.Impression)$",    -- Impression-Gtk
    "^(io.missioncenter.MissionCenter)$",     -- MissionCenter-Gtk

    "^([Xx]dg-desktop-portal-gtk)$",
    "^(.*dialog.*)$",
}
for _, class in ipairs(floatByClass) do
    rule({ class = class }, { float = true })
end

-- common modals
local floatByTitle = {
    "^(Open)$",
    "^(Authentication Required)$",
    "^(Add Folder to Workspace)$",
    "^(Open File)$",
    "^(Choose Files)$",
    "^(Save As)$",
    "^(Confirm to replace files)$",
    "^(File Operation Progress)$",
    "^(File Upload)(.*)$",
    "^(Choose wallpaper)(.*)$",
    "^(Library)(.*)$",
    "^(.*dialog.*)$",
}
for _, title in ipairs(floatByTitle) do
    rule({ title = title }, { float = true })
end

-----------------
---- Layouts ----
-----------------
hl.config({
    dwindle = {
        -- pseudotile = true, -- Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true, -- You probably want this
    },

    -- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
