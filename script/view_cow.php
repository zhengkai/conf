#! /usr/bin/env php
<?php
$sFile = $_SERVER['HOME'] . '/.cow/stat';

if (!file_exists($sFile)) {
	echo 'no file ' . $sFile . "\n";
	exit;
}

$a = json_decode(file_get_contents($sFile), TRUE);
if (!is_array($a)) {
	echo 'file error ' . $sFile . "\n";
	exit;
}

$lBlock = [];
foreach ($a['site_info'] as $sSite => $aSite) {
	if (empty($aSite['block'])) {
		continue;
	}

	printf('%-40s %5d', $sSite, $aSite['block']);
	echo "\n";
	// print_r($aSite);
}
