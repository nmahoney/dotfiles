tap 'homebrew/cask'
tap 'homebrew/cask-versions'
tap 'homebrew/cask-fonts'

brew 'awscli'
brew 'fzf'
brew 'git'
brew 'inetutils'
brew 'iperf3'
brew 'ipython'
brew 'jq'
brew 'mas'
brew 'neofetch'
brew 'neovim'
brew 'node'
brew 'nvm'
brew 'p7zip'
brew 'python'
brew 'ruby-build'
brew 'sqlite'
brew 'svn' # required by fonts
brew 'the_silver_searcher'
brew 'tmux'
brew 'tree'
brew 'vim'
brew 'watch'
brew 'wget'
brew 'zsh'
brew 'zsh-syntax-highlighting'

def exists?(name)
  File.exists?("/Applications/#{name}.app")
end

cask 'alacritty' unless exists? 'Alacritty'
cask 'android-platform-tools'
cask 'bitwarden' unless exists? 'Bitwarden'
cask 'docker' unless exists? 'docker'
cask 'discord' unless exists? 'discord'
cask 'dropbox' unless exists? 'Dropbox'
cask 'firefox' unless exists? 'Firefox'
cask 'google-chrome' unless exists? 'Google Chrome'
cask 'google-drive' unless exists? 'Google Drive'
cask 'intellij-idea' unless exists? 'Intellij Idea'
cask 'iterm2-nightly' unless exists? 'iterm'
cask 'kitty' unless exists? 'kitty'
cask 'microsoft-remote-desktop' unless exists? 'Microsoft Remote Desktop'
cask 'slack' unless exists? 'Slack'
cask 'spotify' unless exists? 'Spotify'
cask 'the-unarchiver' unless exists? 'The Unarchiver'
cask 'transmission' unless exists? 'Transmission'
cask 'visual-studio-code' unless exists? 'Visual Studio Code'
cask 'vlc' unless exists? 'VLC'

cask 'homebrew/cask-fonts/font-source-code-pro' unless File.exists?(File.expand_path '~/Library/Fonts/SourceCodePro-Black.otf')

mas 'mindnode', id: 1289197285
mas 'moom', id: 419330170
