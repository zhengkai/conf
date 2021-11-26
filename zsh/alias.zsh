setopt aliases

alias s='ssh'

alias todo='vi ~/TODO'

alias cat='sudo cat -v'
alias vms='vmstat 1'
alias dmidecode='sudo dmidecode'
alias tcpdump='sudo tcpdump'
alias iptables='sudo iptables'
alias ipset='sudo ipset'
alias iptables-apply='sudo iptables-apply'
alias iptables-restore='sudo iptables-restore'
alias iptables-save='sudo iptables-save'
alias systemctl='sudo systemctl'

alias apt='sudo apt'
alias apt-get='sudo apt-get'
alias apt-cache='sudo apt-cache'
alias wondershaper='sudo wondershaper'
alias iotop='sudo iotop'
alias iftop='sudo iftop'
alias fdisk='sudo fdisk'
alias sysctl='sudo sysctl'
alias md5sum='sudo md5sum'
alias sha1sum='sudo sha1sum'
alias sha256sum='sudo sha256sum'
alias lsof='sudo lsof'
alias lsb_release='sudo lsb_release'
alias kitty='/usr/local/src/kitty/kitty/launcher/kitty'
alias ytl="${HOME}/conf/script/youtube-dl.sh"
alias psql='sudo -u postgres psql --dbname=fb'

alias gkl="gpg2 --list-keys --keyid-format long 'Zheng Kai'"

alias adduser='sudo adduser'
alias groupadd='sudo groupadd'

alias ip='sudo ip'
alias wg='sudo wg'
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'
# alias try='docker run --rm=true -t -i'

alias ifstat='ifstat -t'
alias cpuinfo='less /proc/cpuinfo'
alias jour='journalctl -xe'

alias rm="trash-put"

alias /='cd /'
alias '~/'='cd ~/'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias 'cd-'='cd -'

alias fuck='$(thefuck $(fc -ln -1))'
alias FUCK='fuck'

alias ag='sudo ag --ignore node_modules'

alias g='go run'
alias t='go test -v'
alias tt='go test -v -test.benchmem -cover -covermode=atomic -coverprofile=coverage.out'
alias ttc='go tool cover -html=coverage.out'
alias bce='go build -gcflags="-d=ssa/check_bce/debug=1"'

alias gii='git init && git commit --allow-empty -m "startup"'
alias ga='git add --all ./`git rev-parse --show-cdup 2>/dev/null`'
alias gi='git add --all ./`git rev-parse --show-cdup 2>/dev/null` && git ci -a'
alias ro='cd ./`git rev-parse --show-cdup 2>/dev/null`'
alias gia='gi --amend'
alias gb='git br'
alias gdl='gd HEAD~1 HEAD'
alias gdn='gd --no-index'
alias gdh='gd HEAD'
alias gds='gd --staged'
alias gs='git st'
alias gc='git clone'
alias gc1='git clone --depth 1'
alias gm='git merge --no-ff'
alias gms='git merge --squash'
alias gtp='git stash apply'
alias gpp='git pull && git push'
alias gpt='git push && git push --tags'
alias grb='git ls-remote --heads `git url` | sed "s#^.*refs/heads/##"'
alias gl='git log --abbrev=12 --date="format:%Y-%m-%d %H:%M:%S" --pretty=format:"%C(44)%cd %C(7)%h %C(214)%<(30)%s %C(8)- %cn"'
alias git-delete-all-local-branch='git br | \grep -v "^*" | sed "s#  ##" | xargs -L 1 git br -D | tee -a ./`git rev-parse --show-cdup 2>/dev/null`.git/deleted-brnach'

# 从整个仓库的所有历史里搜索某个关键词
alias git_all_search='git rev-list --all | xargs git grep -F'

alias d='colordiff -u'

alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -lA"
alias l="ls -CF"
alias lsd="\ls -l | \grep ^d"

alias free="free -h"

alias naf="npm audit fix"
alias nng="ng new --skip-git --skip-tests --style=scss --routing=true --strict --inline-style --directory client"

alias date="TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S'"
alias now="php -r '\$i = time(); echo \$i, \"\\n\", date(\"Y-m-d H:i:s\", \$i);'"

alias ssh-keygen-rsa='ssh-keygen -N "" -b 4096 -t rsa'
alias ssh-keygen='ssh-keygen -N "" -b 384 -t ecdsa'

alias top="TERM=screen-256color htop"
alias df="df -h"

alias vimcat="$HOME/.vim/bundle/vimpager/vimcat"

alias du1="sudo du --max-depth=1 -h"
alias dus="sudo du --max-depth=0 -h"

alias sshsync='rsync --partial -vzrtopg -e ssh'
alias ssltime='curl -w "TCP handshake: %{time_connect}, SSL handshake: %{time_appconnect}\n" -so /dev/null'
alias sslview='sudo openssl x509 -noout -text -in'

alias pwgen='((L=$LINES-8)); ((L=L>10?L:10)); ((W=$COLUMNS)); ((W=W>80?W:80)); pwgen -cns $W $L'
alias pwgens='((L=$LINES-8)); ((L=L>10?L:10)); ((W=$COLUMNS)); ((W=W>80?W:80)); pwgen -cnsy $W $L'

alias grep='sudo grep -n -I --color=always --exclude-dir=.hg --exclude-dir=.git --exclude-dir=.svn'
alias grpe='grep'
alias less='less -r --tabs=4'

alias pss='ps aux | \grep'
alias netss='sudo netstat -nap | grep'
alias nss='nginx configtest && nginx stop && nginx start'

alias vimn='vim -N -u NONE'
alias :vs='vim'
alias vs='vim'

function fn_add_user_to_group() {

	# 这个函数存在的意义在于，有些下等 Linux 发行版只有 useradd 没有 adduser

	user=`\id "$1" 2>/dev/null`

	if [[ ! $user =~ ^uid=.* ]]; then
		echo "user not exists: $1"
		return;
	fi
	echo "add user: $1"

	group=`\grep "^$2" /etc/group`
	if [ -z "$group" ]; then
		echo "group not exists: $2"
		return;
	fi
	echo "to group: $2"

	sudo usermod -a -G $2 $1
}
alias add_user_to_group=fn_add_user_to_group

alias c1="awk '{print \$1}'"
alias c2="awk '{print \$2}'"
alias c3="awk '{print \$3}'"
alias c4="awk '{print \$4}'"
alias c5="awk '{print \$5}'"
alias c6="awk '{print \$6}'"
alias c7="awk '{print \$7}'"
alias c8="awk '{print \$8}'"
alias c9="awk '{print \$9}'"

alias head='((L=$LINES-8)); ((L=L>10?L:10)); sudo \head -n $L'
alias st='sudo \tail -n 10'
alias tail='((L=$LINES-8)); ((L=L>10?L:10)); sudo \tail -n $L'
alias f='((L=$LINES-3)); ((L=L>10?L:10)); sudo \tail -n $L -f'
alias terror="sudo touch /tmp/php-error.txt; sudo chmod 666 /tmp/php-error.txt; f /tmp/php-error.txt"

alias mocp="TERM=screen-256color /usr/bin/mocp"

alias mount='sudo mount'
alias service='sudo service'
alias nginx='service nginx'
alias nginx-reload='service nginx force-reload'
alias re-nginx='nginx stop && nginx start'
alias mysqld='service mysql'
alias fpm='service php-fpm'
alias firewall-cmd='sudo firewall-cmd'
alias fail2ban-client='sudo fail2ban-client'

alias logstash='/usr/share/logstash/bin/logstash'

# alias pip='sudo -H pip3'
# alias pip3='sudo -H pip3'
alias easy_install='sudo easy_install'
alias easy_install3='sudo easy_install3'

alias pl="echo 'show processlist;' | mysql"
alias pc='echo `grep -c "^processor" /proc/cpuinfo`'

alias cleanacl="sudo setfacl -b -R ."

alias set644="(find . -type d -exec sudo chmod 755 {} \;) && (find . -not -type d -exec sudo chmod 644 {} \;)"
alias set664="(find . -type d -exec sudo chmod 775 {} \;) && (find . -not -type d -exec sudo chmod 664 {} \;)"
alias set666="(find . -type d -exec sudo chmod 777 {} \;) && (find . -not -type d -exec sudo chmod 666 {} \;)"
alias set600="(find . -type d -exec sudo chmod 700 {} \;) && (find . -not -type d -exec sudo chmod 600 {} \;)"

#alias flushmc="echo 'flush_all' | nc localhost 11211"

alias pwdcp='echo -n "`pwd`" | xclip -selection c'

alias nping='TIME="%E" \time nc -w 5 -vz'
alias iptest="curl https://ifconfig.io/ip --socks5-hostname"

alias -g xx='| tr -d "\\n" xt'
alias -g xt='| tee /dev/tty | xclip -selection clipboard'

alias ms='sudo mongosniff --source NET lo 27017'

ex () {
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)   tar xjf $1   ;;
			*.tar.gz)    tar xzf $1   ;;
			*.tar.xz)    tar xf $1   ;;
			*.bz2)       bunzip2 $1   ;;
			*.rar)       rar x $1     ;;
			*.gz)        gunzip $1    ;;
			*.tar)       tar xf $1    ;;
			*.tbz2)      tar xjf $1   ;;
			*.tgz)       tar xzf $1   ;;
			*.zip)       unzip $1     ;;
			*.Z)         uncompress $1  ;;
			*.7z)        7z x $1    ;;
			*)           echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

alias wake-tesla='wakeonlan "fc:aa:14:ad:25:d5" && wakeonlan -i "10.0.31.16"    "fc:aa:14:ad:25:d5"'
alias wake-molly='wakeonlan "d8:50:e6:ba:43:df" && wakeonlan -i "10.0.31.14"    "d8:50:e6:ba:43:df"'
alias wake-lydia='wakeonlan "e0:d5:5e:16:08:a0" && wakeonlan -i "192.168.1.225" "e0:d5:5e:16:08:a0"'
alias wake-rpi='  wakeonlan "b8:27:eb:c1:83:2a" && wakeonlan -i "192.168.1.224" "b8:27:eb:c1:83:2a"'
