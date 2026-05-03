# autoload -U colors && colors
# autoload -U promptinit && promptinit

if [ -z "$ZSH_DEFAULT_USER" ]; then
	ZSH_DEFAULT_USER="zhengkai"
fi

if [ -z "$ZSH_FORCE_HOST" ]; then
	ZSH_FORCE_HOST="%m"
fi

local time="%D{%X}"
time="%F{39} - ${time} -"

function show_url() {
	local url="%~"

	if [ ! -w "`pwd`" ]; then
		# url+=' %F{214}[RO]%F{39}'
		url="%F{154}%B${url}%b"
	else
		url="%F{39}%B${url}%b"
	fi
	echo $url
}

function show_host() {

	local same_user=true
	if [ "$USER" != "$ZSH_DEFAULT_USER" ]; then
		same_user=false
	fi

	local same_host=true
	if [[ -n "$LC_SSH_FROM" && "$LC_SSH_FROM" != "$HOST" ]]; then
		same_host=false
	fi

	if [[ $same_user = false && $same_host = false ]]; then
		echo "%F{214}%n@${ZSH_FORCE_HOST}%F{39}"
	elif [ $same_host = false ]; then
		echo "%n%F{214}@${ZSH_FORCE_HOST}%F{39}"
	elif [ $same_user = false ]; then
		echo "%F{214}%n@%F{39}${ZSH_FORCE_HOST}"
	else
		echo "%n@${ZSH_FORCE_HOST}"
	fi
}

function vi_prompt_color() {
	local insert_color="%F{10}"
	local normal_color="%F{208}"
	echo "${${KEYMAP/vicmd/$insert_color}/(main|viins)/$normal_color}"
}

function nix_propmt() {
	if [ -z "$IN_NIX_SHELL" ]; then
		echo ' '
		return
	fi
	echo " %F{098}Nix[%B${IN_NIX_SHELL}%b]%f"
}

function git_propmt() {
	local branch=$(git branch --show-current 2>/dev/null)
	if [ -z "$branch" ]; then
		return
	fi
	echo "%F{39}Git[ ${branch}$(git_propmt_dirty) ]"
}

function git_propmt_dirty() {

	git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
	git diff --quiet --ignore-submodules HEAD -- && return

	untracked="$(git ls-files --others --exclude-standard | wc -l)"

	git diff -b --numstat | awk -v u="$untracked" '{
		if ($1 != "-") add += $1
		if ($2 != "-") del += $2
		files++
	} END {
		out = " ] [ %F{250}" files "%F{39}"
		diff = ""
		if (u > 0) out = out " %F{237}" u "%F{39}"
		if (add > 0) diff = diff " %F{118}" add "+%F{39}"
		if (del > 0) diff = diff " %F{208}" del "-%F{39}"
		print out
	}'
}

setopt PROMPT_SUBST

local input_color="%F{252}"

PROMPT='
${time} $(show_host)$(nix_propmt) $(show_url) $(git_propmt)
$(vi_prompt_color) »${input_color} '
