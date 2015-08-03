execute pathogen#infect()
syntax on
filetype plugin indent on
runtime macros/matchit.vim
runtime ftplugin/man.vim

set nocompatible
set listchars=tab:▸\ ,eol:¬
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set number
set hidden
set t_ti= t_te= "Keeps scrollback buffer
set autoread
set nobackup
set noswapfile
set nowrap
set iskeyword+=_
set iskeyword+=-
set iskeyword+=:
set autowrite
set wildignore+=vendor/ruby/**

command! Colors XtermColorTable

" %% yields directory of current buffer
cnoremap %% <C-R>=expand('%:h').'/'<cr>

nnoremap <leader><leader> <c-^>
nnoremap <leader>b :Gblame<CR>
nnoremap <leader>c :so ~/.vimrc<CR> <bar> :echo 'vimrc reloaded'<CR>
nnoremap <leader>e :edit %%
nnoremap <leader>f :CommandTFlush<CR>
nnoremap <leader>g :sp Gemfile<cr>
nnoremap <leader>gr :sp config/routes.rb<cr>
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>l :setlocal number!<CR>
nnoremap <leader>n :call RenameFile()<cr>
nnoremap <leader>p :set paste!<CR>
nnoremap <leader>r <Plug>(golden_ratio_resize)
nnoremap <leader>s :set list!<CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>w :set wrap!<CR>

" navigate up/down in wrap mode
nnoremap j gj
nnoremap k gk

" Diable arrow key usage
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Search config
set hlsearch
set incsearch
hi Search cterm=underline ctermfg=NONE ctermbg=NONE
"hi Search cterm=NONE ctermfg=grey ctermbg=blue

" Cursor config
set cursorline
hi CursorLine cterm=NONE ctermbg=236

" Split config
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
set splitbelow
set splitright

" Don't resize automatically.
let g:golden_ratio_autocommand = 0

" Buffer navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" mimic dot operator in visual mode
vnoremap . :normal .<CR>

if has("autocmd")
  " Autoload vimrc on write
  autocmd bufwritepost .vimrc source $MYVIMRC

  " Remove highlight on insert mode
  autocmd InsertEnter,InsertLeave * set cul!
  autocmd BufWritePre *.js,*.rb :call <SID>StripTrailingWhitespaces()

  autocmd FileType erb let b:surround_{char2nr('=')} = "<%= \r %>"
  autocmd FileType erb let b:surround_{char2nr('-')} = "<% \r %>"

  autocmd FileType ruby nnoremap <leader>m :!ruby %<cr>

  autocmd FileType c nnoremap <leader>m :call Make()<cr>

  " Turn off auto-commenting
  autocmd FileType * setlocal fo-=r fo-=o
endif

" Spec running
let g:rspec_command = "!bundle exec rspec {spec}"
map <cr> :call RunCurrentSpecFile()<CR>
map <Leader>] :call RunNearestSpec()<CR>
"map <Leader>l :call RunLastSpec()<CR>
"map <Leader><cr> :call RunAllSpecs()<CR>

" ----------------------------------- FUNCTIONS -----------------------------------------

function! Make()
  :!make -C %:p:h
endfunction

function! MakeAndRun()
  " TODO
endfunction

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

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
