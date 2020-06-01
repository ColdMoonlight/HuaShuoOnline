/*!
 * @copyright Copyright (c) 2017 IcoMoon.io
 * @license   Licensed under MIT license
 *            See https://github.com/Keyamoon/svgxuse
 * @version   1.2.6
 */
(function(){if("undefined"!==typeof window&&window.addEventListener){var e=Object.create(null),l,d=function(){clearTimeout(l);l=setTimeout(n,100)},m=function(){},t=function(){window.addEventListener("resize",d,!1);window.addEventListener("orientationchange",d,!1);if(window.MutationObserver){var k=new MutationObserver(d);k.observe(document.documentElement,{childList:!0,subtree:!0,attributes:!0});m=function(){try{k.disconnect(),window.removeEventListener("resize",d,!1),window.removeEventListener("orientationchange",
d,!1)}catch(v){}}}else document.documentElement.addEventListener("DOMSubtreeModified",d,!1),m=function(){document.documentElement.removeEventListener("DOMSubtreeModified",d,!1);window.removeEventListener("resize",d,!1);window.removeEventListener("orientationchange",d,!1)}},u=function(k){function e(a){if(void 0!==a.protocol)var b=a;else b=document.createElement("a"),b.href=a;return b.protocol.replace(/:/g,"")+b.host}if(window.XMLHttpRequest){var d=new XMLHttpRequest;var m=e(location);k=e(k);d=void 0===
d.withCredentials&&""!==k&&k!==m?XDomainRequest||void 0:XMLHttpRequest}return d};var n=function(){function d(){--q;0===q&&(m(),t())}function l(a){return function(){!0!==e[a.base]&&(a.useEl.setAttributeNS("http://www.w3.org/1999/xlink","xlink:href","#"+a.hash),a.useEl.hasAttribute("href")&&a.useEl.setAttribute("href","#"+a.hash))}}function p(a){return function(){var c=document.body,b=document.createElement("x");a.onload=null;b.innerHTML=a.responseText;if(b=b.getElementsByTagName("svg")[0])b.setAttribute("aria-hidden",
"true"),b.style.position="absolute",b.style.width=0,b.style.height=0,b.style.overflow="hidden",c.insertBefore(b,c.firstChild);d()}}function n(a){return function(){a.onerror=null;a.ontimeout=null;d()}}var a,b,q=0;m();var f=document.getElementsByTagName("use");for(b=0;b<f.length;b+=1){try{var h=f[b].getBoundingClientRect()}catch(w){h=!1}var g=(a=f[b].getAttribute("href")||f[b].getAttributeNS("http://www.w3.org/1999/xlink","href")||f[b].getAttribute("xlink:href"))&&a.split?a.split("#"):["",""];var c=
g[0];g=g[1];var r=h&&0===h.left&&0===h.right&&0===h.top&&0===h.bottom;h&&0===h.width&&0===h.height&&!r?(c.length||!g||document.getElementById(g)||(c=""),f[b].hasAttribute("href")&&f[b].setAttributeNS("http://www.w3.org/1999/xlink","xlink:href",a),c.length&&(a=e[c],!0!==a&&setTimeout(l({useEl:f[b],base:c,hash:g}),0),void 0===a&&(g=u(c),void 0!==g&&(a=new g,e[c]=a,a.onload=p(a),a.onerror=n(a),a.ontimeout=n(a),a.open("GET",c),a.send(),q+=1)))):r?c.length&&e[c]&&setTimeout(l({useEl:f[b],base:c,
hash:g}),0):void 0===e[c]?e[c]=!0:e[c].onload&&(e[c].abort(),delete e[c].onload,e[c]=!0)}f="";q+=1;d()};var p=function(){window.removeEventListener("load",p,!1);l=setTimeout(n,0)};"complete"!==document.readyState?window.addEventListener("load",p,!1):p()}})();
/* toastr options*/
toastr.options = {
	closeButton: true,
	timeout: 1000,
	hideDuration: 500
};
/* button spinner*/
function showSpinner(self) {
	$(self).attr('disabled', 'disabled');
	$(self).find('.spinner-text').hide();
	$(self).find('.spinner-border').show();
}
function hideSpinner(self) {
	$(self).removeAttr('disabled');
	$(self).find('.spinner-text').show();
	$(self).find('.spinner-border').hide();
}

var CURRENT_URL = window.location.href.split('#')[0],
	$SIDEBAR_MENU = $('#sidebar-menu');

// check page unload
window.addEventListener("beforeunload", function(e) {
	// initial page-num
	setPageNum(1);
});
// Sidebar
function init_sidebar() {
	var closeMenu = function () {
		$SIDEBAR_MENU.find('li').removeClass('active');
		$SIDEBAR_MENU.find('li ul').slideUp();
	}

	$SIDEBAR_MENU.find('a').on('click', function (e) {
		var $li = $(this).parent();
		if ($li.is('.active')) {
			$li.removeClass('active');
			$('ul:first', $li).slideUp();
		} else {
			closeMenu();
			$li.addClass('active');
			$('ul:first', $li).slideDown();
		}
		new PerfectScrollbar('#sidebar-menu', {
			wheelSpeed: 2,
			wheelPropagation: true,
			minScrollbarLength: 20
		});
	});

	// setting current page -> navItem
	$SIDEBAR_MENU.find('a[href="' + CURRENT_URL + '"]').parent('li').addClass('current-page');
	$SIDEBAR_MENU.find('a').filter(function () {
		return this.href == CURRENT_URL;
	}).parent('li').addClass('current-page').parents('ul').slideDown(function () {
		new PerfectScrollbar('#sidebar-menu', {
			wheelSpeed: 2,
			wheelPropagation: true,
			minScrollbarLength: 20
		});
	}).parent().addClass('active');
}

init_sidebar();
/* collections */
var storage = window.localStorage;
/* pageNum */
function getPageNum() {
	return storage.getItem('pageNum') || 1
}

function setPageNum(val) {
	storage.setItem('pageNum', val);
}

function makerArray(n) {
	var arr = []
	for (var i = 0; i < n; i++) {
		arr.push(i + 1);
	}
	return arr;
}
function renderTablePagination(data) {
	if (data) {
		$("#table-pagination").empty();
		//构建元素
		var pageUl = $('<ul class="pagination" />'),
			firstPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('首页').attr('href', '#')),
			prePageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&laquo;')),
			nextPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&raquo;')),
			lastPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('末页').attr('href', '#')),
			pageCurrentNum = data.pageNum,
			pageNums = data.pages,
			pageArr = [];
		prePageLi.on('click', function () {
			pageCurrentNum > 1 && setPageNum(pageCurrentNum - 1);
		});
		nextPageLi.on('click', function () {
			pageCurrentNum < pageNums && setPageNum(pageCurrentNum + 1);
		});
		if (pageNums > 5) {
			if (pageCurrentNum <= 5) {
				pageArr = [1, 2, 3, 4, 5];
			} else if (pageCurrentNum > pageNums - 5) {
				pageArr = [pageNums - 4, pageNums - 3, pageNums - 2, pageNums - 1, pageNums];
			} else {
				pageArr = [pageCurrentNum - 2, pageCurrentNum - 1, pageCurrentNum, pageCurrentNum + 1, pageCurrentNum + 2];
			}
		} else {
			pageArr = makerArray(pageNums || 1);
		}

		if (data.hasPreviousPage == false) {
			firstPageLi.addClass('disabled');
			prePageLi.addClass('disabled');
		} else {
			//为元素添加点击翻页的事件
			firstPageLi.click(function () {
				setPageNum(1);
			});
			prePageLi.click(function () {
				setPageNum(pageCurrentNum - 1);
			});
		}

		if (data.hasNextPage == false) {
			nextPageLi.addClass('disabled');
			lastPageLi.addClass('disabled');
		} else {
			nextPageLi.click(function () {
				setPageNum(pageCurrentNum + 1);
			});
			lastPageLi.click(function () {
				setPageNum(pageNums);
			});
		}

		pageUl.append(firstPageLi).append(prePageLi);

		$.each(pageArr, function (i, item) {
			var numLi = $('<li class="page-item" />').append($('<a class="page-link" href="#" />').append(item));
			if (pageCurrentNum == item) {
				numLi.addClass('active');
			}
			numLi.click(function () {
				setPageNum(item);
			});
			pageUl.append(numLi);
		});

		pageUl.append(nextPageLi).append(lastPageLi);

		var navEle = $('<nav aria-label="Page navigation" />').append(pageUl);
		navEle.appendTo('#table-pagination');
	}
}

function encodeUrl(url) {
	return window.encodeURI(url).replace('(', '%28').replace(')', '%29')
}

function decodeUrl(url) {
	return window.decodeURI(url);
}