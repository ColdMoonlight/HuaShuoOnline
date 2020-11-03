<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Whole Sale</title>
	<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	<link rel="stylesheet" href="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.css">	
</head>
<body class="c-app">
	<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
	<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
	<div class="c-wrapper">
		<div class="c-body">
			<div class="c-main">
				<div class="c-init">
					<div class="c-option">
						<span class="c-option-title">Whole-sale list</span>
						<!-- <button class="btn btn-primary btn-create">Create Order</button> -->
					</div>
					<div class="ecpp-sync row">
						<div class="form-group col-md-4">
							<div class="controls">
								<input hidden id="order-create-time" />
								<input hidden id="order-confirm-time" />
								<input class="form-control daterangetimepicker" id="order-time" type="text" />
							</div>
						</div>
						
					</div>
					<div class="c-table">
						<div class="c-table-tab">
							<div class="c-table-tab-item" data-idx="0">All</div>
							<div class="c-table-tab-list"></div>
							<div class="c-table-tab-tempory"></div>
						</div>
						<div class="c-table-content">
							<div class="input-group c-search">
								<svg class="c-icon">
									<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-magnifying-glass"></use>
								</svg>
								<div class="form-control">
									<input id="customer-name" type="text" placeholder="Search Whole-sale" disabled>						
									<select class="supercate-list" id="searchSupercate" disabled></select>
								</div>
								<a class="btn btn-primary input-group-addon btn-save-search" disabled>Save search</a>
							</div>
							<div class="c-table-table table-responsive-sm">
								<table class="table">
									<thead>
										<tr>
											<th>id</th>
											<th>customer-name</th>
											<th>email</th>
											<th>country</th>
											<th>whats-app</th>
											<th>message</th>
											<th>operate</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
							<div id="table-pagination"></div>
						</div>
					</div>
				</div>
				<!-- edit or create -->
				<div class="c-view hide view-order">
					<div class="c-option">
						<span class="c-option-title">View Order</span>
						<div class="group">
							<button class="btn btn-secondary btn-back">Back</button>
						</div>
					</div>
					<div class="c-form row">
						<!-- left panel -->
						<div class="left-panel col-lg-8 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Order Info</div>
								</div>
								<div class="card-body">
									<div class="order-list">
										<p>no product for order...</p>
									</div>
									<div class="pay-list">
										<div class="pay-item">
											<div class="pay-item-title">Product Total</div>
											<div class="pay-prototal">
												<div class="name"></div>
												<div class="value">$0.00</div>
											</div>
										</div>
										<div class="pay-item">
											<div class="pay-item-title">Discount</div>
											<div class="pay-discount">
												<div class="name"></div>
												<div class="value">-$0.00</div>
											</div>
										</div>
										<div class="pay-item">
											<div class="pay-item-title">Shipping</div>
											<div class="pay-shipping">
												<div class="name"></div>
												<div class="value">$0.00</div>
											</div>
										</div>
										<div class="pay-item">
											<div class="pay-item-title">Total</div>
											<div class="pay-total">
												<div class="name"></div>
												<div class="value">$0.00</div>
											</div>
										</div>									
									</div>
									<div class="pay-final sum-item">
										<div class="name">Paid by customer</div>
										<div class="value">$0.00</div>
									</div>
									<div class="customer-note">
										<div class="name">Customer Note</div>
										<div class="value" style="color: #f00;">No notes from customer...</div>
									</div>
									<div class="payinfo-group">
										<button class="btn btn-warning hide btn-audit" id="ecpp-verify">Aduited</button>
										<!-- <button class="btn btn-danger hide btn-abandon-purchase">Abandon Purchase</button> -->
										<button class="btn btn-primary hide btn-refund">Refund</button>
										<button class="btn btn-dark hide btn-close">Close</button>
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-6">
									<div class="card">
										<div class="card-title">
											<div class="card-title-name">Shipping Address</div>
										</div>
										<div class="card-body shipping-list">
											<div class="shipping-item firstname">
												<div class="name">First Name</div>
												<div class="value"></div>
											</div>
											<div class="shipping-item lastname">
												<div class="name">Last Name</div>
												<div class="value"></div>
											</div>									
											<div class="shipping-item address">
												<div class="name">Address Details</div>
												<div class="value"></div>
											</div>
											<div class="shipping-item city">
												<div class="name">city</div>
												<div class="value"></div>
											</div>
											<div class="shipping-item province">
												<div class="name">Province/State</div>
												<div class="value"></div>
											</div>
											<div class="shipping-item postcode">
												<div class="name">Post Code</div>
												<div class="value"></div>
											</div>
											<div class="shipping-item country">
												<div class="name">Country</div>
												<div class="value"></div>
											</div>
											<div class="shipping-item phone">
												<div class="name">Phone</div>
												<div class="value"></div>
											</div>
											<div class="shipping-item email">
												<div class="name">E-mail</div>
												<div class="value"></div>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="card">
										<div class="card-title">
											<div class="card-title-name">Billing Address</div>
										</div>
										<div class="card-body billing-list">
											<div class="billing-item paymentid">
												<div class="name">Payment ID</div>
												<div class="value"></div>
											</div>
											<div class="billing-item username">
												<div class="name">User Name</div>
												<div class="value"></div>
											</div>
											<div class="billing-item email">
												<div class="name">E-mail</div>
												<div class="value"></div>
											</div>
											<div class="billing-item country">
												<div class="name">Country Code</div>
												<div class="value"></div>
											</div>
											<div class="billing-item province">
												<div class="name">Province/State</div>
												<div class="value"></div>
											</div>
											<div class="billing-item city">
												<div class="name">city</div>
												<div class="value"></div>
											</div>
											<div class="billing-item postcode">
												<div class="name">Post Code</div>
												<div class="value"></div>
											</div>
											<div class="billing-item line1">
												<div class="name">line 1</div>
												<div class="value"></div>
											</div>
											<div class="billing-item line2">
												<div class="name">line 2</div>
												<div class="value"></div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- right panel -->
						<div class="right-panel col-lg-4 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">
										<span>Tracking</span>
										<button class="btn btn-info hide" id="btn-manual-delivery">manual delivery</button>
									</div>
								</div>
								<div class="card-body">
									<div class="track-number track-item">
										<div class="name">Tracking Number</div>
										<div class="value"></div>
									</div>
									<div class="ecpp-number track-item">
										<div class="name">ECPP Number</div>
										<div class="value"></div>
									</div>
								</div>
							</div>
							
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Pay Info</div>
								</div>
								<div class="card-body">
									<div class="pay-status sum-item">
										<div class="name">Pay Status</div>
										<div class="value">Unpaid</div>
									</div>
									<div class="pay-number sum-item">
										<div class="name">Pay Number</div>
										<div class="value">MLxxxxxxx</div>
									</div>
									<div class="pay-method sum-item">
										<div class="name">Pay Method</div>
										<div class="value">Other</div>
									</div>
									<div class="pay-paypal-id pay-paypal sum-item">
										<div class="name"><span class="pay-pay-method">...</span> ID</div>
										<div class="value"></div>
									</div>
									<div class="pay-paypal-status pay-paypal sum-item">
										<div class="name"><span class="pay-pay-method">...</span> Status</div>
										<div class="value"></div>
									</div>
									<div class="pay-paypal-number pay-paypal sum-item">
										<div class="name"><span class="pay-pay-method">...</span> number</div>
										<div class="value"></div>
									</div>
									<div class="pay-purchase-time sum-item">
										<div class="name">Purchase Time</div>
										<div class="value"></div>
									</div>
									<div class="pay-create-time sum-item">
										<div class="name">Pay Create Time</div>
										<div class="value"></div>
									</div>
									<div class="pay-end-time sum-item">
										<div class="name">Pay End Time</div>
										<div class="value"></div>
									</div>									
								</div>	
							</div>
							
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Customer Info</div>
								</div>
								<div class="card-body customer-info">Non-registered user!</div>
							</div>
						</div>
					</div>
				</div>
				<!-- mask -->
				<div class="c-mask">
					<div class="spinner-border"></div>
				</div>
			</div>
		</div>
		<jsp:include page="../layout/backfooter.jsp" flush="true"></jsp:include>
	</div>
	<jsp:include page="../common/backfooter.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/deleteModal.jsp" flush="true"></jsp:include>
	
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/moment.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.js"></script>
	<!-- custom script -->
	<script>
		var hasSuperCateList = false;
		var isCreate = false, oldTime = (new Date()).getTime(), timer = null, storageName = "whole-sale";
		// init
		var date = new Date();
		var ymd = date.getFullYear() + '-' + (date.getMonth() + 1 > 9 ? date.getMonth() + 1 : '0' + (date.getMonth() + 1)) + '-' + (date.getDate() > 9 ? date.getDate() : '0' + date.getDate());
		$('#order-create-time').val(ymd + ' 00:00:00');
		$('#order-confirm-time').val(ymd + ' 23:59:59');
		bindDateRangeEvent(function(startTime, endTime, self) {
			$('#order-create-time').val(startTime);
			$('#order-confirm-time').val(endTime);		
		});
		renderTabItems();
		if (!hasSuperCateList) getSuperCategoryData(renderSuperCategory);
	 	$('#searchSupercate').val($('#searchSupercate').data('val') || -1);
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getTabSearchData($('.c-table-tab-item.active'));
		});
		// create order
		$('.btn-create').on('click', function () {
			$('.c-view c-option-title').text('Create Order');
			showViewBlock();
			getOrderId();
			isCreate = true;
		});
		$('.btn-back').on('click', function () {
			$('.c-view c-option-title').text('Order List');
			showInitBlock();
		});
		// View  Order
		$(document.body).on('click', '.btn-view, .c-table-table tbody tr', function (e) {
			var wholesaleId = parseInt($(this).data('id') || $(this).find('.btn-view').data('id'));
			getOneOrderData({
				wholesaleId: wholesaleId
			}, function(resData) {
				$('.c-view c-option-title').text('View Whole-sale');
				renderOrderDetails(resData);
				showViewBlock();
			});
		});
		// tab-item click
		$(document.body).on('click', '.c-table-tab-item', function (e) {
			$('.c-table-tab-item').removeClass('active');
			$(this).addClass('active');
			// inital pagination num
			setPageNum(1);
			setActiveItemNum($(this).data('idx'));
			getTabSearchData($(this));
		});
		// tab delete
		$(document.body).on('click', '.delete-table-tab-item', deleteTableTabItem);
		// save search
		/* $('.btn-save-search').on('click', function () {
			var searchOrderVal = {
				supercateName: $('#searchSupercate').find('option:selected').text(),
				supercateId: $('#searchSupercate').val(),
				customername: $('#customer-name').val()
			};
			// cancel repeat add save-search
			if (checkNewItem(searchOrderVal)) return;
			if (parseInt(searchOrderVal.supercateId) < 0) searchOrderVal.supercateName = "";
			if (searchOrderVal.supercateId || searchOrderVal.customername) {
				addStorageItem(searchOrderVal);
				$('.c-table-tab-tempory').html('');
				createTableTabItem(searchOrderVal);
				addTableTabItem(searchOrderVal, $('.c-table-tab-item').length);
			}
		}); */
		// search it
		$('#searchSupercate').on('change', function() {
			$(this).attr('data-val', $(this).val());
			updateSearchData();
		});
		$('#customer-name').on('keyup', function() {
			var distanceTime = 1000,
				newTime =  (new Date()).getTime();
			if (newTime - oldTime < 1000) clearTimeout(timer);
			oldTime = newTime;
			timer = setTimeout(function() {
				updateSearchData();
			}, distanceTime);
		});
		// search status change
		function updateSearchData() {
			var searchOrderVal = {
				supercateName: $('#searchSupercate').find('option:selected').text(),
				supercateId: $('#searchSupercate').val(),
				customername: $('#customer-name').val()
			};
			// inital pagination num
			setPageNum(1);
			// check searchOrder
			if (parseInt(searchOrderVal.supercateId) < 0) searchOrderVal.supercateName = "";

			$('.c-table-tab-item.active').removeClass('active');
			$('.c-table-tab-tempory').html(createTableTabItem(searchOrderVal).addClass('active'));
			getTabSearchData($('.c-table-tab-tempory .c-table-tab-item'));
		}
		// tab view/init
		function showViewBlock() {
			$('.c-init').addClass('hide');
			$('.c-view').removeClass('hide');
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-view').addClass('hide');
		}
		// get Data for table
		function getTabSearchData($this) {
			var dataVal = $this.data('val');
			if (dataVal && (dataVal.supercateName || dataVal.customername)) {
				$('#customer-name').val(dataVal.customername || '');
				$('#searchSupercate').attr('data-val', dataVal.supercateId || '-1');
				$('#searchSupercate').val(dataVal.supercateId || '-1');
				getSearchOrdersData();
			} else {
				$('#customer-name').val('');
				$('#searchSupercate').val('999');
				initActiveItemNum();
				getOrdersData();
			}
		}
		
		function renderOrderDetails(data) {
			// order list
			
		}
		// callback order list
		function renderOrderList(data) {
			var htmlStr = '';
			function genSkus(item) {
				var skuHtml = '';
				var optionNameArr = item.orderitemPskuIdnamestr.split(',');
				var optionValueArr = item.orderitemPskuName.split(',');
				optionNameArr.forEach(function(item, idx) {
					skuHtml += '<div class="order-poption-item">' +
							'<div class="name">'+ item +': </div>' +
							'<div class="value">'+ optionValueArr[idx] +'</div>' +
						'</div>';
				});
				return skuHtml;
			}
			data.forEach(function(item, idx) {
				var singlePrice = accuracyCal(parseFloat(item.orderitemProductOriginalprice) + parseFloat(item.orderitemPskuMoneystr), parseFloat(item.orderitemProductAccoff));
				htmlStr += '<div class="order-item">' +
						'<img src="'+ item.orderitemProductMainimgurl +'">' +
						'<div class="order-product-base">' +
							'<a class="order-product-link" href="${APP_PATH}/'+ item.orderitemPseo +'.html">'+ item.orderitemPname +'</a>' +
							'<div class="order-product-option">'+ genSkus(item) +'</div>' +
							'<div class="order-product-sku">SKU: '+ item.orderitemPskuCode +'</div>' +
						'</div>' +
						'<div class="order-product-cal">' +
							'<div class="order-product-money">$'+ singlePrice +'</div>' +
							'<div class="order-product-divider">x</div>' +
							'<div class="order-product-num">'+ item.orderitemPskuNumber +'</div>' +
							'<div class="order-product-total">$'+ (item.orderitemPskuNumber * parseFloat(singlePrice)).toFixed(2) +'</div>' +
						'</div>' +
					'</div>';
			});
			$('.order-list').html(htmlStr || 'no product for order...');
		}
		//  callback get all
		function getOrdersData(val) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/CustomerWholesale/getCustomerWholesaleByPage",
				type: "post",
				data: "pn=" + getPageNum(),
				success: function (data) {
					if (data.code == 100) {
						renderTable(data.extend.pageInfo.list);
						renderTablePagination(data.extend.pageInfo);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('Failed to get Whole-sales, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get search data
		function getSearchOrdersData(data) {
			$('.c-mask').show();

			var formData = new FormData();
			formData.append('customer-name', $('#customer-name').val());
			formData.append('supercateId', ($('#searchSupercate').attr('data-val') || '999'));
			formData.append('pn', getPageNum());

			$.ajax({
				url: "${APP_PATH}/MlfrontPayInfo/selectHighPayInfoListBySearch",
				type: "post",
				data: formData,
				processData: false,
				contentType: false,
				cache: false,
				success: function (data) {
					if (data.code == 100) {
						renderTable(data.extend.pageInfo.list);
						renderTablePagination(data.extend.pageInfo);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function () {
					toastr.error('Failed to get Orders, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get one order data
		function getOneOrderData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/CustomerWholesale/getOneMlbackCatalogDetail",
				type: "post",
				data: JSON.stringify(reqData),
				dataType: "json",
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('Failed to get Super-Categeory, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<tr><td>' + data[i].wholesaleId + '</td>' +
					'<td>' + data[i].wholesaleCustomerName + '</td>' +
					'<td>' + data[i].wholesaleCustomerEmail + '</td>' +
					'<td>' + data[i].wholesaleCustomerCountry + '</td>' +
					'<td>' + data[i].wholesaleCustomerWatsapp + '</td>' +
					'<td>' + data[i].wholesaleCustomerMessage + '</td>' +
					'<td>' +
						'<button class="btn btn-primary btn-view" data-id="' + data[i].wholesaleId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-eye"></use>' +
							'</svg>' +
						'</button>' +
						'<button class="btn btn-danger btn-delete" data-id="' + data[i].wholesaleId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
	</script>
</body>

</html>