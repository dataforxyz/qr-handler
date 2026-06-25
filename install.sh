#!/usr/bin/env bash
# Install qr-handler into ~/.local for the current user.
set -euo pipefail
SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BIN_DIR="$HOME/.local/bin"
APP_DIR="$HOME/.local/share/applications"
mkdir -p "$BIN_DIR" "$APP_DIR"

install -m 755 "$SRC/qr-handler" "$BIN_DIR/qr-handler"
# Write the .desktop with an absolute Exec so launchers always find it.
sed "s|^Exec=.*|Exec=$BIN_DIR/qr-handler|" "$SRC/qr-handler.desktop" \
  > "$APP_DIR/qr-handler.desktop"
command -v update-desktop-database >/dev/null && \
  update-desktop-database "$APP_DIR" 2>/dev/null || true

echo "Installed:"
echo "  $BIN_DIR/qr-handler"
echo "  $APP_DIR/qr-handler.desktop"

# Friendly dependency check (Arch package names in parentheses).
miss=()
for c in qrencode zbarimg zbarcam grim slurp imv magick wl-copy notify-send; do
  command -v "$c" >/dev/null || miss+=("$c")
done
if ((${#miss[@]})); then
  echo
  echo "Missing optional tools: ${miss[*]}"
  echo "On Arch:  sudo pacman -S --needed qrencode zbar grim slurp imv imagemagick wl-clipboard libnotify"
  echo "Wi-Fi connect uses iwd (iwctl); ensure it is installed/running for the login features."
fi
echo
echo "Done. Launch it from your app launcher (search \"qr\"), or run: qr-handler"
