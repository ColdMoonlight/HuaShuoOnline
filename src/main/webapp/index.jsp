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
		<style> main { margin-left: 0; margin-right: 0; margin-top: -16px; }</style>
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
			<div id="showAreaOne" class="showarea"></div>
			<div id="showAreaTwo" class="showarea"></div>
			<div id="showAreaThree" class="showarea"></div>
		</main>
		<jsp:include page="WEB-INF/views/portal/layout/footer.jsp" flush="true"></jsp:include>
		<jsp:include page="WEB-INF/views/portal/common/footer.jsp" flush="true"></jsp:include>
		<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
		<script>
			function renderIndexCarousel(data) {
				indexCarousel && indexCarousel.destory();
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
			var indexCarousel, indexCarouselData;
			getCarouselData(1, function(data) {
				indexCarouselData = data;
				data.length && renderIndexCarousel(data);
			});
			getDisplayAreaData(1, function(data) {
				var $el = $('#showAreaOne');
				data && renderShowArea($el, data);
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			getDisplayAreaData(2, function(data) {
				var $el = $('#showAreaTwo');
				data && renderShowArea($el, data);
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
			getDisplayAreaData(3, function(data) {
				var $el = $('#showAreaThree');
				data && renderShowArea($el, data);
				new LazyLoad($el.find('.lazyload'), {
					root: null,
					rootMargin: "10px",
					threshold: 0
				});
			});
		</script>	
	</body>
</html>