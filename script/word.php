#!/usr/bin/env php
<?php
$f = '/usr/share/dict/words';

$f = fopen($f, "r");
while (!feof($f)) {

	$word = trim(fgets($f, 1024));

	if (strlen($word) === 5 && substr($word, -1) === 'a') {
		echo $word;
		echo " ";
	}
}
