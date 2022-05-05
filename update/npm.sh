#!/bin/bash

list=(

	@angular/cli
	@typescript-eslint/eslint-plugin
	@typescript-eslint/parser
	eslint
	grpc-web
	node-sass
	npm-check-updates
	protoc-gen-grpc-web
	tslint
	typescript
	wscat

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
	sudo "$BIN" install -g "${item}"
	hash -r
done
