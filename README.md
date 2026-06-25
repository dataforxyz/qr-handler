# QR Handler

A small, keyboard-driven QR-code menu for **Wayland / Hyprland** desktops
(built on [Omarchy](https://omarchy.org), but works on any Wayland setup with
the listed tools). Launch it from your app launcher and:

- 📤 **Show your Wi-Fi login QR** — renders the network you're on as a QR code
  with the SSID and password printed underneath, and copies the password to your
  clipboard.
- 📷 **Log in by scanning a QR with your camera** — live preview, auto-connects.
- 🖥️ **Log in by scanning a QR already on your screen** — rubber-band select it.
- 🔎 **Read any QR (camera or on-screen), no action** — decodes it, copies it,
  and tells you what it is (Wi-Fi, URL, contact, OTP secret, …) with a suggestion.
- ✍️ **Make a QR from a typed SSID/password** — for sharing any network.

Wi-Fi connect/share uses **iwd** (`iwctl`). Everything else is generic.

## Screenshot

A generated Wi-Fi QR with the credentials captioned below it:

```
┌───────────────────┐
│   ▄▄▄▄  ▄  ▄▄▄▄    │
│   █  █ ▄▄█ █  █    │   (QR code)
│   ▀▀▀▀ █▀█ ▀▀▀▀    │
└───────────────────┘
  Network:   MyWifi
  Password:  hunter2
```

## Install

```bash
git clone https://github.com/dataforxyz/qr-handler
cd qr-handler
./install.sh
```

This copies `qr-handler` to `~/.local/bin/` and a launcher entry to
`~/.local/share/applications/`. Search **"qr"** in your launcher (e.g. walker via
Super+Space) to run it. Uninstall with `./uninstall.sh`.

## Dependencies

Arch package names:

```bash
sudo pacman -S --needed qrencode zbar grim slurp imv imagemagick wl-clipboard libnotify
```

| Tool | Used for |
|------|----------|
| `qrencode` | generating QR codes |
| `zbar` (`zbarimg`, `zbarcam`) | decoding from screen / camera |
| `grim` + `slurp` | capturing an on-screen QR region |
| `imv` | displaying generated QR codes |
| `imagemagick` (`magick`) | captioning the QR with SSID/password |
| `wl-clipboard` (`wl-copy`) | copying passwords / decoded text |
| `libnotify` (`notify-send`) | success / failure notifications |
| `iwd` (`iwctl`) | Wi-Fi connect & reading the saved passphrase (Wi-Fi features only) |

The caption font is whatever `fc-match` resolves for `JetBrainsMono:bold`,
falling back to your system monospace.

## Notes

- **Reading your current Wi-Fi password** needs root (iwd stores it under
  `/var/lib/iwd/`), so "Show my Wi-Fi login QR" triggers a `pkexec` prompt. If
  the network was saved hashed-only, the password can't be recovered and the tool
  falls back to manual entry.
- Camera defaults to `/dev/video0`. Edit the script if your webcam is elsewhere.
- Designed for installs where `~/.local/bin` is on `PATH`.

## License

MIT — see [LICENSE](LICENSE).
