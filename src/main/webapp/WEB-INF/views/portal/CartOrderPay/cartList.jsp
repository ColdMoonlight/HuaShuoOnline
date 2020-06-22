<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>Cart List</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>main { margin: 0; }</style>
</head>

<body>
	<jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container"></div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		// ajax fetch cart-list
		function getCartListData(callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackCart/getCartitemIdDetails',
				type: 'post',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlfrontCartItemListRes);
					}
				}
			});
		}
		function renderCartList(data) {
			var $cartHeader = $('<div class="cart-header" />');
			var $cartList = $('<div class="cart-list" />');
			data.forEach(function(item, idx) {
				var cartSkuList = '';
				var optionArr = item.cartitemProductskuIdnamestr.split(',');
				var skuNameArr = item.cartitemProductskuName.split(',');
				optionArr.forEach(function(item, idx) {
					cartSkuList += '<div class="cart-sku-list-item">' +
						'<span class="name">'+ item +' :</span>' +
						'<span class="value">'+ skuNameArr[idx] +'</span>' +
					'</div>';
				});
				$cartList.append($('<div class="cart-item">' +
					'<img class="cart-img" src="'+ item.cartitemProductMainimgurl +'">' +
					'<div class="cart-box">' +
						'<a class="cart-product-name" href="${APP_PATH}/'+ item.cartitemProductSeo + '.html">'+ item.cartitemProductName +'</a>' +
						'<div class="cart-sku-list">'+ cartSkuList +'</div>' +
						'<div class="cart-product-num">' +
							'<div class="cart-product-price">' +
								'<span class="product-now-price">$'+ (item.cartitemProductOriginalprice && item.cartitemProductActoff ? (item.cartitemProductOriginalprice * item.cartitemProductActoff / 100) : 0).toFixed(2) +'</span>' +
								'<span class="product-define-price">$'+ (item.cartitemProductOriginalprice || 0).toFixed(2) +'</span>' +
							'</div>' +
							'<span class="icon delete" onclick="deleteCartItem(event)">' + '</span>' +
							'<div class="product-qty">' +
								'<span class="group-addon" id="product-num-sub"><i class="icon sub"></i></span>' +
								'<input type="text" disabled class="product-num" value="' + (item.cartitemProductNumber) + '" />' +
								'<span class="group-addon" id="product-num-add"><i class="icon plus"></i></span>' +
							'</div>' +
						'</div>' +
					'</div>' +
					'<div class="cart-sku-edit">EDIT</div>' +
				'</div>').data('cartitem', JSON.stringify(item)));
			});
			var $cartCal = $('<div class="cart-cal">' +
				'<div class="cart-cal-item"><span class="name">NUMTOTAL</span><span class="value cart-cal-total">'+ 1+'</span></div>' +
				'<div class="cart-cal-item"><span class="name">SUBTOTAL</span><span class="value cart-cal-subtotal">$'+ 1+'</span></div>' +
				'<div class="cart-cal-btn"><a href="${APP_PATH}/index.html" class="btn btn-gray">Continue Shopping</a><a href="javascript:;" class="btn btn-black btn-checkout">Checkout</a></div>' +
			'</div>');
			$('main .container').append($cartHeader).append($('<div class="cart-body" />').append($cartList).append($cartCal));
		}
		function renderCartEmpty() {
			var htmlStr = '<div class="cart-empty">' +
				'<img src="${APP_PATH}/static/pc/img/cart-empty.png">' +
				'<p>The shopping cart is empty. Come and fill it up!</p>' +
				'<a href="${APP_PATH}/index.html" class="btn"> Shop Now </a>' +
			'</div>';
			$('main .container').html(htmlStr);
		}
		// initial cart list
		getCartListData(function(data) {
			if (data.length) {
				renderCartList(data);
			} else {
				renderCartEmpty();
			}			
		});
		// product event
		// add product
		$(document.body).on('click', '#product-num-add', function() {
			productAdd($(this), true);
		});
		// sub product
		$(document.body).on('click', '#product-num-sub', function() {
			productSub($(this), true);
		});
	</script>
</body>

</html>