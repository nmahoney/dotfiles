ls -d ~/.vim/bundle/*/.git | xargs -t -I{} git --git-dir {} pull
