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
			htmlStr += '<div class="showarea-review-item shadow-radius lazyload" data-src="'+ (data.mlfrontReviewImgList[idx][0] && data.mlfrontReviewImgList[idx][0].reviewimgUrl) +'" data-id="'+ item.reviewPid +'"></div>'
		});
		$reviewList.html(htmlStr);
		$el.append($reviewList);
	}
	// render product slide
	function renderProductSlide($el, typeCls, data, seo) {
		/* var moreLink = seo ? '${APP_PATH}/search/' + seo + '.html' : 'javascript:;';
		var $productMore = $('<div class="swiper-slide product-item product-more-img lazyload" data-src="${APP_PATH}/static/pc/img/product-more.jpg">' +
				'<a href="'+ moreLink +'"><div class="product-img"></div><div class="product-more-desc"></div></a>' +
			'</div>');
		var productSlide = generateSwiperSlideProduct(data).addClass('showaera-container');
		productSlide.find('.swiper-wrapper').append((seo && $productMore));
		$el.append(productSlide)
		new Swiper(('.' + typeCls + ' .swiper-container'), {
			slidesPerView: 'auto',
			spaceBetween: 5,
			freeMode: true,
			navigation: {
				nextEl: '.' + typeCls + ' .swiper-button-next',
				prevEl: '.' + typeCls + ' .swiper-button-prev',
			}
		}); */
		function renderCarouselOrBanner($el, data, idx) {
			var htmlStr = '';
			var len = data.length;
			if (len) {
				if (len == 1) {
					htmlStr = '<a class="main-body-item" href="'+ (data[0].pageAreaDetailIfinto ? '${APP_PATH}/' + data[0].pageAreaDetaiLinklUrl : 'javascript:;') +'">' +
						'<img class="lazyload" data-src="'+ data[0].pageAreaDetaiImglUrl +'" />' +
					'</a>';
				} else {
					htmlStr += '<div class="main-body-item banner-'+ idx +'">' +
						'<div class="swiper-btn swiper-button-next"></div>' +
						'<div class="swiper-btn swiper-button-prev"></div>' +
						'<div class="swiper-pagination"></div>' +
						'<div class="swiper-container"><div class="swiper-wrapper">';
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
	}
	
	getMainBodyData(function(data) {
		var $el = $('#main-body');
		if (data.length) {
			data.forEach(function(item, idx) {
				if (String(item[0].pageAreaDetailType) == '0') {
					renderCarouselOrBanner($el, item, idx);
				}
			});
		}
		
		new LazyLoad($el.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	});

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
			hotFive();
		});
		renderIndexCarousel(indexCarouselData);
	});
</script>