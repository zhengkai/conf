if [ -n "$LC_RPG" ] && [ -z "$TMUX" ]; then
	~/conf/bin/tmu
fi

source $HOME/conf/zsh/prompt.zsh
source $HOME/conf/zsh/vi.zsh
source $HOME/conf/zsh/export.zsh
source $HOME/conf/zsh/alias.zsh
source $HOME/conf/zsh/timer.zsh
source $HOME/conf/zsh/fzf.zsh

export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export XMODIFIERS="@im=fcitx"
export GLFW_IM_MODULE="fcitx"
export INPUT_METHOD="fcitx"

HISTFILE=$HOME/conf/zsh/history.txt
HISTSIZE=1000
SAVEHIST=1000
setopt share_history
setopt inc_append_history
setopt autocd
setopt ignoreeof

alias -s {html,scss,css,go,ts,json,yml,yaml}=nvim

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

WORK_ROOT="/www"
if [ -f ~/.config/env ]; then
	source ~/.config/env
fi
if [ -d "$WORK_ROOT" ] && [ -r "$WORK_ROOT" ]; then
	cd "$WORK_ROOT"
fi

if [ -f /usr/local/lib/libstderred.so ]; then
	export LD_PRELOAD="/usr/local/lib/libstderred.so${LD_PRELOAD:+:$LD_PRELOAD}"
	export STDERRED_ESC_CODE=$(echo -e '\e[38;2;255;45;45;48;2;10;10;10m')
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -f ~/google-cloud-sdk/path.zsh.inc ] && source ~/google-cloud-sdk/path.zsh.inc
# [ -f ~/google-cloud-sdk/completion.zsh.inc ] && source ~/google-cloud-sdk/completion.zsh.inc
[ -x "/usr/local/src/kitty/shell-integration/kitty.zsh" ] && source "/usr/local/src/kitty/shell-integration/kitty.zsh"
[ -x "/usr/local/bin/ng" ] && source <(ng completion script)

tabs 4
