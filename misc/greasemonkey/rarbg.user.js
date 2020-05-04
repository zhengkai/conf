// ==UserScript==
// @name         rarbg ad block
// @namespace    https://soulogic.com/
// @version      0.8
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://rarbgunblocked.org/*
// @match        https://rarbg.to/*
// @match        https://proxyrarbg.org/*
// @match        https://rarbgprx.org/*
// @grant        none
// ==/UserScript==

(() => {
	'use strict';

    document.cookie.split('; ').map((v) => {

        const match = v.match('ppu_main_(.*?)=');
        if (!match) {
            return;
        }
        const key = match[1];

        console.log('match key', key);

        const expires = '; expires=' + new Date(2030, 3, 3).toGMTString();
        document.cookie = 'ppu_main_' + key + '=1' + expires;
        document.cookie = 'ppu_sub_' + key + '=10' + expires;
    });

	const ad = document.body.querySelector('td[align=justify] > div[align=center] > table');
	if (ad) {
		ad.remove();
	}

	let clearCount = 0;

	const clear = () => {

		if (document.hidden) {
			return;
		}

		const list = document.querySelectorAll('body > div');
        const a = list[list.length - 1];
		if (a && a.innerHTML) {
            a.innerHTML = '';
            const style = a.style;
            style.display = 'none';
            style.width = '1px';
            style.height = '1px';
		}

		clearCount++;
		if (clearCount < 10) {
            /*
            document.body.querySelectorAll('a, input').forEach((dom) => {
                dom.outerHTML = dom.outerHTML;
            });
             */
		}
	};

	clear();
	window.setInterval(clear, 100);

})();
