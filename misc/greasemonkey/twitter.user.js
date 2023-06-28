// ==UserScript==
// @name         Twitter Cleaner
// @namespace    https://soulogic.com/
// @version      1.6
// @description  屏蔽所有广告、视频、名字上带国旗、互fo、蓝标的推，你要懒得自己部署可以直接用 https://k.9farm.com/gm/twitter.user.js
// @author       Zheng Kai
// @match        https://twitter.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=twitter.com
// @grant        none
// ==/UserScript==
//
(() => {

	const hide = (a) => {
		if (!a) {
			return;
		}
		a.style.display = 'none';
		// a?.remove();
	};

	const whiteList = [
		'iamshaynez',
		'PenngXiao',
	];

	const clean = () => {
		document.querySelectorAll('span').forEach(a => {
			if (!a?.innerText?.startsWith('Promoted')) {
				return;
			}
			hide(a?.closest('article'));
		});

		document.querySelectorAll('video, iframe, div[data-testid=User-Name] img[title^="Flag of"], div[data-testid=User-Name] img[title="🇺🇦"]').forEach(a => {
			hide(a?.closest('article'));
		});

		document.querySelectorAll('svg[aria-label="Verified account"]').forEach(icon => {
			const a = icon.closest('[data-testid="User-Name"]');
			if (!a) {
				return;
			}
			for (const s of whiteList) {
				if (a.innerText.includes(s)) {
					return;
				}
			}
			hide(a?.closest('article'));
		});

		document.querySelectorAll('div[data-testid=User-Name] a span').forEach(a => {
			if (!a.innerText.includes('互fo')) {
				return;
			}
			hide(a?.closest('article'));
		});

		document.querySelectorAll('a[aria-label="Twitter Blue"], a[aria-label="Communities"], aside[aria-label="Get Verified"], a[aria-label="Verified"]').forEach(hide);

		document.querySelectorAll('[data-testid=tweetText]').forEach(a => {
			a.style.lineHeight = 1.75;
		});

		document.querySelectorAll('a').forEach(a => {
			if (!a.href.endsWith('/analytics')) {
				return;
			}
			hide(a.parentNode);
		});

		document.querySelectorAll('div[aria-label$="Like"]').forEach(a => {
			hide(a.parentNode);
		});
	};

	clean();
	setInterval(clean, 500);
})();
