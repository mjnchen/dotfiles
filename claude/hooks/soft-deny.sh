#!/bin/bash
# PreToolUse hook: forces a permission prompt on dangerous commands instead of
# hard-blocking them. Uses the JSON protocol (stdin) for reliable input parsing
# and permissionDecision:"ask" to require user approval.
#
# Exit 0 with no JSON = allow silently
# Exit 0 with permissionDecision:"ask" = force user approval prompt
# Exit 0 with permissionDecision:"deny" = hard block

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // empty' 2>/dev/null)

ask() {
  jq -n --arg reason "$1" '{"hookSpecificOutput":{"permissionDecision":"ask","permissionDecisionReason":$reason}}'
  exit 0
}

if [ "$TOOL_NAME" = "Bash" ]; then
  CMD=$(echo "$TOOL_INPUT" | jq -r '.command // empty' 2>/dev/null)

  case "$CMD" in
    rm\ -rf*|rm\ -fr*|rm\ -r\ -f*|rm\ -f\ -r*)
      ask "Recursive force delete — verify the target path is correct" ;;
    *"&& rm -r"*|*"; rm -r"*|*"|| rm -r"*)
      ask "Chained destructive rm detected — review the full command" ;;
    sudo\ *)
      ask "Elevated privileges — make sure this is necessary" ;;
    git\ push\ --force*|git\ push\ -f\ *|git\ push\ *--force*)
      ask "Force push overwrites remote history — consider --force-with-lease instead" ;;
    git\ reset\ --hard*)
      ask "Hard reset discards uncommitted changes — consider git stash first" ;;
    git\ clean\ -f*|git\ clean\ *-f*)
      ask "git clean -f permanently deletes untracked files — consider -n (dry run) first" ;;
    git\ checkout\ --\ *|git\ checkout\ .)
      ask "Discards uncommitted changes to working tree files" ;;
    git\ branch\ -D\ *)
      ask "Force-deleting branch — unmerged commits will be lost" ;;
    git\ rebase\ *--onto*)
      ask "git rebase --onto is error-prone. Before proceeding: (1) create backup: git tag pre-rebase-backup, (2) verify syntax: --onto <newbase> <parent-of-first-commit-to-keep>, (3) state expected commit count" ;;
    git\ rebase\ *)
      ask "Before rebasing: (1) create backup: git tag pre-rebase-backup, (2) check for merge commits: git log --merges <base>..HEAD, (3) state expected commit count after rebase" ;;
    chmod\ 777\ *)
      ask "chmod 777 makes files world-writable — usually too permissive" ;;
    *curl*\|*bash*|*curl*\|*sh*|*wget*\|*bash*|*wget*\|*sh*)
      ask "Piping download to shell — review the URL and script content first" ;;
  esac

elif [ "$TOOL_NAME" = "Read" ]; then
  FILE=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty' 2>/dev/null)

  case "$FILE" in
    */.env|*/.env.*)
      ask "Reading secrets file: $FILE" ;;
    */.ssh/*)
      ask "Reading SSH credential: $FILE" ;;
    */.gnupg/*)
      ask "Reading GPG keyring: $FILE" ;;
    */.aws/*|*/.azure/*)
      ask "Reading cloud credential: $FILE" ;;
    */.config/gh/*|*/.git-credentials)
      ask "Reading git/GitHub credential: $FILE" ;;
    */.docker/config.json)
      ask "Reading Docker credential: $FILE" ;;
    */.kube/*)
      ask "Reading Kubernetes credential: $FILE" ;;
    */.npmrc|*/.pypirc|*/.gem/credentials)
      ask "Reading package registry credential: $FILE" ;;
  esac

elif [ "$TOOL_NAME" = "Edit" ]; then
  FILE=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty' 2>/dev/null)

  case "$FILE" in
    */.bashrc|*/.zshrc|*/.bash_profile|*/.zprofile)
      ask "Editing shell config: $FILE — affects all future shell sessions" ;;
  esac
fi

exit 0
