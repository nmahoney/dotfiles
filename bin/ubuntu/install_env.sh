sh $HOME/.dotfiles/bin/ubuntu/install_packages.sh
sh $HOME/.dotfiles/bin/link_dotfiles.sh

git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
chsh -s /usr/bin/zsh
zsh $HOME/.dotfiles/bin/install_plugins.sh
