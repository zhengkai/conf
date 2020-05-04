#!/bin/bash -ex

gnome-terminal -- "/bin/bash" "$HOME/conf/script/tmux.sh" 2>/dev/null &

PID=$!
echo $PID
ps aux | grep $PID

echo 'search'
xdotool search --pid "$PID"
# xdotool windowmove "window=%1" 1920 0
echo 'end'
#

# gnome-terminal -- "/bin/bash" "$HOME/conf/script/tmux.sh"
#
