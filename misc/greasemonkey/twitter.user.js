// ==UserScript==
// @name         Twitter Remove Promoted
// @namespace    https://soulogic.com/
// @version      0.1
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
				a?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode?.parentNode.remove();
			}
		});
	};

	clean();
	setInterval(clean, 500);
})();
