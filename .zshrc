export EDITOR="nvim"
export VISUAL="nvim"
alias vim="/usr/bin/env nvim"

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

. $(brew --prefix asdf)/libexec/asdf.sh

if [ -f ${HOME}/.localrc ]; then
  source ${HOME}/.localrc
fi
