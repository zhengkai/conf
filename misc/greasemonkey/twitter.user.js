// ==UserScript==
// @name         Twitter Remove Promoted
// @namespace    https://soulogic.com/
// @version      1.0
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://twitter.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=twitter.com
// @grant        none
// ==/UserScript==
//
(() => {

	const clean = () => {
		document.querySelectorAll('span').forEach(a => {
			if (!a.innerText.startsWith('Promoted')) {
				return;
			}
			const b = a.closest('article');
			if (!b) {
				return;
			}
			b.style.display = 'none';
			b?.remove();
		});

		document.querySelectorAll('video, iframe, div[data-testid=User-Name] img[title^="Flag of"], div[data-testid=User-Name] img[title="🇺🇦"]').forEach(a => {
			const b = a.closest('article');
			if (!b) {
				return;
			}
			b.style.display = 'none';
			b?.remove();
		});

		document.querySelectorAll('div[data-testid=User-Name] a span').forEach(a => {
			if (!a.innerText.includes('互fo')) {
				return;
			}
			const b = a.closest('article');
			if (!b) {
				return;
			}
			b.style.display = 'none';
			b?.remove();
		});

		document.querySelector('a[aria-label="Twitter Blue"]')?.remove();

		document.querySelectorAll('[data-testid=tweetText]').forEach(a => {
			a.style.lineHeight = 1.75;
		});

		document.querySelectorAll('a').forEach(a => {
			if (!a.href.endsWith('/analytics')) {
				return;
			}
			const p = a?.parentNode;
			if (p?.getAttribute('data-testid') !== 'Dropdown') {
				p.style.display = 'none';
			}
		});
	};

	clean();
	setInterval(clean, 500);
})();
