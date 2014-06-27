execute pathogen#infect()
syntax on
filetype plugin indent on

set listchars=tab:▸\ ,eol:¬
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set number
set wildignore+=vendor/ruby/**
set hidden

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
