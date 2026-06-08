#! /usr/bin/env bash

unset http_proxy
unset https_proxy

unset HTTP_PROXY
unset HTTPS_PROXY

unset LD_PRELOAD

steam -forcedesktopscaling=2 %U
