// ==UserScript==
// @name         知乎去提醒
// @namespace    https://soulogic.com/
// @version      1.1
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://*.zhihu.com/*
// @match        https://zhihu.com/*
// @grant        none
// ==/UserScript==

(() => {
    'use strict';

    const clean = () => {

		if (document.hidden) {
			return
		}

        document.title = document.title.replace(/\(.+?\) /, '');

		document.querySelectorAll('.Pc-feedAd-container').forEach(v => v?.parentNode?.remove());
		document.querySelectorAll('.VideoAnswerPlayer').forEach(v => v?.parentNode?.parentNode?.parentNode?.remove());
		document.querySelectorAll('.ZVideoItem').forEach(v => v?.parentNode?.parentNode?.remove());
		document.querySelectorAll('.Banner-link').forEach(v => v?.remove())

		document.querySelectorAll('b, strong').forEach(v => { v.style.fontWeight = '400' });

		document.querySelectorAll('.RichContent-EntityWord').forEach(a => {
			const s = document.createTextNode(a.innerText);
			a.after(s);
			a.remove();
		});
	};

	clean();
	setInterval(clean, 500);
})();
