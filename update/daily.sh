#!/bin/bash -x

cd "$(dirname "$(readlink -f "$0")")" || exit 1

mkdir -p "/tmp/${USER}"
export TMPDIR="/tmp/${USER}"

#~/conf/script/safe-git-pull.sh ~/.vim &
#~/.vim/update.sh || : &

~/conf/script/safe-git-pull.sh ~/conf
~/conf/script/safe-git-pull.sh ~/build
~/conf/script/safe-git-pull.sh ~/.config/nvim

if [ -x ~/hide/pac/run.sh ]; then
	(
		~/conf/script/safe-git-pull.sh ~/hide || :
		~/hide/pac/run.sh
	)
fi

if [ -x ~/hide/backup/run.sh ]; then
	~/hide/backup/run.sh || :
fi

if [ -x ~/cert/run.sh ]; then
	~/cert/run.sh || :
fi

./docker.sh

if [ -e /usr/bin/docker ]; then
	sudo docker system prune -f || :
fi

./npm.sh || :
./pip.sh || :

DOW="$(date +%u)"
if [ -d /www/luigi ]; then
	# 生产机只在周二更新 ubuntu
	if [ "$DOW" -eq 2 ]; then
		./ubuntu.sh
	fi
else
	# 周六日不更新 ubuntu
	if [[ "$DOW" -lt 6 ]]; then
		./ubuntu.sh
	fi
fi

CHN="${HOME}/hide/redir/chn/update.sh"
if [ -x "$CHN" ]; then
	"$CHN"
fi

./clean.sh

if [ -d "/home/${USER}" ]; then
	sudo chown -R "${USER}:${USER}" "/home/${USER}"
fi

if [ "$1" == "no-reboot" ]; then
	exit
fi

wait

if [ -d /www/luigi ] && [ "$DOW" -ne 2 ]; then
    exit
fi

./before-reboot.sh || :
./reboot-check.sh
