<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>Cart List</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/ad.jsp" flush="true"></jsp:include>
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
						callback && callback(data.extend.mlfrontCartItemListRes);
					}
				}
			});
		}
		// update cart product number
		function updateCartNum(el, num, callback) {
			var targetData = el.parents('.cart-item').data('cartitem') || null,
				reqData = {
					cartitemId: parseInt(targetData.cartitemId),
					cartitemProductNumber: num
				};

			$.ajax({
				url: '${APP_PATH}/MlbackCart/updateCartItemSkuNum',
				data: JSON.stringify(reqData),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						updateProructNumberInCart();
						targetData.cartitemProductNumber = num;
						el.parents('.cart-item').data('cartitem', targetData);
						callback && callback();
						updateProductNumSuccessModal();				
					} else {
						el.find('.product-num').val(targetData.cartitemProductNumber);
						updateProductNumFailModal();
					}
				},
				error: function () {
					el.find('.product-num').val(targetData.cartitemProductNumber);
					updateProductNumFailModal();
				}
			});
		}
		// delete cart product
		function deleteCartProduct(el, callback, callback2, callback3) {
			var targetData = el.data('cartitem') || null,
				reqData = {
					cartitemId: parseInt(targetData.cartitemId)
				};

			$.ajax({
				url: '${APP_PATH}/MlbackCart/delCartItem',
				data: JSON.stringify(reqData),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					el.remove();
					callback && callback();
					callback2 && callback2();
					if (!$('.cart-item').length) callback3 && callback3();
					deleteProductSuccessModal();
				},
				error: function () {
					el.find('.product-num').val(targetData.cartitemProductNumber);
					deleteProductFailModal();
				}
			});
		}
		// render cart list
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
				var definePrice = 0, nowPrice = 0;
				if (item.cartitemProductOriginalprice && item.cartitemProductActoff) {
					definePrice = (item.cartitemProductOriginalprice || 0)  + (parseFloat(item.cartitemProductskuMoneystr) || 0);
					nowPrice = definePrice * item.cartitemProductActoff / 100;
				}
				cartitemProductIdArr.push(item.cartitemProductId); // for facebook
				$cartList.append($('<div class="cart-item">' +
					'<a href="'+ productLink +'" class="cart-img lazyload" data-src="'+ item.cartitemProductMainimgurl +'"></a>' +
					'<div class="cart-product">' +
						'<a class="cart-product-name" href="'+ productLink +'">'+ item.cartitemProductName +'</a>' +
						'<div class="cart-sku-list">'+ cartSkuList +'</div>' +
						'<div class="cart-product-num">' +
							'<div class="cart-product-price">' +
								'<span class="product-define-price">$'+ definePrice.toFixed(2) +'</span>' +
								'<span class="product-now-price">$'+ nowPrice.toFixed(2) +'</span>' +
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
			var subTotal = (calCart.price).toFixed(2);
			var $cartCal = $('<div class="cart-cal">' +
				'<div class="cart-cal-item"><span class="name">NUMTOTAL</span><span class="value cart-cal-total">'+ calCart.count +'</span></div>' +
				'<div class="cart-cal-item"><span class="name">SUBTOTAL</span><span class="value cart-cal-subtotal" data-price="'+subTotal +'">$'+ subTotal +'</span></div>' +
				'<div class="cart-cal-btn"><a href="${APP_PATH}/index.html" class="btn btn-gray">Continue Shopping</a><a href="javascript:;" class="btn btn-black btn-checkout">Checkout</a></div>' +
				/* '<div class="paypal-button-container">'+
					'<div title="paypal" class="btn paypal-button paypal-button-paypal"></div>' +
		        	'<div title="credit" class="btn paypal-button paypal-button-credit"></div>' +
		        '</div>' + */
			'</div>');
			$('main .container').append($cartHeader).append($('<div class="cart-body" />').append($cartList).append($cartCal));

			new LazyLoad($cartList.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			})
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
				resData.price += parseFloat((parseFloat((((data.cartitemProductOriginalprice || 0) + (parseFloat(data.cartitemProductskuMoneystr) || 0)) * (data.cartitemProductActoff || 100) / 100).toFixed(2)) * (data.cartitemProductNumber || 1)).toFixed(2));
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
				'<a href="javascript:goToIndex();" class="btn"> Shop Now </a>' +
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
						mlModalTip('Successful update product skus !');
						callback(data.extend.mlfrontCartItem);
					} else {
						mlModalTip('Failed to update product skus !');
					}
				},
				error: function(err) {
					mlModalTip('Failed to update product skus !');
				}
			});
		}
		function updateCartItemSku(data) {
			$selectedItem.find('.cart-sku-list-item').each(function(idx, item) {
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
						callback && callback();
					} else {
						sysModalTip();
					}
				},
				error: function(err) {
					sysModalErrorTip (err);
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
		// to pay instance
		function toPayInstance(reqData) {
			console.log(reqData)
			$.ajax({
				url: '${APP_PATH}/ProPay/cartToOrderPay',
				data: JSON.stringify(reqData),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						// create payment id
						$.ajax({
							url: '${APP_PATH}/MlfrontOrder/proDetailOrderToPayInfo',
							data: JSON.stringify({
								"orderId": data.extend.OrderIdcartToOrderPay,
								"orderPayPlate": 1, //选择的付款方式,int类型   paypal传0，后来再有信用卡传1
								"orderProNumStr": parseInt($('.cart-cal-total').text()),
							}),
							type: 'post',
							dataType: 'json',
							contentType: 'application/json',
							success: function (data) {
								if (data.code == 100) {								
									goTopayInstance();					
								} else {
									sysModalTip();
								}
							}
						});
					} else {
						sysModalTip();
					}
				},
				error: function (err) {
					sysModalTip();
				}
			});
		}
		// facebook
		function subFacebook(data) {
			var orderMoney = $('.cart-cal-subtotal').data('price');
			// console.log(orderMoney, cartitemProductIdArr)
			/* fbq('track', 'InitiateCheckout', {
				content_ids: cartitemProductIdArr,
				content_type: 'product',
				value: orderMoney,
				currency: 'USD'
			}); */
		}
		// check reqData
		function checkReqData(reqData) {
			if (!reqData.length) {
				sysModalTip();
				return false;
			}
			return true;
		}
		var cartitemProductIdArr = [];
		var $selectedItem = null;
		var cartlistModal = null;
		// product event
		// add product
		$(document.body).on('click', '.product-add', function() {
			productAdd($(this), function(el, num) {
				updateCartNum(el, num, updateCalCart);
			});
		});
		// sub product
		$(document.body).on('click', '.product-sub', function() {
			productSub($(this), function(el, num) {
				updateCartNum(el, num, updateCalCart);
			});
		});
		// delete product
		$(document.body).on('click', '.product-delete', function() {
			deleteCartProduct($(this).parents('.cart-item'), updateProructNumberInCart, updateCalCart, renderCartEmpty);
		});
		// edit sku
		$(document.body).on('click', '.cart-sku-edit', function() {
			$selectedItem =  $(this).parents('.cart-item');
			var targetData = $selectedItem.data('cartitem');
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
				mapSet = {};
				mapItems = {};
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
					var targetData = $selectedItem.data('cartitem');
					targetData.cartitemProductskuId = data.cartitemProductskuId;
					targetData.cartitemProductskuName = data.cartitemProductskuName;
					targetData.cartitemProductskuMoneystr = data.cartitemProductskuMoneystr;
					targetData.cartitemProductskuCode = data.cartitemProductskuCode;
					$selectedItem.data('cartitem', targetData);
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
			checkReqData(reqData) && subFacebook(reqData), cartListCheckout(reqData, goToCheckout);
		});
		// paypal button
		// cartlist checkout
		$(document.body).on('click', '.paypal-button', function() {
			var reqData = getCheckoutData();
			checkReqData(reqData) && (payLoading(), toPayInstance(reqData));
		});
		</script>
</body>

</html>