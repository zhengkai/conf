#!/bin/bash -e

DIR=$(readlink -f "$0") && DIR=$(dirname "$DIR") && cd "$DIR" || exit 1

cd "${DIR}/dotfiles"
for FILE in *; do

	SRC="${DIR}/dotfiles/${FILE}"

	if [ ! -f "$SRC" ]; then
		continue
	fi

	TARGET="${HOME}/.${FILE}"
	if [ -e "$TARGET" ]; then
		continue
	fi

	if [ "$FILE" == "gitconfig" ] && [ ! -e "${HOME}/.ssh/id_ecdsa.pub" ]; then
		grep -E -v '\[url|insteadOf' "$SRC" > "$TARGET"
		continue
	fi

	echo "$TARGET"
	ln -sf "$SRC" "$TARGET"
done

if [ ! -e "${HOME}/.npmrc" ]; then
	echo "prefix=${HOME}/.npm" > "${HOME}/.npmrc"
fi

if [ -z "$DISPLAY" ]; then
	cp -R "${DIR}/dotfiles/moc" ~/.moc
	chmod 600 ~/.moc/config
	chmod 600 ~/.moc/keymap_vim
fi

ln -sf "${DIR}/zsh/index.zsh" "${HOME}/.zshrc"

mkdir -p ~/.config/tig
ln -sf "${DIR}/dotfiles/other/tigrc" ~/.config/tig/config

if [ -n "$DISPLAY" ]; then
	mkdir -p ~/.config/kitty
	ln -sf "${DIR}/dotfiles/other/kitty.conf" ~/.config/kitty

	mkdir -p ~/.config/fontconfig
	ln -sf "${DIR}/dotfiles/other/fonts.conf" ~/.config/fontconfig

	mkdir -p ~/.config/wezterm
	ln -sf "${DIR}/dotfiles/other/wezterm.lua" ~/.config/wezterm
fi
