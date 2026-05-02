#!/bin/bash
#
# macOS cleanup — remove known-defunct launch agents, leftover app data, and
# stale login items. Safe to re-run; each step checks before acting.
#
# Run manually:
#   ./macos/cleanup.sh

set -u

remove_launchagent() {
  local name="$1"
  local plist="$HOME/Library/LaunchAgents/${name}.plist"
  if [[ -e "$plist" || -L "$plist" ]]; then
    launchctl unload "$plist" 2>/dev/null || true
    rm -f "$plist"
    echo "  removed: $name"
  fi
}

remove_login_item() {
  local name="$1"
  if osascript -e "tell application \"System Events\" to get the name of login item \"$name\"" >/dev/null 2>&1; then
    osascript -e "tell application \"System Events\" to delete login item \"$name\"" >/dev/null 2>&1
    echo "  removed login item: $name"
  fi
}

echo "==> LaunchAgents: defunct / unused"
remove_launchagent "com.bluejeans.app.detector"      # BlueJeans (defunct, Verizon shut down)
remove_launchagent "com.valvesoftware.steamclean"    # Steam — only if you game
remove_launchagent "org.virtualbox.vboxwebsrv"       # VirtualBox (using OrbStack instead)
remove_launchagent "com.spotify.webhelper"           # Spotify web-launcher helper
remove_launchagent "org.hola.vpn"                    # Hola VPN — security risk, never reinstall

echo "==> LaunchAgents: broken symlinks (Intel Homebrew leftovers)"
for plist in "$HOME"/Library/LaunchAgents/*.plist; do
  [[ -L "$plist" && ! -e "$plist" ]] || continue
  rm -f "$plist"
  echo "  removed broken symlink: $(basename "$plist")"
done

echo "==> Homebrew services: stop databases that don't need to run 24/7"
if command -v brew >/dev/null 2>&1; then
  for svc in mysql postgresql; do
    if brew services list 2>/dev/null | awk -v s="$svc" '$1==s && $2=="started" {found=1} END {exit !found}'; then
      brew services stop "$svc" >/dev/null 2>&1 && echo "  stopped: $svc"
    fi
  done
fi

echo "==> Login items: stale / unwanted"
remove_login_item "Flycut"           # uninstalled, stale entry
remove_login_item "Activity Monitor" # no reason to auto-start
remove_login_item "Preview"          # no reason to auto-start

echo "==> Hola VPN: residual files (no behavior change, ~25 MB disk)"
hola_paths=(
  "$HOME/Library/Caches/org.hola.vpn"
  "$HOME/Library/Application Support/Hola"
  "$HOME/Library/HTTPStorages/org.hola.vpn.binarycookies"
)
for p in "${hola_paths[@]}"; do
  if [[ -e "$p" ]]; then
    rm -rf "$p"
    echo "  removed: $p"
  fi
done

echo "Done."
