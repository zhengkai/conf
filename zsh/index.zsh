if [ -n "$LC_RPG" ] && [ -z "$TMUX" ]; then
	~/conf/bin/tmu
fi

source $HOME/conf/zsh/prompt.zsh
source $HOME/conf/zsh/vi.zsh
source $HOME/conf/zsh/export.zsh
source $HOME/conf/zsh/alias.zsh
source $HOME/conf/zsh/timer.zsh
source $HOME/conf/zsh/fzf.zsh

HISTFILE=$HOME/conf/zsh/history.txt
HISTSIZE=1000
SAVEHIST=1000
setopt share_history
setopt inc_append_history
setopt autocd
setopt ignoreeof

alias -s {html,scss,css,go,json,yml,yaml}=vim

if [ -z "$(declare -f -F j)" ] && [ -f /usr/share/autojump/autojump.zsh ]; then

	. /usr/share/autojump/autojump.zsh
fi

if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then

	. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	# https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/root.md
	ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=154,underline'
	ZSH_HIGHLIGHT_STYLES[precommand]='fg=154,underline'
	ZSH_HIGHLIGHT_STYLES[arg0]='fg=154'
	ZSH_HIGHLIGHT_STYLES[alias]='fg=154,bg=235'
	ZSH_HIGHLIGHT_STYLES[path]='fg=49'
	ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=214'
	ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=199,bold'
fi

if [ -d /www ] && [ -r /www ]; then
	cd /www
fi

tabs 4

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# exec 2>>( while read -r X; do print "\e[01;31m${X}\e[0m" > /dev/tty; done & )
if [ -f /usr/local/lib/libstderred.so ]; then
	export LD_PRELOAD="/usr/local/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
	export STDERRED_ESC_CODE=$(echo -e '\e[38;2;255;45;45;48;2;10;10;10m')
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [ -f ~/google-cloud-sdk/path.zsh.inc ]; then
	. ~/google-cloud-sdk/path.zsh.inc
fi
if [ -f ~/google-cloud-sdk/completion.zsh.inc ]; then
	. ~/google-cloud-sdk/completion.zsh.inc
fi
