# dotfiles

Personal configuration files, managed via symlinks.

## Contents

| File / Directory | Symlink |
|---|---|
| `.zshrc` | `~/.zshrc` |
| `.gitconfig` | `~/.gitconfig` |
| `ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| `sublime/Preferences.sublime-settings` | `~/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings` |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `cursor/rules/` | `~/.cursor/rules` |

## Setup

Clone the repo and create symlinks:

```bash
git clone git@github.com:mjnchen/dotfiles.git ~/Projects/personal/dotfiles
cd ~/Projects/personal/dotfiles

# zsh
ln -sf $(pwd)/.zshrc ~/.zshrc

# git
ln -sf $(pwd)/.gitconfig ~/.gitconfig

# Ghostty
ln -sf $(pwd)/ghostty/config ~/Library/Application\ Support/com.mitchellh.ghostty/config

# Sublime Text
ln -sf $(pwd)/sublime/Preferences.sublime-settings ~/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings

# VS Code
ln -sf $(pwd)/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json

# Cursor global rules
ln -sf $(pwd)/cursor/rules ~/.cursor/rules
```
