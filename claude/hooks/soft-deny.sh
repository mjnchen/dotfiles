#!/bin/bash
# PreToolUse hook. Two tiers:
#   deny  -> hard block, no prompt (loop-safe: never stalls an autonomous run)
#   ask   -> force a user approval prompt (interactive guard; will pause a loop)
# Uses the JSON stdin protocol for reliable parsing.
#
# Exit 0 with no JSON            = allow silently
# Exit 0 with permissionDecision = "deny" (block) or "ask" (prompt)
#
# Scope: hard-deny only catastrophic deletes of system/home roots; everything
# else (project/build dirs, relative paths) is allowed so ralph-loop runs
# frictionless. The catastrophic deny list is mirrored in settings.json.

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
TOOL_INPUT=$(echo "$INPUT" | jq -r '.tool_input // empty' 2>/dev/null)

ask() {
  jq -n --arg reason "$1" '{"hookSpecificOutput":{"permissionDecision":"ask","permissionDecisionReason":$reason}}'
  exit 0
}

deny() {
  jq -n --arg reason "$1" '{"hookSpecificOutput":{"permissionDecision":"deny","permissionDecisionReason":$reason}}'
  exit 0
}

if [ "$TOOL_NAME" = "Bash" ]; then
  CMD=$(echo "$TOOL_INPUT" | jq -r '.command // empty' 2>/dev/null)

  # Tier 1 — hard-deny catastrophic deletion of a system/home root. Leading * so
  # sudo-prefixed and chained (`&& rm -rf ~`) forms are caught too. Root paths are
  # end-anchored (no trailing *) so subdirs like ~/Projects/x stay allowed; only
  # system dirs and precious ~ dirs use a trailing * to cover their contents.
  case "$CMD" in
    *rm\ -rf\ /|*rm\ -rf\ /\ *|*rm\ -fr\ /|*rm\ -fr\ /\ *|\
    *rm\ -rf\ ~|*rm\ -rf\ ~/|*rm\ -fr\ ~|*rm\ -fr\ ~/|\
    *rm\ -rf\ \$HOME|*rm\ -rf\ \$HOME/|*rm\ -fr\ \$HOME|\
    *rm\ -rf\ /Users|*rm\ -rf\ /Users/|*rm\ -rf\ /Users/mchen|*rm\ -rf\ /Users/mchen/|\
    *rm\ -rf\ ~/Documents*|*rm\ -rf\ ~/Desktop*|*rm\ -rf\ ~/Library*|*rm\ -rf\ ~/Pictures*|\
    *rm\ -rf\ /System*|*rm\ -rf\ /Library*|*rm\ -rf\ /usr*|*rm\ -rf\ /etc*|*rm\ -rf\ /bin*|*rm\ -rf\ /var*|*rm\ -rf\ /opt*)
      deny "Refusing rm -rf on a protected system/home root path — narrow the target to a project subdirectory" ;;
  esac

  # Tier 2 — interactive ask guards (rare in loops). Order matters: curl|bash is
  # checked before the force-with-lease exemption so a chained pipe-to-shell can't
  # slip through, and the lease exemption is anchored to `git push`.
  case "$CMD" in
    sudo\ *)
      ask "Elevated privileges — make sure this is necessary" ;;
    *curl*\|*bash*|*curl*\|*sh*|*wget*\|*bash*|*wget*\|*sh*)
      ask "Piping download to shell — review the URL and script content first" ;;
    git\ push\ *--force-with-lease*)
      : ;;  # safe force-push (refuses to clobber remote work) — allow silently
    git\ push\ --force*|git\ push\ -f|git\ push\ -f\ *|git\ push\ *\ -f|git\ push\ *\ -f\ *|git\ push\ *--force*)
      ask "Force push overwrites remote history — consider --force-with-lease instead" ;;
  esac

elif [ "$TOOL_NAME" = "Read" ]; then
  FILE=$(echo "$TOOL_INPUT" | jq -r '.file_path // empty' 2>/dev/null)

  case "$FILE" in
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
fi

exit 0
