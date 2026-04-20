#!/bin/bash
DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
ICON="$DOTFILES/vscode/default_dark.icns"

if ! command -v fileicon &>/dev/null; then
  echo "fileicon not found — run: brew install fileicon"
  exit 1
fi

fileicon set "/Applications/Visual Studio Code.app" "$ICON"
killall Dock
