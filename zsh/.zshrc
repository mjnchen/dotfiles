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
# Catppuccin Mocha
# export FZF_DEFAULT_OPTS="--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8,fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc,marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8,border:#6c7086"
# Kanagawa Dragon
# export FZF_DEFAULT_OPTS="--color=bg+:#282727,bg:#181616,spinner:#8ea4a2,hl:#c4746e,fg:#c5c9c5,header:#c4746e,info:#8992a7,pointer:#c8c093,marker:#8ea4a2,fg+:#c5c9c5,prompt:#8992a7,hl+:#e46876,border:#625e5a"
# Kanagawa Wave
# export FZF_DEFAULT_OPTS="--color=bg+:#2a2a37,bg:#1f1f28,spinner:#7aa89f,hl:#e46876,fg:#dcd7ba,header:#e46876,info:#957fb8,pointer:#c8c093,marker:#7aa89f,fg+:#dcd7ba,prompt:#957fb8,hl+:#ff5d62,border:#54546d"
# Rose Pine (rose-pine/fzf)
# export FZF_DEFAULT_OPTS="--color=fg:#908caa,bg:#191724,hl:#ebbcba,fg+:#e0def4,bg+:#26233a,hl+:#ebbcba,border:#403d52,header:#31748f,gutter:#191724,spinner:#f6c177,info:#9ccfd8,pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
# Rose Pine Moon (rose-pine/fzf)
# export FZF_DEFAULT_OPTS="--color=fg:#908caa,bg:#232136,hl:#ea9a97,fg+:#e0def4,bg+:#393552,hl+:#ea9a97,border:#44415a,header:#3e8fb0,gutter:#232136,spinner:#f6c177,info:#9ccfd8,pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
# TokyoNight Night (colors from folke/tokyonight.nvim extras/fzf)
export FZF_DEFAULT_OPTS="--color=bg+:#283457,bg:#16161e,border:#27a1b9,fg:#c0caf5,gutter:#16161e,header:#ff9e64,hl+:#2ac3de,hl:#2ac3de,info:#545c7e,marker:#ff007c,pointer:#ff007c,prompt:#2ac3de,query:#c0caf5:regular,scrollbar:#27a1b9,separator:#ff9e64,spinner:#ff007c"

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
