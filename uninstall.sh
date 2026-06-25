#!/usr/bin/env bash
set -euo pipefail
rm -fv "$HOME/.local/bin/qr-handler" "$HOME/.local/share/applications/qr-handler.desktop"
command -v update-desktop-database >/dev/null && \
  update-desktop-database "$HOME/.local/share/applications" 2>/dev/null || true
echo "Uninstalled qr-handler."
