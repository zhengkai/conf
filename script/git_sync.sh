#!/bin/sh
cd ~/conf
git pull
git add .
git ci -a -m "auto save from `hostname`"
git push

