# dotfiles

Personal configuration files, managed via symlinks.

## Contents

| File / Directory | Symlink |
|---|---|
| `zsh/.zshrc` | `~/.zshrc` |
| `zsh/.zshrc.personal.example` | `~/.zshrc.personal` (copy & customize, not symlinked) |
| `zsh/.zshrc.work.example` | `~/.zshrc.work` (copy & customize, not symlinked) |
| `git/.gitconfig` | `~/.gitconfig` |
| `git/.gitignore_global` | `~/.gitignore_global` |
| `git/hooks/pre-push` | `.git/hooks/pre-push` (shows diff summary before push) |
| `brew/Brewfile` | common packages — run `brew bundle` to install |
| `brew/Brewfile.work.example` | `~/.Brewfile.work` (copy & customize, not symlinked) |
| `brew/Brewfile.personal.example` | `~/.Brewfile.personal` (copy & customize, not symlinked) |
| `npm/packages` | global npm packages — installed by `setup.sh` |
| `setup.sh` | one-shot setup script for new machines |
| `ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| `sublime/Preferences.sublime-settings` | `~/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings` |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/default_dark.icns` | `/Applications/Visual Studio Code.app/Contents/Resources/Code.icns` |
| `cursor/rules/` | `~/.cursor/rules` |
| `zellij/config.kdl` | `~/.config/zellij/config.kdl` |
| `claude/statusline.sh` | `~/.claude/statusline.sh` |

## Setup

Clone the repo and run the setup script:

```bash
git clone git@github.com:mjnchen/dotfiles.git ~/Projects/personal/dotfiles
cd ~/Projects/personal/dotfiles

# Copy and customize machine-specific files first
cp brew/Brewfile.personal.example ~/.Brewfile.personal  # or Brewfile.work.example
cp zsh/.zshrc.personal.example ~/.zshrc.personal        # then customize

# Run setup
./setup.sh
```

### Claude Code statusline (manual)

The statusline script is symlinked by `setup.sh`, but you also need to add the following to `~/.claude/settings.json` manually:

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/statusline.sh"
}
```

### VS Code icon (optional, manual)

```bash
cp $(pwd)/vscode/default_dark.icns "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"
touch "/Applications/Visual Studio Code.app"
sudo rm -rf /Library/Caches/com.apple.iconservices.store
killall Dock
```
