#!/usr/bin/env zsh

# 根据 env FIGNORE 过滤 fzf 输出文件
__zk_filter_fignore() {
	emulate -L zsh
	setopt extendedglob

	local line pat suffix
	local -a ignores pats

	ignores=(${(s.:.)FIGNORE})

	(( ${#ignores} == 0 )) && { cat; return 0; }

		pats=()
		for suffix in "${ignores[@]}"; do
			[[ -z $suffix ]] && continue
			pats+=("${(b)suffix}")
		done

		(( ${#pats} == 0 )) && { cat; return 0; }

			pat="*(${(j:|:)pats})"

			while IFS= read -r line; do
				[[ $line == ${~pat} ]] || print -r -- "$line"
			done
}

# 从 git 根目录获取文件
__zk_fsel() {
	local root
	root=$(git rev-parse --show-toplevel 2>/dev/null) || return 1

	setopt localoptions pipefail

	cdup=$(git rev-parse --show-cdup)
	git ls-tree -r --name-only HEAD "${cdup:-.}" \
		| __zk_filter_fignore \
		| FZF_DEFAULT_OPTS="--height 40% --reverse" fzf "$@"
}

fzf-git-widget() {

	local file ret

	if ! git rev-parse --show-toplevel >/dev/null 2>&1; then
		zle fzf-file-widget
		return $?
	fi

	file="$(__zk_fsel)"
	ret=$?

	if [[ -n $file ]]; then
		BUFFER="vi ${(q)file}"
		CURSOR=${#BUFFER}
	fi

	zle reset-prompt
	return $ret
}

zle -N fzf-git-widget

# bindkey '^G' fzf-git-widget
