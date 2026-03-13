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

### Manual steps (optional)

# zsh
ln -sf $(pwd)/zsh/.zshrc ~/.zshrc
cp $(pwd)/zsh/.zshrc.personal.example ~/.zshrc.personal  # then customize

# git
ln -sf $(pwd)/git/.gitconfig ~/.gitconfig
ln -sf $(pwd)/git/.gitignore_global ~/.gitignore_global
ln -sf ../../git/hooks/pre-push .git/hooks/pre-push

# Homebrew — common packages
brew bundle --file=$(pwd)/brew/Brewfile

# Homebrew — machine-specific (pick one)
cp $(pwd)/brew/Brewfile.work.example ~/.Brewfile.work        # then customize
# cp $(pwd)/brew/Brewfile.personal.example ~/.Brewfile.personal
brew bundle --file=~/.Brewfile.work    # or ~/.Brewfile.personal

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
