#!/bin/bash

DST_DIR="${HOME}/.local/share/fonts"

LIST=(
	'/usr/local/share/fonts/MapleMono-Italic.ttf'
	'/usr/local/share/fonts/MapleMono-ExtraBoldItalic.ttf'
	'/usr/local/share/fonts/MapleMono-ExtraLightItalic.ttf'
)

cd "$(dirname "$(readlink -f "$0")")" || exit 1

TMP_DIR="/tmp/font-slim"
mkdir -p "${TMP_DIR}"

for SRC_FILE in "${LIST[@]}"; do

	TMP_FILE="${TMP_DIR}/tmp.ttf"
	TMP_TTX="${TMP_DIR}/tmp.ttx"

	rm -f "$TMP_FILE"
	rm -f "$TMP_TTX"

	./strip.py --input-file "$SRC_FILE" \
		--output-file "$TMP_FILE" 2>/dev/null

	ttx "$TMP_FILE" -o "${TMP_TTX}" 2>/dev/null

	sed -i 's/Maple/Zaple/g' "${TMP_TTX}"

	DST_NAME=$(basename "${SRC_FILE}")

	DST_FILE="${DST_DIR}/${DST_NAME//Maple/Zaple}"

	echo "$SRC_FILE -> $DST_FILE"
	ttx "$TMP_TTX" -o "$DST_FILE" 2>/dev/null
done
