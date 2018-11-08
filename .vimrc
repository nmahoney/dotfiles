" Decreasing startup time
"runtime ftplugin/man.vim

call plug#begin()
Plug 'altercation/vim-colors-solarized'
Plug 'guns/xterm-color-table.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mileszs/ack.vim'
Plug 'roman/golden-ratio'
Plug 'sjl/gundo.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'janko-m/vim-test'
Plug 'wellle/targets.vim'
Plug 'wincent/command-t', { 'do': 'rake make' }
call plug#end()

" Plugin config
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

let g:golden_ratio_autocommand = 0
let g:rspec_command = "!bundle exec rspec {spec}"
let g:ackprg = "ag --nogroup --nocolor --column"
"let g:ctrlp_show_hidden = 1
"let g:ctrlp_match_window = 'bottom,order:ttb,min:5,max:10,results:10'

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

" RUBY
set wildignore+=vendor
set wildignore+=app/assets/fonts/**

" PYTHON
set wildignore+=*.pyc

" JAVA
set wildignore+=target
set wildignore+=*.jar,*.class

" C
set wildignore+=*.a,*.o

set wildignore+=tmp
set wildignore+=.DS_Store
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=db/sphinx/**

let g:CommandTWildIgnore=&wildignore

set timeoutlen=1000 ttimeoutlen=0 "Fast mode switching

nnoremap <leader><leader> <c-^>
nnoremap <leader>a :Ack <cword><CR>
vnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>
nnoremap <leader>b :Gblame<CR>
vnoremap <leader>b :Glog<CR>
nnoremap <leader>c :call ToggleColors()<CR>
nnoremap <leader>e :edit %%
nnoremap <leader>f :CommandTFlush<CR>
nmap <leader>g <Plug>(golden_ratio_resize)
nnoremap <leader>n :call RenameFile()<cr>
nnoremap <leader>q :q<CR>
nnoremap <leader>rc :vs $MYVIMRC<CR>
nnoremap <leader>re :vs ~/.dotfiles/.vimrc.todo<CR>
nnoremap <leader>s :so ~/.vimrc<CR> <bar> :echo 'vimrc reloaded'<CR>
nnoremap <leader>ss :mksession<CR> " vim -S reopens
nnoremap <leader>u :GundoToggle<CR>
nnoremap <leader>v :vs<CR>
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

" Unimpaired.vim extensions
nnoremap [d :-1d"<CR>
nnoremap ]d :+1d<CR>k
nnoremap []q :call ToggleQuickfix()<CR>
nnoremap []<Space> [<Space>]<Space>

" Center as moving through search terms
nnoremap n nzz
nnoremap N Nzz

" %% yields directory of current buffer
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" mimic dot operator in visual mode
vnoremap . :normal .<CR>

" Native and plugin block matching
map <tab> %

" More consistent with other upcase bindings
map Y y$

" Stay still on cursor search
nnoremap * *<c-o>
nnoremap # #<c-o>

" Select pasted text
" stopped working somewhere in 7.x
" [] registers do not get updated on paste
"nnoremap gp `[v`]

" Move cursor to end of paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Custom commands
command! Str :call <SID>StripWhitespace()

if has("gui_running")
  set guifont=Source\ Code\ Pro:h18
end

if has("autocmd")
  augroup vimrc
    " Clear autocommands
    autocmd!

    " Turn off auto-commenting
    autocmd FileType * setlocal fo-=r fo-=o

    " Autosave every updatetime secs
    autocmd CursorHold,CursorHoldI * silent! update

    " Autoflush CommandT
    autocmd FocusGained * CommandTFlush
    autocmd BufWritePost * CommandTFlush

    autocmd VimResized * :wincmd =
    autocmd BufLeave,FocusLost * silent! wa
    autocmd BufWritePost .vimrc source $MYVIMRC
    autocmd BufReadPost * :call MoveToMostRecentLine()

    " RUBY
    autocmd FileType ruby nnoremap <leader>sty :call ToggleCC()<cr>
    autocmd FileType ruby nnoremap <cr> :call RubyEnter()<cr>
    autocmd FileType ruby nnoremap <Leader>] :call RunNearestSpec()<CR>
    autocmd FileType ruby nnoremap <Leader>[ :call RunLastSpec()<CR>
    "autocmd FileType ruby nnoremap <Leader><cr> :call RunAllSpecs()<CR>

    " inspired by vim-ragtag
    autocmd FileType eruby let b:surround_{char2nr('=')} = "<%= \r %>"
    autocmd FileType eruby let b:surround_{char2nr('-')} = "<% \r %>"
    autocmd FileType eruby let b:surround_{char2nr('#')} = "<%# \r %>"

    " PYTHON
    autocmd FileType python nnoremap <cr> :!ipython %<cr>

    " C
    autocmd FileType c nnoremap <leader>mr :call MakeAndRun()<cr>
    autocmd FileType c nnoremap <leader>m :call Make()<cr>

    " JAVASCRIPT
    autocmd FileType javascript nnoremap <cr> :!node  %<cr>

    " R
    autocmd FileType r nnoremap <cr> :!Rscript %<cr>

    " OCTAVE
    autocmd FileType matlab nnoremap <cr> :!octave %<cr>

    " SHELL
    autocmd FileType sh nnoremap <cr> :!sh %<cr>

    " TEXT
    autocmd FileType markdown,text set wrap
    autocmd FileType markdown,text set linebreak
    autocmd FileType markdown,text set showbreak=""

    " JAVA
    autocmd FileType java nnoremap <cr> :call JavaEnter()<cr>
    autocmd FileType java nnoremap <Leader>] :TestNearest --quiet<cr>
    autocmd FileType java nnoremap <Leader>[ :TestLast<cr>

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

function! <SID>StripWhitespace()
  let l = line(".")
  let c = col(".")

  " remove trailing whitespace
  %s/\s\+$//e

  " remove successive empty lines
  %s/\v^(\s*\n){2,}/\r/e

  call cursor(l, c)
endfunction

function! IsIterm()
  if $TERM == 'iTerm.app'
    return 1
  else
    return 0
  endif
endfunction

function! RubyEnter()
  if IsSpecFile()
    call RunCurrentSpecFile()
  else
    :!ruby %
  endif
endfunction

function! JavaEnter()
  if IsSpecFile()
    :TestFile --quiet
  else
    :!jshell %
  endif
endfunction

function! IsSpecFile()
  if match(@%, '_spec.rb') == -1 && match(@%, 'Test.java') == -1
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
  silent! colorscheme solarized
endfunction

function! Night()
  if IsIterm()
    silent exec "!set_dark_iterm.sh"
  endif

  let g:solarized_termcolors=256
  let g:solarized_termtrans = 1

  set background=dark
  silent! colorscheme solarized

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
    hi CursorLine cterm=NONE ctermbg=0
  endif

  "hi Search cterm=NONE ctermfg=grey ctermbg=blue
  hi Search cterm=underline ctermfg=NONE ctermbg=NONE
  hi IncSearch cterm=underline ctermfg=NONE ctermbg=NONE
endfunction

function! ToggleQuickfix()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor

  copen
endfunction

function! SetColors()
  if IsIterm()
    silent! colorscheme solarized
  else
    call Night()
  endif
endfunction

call SetColors()
