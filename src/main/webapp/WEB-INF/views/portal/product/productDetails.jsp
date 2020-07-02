<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title></title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
	<link href="${APP_PATH}/static/pc/js/jqzoom/jqzoom.css" rel="stylesheet">
	<link href="${APP_PATH}/static/pc/js/video/video.min.css" rel="stylesheet">
	<script>
		var productId = '${sessionScope.productDetailId}';
		var seoTitle = '${sessionScope.mlbackProductMetaTitle}';
		var seoDescription = '${sessionScope.mlbackProductMeteDesc}';
		var seoKeywords = '${sessionScope.mlbackProductMetaKeyWords}';
		document.title = seoTitle;
		addMeta('keyword', seoKeywords);
		addMeta('description', seoDescription);
	</script>
	<style>
		@media only screen and (max-width: 1023px) {
			main { margin: 0 }
			.product-details, .product-body, .product-footer { margin-left: 1rem; margin-right: 1rem; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="product-header">
				<div class="product-media">
					<div class="swiper-container product-slide product-zoom">
						<div class="swiper-wrapper"></div>
			   			<div class="swiper-pagination"></div>
					    <div class="swiper-btn swiper-button-next"></div>
			            <div class="swiper-btn swiper-button-prev"></div>
					</div>
					<div class="swiper-container product-thumb-slide">
						<div class="swiper-wrapper"></div>
					    <div class="swiper-button-next"></div>
			            <div class="swiper-button-prev"></div>
					</div>
					<div class="product-share">
						<div class="share-item" data-url="https://plus.google.com/share?url=" title="share on google+">google + </div>
						<div class="share-item" data-url="https://twitter.com/intent/tweet?url=" title="share on twitter">twitter</div>
						<div class="share-item" data-url="https://www.facebook.com/sharer/sharer.php?u=" title="share on facebook">facebook</div>
						<div class="share-item" data-url="https://www.pinterest.com/pin/create/button/?url=" title="share on pinterest">pinterest</div>
						<div class="share-item" data-url="https://api.whatsapp.com/send?text=" title="share on whatsapp">whatsapp</div>
					</div>
				</div>
				<div class="product-details">
					<div class="product-name"></div>
					<div class="product-coupons">
						<img class="left" src="http://megalook.com:80/static/img/CouponDescTitle/couponTitlepcId1time8154942.jpg">
						<div class="right">
							<div class="title">Mid-Year Sale  Screaming Price</div>
							<ul class="body">
								<li>Extra&nbsp;<span>&nbsp;6% Off&nbsp;</span>&nbsp;With No Limit, Code :&nbsp;<b>&nbsp;MY6</b></li>
								<li>Over $99&nbsp;<span>&nbsp;Get Extra 12%&nbsp;</span>&nbsp;Off ! Code :&nbsp;<b>&nbsp;MY12</b></li>
							</ul>
						</div>
					</div>
					<div class="product-options"></div>
					<div class="product-price"></div>
					<div class="product-operate">
						<div class="name">Qty:</div>
						<div class="product-qty">
							<span class="group-addon" id="product-num-sub"><i class="icon sub"></i></span>
							<input type="text" class="product-num" value="1" data-count="1" disabled>					 
							<span class="group-addon" id="product-num-add"><i class="icon plus"></i></span>					
						</div>
					</div>
					<div class="product-pay paypal-button-container">
						<div class="btn paypal-button btn-primary" id="add-to-cart">Add To Cart</div>
		   				<div class="btn paypal-button btn-black" id="buy-now">Buy Now</div>
						<div title="paypal" class="btn paypal-button paypal-now paypal-button-paypal"></div>
				        <div title="credit" class="btn paypal-button paypal-now paypal-button-credit"></div>
					</div>
				</div>
			</div>
			<div class="product-body">
				<div class="product-service">
					<div class="product-service-item">
						<div class="icon car"></div>
						<p>Free Shipping</p>
					</div>
					<div class="product-service-item">
						<div class="icon back"></div>
						<p>15 Days Returns</p>
					</div>
					<div class="product-service-item">
						<div class="icon lock"></div>
						<p>Secure Payment</p>
					</div>
				</div>
				<div class="product-tab">
					<div class="product-tab-item btn btn-primary" data-name="desc">Description</div>
					<div class="product-tab-item btn btn-black" data-name="review">Reviews</div>
				</div>
				<div class="product-tab-body">
					<div class="product-tab-container" data-name="desc"></div>
					<div class="product-tab-container active" data-name="review">
						<div class="product-review-title">
							<div class="product-review-cal">
								<div class="product-review-total">Based on <span>0</span> Customer Reviews</div>
								<div class="product-review-star-list"></div>
							</div>
							<div class="product-review-add">
								<button class="btn btn-black">Write A Review</button>
							</div>
						</div>
						<div class="product-reivew-body">
							<div class="product-review-list"></div>
							<div id="table-pagination"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="product-footer"></div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<script src="${APP_PATH}/static/pc/js/jqzoom/jquery.jqzoom.js"></script>
	<script src="${APP_PATH}/static/pc/js/video/video.min.js"></script>
	<script src="${APP_PATH}/static/pc/js/jqfly/jquery.fly.min.js"></script>
	<script>
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
            if (parseInt($('.product-qty .product-num').val()) > productQty.count) {
            	$('.product-qty .product-num').val(productQty.count);
            	mlModalTip('Under the current options can buy at most <i style="font-weight: blold">'+ productQty.count +'</i> product !');
            }
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
       		$('.product-now-price').text('$'+ (data.productDiscount * (data.productPrice +getSkuPrice()) / 100).toFixed(2));
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
					sysModalErrorTip (err);
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
					sysModalErrorTip (err);
				}
			});
		}
		// render product media
		function renderProductMedia(data) {
			var htmlStr = '';
			var htmlVideoThumb = '';
			var htmlVideo = '';
			data.imgs && data.imgs.forEach(function(item, idx) {
				htmlStr += '<div class="swiper-slide">' +
					'<img class="img" src="' + item.productimgUrl + '" rel="' + item.productimgUrl + '">' +
				'</div>';
			});
			if (data.video) {
				htmlVideoThumb = '<div class="swiper-slide">' +
					'<img class="img" src="' + data.video.posterUrl + '">' +
				'</div>';
				
				htmlVideo = '<div class="swiper-slide">' +
					'<video id="ml-video" class="video-js" controls preload="auto" width="500" height="500" poster="' + data.video.posterUrl + '">' +
				    	'<source src="'+ data.video.videoUrl +'" type="video/mp4" />' +
				  	'</video>' +
				'</div>';
			}
			$('.product-thumb-slide .swiper-wrapper').html(htmlVideoThumb + htmlStr);
			$('.product-slide .swiper-wrapper').html(htmlVideo + htmlStr);
			// media video
			var player = null;
			if ($('#ml-video').length) {
				player = videojs('ml-video', {
	                autoPlay: false,
	                preload: 'auto',
	                controls: true,
	            });
			}
			// video play event
            function listenPlay() {
                player && player.on('play', function(e) {
                    this.bigPlayButton.eventBusEl_.style.display = 'none';
                    player.off('play');
                    listenPause();
                });
            }
			// video pause
            function listenPause() {
            	 player && player.on('pause', function(e) {
                    // console.log('pause');
                    this.bigPlayButton.eventBusEl_.style.display = 'block';
                    player.off('pause');
                    listenPlay();
                });
            }

            listenPause();
 			// media imgs
			var swiperThumb = new Swiper('.product-thumb-slide', {
				direction: 'vertical',
				slidesPerView: 6,
				spaceBetween: 5,
				freeMode: true,
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev',
				},
				on: {
					slideChangeTransitionStart: function() {
						 player && player.pause(); // swiper slide start, stop video play
					},
				},
			});
			var swiperMain = new Swiper('.product-slide', {
				pagination: {
					el: '.swiper-pagination',
					clickable: true
				},
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev',
				},
				on: {
					slideChangeTransitionStart: function() {
						 player && player.pause(); // swiper slide start, stop video play
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
			$('.product-price').html('<div class="name">Total Price: </div><div class="product-define-price">$'+ (data.productOriginalprice).toFixed(2) +'</div><div class="product-now-price">$'+ (data.productActoffoff * data.productOriginalprice / 100).toFixed(2) +'</div>');
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
				data: { "productId": productId },
				type: "post",
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend.StartNumList);
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
				url: "${APP_PATH}/MlfrontReview/getMlfrontReviewByPage",
				data: { "reviewPid": productId, "reviewUid": getPageNum() },
				type: "post",
				success: function (data) {
					if (data.code == 100) {
						var pageInfo = data.extend.pageInfo;
						if (!pageInfo.list.length) {
							$('.product-review-body').html('<p class="text-error">here are no comments yet, you can just click the <i>Write a Reveiw</i> button to write a comment</p>');
						} else {
							renderProductReviewList(pageInfo.list);
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
		// varients
		var mediaData = {}, productData = {}, mainUrl;
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
			renderProductDetails(data);
			// option
			getProductOption(function(data) {
				renderProductOptions(data);
			});
			// skus
			getProductSkus(function(data) {
				data.length && buildResult(data);				
			});
		});
		// review count
		getReviewCalData(renderProudctReviewCal);
		// render product review count
		function renderProudctReviewCal (data) {
			var total = data ? data.reduce(function(acc, item) {acc += item.startCount; return acc;}, 0) : 0;
			var htmlStr = '';
			$('.product-review-total span').text(total);
			for (var i = 4, percent = 0; i >= 0; i-=1) {
				percent = (total ? data[i].startCount * 100 / total : 0);
				htmlStr += '<div class="product-review-star-item">' +
	     	 		'<div class="stars">'+ (i+1) +' star</div>' +
	     	 		'<div class="progress">' +
	     	 			'<div class="progress-inner" style="width: ' + percent + '%"></div>' +
	     	 		'</div>' +
	     	 		'<div class="data">'+ percent.toFixed(2)  +'%</div>' +
	     	 	'</div>';
			}
			$('.product-review-star-list').html(htmlStr);
		}
		// review list
		getReviewListData();
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getReviewListData();
		});
		// redner pruduct review list
		function renderProductReviewList(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i++) {
				htmlStr += '<div class="product-review-item" data-reviewid="' + data[i].reviewId + '">' +
						'<div class="product-review-item-title">' +
							'<img src="' + data[i].reviewUimgurl + '" alt="'+ data[i].reviewUname +'">' +
							'<div class="product-review-data">' +
								'<div class="product-review-stars">';
								for (var j = 0; j < 5; j++) {
									if (j < data[i].reviewProstarnum) {
										htmlStr += '<span class="icon star2"></span>';
									} else {
										htmlStr += '<span class="icon star"></span>';
									}
								}
						htmlStr += '</div>' +
								'<div class="product-review-author">' + data[i].reviewUname + '</div>' +
							'</div>' +
						'<div class="proudct-review-date">' + (new RelativeTIime({ date: data[i].reviewCreatetime }).output) + '</div>' +
					'</div>' +
					'<div class="proudct-review-item-text">'+ data[i].reviewDetailstr + '</div>' +
					'<div class="product-review-item-imgs">';
						/* var imgLen = img[i].length <= 5 ? img[i].length : 5;
						for (var k = 0; k < imgLen; k++) {
							htmlStr += '<img src="' + img[i][k] + '">';
						} */
						htmlStr += '</div></div>';
			}
			$('.product-review-list').html(htmlStr);
		}
		// event
		$(window).on('resize', imageZoomEvent);
		// image zoom resize
		function imageZoomEvent() {
			if (window.innerWidth < 1024) {
				$('.product-slide.product-zoom').find('.img').off('mouseover');
			} else {
				$('.product-slide.product-zoom').find('.img').imagezoom();
			}
		}
		// product share
		$('.share-item').on('click', function() {
			window.open($(this).data('url') + encodeURIComponent('https://megalook.com/B-3-Bundles-with-4x4-Closure-Deep-Wave.html'));
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
			if (!$this.hasClass('active')) $('.product-tab-container[data-name="'+ $this.data('name') +'"]').addClass('active').siblings().removeClass('active');
		});
		// add to cart
		$('#add-to-cart').on('click', function(evt) {
			var timeEnd = Date.now();
			if (timeEnd - timeStart < 300) clearTimeout(timer);
			timeStart = timeEnd;
			timer = setTimeout(function() {
				if (isCorrectProduct()) {
					// check product sku is error or not
					var reqData = getProductData();
					if (!reqData) {
						mlModalTip("I'm sorry, the goods temporarily can't buy !");
						return false;
					}

					addToCart(reqData, function() {
						if (window.innerWidth > 1023) {
							generateFlyBubble(evt, updateProructNumberInCart);							
						} else {
							updateProructNumberInCart();
						}
					});
				}
			}, 300);
		});
		// buy now
		$('#buy-now').on('click', function() {
			var reqData = getProductData();
			isCorrectProduct() && reqData && toBuyNow(reqData, goToCheckout);
		});
		$('.paypal-button.paypal-now').on('click', function() {
			var reqData = getProductData();
			isCorrectProduct() && reqData && (payLoading(), toPayInstance(reqData));
		});
	</script>
</body>
</html>