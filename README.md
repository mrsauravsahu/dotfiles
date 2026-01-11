# @mrsauravsahu/dotfiles

Personal dotfiles and configuration scripts.

## Contents

**mrss** - Custom shell functions and utilities for media processing and tools configuration.

**scripts** - Utility scripts including markdown preview and git repository management.

**configs** - Shell and tmux configuration files.

## Snippets

### - fix sound 
```bash
$ systemctl --user restart pulseaudio
```

### - remap alt and windows keys for keyboard
```bash
$ setxkbmap -option altwin:swap_alt_win

# to revert all keymaps
$ setxkbmap -option altwin:swap_alt_win

```

