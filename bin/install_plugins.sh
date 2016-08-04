#!/bin/bash

root="$HOME/.vim/"
remote="https://github.com/"
ext=".git"
bundle=$root"bundle/"
autoload=$root"autoload/"

plugins=(
    "tpope/vim-surround"
    "tpope/vim-unimpaired"
    "tpope/vim-commentary"
    "tpope/vim-fugitive"
    "thoughtbot/vim-rspec"
    "roman/golden-ratio"
    "wincent/command-t"
    "altercation/vim-colors-solarized")


mkdir -p $autoload
mkdir -p $bundle

if [[ -d "$autoload" ]]
then
  cd $autoload
  curl -LSso pathogen.vim https://tpo.pe/pathogen.vim
else
  echo $autoload "does not exist"
fi

if [[ -d "$bundle" ]]
then
  cd $bundle

  for plugin in "${plugins[@]}"
  do
    git clone $remote$plugin$ext
  done
else
  echo $bundle "does not exist"
fi

# compile c-extensions
cd $bundle"command-t" && sudo rake make
