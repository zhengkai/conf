#!/bin/bash

~/conf/script/safe-git-pull.sh ~/.vim
~/.vim/update.sh || : &

~/conf/script/safe-git-pull.sh ~/conf &
~/conf/script/safe-git-pull.sh ~/build &
~/conf/script/safe-git-pull.sh ~/hide &

wait

~/conf/update/daily.sh
