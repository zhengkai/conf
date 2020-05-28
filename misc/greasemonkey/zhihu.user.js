// ==UserScript==
// @name         知乎去提醒
// @namespace    https://soulogic.com/
// @version      0.2
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://www.zhihu.com/*
// @match        https://zhihu.com/*
// @grant        GM_addStyle
// ==/UserScript==

(() => {
    'use strict';

    GM_addStyle('div.css-ybodb { display: none; }');

    const clean = () => {
        document.body.querySelectorAll('div.PushNotifications, div.css-ybodb, div.AppHeader-messages, div.AppHeader-notifications, div.Banner-adsense, div.TopstoryItem--advertCard').forEach(v => {
            v.style.display = 'none';
        });

        document.body.querySelectorAll('div.RelatedCommodities-title, a.Banner-link').forEach(v => {
            v.parentNode.parentNode.removeChild(v.parentNode);
        });

        document.title = document.title.replace(/\(.+?\) /, '');
    };

    clean();
    setInterval(clean, 500);
})();

function GM_addStyle(cssStr) {
    const D = document;
    const newNode = D.createElement('style');
    newNode.textContent = cssStr;

    const targ = D.getElementsByTagName('head')[0] || D.body || D.documentElement;
    targ.appendChild (newNode);
}
