#! /usr/bin/env php
<?php

// 修改 cow  的 pac 文件，添加 优酷去广告插件 的规则
// https://chrome.google.com/webstore/detail/peddmpbdeelbhgfjnmlkfgeddigonncm

$s = @file_get_contents('http://192.168.1.212:7777/pac');
if (!$s) {
	exit;
}

$sFind = 'function FindProxyForURL(url, host) {';

$sReplace = <<<'EOD'

	// if (0
	// 	|| shExpMatch(url, "https://www.google.com/*")
	// 	|| shExpMatch(url, "https://*googlevideo.com/*")
	// 	|| shExpMatch(url, "https://*.ytimg.com/*")
	// 	|| shExpMatch(url, "*.facebook.com/*")
	// ) {
	// 	return "SOCKS5 127.0.0.1:1080; SOCKS5 192.168.1.212:55777";
	// }

	if (0
		|| shExpMatch(url, "http://192.168.1.*")
	) {
		return 'DIRECT';
	}

	if (0
		|| shExpMatch(url, "http://freya:48888/*")
	) {
		return "SOCKS5 192.168.1.212:55777";
	}

	if (0
		|| shExpMatch(url, "http://molly:38888/*")
	) {
		return "SOCKS5 192.168.1.212:55667";
	}

	if (0
		|| shExpMatch(url, "http://royal-local.socialgamenet.com*")
		|| shExpMatch(url, "http://royal-lan-*")
		|| shExpMatch(url, "https://royal-lan-*")
	) {
		return "SOCKS5 192.168.1.212:55667";
	}
EOD;

$s = str_replace($sFind, $sFind."\n\n".$sReplace."\n", $s);

file_put_contents('/www/lan/pac/cow.txt', $s);
