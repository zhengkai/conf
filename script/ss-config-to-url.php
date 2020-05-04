#! /usr/bin/env php
<?php
$file =& $_SERVER['argv'][1];
if (!strlen($file)) {
	fwrite(STDERR, 'no file');
	exit;
}
if (!is_file($file) || !is_readable($file)) {
	fwrite(STDERR, 'can not read file "' . $file . '"');
	exit;
}

$json = file_get_contents($file);
$config = json_decode($json, TRUE);
if (!$config || !is_array($config)) {
	fwrite(STDERR, 'read config fail');
	exit;
}

$config += [
	'server' => 'unknown',
	'server_port' => 8388,
	'method' => 'aes-256-cfb',
	'password' => 'nopassword',
];

$url = sprintf('ss://%s:%s@%s:%s',
	$config['method'],
	$config['password'],
	$config['server'],
	$config['server_port']
);

echo $url;
