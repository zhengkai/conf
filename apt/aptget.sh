#!/bin/bash
DIR=$(readlink -f "$0") && DIR=$(dirname "$DIR") && cd "$DIR" || exit 1

if [ -f ~/.ssh/id_ecdsa.pub ] && [ ! -e ~/.ssh/authorized_keys ]; then
	cp ~/.ssh/id_ecdsa.pub ~/.ssh/authorized_keys
fi

sudo chown -R "${USER}:${USER}" "$HOME"

sudo cp ../misc/sudoers-nopassword /etc/sudoers.d/nopassword

mkdir -p ~/.tmp/vim-undo
mkdir -p ~/.tmp/vim-swap
mkdir -p ~/.tmp/ssh-mux
mkdir -p ~/.Trash

touch ~/.tmp/yankring_history_v2.txt
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
sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq "${list[@]}" || exit 1

sudo systemctl disable webhook
sudo systemctl disable shadowsocks-libev

sudo adduser "$USER" www-data

if [ -d ~/.vim ]; then
	touch ~/.vim/.viminfo
fi
sudo chown -R "${USER}:${USER}" ~/

DAILY_SH="$HOME/script/daily.sh"
if [ ! -e "$DAILY_SH" ]; then
	mkdir -p ~/script
	cp ../script/customize/daily.sh "$DAILY_SH"
fi

./desktop.sh

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --no-update-rc --no-fish --no-bash --completion --no-key-bindings

CHECK_ZHENGKAI=$(grep ' zhengkai' ~/.ssh/id_ecdsa.pub || :)
if [ -n "$CHECK_ZHENGKAI" ]; then
	if [ ! -e ~/hide ]; then
		git clone --depth 1 git@github.com:zhengkai/hide.git ~/hide
	fi
	if [ ! -e ~/build ]; then
		git clone --depth 1 git@github.com:zhengkai/build.git ~/build
	fi
fi

if [ ! -e /usr/bin/python ]; then
	sudo ln -s /usr/bin/python3 /usr/bin/python
fi

ln -s "/home/${USER}/.fzf/bin/fzf" "/home/${USER}/conf/bin/" || :
ln -s "/home/${USER}/.fzf/bin/fzf-tmux" "/home/${USER}/conf/bin/" || :

# ../update/npm.sh
# ../update/pip.sh
