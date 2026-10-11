#!/bin/bash
current=$(gsettings get org.gnome.desktop.interface color-scheme)
WALL_DIR=$(xdg-user-dir PICTURES)
WALL_LIGHT="$WALL_DIR/light.jpg"
WALL_DARK="$WALL_DIR/dark.jpg"
HYPRPAPER_CFG=~/.config/hypr/hyprpaper.conf
ROFI_CFG=~/.config/rofi/config.rasi
KVANTUM_CFG=~/.config/Kvantum/kvantum.kvconfig
CURRENT_WALL="$HOME/.cache/wallpaper.jpg"
MONITOR=$(hyprctl monitors | awk '/Monitor/ {print $2; exit}')


if [[ "$current" == *"prefer-light"* ]]; then
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  kitty +kitten themes Neutron
  kvantummanager --set KvArcDark# >/dev/null
  sed -i 's/^style=.*/style=libAdwaita-Dark/' ~/.config/qt6ct/qt6ct.conf
  sed -i 's/^icon_theme=.*/icon_theme=breeze-dark/' ~/.config/qt6ct/qt6ct.conf
  sed -i 's/^custom_palette=.*/custom_palette=false/' ~/.config/qt6ct/qt6ct.conf
  hyprctl hyprpaper wallpaper "$MONITOR,$WALL_DARK,cover"
  sed -i 's|@theme.*|@theme "~/.local/share/rofi/themes/spotlight-dark.rasi"|' "$ROFI_CFG"
  ln -sf "$WALL_DARK" "$CURRENT_WALL"
  cd ~/.config/swaync
  ln -sf style-dark.css style.css
  ln -sf menu-dark.css ~/.config/waybar/menu.css
  pkill -SIGUSR2 -x waybar
  if [[ "$LANG" == "ru_RU.UTF-8" ]]; then
   ln -sf config-ru.json config.json
  else
   ln -sf config-default.json config.json 
  fi
  swaync-client -R -rs
  cat > "$HYPRPAPER_CFG" <<EOF
splash = false
wallpaper {
    monitor = $MONITOR
    path = $WALL_DARK
    fit_mode = cover
}
EOF
else
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  kitty +kitten themes Spring
  kvantummanager --set KvArc# >/dev/null
  sed -i 's|^theme=.*|theme=KvArc#|' "$KVANTUM_CFG"
  sed -i 's/^style=.*/style=libAdwaita/' ~/.config/qt6ct/qt6ct.conf
  sed -i 's/^icon_theme=.*/icon_theme=breeze/' ~/.config/qt6ct/qt6ct.conf
  sed -i 's/^custom_palette=.*/custom_palette=false/' ~/.config/qt6ct/qt6ct.conf
  hyprctl hyprpaper wallpaper "$MONITOR,$WALL_LIGHT,cover"
  sed -i 's|@theme.*|@theme "~/.local/share/rofi/themes/spotlight.rasi"|' "$ROFI_CFG"
  ln -sf "$WALL_LIGHT" "$CURRENT_WALL"
  cd ~/.config/swaync
  ln -sf style-light.css style.css
  ln -sf menu-light.css ~/.config/waybar/menu.css
  pkill -SIGUSR2 -x waybar
  if [[ "$LANG" == "ru_RU.UTF-8" ]]; then
   ln -sf config-ru.json config.json
  else
   ln -sf config-default.json config.json 
  fi
  swaync-client -R -rs
  cat > "$HYPRPAPER_CFG" <<EOF
splash = false
wallpaper {
    monitor = $MONITOR
    path = $WALL_LIGHT
    fit_mode = cover
}
EOF
fi
