#!/usr/bin/env php
<?PHP
if (PHP_SAPI != "cli") {
	exit;
}

define("EMULE_HASH_PID", "/tmp/emule_clean.txt");
if (file_exists(EMULE_HASH_PID)) {
        exit;
}
file_put_contents(EMULE_HASH_PID, getmypid());
sleep(2);
if (!file_exists(EMULE_HASH_PID) || (file_get_contents(EMULE_HASH_PID) != getmypid())) {
        exit;
}

ignore_user_abort();
function shutdown() {
        unlink(EMULE_HASH_PID);
}
register_shutdown_function("shutdown");

chdir("/www/emule/");

file_put_contents("/tmp/emule_check.txt", date("Y-m-d H:i:s"));

$sCmd = "curl --socks5 10.0.2.15:7777 \"http://x.soulogic.com/emule_list?t=".time()."\" --output /tmp/clean_emule.txt";
exec($sCmd);

$aFile = unserialize(file_get_contents("/tmp/clean_emule.txt"));
if (!is_array($aFile)) {
	exit;
}

foreach ($aFile as $sKey => $aRow) {
	if (!file_exists($aRow["file"])) {
		continue;
	}
	if (filesize($aRow["file"]) != $aRow["size"]) {
		continue;
	}

	echo $aRow["file"];
	echo "\n";

	$sCheck = md5("xmajxhakdsld".$aRow["md5"]);
	$sMD5 = md5_file($aRow["file"]);
	if ($sMD5 != $aRow["md5"]) {
		continue;
	}

	echo $sCmd = "curl --socks5 10.0.2.15:7777 \"http://x.soulogic.com/emule_del?id=".$sKey."&check=".$sCheck."\"";
	exec($sCmd);
}

