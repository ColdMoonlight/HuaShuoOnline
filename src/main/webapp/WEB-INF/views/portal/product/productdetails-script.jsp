<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<script>
	function addHeaderInfo(productData) {
		var productNameStr = productData.productName,
			productMetaDescStr = productData.productMetaDesc,
			productSeoStr = productData.productSeo,
			urlStr = 'https://www.megalook.com/' + productSeoStr + '.html',
			imageStr = productData.productMainimgurl,
			amountStr =  accuracyCal(productData.productOriginalprice, productData.productActoffoff),
			productIdStr = productData.productId;
		var meta = $('<meta property = "og:title" content ="' + productNameStr + '">' +
			'<meta property = "og:description" content = "' + productMetaDescStr + '" >' +
			'<meta property = "og:url" content = "' + urlStr + '" >' +
			'<meta property = "og:image" content = "' + imageStr + '" >' +
			'<meta property = "product:brand" content = "MegaLook" >' +
			'<meta property = "product:availability" content = "in stock" >' +
			'<meta property = "product:condition" content = "new" > ' +
			'<meta property = "product:price:amount" content = "' + amountStr + '" >' +
			'<meta property = "product:price:currency" content = "USD" >' +
			'<meta property = "product:retailer_item_id" content = "' + productIdStr + '" >' +
			'');
		$(document.head).append(meta);
	}
	// imagezoom
	(function($) {
	    $.fn.imagezoom = function(options) {
	        var settings = {
	            xzoom: 300,
	            yzoom: 300,
	            scale: 3
	        };
	        var self = this;
	        if (options) {
	            $.extend(settings, options);
	        }
	        $(this).bind("mouseover",  function(ev) {
	            var imageLeft = $(this).offset().left;
	            var imageTop = $(this).offset().top;
	            var imageWidth = $(this).get(0).offsetWidth;
	            var imageHeight = $(this).get(0).offsetHeight;
	            var boxLeft = $(this).parent().offset().left;
	            var boxTop = $(this).parent().offset().top;
	            var boxWidth = $(this).parent().width();
	            var boxHeight = $(this).parent().height();
	            var imageUrl = $(this).attr("rel");
	
	            if ($("div.zoomDiv").get().length == 0) {
	                $(document.body).append("<div class='zoomDiv'><img class='bigimg' src='" + imageUrl + "'/></div>");
	            }
	
	            $(this).css('cursor', 'crosshair');
	
	            $("div.zoomDiv").css({ top: boxTop, left: (boxLeft + boxWidth) });
	            $("div.zoomDiv").width(settings.xzoom);
	            $("div.zoomDiv").height(settings.yzoom);
	            $("div.zoomDiv .bigimg").width(settings.xzoom * settings.scale);
	            $("div.zoomDiv .bigimg").height(settings.yzoom * settings.scale);
	            $("div.zoomDiv").show();
	
	            $(document.body).mousemove(function(e) {
	                var mouse = {
	                		x: e.pageX,
	                		y: e.pageY
	                	};
	                if (mouse.x < imageLeft || (mouse.x > imageLeft + imageWidth) || mouse.y < imageTop || (mouse.y > imageTop + imageHeight)) {
	                    mouseOutImage();
	                } else {                	
	                	var bigWidth = $(".bigimg").get(0).offsetWidth;
	                	var bigHeight = $(".bigimg").get(0).offsetHeight;
	                	var scalex = boxWidth / (bigWidth - settings.xzoom);
	                	var scaley = boxHeight / (bigHeight - settings.yzoom);
	                	var xposs = mouse.x - imageLeft;
	                	var yposs = mouse.y - imageTop;
	                	
	                	$("div.zoomDiv").get(0).scrollLeft = xposs / scalex;
	                	$("div.zoomDiv").get(0).scrollTop = yposs / scaley;
	                }
	            });
	        });
	        function mouseOutImage() {
	            $(document.body).unbind("mousemove");
	            $("div.zoomDiv").remove();
	        }
	    }
	})(jQuery);
	// fly bubble
	function generateFlyBubble(event, callback) {
		$('<img class="ml-flyer" src="'+ mainUrl +'" />').fly({
		    start:{
		    	left: event.pageX - window.pageXOffset,
				top: event.pageY - window.pageYOffset
		    },
		    end:{
		        left: window.innerWidth - 30,
		        top: 150,
		        width: 0,
		        height: 0,
		    },
		    onEnd: function() {
		    	this.destroy();
		    	callback();
		    }
		});
	}
	// update product details attr-data
       function updateProductData(selectedKeys) {
       	var productQty = mapSet[selectedKeys.join(',')];
           var productSku = mapItems[selectedKeys.join(',')] || {};
           if (!Object.keys(mapSet).length || !Object.keys(mapItems).length) {
           	mlModalTip("I'm sorry that the product cannot be purchased for the time being. If necessary, please contact customer service !");
           	return;
           }
           /* if (parseInt($('.product-qty .product-num').val()) > productQty.count) {
           	$('.product-qty .product-num').val(productQty.count);
           	mlModalTip('Under the current options can buy at most <i style="font-weight: blold">'+ productQty.count +'</i> product !');
           } */
          	$('.product-qty .product-num').data('count', productQty.count).data('productsku', productSku);
          	var productSkuMoney = productSku.productskuMoney
          	productSkuMoney ? updateProductPrice(productSkuMoney) : updateProductPrice();
       }
	// update product price
       function updateProductPrice(price) {
       	var data = $('.product-details').data('product');
		function getSkuPrice() {
			return price ? (parseFloat(price) ? parseFloat(price) : 0) : 0
		}
      		$('.product-define-price').text('$'+ (data.productPrice + getSkuPrice()).toFixed(2));
      		$('.product-now-price').text('$'+ accuracyCal((data.productPrice + getSkuPrice()), data.productDiscount));
       }
	// get product data
	function getProductData () {
		var productData = {};
		var productDetails = $('.product-details').data('product') || {};
		var productSKu = $('.product-qty .product-num').data('productsku');

		if (!productSKu || !Object.keys(productSKu).length) return false;

		productData["cartitemProductId"] = productDetails.proudctId;
		productData["cartitemProductSeoName"] = productDetails.productSeo;
		productData["cartitemProductName"] = productDetails.productName;
		productData["cartitemProductOriginalprice"] = productDetails.productPrice;
		productData["cartitemProductMainimgurl"] = productDetails.productMainImgUrl;
		productData["cartitemProductActoff"] = productDetails.productDiscount;

		productData["cartitemProductskuIdstr"] = optionIdArr.join(',');
		productData["cartitemProductskuIdnamestr"] = Object.keys(optionObj).join(',');

		productData["cartitemProductskuId"] = productSKu.productskuId;
		productData["cartitemProductskuName"] = productSKu.productskuName;
		productData["cartitemProductskuCode"] = productSKu.productskuCode;
		productData["cartitemProductskuMoneystr"] = productSKu.productskuMoney;
		productData["cartitemProductNumber"] =  parseInt($('.product-qty .product-num').val());
		
		return productData;
	}
	// to add cart
	function addToCart(reqData, callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackCart/toAddToCart',
			data: JSON.stringify(reqData),
			type: "post",
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					callback && callback();
				} else {
					mlModalTip('Failed to add products to cart !</p>');
				}
			},
			error: function (err) {
				sysModalTip();
			}
		});
	}
	// to buy now
	function toBuyNow(reqData, callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackCart/toBuyNow',
			data: JSON.stringify(reqData),
			type: "post",
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					callback & callback();
				} else {
					mlModalTip("I'm sorry, temporarily unable to settlement, please try again later !");
				}
			},
			error: function(err) {
				sysModalTip();
			}
		});
	}
	// render product media
	function renderProductMedia(data) {
		function stopVideo () {
			$('#ml-video')[0] && $('#ml-video')[0].pause();
		}
		var htmlStr = '';
		var htmlVideoThumb = '';
		var htmlVideo = '';
		data.imgs && data.imgs.forEach(function(item, idx) {
			htmlStr += '<div class="swiper-slide"><div class="lazyload img" data-src="' + item.productimgUrl + '" rel="' + item.productimgUrl + '"></div></div>';
		});
		if (data.video) {
			htmlVideoThumb = '<div class="swiper-slide"><div class=" lazyload" data-src="' + data.video.posterUrl + '"></div></div>';
			
			htmlVideo = '<div class="swiper-slide">' +
				'<video id="ml-video" controls preload="none" poster="' + data.video.posterUrl + '">' +
			    	'<source src="'+ data.video.videoUrl +'" type="video/mp4" />' +
			  	'</video>' +
			'</div>';
		}
		$('.product-thumb-slide .swiper-wrapper').html(htmlVideoThumb + htmlStr);
		$('.product-slide .swiper-wrapper').html(htmlVideo + htmlStr);
		
		$('#ml-video').on('play', function() {
			pintrk('track', 'watchvideo');
		});

		// lazyload
		new LazyLoad($('.product-media .lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
		// media video
			// media imgs
		var swiperThumb = new Swiper('.product-thumb-slide', {
			direction: 'vertical',
			slidesPerView: 6,
			spaceBetween: 5,
			freeMode: true,
			navigation: {
				nextEl: '.product-thumb-slide .swiper-button-next',
				prevEl: '.product-thumb-slide .swiper-button-prev',
			},
			on: {
				slideChangeTransitionStart: function() {
					stopVideo(); // swiper slide start, stop video play
				},
			},
		});
		var swiperMain = new Swiper('.product-slide', {
			pagination: {
				el: '.product-slide .swiper-pagination',
				clickable: true
			},
			navigation: {
				nextEl: '.product-slide .swiper-button-next',
				prevEl: '.product-slide .swiper-button-prev',
			},
			on: {
				slideChangeTransitionStart: function() {
					stopVideo(); // swiper slide start, stop video play
				},
			},
			thumbs: { swiper: swiperThumb },
		});
		imageZoomEvent();
	}
	// render product detials
	function renderProductDetails(data) {
		$('.product-details').data('product', {
			'proudctId': data.productId,
			'productName': data.productName,
			'productDiscount': data.productActoffoff,
			'productMainImgUrl': data.productMainimgurl,
			'productPrice': data.productOriginalprice,
			'productSeo': data.productSeo,
		});
		$('.product-name').text(data.productName);
		$('.product-price').html('<div class="name">Total Price: </div><div class="product-define-price">$'+ (data.productOriginalprice).toFixed(2) +'</div><div class="product-now-price">$'+ accuracyCal(data.productOriginalprice, data.productActoffoff) +'</div>');
		$('.product-tab-container[data-name="desc"]').html(data.productDesc);
	}
	/* product imgs */
	function getProductImgs(callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackProductImg/getMlbackProductImgListByProductId',
			data: JSON.stringify({ "productId": productId }),
			dataType: 'json',
			contentType: 'application/json',
			type: "post",
			success: function (data) {
				if (data.code == 100) {
					callback(data.extend.mbackProductImgResList);
				}
			}
		});			
	}
	/* create review swiper */
	function createReviewSwiper(imgs, activeNum) {
		var slideImgs = imgs.reduce(function(acc, img) {acc += '<div class="swiper-slide"><img class="lazyload" src="'+ img +'" /></div>'; return acc;}, '');
		if (!reviewSwiper) {
			var $reviewSwiper = $('<div class="review-swiper-box">' +
					'<div id="review-swiper" class="swiper-container">' +
					    '<div class="swiper-wrapper">'+ slideImgs +'</div>' +
					    '<div class="swiper-pagination"></div>' +
					    '<div class="swiper-button-next"></div>' +
					    '<div class="swiper-button-prev"></div>' +
				    '</div>' +
				    '<div class="review-swiper-close"><span class="icon close"></span></div>' +
				'<div>');
			$(document.body).append($reviewSwiper);
			addFixed();
			reviewSwiper = new Swiper('#review-swiper', {
				pagination: {
			    	el: '.swiper-pagination',
			    	type: 'fraction',
				},
			    navigation: {
			    	nextEl: '.swiper-button-next',
			    	prevEl: '.swiper-button-prev',
				},
			});

			reviewSwiper.slideTo(activeNum, 0, false);
		} else {
			$('.review-swiper-box .swiper-wrapper').html(slideImgs);

			reviewSwiper.updateSlides();
			reviewSwiper.slideTo(activeNum, 0, false);
			
			$('.review-swiper-box').show();
			addFixed();
		}
	}
	/* details of main */
	function getProductDetails(callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackProduct/getOneMlbackProductDetail',
			data: JSON.stringify({ "productId": productId }),
			dataType: 'json',
			contentType: 'application/json',
			type: "post",
			async: false,
			success: function (data) {
				if (data.code == 100) {
					callback(data.extend.mlbackProductOne);
				}
			}
		});			
	}
	// callback to cart or checkout
	function selectCartOrCheckout(data) {
		var cartCheckoutHtml = '<div class="cart-checkout-product">' +
				'<div class="lazyload" data-src="'+ data.cartitemProductMainimgurl +'"></div>' +
				'<div class="cart-checkout-data">' +
					'<div class="cart-checkout-productname">'+ data.cartitemProductName +'</div>' +
					'<div class="cart-checkout-productprice">' +
						'<div class="name">Price: </div>' +
						'<div class="value">$'+ accuracyCal((data.cartitemProductOriginalprice + parseFloat(data.cartitemProductskuMoneystr)), data.cartitemProductActoff) +'</div>' +
					'</div>' +
					'<div class="btn-group">' +
						'<a class="btn" href="javascript:goToCartList();">View Cart</a>' +
						'<a class="btn btn-pink buy-now">Checkout</a>' +
					'</div>' +
				'</div>' +
			'</div>';
		var cartOrCheckoutModal = createModal({
			header: {
				html: '<p>Product successfully added to your cart!</p>'
			},
   			body: {
   				html: cartCheckoutHtml,
   			},
   			footer: {
   				isShow: true,
   				html: 'Free Gift For Every Order!'
   			},
   			autoClose: false
   		});
		new LazyLoad(cartOrCheckoutModal.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
		cartOrCheckoutModal.addClass('cart-checkout');
		
		setTimeout(function() {
			removeModal(cartOrCheckoutModal);
		}, 5000);
	}
	// to pay instance
	function toPayInstance(reqData) {
		$.ajax({
			url: '${APP_PATH}/ProPay/toBuyNowPay',					
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
							"orderId": data.extend.OrderIdBuyNowPay,
							"orderPayPlate": 1, //选择的付款方式,int类型   paypal传0，后来再有信用卡传1
							"orderProNumStr": reqData.cartitemProductNumber
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
						},
						error: function(err) {
							sysModalTip();
						}
					});
				} else {
					sysModalTip();
				}
			},
			error: function (data) {
				sysModalTip();
			}
		});
	}
	// get review cal data
	function getReviewCalData(callback) {
		$.ajax({
			url: '${APP_PATH}/MlfrontReview/getMlfrontReviewCount',
			data: JSON.stringify({ "reviewPid": productId }),
			type: "post",
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					callback && callback(data.extend);
				} else {
					refreshPageModal();
				}
			},
			error: function(err) {
				refreshPageModal();
			}
		});
	}
	// get review list data
	function getReviewListData() {
		$.ajax({
			url: "${APP_PATH}/MlfrontReview/getMlfrontReviewByProductIdAndPage",
			data: JSON.stringify({ "reviewPid": productId, "reviewUid": getPageNum() }),
			type: "post",
			dataType: 'json',
			contentType: 'application/json',
			async: false,
			success: function (data) {
				if (data.code == 100) {
					var pageInfo = data.extend.pageInfo;
					if (!pageInfo.list.length) {
						$('.product-review-body').html('<p class="text-error">here are no comments yet, you can just click the <i>Write a Reveiw</i> button to write a comment !</p>');
					} else {
						renderProductReviewList(pageInfo.list, data.extend.imgUrlStrListst);
						renderTablePagination(pageInfo);				
					}
				} else {
					refreshPageModal();
				}
			},
			error: function(err) {
				refreshPageModal();					
			}
		});
	}
	// render product review count
	function renderProudctReviewCal (data) {
		var reviewNum = data.allReviewNum,
			reviewStarList = data.StartNumList,
			total = reviewStarList ? reviewStarList.reduce(function(acc, item) {acc += item.startCount * item.startNum; return acc;}, 0) : 0,
			avgStar = Math.ceil(total / reviewNum);
			htmlStr = '';
		for (var i = 4, percent = 0; i >= 0; i-=1) {
			percent = (data.allReviewNum ? reviewStarList[i].startCount * 100 / data.allReviewNum : 0);
			htmlStr += '<div class="product-review-star-item">' +
     	 		'<div class="stars">'+ (i+1) +' star</div>' +
     	 		'<div class="progress">' +
     	 			'<div class="progress-inner" style="width: ' + percent + '%"></div>' +
     	 		'</div>' +
     	 		'<div class="data">'+ percent.toFixed(2)  +'%</div>' +
     	 	'</div>';
		}
		// avg
		$('.product-review-avgstar .icon').each(function(idx, item) {
			if (idx < avgStar) $(item).removeClass('.star').addClass('star2');
		});
		// percent
		$('.product-review-star-list').html(htmlStr);
	}
	// redner pruduct review list
	function renderProductReviewList(reviewList, imgList) {
		var htmlStr = '';
		for (var i = 0, len = reviewList.length; i < len; i++) {
			htmlStr += '<div class="product-review-item">' +
					'<div class="product-review-item-title">' +
						'<div class="product-reivewer-img lazyload" data-src="' + reviewList[i].reviewUimgurl + '"></div>' +
						'<div class="product-review-item-data">' +
							'<div class="product-review-stars">';
							for (var j = 0; j < 5; j++) {
								if (j < reviewList[i].reviewProstarnum) {
									htmlStr += '<span class="icon star2"></span>';
								} else {
									htmlStr += '<span class="icon star"></span>';
								}
							}
					htmlStr += '</div>' +
							'<div class="product-review-author">' + reviewList[i].reviewUname + '</div>' +
						'</div>' +
					'<div class="product-review-date">' + (reviewList[i].reviewCreatetime) + '</div>' +
				'</div>' +
				'<div class="proudct-review-item-text">'+ reviewList[i].reviewDetailstr + '</div>' +
				'<div class="product-review-item-imgs">';
					var imgLen = imgList[i].length <= 6 ? imgList[i].length : 6;
					for (var k = 0; k < imgLen; k++) {
						htmlStr += '<div class="product-review-imgs-item lazyload" data-src="' + imgList[i][k] + '"></div>';
					}
					htmlStr += '</div></div>';
		}
		$('.product-review-list').html(htmlStr);
		
		new LazyLoad($('.product-review-list .lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		})
	}
	// callback delete revie id
	function deleteReviewId() {
		reviewId && $.ajax({
			url: "${APP_PATH }/MlfrontReview/delete",
			type: "post",
			dataType: "json",
			contentType: 'application/json',
			data: JSON.stringify({
				"reviewId": reviewId
			}),
			success: function (data) {}
		});
	}
	// callback get review id
	function getReviewId() {
		deleteReviewId();
		$.ajax({
			url: "${APP_PATH }/MlfrontReview/initializaReview",
			type: "post",
			dataType: "json",
			contentType: 'application/json',
			async: false,
			success: function (data) {
				if (data.code == 100) {
					reviewId = data.extend&& data.extend.mlfrontReview && data.extend.mlfrontReview.reviewId;
				} else {
					sysModalTip();
				}
			},
			error: function (err) {
				sysModalTip();
			}
		});
	}
	// callback save review data
	function saveReviewData(reqData, callback) {
		$.ajax({
			url: "${APP_PATH}/MlfrontReview/save",
			type: "post",
			data: JSON.stringify(reqData),
			dataType: "json",
			contentType: 'application/json',
			async: false,
			success: function (result) {
				if (result.code == 100) {
					mlModalTip('Successful operation. New comment information needs to be reviewed before it can be displayed !');
					reviewId = null;
					callback && callback();
				} else {
					mlModalTip('Operation Failed !');
				}
			},
			error: function() {
				mlModalTip('Operation Failed !');					
			}
		});
	}
	// varients
	var mediaData = {}, productData = {}, mainUrl, reviewSwiper, reviewModal, reviewId, hasReivewData = false;
	// initial
	getProductDetails(function(data) {
		mainUrl = data.productMainimgurl;
		// media
		if (data.productVideoUrl && data.productVideoImgUrl) {
			mediaData.video = {
				videoUrl: data.productVideoUrl,
				posterUrl: data.productVideoImgUrl,
				isVideo: true
			};
		}
		getProductImgs(function(data) {
			mediaData.imgs = data;
			renderProductMedia(mediaData);
		});
		// details
		productSeo = data.productSeo;
		productName = data.proudctName;
		renderProductDetails(data);
		// coupon area list			
		getCouponAreaData(renderCouponAreaData);
		// option
		getProductOption(function(data) {
			renderProductOptions(data);
		});
		// skus
		getProductSkus(function(data) {
			data.length && buildResult(data);				
		});
		// countdown time
		getCoundownTimeData(2, rednerCountDownAreaOne);
		addHeaderInfo(data);
		var fbpid = data.productId;
		var fbprice = accuracyCal(data.productOriginalprice, data.productActoffoff);
		fbq('track', 'PageView', {
			content_ids: fbpid,
			contents: [{ "id": fbpid, "quantity": 999, "item_price": fbprice }],
			content_type: 'product',
			value: fbprice,
			currency: 'USD'
		});
		fbq('track', 'ViewContent', {
			content_ids: fbpid,
			contents: [{ "id": fbpid, "quantity": 999, "item_price": fbprice }],
			content_type: 'product',
			value: fbprice,
			currency: 'USD'
		});
	});
	// event
	$(window).on('resize', imageZoomEvent);
	// image zoom resize
	function imageZoomEvent() {
		if (window.innerWidth < 1300) {
			$('.product-slide.product-zoom').find('.img').off('mouseover');
		} else {
			$('.product-slide.product-zoom').find('.img').imagezoom();
		}
	}
	// product share
	$('.share-item').on('click', function() {
		window.open($(this).data('url') + encodeURIComponent(window.location.href));
	});
	// add product
	$('#product-num-add').on('click', function() {
		productAdd($(this));
	});
	// sub product
	$('#product-num-sub').on('click', function() {
		productSub($(this));
	});
	// product-body product-tab
	$('.product-tab-item').on('click', function() {
		var $this = $(this);
		var tabName = $this.data('name');
		if (!$this.hasClass('active')) $('.product-tab-container[data-name="'+ tabName +'"]').addClass('active').siblings().removeClass('active');
		if (tabName == 'review' && !hasReivewData) {
			// review count
			getReviewCalData(function(data) {
				$('.product-review-total span').text(data.allReviewNum);
				renderProudctReviewCal(data);
			});
			// review list
			getReviewListData();
			// change review state
			hasReivewData = true;
			$('#loader-box').hide();
		}
	});
	// pagination a-click
	$(document.body).on('click', '#table-pagination li', function (e) {
		getReviewListData();
	});
	// add to cart
	$('#add-to-cart').on('click', function(evt) {
		debounce(function() {
			if (isCorrectProduct()) {
				// check product sku is error or not
				var reqData = getProductData();
				if (!reqData) {
					removeModal(reviewModal);
					cannotBuyProductModal();
					return false;
				}

				addToCart(reqData, function() {
					if (window.innerWidth > 1023) {
						generateFlyBubble(evt, updateProructNumberInCart);							
					} else {
						updateProructNumberInCart();
						selectCartOrCheckout(reqData);
					}
				});

				fbq('track', 'AddToCart', {
					content_ids: reqData.cartitemProductId,
					content_type: 'product',
					value: reqData.cartitemProductOriginalprice,
					currency: 'USD'
				});
				pintrk('track', 'addtocart', {
					value: reqData.cartitemProductOriginalprice,
					order_quantity: $('.product-qty .product-num').val(),
					currency: 'USD'
				});
			}
		}, 300);
	});
	// buy now
	$(document.body).on('click', '.buy-now', function() {
		var reqData = getProductData();
		isCorrectProduct() && reqData && (fbq('track', 'InitiateCheckout', {
			content_ids: reqData.cartitemProductId,
			content_type: 'product',
			value: accuracyCal((reqData.cartitemProductOriginalprice + parseFloat(reqData.cartitemProductskuMoneystr)), reqData.cartitemProductActoff),
			currency: "USD"
		}), pintrk('track', 'checkout', {
			value: accuracyCal((reqData.cartitemProductOriginalprice + parseFloat(reqData.cartitemProductskuMoneystr)), reqData.cartitemProductActoff),
			order_quantity: $('.product-qty .product-num').val(),
			currency: 'USD'
		}), toBuyNow(reqData, goToCheckout));
	});
	/* $('.paypal-button.paypal-now').on('click', function() {
		var reqData = getProductData();
		isCorrectProduct() && reqData && (payLoading(), fbq('track', 'AddPaymentInfo', {
			content_ids: reqData.cartitemProductId,
			content_type: 'product',
			value: accuracyCal((reqData.cartitemProductOriginalprice + parseFloat(reqData.cartitemProductskuMoneystr)) * reqData.cartitemProductNumber, reqData.cartitemProductActoff),
			currency: 'USD'
		}), toPayInstance(reqData));
	}); */
	// open reiview swiper
	$(document.body).on('click', '.product-review-imgs-item', function() {
		var activeImg = $(this).data('src');
		var activeNum = 0;
		var imgs = [];
		$(this).parent().find('.lazyload').each(function(idx, item) {
			var img = $(item).data('src');
			if (img == activeImg) activeNum = idx;
			imgs.push(img);
		});
		createReviewSwiper(imgs, activeNum);
	});
	// clsoe reivew swiper		
	$(document.body).on('click', '.review-swiper-close', function() {
		$('.review-swiper-box').hide();
		removeFixed();
	});
	// write review
	$('#write-review').on('click', function(e) {
		var writeReviewHtml = '<div class="write-review-content">' +
			'<div class="input-group">' +
				'<label for="write-review-name">User Name</label>' +
				'<input type="text" id="write-review-name" placeholder="Enter your name (public)">' +
			'</div>' +
			'<div class="input-group">' +
				'<label class="name">Star Rating</label>' +
				'<div class="write-review-star">' +
					'<span class="icon star" data-id="1"></span>' +
					'<span class="icon star" data-id="2"></span>' +
					'<span class="icon star" data-id="3"></span>' +
					'<span class="icon star" data-id="4"></span>' +
					'<span class="icon star" data-id="5"></span>' +
				'</div>' +
			'</div>' +
			'<div class="input-group">' +
				'<label for="write-review-details">Review Text</label>' +
				'<textarea id="write-review-details" placeholder="Write your comments here" rows="5"></textarea>' +
			'</div>' +
			'<div class="input-group">' +
				'<label>Picture Zone (optional)</label>' +
				'<div class="write-review-img-box">' +
					'<div class="ml-upload">' +
						'<input class="upload-review-picture" type="file">' +
						'<i class="icon plus"></i>' +
						'<div class="spinner">' +
							'<div class="spinner-border" role="status" aria-hidden="true"></div>' +
						'</div>'+
					'</div>' +
					'<div class="write-review-imglist hide"></div>' +
				'</div>' +
			'</div>' +
			'<div class="input-group">' +
				'<button class="btn btn-pink write-review-publish">publish</button>' +
			'</div>' +
		'</div>';
		getReviewId();
		reviewModal = createModal({
			header: {
				html: '<p>Write A Review...</p>'
			},
   			body: {
   				html: writeReviewHtml,
   			}
   		});
		reviewModal.addClass('review-modal');
	});
	// select star
	$(document.body).on('click', '.write-review-star .icon', function (e) {
		$('.write-review-star').data('star', $(this).data('id'));
		$(this).removeClass('star').addClass('star2').prevAll('.icon').removeClass('star').addClass('star2');
		$(this).nextAll('.icon').removeClass('star2').addClass('star');
	});
	// upload review picture
	$(document.body).on('change', '.upload-review-picture', function(e) {
		var $this = $(this);
		var file = $this[0].files[0];
		var formData = new FormData();
		var reviewImgLen = $('.write-review-imglist-item').length || 0;
		var reviewImgOrder = reviewImgLen + 1;

		if (!file) return false;

		$this.parent().find('.spinner').show();
		$this.val('');

		formData.append('image', file);
		formData.append('type', 'reviewDetail');
		formData.append('productSeo', productSeo);
		formData.append('reviewId', reviewId);
		formData.append('reviewimgSortOrder', reviewImgOrder);

		if (reviewImgLen >= 6) {
			mlModalTip('Upload up to 6 pictures !');
			return false;
		}

		$.ajax({
			url: "${APP_PATH}/ImageUpload/thumImageReviewAll",
			type: "post",
			data: formData,
			processData: false,
			contentType: false,
			cache: false,
			dataType: 'json',
			success: function (data) {
				if (data.code == 100) {
					$('.write-review-imglist').hasClass('hide') && $('.write-review-imglist').removeClass('hide');
					$('.write-review-imglist').append($('<div class="write-review-imglist-item"><img src="'+ data.extend.sqlimageUrl +'"></div>'));
				} else {
					mlModalTip('Failed to upload comment picture !');
				}
			},
			error: function (err) {
				mlModalTip('Failed to upload comment picture !');
			},
			complete: function () {
				$this.parent().find('.spinner').hide();
			}
		});
	});
	// publish a review
	$(document.body).on('click', '.write-review-publish', function(e) {
		var username = $('#write-review-name').val(),
			starNum = $('.write-review-star').data('star'),
			details = $('#write-review-details').val();

		if (!username || !username.trim()) {
			mlModalTip('Please enter user name !');
			return;
		}

		if (!starNum) {
			mlModalTip('Please Rating Star !');
			return;
		}

		if (!details || !details.trim()) {
			mlModalTip('Comment content cannot be empty !');
			return;
		}

		saveReviewData({
			reviewId: reviewId,
			reviewUname: username,
			reviewPid: productId,
			reviewPseoname: productSeo,
			reviewPname: productName,
			reviewDetailstr: details,
			reviewProstarnum: starNum,
			reviewFrom: 1,
		}, function() {
			removeModal(reviewModal);
		});
	});
	// get introduct product
	getProductSlideArea(function(data) {
		var $el = $('.product-footer');
		data.length && (renderIntroduceProductSlide($el, data),
		new LazyLoad($el.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		}));
	});
	// delte unused reiview
	$(window).on('beforeunload', function() {
		deleteReviewId();
		setPageNum(1);
	});
</script>