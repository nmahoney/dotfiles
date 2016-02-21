let g:pathogen_disabled = []

" Decreasing startup time
"call add(g:pathogen_disabled, 'vim-rails')
"runtime ftplugin/man.vim

execute pathogen#infect()
syntax on
filetype plugin indent on
runtime macros/matchit.vim

command! Colors XtermColorTable

set autoread
set autowrite
set cursorline
set gdefault
set hidden
set hlsearch
set incsearch
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:⌴
set showbreak=❯
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
set updatetime=1

set wildignore+=vendor/ruby/**
set wildignore+=*.a,*.o
set wildignore+=.DS_STORE
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=*.pyc

set timeoutlen=1000 ttimeoutlen=0 "Fast mode switching

nnoremap <leader><leader> <c-^>
nnoremap <leader><space> :nohlsearch<cr>
nnoremap <leader>a :Ack <cword><CR>
vnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>
nnoremap <leader>b :Gblame<CR>
nnoremap <leader>c :call ToggleColors()<CR>
nnoremap <leader>e :edit %%
nnoremap <leader>f :CommandTFlush<CR>
nmap <leader>g <Plug>(golden_ratio_resize)
nnoremap <leader>l :setlocal number!<CR>
nnoremap <leader>n :call RenameFile()<cr>
nnoremap <leader>p :set paste!<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>rc :vs $MYVIMRC<CR>
nnoremap <leader>re :vs ~/.dotfiles/.vimrc.todo<CR>
nnoremap <leader>s :so ~/.vimrc<CR> <bar> :echo 'vimrc reloaded'<CR>
nnoremap <leader>sp :set spell! spelllang=en_us<CR>
nnoremap <leader>ss :mksession<CR> " vim -S reopens
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

" Custom commands
command! Str :call <SID>StripTrailingWhitespace()

" Plugin config
let g:golden_ratio_autocommand = 0
let g:rspec_command = "!bundle exec rspec {spec}"
"let g:ctrlp_show_hidden = 1
"let g:ctrlp_match_window = 'bottom,order:ttb,min:5,max:10,results:10'

if has("gui_running")
  set guifont=Source\ Code\ Pro:h18
end

if has("autocmd")
  augroup vimrc
    " Clear autocommands
    autocmd!

    autocmd VimResized * :wincmd =
    autocmd BufLeave,FocusLost * silent! wa
    "autocmd BufWritePre * :call <SID>StripTrailingWhitespace()
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd FileType c nnoremap <leader>mr :call MakeAndRun()<cr>
    autocmd FileType c nnoremap <leader>m :call Make()<cr>

    autocmd FileType markdown,text set wrap

    " Turn off auto-commenting
    autocmd FileType * setlocal fo-=r fo-=o

    autocmd FileType erb let b:surround_{char2nr('=')} = "<%= \r %>"
    autocmd FileType erb let b:surround_{char2nr('-')} = "<% \r %>"

    autocmd FileType ruby nnoremap <leader>sty :call ToggleCC()<cr>
    autocmd FileType ruby nnoremap <cr> :call RubyEnter()<cr>
    autocmd FileType ruby nnoremap <Leader>] :call RunNearestSpec()<CR>
    autocmd FileType ruby nnoremap <Leader>[ :call RunLastSpec()<CR>
    "autocmd FileType ruby nnoremap <Leader><cr> :call RunAllSpecs()<CR>

    autocmd FileType python nnoremap <cr> :!ipython %<cr>

    autocmd BufReadPost * :call MoveToMostRecentLine()

    " autosave every updatetime secs
    if bufname('%') != ''
      autocmd CursorHold,CursorHoldI * update
    endif

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
    setlocal cc=80
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

function! <SID>StripTrailingWhitespace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfunction

function! IsIterm()
  if $TERM == 'xterm-256color'
    return 1
  else
    return 0
  endif
endfunction

function! RubyEnter()
  if IsSpecFile()
    call RunCurrentSpecFile()
  else
    :!ruby %<cr>
  endif
endfunction

function! IsSpecFile()
  if match(@%, '_spec.rb') == -1
    return 0
  else
    return 1
  endif
endfunction

function! Day()
  if IsIterm()
    silent exec "!set_light_iterm.sh"
  endif

  let g:solarized_termcolors=256
  let g:solarized_termtrans = 0

  set background=light
  colorscheme solarized
endfunction

function! Night()
  if IsIterm()
    silent exec "!set_dark_iterm.sh"
  endif

  let g:solarized_termcolors=256
  let g:solarized_termtrans = 1

  set background=dark
  colorscheme solarized

  call CustomizeColors()
endfunction

function! ToggleColors()
  if &background == 'dark'
    call Day()
  else
    call Night()
  endif

  call CustomizeColors()
endfunction

function! CustomizeColors()
  if &background == 'dark'
    hi CursorLine cterm=NONE ctermbg=236
  endif

  "hi Search cterm=NONE ctermfg=grey ctermbg=blue
  hi Search cterm=underline ctermfg=NONE ctermbg=NONE
  hi IncSearch cterm=underline ctermfg=NONE ctermbg=NONE
endfunction

call Night()
