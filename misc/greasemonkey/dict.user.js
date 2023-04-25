// ==UserScript==
// @name         dict.cn
// @namespace    https://soulogic.com/
// @version      0.1
// @description  try to take over the world!
// @author       Zheng Kai
// @match        http://dict.cn/*
// @match        https://dict.cn/*
// @grant        none
// ==/UserScript==

(() => {
	'use strict';

	const clean = () => {
		if (document.hidden) {
			return;
		}
		document.querySelectorAll('iframe').forEach(v => v?.remove());
		document.getElementById('aswift_0_host')?.remove();
		document.getElementById('aswift_1_host')?.remove();

		const o = document.getElementById('dict-chart-basic')?.style;
		if (o) {
			o.position = 'absolute';
			o.right = 0;
			o.top = 0;
		}
	};

	clean();
	setInterval(clean, 500);
})();
