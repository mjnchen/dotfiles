# dotfiles

Personal configuration files, managed via symlinks.

## Contents

| File / Directory | Symlink |
|---|---|
| `zsh/.zshrc` | `~/.zshrc` |
| `zsh/.zshrc.personal.example` | `~/.zshrc.personal` (copy & customize, not symlinked) |
| `git/.gitconfig` | `~/.gitconfig` |
| `git/.gitignore_global` | `~/.gitignore_global` |
| `Brewfile` | run `brew bundle` to install |
| `ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| `sublime/Preferences.sublime-settings` | `~/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings` |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/default_dark.icns` | `/Applications/Visual Studio Code.app/Contents/Resources/Code.icns` |
| `cursor/rules/` | `~/.cursor/rules` |

## Setup

Clone the repo and create symlinks:

```bash
git clone git@github.com:mjnchen/dotfiles.git ~/Projects/personal/dotfiles
cd ~/Projects/personal/dotfiles

# zsh
ln -sf $(pwd)/zsh/.zshrc ~/.zshrc
cp $(pwd)/zsh/.zshrc.personal.example ~/.zshrc.personal  # then customize

# git
ln -sf $(pwd)/git/.gitconfig ~/.gitconfig
ln -sf $(pwd)/git/.gitignore_global ~/.gitignore_global

# Homebrew packages
brew bundle

# Ghostty
ln -sf $(pwd)/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config

# Sublime Text
ln -sf $(pwd)/sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings

# VS Code
ln -sf $(pwd)/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# VS Code icon
cp $(pwd)/vscode/default_dark.icns "/Applications/Visual Studio Code.app/Contents/Resources/Code.icns"
touch "/Applications/Visual Studio Code.app"
sudo rm -rf /Library/Caches/com.apple.iconservices.store
killall Dock

# Cursor global rules
ln -sf $(pwd)/cursor/rules ~/.cursor/rules
```
