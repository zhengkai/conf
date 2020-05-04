#!/bin/bash

sudo docker images --all=true --no-trunc=true --filter=dangling=true -q | sort | uniq | xargs sudo docker rmi
