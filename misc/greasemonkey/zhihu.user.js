// ==UserScript==
// @name         知乎去提醒
// @namespace    https://soulogic.com/
// @version      0.1
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://www.zhihu.com/*
// @match        https://zhihu.com/*
// @grant        none
// ==/UserScript==

(() => {
    'use strict';

    const clean = () => {
        document.body.querySelectorAll('div.PushNotifications, div.AppHeader-messages, div.Banner-adsense, div.TopstoryItem--advertCard').forEach(v => {
            v.parentNode.removeChild(v);
        });

        document.body.querySelectorAll('div.RelatedCommodities-title, a.Banner-link').forEach(v => {
            v.parentNode.parentNode.removeChild(v.parentNode);
        });

        document.title = document.title.replace(/\(.+?\) /, '');
    };

    clean();
    setInterval(clean, 500);
})();
