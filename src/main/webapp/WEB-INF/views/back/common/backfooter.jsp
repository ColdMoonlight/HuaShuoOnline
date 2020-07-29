<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<!-- common script -->
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script src="${APP_PATH}/static/common/toastr/toastr.min.js"></script>
<script src="${APP_PATH}/static/back/lib/bootstrap/bootstrap.min.js"></script>
<script src="${APP_PATH}/static/back/js/main.js"></script>
<script>
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
</script>
