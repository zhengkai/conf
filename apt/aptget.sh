#!/bin/bash
DIR=`readlink -f "$0"` && DIR=`dirname "$DIR"` && cd "$DIR" || exit 1

if [ -f ~/.ssh/id_rsa.pub ] && [ ! -e ~/.ssh/authorized_keys ]; then
	cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
fi

sudo chown -R zhengkai:zhengkai /home/zhengkai

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

list=(`cat list-aptget`)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq ${list[@]}

sudo apt-get remove -y fonts-droid

sudo systemctl disable webhook
sudo systemctl disable shadowsocks-libev

sudo adduser zhengkai www-data

touch ~/.vim/.viminfo
sudo chown -R zhengkai:zhengkai ~/

mkdir -p ~/script
if [ ! -e "$HOME/script/daily.sh" ]; then
	cp ../script/customize/daily.sh ~/script/
fi

./desktop.sh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-update-rc --no-fish --no-bash

../update/npm.sh
../update/pip.sh
