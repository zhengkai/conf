#!/bin/bash

VIM_DIR="$HOME/.vim"

if [ -e "$VIM_DIR" ]; then
	echo "$VIM_DIR ready been installed"
	exit
fi

git clone --depth 1 https://github.com/zhengkai/vimrc.git "$VIM_DIR"

mkdir -p "$HOME/.tmp/vim-undo"
mkdir -p "$HOME/.tmp/vim-swap"
cd "$VIM_DIR" || exit 1
git submodule update --init --recursive
#vim +PlugInstall +qall
