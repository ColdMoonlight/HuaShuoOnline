<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Order List</title>
	<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
</head>
<body class="c-app">
	<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
	<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
	<div class="c-wrapper">
		<div class="c-body">
			<div class="c-main">
				<div class="c-init">
					<div class="c-option">
						<span class="c-option-title">Order list</span>
						<!-- <button class="btn btn-primary btn-create">Create Order</button> -->
					</div>
					<div class="c-table">
						<div class="c-table-tab">
							<div class="c-table-tab-item" data-idx="0">All</div>
							<div class="c-table-tab-list"></div>
							<div class="c-table-tab-tempory"></div>
						</div>
						<div class="c-table-content">
							<table class="c-table-table table table-responsive-sm">
								<thead>
									<tr>
										<th>id</th>
										<th>payinfoOid</th>
										<th>price</th>
										<th>pay-status</th>
										<th>date</th>
										<th>plate-num</th>
										<th>customer-name</th>
										<!-- <th>customer-email</th> -->
										<th>paypal-num</th>
										<th>paypal-status</th>
										<th>ecpp-num</th>
										<th>tracking-num</th>
										<th>operate</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
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
						<div class="left-panel col-lg-7 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Order Info</div>
								</div>
								<div class="card-body">
									<div class="order-list">
										<p>no product for order...</p>
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
									<div class="pay-paypal-id sum-item">
										<div class="name">Paypal ID</div>
										<div class="value"></div>
									</div>
									<div class="pay-paypal-status sum-item">
										<div class="name">Paypal Status</div>
										<div class="value"></div>
									</div>
									<div class="pay-paypal-number sum-item">
										<div class="name">Paypal number</div>
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
									<div class="pay-list">
										<div class="pay-item">
											<div class="pay-item-title">Product Total</div>
											<div class="pay-prototal">
												<div class="name"></div>
												<div class="value">$0.00</div>
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
											<div class="pay-item-title">Discount</div>
											<div class="pay-discount">
												<div class="name"></div>
												<div class="value">-$0.00</div>
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
								</div>	
							</div>
						</div>
						<!-- right panel -->
						<div class="right-panel col-lg-5 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Customer Note</div>
								</div>
								<div class="card-body">
									<div class="customer-note">No notes from customer</div>
								</div>
							</div>
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Tracking</div>
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
									<div class="shipping-item email">
										<div class="name">E-mail</div>
										<div class="value"></div>
									</div>
									<div class="shipping-item phone">
										<div class="name">Phone</div>
										<div class="value"></div>
									</div>
									<div class="shipping-item country">
										<div class="name">Country</div>
										<div class="value"></div>
									</div>
									<div class="shipping-item province">
										<div class="name">Province/State</div>
										<div class="value"></div>
									</div>
									<div class="shipping-item city">
										<div class="name">city</div>
										<div class="value"></div>
									</div>
									<div class="shipping-item postcode">
										<div class="name">Post Code</div>
										<div class="value"></div>
									</div>									
									<div class="shipping-item address">
										<div class="name">Address Details</div>
										<div class="value"></div>
									</div>
								</div>
							</div>
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
	
	<!-- custom script -->
	<script>
		var isCreate = false;
		// init
		getOrdersData();
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getOrdersData();
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
		$(document.body).on('click', '.btn-view', function (e) {
			var payinfoId = parseInt($(this).data('id'));
			getOneOrderData({
				payinfoId: payinfoId
			}, function(resData) {
				$('.c-view c-option-title').text('View Order');
				renderOrderDetails(resData);
				showViewBlock();
			});
		});
		// tab view/init
		function showViewBlock() {
			$('.c-init').addClass('hide');
			$('.c-view').removeClass('hide');
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-view').addClass('hide');
		}
		// callback init order details
		function renderOrderDetails(data) {
			// order list
			renderOrderList(data.mlfrontOrderItemList);
			// sum info
			$('.pay-status .value').html(getPayStatus(data.mlfrontPayInfoOne.payinfoStatus));
			data.mlfrontPayInfoOne.payinfoPlatenum && $('.pay-number .value').html(data.mlfrontPayInfoOne.payinfoPlatenum);
			$('.pay-method .value').html(data.mlfrontPayInfoOne.payinfoPlatform);
			data.mlfrontPayInfoOne.payinfoTransidnum && $('.pay-paypal-id .value').html(data.mlfrontPayInfoOne.payinfoTransidnum);
			data.mlfrontPayInfoOne.payinfoTransStatus && $('.pay-paypal-status .value').html(data.mlfrontPayInfoOne.payinfoTransStatus);
			data.mlfrontPayInfoOne.payinfoPlatformserialcode && $('.pay-paypal-number .value').html(data.mlfrontPayInfoOne.payinfoPlatformserialcode);
			data.mlfrontOrderPayOneRes.orderCreatetime && $('.pay-purchase-time .value').html(data.mlfrontOrderPayOneRes.orderCreatetime);
			data.mlfrontPayInfoOne.payinfoCreatetime && $('.pay-create-time .value').html(data.mlfrontPayInfoOne.payinfoCreatetime);
			data.mlfrontPayInfoOne.payinfoMotifytime && $('.pay-end-time .value').html(data.mlfrontPayInfoOne.payinfoMotifytime);
			

			$('.pay-prototal .value').html('$' + (data.mlfrontPayInfoOne.payinfoMoney + (data.mlfrontOrderPayOneRes.orderCouponPrice || 0) - data.areafreightMoney));
			$('.pay-discount .name').html(data.mlfrontOrderPayOneRes.orderCouponCode);
			data.mlfrontOrderPayOneRes.orderCouponCode && data.mlfrontOrderPayOneRes.orderCouponPrice && $('.pay-discount .value').html('-$' + (data.mlfrontOrderPayOneRes.orderCouponPrice).toFixed(2));
			data.areafreightMoney && $('.pay-shipping .value').html('$' + (data.areafreightMoney).toFixed(2));
			data.mlfrontPayInfoOne.payinfoMoney && $('.pay-total .value').html('$' + data.mlfrontPayInfoOne.payinfoMoney);
			data.mlfrontPayInfoOne.payinfoMoney && $('.pay-final .value').html('$' + data.mlfrontPayInfoOne.payinfoMoney);
			
			// customer note
			data.mlfrontOrderPayOneRes.orderBuyMess && $('.customer-note').html(data.mlfrontOrderPayOneRes.orderBuyMess);
			// track
			data.mlfrontPayInfoOne.payinfoSendnum && $('.track-number').html(data.mlfrontPayInfoOne.payinfoSendnum);
			data.mlfrontPayInfoOne.payinfoEcpphsnum && $('.ecpp-number').html(data.mlfrontPayInfoOne.payinfoEcpphsnum);
			// shipping
			data.mlfrontAddressOne.addressUserfirstname && $('.shipping-item.firstname .value').html(data.mlfrontAddressOne.addressUserfirstname);
			data.mlfrontAddressOne.addressUserlastname && $('.shipping-item.lastname .value').html(data.mlfrontAddressOne.addressUserlastname);
			data.mlfrontAddressOne.addressEmail && $('.shipping-item.email .value').html(data.mlfrontAddressOne.addressEmail);
			data.mlfrontAddressOne.addressTelephone && $('.shipping-item.phone .value').html(data.mlfrontAddressOne.addressTelephone);
			data.mlfrontAddressOne.addressCountry && $('.shipping-item.country .value').html(data.mlfrontAddressOne.addressCountry + ' ('+ data.mlfrontAddressOne.addressCountryCode +')');
			data.mlfrontAddressOne.addressProvince && $('.shipping-item.province .value').html(data.mlfrontAddressOne.addressProvince + ' ('+ data.mlfrontAddressOne.addressProvincecode +')');
			data.mlfrontAddressOne.addressCity && $('.shipping-item.city .value').html(data.mlfrontAddressOne.addressCity);
			data.mlfrontAddressOne.addressPost && $('.shipping-item.postcode .value').html(data.mlfrontAddressOne.addressPost);
			data.mlfrontAddressOne.addressDetail && $('.shipping-item.address .value').html(data.mlfrontAddressOne.addressDetail);
			// billing
			data.mlPaypalShipAddressOne.shippingaddressPaymentid && $('.billing-item.paymentid .value').html(data.mlPaypalShipAddressOne.shippingaddressPaymentid);
			data.mlPaypalShipAddressOne.shippingaddressRecipientName && $('.billing-item.username .value').html(data.mlPaypalShipAddressOne.shippingaddressRecipientName);
			data.mlPaypalShipAddressOne.shippingaddressEmail && $('.billing-item.email .value').html(data.mlPaypalShipAddressOne.shippingaddressEmail);
			data.mlPaypalShipAddressOne.shippingaddressCountryCode && $('.billing-item.country .value').html(data.mlPaypalShipAddressOne.shippingaddressCountryCode);
			data.mlPaypalShipAddressOne.shippingaddressCity && $('.billing-item.city .value').html(data.mlPaypalShipAddressOne.shippingaddressCity);
			data.mlPaypalShipAddressOne.shippingaddressState && $('.billing-item.province .value').html(data.mlPaypalShipAddressOne.shippingaddressState);
			data.mlPaypalShipAddressOne.shippingaddressPostalCode && $('.billing-item.postcode .value').html(data.mlPaypalShipAddressOne.shippingaddressPostalCode);
			data.mlPaypalShipAddressOne.shippingaddressLine1 && $('.billing-item.line1 .value').html(data.mlPaypalShipAddressOne.shippingaddressLine1);
			data.mlPaypalShipAddressOne.shippingaddressLine2 && $('.billing-item.line2 .value').html(data.mlPaypalShipAddressOne.shippingaddressLine2);
		}
		// callback order list
		function renderOrderList(data) {
			var htmlStr = '';
			function genSkus(item) {
				var skuHtml = '';
				var optionNameArr = item.orderitemPskuIdnamestr.split(',');
				var optionValueArr = item.orderitemPskuName.split(',');
				optionNameArr.forEach(function(item, idx) {
					skuHtml = '<div class="order-poption-item">' +
							'<div class="name">'+ item +': </div>' +
							'<div class="value">'+ optionValueArr[idx] +'</div>' +
						'</div>';
				});
				return skuHtml;
			}
			data.forEach(function(item, idx) {
				var singlePrice = ((parseFloat(item.orderitemProductOriginalprice) + parseFloat(item.orderitemPskuMoneystr)) * (parseFloat(item.orderitemProductAccoff) / 100))
				htmlStr += '<div class="order-item">' +
						'<img src="'+ item.orderitemProductMainimgurl +'">' +
						'<div class="order-product-base">' +
							'<a class="order-product-link" href="${APP_PATH}/'+ item.orderitemPseo +'.html">'+ item.orderitemPname +'</a>' +
							'<div class="order-product-option">'+ genSkus(item) +'</div>' +
							'<div class="order-product-sku">SKU: '+ item.orderitemPskuCode +'</div>' +
						'</div>' +
						'<div class="order-product-cal">' +
							'<div class="order-product-money">$'+ singlePrice.toFixed(2) +'</div>' +
							'<div class="order-product-divider">x</div>' +
							'<div class="order-product-num">'+ item.orderitemPskuNumber +'</div>' +
							'<div class="order-product-total">$'+ (item.orderitemPskuNumber * singlePrice).toFixed(2) +'</div>' +
						'</div>' +
					'</div>';
			});
			$('.order-list').html(htmlStr);
		}
		//  callback get all
		function getOrdersData(val) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlfrontPayInfo/getMlfrontPayInfoByPage",
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
					toastr.error('Failed to get Super-Categeory, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		
		function getOneOrderData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlfrontPayInfo/backGetOnePayInfoDetail",
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
		function getPayStatus(num) {
			var statusText;
			switch(num) {
				case 0:
					statusText = '<a class="badge badge-danger">uppaid</a>'; // 未支付 red
				    break;
				case 1:
					statusText = '<a class="badge badge-warning">paid</a>'; // 已支付  yellow
					break;
				case 2:
					statusText = '<a class="badge badge-success">audited</a>'; // 已审核  green
					break;
				case 3:
					statusText = '<a class="badge badge-secondary">delivered</a>'; // 已发货  blue
				    break;
				case 4:
					statusText = '<a class="badge badge-info">refunded</a>'; // 已退款  purple
					break;
				case 5:
					statusText = '<a class="badge badge-light">re-purchase notified</a>'; // 已通知复购  light
					break;
				case 6:
					statusText = '<a class="badge badge-dark">closed</a>'; // 已关闭  dark
					break;
				default:
					statusText = '<a class="badge badge-danger">uppaid</a>'; // 未支付 red
			}
			return statusText;
		}
		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<tr><td>' + data[i].payinfoId + '</td>' +
					'<td>' + (data[i].payinfoOid || '') + '</td>' +
					'<td>' + data[i].payinfoMoney + '</td>' +
					'<td>' + getPayStatus(data[i].payinfoStatus) + '</td>' +
					'<td>' + data[i].payinfoCreatetime + '</td>' +
					'<td>' + (data[i].payinfoPlatenum || '') + '</td>' +
					'<td>' + (data[i].payinfoUname || '') + '</td>' +
					/* '<td>' + (data[i].payinfoUemail || '') + '</td>' + */
					'<td>' + (data[i].payinfoTransidnum || '') + '</td>' +
					'<td>' + (data[i].payinfoTransStatus || '') + '</td>' +
					'<td>' + (data[i].payinfoEcpphsnum || '') + '</td>' +
					'<td>' + (data[i].payinfoSendnum || '') + '</td>' +
					'<td>' +
						'<button class="btn btn-primary btn-view" data-id="' + data[i].payinfoId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
							'</svg>' +
						'</button>' +
						/* '<button class="btn btn-danger btn-delete" data-id="' + data[i].payinfoId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' + */
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
	</script>
</body>

</html>