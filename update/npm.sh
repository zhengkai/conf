#!/bin/bash

if ! command -v npm &>/dev/null; then
	>&2 echo "npm is not installed"
	exit 1
fi

export PATH="${HOME}/.venvs/default/bin:${HOME}/.local/bin:${HOME}/.npm/bin:/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/snap/bin"

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
sudo chown "${USER}:${USER}" -R ~/.npm

for item in "${list[@]}"
do
	echo "$item"
	npm install --location=global "$item"
	hash -r
done
