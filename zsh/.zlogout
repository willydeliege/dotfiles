notmuch new
mbsync -a
notmuch new
cd ~/willydeliege/
git add .
git commit -am 'vault backup'
git push
cd ~/.dotfiles/
git add .
git commit -am 'save anyway'
git push
cd 

