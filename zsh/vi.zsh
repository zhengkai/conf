bindkey -v

bindkey '^b' history-beginning-search-forward
bindkey '^n' history-beginning-search-backward
bindkey '^/' backward-delete-char
bindkey '^w' backward-kill-word

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

function zle-line-init {
    zle reset-prompt
}

function zle-keymap-select {
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=1
