# ENV VARS
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
  if [[ -d "$1" ]]; then
   pushd "$1" > /dev/null
   env nvim
   popd > /dev/null
  else
    env nvim --cmd ":e $1"
  fi
}

# payobills
p='/home/mrsauravsahu/Code/payobills'

# ====================================================================================================================================
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux -u
fi

