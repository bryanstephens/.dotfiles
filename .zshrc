# For profiling zsh startup
# zmodload zsh/zprof
#
# # If not running interactively, don't do anything
[ -z "$PS1" ] && return

HISTFILE=~/.zsh_history

# don't put duplicate lines or lines starting with space in the history.
# See zsh(1) for more options
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

# share history with all current terminals
setopt SHARE_HISTORY
export HISTTIMEFORMAT="[%F %T] "
setopt EXTENDED_HISTORY

# for setting history length see HISTSIZE and HISTFILESIZE in zsh(1)
HISTSIZE=1000000000
HISTFILESIZE=1000000000

export EDITOR="nvim"
export VISUAL="nvim"
alias vim="/usr/bin/env nvim"

# Use vim style zsh bindings
bindkey -v
# Restore ^r command history search
bindkey -M viins '^R' history-incremental-search-backward
bindkey -M vicmd '^R' history-incremental-search-backward

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

. $(brew --prefix asdf)/bin

if [ -f ${HOME}/.localrc ]; then
  source ${HOME}/.localrc
fi
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# Also for profiling zsh startup
# zprof
