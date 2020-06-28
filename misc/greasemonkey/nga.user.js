// ==UserScript==
// @name         NGA 去广告
// @namespace    https://soulogic.com/
// @version      0.4
// @description  try to take over the world!
// @author       Zheng Kai
// @match        http://bbs.nga.cn/*
// @match        https://bbs.nga.cn/*
// @match        http://nga.178.com/*
// @grant        none
// ==/UserScript==

(() => {
	'use strict';

	const st = (id) => {
		const o = document.getElementById(id);
		if (o) {
			return o.style;
		}
		return {};
	};

	__COOKIE.setMiscCookieInSecond('pv_count_for_insad', -300);

	const clearAD = () => {

		st('mainmenu').margin = '0';
		st('toptopics').display = 'none';
		st('bbs_ads9_add').display = 'none';
		st('custombg').display = 'none';

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
	for (let i = 0; i < 10; i++) {
		window.setTimeout(() => {
			clearAD();
		}, i * 1000);
	}

})();
