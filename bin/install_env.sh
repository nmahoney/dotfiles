if [[ $(uname) =~ 'Darwin' ]]; then
  if ! which brew 1>/dev/null; then
    echo 'Installing homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  echo 'Installing packages...'
  sh $HOME/.dotfiles/bin/mac/install_packages.sh

  echo 'Installing mac defaults...'
  sh $HOME/.dotfiles/bin/mac/set_defaults.sh
fi

echo 'Installing open source tools...'
mkdir ~/dev
mkdir ~/dev/open-source

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/gpakosz/.tmux.git ~/dev/open-source/.tmux

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo 'Linking dotfiles...'
sh $HOME/.dotfiles/bin/link_dotfiles.sh

echo 'Setting shell...'
custom_shell="/usr/local/bin/zsh"
if ! grep -q $custom_shell /etc/shells; then
  echo $custom_shell | sudo tee -a /etc/shells > /dev/null
fi

[ $SHELL != $custom_shell ] && chsh -s $custom_shell

echo 'Setting keys...'
[ ! -f $HOME/.ssh/id_rsa ] && ssh-keygen -t rsa
