#! /usr/bin/env php
<?php

$sConfigFile = '/etc/shadowsocks.json';
$sBlockFile  = '/home/zhengkai/hide/pac/list/blocked.txt';
$sDirectFile = '/home/zhengkai/hide/pac/list/direct.txt';

$s = '';
$s .= 'version: 2' . "\n";

// shadowsocks config

if (!file_exists($sConfigFile)) {
	echo 'no config ' . $sConfigFile;
	exit;
}

$aConfig = json_decode(file_get_contents($sConfigFile), TRUE);

$sProxyName = 'ss_proxy';

$aSave = [
	'id' => $sProxyName,
	'type' => 'ss',
	'method' => $aConfig['method'],
	'host' => $aConfig['server'],
	'port' => $aConfig['server_port'],
	'password' => $aConfig['password'],
];

$s .= 'adapter:' . "\n";
$bFirst = TRUE;
foreach ($aSave as $k => $v) {
	if ($bFirst) {
		$bFirst = FALSE;
		$s .= ' - ';
	} else {
		$s .= '   ';
	}
	$s .= $k . ': ' . $v;
	$s .= "\n";
}

$s .= 'rule:' . "\n";

// blocked list

if (file_exists($sBlockFile)) {
	$s .= ' - type: domainlist' . "\n";
	$s .= '   criteria:' . "\n";
	$l = file($sBlockFile, FILE_SKIP_EMPTY_LINES | FILE_IGNORE_NEW_LINES);
	foreach ($l as $line) {
		$s .= '    - ' . $line . "\n";
	}
	$s .= '   adapter: ' . $sProxyName . "\n";
}

// reserved ip

$l = file(__DIR__ . '/reserved_ip.txt', FILE_SKIP_EMPTY_LINES | FILE_IGNORE_NEW_LINES);
$s .= ' - type: iplist' . "\n";
$s .= '   criteria:' . "\n";
foreach ($l as $line) {
	if (!preg_match('#^[0-9]#', $line)) {
		continue;
	}
	$s .= '    - ' . explode(' ', $line, 2)[0] . "\n";
}
$s .= '   adapter: direct' . "\n";

// whitelist

if (file_exists($sDirectFile)) {
	$s .= ' - type: domainlist' . "\n";
	$s .= '   criteria:' . "\n";
	$l = file($sDirectFile, FILE_SKIP_EMPTY_LINES | FILE_IGNORE_NEW_LINES);
	foreach ($l as $line) {
		$s .= '    - ' . $line . "\n";
	}
	$s .= '   adapter: direct' . "\n";
}

// other

$s .= ' - type: country' . "\n";
$s .= '   country: CN' . "\n";
$s .= '   match: true' . "\n";
$s .= '   adapter: direct' . "\n";
$s .= ' - type: all' . "\n";
$s .= '   adapter: ' . $sProxyName . "\n";

echo $s;
