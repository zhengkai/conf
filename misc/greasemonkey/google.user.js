// ==UserScript==
// @name         Hide Google Box
// @namespace    http://tampermonkey.net/
// @version      2025-12-11
// @description  Hide that dumbass Google AI answer box.
// @author       Soulogic
// @match        https://www.google.com/*
// @icon         https://www.google.com/s2/favicons?sz=64&domain=google.com
// @grant        GM_addStyle
// ==/UserScript==

GM_addStyle(`
    [data-async-type="folsrch"] {
        display: none !important;
    }
`);
