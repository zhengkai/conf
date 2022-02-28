// ==UserScript==
// @name         fextralife.com 去直播
// @namespace    https://soulogic.com/
// @version      0.4
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://*.fextralife.com/*
// @grant        none
// ==/UserScript==
//
(() => {

	const x = document.getElementById('video-stream-container');
	if (x) {
		x.innerHTML = '';
	}

	const clean = () => {
		document.querySelectorAll('body > picture, .ad-banner, .ad-siderbar, .hidden-sm, [data-adunit-name], .addthis-smartlayers').forEach(o => o.remove())
	};

	clean();
	setInterval(clean, 500);
})();
