# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git bundler rails vi-mode)

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
export LESS='-P%f (%i/%m) Line %lt/%L'

# Customize to your needs...
export PATH=$HOME/shell-scripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# Shorter lag for vi-mode
export KEYTIMEOUT=1

eval "$(rbenv init -)"
source $ZSH/oh-my-zsh.sh

# Overrides any plugin aliases
alias rails='bundle exec rails'
alias rr='touch tmp/restart.txt'
alias bi='bundle install --path vendor'
alias dev='cd ~/dev'
alias dot='cd ~/.dotfiles'

alias v='vim'
alias t='touch'
