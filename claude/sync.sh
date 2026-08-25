#!/bin/bash
#
# Sync the tracked, sanitized Claude settings base into ~/.claude/settings.json.
#
# Why this exists (not a symlink):
#   The auto-mode classifier reads its trust-boundary profile from
#   `autoMode.environment` in ~/.claude/settings.json ONLY — and writes it there
#   too. That block carries machine/work-specific data (org, secret names, infra)
#   and must NEVER land in this PUBLIC repo. So ~/.claude/settings.json is a REAL
#   local file, and this script copies the sanitized repo base into it while
#   preserving any local autoMode block.
#
# Run after editing claude/settings.json (the tracked base):  ./claude/sync.sh
set -eu

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
BASE="$DOTFILES/claude/settings.json"
TARGET="$HOME/.claude/settings.json"

mkdir -p "$HOME/.claude"

# Preserve an existing autoMode block from the real target (if any).
auto='{}'
if [ -f "$TARGET" ] && [ ! -L "$TARGET" ]; then
  auto="$(jq 'if has("autoMode") then {autoMode} else {} end' "$TARGET")"
fi

# Replace a legacy symlink with a real file.
[ -L "$TARGET" ] && rm -f "$TARGET"

# Merge: sanitized base + preserved local autoMode -> real local file.
jq -s '.[0] * .[1]' "$BASE" <(printf '%s' "$auto") > "$TARGET.tmp"
mv "$TARGET.tmp" "$TARGET"

if [ "$auto" = '{}' ]; then
  echo "Synced base -> $TARGET (no local autoMode block)"
else
  echo "Synced base -> $TARGET (local autoMode block preserved)"
fi
