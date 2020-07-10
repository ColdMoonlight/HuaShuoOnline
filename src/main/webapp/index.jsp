<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
	<head>
		<title>Megalook Hair - Megalook Offical Store</title>
		
		<meta name="keyword" content="Megalook,MegaLook Hair,Human Hair Wig,Full Lace Wig, 360 Lace Front Wig, Lace Front Wig,Bundles with Closure,straight Human Hair,Body Wave Human Hair,Water Wave Human Hair,Deep Wave Wig,Loose Wave Wig,kinky Curly Wig,Jerry Curly Wig,Bob Wig,Yaki Straight Wig,Full Lace Wig,Transparent Lace Wig,613 Blonde Wig,Ombre Color Wig,613 blonde hair">
		<meta name="description" content="Megalook Hair Official Website Sells Best Virgin Hair, Full Lace Wig, Transparent Lace Wig, 360 Lace Wig, Frontal Lace Wig, Closure Lace Wig, Bundles with Closure, Bundles with Frontal, Free Wig Making Service. Hottest Products, Free Gifts, Free & Fast Shipping. No Shedding, No Tangles, Save Big! Lowest Price For U.">
		
		<jsp:include page="WEB-INF/views/portal/common/header.jsp" flush="true"></jsp:include>
		<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
		<style> main { margin: -16px 0 0 0; background-color: #f5f5f5;}</style>
	</head>
	<body>
		<jsp:include page="WEB-INF/views/portal/layout/header.jsp" flush="true"></jsp:include>
		<main>
			<div class="ml-index-carousel swiper-container">
				<div class="swiper-wrapper"></div>
		   		<div class="swiper-pagination"></div>
			    <div class="swiper-btn swiper-button-next"></div>
	            <div class="swiper-btn swiper-button-prev"></div>
			</div>
			<div id="hot-five" class="hot-five"></div>
			<div id="hot-two" class="hot-two"></div>
			<div id="hot-coupon" class="hot-coupon"></div>
			<div id="activity-product" class="activity-product"></div>
			<div id="hot-collection" class="hot-collection"></div>
			<div id="showAreaOne" class="showarea showAreaOne"></div>
			<div id="showAreaTwo" class="showarea showAreaTwo"></div>
			<div id="showAreaThree" class="showarea showAreaThree"></div>
		</main>
		<jsp:include page="WEB-INF/views/portal/layout/footer.jsp" flush="true"></jsp:include>
		<jsp:include page="WEB-INF/views/portal/common/footer.jsp" flush="true"></jsp:include>
		<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
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
					if (item.catalogIfproorcateorpage == 1) {
						itemSeo = 'search/' + item.slideCateseoname;
					}
					// subject
					if (item.catalogIfproorcateorpage == 2) {
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
					if (item.catalogIfproorcateorpage == 1) {
						itemSeo = 'search/' + item.slideCateseoname;
					}
					// subject
					if (item.catalogIfproorcateorpage == 2) {
						itemSeo = item.slidePageseoname;
					}
					itemLink = item.slideIfinto ? '${APP_PATH}/' + itemSeo + '.html' : 'javascript:;';
					htmlStr += '<a class="'+ tagCls +'-item wap lazyload" href="'+ itemLink +'" data-src="'+ item.slideWapimgurl +'"></a>' +
						'<a class="'+ tagCls +'-item pc lazyload" href="'+ itemLink +'" data-src="'+ item.slidePcimgurl +'"></a>';
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
					async: false,
					success: function (data) {
						if (data.code == 100) {
							callback && callback(data.extend.mlbackShowAreaOne);
						}
					}
				});
			}
			// get activity product data
			function getActivityProductData(num, callback) {
				$.ajax({
					url: '${APP_PATH}/MlbackActShowPro/getMlbackActShowProListByActnum',
					data: JSON.stringify({"actshowproActnum": num}),
					type: "post",
					dataType: "json",
					contentType: 'application/json',
					async: false,
					success: function (data) {
						if (data.code == 100) {
							callback && callback(data.extend.mlbackActShowProList);
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
					async: false,
					success: function (data) {
						if (data.code == 100) {
							callback && callback(data.extend.mlbackProductResList);
						}
					}
				});
			}
			// get review data
			function getReviewData(callback) {
				$.ajax({
					url: "${APP_PATH}/MlfrontReview/selectReviewListFrom",
					data: JSON.stringify({ "reviewFrom": 3 }),
					type: "post",
					dataType: 'json',
					contentType: 'application/json',
					async: false,
					success: function (data) {
						if (data.code == 100) {
							callback && callback();
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
					htmlStr += '<a class="'+ tagCls +'-item wap lazyload" href="'+ itemLink +'" data-src="'+ item.actshowproImgwapurl +'"></a>' +
						'<a class="'+ tagCls +'-item pc lazyload" href="'+ itemLink +'" data-src="'+ item.actshowproImgpcurl +'"></a>';
				});
				$el.html(htmlStr);
			}
			function hotFive() {
				!hasHotFive && getActivityProductData(9, function(data) {
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
			function renderProductSlide($el, typeCls, data) {
				var productSlide = generateSwiperSlideProduct(data).addClass('showaera-container');
				$el.append(productSlide)
				new Swiper(('.' + typeCls + ' .swiper-container'), {
					slidesPerView: (window.innerWidth > 575 ? 4 : 2),
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
				
			}
			var indexCarousel, indexCarouselData, hasHotFive = false;
			getCarouselData(1, function(data) {
				indexCarouselData = data;
				data.length && renderIndexCarousel(data);
			});
			hotFive();
			getActivityProductData(8, function(data) {
				var $el = $('#hot-two');
				data.length && renderActivityProduct($el, data, 'hot-two');				
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			getCarouselData(2, function(data) {
				var $el = $('#hot-coupon');
				data.length && renderCarouselAd($el, data, 'hot-coupon');				
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			getActivityProductData(7, function(data) {
				var $el = $('#activity-product');
				data.length && renderActivityProduct($el, data, 'activity-product');				
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			getActivityProductData(6, function(data) {
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
				getIntroduceProductData('top-selling', function(data) {
					data.length && renderProductSlide($el, 'showAreaOne', data.slice(0, 8));
				});
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			getDisplayAreaData(2, function(data) {
				var $el = $('#showAreaTwo');
				data && renderShowArea($el, data);
				getIntroduceProductData('New-Arrival', function(data) {
					renderProductSlide($el, 'showAreaTwo', data.slice(0, 8));
				});
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			getDisplayAreaData(3, function(data) {
				var $el = $('#showAreaThree');
				data && renderShowArea($el, data);
				getReviewData(function(data) {
					data.length && renderIntroduceReview($el, data);
				});
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			$(window).on('resize', function () {
				window.innerWidth < 575 && debounce(function() {
					hotFive();
				});
				renderIndexCarousel(indexCarouselData);
			});
		</script>	
	</body>
</html>