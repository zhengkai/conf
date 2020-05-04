#!/bin/bash

(
	flock -x -n 200 || exit 1

	/home/zhengkai/.cow/cow

) 200>/tmp/cow.lock
