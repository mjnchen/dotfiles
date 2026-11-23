#!/bin/bash
DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"

install_extensions() {
  local cmd=$1
  local file=$2
  while IFS= read -r ext; do
    [[ -z "$ext" ]] && continue
    $cmd --install-extension "$ext" --force
  done < "$file"
}

if command -v cursor &>/dev/null; then
  echo "Installing Cursor extensions..."
  install_extensions cursor "$DOTFILES/vscode/extensions.cursor.txt"
fi

# `code` on PATH is often shadowed by Cursor's CLI, so resolve VS Code's own binary.
VSCODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
if [[ -x "$VSCODE_BIN" ]]; then
  echo "Installing VS Code extensions..."
  install_extensions "$VSCODE_BIN" "$DOTFILES/vscode/extensions.vscode.txt"
fi
