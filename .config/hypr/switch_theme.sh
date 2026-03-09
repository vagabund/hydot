#!/bin/bash
current=$(gsettings get org.gnome.desktop.interface color-scheme)
WALL_DIR=$(xdg-user-dir PICTURES)
WALL_LIGHT="$WALL_DIR/light.jpg"
WALL_DARK="$WALL_DIR/dark.jpg"
HYPRPAPER_CFG=~/.config/hypr/hyprpaper.conf
ROFI_CFG=~/.config/rofi/config.rasi
KVANTUM_CFG=~/.config/Kvantum/kvantum.kvconfig
PYCHARM_DIR=$(find ~/.config/JetBrains/ -type d -name "PyCharmCE*" | head -n 1)
PYCHARM_CFG=$(find ~/.config/JetBrains/ -type f -path "*/PyCharm*/options/colors.scheme.xml" | head -n1)
PYCHARM_LAF_CFG=$PYCHARM_DIR/options/laf.xml
CURRENT_WALL="$HOME/.cache/wallpaper.jpg"
MONITOR=$(hyprctl monitors | awk '/Monitor/ {print $2; exit}')

grep -E '^preload' "$HYPRPAPER_CFG" > "$HYPRPAPER_CFG.tmp" 2>/dev/null || true
grep -qxF "preload = $WALL_LIGHT" "$HYPRPAPER_CFG.tmp" || echo "preload = $WALL_LIGHT" >> "$HYPRPAPER_CFG.tmp"
grep -qxF "preload = $WALL_DARK"  "$HYPRPAPER_CFG.tmp" || echo "preload = $WALL_DARK" >> "$HYPRPAPER_CFG.tmp"

if [[ "$current" == *"prefer-light"* ]]; then
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  kitty +kitten themes Neutron
  kvantummanager --set KvArcDark# >/dev/null
  hyprctl hyprpaper wallpaper "DP-2,$WALL_DARK,cover"
  sed -i 's|@theme.*|@theme "~/.local/share/rofi/themes/spotlight-dark.rasi"|' "$ROFI_CFG"
  ln -sf "$WALL_DARK" "$CURRENT_WALL"
  cd ~/.config/swaync
  ln -sf style-dark.css style.css
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
  sed -i 's|^theme=.*|theme=KvArc#' "$KVANTUM_CFG"
  hyprctl hyprpaper preload "$WALL_LIGHT"
  hyprctl hyprpaper wallpaper "$MONITOR,$WALL_LIGHT"
  sed -i 's|@theme.*|@theme "~/.local/share/rofi/themes/spotlight.rasi"|' "$ROFI_CFG"
  ln -sf "$WALL_LIGHT" "$CURRENT_WALL"
  cd ~/.config/swaync
  ln -sf style-light.css style.css
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
