// ==UserScript==
// @name         知乎去提醒
// @namespace    https://soulogic.com/
// @version      0.5
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://www.zhihu.com/*
// @match        https://zhihu.com/*
// @grant        GM_addStyle
// ==/UserScript==

(() => {
    'use strict';

    GM_addStyle('div.css-ybodb { display: none; }');
    GM_addStyle('div.Popover18-toggle > div { display: none; }');

    const clean = () => {

		if (document.hidden) {
			return
		}

		/*
        document.body.querySelectorAll('.Popover18-toggle > div').forEach(v => {
            v.style.display = 'none';
        });

        document.body.querySelectorAll('div.RelatedCommodities-title, a.Banner-link').forEach(v => {
            v.parentNode.parentNode.removeChild(v.parentNode);
        });
		 */

        document.title = document.title.replace(/\(.+?\) /, '');

		document.querySelectorAll('.Pc-feedAd-container').forEach(v => v?.parentNode?.remove());
		document.querySelectorAll('.VideoAnswerPlayer').forEach(v => v?.parentNode?.parentNode?.parentNode?.parentNode?.remove());
		document.querySelectorAll('.ZVideoItem').forEach(v => v?.parentNode?.parentNode?.remove());
    };

    clean();
    setInterval(clean, 500);
})();

function GM_addStyle(cssStr) {
    const D = document;
    const newNode = D.createElement('style');
    newNode.textContent = cssStr;

    const targ = D.getElementsByTagName('head')[0] || D.body || D.documentElement;
    targ.appendChild (newNode);
}
