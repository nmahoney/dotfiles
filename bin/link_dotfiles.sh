#! /bin/bash

ln -fs $HOME/.dotfiles/.gitconfig $HOME
ln -fs $HOME/.dotfiles/.Rprofile $HOME
ln -fs $HOME/.dotfiles/.Brewfile $HOME
ln -fs $HOME/.dotfiles/bin $HOME
ln -fs $HOME/.dotfiles/.alacritty.yml $HOME

ln -fs $HOME/dev/open-source/.tmux/.tmux.conf $HOME/.tmux.conf

# periodically pull latest oh-my-tmux and merge overrides
ln -fs $HOME/.dotfiles/.tmux.conf.oh-my-tmux $HOME/.tmux.conf.local

ln -fs $HOME/.dotfiles/.*rc $HOME
ln -fs $HOME/.dotfiles/.*ignore $HOME
ln -fs $HOME/.dotfiles/coc-settings.json $HOME/.vim

mkdir -p $XDG_CONFIG_HOME
ln -fs $HOME/.vim $XDG_CONFIG_HOME/nvim
ln -fs $HOME/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
ln -fs $HOME/.dotfiles/kitty.conf $XDG_CONFIG_HOME/kitty/

if [[ $(uname) =~ 'Darwin' ]]; then
  ln -fs $HOME/.dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User"
  ln -fs $HOME/.dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User"
fi
