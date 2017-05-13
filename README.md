# tmux-session-spectrum

This is a script that makes [tmux](https://tmux.github.io/) using different panel colors
for different sessions.


See it in action:

![recording](https://raw.githubusercontent.com/a-rodin/tmux-session-spectrum/images/recording.gif)

Each new session will use new color for the bottom panel, so that different sessions are
more easily distinguishable between each other.

Also it automatically renumerates default session names, analogous to 
[renumber-windows](http://man.openbsd.org/OpenBSD-current/man1/tmux.1#renumber-windows) for
windows.

## Installation

The script requires `tmux` version to be not less than 2.3.

To install it copy the `tmux-session-spectru.sh` file to `~/.tmux` directory and
add to your `~/.tmux.conf` the following command:

```
set-hook -g after-new-session "run-shell 'bash ~/.tmux/tmux-session-spectrum.sh'"
```

If you want to change the default style, pass it as an environment variable:

```
set-hook -g after-new-session "run-shell 'DEFAULT_STYLE=colour4 bash ~/.tmux/tmux-session-spectrum.sh'"
```

If you want your `~/.tmux.conf` work with both older `tmux` versions that don't support
this script and the newer ones, it can be done using `tmux` conditional directive:

```
if-shell "bash -c \"[[ ! $(tmux -V | cut -d' ' -f2) < 2.3 ]]\"" "\
  set-hook -g after-new-session \"run-shell 'bash ~/.tmux-session.sh\'\""
```
