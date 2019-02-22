#!/bin/bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

[[ ! $(tmux -V | cut -d' ' -f2) < 2.3 ]] &&
  tmux set-hook -g after-new-session "run-shell 'bash \"$CURRENT_DIR/tmux-session-spectrum.sh\"'" &&
  "$CURRENT_DIR/tmux-session-spectrum.sh"
