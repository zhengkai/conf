#! /bin/bash

nvim --headless -c "lua require('lazy').update({ wait = true })" +qa
