mkdir ~/dev
mkdir ~/dev/open-source

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/gpakosz/.tmux.git ~/dev/open-source/.tmux

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sh $HOME/.dotfiles/bin/link_dotfiles.sh

# add zsh to /etc/shells
chsh -s /usr/local/bin/zsh
