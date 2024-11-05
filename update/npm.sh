#!/bin/bash

if ! command -v npm &>/dev/null; then
	>&2 echo "npm is not installed"
	exit 1
fi

list=(

	@angular/cli
	@angular/language-service
	@typescript-eslint/eslint-plugin
	@typescript-eslint/parser
	bash-language-server
	dockerfile-language-server-nodejs
	eslint
	grpc-web
	neovim
	node-sass
	npm
	npm-check-updates
	protoc-gen-grpc-web
	tree-sitter
	tree-sitter-cli
	typescript
	typescript-language-server
	wscat

)

# ----------------------------------------------------------------------------

export NG_CLI_ANALYTICS=ci

mkdir -p ~/.npm
sudo chown zhengkai:zhengkai -R ~/.npm

for item in "${list[@]}"
do
	echo "$item"
	npm install --location=global "$item"
	hash -r
done
