# ==============================================================================
#                                  STARSHIP
# ==============================================================================

eval "$(starship init zsh)"

# ==============================================================================
#                                  HISTORY
# ==============================================================================

unsetopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

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
#                                   ALIASES
# ==============================================================================

alias gopersonal="cd ~/Projects/personal"

# ==============================================================================
#                              GHOSTTY TAB TITLE
# ==============================================================================

set_terminal_title() {
  [[ -n "$GHOSTTY_RESOURCES_DIR" ]] || return

  local dir repo branch title

  dir="%1~"

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

# Use OrbStack as default Docker runtime (survives Docker Desktop context resets)
export DOCKER_HOST="unix://$HOME/.orbstack/run/docker.sock"
