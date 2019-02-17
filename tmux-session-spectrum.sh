#!/bin/bash

if [ -n "$STYLES" ]; then
  STYLES=(${STYLES})
else
  STYLES=(colour2 colour4 colour5 colour6 colour8 colour1 colour3)
fi
DEFAULT_STYLE=${DEFAULT_STYLE:-colour2}

SESSION_ID='$'$(tmux list-sessions -F "#{session_id}" | tr -d '$' | sort -nr | head -n1)

tmux rename-session -t $SESSION_ID _${SESSION_ID/\$/}
SESSION_NAMES=$(tmux list-sessions -F "#{session_name}")
SESSION_NUMBER=0
while true; do
  if grep "^$SESSION_NUMBER$" <<<"$SESSION_NAMES" >/dev/null ; then
    ((SESSION_NUMBER++))
  else
    break
  fi
done
tmux rename-session -t $SESSION_ID $SESSION_NUMBER

for ((STYLE_NUMBER = 0; STYLE_NUMBER < ${#STYLES[@]}; STYLE_NUMBER++)); do
  if [ "${STYLES[$STYLE_NUMBER]}" == "$DEFAULT_STYLE" ]; then
    break
  fi
done

STYLE=${STYLES[$(((SESSION_NUMBER + STYLE_NUMBER) % ${#STYLES[@]}))]}

tmux set -t $SESSION_ID status-style bg=$STYLE
tmux set -t $SESSION_ID pane-active-border-style fg=$STYLE
tmux set-hook -t $SESSION_ID after-new-window \
  "set -t $SESSION_ID pane-active-border-style fg=$STYLE"
