// ==UserScript==
// @name         ChatGPT Keepalive
// @namespace    https://soulogic.com/
// @version      0.1
// @description  try to take over the world!
// @author       You
// @match        https://chat.openai.com/
// @icon         https://www.google.com/s2/favicons?sz=64&domain=openai.com
// @grant        none
// ==/UserScript==

(() => {
	'use strict';

	setInterval(() => {
		const iframe = document.createElement('iframe');
		iframe.style.display = 'none';
		iframe.src = '/api/auth/session';
		document.body.appendChild(iframe);
		iframe.onload = function() {
			document.body.removeChild(iframe);
		};
	}, 30000);
})();
