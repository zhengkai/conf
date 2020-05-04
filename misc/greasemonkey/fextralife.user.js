// ==UserScript==
// @name         fextralife.com 去直播
// @namespace    https://soulogic.com/
// @version      0.3
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

	document.querySelectorAll('body > picture').forEach((pic) => {
		pic.innerHTML = '';
	});
})();
