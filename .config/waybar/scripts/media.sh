artist=$(playerctl metadata xesam:artist 2>/dev/null)
title=$(playerctl metadata xesam:title 2>/dev/null)

if [[ -n "$artist" && -n "$title" ]]; then
    echo "{\"text\": \"$artist - $title\", \"tooltip\": \"$artist - $title\"}"
else
    echo ""
fi
