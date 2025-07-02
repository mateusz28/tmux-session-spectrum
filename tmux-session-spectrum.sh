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
tmux set -t $SESSION_NAME pane-active-border-style fg=$STYLE
tmux set -t $SESSION_NAME status-style bg=default,fg=default

tmux set-hook -t $SESSION_NAME after-new-window[0] \
  "set -t $SESSION_NAME pane-active-border-style fg=$STYLE"
tmux set-hook -t $SESSION_NAME after-new-window[1] \
  "set -t $SESSION_NAME status-style bg=default,fg=default"

#tmux nested
tmux set-hook -t $SESSION_NAME after-new-window[2]\
  "bind -n M-F11 set -q -t $SESSION_NAME status-bg default"
tmux set-hook -t $SESSION_NAME after-new-window[3]\
  "bind -n M-F12 set -q -t $SESSION_NAME status-bg $STYLE"

tmux bind -n M-F11 set -q -t $SESSION_NAME status-bg default
tmux bind -n M-F12 set -q -t $SESSION_NAME status-bg $STYLE
#tmux nested
ARGS_ENTER="send-keys M-F11 \; set -q status-bg $STYLE \; set-option -g window-active-style fg=default,bg=terminal \; bind-key -n M-h select-pane -L \; bind-key -n M-j select-pane -D \; bind-key -n M-k select-pane -U \; bind-key -n M-l select-pane -R \; set-option -gq prefix M-z"

ARGS_EXIT="send-keys M-F12 \; set -q status-bg $FOREGROUND_COLOR \; set-option -g window-active-style fg=default,bg=terminal \; unbind-key -n M-h \; unbind-key -n M-j \; unbind-key -n M-k \; unbind-key -n M-l \; set-option -gq prefix M-s"

tmux bind -n M-C-j $ARGS_ENTER
tmux bind -n M-C-k $ARGS_EXIT

tmux set-hook -t $SESSION_NAME after-new-window[4]\
  "bind -n M-C-j $ARGS_ENTER"
tmux set-hook -t $SESSION_NAME after-new-window[5]\
  "bind -n M-C-k $ARGS_EXIT"


