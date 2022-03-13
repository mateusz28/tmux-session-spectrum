#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$HOME/dotfiles/tmux-session-spectrum.conf" 2>/dev/null

SESSION_NAME=$(tmux display-message -p '#S')
STYLE=${DEFAULT_STYLE:-colour14}
for map in "${ARRAY[@]}" ; do
    KEY="${map%%:*}"
    VALUE="${map##*:}"
    if [ $SESSION_NAME == $KEY ] ; then
      STYLE=$VALUE
    fi
done
tmux set -t $SESSION_NAME status-style bg=$STYLE
tmux set -t $SESSION_NAME pane-active-border-style fg=$STYLE
tmux set-hook -t $SESSION_NAME after-new-window \
  "set -t $SESSION_NAME pane-active-border-style fg=$STYLE"

#tmux nested
tmux bind -n M-F11 "set -q -t $SESSION_NAME status-bg colour0"
tmux bind -n M-F12 "set -q -t $SESSION_NAME status-bg $STYLE"
