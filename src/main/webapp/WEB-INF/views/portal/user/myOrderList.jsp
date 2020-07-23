<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>My Order List</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
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
			<div class="usercenter-back"><a href="javascript:goToUserCenter();"><span class="icon left"></span>Back</a></div>
			<div class="usercenter-order-box">
				<div class="order-tab">
					<div class="order-tab-item active" data-id="999">All orders</div>
					<div class="order-tab-item" data-id="1">Paid</div>
					<div class="order-tab-item" data-id="3">Processing</div>
					<div class="order-tab-item" data-id="4">Delivered</div>
					<div class="order-tab-item" data-id="5">Refund</div>
				</div>
				<div class="user-order-list"></div>
				<div id="table-pagination" class="hide"></div>
				<div class="loader-box">
					<div class="loader"></div>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		function getOrderList() {
			$.ajax({
				url: "${APP_PATH }/MlfrontOrderList/selectOrderlistBySearch",
				data: {
					orderStatus: orderStatus,
					pn: getPageNum()
				},
				type: "post",
				async: false,
				success: function (data) {
					if(data.code == 100) {
						rednerOrderList(data.extend.pageInfo.list, data.extend.mlfrontOrderItemReturnList, data.extend.sizeList);
						renderTablePagination(data.extend.pageInfo);
						$('.loader-box').hide();
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
		function orderMap(data) {
			var orderMap = {};
			var orderItemMap = {}
			for (var i = 0, len = data.length; i < len; i += 1) {
				if (orderMap[data[i].orderId]) {
					orderMap[data[i].orderId].push(data[i].orderitemId);
				} else {
					orderMap[data[i].orderId] = [data[i].orderitemId]
				}
				orderItemMap[data[i].orderitemId] = data[i];
			}
			return {
				orderMap: orderMap,
				orderItemMap: orderItemMap
			}
		}
		function rednerOrderList(orderList, orderItemList, orderItemSize) {
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
			var map = orderMap(orderItemList);
			var htmlStr = '';
			if (orderList.length) {
				for (var key in orderList) {
					htmlStr += '<div class="user-order-item" data-id="' + orderList[key].orderId + '">' +
						'<div class="user-orderitem-title">' +
							'<div class="user-order-id">order Id: ' + orderList[key].orderId + '</div>' +
							'<div class="user-order-status">' + (statusMap[orderList[key].orderStatus]) + '</div>' +
						'</div>' +
						'<div class="user-orderitem-body">';
					for (var i = 0; i < orderItemSize[key]; i+=1) {
						var item = map.orderItemMap[map.orderMap[orderList[key].orderId][i]];
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
						'<div class="user-orderitem-footer">Total ' + orderItemSize[key] + ' goods, money $ ' + orderList[key].orderMoney + '</div>' +
					'</div>';
				}

				$userOrderList.html(htmlStr);
				new LazyLoad($userOrderList.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
				$tablePagination.removeClass('hide');
			} else {
				$userOrderList.html('<p class="user-order-empty">No orders...</p>');
				!$tablePagination.hasClass('hide') && $tablePagination.addClass('hide');
			}
		}
		var $userOrderList = $('.user-order-list'),
			$tablePagination = $('#table-pagination'),
			orderStatus = 999,
			statusMap = {
				1: 'Paid',
				3: 'Processing',
				4: 'Delviered',
				5:'refund'
			},
			loginStatus = checkUserLoginOrNot();
		
		!loginStatus && loginNotTip();
		loginStatus && getOrderList();
		// tab-order-item tab
		$('.order-tab-item').on('click', function() {
			if (!$(this).hasClass('active')) {
				$(this).addClass('active').siblings().removeClass('active');
				orderStatus = $(this).data('id');
				getOrderList();
			}
		});
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getOrderList();
		});
		$(document.body).on('click', '.user-order-item', function() {
			var orderId = $(this).data('id');
			orderId && (window.location.href = '${APP_PATH}/MlfrontUser/tomyOrderDetailPage?orderId=' + orderId);
		});
	</script>
</body>
</html>