" vim: foldmethod=marker

"plugins {{{
call plug#begin()
" styles
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'guns/xterm-color-table.vim'

" testing
Plug 'janko-m/vim-test'
Plug 'thoughtbot/vim-rspec'

" search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mileszs/ack.vim'
Plug 'wincent/command-t', { 'do': 'rake make && gem install neovim' }

" syntax
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'jparise/vim-graphql'

" autocomplete
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" panes
Plug 'roman/golden-ratio'

" editing
Plug 'junegunn/vim-easy-align'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
call plug#end()
"}}}

" settings {{{
syntax on
filetype plugin indent on
runtime macros/matchit.vim

set autoread
set autowrite
set cursorline
set foldmethod=marker
set gdefault
set hidden
set hlsearch
set incsearch
set laststatus=0
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮,trail:⌴
set nobackup
set nocompatible
set noswapfile
set nowrap
set number
set showbreak=❯
set smartcase
set splitbelow
set splitright
set t_ti= t_te= "Keeps scrollback buffer
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set timeoutlen=1000 ttimeoutlen=0 "Fast mode switching
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

" JS
set wildignore+=node_modules
set wildignore+=*.d.ts

set wildignore+=tmp
set wildignore+=.DS_Store
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=db/sphinx/**
"}}}

"plugin config {{{
"let g:ctrlp_match_window = 'bottom,order:ttb,min:5,max:10,results:10'
"let g:ctrlp_show_hidden = 1
let g:CommandTTraverseSCM="pwd"
let g:CommandTWildIgnore=&wildignore
let g:ackprg = "ag --nogroup --nocolor --column"
let g:fzf_layout = {'down': '30%'}
let g:golden_ratio_autocommand = 0
let g:rspec_command = "!bundle exec rspec {spec}"
let g:test#javascript#cypress#file_pattern = 'cypress/.*spec\.js'
let g:test#javascript#jest#file_pattern = '__test__/.*test\.js'
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-json',
  \ 'coc-eslint',
  \ 'coc-prettier'
  \ ]

source ~/.dotfiles/coc-config.vim
"}}}

" mappings {{{
nnoremap <leader><leader> <c-^>
nnoremap <leader>a :Ack <cword><CR>
vnoremap <Leader>a y:Ack <C-r>=fnameescape(@")<CR><CR>
nnoremap <leader>b :Git blame<CR>
vnoremap <leader>b :Gclog<CR>
nnoremap <leader>e :edit %%
nnoremap <leader>f :CommandTFlush<CR>
nnoremap <leader>fz :FZF<CR>
nmap <leader>g <Plug>(golden_ratio_resize)
nnoremap <leader>n :call RenameFile()<cr>
nnoremap <leader>p :CocCommand prettier.formatFile<cr>
nnoremap <leader>q :q<CR>
nnoremap <leader>rc :vs $MYVIMRC<CR>
nnoremap <leader>re :vs ~/.dotfiles/.vimrc.todo<CR>
nnoremap <leader>s :so ~/.vimrc<CR> <bar> :echo 'vimrc reloaded'<CR>
nnoremap <leader>ss :mksession<CR> " vim -S reopens
nnoremap <leader>t :CommandT<CR>
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

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
"}}}

" commands {{{
command! Colors XtermColorTable
command! Str :call <SID>StripWhitespace()

if has("gui_running")
  set guifont=Source\ Code\ Pro:h18
end

if has("nvim")
  " for plugins requiring ruby (commandT)
  " this should always match the latest system ruby installation of the neovim gem
  let g:ruby_host_prog = '/usr/local/lib/ruby/gems/3.0.0/bin/neovim-ruby-host'

  " vim does not support dynamic show/hide
  set signcolumn=auto:1
endif

if has("autocmd")
  augroup vimrc
    " Clear autocommands
    autocmd!

    " Turn off auto-commenting
    autocmd FileType * setlocal fo-=r fo-=o

    " Autosave every updatetime secs
    autocmd CursorHold,CursorHoldI * silent! update

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
    autocmd FileType javascript nnoremap <cr> :call JavascriptEnter()<cr>
    autocmd FileType javascript nnoremap <Leader>] :TestNearest<cr>
    autocmd FileType javascript nnoremap <Leader>[ :TestLast<cr>

    " TYPESCRIPT
    autocmd FileType typescript nnoremap :!ts-node %<cr>

    " R
    autocmd FileType r nnoremap <cr> :!Rscript %<cr>

    " OCTAVE
    autocmd FileType matlab nnoremap <cr> :!octave %<cr>

    " SHELL
    autocmd FileType sh nnoremap <cr> :!./%<cr>

    " TEXT
    autocmd FileType markdown,text set wrap
    autocmd FileType markdown,text set linebreak
    autocmd FileType markdown,text set showbreak=""

    " JAVA
    autocmd FileType java nnoremap <cr> :call JavaEnter()<cr>
    autocmd FileType java nnoremap <Leader>] :TestNearest --quiet<cr>
    autocmd FileType java nnoremap <Leader>[ :TestLast<cr>

    " GROOVY
    autocmd BufNewFile,BufRead Jenkinsfile* setf groovy
  augroup end
endif
"}}}

" functions {{{
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

function! RubyEnter()
  if IsSpecFile()
    call RunCurrentSpecFile()
  elseif IsTestFile()
    :!bundle exec rake test %
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

function! JavascriptEnter()
  if match(@%, 'cypress') == -1 && match(@%, '__test__') == -1
    :!node %
  else
    :TestFile
  end
endfunction

function! IsSpecFile()
  if match(@%, '_spec.rb') == -1 && match(@%, 'Test.java') == -1
    return 0
  else
    return 1
  endif
endfunction

function! IsTestFile()
  if match(@%, '_test.rb') == -1
    return 0
  else
    return 1
  endif
endfunction

function! Day()
  let g:solarized_termtrans = 0

  set background=light
endfunction

function! Night()
  set background=dark

  " overrides, must be called after colorscheme command
  hi CursorLine cterm=NONE ctermbg=0

  hi Search cterm=underline ctermfg=NONE ctermbg=NONE
  hi Search gui=underline guifg=NONE guibg=NONE

  hi IncSearch cterm=underline ctermfg=NONE ctermbg=NONE
  hi IncSearch gui=underline guifg=NONE guibg=NONE

  hi clear SignColumn
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

function! SetColor()
  if $COLORTERM == 'truecolor'
    " terminal supports true color/rgb color
    set termguicolors
    silent! colorscheme solarized8_flat
  else
    " fallback for mac terminal/256 color
    let g:solarized_termtrans = 1
    let g:solarized_termcolors = 256
    silent! colorscheme solarized
  endif

  call Night()
endfunction

call SetColor()
"}}}
