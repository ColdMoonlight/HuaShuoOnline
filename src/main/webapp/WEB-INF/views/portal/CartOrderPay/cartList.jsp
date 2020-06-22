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
								'<span class="product-now-price">$'+ (item.cartitemProductOriginalprice && item.cartitemProductActoff ? ((item.cartitemProductOriginalprice  + parseFloat(item.cartitemProductskuMoneystr)) * item.cartitemProductActoff / 100) : 0).toFixed(2) +'</span>' +
								'<span class="product-define-price">$'+ (item.cartitemProductOriginalprice || 0).toFixed(2) +'</span>' +
							'</div>' +
							'<span class="icon delete product-delete">' + '</span>' +
							'<div class="product-qty">' +
								'<span class="group-addon product-sub"><i class="icon sub"></i></span>' +
								'<input type="text" disabled class="product-num" value="' + (item.cartitemProductNumber) + '" />' +
								'<span class="group-addon product-add"><i class="icon plus"></i></span>' +
							'</div>' +
						'</div>' +
					'</div>' +
					'<div class="cart-sku-edit">EDIT</div>' +
				'</div>').data('cartitem', item));
			});
			var calCart = calCartList($cartList.find('.cart-item'));
			var $cartCal = $('<div class="cart-cal">' +
				'<div class="cart-cal-item"><span class="name">NUMTOTAL</span><span class="value cart-cal-total">'+ calCart.count +'</span></div>' +
				'<div class="cart-cal-item"><span class="name">SUBTOTAL</span><span class="value cart-cal-subtotal">$'+ (calCart.price).toFixed(2) +'</span></div>' +
				'<div class="cart-cal-btn"><a href="${APP_PATH}/index.html" class="btn btn-gray">Continue Shopping</a><a href="javascript:;" class="btn btn-black btn-checkout">Checkout</a></div>' +
			'</div>');
			$('main .container').append($cartHeader).append($('<div class="cart-body" />').append($cartList).append($cartCal));
		}
		// cal cartList data
		function calCartList (els) {
			var resData = {
					count: 0,
					price: 0,
				};
			els.each(function(idx, item) {
				var data = $(item).data('cartitem');
				resData.count += data.cartitemProductNumber;
				resData.price += parseFloat((parseFloat(((data.cartitemProductOriginalprice + parseInt(data.cartitemProductskuMoneystr)) * data.cartitemProductActoff / 100).toFixed(2)) * data.cartitemProductNumber).toFixed(2));
			});
			return resData;
		}
		// update cart cal
		function updateCalCart() {
			var calCart = calCartList($('.cart-item'));
			$('.cart-cal-total').text(calCart.count);
			$('.cart-cal-subtotal').text('$' + (calCart.price).toFixed(2));
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
		$(document.body).on('click', '.product-add', function() {
			productAdd($(this), true, updateCalCart);
		});
		// sub product
		$(document.body).on('click', '.product-sub', function() {
			productSub($(this), true, updateCalCart);
		});
		// delete product
		$(document.body).on('click', '.product-delete', function() {
			deleteCartProduct($(this).parents('.cart-item'), updateProructNumberInCart, updateCalCart, renderCartEmpty);
		});
	</script>
</body>

</html>