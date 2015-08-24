find ~/.vim -name "config" -path "*git*" |
xargs cat |
grep url |
cut -d " " -f3 |
sed -E 's/git@|git\:\/\//https\:\/\//' |
sed 's/com\:/com\//' |
xargs -I{} echo "git clone {}"
