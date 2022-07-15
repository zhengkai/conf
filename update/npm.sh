#!/bin/bash

list=(

	@angular/cli
	@angular/language-service
	@typescript-eslint/eslint-plugin
	@typescript-eslint/parser
	dockerfile-language-server-nodejs
	eslint
	grpc-web
	node-sass
	npm-check-updates
	protoc-gen-grpc-web
	tslint
	typescript
	typescript-language-server
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
	"$BIN" install --location=global "${item}"
	hash -r
done
