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

echo "==> Symlinks: zellij"
mkdir -p ~/.config/zellij
ln -sf "$DOTFILES/zellij/config.kdl" ~/.config/zellij/config.kdl
ln -sfn "$DOTFILES/zellij/layouts" ~/.config/zellij/layouts

echo "==> Symlinks: Claude"
mkdir -p ~/.claude
ln -sf "$DOTFILES/claude/CLAUDE.md" ~/.claude/CLAUDE.md
ln -sf "$DOTFILES/claude/settings.json" ~/.claude/settings.json
ln -sf "$DOTFILES/claude/statusline.sh" ~/.claude/statusline.sh
mkdir -p ~/.claude/skills
ln -sfn "$DOTFILES/claude/skills/ai-daily-news" ~/.claude/skills/ai-daily-news
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
# Vault path is machine-specific — set it in ~/.obsidian_vault (see obsidian/obsidian_vault.example)
if [[ -f ~/.obsidian_vault ]]; then
  OBSIDIAN_VAULT="$(cat ~/.obsidian_vault)"
  if [[ -d "$OBSIDIAN_VAULT/.obsidian" ]]; then
    # Only symlink if vault has its own .obsidian/ managed by dotfiles (not a self-managed git repo)
    if [[ ! -f "$OBSIDIAN_VAULT/.git" && ! -d "$OBSIDIAN_VAULT/.git" ]]; then
      for f in app.json appearance.json core-plugins.json graph.json; do
        ln -sf "$DOTFILES/obsidian/.obsidian/$f" "$OBSIDIAN_VAULT/.obsidian/$f"
      done
    else
      echo "    Vault is a git repo (self-managing config) — skipping symlinks"
    fi
  else
    echo "    Obsidian vault not found at $OBSIDIAN_VAULT — skipping"
  fi
else
  echo "    ~/.obsidian_vault not set — skipping (see obsidian/obsidian_vault.example)"
fi

echo "==> gh: aliases"
gh alias set co 'pr checkout' --clobber >/dev/null

echo ""
echo "Done! Don't forget to:"
echo "  - Copy brew/Brewfile.personal.example to ~/.Brewfile.personal and customize"
echo "  - Copy zsh/.zshrc.personal.example to ~/.zshrc.personal and customize"
echo "  - Review ~/.claude/settings.local.json for machine-specific Claude settings"
