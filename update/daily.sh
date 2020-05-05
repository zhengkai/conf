#!/bin/bash -e

~/conf/script/safe-git-pull.sh ~/.vim &
#~/.vim/update.sh || : &

~/conf/script/safe-git-pull.sh ~/conf &
~/conf/script/safe-git-pull.sh ~/build &
~/conf/script/safe-git-pull.sh ~/hide &

./npm.sh || : &
./pip.sh || : &

./ubuntu.sh &

CHN="$HOME/hide/redir/chn/update.sh"
if [ -x "$CHN" ]; then
	"$CHN" &
fi

wait

sudo chown -R zhengkai:zhengkai /home/zhengkai

./clean-motd.sh

./before-reboot.sh
./reboot-check.sh
