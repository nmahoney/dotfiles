#! /bin/bash

if  [ ! -e ~/.gitconfig ]; then
  # use template but email may be different
  cp $HOME/.dotfiles/.gitconfig $HOME
  echo "Email for git: "
  read git_email
  git config --global user.email $git_email
fi

ln -fs $HOME/.dotfiles/.Rprofile $HOME
ln -fs $HOME/.dotfiles/.Brewfile $HOME
ln -fs $HOME/.dotfiles/bin $HOME
ln -fs $HOME/.dotfiles/.alacritty.yml $HOME

# link standard .conf and customized .conf.local from fork
ln -fs $HOME/dev/open-source/.tmux/.tmux.conf $HOME/.tmux.conf
ln -fs $HOME/dev/open-source/.tmux/.tmux.conf.local $HOME/.tmux.conf.local

ln -fs $HOME/.dotfiles/.*rc $HOME
ln -fs $HOME/.dotfiles/.*ignore $HOME
ln -fs $HOME/.dotfiles/coc-settings.json $HOME/.vim

mkdir -p $XDG_CONFIG_HOME
ln -fs $HOME/.vim $XDG_CONFIG_HOME/nvim
ln -fs $HOME/.vimrc $XDG_CONFIG_HOME/nvim/init.vim
ln -fs $HOME/.dotfiles/kitty.conf $XDG_CONFIG_HOME/kitty/

mkdir -p $HOME/.ipython/profile_default
ln -fs $HOME/.dotfiles/ipython_config.py $HOME/.ipython/profile_default/ipython_config.py

if [[ $(uname) =~ 'Darwin' ]]; then
  mkdir -p "$HOME/Library/Application Support/Code/User"
  ln -fs $HOME/.dotfiles/vscode/settings.json "$HOME/Library/Application Support/Code/User"
  ln -fs $HOME/.dotfiles/vscode/keybindings.json "$HOME/Library/Application Support/Code/User"

  # spotlight will not index files in a dot directory, or their symlinks
  # copy files until a workaround is found
  cp -r $HOME/.dotfiles/bin/mac/spotlight $HOME
fi
