let g:pathogen_disabled = []

" Decreasing startup time
call add(g:pathogen_disabled, 'vim-rails')
"runtime ftplugin/man.vim

execute pathogen#infect()
syntax on
filetype plugin indent on
runtime macros/matchit.vim

command! Colors XtermColorTable

"hi Search cterm=NONE ctermfg=grey ctermbg=blue
hi Search cterm=underline ctermfg=NONE ctermbg=NONE
hi CursorLine cterm=NONE ctermbg=236

set autoread
set autowrite
set cursorline
set gdefault
set hidden
set hlsearch
set incsearch
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:⌴
set showbreak=↪
set nobackup
set nocompatible
set noswapfile
set nowrap
set number
set smartcase
set splitbelow
set splitright
set t_ti= t_te= "Keeps scrollback buffer
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set wildignore+=vendor/ruby/**
set timeoutlen=1000 ttimeoutlen=0 "Fast mode switching

nnoremap <leader><leader> <c-^>
nnoremap <leader><space> :nohlsearch<cr>
nnoremap <leader>a :Ack <cword><CR>
vnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>
nnoremap <leader>b :Gblame<CR>
nnoremap <leader>c :call ToggleColors()<CR>
nnoremap <leader>ch :set spell! spelllang=en_us<CR>
nnoremap <leader>e :edit %%
nnoremap <leader>f :CommandTFlush<CR>
nnoremap <leader>l :setlocal number!<CR>
nnoremap <leader>n :call RenameFile()<cr>
nnoremap <leader>p :set paste!<CR>
nnoremap <leader>q :q<CR>
nmap <leader>r <Plug>(golden_ratio_resize)
nnoremap <leader>rc :vs $MYVIMRC<CR>
nnoremap <leader>s :so ~/.vimrc<CR> <bar> :echo 'vimrc reloaded'<CR>
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>wh :set list!<CR>
nnoremap <leader>wr :set wrap!<CR>
nnoremap <leader>x :x<CR>
vnoremap <leader>y "+y<CR>

" navigate up/down in wrap mode
nnoremap j gj
nnoremap k gk

" Diable arrow key usage
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Split navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap <c-J> <c-w>j
nnoremap <c-K> <c-w>k
nnoremap <c-H> <c-w>h
nnoremap <c-L> <c-w>l

nnoremap <c-w>j <nop>
nnoremap <c-w>k <nop>
nnoremap <c-w>h <nop>
nnoremap <c-w>l <nop>

" Buffer behavior
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
"not working
nnoremap <C-s> :w<CR>
nnoremap n nzz
nnoremap N Nzz

" %% yields directory of current buffer
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" mimic dot operator in visual mode
vnoremap . :normal .<CR>

" Native and plugin block matching
map <tab> %

" Stay still on cursor search
nnoremap * *<c-o>
nnoremap # #<c-o>

" Select pasted text
nnoremap gp `[v`]

" Move cursor to end of paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Python-style regex
nnoremap / /\v
vnoremap / /\v

" Plugin config
let g:golden_ratio_autocommand = 0
let g:rspec_command = "!bundle exec rspec {spec}"

if has("gui_running")
  set guifont=Source\ Code\ Pro:h18
end

if has("autocmd")
  augroup vimrc
    " Clear autocommands
    autocmd!

    autocmd FocusLost * :wa
    autocmd BufWritePre *.js,*.rb :call <SID>StripTrailingWhitespaces()
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd FileType c nnoremap <leader>mr :call MakeAndRun()<cr>
    autocmd FileType c nnoremap <leader>m :call Make()<cr>

    " Turn off auto-commenting
    autocmd FileType * setlocal fo-=r fo-=o

    autocmd FileType erb let b:surround_{char2nr('=')} = "<%= \r %>"
    autocmd FileType erb let b:surround_{char2nr('-')} = "<% \r %>"

    autocmd FileType ruby nnoremap <leader>m :!ruby %<cr>
    autocmd FileType ruby nnoremap <leader>g :call ToggleCC()<cr>
    autocmd FileType ruby nnoremap <cr> :call RunCurrentSpecFile()<CR>
    autocmd FileType ruby nnoremap <Leader>] :call RunNearestSpec()<CR>
    autocmd FileType ruby nnoremap <Leader>[ :call RunLastSpec()<CR>
    "autocmd FileType ruby nnoremap <Leader><cr> :call RunAllSpecs()<CR>

    autocmd BufReadPost * :call MoveToMostRecentLine()
  augroup end
endif

" ----------------------------------- FUNCTIONS -----------------------------------------
function! MoveToMostRecentLine()
  if line("'\"") > 0 && line("'\"") <= line("$") |
    execute 'normal! g`"zvzz' |
  endif
endfunction

function! Make()
  if filereadable("./Makefile")
    :!make -C %:p:h
  else
    :!gcc % -o %<
  end
endfunction

function! MakeAndRun()
  call Make()
  :!./%<
endfunction

function! ToggleCC()
  if &cc
    setlocal cc=0
  else
    setlocal cc=0
  endif
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

function! Day()
  let g:solarized_termtrans = 0

  set background=light
  colorscheme solarized
endfunction

function! Night()
  " use terminal background
  let g:solarized_termtrans = 1

  set background=dark
  colorscheme solarized
endfunction


function! ToggleColors()
  if &background == 'dark'
    call Day()
  else
    call Night()
  endif
endfunction
