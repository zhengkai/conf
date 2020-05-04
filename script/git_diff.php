#!/usr/bin/env php
<?php

// TODO: 汉字测试 / @@ 后新开一行 / chmod 777

/*
diff --git a/script/a.php b/script/a.php
deleted file mode 100755
index f0d2262..0000000
--- a/script/a.php
+++ /dev/null
 */

// cmd:
// cat diff | ./git_diff.php | less

$aConfig = array(
	"file" => 222,
	"add_line" => 118,
	"sub_line" => 208,
	"comment" => 222,
	"normal" => 252,
	"tabs" => 4,
);

if (!function_exists("hex2bin")) {
	function hex2bin($s) {
		return pack("H*", $s);
	}
}

function color($sControl = "0") {
	return hex2bin("1b").'['.$sControl.'m';
}

function fg($iColor) {
	return color("38;5;".$iColor);
}

function bg($iColor) {
	return color("48;5;".$iColor);
}

while ($sLine = fgets(STDIN)) {
	// $sLine = str_replace("\t", bg(155)."    ".color(), $sLine);

	$sMode = substr($sLine, 0, 1);
	$sLine = substr($sLine, 1);

	if (!trim($sLine)) {
		continue;
	}

	// $sLine = preg_replace("^.*?\t");

	$iCount = 1;
	while ($iCount) {

		$sLine = preg_replace_callback('#^(.*?)\t#', function ($aMatch) use ($aConfig) {

			$sReturn = $aMatch[1];

			$iLength = mb_strwidth($sReturn, "UTF-8");
			$iLength = $aConfig["tabs"] - $iLength % $aConfig["tabs"];
			$sReturn .= str_repeat(" ", $iLength);

			return $sReturn;
		}, $sLine, 1, $iCount);
	}
	$sLine = $sMode.$sLine;

	switch ($sMode) {
		case "-":
			if (substr($sLine, 0, 3) === "---") {
				continue 2;
			}
			$sLine = fg($aConfig["sub_line"]).$sLine.color();
			break;
		case "+":
			if (substr($sLine, 0, 3) === "+++") {
				continue 2;
			}
			$sLine = fg($aConfig["add_line"]).$sLine.color();
			break;
		case "@":
			$sLine = preg_replace("#@@(.*?)@@#", fg($aConfig["comment"]).'@$1@'.fg($aConfig["normal"]), $sLine);
			$sLine = "\n".$sLine.color();
			break;
		case " ":
			$sLine = fg($aConfig["normal"]).$sLine.color();
			break;
		case "i": // index
			continue 2;
			break;
		case "d": // diff
			$sLine = preg_replace('#^.*?\-\-git a/(.+) b/.*$#', '$1', $sLine);
			$sLine = "\n    ".fg($aConfig["file"]).bg(235).color(1)." [ ".trim($sLine)." ] ".color()."\n";
			break;
	}

	echo $sLine;
}

