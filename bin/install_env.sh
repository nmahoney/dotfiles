mkdir ~/dev
mkdir ~/dev/open-source

git clone git@github.com:square/maximum-awesome.git ~/dev/open-source/maximum-awesome
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

curl get.pow.cx | sh

sh $HOME/.dotfiles/bin/link_dotfiles.sh

# add zsh to /etc/shells
chsh -s /usr/local/bin/zsh
sh $HOME/.dotfiles/bin/install_vim_plugins.sh
