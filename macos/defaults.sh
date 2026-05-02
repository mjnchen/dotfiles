#!/bin/bash
#
# macOS system defaults. Run manually after a fresh install:
#   ./macos/defaults.sh
#
# Settings here reflect the current machine's actual customizations.
# Optional dev-friendly toggles are commented out at the bottom — enable as desired.

set -u

echo "==> Dock: autohide"
defaults write com.apple.dock autohide -bool true

echo "==> Dock: tile size 73"
defaults write com.apple.dock tilesize -int 73

echo "==> Dock: hide recent apps"
defaults write com.apple.dock show-recents -bool false

echo "==> Screenshots: save to ~/Desktop/screenshots"
mkdir -p "$HOME/Desktop/screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/screenshots"
killall SystemUIServer 2>/dev/null || true

# Reduce Motion + Reduce Transparency live in com.apple.universalaccess, which
# is TCC-protected on modern macOS. Toggle these via GUI:
#   System Settings → Accessibility → Display → Reduce motion / Reduce transparency

echo "==> Performance: disable Dock magnification"
defaults write com.apple.dock magnification -bool false

echo "==> Performance: disable window animations"
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# --- Optional dev-friendly toggles ---
# Uncomment any you want.

# Faster key repeat
# defaults write NSGlobalDomain InitialKeyRepeat -int 15
# defaults write NSGlobalDomain KeyRepeat -int 2

# Show all file extensions in Finder
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files in Finder
# defaults write com.apple.finder AppleShowAllFiles -bool true

# Show path bar / status bar in Finder
# defaults write com.apple.finder ShowPathbar -bool true
# defaults write com.apple.finder ShowStatusBar -bool true

# Search current folder by default
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable smart quotes / dashes (annoying when typing code in non-code fields)
# defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# --- Apply ---
killall Dock 2>/dev/null || true
echo "Done."
