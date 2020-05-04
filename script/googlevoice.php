#! /usr/bin/php
<?php

foreach (range(313, 999) as $go) {

	$maxPage = 999;

	for ($i = 0; $i < $maxPage; $i++) {

		$cmd = "curl -s 'https://www.google.com/voice/b/0/setup/search/?ac=" . $go . "&start=" . $i . "&country=US' -H 'dnt: 1' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36' -H 'x-chrome-uma-enabled: 1' -H 'accept: */*' -H 'referer: https://www.google.com/voice/b/0?gsessionid=t3BEKLwOl8Pw5M33BAkLO0V4ixDQM3fK' -H 'authority: www.google.com' -H 'cookie: gv=6QTI2k3UTwXtRfw60N32_369HeJrRfRUIDXhfFDGv4fIoHDWPZKE5ecnXj5bKaVbVrXNIA.; GV_NR=1; HSID=AtDZvjCeXOBfs3Y7X; SSID=A0xU_mwKR1tBilqub; APISID=P8RubJ4tqotGeeij/Av5_40mOEVS5M4tJZ; SAPISID=WegLfry0kGUnniM9/AL94HuxWujxM08i8l; SID=6QTI2nfPnlkwicugl8HZ1Gtx9uDrWQ6dmeMJ9Ai1X3tm9vsao8Io47Gyni88DBUJ-Fdifw.; NID=107=NGkDqvEpdvDoGVzzD3ukN39C-grBdg36GbshDNdP2L8MF5JWBWF8iQ2HObrX5zlG9xpRAVNbGPwbYsbzFRw_i5Vl6FsaodV7T268pGF0l6h7HRXZD6hfmzh9snwlQ0U2VPlP_ZLl7KQmjNB3yMbrVg-Usd8iV3i73JwaTAnicnOl1VYuX--PdJwKBN24F7wEV7VlH7nbuKp3sS16_Lfezgm87wXNYVfoz8mKZjVNgaFfNbl3edNRTF6CuV2H1bXs1iZqXFstVSbi332hgToElmB-LB4_7tlXTmO0s7OtU5lDaLP2Cqg9N5OgUg; DV=UwKrOvbXqN9OEE2cXk7VD9VNopma01URecFTsiI64AIAANA61uwObVpxBQEAAFxN1Dl0-Y77SgAAAA; UULE=a+cm9sZToxIHByb2R1Y2VyOjEyIHByb3ZlbmFuY2U6NiB0aW1lc3RhbXA6MTQ5OTkxMTAwNDYzMjAwMCBsYXRsbmd7bGF0aXR1ZGVfZTc6MjIzOTY0MjgwIGxvbmdpdHVkZV9lNzoxMTQxMDk0OTcwfSByYWRpdXM6MTI1NTU2MjA=; S=billing-ui-v3=lmTqAbQ7t4etPiKkeZJf--loCyuSjtAF:billing-ui-v3-efe=lmTqAbQ7t4etPiKkeZJf--loCyuSjtAF:grandcentral=t3BEKLwOl8Pw5M33BAkLO0V4ixDQM3fK; _ga=GA1.1.1866389953.1499845471; _gid=GA1.1.1686810754.1499845471; _gat=1' -H 'x-client-data: CIu2yQEIo7bJAQjKnMoBCKmdygEI1J7KAQ==' --compressed";
		$s = shell_exec($cmd);

		$a = json_decode($s, true);

		$a = $a['JSON'];

		if ($a['num_matches'] < 1) {
			echo $go, ' skip', "\n";
			break;
		}

		$calcMax = ceil($a['num_matches'] / 5);

		if ($maxPage != $calcMax) {
			$maxPage = $calcMax;
		}

		foreach ($a['vanity_info'] as $phone => $_) {

			$cmd = "curl -s 'https://www.google.com/voice/b/0/service/post' -H 'origin: https://www.google.com' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.8' -H 'x-chrome-uma-enabled: 1' -H 'cookie: gv=6QTI2k3UTwXtRfw60N32_369HeJrRfRUIDXhfFDGv4fIoHDWPZKE5ecnXj5bKaVbVrXNIA.; GV_NR=1; HSID=AtDZvjCeXOBfs3Y7X; SSID=A0xU_mwKR1tBilqub; APISID=P8RubJ4tqotGeeij/Av5_40mOEVS5M4tJZ; SAPISID=WegLfry0kGUnniM9/AL94HuxWujxM08i8l; SID=6QTI2nfPnlkwicugl8HZ1Gtx9uDrWQ6dmeMJ9Ai1X3tm9vsao8Io47Gyni88DBUJ-Fdifw.; NID=107=NGkDqvEpdvDoGVzzD3ukN39C-grBdg36GbshDNdP2L8MF5JWBWF8iQ2HObrX5zlG9xpRAVNbGPwbYsbzFRw_i5Vl6FsaodV7T268pGF0l6h7HRXZD6hfmzh9snwlQ0U2VPlP_ZLl7KQmjNB3yMbrVg-Usd8iV3i73JwaTAnicnOl1VYuX--PdJwKBN24F7wEV7VlH7nbuKp3sS16_Lfezgm87wXNYVfoz8mKZjVNgaFfNbl3edNRTF6CuV2H1bXs1iZqXFstVSbi332hgToElmB-LB4_7tlXTmO0s7OtU5lDaLP2Cqg9N5OgUg; DV=UwKrOvbXqN9OEE2cXk7VD9VNopma01URecFTsiI64AIAANA61uwObVpxBQEAAFxN1Dl0-Y77SgAAAA; UULE=a+cm9sZToxIHByb2R1Y2VyOjEyIHByb3ZlbmFuY2U6NiB0aW1lc3RhbXA6MTQ5OTkxMTAwNDYzMjAwMCBsYXRsbmd7bGF0aXR1ZGVfZTc6MjIzOTY0MjgwIGxvbmdpdHVkZV9lNzoxMTQxMDk0OTcwfSByYWRpdXM6MTI1NTU2MjA=; S=billing-ui-v3=lmTqAbQ7t4etPiKkeZJf--loCyuSjtAF:billing-ui-v3-efe=lmTqAbQ7t4etPiKkeZJf--loCyuSjtAF:grandcentral=t3BEKLwOl8Pw5M33BAkLO0V4ixDQM3fK; _ga=GA1.1.1866389953.1499845471; _gid=GA1.1.1686810754.1499845471; _gat=1' -H 'x-client-data: CIu2yQEIo7bJAQj7nMoBCKmdygEI1J7KAQ==' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded;charset=UTF-8' -H 'accept: */*' -H 'referer: https://www.google.com/voice/b/0?gsessionid=t3BEKLwOl8Pw5M33BAkLO0V4ixDQM3fK' -H 'authority: www.google.com' -H 'dnt: 1' "
				. "--data 'sid=3&mid=6&req=%5Bnull%2C%22%2B" . substr($phone, 1) . "%22%2Ctrue%2C%22%22%5D&_rnr_se=CxZkTEu82stDdl7Un9H7XfyzZ2w%3D' --compressed 2>&1";
			echo $go, ' ', $phone, "\n";
			$s = shell_exec($cmd);
			if (strlen($s) && strpos($s, 'Please try again') === FALSE) {
				echo 'stop:', $s;
				exit;
			}
		}
	}
}
