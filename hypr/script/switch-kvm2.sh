#! /usr/bin/env bash

cd "$(dirname "$(readlink -f "$0")")" || exit 1

./switch-kvm.sh >/tmp/kvm.txt 2>&1
