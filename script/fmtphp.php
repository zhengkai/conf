#! /usr/bin/env php
<?php

$s = '/www/code';

// scan('/www/fmt/1');
scan($s);

function scan(string $s) {
	$l = scandir($s);
	if (!$l) {
		return;
	}
	$l = array_filter($l, function(string $s) {
		return $s[0] !== '.';
	});
	$fn = __FUNCTION__;
	foreach ($l as $f) {
		$f = $s . '/' . $f;
		if (!is_writable($f)) {
			continue;
		}
		if (is_dir($f)) {
			$fn($f);
			continue;
		}
		if (substr($f, -4) === '.php') {
			fmt($f);
		}
	}
}

function fmt($f) {
	echo $f, "\n";

	$s = file_get_contents($f);
	$orig = $s;
	$s = trim(str_replace(["\r\n", "\r"], "\n", $s));

	if (substr($s, -2) === '?>') {
		$s = trim(substr($s, 0, -2));
	}
	$s .= "\n";

	$s = preg_replace('#error_reporting\(.*?\);\s*#', '', $s);

	$s = preg_replace('#ini_set\(\'display_errors\',.*?\);\s*#', '', $s);
	$s = preg_replace('#ini_set\("display_errors",.*?\);\s*#', '', $s);

	$s = preg_replace('#[ \t]+\n#', "\n", $s);
	$s = preg_replace('#\n\n(\n+)#', "\n\n", $s);

	if ($s !== $orig) {
		file_put_contents($f, $s);
	}
}
