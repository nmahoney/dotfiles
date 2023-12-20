#! /bin/bash
# prereq: dotfiles are installed to ~/.dotfiles

if [[ $(uname) =~ 'Darwin' ]]; then
  if ! which brew 1>/dev/null; then
    echo 'Installing homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  echo 'Installing packages...'
  brew bundle --file ~/.dotfiles/.Brewfile --no-lock

  echo 'Installing mac defaults...'
  sh $HOME/.dotfiles/bin/mac/set_defaults.sh
  echo 'Defaults installed. Restart needed for trackpad/keyboard changes...'
fi

echo 'Installing open source tools...'
[ -e ~/dev ] || mkdir ~/dev
[ -e ~/dev/open-source ] || mkdir ~/dev/open-source

if [ -e ~/.oh-my-zsh ]; then
  git -C ~/.oh-my-zsh pull --rebase
else
  git clone git@github.com:ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

if [ -e ~/.rbenv ]; then
  git -C ~/.rbenv pull --rebase
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

if [ -e ~/dev/open-source/.tmux ]; then
  git -C ~/dev/open-source/.tmux pull --rebase
else
  git clone https://github.com/gpakosz/.tmux.git ~/dev/open-source/.tmux
fi

[ -e ~/.vim/autoload/plug.vim ] || \
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c 'PlugInstall' -c 'qa'

npm install -g json-server typescript ts-node yarn

echo 'Linking dotfiles...'
sh $HOME/.dotfiles/bin/link_dotfiles.sh
touch $HOME/.zshrc.local

echo 'Setting shell...'
custom_shell=$(which zsh)
if ! grep -q $custom_shell /etc/shells; then
  echo $custom_shell | sudo tee -a /etc/shells > /dev/null
fi

[ $SHELL != $custom_shell ] && chsh -s $custom_shell

echo 'Setting keys...'
[ ! -f $HOME/.ssh/id_rsa ] && ssh-keygen -t rsa
