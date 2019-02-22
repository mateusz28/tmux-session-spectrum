# tmux-session-spectrum

This is a script that makes [tmux](https://tmux.github.io/) use different panel colors
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

to your `~/.tmux.conf` and run `tmux source ~/.tmux.conf` or restart tmux.

### Manually

Run

```sh
mkdir -p ~/.tmux/plugins
git clone https://github.com/a-rodin/tmux-session-spectrum ~/.tmux/plugins/tmux-session-spectrum
```

Then add the following line to your `~/.tmux.conf`:

```
set-hook -g after-new-session "run-shell 'bash ~/.tmux/plugins/tmux-session-spectrum/tmux-session-spectrum.sh'"
```

If you want your `~/.tmux.conf` work with both older `tmux` versions that don't support
this script and the newer ones, it can be done using `tmux` conditional directive:

```
if-shell "bash -c \"[[ ! $(tmux -V | cut -d' ' -f2) < 2.3 ]]\"" "\
  set-hook -g after-new-session \"run-shell 'bash ~/.tmux/tmux-session-spectrum/tmux-session-spectrum.sh'\""
```

## Configuration

There are two varaibles to configure. The first one is the palette. It could be configured
by providing space-separated [colour names](https://superuser.com/a/285400/249673) a variable `STYLES`. The second one is the initial style from the palette. It is specified by providing `DEFAULT_STYLE`. If no `DEFAULT_STYLE` is provided, then the first one from the palette is used.

Both of the variables should be added to a file `~/.tmux/plugins/tmux-session-spectrum/tmux-session-spectrum.conf`.

Example `tmux-session-spectrum.conf`:

```sh
STYLES="colour47 colour53"
DEFAULT_STYLE=colour4
```
