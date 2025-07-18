#!/bin/bash
current=$(gsettings get org.gnome.desktop.interface color-scheme)

if [[ "$current" == *"prefer-dark"* ]]; then
  echo "🌙"
else
  echo "☀️"
fi
