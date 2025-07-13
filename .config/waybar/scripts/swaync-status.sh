
if swaync-client -sw | grep -q "true"; then
  echo '{"text": "", "class": "swaync-active"}'
else
  echo '{"text": "", "class": "swaync-empty"}'
fi
