#! /usr/bin/env bash

SCRIPT_DIR=$(dirname -- "$0")

which brew

if [ $? -gt 0 ]; then
  echo "Please install homebrew"
  exit 1
fi

brew install --cask font-awesome-terminal-fonts
brew install tmux neovim ripgrep stow asdf gpg gawk

stow . -d ${SCRIPT_DIR} -t ${HOME} -v

asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add python
asdf plugin-add direnv
asdf install

# Install TPM (Tmux plugin manager) if it doesn't exist and all configured plugins
if [ ! -d $HOME/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/bin/install_plugins
fi

if [ ! -d $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then
  git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
  nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
fi
