// ==UserScript==
// @name         Twitter Remove Promoted
// @namespace    https://soulogic.com/
// @version      1.3
// @description  try to take over the world!
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

	const clean = () => {
		document.querySelectorAll('span').forEach(a => {
			if (!a?.innerText?.startsWith('Promoted')) {
				return;
			}
			hide(a?.closest('article'));
		});

		document.querySelectorAll('video, iframe, svg[aria-label="Verified account"], div[data-testid=User-Name] img[title^="Flag of"], div[data-testid=User-Name] img[title="🇺🇦"]').forEach(a => {
			hide(a?.closest('article'));
		});

		document.querySelectorAll('div[data-testid=User-Name] a span').forEach(a => {
			if (!a?.innerText?.includes('互fo')) {
				return;
			}
			hide(a?.closest('article'));
		});

		document.querySelector('a[aria-label="Twitter Blue"]')?.remove();

		document.querySelectorAll('[data-testid=tweetText]').forEach(a => {
			a.style.lineHeight = 1.75;
		});

		document.querySelectorAll('a').forEach(a => {
			if (!a?.href?.endsWith('/analytics')) {
				return;
			}
			const p = a?.parentNode;
			if (p?.getAttribute('data-testid') !== 'Dropdown') {
				hide(p);
			}
		});
	};

	clean();
	setInterval(clean, 500);
})();
