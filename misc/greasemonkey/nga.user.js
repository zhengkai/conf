// ==UserScript==
// @name         NGA 去广告
// @namespace    https://soulogic.com/
// @version      1.0
// @description  try to take over the world!
// @author       Zheng Kai
// @match        http://bbs.nga.cn/*
// @match        https://bbs.nga.cn/*
// @match        http://nga.178.com/*
// @match        https://nga.178.com/*
// @match        http://ngabbs.com/*
// @match        https://ngabbs.com/*
// @match        http://g.nga.cn/*
// @match        https://g.nga.cn/*
// @grant        none
// ==/UserScript==

(() => {
	'use strict';

    const mainDomain = 'bbs.nga.cn';
    // const mainDomain = 'nga.178.com';

	__COOKIE.setMiscCookieInSecond('pv_count_for_insad', -300);

	if (window.location.host !== mainDomain) {
		if (!window.location.pathname.includes('misc/adpage')) {
			window.location.href = 'https://' + mainDomain + window.location.pathname + window.location.search;
		}
		return;
	}

	const st = (id) => {
		const o = document.getElementById(id);
		if (o) {
			return o.style;
		}
		return {};
	};

	const clearAD = () => {

		st('mainmenu').margin = '0';
		st('toptopics').display = 'none';
		st('bbs_ads9_add').display = 'none';
		st('custombg').display = 'none';
        document.querySelectorAll('#m_posts_c > span, #SG_GG_CONTAINER_200809').forEach(v => v?.remove());

		try {
			const list = document.body.querySelectorAll('img');
			for (const img of list) {
				if (img.src.match('ngabbs/nga_classic/admark\.png')) {
					img.parentNode.parentNode.remove();
					continue;
				}
			}
		} catch (x) {
		}
	};

	clearAD();
    setInterval(clearAD, 500);

})();
