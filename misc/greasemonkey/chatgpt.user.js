// ==UserScript==
// @name         ChatGPT
// @namespace    https://soulogic.com/
// @version      0.3
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://chatgpt.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=openai.com
// @grant        GM_addStyle
// ==/UserScript==

GM_addStyle(`
div[aria-live="polite"][popover="manual"] {
	display: none !important;
}
`);
