#!/bin/bash
# Claude Code statusline — shows context usage

input=$(cat)

used=$(echo "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('used_percentage', 0))" 2>/dev/null)

if [[ -n "$used" ]]; then
  used_int=${used%.*}
  if (( used_int >= 90 )); then
    color="\033[31m"  # red
  elif (( used_int >= 75 )); then
    color="\033[33m"  # yellow
  else
    color="\033[32m"  # green
  fi
  printf "${color}ctx: ${used_int}%%\033[0m"
fi
