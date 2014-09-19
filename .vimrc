execute pathogen#infect()
syntax on
filetype plugin indent on
runtime macros/matchit.vim

set nocompatible
set listchars=tab:▸\ ,eol:¬
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set number
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

" Split config
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Navigation config
nnoremap <leader><leader> <c-^>

if has("autocmd")
  " Autoload vimrc on write
  autocmd bufwritepost .vimrc source $MYVIMRC

  autocmd FileType erb let b:surround_{char2nr('=')} = "<%= \r %>"
  autocmd FileType erb let b:surround_{char2nr('-')} = "<% \r %>"
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

" Rails-specific config
map <leader>gr :sp config/routes.rb<cr>
map <leader>g :sp Gemfile<cr>
set wildignore+=vendor/ruby/**

" Bernhardt-style test running
function! MapCR()
  nnoremap <cr> :call RunTestFile()<cr>
endfunction
"call MapCR() " leave <cr> to search clearing for now
nnoremap <leader>T :call RunNearestTest()<cr>
nnoremap <leader>a :call RunTests('')<cr>
function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number)
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

function! RunTests(filename)
    " Write the file and run tests for the given filename
    if expand("%") != ""
      :w
    end
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        " First choice: project-specific test script
        if filereadable("script/test")
            exec ":!script/test " . a:filename
        " Fall back to the .test-commands pipe if available, assuming someone
        " is reading the other side and running the commands
        elseif filewritable(".test-commands")
          let cmd = 'rspec --color --format progress --require "~/lib/vim_rspec_formatter" --format VimFormatter --out tmp/quickfix'
          exec ":!echo " . cmd . " " . a:filename . " > .test-commands"

          " Write an empty string to block until the command completes
          sleep 100m " milliseconds
          :!echo > .test-commands
          redraw!
        " Fall back to a blocking test run with Bundler
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        " Fall back to a normal blocking test run
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction
