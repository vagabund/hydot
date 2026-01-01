set -euo pipefail
pick_terminal() {
  if [[ -n "${TERMINAL:-}" ]] && command -v "$TERMINAL" >/dev/null 2>&1; then
    echo "$TERMINAL"
    return 0
  fi

  for t in foot kitty alacritty wezterm ghostty konsole gnome-terminal xterm; do
    if command -v "$t" >/dev/null 2>&1; then
      echo "$t"
      return 0
    fi
  done

  echo "Terminal not found" >&2
  exit 1
}

TERM_BIN="$(pick_terminal)"

read -r -d '' INNER <<'EOS' || true
set -euo pipefail

echo "==> [1/3] pacman update"
sudo -v
sudo pacman -Syy --noconfirm archlinux-keyring || true
sudo pacman -Syyu

echo
echo "==> [2/3] yay update"
if command -v yay >/dev/null 2>&1; then
  yay -Syu
else
  echo "!!! yay not found"
fi

echo
echo "==> [3/3] flatpak update"
if command -v flatpak >/dev/null 2>&1; then
  flatpak update -y
else
  echo "!!! flatpak not found"
fi

echo
echo "Ready."
read -n 1 -s -r -p "Press any button to close"
echo
EOS

case "$(basename "$TERM_BIN")" in
  foot)          exec foot -e bash -lc "$INNER" ;;
  kitty)         exec kitty bash -lc "$INNER" ;;
  alacritty)     exec alacritty -e bash -lc "$INNER" ;;
  wezterm)       exec wezterm start -- bash -lc "$INNER" ;;
  konsole)       exec konsole -e bash -lc "$INNER" ;;
  gnome-terminal) exec gnome-terminal -- bash -lc "$INNER" ;;
  xterm)         exec xterm -e bash -lc "$INNER" ;;
  *)             exec "$TERM_BIN" -e bash -lc "$INNER" ;;
esac
