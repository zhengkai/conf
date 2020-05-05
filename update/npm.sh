#!/bin/bash

list=(

	npm
	node-sass
	@angular/cli
	eslint
	tslint
	wscat
	typescript
	@typescript-eslint/parser
	@typescript-eslint/eslint-plugin

)

# ----------------------------------------------------------------------------

export NG_CLI_ANALYTICS=ci

mkdir -p ~/.npm
sudo chown zhengkai:zhengkai -R ~/.npm

BIN='/usr/local/bin/npm'
if [ ! -e "$BIN" ]; then
	>&2 echo no $BIN
	exit 1
fi

for item in "${list[@]}"
do
	"$BIN" install -g "${item}"
	hash -r
done
