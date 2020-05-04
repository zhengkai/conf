#!/bin/bash

cd $(dirname `readlink -f $0`)

COMPOSER_DIR=$HOME'/.composer'

if [ ! -e $COMPOSER_DIR ]; then
	mkdir -p $COMPOSER_DIR
fi

if [ ! -e $COMPOSER_DIR'/auth.json' ] &&  [ -e $HOME'/hide/composer/auth.json' ]; then
	cp $HOME'/hide/composer/auth.json' $COMPOSER_DIR'/auth.json'
fi

if [ ! -d $COMPOSER_DIR ]; then
	if [ -e $COMPOSER_DIR ]; then
		echo
		echo 'ERROR: '$COMPOSER_DIR' is not a dir'
		echo
		exit 1
	fi

	mkdir $COMPOSER_DIR
	ln -s $PWD'/composer.json' $COMPOSER_DIR
fi

COMPOSER='/usr/local/bin/composer'
if [ ! -x $COMPOSER ]; then
	curl -sS https://getcomposer.org/installer | sudo php -- --install-dir="$(dirname $COMPOSER)" --filename=composer
fi

COMPOSER="$COMPOSER  --no-ansi --no-interaction"

sudo $COMPOSER self-update 2>&1
sudo chown -R zhengkai:zhengkai $COMPOSER_DIR

COMPOSER_JSON=$COMPOSER_DIR'/composer.json'
if [ ! -e $COMPOSER_JSON ]; then
	ln -s $PWD'/composer.json' $COMPOSER_JSON
fi

PHPCS_RULESET=$COMPOSER_DIR'/vendor/squizlabs/php_codesniffer/CodeSniffer.conf'
if [ ! -e $PHPCS_RULESET ]; then
	mkdir -p "$(dirname $PHPCS_RULESET)"
	ln -s $PWD'/CodeSniffer.conf' $PHPCS_RULESET
fi

$COMPOSER global update
