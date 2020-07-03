mkdir ~/dev
mkdir ~/dev/open-source

git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
git clone https://github.com/gpakosz/.tmux.git ~/dev/open-source/.tmux

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

sh $HOME/.dotfiles/bin/link_dotfiles.sh

custom_shell="/usr/local/bin/zsh"
if ! grep -q $custom_shell /etc/shells; then
  echo "Adding custom shell to /etc/shells..."
  echo $custom_shell | sudo tee -a /etc/shells > /dev/null
fi

[ $SHELL != $custom_shell ] && chsh -s $custom_shell

[ ! -f $HOME/.ssh/id_rsa ] && ssh-keygen -t rsa
