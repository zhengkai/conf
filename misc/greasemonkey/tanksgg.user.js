// ==UserScript==
// @name         tanks.gg 去广告
// @namespace    https://soulogic.com/
// @version      0.2
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://tanks.gg/*
// @grant        none
// ==/UserScript==
//
(() => {
	setInterval(() => {
		document.querySelectorAll('body > div').forEach(v => {
			if (v?.style?.left === '10px') {
				v.style.left = '-10000px';
			}
		});
		const x = document.getElementById('ac-lre-player-ph')
		if (x) {
			x.style.display = 'none';
		}

		document.querySelectorAll('.ac-unit').forEach(o => o.remove())
	}, 500);
})();
