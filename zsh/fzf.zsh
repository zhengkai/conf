#!/bin/bash

__zk_fsel() {
  if [ -z "$(git rev-parse --show-toplevel 2>/dev/null)" ]; then
	  return 1
  fi
  local cmd='git ls-tree -r --name-only $(git rev-parse --abbrev-ref HEAD) $(git rev-parse --show-cdup)'
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height 40% --reverse" fzf "$@"
  local ret=$?
  return $ret
}

fzf-git-widget() {
  local file="$(__zk_fsel)"
  local ret=$?
  if [ -n "$file" ]; then
    # eval "vi $file"
	LBUFFER="vi ${file}"
  fi
  zle reset-prompt
  if [ -n "$TMUX" ]; then
	tmux send-keys C-m
  fi
  return $ret
}
zle -N fzf-git-widget

if [ -e $HOME/.fzf.zsh ]; then
	source $HOME/.fzf.zsh
	bindkey '^p' fzf-git-widget
fi
