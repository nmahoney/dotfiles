mkdir ~/dev
mkdir ~/dev/open-source

git clone git@github.com:square/maximum-awesome.git ~/dev/open-source/maximum-awesome
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl get.pow.cx | sh

sh $HOME/.dotfiles/bin/link_dotfiles.sh

# add zsh to /etc/shells
chsh -s /usr/local/bin/zsh
