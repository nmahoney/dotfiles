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
set autoread
set nobackup
set noswapfile

hi Search cterm=NONE ctermfg=grey ctermbg=blue
command! Colors XtermColorTable

if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif
