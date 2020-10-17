<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<script>
	// get display area data
	function getMainBodyData(callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackPageArea/portalSelectPageArea',
			type: "post",
			dataType: "json",
			async: false,
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					callback && callback(data.extend.pageArealist);
				}
			}
		});
	}
	// render banner product
	function renderCarouselOrBanner($el, data, idx) {
		var htmlStr = '';
		var len = data.length;
		if (len) {
			if (len == 1) {
				htmlStr = '<a class="main-body-item" href="'+ (data[0].pageAreaDetailIfinto ? '${APP_PATH}/' + data[0].pageAreaDetaiLinklUrl : 'javascript:;') +'">' +
					'<img class="lazyload" data-src="'+ data[0].pageAreaDetaiImglUrl +'" />' +
				'</a>';
			} else {
				htmlStr += '<div class="main-body-item banner-'+ idx +'"><div class="swiper-container">' +
					'<div class="swiper-btn swiper-button-next"></div>' +
					'<div class="swiper-btn swiper-button-prev"></div>' +
					'<div class="swiper-pagination"></div>' +
					'<div class="swiper-wrapper">';
						data.forEach(function(item) {
							htmlStr += '<div class="swiper-slide">' +
									'<a href="'+ (item.pageAreaDetailIfinto ? '${APP_PATH}/' + item.pageAreaDetaiLinklUrl : 'javascript:;') +'">' +
										'<img class="lazyload" data-src="'+ item.pageAreaDetaiImglUrl +'" />' +										
									'</a>' +
								'</div>';
						});
				htmlStr += '</div></div></div>';
			}			
			$el.append($(htmlStr));
			len > 1 && new Swiper(('.banner-'+ idx +' .swiper-container'), {
				freeMode: true,
				pagination: {
					el: '.banner-'+ idx +' .swiper-pagination',
					clickable: true
				},
				navigation: {
					nextEl: '.banner-'+ idx +' .swiper-button-next',
					prevEl: '.banner-'+ idx +' .swiper-button-prev',
				}
			});
		}
	}
	// render activity product
	function renderActivityProduct($el, data, idx) {
		var htmlStr = '';
		if (data.length) {
			htmlStr += '<div class="ml-ap ap-'+ idx +'">';
			data.forEach(function(item) {
				htmlStr += '<a class="ml-ap-item" href="'+ (data[0].pageAreaDetailIfinto ? '${APP_PATH}/' + data[0].pageAreaDetaiLinklUrl : 'javascript:;') +'">' +
					'<img class="lazyload" data-src="'+ data[0].pageAreaDetaiImglUrl +'" />' +
				'</a>';
			});
			htmlStr += '</div>';
		}
		$el.append($(htmlStr));
	}
	// render carsouel product
	function renderCarouselOrProduct($el, data, idx) {
		var htmlStr = '';
		var len = data.length;
		if (len) {
			htmlStr += '<div class="ml-product-slide banner-'+ idx +'">' +
				'<div class="swiper-btn swiper-button-black swiper-button-next"></div>' +
				'<div class="swiper-btn swiper-button-black swiper-button-prev"></div>' +
				'<div class="swiper-pagination"></div>' +
				'<div class="swiper-container"><div class="swiper-wrapper">';
					data.forEach(function(data) {
						var item = data.mlbackProduct;
						var productLink = item.productSeo ? '${APP_PATH}/' + item.productSeo + '.html' : 'javascript:;';
						htmlStr += '<div class="swiper-slide product-item" data-productid="'+ item.productId +'">' +
						    '<span class="product-discount-label'+ (item.productDiscoutimgShow ? ' show' : '') +'" style="background-image: url('+ (item.productDiscoutimgurl || '') +');"></span>' +
							'<div class="product-img">' +
								'<a href="'+ productLink +'">' +
									'<img class="lazyload" data-src="'+ item.productMainimgurl +'" />' +
								'</a>' +
							'</div>' +
							'<div class="product-desc">' +
								'<div class="product-name"><a href="'+ productLink +'">'+ item.productName +'</a></div>' +
								'<div class="product-data">' +
									'<span class="product-pay-num">'+ (item.productHavesalenum || 0) +' Order(s)</span>' +
									'<span class="product-review-num">'+ (item.productReviewnum || 0) +' Review(s)</span>' +
								'</div>' +
								'<div class="product-price">' +
									'<span class="product-define-price">$'+ (item.productOriginalprice || 0).toFixed(2) +'</span>' +
									'<span class="product-now-price">$'+ (item.productOriginalprice && item.productActoffoff ? accuracyCal(item.productOriginalprice, item.productActoffoff) : 0.00) +'</span>' +
								'</div>' +
							'</div>' +
						'</div>';
					});
			htmlStr += '</div></div></div>';			
			$el.append($(htmlStr));

			new Swiper(('.banner-'+ idx +' .swiper-container'), {
				slidesPerView: 'auto',
				spaceBetween: 5,
				freeMode: true,
				pagination: {
					el: '.banner-'+ idx +' .swiper-pagination',
					clickable: true
				},
				navigation: {
					nextEl: '.banner-'+ idx +' .swiper-button-next',
					prevEl: '.banner-'+ idx +' .swiper-button-prev',
				}
			});
		}
	}
	// get review data
	function getIntroduceReviewData(callback) {
		$.ajax({
			url: "${APP_PATH}/MlfrontReview/selectReviewListFrom",
			data: JSON.stringify({ "reviewFrom": 3 }),
			type: "post",
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					callback && callback(data.extend);
				}
			}
		});
	}
	// render introduce reivews
	function renderIntroduceReview($el, data) {
		var htmlStr = '';
		var $reviewList = $('<div class="showaera-review-container" />')
		data.mlfrontReviewList.forEach(function(item, idx) {
			htmlStr += '<div class="showarea-review-item shadow-radius lazyload" data-src="'+ (data.mlfrontReviewImgList[idx][0] && data.mlfrontReviewImgList[idx][0].reviewimgUrl) +'" data-id="'+ item.reviewPid +'">' +
				'<div class="showarea-review-mask"><div class="shop-it">SHOP IT</div></div>' +
			'</div>';
		});
		$reviewList.html(htmlStr);
		$el.append($reviewList);
	}
	
	function renderMainBody() {
		getMainBodyData(function(data) {
			var $el = $('#main-body');
			if (data.length) {
				data.forEach(function(item, idx) {
					if (String(item[0].pageAreaDetailType) == '0') {
						renderCarouselOrBanner($el, item, idx);
					}
					
					if (String(item[0].pageAreaDetailType) == '1') {
						renderActivityProduct($el, item, idx)
					}

					if (String(item[0].pageAreaDetailType) == '2') {
						renderCarouselOrProduct($el, item, idx)
					}
				});
			}

			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
	}
	
	renderMainBody();

	getCoundownTimeData(1, rednerCountDownAreaOne);

	// customer reviews
	getIntroduceReviewData(function(data) {
		var $el = $('#showAreaThree');
		data.mlfrontReviewList.length && renderIntroduceReview($el, data);
		new LazyLoad($el.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	});
	$(document.body).on('click', '.showarea-review-item', function(e) {
		var productId = $(this).data('id');
		productId && getOneProductData({ "productId": productId }, function(data) {
			var customerVoiceHtml = '<div class="customer-voice">'+
					'<div class="customer-voice-img lazyload" data-src="'+ data.productMainimgurl +'"></div>'+
					'<div class="customer-voice-name">'+ data.productName +'</div>'+
					'<div class="customer-voice-dprice"><span class="name">Regular Price :</span><span class="value">$'+ data.productOriginalprice.toFixed(2) +'</span></div>'+
					'<div class="customer-voice-nprice"><span class="name">Sale Price :</span><span class="value">$'+ (data.productOriginalprice && data.productActoffoff ? accuracyCal(data.productOriginalprice, data.productActoffoff) : 0) +'</span></div>'+
					'<a class="btn btn-pink" href="'+ (data.productSeo ? ('${APP_PATH}/' + data.productSeo +'.html') : 'jvascrtip:;') +'">Buy Now</a>'+
				'</div>';
			var customerVoiceModal = createModal({
				header: {
					html: '<p>Customer Voice</p>'
				},
				body: {
					html: customerVoiceHtml
				}
			});
			new LazyLoad(customerVoiceModal.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
	});
	$(window).on('resize', function () {
		window.innerWidth < 575 && debounce(function() {
			$('#main-body').html('');
			renderMainBody();
		});
	});
</script>