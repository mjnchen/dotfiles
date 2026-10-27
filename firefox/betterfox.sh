#!/bin/bash
#
# Install (or update) Betterfox into the default Firefox profile.
# Downloads user.js from the latest Betterfox release, appends
# firefox/user-overrides.js (later prefs win), and writes it to the profile.
#
# Run by setup.sh. Re-run any time to pick up a new Betterfox release
# or changed overrides:  ./firefox/betterfox.sh
# Prefs apply on the next Firefox restart.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
FIREFOX_DIR="$HOME/Library/Application Support/Firefox"

if [[ ! -f "$FIREFOX_DIR/profiles.ini" ]]; then
  echo "    No Firefox profile yet — launch Firefox once, then re-run this script"
  exit 0
fi

# installs.ini names the profile each Firefox install actually uses;
# fall back to the Default=1 profile in profiles.ini.
PROFILE="$(awk -F= '$1=="Default"{print $2; exit}' "$FIREFOX_DIR/installs.ini" 2>/dev/null || true)"
if [[ -z "$PROFILE" ]]; then
  PROFILE="$(awk -F= '/^\[/{p=""} $1=="Path"{p=$2} $1=="Default" && $2=="1" && p{print p; exit}' "$FIREFOX_DIR/profiles.ini")"
fi
PROFILE_DIR="$FIREFOX_DIR/$PROFILE"
if [[ -z "$PROFILE" || ! -d "$PROFILE_DIR" ]]; then
  echo "    Could not find the default Firefox profile — skipping"
  exit 0
fi

TAG="$(curl -fsSL https://api.github.com/repos/yokoffing/Betterfox/releases/latest \
  | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')"
if [[ -z "$TAG" ]]; then
  echo "    Could not look up the latest Betterfox release — skipping"
  exit 0
fi

TMP="$(mktemp)"
trap 'rm -f "$TMP"' EXIT
curl -fsSL "https://raw.githubusercontent.com/yokoffing/Betterfox/$TAG/user.js" -o "$TMP"
grep -q "Betterfox" "$TMP"  # sanity check before touching the profile
{
  echo ""
  echo "// ---- firefox/user-overrides.js from dotfiles ----"
  cat "$DOTFILES/firefox/user-overrides.js"
} >> "$TMP"

# Keep a hand-written user.js once, rather than silently replacing it.
if [[ -f "$PROFILE_DIR/user.js" ]] && ! grep -q "Betterfox" "$PROFILE_DIR/user.js"; then
  cp "$PROFILE_DIR/user.js" "$PROFILE_DIR/user.js.bak"
  echo "    Backed up existing user.js to user.js.bak"
fi
cp "$TMP" "$PROFILE_DIR/user.js"
echo "    Betterfox $TAG installed to $PROFILE (restart Firefox to apply)"
