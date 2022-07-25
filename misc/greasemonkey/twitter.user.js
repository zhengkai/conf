// ==UserScript==
// @name         Twitter Remove Promoted
// @namespace    https://soulogic.com/
// @version      0.2
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://twitter.com/*
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

		document.querySelectorAll('video').forEach(a => {
			const p = a?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode;
			if (p) {
				p.style.display = 'none';
			}
			a?.remove();
		});
	};

	clean();
	setInterval(clean, 500);
})();
