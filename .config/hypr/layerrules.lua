local function layer(namespace, effects)
    effects.match = { namespace = namespace }
    hl.layer_rule(effects)
end

-- rofi
layer("^(.*rofi.*)$", { ignore_alpha = 0.35, blur = true })

-- notifications (generic)
layer("^(.*notifications.*)$", { blur = true, ignore_alpha = 0 })

-- swaync notification window
layer("^(.*swaync-notification-window.*)$", { blur = true, ignore_alpha = 0.1 })

-- swaync control center
layer("^(.*swaync-control-center.*)$", { blur = true, ignore_alpha = 0 })

-- swaync misc
layer("^(.*swaync-client.*)$",       { blur = true })
layer("^(.*swaync-notification.*)$", { blur = true })

-- other layers
layer("^(.*logout_dialog.*)$", { blur = true })
layer("^(.*waybar.*)$",        { blur = true, blur_popups = true, ignore_alpha = 0.05 })
layer("^(.*dunst.*)$",         { blur = true })
