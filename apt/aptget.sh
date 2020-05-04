#!/bin/bash
DIR=$(readlink -f "$0") && DIR=$(dirname "$DIR") && cd "$DIR" || exit 1

if [ -f ~/.ssh/id_rsa.pub ] && [ ! -e ~/.ssh/authorized_keys ]; then
	cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
fi

if [ ! -f ~/.ssh/id_rsa ]; then
	sed '/github\.com/d' -i ./dotfiles/gitconfig
fi

sudo chown -R "${USER}:${USER}" "$HOME"

sudo cp ../file/sudoers-nopassword /etc/sudoers.d/nopassword

mkdir -p ~/.tmp/vim-undo
mkdir -p ~/.tmp/vim-swap
mkdir -p ~/.tmp/ssh-mux
mkdir -p ~/.Trash

touch ~/conf/store/wget-cookie
touch ~/conf/store/wget-hsts
touch ~/conf/store/curl-cookie

sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq vim
sudo update-alternatives --set editor /usr/bin/vim.basic

# sudo sh -c 'echo "Asia/Shanghai" > /etc/timezone'
# sudo cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
sudo timedatectl set-timezone Asia/Shanghai

mapfile -t list < <(cat list-aptget)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq "${list[@]}"

sudo systemctl disable webhook
sudo systemctl disable shadowsocks-libev

sudo adduser "$USER" www-data

touch ~/.vim/.viminfo
sudo chown -R "${USER}:${USER}" ~/

mkdir -p ~/script
if [ ! -e "$HOME/script/daily.sh" ]; then
	cp ../script/customize/daily.sh ~/script/
fi

./desktop.sh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-update-rc --no-fish --no-bash

CHECK_ZHENGKAI=$(grep ' zhengkai' ~/.ssh/id_rsa.pub || :)
if [ -n "$CHECK_ZHENGKAI" ]; then
	if [ ! -e ~/hide ]; then
		git clone --depth 1 git@github.com:zhengkai/hide.git ~/hide
	fi
	if [ ! -e ~/build ]; then
		git clone --depth 1 git@github.com:zhengkai/build.git ~/build
	fi
fi

# ../update/npm.sh
../update/pip.sh
