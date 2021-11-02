#!/bin/bash -e

cd "$(dirname "$(readlink -f "$0")")" || exit 1

#~/conf/script/safe-git-pull.sh ~/.vim &
#~/.vim/update.sh || : &

~/conf/script/safe-git-pull.sh ~/conf &
~/conf/script/safe-git-pull.sh ~/build &
~/conf/script/safe-git-pull.sh ~/hide &

./docker.sh &

# ./npm.sh || : &
# ./pip.sh || : &

./ubuntu.sh &

CHN="$HOME/hide/redir/chn/update.sh"
if [ -x "$CHN" ]; then
	"$CHN" &
fi

if [ -w /go/tmp ]; then
	find /go/tmp -mtime +10 -delete
fi
if [ -w ~/.tmp/vim-undo ]; then
	find ~/.tmp/vim-undo -mtime +10 -delete
fi

wait

sudo chown -R zhengkai:zhengkai /home/zhengkai

./clean-motd.sh || :
./before-reboot.sh || :
./reboot-check.sh
