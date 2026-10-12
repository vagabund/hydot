hl.config({
    general = {
        gaps_in  = 3,
        gaps_out = 5,

        border_size = 0,

        col = {
            active_border   = { colors = { "rgba(ffffff60)", "rgba(ffffff10)" }, angle = 45 },
            inactive_border = "rgba(ffffff12)",
        },

        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 16,
        rounding_power = 4,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        dim_inactive     = true,
        dim_strength     = 0.07,
        dim_special      = 0.35,

        shadow = {
            enabled        = true,
            range          = 28,
            render_power   = 3,
            color          = "rgba(00000055)",
            color_inactive = "rgba(00000030)",
        },

        blur = {
            enabled            = true,
            size               = 10,
            passes             = 5,
            new_optimizations  = true,
            ignore_opacity     = true,
            xray               = false,
            noise              = 0.035,
            contrast           = 1.15,
            brightness         = 1.08,
            popups             = true,
            popups_ignorealpha = 0.2,
            special            = true,

            vibrancy          = 0.3,
            vibrancy_darkness = 0.4,
        },
    },
})
