brew update

# terminal applications
brew install \
  git \
  neofetch \
  node \
  python \
  ruby-build \
  sqlite \
  the_silver_searcher \
  tmux \
  tree \
  vim \
  watch \
  zsh \
  zsh-syntax-highlighting

# GUI applications
brew cask
brew tap homebrew/cask-versions
brew cask install \
  1password6 \
  docker \
  dropbox \
  firefox \
  google-chrome \
  iterm2-nightly \
  macvim \
  moom \
  skitch \
  slack \
  spotify \
  the-unarchiver \
  transmission \
  visual-studio-code \
  vlc

# fonts
brew tap homebrew/cask-fonts
brew cask install homebrew/cask-fonts/font-source-code-pro
