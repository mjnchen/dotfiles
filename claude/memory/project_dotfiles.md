---
name: Dotfiles project overview
description: Structure, tooling, and configuration choices in this dotfiles repo
type: project
originSessionId: 60adc810-7c0a-4cd6-b041-a2bfe8c3eb62
---
This is a personal macOS dotfiles repo managed by Martin Chen.

**Shell:** zsh with Starship prompt (stock gruvbox-rainbow preset), zsh-autosuggestions, zsh-syntax-highlighting. No Oh My Zsh — plugins sourced directly via Homebrew.

**Prompt:** Starship (`starship/starship.toml`) is the unmodified `starship preset gruvbox-rainbow` (since 2026-11-09): powerline blocks OS/username → directory (truncated to 3) → git → languages → docker/conda → time, then `➜`-style character on a second line. It has its own Gruvbox palette, matching the Gruvbox Dark theme used elsewhere, and is not part of the per-app theme toggles. The previous custom Catppuccin-derived config (full path, right-side cmd_duration with notifications, multiple palettes) is in git history before this change.

**Terminal:** Ghostty with MapleMono NF CN font, Gruvbox Dark theme (active since 2026-11-09, chosen to match the Starship preset; Dracula, Catppuccin Mocha, Kanagawa Dragon/Wave, Rose Pine/Moon and TokyoNight Night are left commented out in each app), `copy-on-select = clipboard`, `shell-integration = zsh`, `shell-integration-features = no-title` (tab titles managed manually via zsh precmd).

**Package management:** Homebrew via `brew/Brewfile` (common) + machine-specific `~/.Brewfile.personal` or `~/.Brewfile.work`. Key brews: fd, fzf, gh, starship, jq, lazygit, node, ripgrep, tmux, yazi, zoxide, zsh-autosuggestions, zsh-syntax-highlighting. Casks: `font-maple-mono-nf-cn`, `maccy` (clipboard manager), `shottr` (screenshot tool). Work-specific adds: awscli, telnet, tmate, cloudflared, helm, k3d, etc.

**Multiplexer:** tmux (replaced zellij). Config at `tmux/.tmux.conf` → `~/.tmux.conf`. Includes mouse support, 10k scrollback, `Prefix+L` to toggle pipe-pane logging to `/tmp/tmux-YYYYMMDD.log`.

**Claude Code:** `claude/statusline.sh` symlinked to `~/.claude/statusline.sh`. Requires manual addition of `statusLine` config to `~/.claude/settings.json` (see README).

**Setup script:** `setup.sh` — runs Brewfiles, installs global npm packages, and symlinks all configs (zsh, git, starship, ghostty, vscode, cursor, claude statusline). VS Code custom icon: `vscode/apply-icon.sh` is made executable but NOT auto-applied or installed as a launchd agent (removed because it broke VS Code's code signature on updates). Run manually after VS Code updates.

**Machine-specific overrides:** `~/.zshrc.personal` and `~/.zshrc.work` sourced at end of `.zshrc`. Brewfiles follow the same pattern.

**History:** `INC_APPEND_HISTORY` (append immediately), `SHARE_HISTORY` disabled (no cross-session sharing).

**Why:** Clean separation of personal vs. work config; Starship was re-added after a revert (commit history shows Starship → revert → re-add with full Catppuccin config).
**How to apply:** When suggesting prompt/shell changes, keep the Starship gruvbox-rainbow preset unless asked. Gruvbox Dark is also set for bat/delta (BAT_THEME), btop and lazygit (Dracula left commented out in each). Commented-out alternative themes exist in Ghostty, fzf, Zellij, VS Code/Cursor and Sublime; switching means toggling one line per app. Machine-specific config goes in `~/.zshrc.personal` or `~/.zshrc.work`, not in the dotfiles repo itself.
