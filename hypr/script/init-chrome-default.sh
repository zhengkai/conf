#! /usr/bin/env bash

WORKSPACE="chrome-default"
PROFILE="Profile 1"

hyprctl dispatch exec "[workspace name:${WORKSPACE} silent] google-chrome --profile-directory=\"${PROFILE}\""
