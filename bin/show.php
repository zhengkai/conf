#! /usr/bin/env php
<?php

if (function_exists('readline_completion_function')) {
	readline_completion_function(function($s) {
		file_put_contents('/tmp/readline.txt', $s . "\n" . $b . "\n" . print_r(readline_info(), 1));
		return true;
	});
}

if (empty($argv[1])) {
	echo 'input a image file', "\n";
	exit;
}
$image = $argv[1];

$download = false;
if (preg_match('#^https?://#', $image)) {

	$download = true;

	$tmp = file_get_contents($image);

	if (!$tmp) {
		echo 'download file ' . $image . ' fail';
		unlink($file);
		exit;
	}

	$file = tempnam(sys_get_temp_dir(), 'thumb_');
	file_put_contents($file, $tmp);
	unset($tmp);
	$image = $file;

} else if (!file_exists($image)) {

	echo 'not a file: ', $image, "\n";
	exit;
}

$truecolor = true;
$fill = true;

$default_bg_rgb = [0, 0, 0]; // if thumb height pixel is odd number

$pixel = $truecolor ? 3 : 4;

$resize = '';
if (!empty($argv[2])) {
	$tmp = trim($argv[2]);
	if (preg_match('#\d+x\d+#', $tmp)) {
		$resize = $tmp;
	}
}

if (!$resize) {
	$COLUMNS = trim(shell_exec('tput cols')) ?: 80;
	$LINES = (trim(shell_exec('tput lines')) * 2) ?: 30;
	$resize = $COLUMNS . 'x' . $LINES;
}

function getcolor($x, $y, $bg = true) {

	global $bmp, $offset, $w, $linebit, $filesize, $pixel;

	if (!$bg) {
		$y = $y - 1;
	}
	if ($y < 0) {
		return false;
	}

	$start = $offset + $y * $linebit + $x * $pixel;

	if (($start + 2) >= $filesize) {
		return false;
	}

	$r = bin2dec($bmp[$start + 2]);
	$g = bin2dec($bmp[$start + 1]);
	$b = bin2dec($bmp[$start + 0]);

	return sprintf("%d;2;%d;%d;%d", $bg ? 48: 38, $r, $g, $b);
}

function bin2dec($s) {
	return hexdec(bin2hex($s));
}

function getnum($addr, $len = 4) {

	global $bmp;

	$k = range($addr + $len - 1, $addr, -1);
	$return = '';
	foreach ($k as $i) {
		$return .= $bmp[$i];
	}

	return bin2dec($return);
}

$CMD = 'convert ' . escapeshellarg($image . '[0]')
	. ($truecolor ? ' -type truecolor' : '')
	. ' -resize ' . escapeshellarg($resize)
	. ($fill ? '' : ' -resize "100%x50%!"')
	. ' bmp:- '
	. ' 2>/dev/null';
// echo $CMD, "\n";

$bmp = shell_exec($CMD);
if ($download) {
	unlink($image);
}

if (!$bmp) {
	echo 'convert fail', "\n";
	exit;
}

// file_put_contents('/tmp/test.bmp', $bmp);

$filesize = strlen($bmp);

$offset = getnum(0x0a);

$w = getnum(0x0012);
$h = getnum(0x0016);

$linebit = intval(ceil($w * $pixel / 4) * 4);

/*
echo 'size = ', getnum(0x000e), "\n";
echo 'width = ', $w, "\n";
echo 'height = ', $h, "\n";
echo 'padding = ', $padding, "\n";
echo 'depth = ', getnum(0x001c, 2), "\n";
echo 'compress = ', getnum(0x001e), "\n";
exit;
 */

$prev_fg_color = '';
$prev_bg_color = '';

if ($fill) {
	$block = '▄'; // https://www.compart.com/en/unicode/U+2584
} else {
	$block = ' ';
}

ob_start();

foreach (range($h - 1, 0, $fill ? -2 : -1) as $y) {

	$prev_fg_color = '';
	$prev_bg_color = '';

	$first = true;

	foreach (range(0, $w - 1) as $x) {

		$bg_color = getcolor($x, $y) ?: '';
		if ($bg_color) {
			if ($prev_bg_color === $bg_color) {
				$bg_color = '';
			} else {
				$prev_bg_color = $bg_color;
			}
		}

		$fg_color = '';
		if ($fill) {
			$fg_color = getcolor($x, $y, false) ?: '';
			if ($prev_fg_color === $fg_color) {
				$fg_color = '';
			} else {
				$prev_fg_color = $fg_color;
			}
		}

		if ($first && !$fg_color) {
			$fg_color = '38;2;' . implode('.', $default_bg_rgb);
		}

		if ($fg_color || $bg_color) {
			if ($fg_color && $bg_color) {
				$fg_color .= ';';
			}
			echo sprintf("\033[%s%sm", $fg_color, $bg_color);
			// echo sprintf("\\033[%s%sm", $fg_color, $bg_color);
		}
		echo $block;
	}

	echo "\033[0m\n";
}
