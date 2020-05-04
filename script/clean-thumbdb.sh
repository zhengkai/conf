#!/bin/sh
find /share -name Thumbs.db | xargs sudo rm -f
find /share -name *DS_Store* | xargs sudo rm -f

