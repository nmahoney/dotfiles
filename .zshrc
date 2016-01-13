# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(
  brew
  bundler
  git
  mercurial
  rails
  vagrant
  vi-mode
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'
export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Home/
export KEYTIMEOUT=1 # shorter lag for vi-mode
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

eval "$(rbenv init -)"

bindkey '^r' history-incremental-search-backward

# Overrides any plugin aliases
alias reload='. ~/.zshrc && echo "zsh config reloaded"'
alias rails='bundle exec rails'
alias rr='touch tmp/restart.txt'
alias bi='bundle install --path vendor'
alias dev='cd ~/dev'
alias dot='cd ~/.dotfiles'

alias r=rails
alias py=ipython
alias v='vim'
alias nv='nvim'
alias vg='vagrant'
alias t='touch'
alias j='jobs'
alias e='exit'

# Fast vim switching
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
