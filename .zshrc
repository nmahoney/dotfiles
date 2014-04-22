# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git bundler rails)

export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
export LESS='-P%f (%i/%m) Line %lt/%L'

# Customize to your needs...
export PATH=$HOME/shell-scripts:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

eval "$(rbenv init -)"

source $ZSH/oh-my-zsh.sh
