export EDITOR="nvim"
export VISUAL="nvim"
alias vim="/usr/bin/env nvim"

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
