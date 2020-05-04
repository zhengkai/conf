#!/bin/bash
session=tilda

for line in `tmux list-windows -F "#{window_index}:#{window_name}" -t $session`; do
	window=`echo $line | cut -d: -f1 2>/dev/null`
	name=`echo $line | cut -d: -f2 2>/dev/null`
	if [ $name != 'bash' ]; then
		continue
	fi
	
	cmd='/usr/bin/tmux send-keys -t '$session':'$window' C-c C-m ". ~/.zhengkai" C-m'
	echo $cmd | bash
done

