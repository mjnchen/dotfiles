#!/bin/bash
input=$(cat)

eval "$(echo "$input" | jq -r '
  @sh "MODEL=\(.model.display_name // "")",
  @sh "THINKING=\(.thinking.enabled // false)",
  @sh "EFFORT=\(.effort.level // "")",
  @sh "CTX=\(.context_window.used_percentage // "" | tostring | split(".")[0])",
  @sh "COST=\(.cost.total_cost_usd // 0 | . * 100 | round / 100)",
  @sh "RATE=\(.rate_limits.five_hour.used_percentage // "" | tostring | split(".")[0])",
  @sh "SID=\(.session_id // "")"
')"

# Remote Control: the session's state file carries bridgeSessionId once the bridge is registered.
RC=""
if [[ -n "$SID" ]]; then
  f=$(grep -l "\"sessionId\":\"$SID\"" ~/.claude/sessions/*.json 2>/dev/null | head -1)
  [[ -n "$f" ]] && read -r RC CPID < <(jq -r '"\(.bridgeSessionId // "") \(.pid // "")"' "$f")
fi

color() {
  local val=$1
  if (( val >= 75 )); then printf '\033[31m'; # red
  elif (( val >= 50 )); then printf '\033[33m'; # yellow
  else printf '\033[32m'; fi # green
}
RST='\033[0m'
CYN='\033[36m'
MAG='\033[35m'
BLU='\033[34m'

parts=()

if [[ -n "$MODEL" ]]; then
  label="${CYN}${MODEL}${RST}"
  [[ "$THINKING" == "true" ]] && label="$label ${MAG}(thinking)${RST}"
  [[ -n "$EFFORT" ]] && label="$label ${BLU}[$EFFORT]${RST}"
  parts+=("$label")
fi

[[ -n "$CTX" ]] && parts+=("$(color "$CTX")${CTX}% ctx${RST}")
(( $(echo "$COST > 0" | bc) )) && parts+=("${MAG}\$$COST${RST}")
[[ -n "$RATE" ]] && parts+=("$(color "$RATE")${RATE}% 5h${RST}")
IFS=' | ' ; left=$(echo -e "${parts[*]}")

# Right-align the Remote Control marker using the width Claude Code passes in COLUMNS.
if [[ -n "$RC" ]]; then
  right="⇄ remote"
  visible=$(printf '%s' "$left" | sed $'s/\033\\[[0-9;]*m//g')
  # COLUMNS from Claude Code can be stale; ask the Claude process's own TTY for the real width.
  width=${COLUMNS:-80}
  tty=$(ps -o tty= -p "$CPID" 2>/dev/null | tr -d ' ')
  if [[ -n "$tty" && "$tty" != "??" ]]; then
    w=$(stty -f "/dev/$tty" size 2>/dev/null | awk '{print $2}')
    [[ -n "$w" ]] && width=$w
  fi
  pad=$(( width - ${#visible} - ${#right} - 4 ))
  (( pad < 1 )) && pad=1
  left="$left$(printf '%*s' "$pad" '')\033[32m${right}${RST}"
fi
echo -e "$left"
