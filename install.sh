#! /usr/bin/env bash

SCRIPT_DIR=$(dirname -- "$0")

which brew

if [ $? -gt 0 ]; then
  echo "Please install homebrew"
  exit 1
fi

brew tap homebrew/cask-fonts
brew install wezterm neovim ripgrep stow asdf gpg gawk font-hack-nerd-font

stow . -d ${SCRIPT_DIR} -t ${HOME} -v

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add gcloud
asdf plugin add java
asdf plugin add maven
asdf plugin add python
asdf plugin add direnv
asdf plugin add zellij
asdf plugin add rust
asdf plugin add golang
asdf plugin add terraform https://github.com/asdf-community/asdf-hashicorp.git
asdf plugin add jq
asdf install

asdf direnv setup --shell zsh --version 2.32.2
