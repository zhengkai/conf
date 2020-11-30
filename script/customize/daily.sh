#!/bin/bash

~/conf/script/safe-git-pull.sh ~/build
~/conf/script/safe-git-pull.sh ~/hide
~/conf/script/safe-git-pull.sh ~/conf

~/conf/update/daily.sh
