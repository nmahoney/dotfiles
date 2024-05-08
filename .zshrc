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
  vi-mode
  yarn
)

source $ZSH/oh-my-zsh.sh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export EDITOR='vim'
export FZF_DEFAULT_COMMAND='ag --hidden -g "" -U'
export FZF_DEFAULT_OPTS='
--no-bold
--info hidden
--color dark,hl:33,hl+:37,fg+:235,bg:-1,bg+:-1,fg+:254
--color info:254,prompt:37,spinner:108,pointer:#FFFFFF,marker:235'

export KEYTIMEOUT=1 # shorter lag for vi-mode
export WORKON_HOME=~/.virtualenv
export XDG_CONFIG_HOME=$HOME/.config

PATH=""
PATH+=:$HOME/.rbenv/bin
PATH+=:$HOMEBREW_PREFIX/opt/ruby/bin # homebrew will not overwrite macos lib
PATH+=:$HOME/bin
PATH+=:/usr/local/bin
PATH+=:/usr/bin
PATH+=:/bin
PATH+=:/usr/sbin
PATH+=:/sbin
PATH+=:/usr/X11/bin
export PATH=$PATH

eval "$(rbenv init -)"
if [[ $(uname -p) == 'arm' ]]; then
  # M1 macs
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

bindkey '^r' history-incremental-search-backward

# other aliases come from oh-my-zsh plugins
alias ag='ag $* --hidden --ignore-dir={.git,}'
alias al=alias
alias b=brew
alias bi='bundle install --path vendor'
alias c=cat
alias cpu='top -l1 | awk "NR==4 || NR==7 {print}"'
alias dev='cd ~/dev'
alias disk='df -lh | awk "{print \$1,\$5,\$4}" | column -t'
alias dot='cd ~/.dotfiles'
alias e='exit'
alias gcfh='gc --fixup=HEAD'
alias grbim='grbi origin/master'
alias j='jobs'
alias ka=killall
alias m=man
alias nv='nvim'
alias p=print
alias py=ipython
alias r='bundle exec rails'
alias rl='. ~/.zshrc && echo "zsh config reloaded"'
alias roku_encode='for i in *.mkv; do ffmpeg -i "$i" -c:v copy -c:a aac -ac 2 -ab 256K -strict experimental "${i%.*}.mp4"; done'
alias rr='touch tmp/restart.txt'
alias t='touch'
alias top_commands="cat ~/.zsh_history | awk -F ';' '{ split(\$2,arr,\" \"); print arr[1] }' | iconv -f UTF-8 -t UTF-8//IGNORE | sort | uniq -c | sort | tail -n 50" # prereq of uniq is sorted input
alias td='touch `date +%F`'
alias v='vim'
alias wh=which

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

[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local
