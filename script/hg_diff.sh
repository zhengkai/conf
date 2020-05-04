#!/bin/bash

#alias gd='git diff --no-ext-diff -b -w -z --color=never | ~/conf/script/git_diff.php | less'

export LINES

let height=$LINES-3

count=`hg diff -g $@ | ~/conf/script/git_diff.php | head -n $height | wc -l`

if [ $count -ge $height ]; then
	hg diff -g $@ | ~/conf/script/git_diff.php | less -r
else
	hg diff -g $@ | ~/conf/script/git_diff.php
fi

