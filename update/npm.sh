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

for item in "${list[@]}"
do
	npm install --location=global "${item}"
	hash -r
done
