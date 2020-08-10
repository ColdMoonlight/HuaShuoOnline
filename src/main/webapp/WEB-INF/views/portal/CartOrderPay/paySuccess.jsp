<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>Payment Success</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style> main { margin: 0; } </style>
</head>

<body>
	<jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="container">
			<div class="payment-header"></div>
			<div class="payment-box payment-order">
				<div class="payment-box-title">
					<span class="icon cart"></span>
					<span class="value">Show order summary</span>
					<span class="icon arrow bottom"></span>
					<span class="total-money"></span>
				</div>
				<div class="payment-box-body active">
					<div class="payment-product"></div>
					<div class="payment-cal"></div>
				</div>
			</div>
			<div class="payment-box payment-buyer">
				<div class="payment-box-title">
					<span class="icon wallet"></span>
					<div class="revceiver-info"></div>
				</div>
				<div class="payment-box-body">
					<div class="payment-address payment-shipping-address"></div>
					<div class="payment-address payment-billing-address"></div>
				</div>
			</div>
			<p class="payment-tip">If there's any questions, plz contact the customer service </p>
			<div class="payment-btn">
				<a href="javascript:goToIndex();" class="btn btn-black">Continue Shopping</a>
			</div>
		</div>
	<!-- main end -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script type="text/javascript">
		function getPayInfo(reqData, callback) {
			$.ajax({
				url: "${APP_PATH}/MlfrontPayInfo/successPageGetPaymentInfo",
				data: JSON.stringify(reqData),
				dataType: 'json',
				contentType: 'application/json',
				type: "post",
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend);
					} else {
						refreshPageModal();
					}
				},
				error: function(err) {
					sysModalTip();
				}
			});
		}

		function renerPaymentInfo(data) {
			$('.payment-order .total-money').html('$' + data.payinfoMoney);

			var paymentProductHtml = '';
			data.list.forEach(function (item, idx) {
				var productLink = item.orderitemPseo ? ('${APP_PATH}/' + item.orderitemPseo + '.html') : 'javascript:;';
				payinfoProductArr.push({
					'id': item.orderitemPid,
					'quantity': item.orderitemPskuNumber,
					'item_price': item.orderitemPskuReamoney
				}); // for facebook
				payinfoOrderArr.push({
					'id': item.orderitemPid,
					'name': item.orderitemPname,
					'quantity': item.orderitemPskuNumber,
					'price': (item.orderitemPskuReamoney / item.orderitemPskuNumber).toFixed(2),
					'brand': 'MLH',
					'list_name': 'Search Results'
				}); // for google
				paymentProductHtml += '<div class="payment-product-item">' +
						'<a href="' + productLink + '"><img class="order-img" src="' + item.orderitemProductMainimgurl + '"></a>' +
						'<div class="payment-product-details">' +
							'<a class="payment-product-name" href="' + productLink + '">' + item.orderitemPname + '</a>' +
							'<div class="payment-sku-list">' + item.orderitemPskuName + '</div>' +
						'</div>' +
						'<div class="payment-product-num">' +
							'<span class="product-num">x' + item.orderitemPskuNumber + '</span>' +
							'<span class="product-price">$' + (item.orderitemProductOriginalprice && item.orderitemProductAccoff ? accuracyCal((item.orderitemProductOriginalprice + parseFloat(item.orderitemPskuMoneystr)), item.orderitemProductAccoff) : 0.00) + '</span>' +
						'</div>' +
					'</div>';
			});
			$('.payment-order .payment-product').html(paymentProductHtml);

			var paymentCalHtml = '';
			paymentCalHtml = '<div class="payment-cal-item">' +
					'<span class="name">prototal: </span>' +
					'<span class="value">$' + (parseFloat(data.payinfoMoney) + parseFloat(data.orderCouponPrice) - data.shipping).toFixed(2) + '</span>' +
				'</div>' +
				'<div class="payment-cal-item">' +
					'<span class="name">shipping: </span>' +
					'<span class="value">$' + (data.shipping).toFixed(2) + '</span>' +
				'</div>' +
				'<div class="payment-cal-item">' +
					'<span class="name">coupon: </span>' +
					'<span class="value">-$' + (data.orderCouponPrice).toFixed(2) + '</span>' +
				'</div>' +
				'<div class="payment-cal-item">' +
					'<span class="name">subtotal: </span>' +
					'<span class="value">$' + (data.payinfoMoney).toFixed(2) + '</span>' +
				'</div>';
			$('.payment-order .payment-cal').html(paymentCalHtml);

		}

		$(".payment-order .payment-box-title").on('click', function () {
			if ($(".payment-order .payment-box-body").hasClass('active')) {
				$(".payment-order .payment-box-body").removeClass('active').slideUp();
				$(".payment-order .icon.arrow").removeClass('bottom').addClass('top');
			} else {
				$(".payment-order .payment-box-body").addClass('active').slideDown();
				$(".payment-order .icon.arrow").removeClass('top').addClass('bottom');
			}
		});

		function renderReceiverinfo(data) {
			$('.revceiver-info').html('<div class="payment-buyer-name"><span class="name">Thank You </span><span class="value">' + data.addressUserfirstname + '</span></div>' +
				'<div class="payment-orderid"><span class="name">Your Order ID: </span><span class="value">' + data.payinfoPlatenum + '</span></div>');

			$(".payment-shipping-address").html('<div class="payment-address-title">Shipping Address</div>' +
				'<div class="payment-address-item"><span class="name">Phone: </span><span class="value">' + data.addressTelephone + '</span></div>' +
				'<div class="payment-address-item"><span class="name">Address: </span><span class="value">' + data.addressCountry + ' ' + data.addressProvince + ' ' + data.addressCity + ' ' + data.addressDetail + '</span></div>' +
				'</div');
		}

		function renderPaypaladdress(data) {
			$(".payment-billing-address").html('<div class="payment-address-title">Billing Address</div>' +
				'<div class="payment-address-item"><span class="name">Postcode: </span><span class="value">' + data.shippingaddressPostalCode + '</span></div>' +
				'<div class="payment-address-item"><span class="name">Address: </span><span class="value">' + data.shippingaddressCountryCode + ' ' + data.shippingaddressCity + ' ' + data.shippingaddressLine1 + '</span></div>' +
				'</div');
		}

		var payinfoId = '${sessionScope.payinfoId}';
		var payinfoProductArr = [], payinfoOrderArr = [];
		
		if (!payinfoId) {
			mlModalTip('Please contact customer service for abnormal orders !');
			$('main').html('');
			setTimeout(goToIndex, 3000);
		}

		getPayInfo({ "payinfoId": payinfoId}, function (data) {
			var resDataPayInfoOne = data.mlfrontPayInfoOne;
			var resDataOrderItemList = data.mlfrontOrderItemList;
			var resDataOrderPayOne = data.mlfrontOrderPayOneRes;
			var resDataAddressOne = data.mlfrontAddressOne;
			var mlPaypalShipAddressOne = data.mlPaypalShipAddressOne;
			if (data.mlfrontPayInfoOne) {
				var orderData = resDataOrderPayOne;
				orderData.shipping = data.areafreightMoney;
				orderData.list = resDataOrderItemList;
				orderData.payinfoMoney = resDataPayInfoOne.payinfoMoney;
	
				resDataAddressOne.payinfoPlatenum = resDataPayInfoOne.payinfoPlatenum;
	
				renerPaymentInfo(orderData);
				renderReceiverinfo(resDataAddressOne);
				renderPaypaladdress(mlPaypalShipAddressOne);

				fbq('track', 'Purchase', {
					'content_ids': payinfoProductArr,
					'content_type': 'product',
					'value': orderData.payinfoMoney,
					'currency': 'USD'
				});

				setTimeout(function() {
					gtag('event', 'purchase', {
						'transaction_id': resDataPayInfoOne.payinfoPlatenum,
						'affiliation': 'MegaLookHair',
						'value': String(orderData.payinfoMoney),
						'currency': 'USD',
						'tax': 0,
						'shipping': 0,
						'items': payinfoOrderArr
					});					
				}, 0);
			}
		});
	</script>
</body>

</html>