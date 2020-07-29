<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>My Order Details</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/ad.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 575px) {
			main { margin: -1rem 0 0 0; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="usercenter-back"><a href="javascript:goToUserCenerOrder();"><span class="icon left"></span>Back</a></div>

			<div class="usercenter-order-details">
				<div class="user-order-address"></div>
				<div class="user-order-order"></div>
				<div class="user-order-time"></div>
			</div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		function getOrderList(orderId) {
			$.ajax({
				url: "${APP_PATH}/MlfrontOrder/getOneMlfrontOrderDetail",
				data: JSON.stringify({ orderId: orderId }),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if(data.code == 100) {
						shippingMoney = data.extend.areafreightMoney;
						renderOrderAddress(data.extend.addressInfo);
						renderOrderOrder(data.extend.mlfrontOrderOne, data.extend.mlfrontOrderItemList);
						renderOrderTime(data.extend.mlfrontOrderOne);
					} else {
						sysModalTip();
						setTimeout(goToUserCenter, 2000);
					}
				},
				error: function(err) {
					sysModalTip();
					setTimeout(goToUserCenter, 2000);
				}
			})
		}
		function renderOrderAddress(data) {
			var html = '';
			html += '<span class="icon address"></span>' +
					'<div class="order-address-data">' +
						'<div class="order-address-info">' +
							'<div class="order-address-username">Consignee: ' + (data.addressUserlastname + ' ' + data.addressUserfirstname) + '</div>' +
							'<div class="order-address-phone">Phone: ' + data.addressTelephone + '</div>' +
						'</div>' +
						'<div class="order-address-address">' +
							'<div class="name">Address: </div>' +
							'<div class="value">' + data.addressDetail + ' ' + data.addressCity + ' ' + data.addressProvince + ' ' + data.addressCountry + '</div>' +
						'</div>' +
					'</div>' +
				'</div>';
			$('.user-order-address').html(html);
		}
		function renderOrderOrder(orderData, orderItemList) {
			function generateSkus(item) {
				var html = '';
				var optionName = item.orderitemPskuIdnamestr.split(',');
				var optionValue = item.orderitemPskuName.split(',');
				optionName.forEach(function(name, idx) {
					html += '<div class="user-orderitem-skuitem">' +
							'<div class="name">'+ name +':&nbsp;</div>' +
							'<div class="value">'+ optionValue[idx] +'</div>' +
						'</div>';
				});
				return html;
			}
			var htmlStr = '';
			if (orderData) {
				htmlStr += '<div class="user-order-item" data-id="' + orderData.orderId + '">' +
					'<div class="user-orderitem-title">' +
						'<div class="user-order-id">order Id: ' + orderData.orderId + '</div>' +
					'</div>' +
					'<div class="user-orderitem-body">';
				var len = orderItemList.length;
				for (var i = 0, len; i < len; i+=1) {
					var item = orderItemList[i];
					var itemLink = item.orderitemPseo ? ('${APP_PATH}/'+ item.orderitemPseo + '.html') : 'javascript:;';
					htmlStr += '<div class="user-orderitem-item">' +
							'<div class="lazyload" data-src="' + item.orderitemProductMainimgurl + '"></div>' +
							'<div class="user-orderitem-text">' +
								'<a class="user-orderitem-name" href="'+ itemLink +'">' + item.orderitemPname + '</a>' +
								'<div class="user-orderitem-sku">' + generateSkus(item) + '</div>' +
							'</div>' +
							'<div class="user-orderitem-data">' +
								'<div class="user-orderitem-price">$' + (item.orderitemPskuReamoney / item.orderitemPskuNumber).toFixed(2) + '</div>' +
								'<div class="user-orderitem-num">X' + item.orderitemPskuNumber + '</div>' +
							'</div>' +
						'</div>';
				}
				htmlStr += '</div>' +
					'<div class="user-orderitem-footer">' +
						'<div class="user-orderitem-cal">' +
							'<span class="name">Total Amount: </span>' +
							'<span class="value">$' + (orderData.orderMoney + orderData.orderCouponPrice - shippingMoney).toFixed(2) + '<span>' +
						'</div>' +
						'<div class="user-orderitem-cal">' +
							'<span class="name">Coupon: </span>' +
							'<span class="value">-$' + (orderData.orderCouponPrice).toFixed(2) + '<span>' +
						'</div>' +
						'<div class="user-orderitem-cal">' +
							'<span class="name">shipping: </span>' +
							'<span class="value">$' + shippingMoney.toFixed(2) + '<span>' +
						'</div>' +
						'<div class="user-orderitem-cal">' +
							'<span class="name">Actual payment: </span>' +
							'<span class="value">$' + (orderData.orderMoney).toFixed(2) + '<span>' +
						'</div>' +
					'</div>' +
				'</div>';

				$('.user-order-order').html(htmlStr);
				new LazyLoad($('.user-order-order').find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			} else {
				$('.user-order-order').html('<p class="user-order-empty">No order Info...</p>');
			}
		}
		function renderOrderTime(data) {
			var html = '';
			data && (html = '<div class="user-order-time-title">Order Time</div>' +
				'<div class="user-order-time-body">' +
					'<div class="user-order-time-item">' +
						'<span class="name">Payment Method:</span>' +
						'<span class="value">' + (data.orderPayPlate ? 'paypal card' : 'paypal') + '<span>' +
					'</div>' +
					'<div class="user-order-time-item">' +
						'<span class="name">Create Time:</span>' +
						'<span class="value">' + data.orderCreatetime + '<span>' +
					'</div>' +
					'<div class="user-order-time-item">' +
						'<span class="name">Pay End Time:</span>' +
						'<span class="value">' +  data.orderMotifytime + '<span>' +
					'</div>' +
				'</div>'
				);
			$('.user-order-time').html(html);
		}
		var  orderId= window.location.href.split('?')[1].split('=')[1],
			shippingMoney = 0,
			loginStatus = checkUserLoginOrNot();
		
		!loginStatus && loginNotTip();
		loginStatus && getOrderList(orderId);
	</script>
</body>
</html>