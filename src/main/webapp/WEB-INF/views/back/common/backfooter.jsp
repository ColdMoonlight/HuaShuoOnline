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
</script>
