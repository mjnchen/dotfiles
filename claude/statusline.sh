#!/bin/bash
input=$(cat)

eval "$(echo "$input" | jq -r '
  @sh "MODEL=\(.model.display_name // "")",
  @sh "THINKING=\(.thinking.enabled // false)",
  @sh "EFFORT=\(.effort.level // "")",
  @sh "CTX=\(.context_window.used_percentage // "" | tostring | split(".")[0])",
  @sh "COST=\(.cost.total_cost_usd // 0 | . * 100 | round / 100)",
  @sh "RATE=\(.rate_limits.five_hour.used_percentage // "" | tostring | split(".")[0])"
')"

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

IFS=' | ' ; echo -e "${parts[*]}"
