#!/bin/bash
DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
ICON="$DOTFILES/vscode/default_dark.icns"
TARGET="/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"

cp "$ICON" "$TARGET"
touch "/Applications/Visual Studio Code.app"
killall Dock
