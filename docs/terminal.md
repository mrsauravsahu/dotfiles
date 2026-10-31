# Terminal setup

## Stack

- WezTerm: `~/.config/wezterm` (own repo, `mrsauravsahu/wezterm-config`)
- tmux: `~/.config/tmux/tmux.conf`, symlinked to `tmux.conf` in this repo
- Nesting: `auto_tmux` in `~/.zshrc` starts the outer tmux, and an nvim `:terminal` starts a second server with `tmux -L vim`
- A pane can sit four layers deep: WezTerm > tmux > nvim > `tmux -L vim`

## Wrapped links

**Symptom:** a link that wraps onto a second row doesn't open correctly.

**Cause:** Claude Code emits one OSC 8 link for the whole URL but hard-wraps its text across rows. Without the `hyperlinks` feature, tmux drops the link (`Hls: [missing]` in `tmux info`), so WezTerm can only match the text row by row.

**Fix:** `set -as terminal-features "*:hyperlinks"` in `tmux.conf`.

Terminal features are read when a client attaches, so detach and reattach after adding it. Do this for each tmux layer. A config reload isn't enough.

**Check:**

```sh
tmux info | grep Hls
printf '\033]8;;https://example.com/%s\033\\wrapped link %s\033]8;;\033\\\n' "$(printf 'x%.0s' {1..300})" "$(printf 'x%.0s' {1..300})"
```

`Hls` should show a value instead of `[missing]`, and clicking any row of the output should open the same URL.

**Limit:** this only helps programs that emit OSC 8. A plain-text URL still depends on WezTerm's `hyperlink_rules`, which can't rejoin rows that an app hard-wrapped or that sit in a tmux split.
