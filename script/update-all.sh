#!/bin/bash

sudo chown -R zhengkai:zhengkai /home/zhengkai

dir=$(dirname `readlink -f $0`);

conf_vim="$HOME/.vim/.git"
if [ -d "$conf_vim" ]; then
	cd $conf_vim
	cd ..
	git pull --rebase
	cd $dir
fi
if [ -f $HOME/.vim/vundle.vim ]; then
	vim +BundleInstall +qall 2>&1 >/dev/null &
	cd $dir
fi

conf_git="$HOME/conf/.git"
if [ -d "$conf_git" ]; then
	cd $conf_git
	cd ..
	git pull --rebase
	cd $dir
fi

$dir/php.manual.sh 2>&1

is_ubuntu=`grep 'Ubuntu ' /etc/issue`
if [ -n "$is_ubuntu" ]; then
	$dir/update_ubuntu.sh 2>&1
fi

../composer/update.sh

checkdir=(
	/www/kt
	/www/core
	/www/soulogic
)

for check in ${checkdir[@]}; do
	if [ -f "$check/composer.json" ]; then
		cd $check
		composer update &
	fi
done
wait
cd $dir
