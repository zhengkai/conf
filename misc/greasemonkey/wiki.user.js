// ==UserScript==
// @name         wiki 去移动版
// @namespace    https://soulogic.com/
// @version      0.2
// @description  try to take over the world!
// @author       Zheng Kai
// @match        *://*.m.wikipedia.org/*
// @match        *://*.m.wikisource.org/*
// @grant        none
// ==/UserScript==

(() => {
	'use strict';

	if (window.location.host.endsWith('.m.wikipedia.org')) {
		window.location.href = window.location.href.replace(/\.m\.wikipedia\.org/, '.wikipedia.org')
		return;
	}
	if (window.location.host.endsWith('.m.wikisource.org')) {
		window.location.href = window.location.href.replace(/\.m\.wikisource\.org/, '.wikisource.org')
		return;
	}
})();
