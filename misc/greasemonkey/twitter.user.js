// ==UserScript==
// @name         Twitter Cleaner
// @namespace    https://soulogic.com/
// @version      2.6
// @description  hide twitter link
// @author       Zheng Kai
// @match        https://x.com/*
// @match        https://twitter.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=twitter.com
// @grant        GM_addStyle
// ==/UserScript==

GM_addStyle(`
a[aria-label="社群"],
a[aria-label="Premium"],
a[href="/i/premium_sign_up"],
a[href="/i/premium-business"],
div[data-testid="super-upsell-UpsellCardRenderProperties"],
div[data-testid="verified_profile_visitor_upsell"],
div[data-testid="analytics-preview"],
div[style*="background-color: rgb(0, 67, 41)"],
div[data-testid="chat-drawer-main"],
div[data-testid="GrokDrawerHeader"],
div#twitter-bird-shield-content,
a[href="/i/premium-business"],
a[href="/i/jf/creators/studio"],
div.mark-container {
	display: none !important;
}
`);

(() => {
	const clean = (o) => {
		o.classList.add('ignore');
		if (o.innerHTML === "广告") {
			console.log('delete', o);
			o.closest('article').style.display = "none";
		};
	};
	const loop = () => {
		document.querySelectorAll('*:not(a) > div[style*="color: rgb(113, 118, 123)"]:not(:has(a)):has(> span:only-child) > span:not(.ignore)').forEach(clean);
	};
	setInterval(loop, 100);
})();
