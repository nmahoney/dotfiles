#! /bin/bash

ln -fs $HOME/.dotfiles/.gitconfig $HOME
ln -fs $HOME/.dotfiles/.Rprofile $HOME
ln -fs $HOME/.dotfiles/.Brewfile $HOME
ln -fs $HOME/.dotfiles/bin $HOME

ln -fs $HOME/dev/open-source/.tmux/.tmux.conf $HOME/.tmux.conf
ln -fs $HOME/dev/open-source/.tmux/.tmux.conf.local $HOME/.tmux.conf.local

ln -fs $HOME/.dotfiles/.*rc $HOME
ln -fs $HOME/.dotfiles/.*ignore $HOME

mkdir -p $XDG_CONFIG_HOME
ln -fs $HOME/.vim $XDG_CONFIG_HOME/nvim
ln -fs $HOME/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

if [[ $(uname) =~ 'Darwin' ]]; then
  ln -fs $HOME/.dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User"
  ln -fs $HOME/.dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User"
fi
