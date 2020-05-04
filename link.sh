#!/bin/bash -ex

DIR=$(readlink -f "$0") && DIR=$(dirname "$DIR") && cd "$DIR" || exit 1

cd "${DIR}/dotfiles"
for FILE in *; do

	SRC="${DIR}/dotfiles/${FILE}"

	if [ ! -f "$SRC" ]; then
		continue
	fi

	ln -sf "$SRC" "${HOME}/.${FILE}"
done

if [ -z "$DISPLAY" ]; then
	cp -R "${DIR}/dotfiles/moc" ~/.moc
fi

ln -sf "${DIR}/zsh/index.zsh" "${HOME}/.zshrc"

mkdir -p ~/.config/tig
ln -sf "${DIR}/dotfiles/other/tigrc" ~/.config/tig/config
