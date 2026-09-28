#!/usr/bin/env bash
# PreToolUse (Bash): remind to base new branches/PRs on latest origin/main.
# Fires only when the command creates a branch/worktree/PR AND the current HEAD
# is behind origin/main. Non-blocking (additionalContext reminder).
set -uo pipefail

input=$(cat)
cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // ""' 2>/dev/null)

case "$cmd" in
  *"git checkout -b"*|*"git switch -c"*|*"git worktree add"*|*"gh pr create"*) ;;
  *) exit 0 ;;
esac

git rev-parse --git-dir >/dev/null 2>&1 || exit 0
git fetch origin main --quiet 2>/dev/null
om=$(git rev-parse --short origin/main 2>/dev/null) || exit 0
head=$(git rev-parse --short HEAD 2>/dev/null) || exit 0

# origin/main is an ancestor of HEAD => HEAD already includes latest main.
if git merge-base --is-ancestor origin/main HEAD 2>/dev/null; then
  exit 0
fi

msg="BASE-ON-LATEST-MAIN: HEAD ($head) is BEHIND origin/main ($om). Before creating this branch/PR: base it on freshly-fetched origin/main, and grep main for existing work on these files/feature first (prevents stale-base PRs and duplicating already-merged work). If branching off a non-main base is intentional here, proceed."
jq -cn --arg m "$msg" '{hookSpecificOutput:{hookEventName:"PreToolUse",additionalContext:$m}}'
exit 0
