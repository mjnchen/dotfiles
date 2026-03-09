# dotfiles

Personal configuration files, managed via symlinks.

## Contents

| File / Directory | Symlink |
|---|---|
| `.zshrc` | `~/.zshrc` |
| `.gitconfig` | `~/.gitconfig` |
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

# Cursor global rules
ln -sf $(pwd)/cursor/rules ~/.cursor/rules
```
