#! /usr/bin/env bash

hyprctl dispatch workspace 8
sleep 1
google-chrome --profile-directory="Profile 1" &
sleep 1

hyprctl dispatch workspace 9
sleep 1
google-chrome --profile-directory="Profile 2" &
