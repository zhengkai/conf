// ==UserScript==
// @name         Twitter Remove Promoted
// @namespace    https://soulogic.com/
// @version      0.7
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
			if (a.innerText.startsWith('Promoted')) {
				const n = a?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode;
				if (n) {
					n.style.display = 'none';
				}
			}
		});

		document.querySelectorAll('video, iframe').forEach(a => {
			const p = a?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode;
			if (p) {
				p.style.display = 'none';
			}
			a?.remove();
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
