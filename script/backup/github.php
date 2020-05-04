#!/usr/bin/env php
<?php

$sUser = "zhengkai";
$sPassword = "";
$sBackupDir = $_SERVER["HOME"]."/backup/github/";

echo "\n";

if (!strlen($sPassword)) {
	echo "Error: no password\n\n";
	exit(1);
}

if (!is_dir($sBackupDir)) {
	echo "Error: ".$sBackupDir." no exists\n\n";
	exit(1);
}

if (!is_writeable($sBackupDir)) {
	echo "Error: ".$sBackupDir." is not writeable\n\n";
	exit(1);
}

echo "start backup github\n\n";

$sJSON = file_get_contents("https://".$sUser.":".$sPassword."@api.github.com/user/repos");

$lRepoGithub = json_decode($sJSON, TRUE);

$lRepo = [];

foreach ($lRepoGithub as $aRepo) {

	$lRepo[] = [
		"full_name" => $aRepo["full_name"],
		"ssh_url" => $aRepo["ssh_url"],
	];

	if ($aRepo["has_wiki"]) {
		$lRepo[] = [
			"full_name" => $aRepo["full_name"].".wiki",
			"ssh_url" => substr($aRepo["ssh_url"], 0, -4).".wiki.git",
		];
	}
}

foreach ($lRepo as $aRepo) {

	$sTargetDir = $sBackupDir.$aRepo["full_name"].".git";
	echo $sTargetDir;
	echo "\n\n";

	if (!file_exists($sTargetDir)) {

		$sParentDir = dirname($sTargetDir);
		if (!file_exists($sParentDir)) {
			mkdir($sParentDir, 0777, TRUE);
		}

		$sCmd = "git clone --bare ".$aRepo["ssh_url"]." ".$sTargetDir;
		exec($sCmd);

		if (!file_exists($sTargetDir)) {
			continue;
		}

		chdir($sTargetDir);

		$sCmd = "git remote rm origin";
		exec($sCmd);

		$sCmd = "git remote add --mirror=fetch origin ".$aRepo["ssh_url"];
		exec($sCmd);
	}

	chdir($sTargetDir);
	$sCmd = "git remote update";
	exec($sCmd);
}

