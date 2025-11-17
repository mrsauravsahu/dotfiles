# vim: set filetype=sh :

# ENV VARS
export SHELL=/usr/bin/zsh
export GTK_THEME='Yaru-dark'
export TERM='xterm-256color'
export KUBECONFIG='/home/mrsauravsahu/.kube/config'

# ====================================================================================================================================

# PATH
export PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
# flatpak
export PATH="${PATH}:/var/lib/flatpak/exports/share:/home/mrsauravsahu/.local/share/flatpak/exports/share"
# my programs
export PATH="${PATH}:/opt/mrsauravsahu/bin"

# save the history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ====================================================================================================================================
# ALIASES
alias k=kubectl
alias cat=bat
alias ll='ls -l'
alias l='ls'
alias vim=nvim
# wezterm
alias wezterm='flatpak run org.wezfurlong.wezterm'
# tor
alias tor="~/Downloads/tor-browser/Browser/firefox >/dev/null 2>&1 &"
# grep: always show color
alias grep='grep --color'

# ====================================================================================================================================
# SCRIPTS 
. "$HOME/.cargo/env"
. ${ASDF_DATA_DIR:-$HOME/.asdf}/plugins/golang/set-env.zsh

# ====================================================================================================================================
# REUSABLE FUNCTIONS
shutdown(){
  sudo shutdown -P now
}

# alias: vim to nvim
function nvim() {
  if [[ "$#" -eq 0 ]]; then 
   env nvim .
  elif [[ -d "$1" ]]; then
   pushd "$1" > /dev/null
   env nvim $1
   popd > /dev/null
  else
    env nvim --cmd ":e $1"
  fi
}

# payobills
p='/home/mrsauravsahu/Code/payobills'

# ====================================================================================================================================
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#   exec tmux -u
# fi

# ====================================================================================================================================
# XDG 

export XDG_CONFIG_HOME='/home/mrsauravsahu'
export XDG_SESSION_TYPE=x11
export XDG_CACHE_HOME=/home/mrsauravsahu/.cache
export XDG_SESSION_CLASS=user
export XDG_MENU_PREFIX=gnome-
export XDG_RUNTIME_DIR=/run/user/1000
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_HOME=/home/mrsauravsahu/.config
export XDG_DATA_HOME=/home/mrsauravsahu/.data
export XDG_SESSION_DESKTOP=ubuntu
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/app/etc/xdg:/etc/xdg
export XDG_DATA_DIRS=/usr/share/ubuntu:/usr/share/gnome:/home/mrsauravsahu/.var/app/org.wezfurlong.wezterm/data/flatpak/exports/share:/var/lib/flatpak/exports/share:/app/share:/usr/share:/usr/share/runtime/share:/run/host/user-share:/run/host/share:/var/lib/snapd/desktop

# =====
#TMUX

# if not in a Tmux session, start one
if [[ -z "$TMUX" ]]; then 
  exec tmux -u
else
  TMUX_SESSION_NAME="${PWD}"
  tmux new-session -s "${TMUX_SESSION_NAME}" -c "${PWD}" -f "${XDG_CONFIG_HOME}/tmux/tmux.conf"
fi

