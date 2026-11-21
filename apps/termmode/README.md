# termmode

Switch between the GNOME UI (gdm) and a full-screen [kmscon](https://github.com/Aetf/kmscon) terminal, and pick which display kmscon uses.

kmscon runs on the VTs instead of getty (`autovt@.service` points at `kmsconvt@.service`; config in `/etc/kmscon/kmscon.conf`). gdm is disabled at boot, so the machine starts in kmscon.

## Usage

```sh
termmode on          # stop gdm (ends the GUI session), switch to kmscon on tty1
termmode on --full   # also terminate wayland/x11 sessions, stop GNOME user units, kill leftovers
termmode off         # start gdm, back to the graphical login
termmode status      # mode, gdm state, VT, display, leftover GNOME/Wayland sessions and processes

termmode ls --displays               # list displays (or -d): * is the one kmscon uses, (off) ones termmode turned off
termmode config --display HDMI-A-1   # use only HDMI-A-1 (saved in ~/.config/termmode/display)
termmode config --display all        # back to every display
```

- `KMS_TTY=2 termmode on` picks another VT.
- `KMS_OUTPUT=DP-2 termmode on` overrides the saved display for one run.

Save your work before `termmode on`: it ends the desktop session and closes every GUI app.

## Display

kmscon shows one console on every connected display and sizes it to the smallest, so a 4K screen next to a 1440p one only gets a 1440p grid.

With a display picked, `termmode on` (or `termmode config --display <name>` while already in terminal mode):

- forces the other outputs off by writing `off` to `/sys/class/drm/card*-<output>/status`, which re-probes them and sends the hotplug event kmscon resizes on;
- puts those monitors to sleep over DDC/CI (VCP `D6` = `04`), since kmscon stops drawing on them but leaves the last frame up. Needs `ddcutil` (`sudo apt install ddcutil`); without it, or on a monitor without DDC/CI, the frozen frame stays until the monitor sleeps.

`termmode off` wakes them (`D6` = `01`) and writes `detect` to hand them back to the kernel before starting gdm, so GNOME sees every monitor.

State:

| Path | What |
|------|------|
| `~/.config/termmode/display` | the picked display |
| `~/.config/termmode/edid/<output>` | each output's EDID, saved while connected; a forced-off output has none in sysfs and `ddcutil --edid` needs it |
| `$XDG_RUNTIME_DIR/termmode-off` | outputs termmode forced off, so `ls -d` can tell them from unplugged ones; cleared on reboot along with the force |

If kmscon doesn't resize, restart it from another VT: `sudo systemctl restart kmsconvt@tty1`.

## Install

`linux.zshrc` puts every `apps/<name>/` directory on `PATH`, so `termmode` is available once the dotfiles are at `~/.mrsauravsahu/dotfiles`.
