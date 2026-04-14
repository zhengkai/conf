#!/usr/bin/env bash

docker ps -a -q --no-trunc | xargs sudo docker rm
