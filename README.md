# tmux-session-spectrum

This is a [tmux](https://tmux.github.io/) plugin that sets different pane colors
for different sessions.


See it in action:

![recording](https://raw.githubusercontent.com/a-rodin/tmux-session-spectrum/images/recording.gif)

Each new session uses new color for the bottom panel, so that different sessions are
more easily distinguishable between each other.

Also it automatically renumerates default session names, analogous to 
[renumber-windows](http://man.openbsd.org/OpenBSD-current/man1/tmux.1#renumber-windows) for
windows.

## Installation

The script requires `tmux` version to be not less than 2.3.

### With [`tpm`](https://github.com/tmux-plugins/tpm)

Add

```
set -g @plugin 'a-rodin/tmux-session-spectrum'
```

to your `~/.tmux.conf` and run `tmux source ~/.tmux.conf` or restart tmux. Then press `prefix` + <kbd>I</kbd>.

### Manual

Run

```sh
git clone https://github.com/a-rodin/tmux-session-spectrum ~/.tmux/plugins/tmux-session-spectrum
```

Then add the following line to your `~/.tmux.conf`:

```
set-hook -g after-new-session "run-shell 'bash ~/.tmux/plugins/tmux-session-spectrum/tmux-session-spectrum.sh'"
```

If you want your `~/.tmux.conf` to work with both older `tmux` versions that don't support
this script and the newer ones, it can be done using `tmux` conditional directive:

```
if-shell "bash -c \"[[ ! $(tmux -V | cut -d' ' -f2) < 2.3 ]]\"" "\
  set-hook -g after-new-session \"run-shell 'bash ~/.tmux/tmux-session-spectrum/tmux-session-spectrum.sh'\""
```

## Configuration

There are two varaibles to configure.

The first one is the palette. It could be configured by providing space-separated list of color
names as a variable `STYLES`. The second one is the initial color from the palette.
It is specified by providing `DEFAULT_STYLE` variable. If no `DEFAULT_STYLE` is provided, then the
first color from the palette is used.

The color names used by tmux are [the following](https://superuser.com/a/285400/249673):
![colour names](https://i.stack.imgur.com/e63et.png)

Both of the variables should be added to a file `~/.tmux/plugins/tmux-session-spectrum/tmux-session-spectrum.conf`.

Example `tmux-session-spectrum.conf`:

```bash
STYLES="colour47 colour53"
DEFAULT_STYLE=colour4
```
