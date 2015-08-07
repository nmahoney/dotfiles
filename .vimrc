execute pathogen#infect()
syntax on
filetype plugin indent on
runtime macros/matchit.vim
runtime ftplugin/man.vim

set autoread
set autowrite
set cursorline
set hidden
set hlsearch
set incsearch
set iskeyword+=-
set iskeyword+=:
set iskeyword+=_
set listchars=tab:▸\ ,eol:¬
set nobackup
set nocompatible
set noswapfile
set nowrap
set number
set splitbelow
set splitright
set t_ti= t_te= "Keeps scrollback buffer
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set wildignore+=vendor/ruby/**

"hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi Search cterm=underline ctermfg=NONE ctermbg=NONE
hi CursorLine cterm=NONE ctermbg=236

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

" Split config
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Don't resize automatically.
let g:golden_ratio_autocommand = 0

" Buffer navigation
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>

" mimic dot operator in visual mode
vnoremap . :normal .<CR>

if has("autocmd")
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
map <Leader>[ :call RunLastSpec()<CR>
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
