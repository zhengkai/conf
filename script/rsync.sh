#!/bin/bash
script=`basename $0`
sleep 1 

ifrunning=`ps -ef | grep -w $script | grep -v "grep" | wc -l`
ifrunning=`ps aux | grep -w $script | grep -v "grep"`
echo $ifrunning
exit

echo "[ $ifrunning $script ]"

if [ $ifrunning > 2 ]
then
	echo "script $script running, stop"
else
	echo "nothing"
fi


sleep 20

exit
