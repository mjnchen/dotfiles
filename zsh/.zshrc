# ==============================================================================
#                                   HISTORY
# ==============================================================================

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

# ==============================================================================
#                                 COMPLETION
# ==============================================================================

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ==============================================================================
#                                  PLUGINS
# ==============================================================================

[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ==============================================================================
#                                   PROMPT
# ==============================================================================

eval "$(starship init zsh)"

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

alias gonaisa="cd ~/Projects/naisa"
alias gopersonal="cd ~/Projects/personal"

# ==============================================================================
#                                    NAISA
# ==============================================================================

# naisa ui — lazy-load token on first use
_load_github_token() {
  if [[ -z "$GITHUB_PACKAGES_TOKEN" ]] && command -v gh >/dev/null 2>&1; then
    export GITHUB_PACKAGES_TOKEN="$(gh auth token 2>/dev/null)"
  fi
}
precmd_functions+=(_load_github_token)

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
