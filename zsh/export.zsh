export EDITOR=/usr/local/bin/vim

export GOROOT=/usr/local/go
#export GOARCH=amd64
export GOOS=linux
export GOPATH=/go
export GO111MODULE=on

export EDITOR=/usr/bin/vim.basic
export LC_ALL=en_US.UTF-8

export PATH="/home/zhengkai/.fzf/bin:/cuda/anaconda/bin:/home/zhengkai/.local/bin:/usr/local/cuda/bin:$HOME/conf/bin:$HOME/.npm/bin:$GOPATH/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/games:/snap/bin"

# man color
#export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[1;38;5;222m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[30;48;5;32m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[38;5;117m'

if [ -z "$LC_SSH_FROM" ]; then
	export LC_SSH_FROM="$HOST"
fi
