brew update

# terminal applications
brew install \
  awscli \
  git \
  mas \
  neofetch \
  neovim \
  node \
  nvm \
  python \
  ruby-build \
  sqlite \
  svn \ # required by fonts
  the_silver_searcher \
  tmux \
  tree \
  vim \
  watch \
  wget \
  zsh \
  zsh-syntax-highlighting

# GUI applications
brew tap homebrew/cask-versions

brew cask install \
  1password6 \
  docker \
  firefox \
  intellij-idea \
  iterm2-nightly \
  transmission \
  visual-studio-code \
  vlc

# unversioned casks, non-silent failure
brew cask install \
  dropbox \
  google-chrome \
  slack \
  spotify \
  the-unarchiver

mas lucky mindnode
mas lucky monity
mas lucky moom

# fonts
brew tap homebrew/cask-fonts
brew cask install homebrew/cask-fonts/font-source-code-pro
