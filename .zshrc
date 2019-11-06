# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(
  aws
  brew
  bundler
  docker
  git
  mvn
  npm
  rails
  vagrant
  vi-mode
)

source $ZSH/oh-my-zsh.sh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR='vim'
export KEYTIMEOUT=1 # shorter lag for vi-mode
export WORKON_HOME=~/.virtualenv
export XDG_CONFIG_HOME=$HOME/.config

PATH=""
PATH+=:$HOME/.rbenv/bin
PATH+=:/usr/local/opt/ruby/bin # homebrew ruby, for vim plugin compilation
PATH+=:$HOME/bin
PATH+=:/usr/local/bin
PATH+=:/usr/bin
PATH+=:/bin
PATH+=:/usr/sbin
PATH+=:/sbin
PATH+=:/usr/X11/bin
export PATH=$PATH

eval "$(rbenv init -)"

bindkey '^r' history-incremental-search-backward

# Overrides any plugin aliases
alias reload='. ~/.zshrc && echo "zsh config reloaded"'
alias rails='bundle exec rails'
alias rr='touch tmp/restart.txt'
alias bi='bundle install --path vendor'
alias dev='cd ~/dev'
alias dot='cd ~/.dotfiles'
alias formulae='cd /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/'

alias r=rails
alias py=ipython
alias v='vim'
alias nv='nvim'
alias vg='vagrant'
alias t='touch'
alias td='touch `date +%F`'
alias j='jobs'
alias e='exit'
alias ag='ag $* --hidden --ignore-dir={.git,}'

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
