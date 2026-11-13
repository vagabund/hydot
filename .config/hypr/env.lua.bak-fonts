local home = os.getenv("HOME")

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("GDK_BACKEND", "wayland")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
-- hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "qt6ct")
hl.env("QT_PLUGIN_PATH", "/usr/lib/qt6/plugins")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_SCALE", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
-- В старом конфиге SDL_VIDEODRIVER задавался дважды (wayland, затем x11) —
-- действовало последнее значение
-- hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("SDL_VIDEODRIVER", "x11")

local runtime = os.getenv("XDG_RUNTIME_DIR")
if runtime then
    hl.env("XDG_RUNTIME_DIR", runtime)
end
hl.env("XDG_CONFIG_HOME", home .. "/.config")
hl.env("XDG_CACHE_HOME", home .. "/.cache")
hl.env("XDG_DATA_HOME", home .. "/.local/share")
hl.env("XDG_STATE_HOME", home .. "/.local/state")

-- в hyprlang "#" начинал комментарий, поэтому значение было пустым
hl.env("BUTTON_LAYOUT", "")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    },
})
