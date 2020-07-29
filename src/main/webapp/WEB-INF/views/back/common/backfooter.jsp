<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<!-- common script -->
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script src="${APP_PATH}/static/common/toastr/toastr.min.js"></script>
<script src="${APP_PATH}/static/back/lib/bootstrap/bootstrap.min.js"></script>
<script>
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
</script>
<!-- custom -->
<script>
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
				firstPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('first')),
				prePageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&laquo;')),
				nextPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&raquo;')),
				lastPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('last')),
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
				var numLi = $('<li class="page-item" />').append($('<a class="page-link" />').append(item));
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
	var format = 'YYYY-MM-DD HH:mm:ss';

	// intitial date
	function initDate() {
		return moment(new Date()).format(format);
	}

	// daterange
	function bindDateRangeEvent(callback) {
		$('.daterangetimepicker').daterangepicker({
			timePicker: true,
			timePicker24Hour: true,
			timePickerSeconds: true,
			showWeekNumbers: true,
			locale: {
				format: format,
			},
			ranges: {
		        'Today': [moment(), moment()],
		        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
		        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
		        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
		        'This Month': [moment().startOf('month'), moment().endOf('month')],
		        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
		    }
		}, function(start, end, label) {
			var startTime = moment(new Date(start)).format(format);
			var endTime = moment(new Date(end)).format(format);
			callback && callback(startTime, endTime);
		});
	}
	
	// timepicker
	function bindDateTimepicker() {
		$('.datetimepicker').daterangepicker({
			singleDatePicker: true,
			timePicker: true,
			timePickerSeconds: true,
			showWeekNumbers: true,
			locale: {
				format: format,
			},
		});
	}

	function getMilliseconds(value) {
		return moment(value, format).utc().valueOf();
	}
	
	// callback superCategory
	function getSuperCategoryData(callback) {
		$('.c-mask').show();
		$.ajax({
			url: "${APP_PATH}/MlbackSuperCate/getSuperCateDownList",
			type: "post",
			contentType: 'application/json',
			async: false,
			success: function (data) {
				if (data.code == 100) {
					toastr.success(data.extend.resMsg);
					callback(data.extend.mlbackSuperCateResList);
				} else {
					toastr.error(data.extend.resMsg);
				}
			},
			error: function (err) {
				toastr.error(err);
			},
			complete: function () {
				$('.c-mask').hide();
			}
		});
	}
	// render superCategoryData
	function renderSuperCategory(data) {
		var htmlStr = '<option value="-1">Please Select Super-category</option>';
		for (var i = 0, len = data.length; i < len; i += 1) {
			htmlStr += '<option value="' + data[i].supercateId + '">' + data[i].supercateName + '</option>';
		}
		$('.supercate-list').html(htmlStr);
		$('#searchSupercate').html(htmlStr);
		hasSuperCateList = true;
	}
	
	// callback get all product
	function getAllProductData(callback) {
		$('.c-mask').show();
		$.ajax({
			url: "${APP_PATH}/MlbackProduct/lownLoadProduct",
			type: "post",
			contentType: 'application/json',
			async: false,
			success: function (data) {
				if (data.code == 100) {
					toastr.success(data.extend.resMsg);
					callback(data.extend.mlbackProductResList);
				} else {
					toastr.error(data.extend.resMsg);
				}
			},
			error: function (err) {
				toastr.error(err);
			},
			complete: function () {
				$('.c-mask').hide();
			}
		});
	}
	// render all product data
	function renderAllProduct(data) {
		var htmlStr = '<option value="-1">Please Select product</option>';
		for (var i = 0; i < data.length; i += 1) {
				htmlStr += '<option value="' + data[i].productId + '" data-seo="'+ data[i].productSeo +'" data-name="'+ data[i].productName + '">' + data[i].productId + ' * '+ data[i].productName + '</option>';
			}
		$('.product-list').html(htmlStr);
		hasProductList = true;
	}
	// get all collection
	function getAllCollectionData(callback) {
		$('#editModal .spinner').show();
		$.ajax({
			url: "${APP_PATH}/MlbackCategory/getMlbackCategoryDropdownSelect",
			type: "post",
			contentType: 'application/json',
			async: false,
			success: function (data) {
				if (data.code == 100) {
					toastr.success(data.extend.resMsg);
					callback(data.extend.mlbackCategorydownList);
				} else {
					toastr.error(data.extend.resMsg);
				}
			},
			error: function (err) {
				toastr.error(err);
			},
			complete: function () {
				$('#editModal .spinner').hide();
			}
		});
	}
	// render all collection
	function renderAllCollection(data) {
		var htmlStr = '<option value="-1">Please Select collection</option>';
		for (var i = 0; i < data.length; i += 1) {
				htmlStr += '<option value="' + data[i].categoryId + '" data-seo="'+ data[i].categorySeo +'" data-name="'+ data[i].categoryName + '">' + data[i].categoryId + ' * '+ data[i].categoryDesc + '</option>';
			}
		$('.collection-list').html(htmlStr);
		hasCollectionList = true;
	}

	/* table tab list for storage */
	function renderTabItems() {
		var products = getStorageList(),
			len = products.length,
			htmlStr = '',
			activeNum = parseInt(getActiveItemNum());

		if (len > 0) {
			for (var i = 0; i < len; i += 1) {
				var $item = createTableTabItem(products[i]);
				$item.attr('data-idx', i+1);

				if (activeNum == i + 1) {
					$item.addClass('active')
				}

				htmlStr += $item[0].outerHTML;
			}

			$('.c-table-tab-list').append(htmlStr);
		}
		// check activeItem exsits or not.
		if ($('.c-table-tab-item.active').length < 1) {
			$('.c-table-tab-item').eq(0).addClass('active');
		}

		getTabSearchData($('.c-table-tab-item.active'));
	}
	// check new item
	function checkNewItem(val) {
		var storageList = getStorageList();
		if (storageList.length >= 6) {
			// save-search-item num <= 6
			toastr.info('You can add up to six search records！');
			return true;
		}
			
		var filterArr = storageList.filter(function(item) {
			if (JSON.stringify(val) === JSON.stringify(item)) {
				return item;
			}
		});

		if (filterArr.length > 0) {
			toastr.info('You can not add it repeatedly！');
			return true;
		}
		return false;
	}
	// initial activeItem
	function initActiveItemNum() {
		$('.c-table-tab-tempory').html('');
		$('.c-table-tab-item').removeClass('active').eq(0).addClass('active');
		setActiveItemNum(0);
		setPageNum(1);
	}
	// add table tab item
	function addTableTabItem(val, idx) {
		var $tableTabItem = createTableTabItem(val).addClass('active');
		$('.c-table-tab-item').removeClass('active');
		idx && $tableTabItem.attr('data-idx', idx);
		$('.c-table-tab-list').append($tableTabItem);
	}
	// generate table tab item
	function createTableTabItem(val) {
		var textArr = [];
		for (var key in val) {
			val[key] && isNaN(val[key]) && textArr.push(val[key]);
		}

		return $('<div class="c-table-tab-item">' + textArr.join("-") + '<div class="delete-table-tab-item c-icon">x</div></div>').attr('data-val', JSON.stringify(val));
	}
	// delete table tab item
	function deleteTableTabItem(e) {
		e.stopPropagation();
		var targetEl = $(e.target),
			parentEl = targetEl.parent('.c-table-tab-item'),
			itemVal = $(parentEl).data('val');

		deleteStorageItem(itemVal);
		$(parentEl).remove();

		$('.c-table-tab-item').eq(0).addClass('active');
		getTabSearchData($('.c-table-tab-item').eq(0));
	}
	// get storage list
	function getStorageList() {
		return JSON.parse(storage.getItem(storageName)) || [];
	}
	// delete one storage
	function deleteStorageItem(name) {
		var oldStorageList = getStorageList();
		var newStorageList = oldStorageList.filter(function (item) {
			if (JSON.stringify(item) != JSON.stringify(name)) return item;
		});
		storage.setItem(storageName, JSON.stringify(newStorageList));
		setActiveItemNum(0);
	}
	// add one storage
	function addStorageItem(name) {
		var storageList = getStorageList();
		storageList.push(name);
		storage.setItem(storageName, JSON.stringify(storageList));
		setActiveItemNum(storageList.length);
	}
	// tab active-item cache get
	function getActiveItemNum() {
		return storage.getItem('itemNum') || 0;
	}
	// tab active-item cache set
	function setActiveItemNum(num) {
		storage.setItem('itemNum', num);
	}
	var CURRENT_URL = window.location.href.split('#')[0],
	$SIDEBAR_MENU = $('#sidebar-menu');

	/* collections */
	var storage = window.localStorage;
	init_sidebar();
	/* toastr options*/
	toastr.options = {
		closeButton: true,
		timeout: 1000,
		hideDuration: 500
	};
	// check page unload
	window.addEventListener("beforeunload", function(e) {
		// initial page-num
		setPageNum(1);
		setActiveItemNum(0);
	});
</script>
