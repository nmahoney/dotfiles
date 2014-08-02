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

command! Colors XtermColorTable

" Autoload vimrc on write
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" %% yields directory of current buffer
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" Rename current file
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" Search configuration
"hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi Search cterm=underline ctermfg=NONE ctermbg=NONE
nnoremap <CR> :nohlsearch<cr>
