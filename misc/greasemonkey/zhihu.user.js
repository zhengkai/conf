// ==UserScript==
// @name         知乎去提醒
// @namespace    https://soulogic.com/
// @version      1.4
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://*.zhihu.com/*
// @match        https://zhihu.com/*
// @grant        GM_addStyle
// ==/UserScript==

GM_addStyle(`
.highlight-wrap {
	border-bottom-width: 0 !important;
}
`);

(() => {
	'use strict';

	const hide = (a) => {
		if (!a?.style) {
			return;
		}
		a.style.display = 'none';
	};

	const clean = () => {

		if (document.hidden) {
			return;
		}

		document.title = document.title.replace(/\(.+?\) /, '');

		document.querySelectorAll('a[href="//www.zhihu.com"]').forEach(hide)
		document.querySelectorAll('.Pc-feedAd-container').forEach(v => hide(v?.parentNode));
		document.querySelectorAll('.VideoAnswerPlayer').forEach(v => hide(v?.parentNode?.parentNode?.parentNode));
		document.querySelectorAll('.ZVideoItem').forEach(v => hide(v?.parentNode?.parentNode));
		document.querySelectorAll('.Banner-link').forEach(hide);

		document.querySelectorAll('b, strong').forEach(v => {
			v.style.fontWeight = '400';
		});

		document.querySelectorAll('.RichContent-EntityWord').forEach(a => {
			if (a.style.display === 'none') {
				return;
			}
			const s = document.createTextNode(a.innerText);
			a.after(s);
			hide(a);
		});
	};

	clean();
	setInterval(clean, 500);
})();
