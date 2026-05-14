#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

echo "==> Homebrew: common packages"
brew bundle --file="$DOTFILES/brew/Brewfile"

echo "==> Homebrew: machine-specific packages"
if [[ -f ~/.Brewfile.personal ]]; then
  brew bundle --file=~/.Brewfile.personal
elif [[ -f ~/.Brewfile.work ]]; then
  brew bundle --file=~/.Brewfile.work
else
  echo "    No ~/.Brewfile.personal or ~/.Brewfile.work found — skipping"
fi

echo "==> npm: global packages"
xargs npm install -g < "$DOTFILES/npm/packages"

echo "==> Symlinks: zsh"
ln -sf "$DOTFILES/zsh/.zshrc" ~/.zshrc

echo "==> Symlinks: git"
ln -sf "$DOTFILES/git/.gitconfig" ~/.gitconfig
ln -sf "$DOTFILES/git/.gitignore_global" ~/.gitignore_global

echo "==> Symlinks: Starship"
mkdir -p ~/.config
ln -sf "$DOTFILES/starship/starship.toml" ~/.config/starship.toml

echo "==> Symlinks: tmux"
ln -sf "$DOTFILES/tmux/.tmux.conf" ~/.tmux.conf

echo "==> Symlinks: Claude"
mkdir -p ~/.claude
ln -sf "$DOTFILES/claude/statusline.sh" ~/.claude/statusline.sh
CLAUDE_PROJECT_DIR="${HOME}/.claude/projects/-Users-mchen-Projects-personal-dotfiles"
mkdir -p "$CLAUDE_PROJECT_DIR"
ln -sf "$DOTFILES/claude/memory" "$CLAUDE_PROJECT_DIR/memory"

echo "==> Symlinks: Ghostty"
ln -sf "$DOTFILES/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

echo "==> Symlinks: VS Code"
ln -sf "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

echo "==> VS Code: custom icon (run vscode/apply-icon.sh manually to apply)"
chmod +x "$DOTFILES/vscode/apply-icon.sh"

echo "==> Symlinks: Cursor"
ln -sf "$DOTFILES/cursor/rules" ~/.cursor/rules
ln -sf "$DOTFILES/cursor/settings.json" "$HOME/Library/Application Support/Cursor/User/settings.json"

echo "==> Symlinks: Obsidian"
OBSIDIAN_VAULT="$HOME/Documents/Obsidian Vault"
if [[ -d "$OBSIDIAN_VAULT" ]]; then
  mkdir -p "$OBSIDIAN_VAULT/.obsidian"
  for f in app.json appearance.json core-plugins.json graph.json; do
    ln -sf "$DOTFILES/obsidian/.obsidian/$f" "$OBSIDIAN_VAULT/.obsidian/$f"
  done
else
  echo "    Obsidian vault not found at $OBSIDIAN_VAULT — skipping"
fi

echo "==> gh: aliases"
gh alias set co 'pr checkout' --clobber >/dev/null

echo ""
echo "Done! Don't forget to:"
echo "  - Copy brew/Brewfile.personal.example to ~/.Brewfile.personal and customize"
echo "  - Copy zsh/.zshrc.personal.example to ~/.zshrc.personal and customize"
echo "  - Add the Claude Code statusLine config to ~/.claude/settings.json (see README)"
