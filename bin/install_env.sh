#! /bin/bash
# prereq: dotfiles are installed to ~/.dotfiles

if [[ $(uname) =~ 'Darwin' ]]; then
  if ! which brew 1>/dev/null; then
    echo 'Installing homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # when first installed, brew will not be in the path
    # zshrc will do this once linked
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  echo 'Installing cli packages...'
  brew bundle --file ~/.dotfiles/.Brewfile_cli

  echo 'Install base applications? (y/n)'
  read -r input
  [ "$input" == "y" ] && brew bundle --file ~/.dotfiles/.Brewfile

  echo 'Install media client packages? (y/n)'
  read -r input
  [ "$input" == "y" ] && brew bundle --file ~/.dotfiles/.Brewfile_media_client

  echo 'Installing mac defaults...'
  sh "$HOME"/.dotfiles/bin/mac/set_defaults.sh
  echo 'Defaults installed. Restart needed for trackpad/keyboard changes...'
fi

echo 'Installing open source tools...'
[ -e ~/dev ] || mkdir ~/dev
[ -e ~/dev/open-source ] || mkdir ~/dev/open-source

if [ -e ~/.oh-my-zsh ]; then
  git -C ~/.oh-my-zsh pull --rebase
else
  git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
fi

if [ -e ~/.rbenv ]; then
  git -C ~/.rbenv pull --rebase
else
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

if [ -e ~/dev/open-source/.tmux ]; then
  git -C ~/dev/open-source/.tmux pull --rebase
else
  git clone https://github.com/nmahoney/.tmux.git ~/dev/open-source/.tmux
fi

[ -e ~/.vim/autoload/plug.vim ] || \
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c 'PlugInstall' -c 'qa'

npm install -g json-server typescript ts-node yarn

echo 'Linking dotfiles...'
sh "$HOME"/.dotfiles/bin/link_dotfiles.sh
touch "$HOME"/.zshrc.local

echo 'Setting shell...'
custom_shell=$(which zsh)
if ! grep -q "$custom_shell" /etc/shells; then
  echo "$custom_shell" | sudo tee -a /etc/shells > /dev/null
fi

[ "$SHELL" != "$custom_shell" ] && chsh -s "$custom_shell"

echo 'Configuring ssh...'
[ ! -f "$HOME"/.ssh/id_rsa ] && ssh-keygen -t rsa
touch ~/.ssh/authorized_keys

# https://superuser.com/questions/215504/permissions-on-private-key-in-ssh-folder
chmod 700 ~/.ssh
chmod 644 ~/.ssh/id_rsa.pub
chmod 600 ~/.ssh/id_rsa
chmod 640 ~/.ssh/authorized_keys
