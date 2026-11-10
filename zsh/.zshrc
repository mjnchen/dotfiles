# ==============================================================================
#                                  STARSHIP
# ==============================================================================

eval "$(starship init zsh)"

# ==============================================================================
#                                  HISTORY
# ==============================================================================

unsetopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Allow `# comments` in pasted command blocks
setopt INTERACTIVE_COMMENTS

# ==============================================================================
#                                  PLUGINS
# ==============================================================================

[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==============================================================================
#                          MACHINE-SPECIFIC OVERRIDES
# ==============================================================================

[[ -f ~/.zshrc.personal ]] && source ~/.zshrc.personal
[[ -f ~/.zshrc.work ]] && source ~/.zshrc.work

# ==============================================================================
#                                    PATH
# ==============================================================================

# Cursor
export PATH="$HOME/.local/bin:$PATH"

# ==============================================================================
#                                     FZF
# ==============================================================================

export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :200 {}'"
# bat has no Kanagawa theme; "ansi" uses the terminal's palette (Ghostty: Kanagawa Dragon)
# export BAT_THEME="ansi"
# Dracula (bat built-in; delta also reads BAT_THEME)
# export BAT_THEME="Dracula"
# Gruvbox Dark (bat built-in)
# export BAT_THEME="gruvbox-dark"
# Catppuccin Mocha (bat built-in)
export BAT_THEME="Catppuccin Mocha"
# TokyoNight / Rose Pine: bat has neither; "ansi" uses Ghostty's palette
# export BAT_THEME="ansi"
# Ayu Dark: bat has no Ayu theme; "ansi" uses Ghostty's palette
# export BAT_THEME="ansi"
# Catppuccin Mocha
export FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8,border:#6c7086"
# Kanagawa Dragon
# export FZF_DEFAULT_OPTS="--color=bg+:#282727,bg:#181616,spinner:#8ea4a2,hl:#c4746e,fg:#c5c9c5,header:#c4746e,info:#8992a7,pointer:#c8c093,marker:#8ea4a2,fg+:#c5c9c5,prompt:#8992a7,hl+:#e46876,border:#625e5a"
# Kanagawa Wave
# export FZF_DEFAULT_OPTS="--color=bg+:#2a2a37,bg:#1f1f28,spinner:#7aa89f,hl:#e46876,fg:#dcd7ba,header:#e46876,info:#957fb8,pointer:#c8c093,marker:#7aa89f,fg+:#dcd7ba,prompt:#957fb8,hl+:#ff5d62,border:#54546d"
# Rose Pine (rose-pine/fzf)
# export FZF_DEFAULT_OPTS="--color=fg:#908caa,bg:#191724,hl:#ebbcba,fg+:#e0def4,bg+:#26233a,hl+:#ebbcba,border:#403d52,header:#31748f,gutter:#191724,spinner:#f6c177,info:#9ccfd8,pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
# Rose Pine Moon (rose-pine/fzf)
# export FZF_DEFAULT_OPTS="--color=fg:#908caa,bg:#232136,hl:#ea9a97,fg+:#e0def4,bg+:#393552,hl+:#ea9a97,border:#44415a,header:#3e8fb0,gutter:#232136,spinner:#f6c177,info:#9ccfd8,pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
# TokyoNight Night (colors from folke/tokyonight.nvim extras/fzf)
# export FZF_DEFAULT_OPTS="--color=bg+:#283457,bg:#16161e,border:#27a1b9,fg:#c0caf5,gutter:#16161e,header:#ff9e64,hl+:#2ac3de,hl:#2ac3de,info:#545c7e,marker:#ff007c,pointer:#ff007c,prompt:#2ac3de,query:#c0caf5:regular,scrollbar:#27a1b9,separator:#ff9e64,spinner:#ff007c"
# TokyoNight Moon (colors from folke/tokyonight.nvim extras/fzf)
# export FZF_DEFAULT_OPTS="--color=bg+:#2d3f76,bg:#1e2030,border:#589ed7,fg:#c8d3f5,gutter:#1e2030,header:#ff966c,hl+:#65bcff,hl:#65bcff,info:#545c7e,marker:#ff007c,pointer:#ff007c,prompt:#65bcff,query:#c8d3f5:regular,scrollbar:#589ed7,separator:#ff966c,spinner:#ff007c"
# TokyoNight Storm (colors from folke/tokyonight.nvim extras/fzf)
# export FZF_DEFAULT_OPTS="--color=bg+:#2e3c64,bg:#1f2335,border:#29a4bd,fg:#c0caf5,gutter:#1f2335,header:#ff9e64,hl+:#2ac3de,hl:#2ac3de,info:#545c7e,marker:#ff007c,pointer:#ff007c,prompt:#2ac3de,query:#c0caf5:regular,scrollbar:#29a4bd,separator:#ff9e64,spinner:#ff007c"
# Dracula (dracula/fzf)
# export FZF_DEFAULT_OPTS="--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9,fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9,info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6,marker:#ff79c6,spinner:#ffb86c,header:#6272a4"
# Gruvbox Dark (colors from the Gruvbox palette)
# export FZF_DEFAULT_OPTS="--color=bg+:#3c3836,bg:#282828,spinner:#8ec07c,hl:#fabd2f,fg:#ebdbb2,header:#928374,info:#83a598,pointer:#fe8019,marker:#fb4934,fg+:#fbf1c7,prompt:#fe8019,hl+:#fabd2f,border:#504945"
# Ayu Dark (colors from the ayu palette)
# export FZF_DEFAULT_OPTS="--color=fg:#bfbdb6,bg:#0b0e14,hl:#e6b450,fg+:#bfbdb6,bg+:#1b395a,hl+:#e6b450,info:#59c2ff,prompt:#ffb454,pointer:#f29668,marker:#aad94c,spinner:#95e6cb,header:#565b66"

# ==============================================================================
#                                   ALIASES
# ==============================================================================

alias gopersonal="cd ~/Projects/personal"

brew() {
  command brew "$@"
  if [[ "$1" == "upgrade" ]]; then
    echo "Re-linking npm global packages..."
    npm rebuild -g
  fi
}

# ==============================================================================
#                              GHOSTTY TAB TITLE
# ==============================================================================

set_terminal_title() {
  [[ -n "$GHOSTTY_RESOURCES_DIR" ]] || return

  local dir repo branch title

  dir="%2~"

  if command git rev-parse --is-inside-work-tree &>/dev/null; then
    repo=$(basename "$(git rev-parse --show-toplevel)")
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    title="${repo} (${branch}) — ${dir}"
  else
    title="${dir}"
  fi

  print -Pn "\e]0;${title}\a"
}

precmd_functions+=(set_terminal_title)
chpwd_functions+=(set_terminal_title)

# Use Docker Desktop as default Docker runtime
export DOCKER_HOST="unix://$HOME/.docker/run/docker.sock"
