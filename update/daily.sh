#!/bin/bash -e

cd "$(dirname "$(readlink -f "$0")")" || exit 1

#~/conf/script/safe-git-pull.sh ~/.vim &
#~/.vim/update.sh || : &

~/conf/script/safe-git-pull.sh ~/conf &
~/conf/script/safe-git-pull.sh ~/build &
~/conf/script/safe-git-pull.sh ~/.config/nvim &

if [ -x ~/hide/pac/run.sh ]; then
	(
		~/conf/script/safe-git-pull.sh ~/hide || :
		~/hide/pac/run.sh
	) &
fi

./docker.sh &

./npm.sh || : &
./pip.sh || : &

./ubuntu.sh &

CHN="${HOME}/hide/redir/chn/update.sh"
if [ -x "$CHN" ]; then
	"$CHN" &
fi

./clean.sh &

if [ "$USER" == 'zhengkai' ]; then
	sudo chown -R zhengkai:zhengkai /home/zhengkai &
fi

wait

./before-reboot.sh || :
./reboot-check.sh
