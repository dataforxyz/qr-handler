#!/usr/bin/env bash
set -euo pipefail
rm -fv "$HOME/.local/bin/qr-handler" \
       "$HOME/.local/share/applications/qr-handler.desktop" \
       "$HOME/.local/share/icons/hicolor/256x256/apps/qr-handler.png"
command -v update-desktop-database >/dev/null && \
  update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
command -v gtk-update-icon-cache >/dev/null && \
  gtk-update-icon-cache -q "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
echo "Uninstalled qr-handler."
