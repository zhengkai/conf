// ==UserScript==
// @name         Twitter Cleaner
// @namespace    https://soulogic.com/
// @version      2.0
// @description  屏蔽所有广告、视频、名字上带国旗、互fo、蓝标的推，你要懒得自己部署可以直接用 https://k.9farm.com/gm/twitter.user.js
// @author       Zheng Kai
// @match        https://twitter.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=twitter.com
// @grant        none
// ==/UserScript==
//
(() => {

	let tweetPage = false;

	const forceHide = (a) => {
		if (!a) {
			return false;
		}
		a.style.display = 'none';
		return true;
		// a?.remove();
	};

	const hide = (a) => {
		if (tweetPage || !a) {
			return false;
		}
		a.style.display = 'none';
		return true;
		// a?.remove();
	};

	const hideArticle = (a) => {
		if (!a?.closest('div[role=link]')) {
			hide(a?.closest('article'));
		}
	};

	const whiteList = [
		'iamshaynez',
		'PenngXiao',
		'salonbus1024',
		'PlayStation',
		'armoredcore',
		'salonbus1024',
	];

	const clean = () => {

		tweetPage = /\/status\/\d+$/.test(window.location.pathname);

		document.querySelectorAll('span').forEach(a => {
			if (a?.innerText?.startsWith('Promoted')) {
				hideArticle(a);
			}
		});

		document.querySelectorAll('video, iframe').forEach((a) => {
			hide(a?.closest('div[data-testid="tweetPhoto"]'));
			hide(a);
		});

		document.querySelectorAll('div[data-testid=User-Name] img[title^="Flag of"], div[data-testid=User-Name] img[title="🇺🇦"]').forEach(hideArticle);

		if (!document.querySelector('[data-testid="UserName"] svg[aria-label="Verified account"]')) {
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
				hideArticle(a);
			});
		}

		document.querySelectorAll('div[data-testid=User-Name] a span').forEach(a => {
			if (a.innerText.includes('互fo')) {
				hideArticle(a);
			}
		});

		document.querySelectorAll('aside[aria-label="Subscribe to Premium"], a[aria-label="Twitter Blue"], a[aria-label="Communities"], aside[aria-label="Get Verified"], a[aria-label="Verified"]').forEach(forceHide);

		document.querySelectorAll('[data-testid=tweetText]').forEach(a => {
			a.style.lineHeight = 1.75;
		});

		document.querySelectorAll('[aria-label$="View Tweet analytics"]').forEach(a => {
			hide(a.parentNode);
		});
	};

	clean();
	setInterval(clean, 500);
})();
