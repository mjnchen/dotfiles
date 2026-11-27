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
| `firefox/user-overrides.js` | Appended to [Betterfox](https://github.com/yokoffing/Betterfox) `user.js` in the default Firefox profile by `firefox/betterfox.sh` (re-run to update) |
| `vscode/settings.json` | `~/Library/Application Support/Code/User/settings.json` |
| `vscode/default_dark.icns` | `/Applications/Visual Studio Code.app/Contents/Resources/Code.icns` |
| `cursor/rules/` | `~/.cursor/rules` |
| `claude/statusline.sh` | `~/.claude/statusline.sh` |
| `macos/defaults.sh` | macOS system defaults — run manually after fresh install |
| `macos/cleanup.sh` | macOS cleanup of known-defunct launch agents / login items — safe to re-run |

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

### Browser theme: Catppuccin Mocha (manual)

Browser themes and extensions come from the stores, so nothing is checked in here.

- **Chrome / Brave**: install [Catppuccin Chrome Theme – Mocha](https://chromewebstore.google.com/detail/bkkmolkhemgaeaeggcmfbghljjjoofoh). In Brave, also set Settings → Appearance to Dark.
- **Firefox**: install [Firefox Color](https://addons.mozilla.org/en-US/firefox/addon/firefox-color/), then open the **Mocha → Mauve** link from [catppuccin/firefox](https://github.com/catppuccin/firefox#usage) and apply it.
- **Safari**: no themes.

Web pages are themed with Stylus and [catppuccin/userstyles](https://github.com/catppuccin/userstyles):

1. Install Stylus for [Chrome / Brave](https://chromewebstore.google.com/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne) or [Firefox](https://addons.mozilla.org/en-US/firefox/addon/styl-us/).
2. Download the all-styles export (keeps itself up to date after import, so don't check it in):
   ```bash
   curl -fsSL -o ~/Downloads/catppuccin-userstyles-import.json \
     https://github.com/catppuccin/userstyles/releases/download/all-userstyles-export/import.json
   ```
3. Stylus → Manage → Import (under Backup) → pick that file. Defaults: dark Mocha, light Latte, accent Mauve.
