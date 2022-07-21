// ==UserScript==
// @name         wiki 去移动版
// @namespace    https://soulogic.com/
// @version      0.1
// @description  try to take over the world!
// @author       Zheng Kai
// @match        http://*.m.wikipedia.org/*
// @match        https://*.m.wikipedia.org/*
// @grant        none
// ==/UserScript==

(() => {
	'use strict';

	if (window.location.host.endsWith('.m.wikipedia.org')) {
		window.location.href = window.location.href.replace(/\.m\.wikipedia\.org/, '.wikipedia.org')
	}
})();
