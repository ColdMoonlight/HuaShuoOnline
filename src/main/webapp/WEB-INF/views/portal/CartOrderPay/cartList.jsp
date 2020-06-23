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
				var productLink = item.cartitemProductSeoName ? ('${APP_PATH}/'+ item.cartitemProductSeoName +'.html') : 'javascript:;';
				$cartList.append($('<div class="cart-item">' +
					'<a href="'+ productLink +'"><img class="cart-img" src="'+ item.cartitemProductMainimgurl +'"></a>' +
					'<div class="cart-box">' +
						'<a class="cart-product-name" href="'+ productLink +'">'+ item.cartitemProductName +'</a>' +
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
		// update product attr-data
		function updateProductData(data) {
			$('.cartlist-modal .product-options').data('productsku', mapItems[data.join(',')]);
		}
		// update product sku data
		function updateCartItemData(reqData, callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackCart/updateCartitemPku',
				data: JSON.stringify(reqData),
				dataType: 'json',
				contentType: 'application/json',
				type: "post",
				async: false,
				success: function (data) {
					if (data.code == 100) {
						var modal = createModal({
			    			body: {
			    				html: '<p>Successful update product skus.</p>'
			    			},
			    			autoClose: true
			    		});
						callback(data.extend.mlfrontCartItem);
					} else {
						var mpodal = createModal({
			    			body: {
			    				html: '<p>Failed to update product skus.</p>'
			    			},
			    			autoClose: true
			    		});
					}
				},
				error: function(err) {
					var modal = createModal({
		    			body: {
		    				html: '<p>Failed to update product skus.</p>'
		    			},
		    			autoClose: true
		    		});
				}
			});
		}
		function updateCartItemSku(data) {
			$('.cart-sku-list-item').each(function(idx, item) {
				$(item).find('.value').text(data[idx]);
			});			
		}
		// to checkout 
		function cartListCheckout(reqData, callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackCart/cartToOrder',
				data: JSON.stringify(reqData),
				dataType: 'json',
				contentType: 'application/json',
				type: "post",
				async: false,
				success: function (data) {
					if (data.code == 100) {
						callback & callback();
					} else {
						var modal = createModal({
			    			body: {
			    				html: "<p>I'm sorry, temporarily unable to settlement, please try again later !</p>"
			    			},
			    			autoClose: true
			    		});
					}
				},
				error: function(err) {
					var modal = createModal({
		    			body: {
		    				html: '<p>Error: '+ err + '</p>'
		    			},
		    			autoClose: true
		    		});
				}
			});
		}
		// get checkout reqData
		function getCheckoutData() {
			var checkoutData = [];
			$('.cart-item').each(function(idx, item) {
				var targetData = $(item).data('cartitem')
				checkoutData.push({
					"cartitemId": targetData.cartitemId,
			        "cartitemProductId": targetData.cartitemProductId,
			        "cartitemProductNumber": targetData.cartitemProductNumber
				});
			});
			return checkoutData;
		}
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
		// edit sku
		// var selectedRadioArr = [];
		var selectedItem = null;
		var cartlistModal = null;
		$(document.body).on('click', '.cart-sku-edit', function() {
			selectedItem =  $(this).parents('.cart-item');
			var targetData = selectedItem.data('cartitem');
			var selectedRadioArr = targetData.cartitemProductskuName.split(',');
			productId = targetData.cartitemProductId;
			cartlistModal = createModal({
				header: {
					html: '<p>'+ targetData.cartitemProductName +'</p>'
				},
    			body: {
    				html: '<input id="cartitemId" value="'+ targetData.cartitemId +'" hidden /><div class="product-options"></div>'
    			},
    			footer: {
    				isShow: true
    			}
    		});
			cartlistModal.addClass('cartlist-modal');
			// option
			getProductOption(function(data) {
				renderProductOptions(data, selectedRadioArr);
			});
			getProductSkus(function(data) {
				data.length && buildResult(data);				
			});
		});
		// update product sku
		$(document.body).on('click', '.cartlist-modal .modal-ok', function() {
			if (!isCorrectProduct()) return;
			var reqData = $('.cartlist-modal .product-options').data('productsku');
			updateCartItemData({
				"cartitemId": $('#cartitemId').val(),
				"cartitemProductskuId": reqData.productskuId,
				"cartitemProductskuName": reqData.productskuName,
			    "cartitemProductskuCode": reqData.productskuCode,
			    "cartitemProductskuMoneystr": reqData.productskuMoney
			}, function(data) {
				if (data) {
					var targetData = selectedItem.data('cartitem');
					targetData.cartitemProductskuId = data.cartitemProductskuId;
					targetData.cartitemProductskuName = data.cartitemProductskuName;
					targetData.cartitemProductskuMoneystr = data.cartitemProductskuMoneystr;
					targetData.cartitemProductskuCode = data.cartitemProductskuCode;
					selectedItem.data('cartitem', targetData);
					updateCartItemSku(data.cartitemProductskuName.split(','));
					removeModal(cartlistModal);
				} else {
					window.location.href = window.location.href;
				}
			});
		});
		// cartlist checkout
		$(document.body).on('click', '.btn-checkout', function() {
			var reqData = getCheckoutData();
			if (!reqData.length) {
				var modal = createModal({
	    			body: {
	    				html: "<p>Settlement system error, temporarily unable to, please try again later !</p>"
	    			},
	    			autoClose: true
	    		});
				return ;
			}
			cartListCheckout(reqData, goToCheckout);
		});
		</script>
</body>

</html>