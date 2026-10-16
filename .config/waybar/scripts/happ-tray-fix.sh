#!/usr/bin/env bash
# Waybar 0.15 drops the custom tray icon (tray.icons) when an app sends NewIcon.
# Happ does this on connect/disconnect, so point happ-tray-symbolic at the
# matching monochrome icon and reload waybar to re-apply it.
# After updating to waybar 0.16 (fixed upstream) only the state switch is needed.

ICONS=$HOME/.local/share/icons/happ-tray
LINK=$HOME/.local/share/icons/hicolor/scalable/apps/happ-tray-symbolic.svg

# Happ's connected icon has green chevrons; count green pixels in its pixmap
happ_state() {
    busctl --user --json=short get-property "$1" /StatusNotifierItem org.kde.StatusNotifierItem IconPixmap 2>/dev/null |
        python3 -I -c '
import json, sys
w, h, b = json.load(sys.stdin)["data"][0]
green = sum(1 for i in range(0, len(b), 4) if b[i] and b[i+2] > b[i+1] + 60 and b[i+2] > b[i+3] + 60)
print("connected" if green > 5 else "disconnected")' 2>/dev/null || echo disconnected
}

apply() {
    local state
    state=$(happ_state "$1")
    [[ $(readlink "$LINK") == "$ICONS/$state.svg" ]] || ln -sfn "$ICONS/$state.svg" "$LINK"
    pkill -x -SIGUSR2 waybar
}

# Happ may already be running (e.g. script restarted while connected)
for item in $(busctl --user get-property org.kde.StatusNotifierWatcher /StatusNotifierWatcher \
        org.kde.StatusNotifierWatcher RegisteredStatusNotifierItems 2>/dev/null | grep -oE '":[0-9.]+/StatusNotifierItem"' | tr -d '"'); do
    svc=${item%%/*}
    [[ $(busctl --user get-property "$svc" /StatusNotifierItem org.kde.StatusNotifierItem Id 2>/dev/null) == 's "Happ"' ]] && apply "$svc"
done

dbus-monitor --session "type='signal',interface='org.kde.StatusNotifierItem',member='NewIcon'" 2>/dev/null |
while read -r line; do
    [[ $line =~ sender=([^ ]+) ]] || continue
    sender=${BASH_REMATCH[1]}
    id=$(busctl --user get-property "$sender" /StatusNotifierItem org.kde.StatusNotifierItem Id 2>/dev/null)
    [[ $id == 's "Happ"' ]] || continue
    # Happ may send several NewIcon in a row; let them settle first
    sleep 1
    while read -r -t 0.5 _; do :; done
    apply "$sender"
done
