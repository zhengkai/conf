export VISUAL=nvim
export EDITOR=nvim

export HERMES_DEFAULT_SIZE="18x18"

export LC_ALL=en_US.UTF-8

export NIXPKGS_ALLOW_UNFREE=1

export FIGNORE=".lock:.example"

# export NIX_BUILD_SHELL="${HOME}/conf/script/nix-shell-wrapper"

export JQ_COLORS="48;5;237:48;5;52:48;5;22:38;5;80:38;5;214:1;39:1;39"

# man color
#export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[1;38;5;222m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[30;48;5;32m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[38;5;117m'

export ANDROID_SDK_ROOT=/mnt/sdb/android/sdk

if [ -n "$TMUX" ]; then
	export LC_TMUX=""
fi

if [ -z "$LC_SSH_FROM" ]; then
	export LC_SSH_FROM="$HOST"
fi
