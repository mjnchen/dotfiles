#!/bin/bash
input=$(cat)

echo "$input" | jq -r '
  [
    ((.model.display_name // empty) +
      (if .thinking.enabled then " (thinking)" else "" end) +
      (if .effort.level then " [" + .effort.level + "]" else "" end)),
    (.context_window.used_percentage // empty | tostring | split(".")[0] + "% ctx")
  ] | map(select(. != "")) | join(" | ")
'
