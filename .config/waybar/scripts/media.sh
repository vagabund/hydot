#!/usr/bin/env bash
# MPRIS status for waybar's custom/media, via playerctl --follow (event-driven).
# Replaces the built-in mpris module, which segfaults in waybar 0.15.

IGNORE="firefox,chromium"
MAX=150

while true; do
    playerctl --ignore-player="$IGNORE" --follow metadata \
        --format $'{{status}}\t{{artist}}\t{{title}}\t{{playerName}}' 2>/dev/null |
    while IFS=$'\t' read -r status artist title player; do
        if [[ -z "$title" || "$status" == "Stopped" ]]; then
            echo '{"text": ""}'
            continue
        fi
        case "$status" in
            Playing) icon=$'\uf04b' ;;  # FontAwesome play
            Paused)  icon=$'\uf04c' ;;  # FontAwesome pause
            *)       icon="" ;;
        esac
        track="${artist:+$artist - }$title"
        text="$icon $track"
        (( ${#text} > MAX )) && text="${text:0:MAX-1}…"
        jq -cn --arg text "$text" --arg tip "$player: $track" --arg class "${status,,}" \
            '{text: $text, tooltip: $tip, class: $class}'
    done
    # playerctl exited (e.g. D-Bus hiccup) — clear and retry
    echo '{"text": ""}'
    sleep 2
done
