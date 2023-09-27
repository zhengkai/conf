#!/bin/bash -e

cd "$(dirname "$(readlink -f "$0")")" || exit 1

#~/conf/script/safe-git-pull.sh ~/.vim &
#~/.vim/update.sh || : &

sudo find /var/log/journal -name '*@*' -type f -ctime +10 -delete &

~/conf/script/safe-git-pull.sh ~/conf &
~/conf/script/safe-git-pull.sh ~/build &
~/conf/script/safe-git-pull.sh ~/.config/nvim &

~/conf/script/safe-git-pull.sh ~/hide || : &
if [ -x ~/hide/pac/run.sh ]; then
	~/hide/pac/run.sh &
fi

./docker.sh &

./npm.sh || : &
./pip.sh || : &

./ubuntu.sh &

CHN="${HOME}/hide/redir/chn/update.sh"
if [ -x "$CHN" ]; then
	"$CHN" &
fi

./clean-tmp.sh &

/usr/bin/trash-empty 30

wait

sudo chown -R zhengkai:zhengkai /home/zhengkai

./clean-motd.sh || :
./before-reboot.sh || :
./reboot-check.sh
