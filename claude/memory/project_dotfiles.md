---
name: Dotfiles project overview
description: Structure, tooling, and configuration choices in this dotfiles repo
type: project
originSessionId: 60adc810-7c0a-4cd6-b041-a2bfe8c3eb62
---
This is a personal macOS dotfiles repo managed by Martin Chen.

**Shell:** zsh with Starship prompt (customized catppuccin-powerline layout, Catppuccin Mocha palette), zsh-autosuggestions, zsh-syntax-highlighting. No Oh My Zsh — plugins sourced directly via Homebrew.

**Prompt:** Starship (`starship/starship.toml`) is a customized catppuccin-powerline layout: OS icon → username → full directory → git branch/status on the left, `❯` on a second line; cmd_duration (with notifications over 45s) and language versions on the right. Active palette `catppuccin_mocha`; other palettes (Catppuccin Frappé/Latte/Macchiato, Kanagawa Dragon/Wave, Rose Pine/Moon, Dracula, Ayu Mirage) use the same Catppuccin key names and are toggled by the `palette =` line. Nerd Font characters (edges, icons) were missing for a long time and were restored 2026-11-09; if edges look flat again, check the file still contains private-use glyphs. Stock presets (gruvbox-rainbow, catppuccin-powerline) and a minimal Pure-style prompt were tried that day and rejected; the user prefers this powerline look.

**Terminal:** Ghostty with MapleMono NF CN font, Catppuccin Mocha theme (active again since 2026-11-10; the other themes are left commented out in each app), `copy-on-select = clipboard`, `shell-integration = zsh`, `shell-integration-features = no-title` (tab titles managed manually via zsh precmd).

**Package management:** Homebrew via `brew/Brewfile` (common) + machine-specific `~/.Brewfile.personal` or `~/.Brewfile.work`. Key brews: fd, fzf, gh, starship, jq, lazygit, node, ripgrep, tmux, yazi, zoxide, zsh-autosuggestions, zsh-syntax-highlighting. Casks: `font-maple-mono-nf-cn`, `maccy` (clipboard manager), `shottr` (screenshot tool). Work-specific adds: awscli, telnet, tmate, cloudflared, helm, k3d, etc.

**Multiplexer:** tmux (replaced zellij). Config at `tmux/.tmux.conf` → `~/.tmux.conf`. Includes mouse support, 10k scrollback, `Prefix+L` to toggle pipe-pane logging to `/tmp/tmux-YYYYMMDD.log`.

**Claude Code:** `claude/statusline.sh` symlinked to `~/.claude/statusline.sh`. Requires manual addition of `statusLine` config to `~/.claude/settings.json` (see README).

**Setup script:** `setup.sh` — runs Brewfiles, installs global npm packages, and symlinks all configs (zsh, git, starship, ghostty, vscode, cursor, claude statusline). VS Code custom icon: `vscode/apply-icon.sh` is made executable but NOT auto-applied or installed as a launchd agent (removed because it broke VS Code's code signature on updates). Run manually after VS Code updates.

**Machine-specific overrides:** `~/.zshrc.personal` and `~/.zshrc.work` sourced at end of `.zshrc`. Brewfiles follow the same pattern.

**History:** `INC_APPEND_HISTORY` (append immediately), `SHARE_HISTORY` disabled (no cross-session sharing).

**Why:** Clean separation of personal vs. work config; Starship was re-added after a revert (commit history shows Starship → revert → re-add with full Catppuccin config).
**How to apply:** When suggesting prompt/shell changes, work within the customized Starship layout + Catppuccin Mocha aesthetic. Catppuccin Mocha is set in every app (bat uses its built-in Catppuccin Mocha theme; btop TTY follows Ghostty; Slack is themed by hand in its own preferences). Commented-out alternative themes exist in Ghostty, fzf, Zellij, VS Code/Cursor and Sublime; switching means toggling one line per app. Machine-specific config goes in `~/.zshrc.personal` or `~/.zshrc.work`, not in the dotfiles repo itself.

**Theme preferences (2026-11-10):** Kept theme set (trimmed 2026-11-10): Catppuccin, Kanagawa, Rose Pine and Dracula, plus Ayu Mirage (added that day and tried briefly; Ayu Dark stays removed); TokyoNight, Nord and Gruvbox were tried that day and removed, and other themes were removed earlier. Catppuccin Mocha and Rose Pine are favorites; within Rose Pine, Moon is slightly preferred over the base variant. Dracula felt a bit too high-contrast, and Rose Pine later felt a little too purple; lean toward softer palettes that are not strongly purple. Icon themes: VS Code and Cursor use Catppuccin Icons (`catppuccin-mocha`) with Catppuccin Mocha (`ayu` went with Ayu Mirage, Seti with Dracula; Symbols, miguelsolorio.symbols, was chosen as the muted match for Kanagawa); the user wants minimal icons (Material Icon Theme is too busy).
