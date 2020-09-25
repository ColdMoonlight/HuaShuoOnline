<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<script>
	function renderIndexCarousel(data) {
		indexCarousel && $('.ml-index-carousel .swiper-wrapper').html('');
		var htmlStr = '';
		var isPc = window.innerWidth > 575;
		data.forEach(function(item, idx) {
			var itemSeo, itemLink;
			// product
			if (item.slideIfproorcateorpage == 0) {				
				itemSeo = item.slideSeoname;
			}
			// collection
			if (item.slideIfproorcateorpage == 1) {
				itemSeo = 'search/' + item.slideCateseoname;
			}
			// subject
			if (item.slideIfproorcateorpage == 2) {
				itemSeo = item.slidePageseoname;
			}
			itemLink = item.slideIfinto ? '${APP_PATH}/' + itemSeo + '.html' : 'javascript:;';
			if (isPc) {
				item.slidePcstatus && (htmlStr += '<div class="swiper-slide"><a href="'+ itemLink +'" class="lazyload" data-src="'+ item.slidePcimgurl +'"></a></div>');
			} else {
				item.slideWapstatus && (htmlStr += '<div class="swiper-slide"><a href="'+ itemLink +'" class="lazyload" data-src="'+ item.slideWapimgurl +'"></a></div>');
			}
		});
		$('.ml-index-carousel .swiper-wrapper').html(htmlStr);
		indexCarousel = new Swiper('.ml-index-carousel', {
			loop:true,
			autoplay: {
			    delay: 5000,
			    stopOnLastSlide: false,
			    disableOnInteraction: false,
			},
			pagination: {
				el: '.swiper-pagination',
				clickable: true
			},
			navigation: {
				nextEl: '.swiper-button-next',
				prevEl: '.swiper-button-prev',
			}
		});
		new LazyLoad($('.ml-index-carousel').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	}
	// render carousel
	// render hot ad
	function renderCarouselAd($el, data, tagCls) {
		var htmlStr = '';
		data.forEach(function(item, idx) {
			var itemSeo, itemLink;
			// product
			if (item.slideIfproorcateorpage == 0) {				
				itemSeo = item.slideSeoname;
			}
			// collection
			if (item.slideIfproorcateorpage == 1) {
				itemSeo = 'search/' + item.slideCateseoname;
			}
			// subject
			if (item.slideIfproorcateorpage == 2) {
				itemSeo = item.slidePageseoname;
			}
			itemLink = item.slideIfinto ? '${APP_PATH}/' + itemSeo + '.html' : 'javascript:;';
			htmlStr += (item.slideWapstatus ? '<a class="'+ tagCls +'-item shadow-radius wap lazyload" href="'+ itemLink +'" data-src="'+ item.slideWapimgurl +'"></a>' : '') +
				(item.slideWapstatus ? '<a class="'+ tagCls +'-item pc shadow-radius lazyload" href="'+ itemLink +'" data-src="'+ item.slidePcimgurl +'"></a>' : '');
		});
		$el.html(htmlStr);
	}
	// render showArea
	function renderShowArea($el, data) {
		$el.append($('<div class="showarea-banner lazyload wap" data-src="'+ data.showareaImgurl +'"></div>' +
				'<div class="showarea-banner lazyload pc" data-src="'+ data.showareaImgpcurl +'">'));
	}
	// get display area data
	function getDisplayAreaData(num, callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackShowArea/getMlbackShowAreaOne',
			data: JSON.stringify({"showareaNumth": num}),
			type: "post",
			dataType: "json",
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					callback && callback(data.extend.mlbackShowAreaOne);
				}
			}
		});
	}
	// get activity product data
	function getActivityProductData(num, async, callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackActShowPro/getMlbackActShowProListByActnum',
			data: JSON.stringify({"actshowproActnum": num}),
			type: "post",
			dataType: "json",
			contentType: 'application/json',
			async: async,
			success: function (data) {
				if (data.code == 100) {
					callback && callback(data.extend.mlbackActShowProList || []);
				}
			}
		});
	}
	// get introduce Product data
	function getIntroduceProductData(seo, callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackCategory/searchBycategorySeo',
			data: JSON.stringify({ "categorySeo": seo }),
			type: 'post',
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					callback && callback(descPrdouct(data.extend.mlbackProductResList || []));
				}
			}
		});
	}
	// get review data
	function getIntroduceReviewData(callback) {
		$.ajax({
			url: "${APP_PATH}/MlfrontReview/selectReviewListFrom",
			data: JSON.stringify({ "reviewFrom": 3 }),
			type: "post",
			dataType: 'json',
			contentType: 'application/json',
			async: false,
			success: function (data) {
				if (data.code == 100) {
					callback && callback(data.extend);
				}
			}
		});
	}
	// render hot ad
	function renderActivityProduct($el, data, tagCls) {
		var htmlStr = '';
		data.forEach(function(item, idx) {
			var itemSeo, itemLink;
			if (item.actshowproIfproorcate == 0) {				
				itemSeo = item.actshowproSeoname;
			}
			// collection
			if (item.actshowproIfproorcate == 1) {
				itemSeo = 'search/' + item.actshowproCateseoname;
			}
			// subject
			if (item.actshowproIfproorcate == 2) {
				itemSeo = item.actshowproPageseoname;
			}
			itemLink = itemSeo ? itemSeo + '.html' : 'javascript:;'
			htmlStr += '<a class="'+ tagCls +'-item wap shadow-radius lazyload" href="'+ itemLink +'" data-src="'+ item.actshowproImgwapurl +'"></a>' +
				'<a class="'+ tagCls +'-item pc shadow-radius lazyload" href="'+ itemLink +'" data-src="'+ item.actshowproImgpcurl +'"></a>';
		});
		$el.html(htmlStr);
	}
	function hotFive() {
		!hasHotFive && getActivityProductData(9, false, function(data) {
			var htmlStr = '';
			var $el = $('#hot-five');
			data.length && data.forEach(function(item, idx) {
				var itemSeo, itemLink;
				if (item.actshowproIfproorcate == 0) {				
					itemSeo = item.actshowproSeoname;
				}
				// collection
				if (item.actshowproIfproorcate == 1) {
					itemSeo = 'search/' + item.actshowproCateseoname;
				}
				// subject
				if (item.actshowproIfproorcate == 2) {
					itemSeo = item.actshowproPageseoname;
				}
				itemLink = itemSeo ? itemSeo + '.html' : 'javascript:;'
				htmlStr += '<a class="hot-five-item wap lazyload" href="'+ itemLink +'" data-src="'+ item.actshowproImgwapurl +'"></a>'
			});
			$el.html(htmlStr);
			hasHotFive = true;
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
	}
	// render product slide
	function renderProductSlide($el, typeCls, data, seo) {
		var moreLink = seo ? '${APP_PATH}/search/' + seo + '.html' : 'javascript:;';
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
		});
	}
	// introduce reivews
	function renderIntroduceReview($el, data) {
		var htmlStr = '';
		var $reviewList = $('<div class="showaera-review-container" />')
		data.mlfrontReviewList.forEach(function(item, idx) {
			htmlStr += '<div class="showarea-review-item shadow-radius lazyload" data-src="'+ (data.mlfrontReviewImgList[idx][0] && data.mlfrontReviewImgList[idx][0].reviewimgUrl) +'" data-id="'+ item.reviewPid +'"></div>'
		});
		$reviewList.html(htmlStr);
		$el.append($reviewList);
	}
	var indexCarousel, indexCarouselData, hasHotFive = false;
	getCarouselData(1, false, function(data) {
		indexCarouselData = data;
		data.length && renderIndexCarousel(data);
	});
	hotFive();
	getActivityProductData(8, false, function(data) {
		var $el = $('#hot-two');
		data.length && renderActivityProduct($el, data, 'hot-two');				
		new LazyLoad($el.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	});
	getCarouselData(2, true, function(data) {
		var $el = $('#hot-coupon');
		data.length && renderCarouselAd($el, data, 'hot-coupon');				
		new LazyLoad($el.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	});
	getActivityProductData(7, true, function(data) {
		var $el = $('#activity-product');
		data.length && renderActivityProduct($el, data, 'activity-product');				
		new LazyLoad($el.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	});
	getActivityProductData(6, true, function(data) {
		var $el = $('#hot-collection');
		data.length && renderActivityProduct($el, data, 'hot-collection');				
		new LazyLoad($el.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	});
	getDisplayAreaData(1, function(data) {
		var $el = $('#showAreaOne');
		data && renderShowArea($el, data);
		getIntroduceProductData(ml.area_one, function(data) {
			data.length && renderProductSlide($el, 'showAreaOne', data.slice(0, 8), ml.area_one);
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
	});
	getDisplayAreaData(2, function(data) {
		var $el = $('#showAreaTwo');
		data && renderShowArea($el, data);
		getIntroduceProductData(ml.area_two, function(data) {
			data.length && renderProductSlide($el, 'showAreaTwo', data.slice(0, 8), ml.area_two);
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
	});
	getDisplayAreaData(3, function(data) {
		var $el = $('#showAreaThree');
		data && renderShowArea($el, data);
		getIntroduceReviewData(function(data) {
			data.mlfrontReviewList.length && renderIntroduceReview($el, data);
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
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