execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
set listchars=tab:▸\ ,eol:¬
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set number
set wildignore+=vendor/ruby/**
set hidden
set t_ti= t_te= "Keeps scrollback buffer
set autoread
set nobackup
set noswapfile

command! Colors XtermColorTable

" Search config
set hlsearch
set incsearch
hi Search cterm=underline ctermfg=NONE ctermbg=NONE
"hi Search cterm=NONE ctermfg=grey ctermbg=blue
nnoremap <CR> :nohlsearch<cr>

" Cursor config
set cursorline
hi CursorLine cterm=NONE ctermbg=236

" Split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

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
