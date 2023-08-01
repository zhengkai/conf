// ==UserScript==
// @name         btschool ad remover
// @namespace    https://soulogic.com/
// @version      0.1
// @description  try to take over the world!
// @author       Zheng Kai
// @match        https://*.btschool.club/*
// @grant        none
// ==/UserScript==
//
(() => {
	const remove = (id) => {
		const o = document.querySelector(id);
		if (o) {
			o.style.overflow = 'hidden';
			o.style.height = '1px';
			o.querySelectorAll('td')?.forEach((td) => {
				td.style.display = 'block';
				td.style.overflow = 'hidden';
				td.style.height = '1px';
			});
		}
	};
	remove('#ad_belowsearchbox');
	remove('#ad_belownav');
	remove('#ad_belownav');
	remove('#ad_torrentdetail');
	remove('table.head');
})();
