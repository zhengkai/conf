#!/bin/bash -e

DIR=$(readlink -f "$0") && DIR=$(dirname "$DIR") && cd "$DIR" || exit 1

cd "${DIR}/dotfiles"
for FILE in *; do

	SRC="${DIR}/dotfiles/${FILE}"

	if [ ! -f "$SRC" ]; then
		continue
	fi

	TARGET="${HOME}/.${FILE}"

	if [ "$FILE" == "gitconfig" ] && [ ! -e "${HOME}/.ssh/id_rsa.pub" ]; then
		grep -E -v '\[url|insteadOf' "$SRC" > "$TARGET"
		continue
	fi

	ln -sf "$SRC" "$TARGET"
done

if [ -z "$DISPLAY" ]; then
	cp -R "${DIR}/dotfiles/moc" ~/.moc
fi

ln -sf "${DIR}/zsh/index.zsh" "${HOME}/.zshrc"

mkdir -p ~/.config/tig
ln -sf "${DIR}/dotfiles/other/tigrc" ~/.config/tig/config
