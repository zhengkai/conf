// ==UserScript==
// @name         Twitter Cleaner
// @namespace    https://soulogic.com/
// @version      2.5
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
