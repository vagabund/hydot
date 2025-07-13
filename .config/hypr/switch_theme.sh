
current=$(gsettings get org.gnome.desktop.interface color-scheme)
WALL_DIR=$(xdg-user-dir PICTURES)
WALL_LIGHT="$WALL_DIR/light.jpg"
WALL_DARK="$WALL_DIR/dark.jpg"
HYPRPAPER_CFG=~/.config/hypr/hyprpaper.conf
ROFI_CFG=~/.config/rofi/config.rasi
KVANTUM_CFG=~/.config/Kvantum/kvantum.kvconfig
PYCHARM_CFG=~/.config/JetBrains/PyCharm*/options/colors.scheme.xml
CURRENT_WALL="/tmp/wallpaper.jpg"
MONITOR=$(hyprctl monitors | awk '/Monitor/ {print $2; exit}')

grep -E '^preload' "$HYPRPAPER_CFG" > "$HYPRPAPER_CFG.tmp" 2>/dev/null || true
grep -qxF "preload = $WALL_LIGHT" "$HYPRPAPER_CFG.tmp" || echo "preload = $WALL_LIGHT" >> "$HYPRPAPER_CFG.tmp"
grep -qxF "preload = $WALL_DARK"  "$HYPRPAPER_CFG.tmp" || echo "preload = $WALL_DARK" >> "$HYPRPAPER_CFG.tmp"

if [[ "$current" == *"prefer-light"* ]]; then
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
  kitty +kitten themes Neutron
  sed -i 's|<option name="global_color_scheme" value=".*"|<option name="global_color_scheme" value="Dark"|' "$PYCHARM_CFG"
  kvantummanager --set KvArcDark# >/dev/null
  echo "wallpaper = $MONITOR,$WALL_DARK" >> "$HYPRPAPER_CFG.tmp"
  mv "$HYPRPAPER_CFG.tmp" "$HYPRPAPER_CFG"
  sed -i 's|@theme.*|@theme "~/.local/share/rofi/themes/spotlight-dark.rasi"|' "$ROFI_CFG"
  ln -sf "$WALL_DARK" "$CURRENT_WALL"
  ln -sf ~/.config/swaync/style-dark.css ~/.config/swaync/style.css
  if [[ "$LANG" == "ru_RU.UTF-8" ]]; then
   ln -sf ~/.config/swaync/config-ru.json ~/.config/swaync/config.json
  else
   ln -sf ~/.config/swaync/config-default.json ~/.config/swaync/config.json 
  fi
  killall hyprpaper
  hyprpaper &
  killall swaync
  swaync &
else
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
  kitty +kitten themes Spring
  sed -i 's|<option name="global_color_scheme" value=".*"|<option name="global_color_scheme" value="Light"|' "$PYCHARM_CFG"
  kvantummanager --set KvArc# >/dev/null
  sed -i 's|^theme=.*|theme=KvArc#' "$KVANTUM_CFG"
  echo "wallpaper = $MONITOR,$WALL_LIGHT" >> "$HYPRPAPER_CFG.tmp"
  mv "$HYPRPAPER_CFG.tmp" "$HYPRPAPER_CFG"
  sed -i 's|@theme.*|@theme "~/.local/share/rofi/themes/spotlight.rasi"|' "$ROFI_CFG"
  ln -sf "$WALL_LIGHT" "$CURRENT_WALL"
  ln -sf ~/.config/swaync/style-light.css ~/.config/swaync/style.css
  if [[ "$LANG" == "ru_RU.UTF-8" ]]; then
   ln -sf ~/.config/swaync/config-ru.json ~/.config/swaync/config.json
  else
   ln -sf ~/.config/swaync/config-default.json ~/.config/swaync/config.json 
  fi
  killall hyprpaper
  hyprpaper &
  killall swaync
  swaync &
fi
