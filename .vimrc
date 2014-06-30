execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
set listchars=tab:▸\ ,eol:¬
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set number
set wildignore+=vendor/ruby/**
set hidden
set hlsearch
set cursorline
set t_ti= t_te= "Keeps scrollback buffer

hi Search cterm=NONE ctermfg=grey ctermbg=blue

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
command! Colors XtermColorTable
