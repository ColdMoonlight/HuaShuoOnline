<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<!--[if IE 8]><html class="no-js lt-ie9" lang="en" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml"> <![endif]-->
<!--[if IE 9 ]><html class="ie9 no-js" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html class="no-js" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml"> <!--<![endif]-->
<head>
<c:choose>
<c:when test="${sessionScope.mlbackProductMetaTitle==null}"><title>Product Details</title></c:when>
<c:otherwise><title>${ sessionScope.mlbackProductMetaTitle }</title></c:otherwise>
</c:choose>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
    <meta name="keyword" content="${sessionScope.mlbackProductMetaKeyWords}">
    <meta id="ml-des" name="description" content="${sessionScope.mlbackProductMeteDesc}">
    <!-- google rule -->
	<meta name="robots" content="INDEX,FOLLOW">
    <link rel="alternate" href="https://www.megalook.com/<%=request.getParameter("productSeo") %>.html" hreflang="en-us" />
	<link rel="canonical" href="https://www.megalook.com/<%=request.getParameter("productSeo") %>.html" />
	<!-- socail media -->
	<meta name="twitter:site" content="@megalookhair">
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="${ sessionScope.mlbackProductMetaTitle }">
	<meta name="twitter:description" content="${sessionScope.mlbackProductMeteDesc}">
	<meta name="twitter:image" content="${mbackProductImgResList[0].productimgUrl}">
	<meta name="twitter:image:width" content="600">
	<meta name="twitter:image:height" content="600">
	<script type="application/ld+json">{
		"@context": "http://schema.org/",
		"@type": "Product",
		"name": "${ sessionScope.mlbackProductMetaTitle }",
		"url": "https://www.megalook.com/<%=request.getParameter("productSeo") %>.html",
		"sku": "${sessionScope.productDetailId}",
		"image": [ <c:forEach items="${ mbackProductImgResList }" var="pro" varStatus="status"><c:if test="${status.count < 2}">"${ pro.productimgUrl }"</c:if><c:if test="${status.count > 2}">,"${ pro.productimgUrl }"</c:if></c:forEach> ],
		"description": "${sessionScope.mlbackProductMeteDesc}",
		"brand": { "@type": "Thing", "name": "Megalook Hair" },
		"offers": {
			"@type": "AggregateOffer",
          	"offerCount": "100",
          	"lowPrice": "89.99",
          	"highPrice": "599.99",
          	"priceCurrency": "USD"
        }
	}</script>
	<script> var productId='${sessionScope.productDetailId}', productSeo, productName; </script>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/swiper.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 575px) { .product-share .instagram {background-position: 0 -2rem;} .product-share .youtube {background-position: 0 -8rem;} }
		@media only screen and (min-width: 576px) and (max-width: 1023px) {.product-share .instagram {background-position: 0 -2.5rem;} .product-share .youtube {background-position: 0 -10rem;} }		
		@media only screen and (min-width: 1023px) {.product-share .instagram {background-position: 0 -3rem;} .product-share .youtube {background-position: 0 -12rem;} }
		#countdown-area .body { padding-top: 0; }
		#countdown-area .desc { padding: 0; }
		.product-slide-box .swiper-btn { z-index: 1; }
		.product-slide .swiper-slide>.img { border: 1px solid #ededed; }
		.product-slide .swiper-slide>.img.loaded { background-size: cover; }
		.product-fb-reviews iframe, .fb-reviews-box iframe { width: 100% !important; }
		.product-together-box { padding: 1rem; margin-top: 1rem; border: 1px solid #ededed; border-radius: .5rem; background-color: rgb(255, 192, 203); }
		.product-togher-title { font-size: 1.5rem; font-weight: 500; }
		.product-together-head, .product-together-imgs { margin-bottom: 1rem; }
		.product-together-img-item { display: flex; align-items: center; margin-top: 1rem; }
		.product-together-img+.product-togehter-img-item { margin-left: 1rem; }
		.product-together-plus { font-size: 2rem; }
		.product-together-img-item a { border: 1px solid #ddd; }
		.product-together-cal { margin-bottom: 1rem; } 
		.product-together-info-item { margin-top: .5rem; }
		.proudct-together-name { margin-left: .5rem; font-size: 1.2rem;  color: #333; }
		.product-together-check { width: 18px; height: 18px; }
		.product-together-select { margin-left: 1rem; padding: .25rem .5rem; background-color: #fff; }
		.product-together-oprice { margin-left: .5rem; color: #333; text-decoration: line-through; font-weight: 500; }
		.product-together-dprice { margin-left: .5rem; color: #ff0000; font-weight: 500; }
		.product-tab-item.active { color: #fff; border: 1px solid #000; background-color: #000; }
		.product-reviews,.product-review-orders {display:flex;align-items:center;}
		.product-review-orders {margin-top: 1rem;}
		.product-reviews .product-review-stars {margin-right: .5rem;}
		.product-sold-num {margin-left: 1rem;}
		.product-price-save {border: 1px solid #ff186e; border-radius: 1em;}
		.product-stock {color: #666666; font-style: italic; font-size: .875rem;}
		.product-media {flex-shrink: 0;}
		.product-service {display: none; opacity: 0; visibility: hidden;}
		.product-service-wap-item,.product-service-pc-item2 {margin-bottom: .75rem; margin-right: 1.2rem; font-size: 1rem; color: #3e3a3a;}
		.product-service-wap-item:before,.product-service-pc-item2:before {content: ""; display: inline-block; vertical-align: middle; margin-right: .5rem; background: url(${APP_PATH}/static/pc/img/product-service.png) no-repeat; background-size: 100%;}
		@media only screen and (max-width: 575px) {
			.product-together-imgs { width: 100%; }
			.product-together-img-item { display: inline-block; }
			.product-together-img-item a { display: inline-block; vertical-align: middle; width: 135px; height: 135px; }
			.product-together-plus { display: inline-block; vertical-align: middle; margin: 0 .5rem; }
			.product-together-cal { text-align: center; }
			#product-together-sadd { width: 100%; }
			.product-price-qty {display: flex;justify-content: space-between;}
			.product-price-qty .product-operate {margin-top: 0!important;}
			.product-price-save {float: right;padding: .1rem .25rem; }
			.product-options {margin-top: .5rem!important;}
			.product-service.wap {display: block; opacity: 1;  visibility: visible;}
			.product-service-wap-item:before {width: 1rem; height: 1rem;}
		}
		@media only screen and (min-width: 576px) {
			.product-together-head, .product-together-imgs { display: flex; flex-wrap: wrap;  align-items: center; }
			.product-together-imgs { margin-right: 1rem; }
			.product-together-plus { margin: 0 1rem; }
			.product-together-img-item a { display: block; justify-content: center; width: 150px; height: 150px; }
			.product-price-qty .product-qty { margin-left: 1rem; }
			.product-price-data {display: flex; align-items: center;}
			.product-price-save {margin-top: .5rem; margin-left: 1rem;padding: .2rem .5rem;}
			.product-service.pc {display: block; opacity: 1;  visibility: visible; margin-top: 1rem; padding: 1rem;}
			.product-service-pc-item {display: inline-block; margin-bottom: .75rem; margin-right: 1.2rem;}
			.product-service-pc-item .text {font-size: 1.25rem;}
			.product-service-pc-item .icon {display: inline-block; font-size: 1.5rem; margin-right: .5rem; width: 1.5rem; height: 1.5rem; color: #ff186e;}
			.product-service-pc-item2:before {width: 1.25rem; height: 1.25rem;}
			.product-service-pc-item2 .color {color: #ff186e;}
		}
		.product-coupons.wap, .product-coupons.pc { display: none; opacity: 0; visibility: hidden; }
		@media only screen and (max-width: 1023px) { .product-coupons.wap { display: flex; opacity: 1; visibility: visible; } }
		@media only screen and (min-width: 1024px) { .product-coupons.pc { display: flex; opacity: 1; visibility: visible; } }
		@media only screen and (min-width: 1299px) { .product-media-container {position: absolute;} .product-media-container.product-media-fixed {position: fixed;} }
	</style>
</head>
<body>
    <jsp:include page="../layout/header/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="container">
			<div class="product-details-name product-name"></div>
			<div class="product-header">
				<div class="product-media">
					<div class="product-media-container">
						<div class="product-slide-box">
							<div class="swiper-container product-slide product-zoom">
								<div class="swiper-wrapper">
									<c:forEach items="${ mbackProductImgResList }" var="pro"><div class="swiper-slide"><div class="lazyload img" data-src="${ pro.productimgUrl }" rel="${ pro.productimgUrl }"></div><noscript><img src="${ pro.productimgUrl }" alt="${ sessionScope.mlbackProductMetaTitle }" /></noscript></div></c:forEach>
								</div>
								<div class="swiper-pagination hide"></div>
							</div>
						    <div class="swiper-btn swiper-button-next"></div>
				            <div class="swiper-btn swiper-button-prev"></div>
						</div>
						<div class="swiper-container product-thumb-slide">
							<div class="swiper-wrapper"></div>
						</div>
					</div>
				</div>
				<div class="product-details">
					<div class="product-coupons pc hide"></div>
					<div class="product-review-orders">
						<div class="product-reviews"></div>
						<div class="product-sold-num"></div>
					</div>
					<div class="product-options"><div id="init-loading"></div></div>
					<div class="product-stock"></div>
					<div class="product-price-qty">
						<div class="product-price-data">
							<div class="product-price"></div>
							<div class="product-price-save"></div>
						</div>
						<div class="product-operate">
							<div class="name">Qty:</div>
							<div class="product-qty">
								<span class="group-addon" id="product-num-sub"><i class="icon sub"></i></span>
								<input type="text" class="product-num" value="1" data-count="1">					 
								<span class="group-addon" id="product-num-add"><i class="icon plus"></i></span>					
							</div>
						</div>
					</div>
					<div class="product-pay paypal-button-container">
						<div class="btn paypal-button btn-primary" id="add-to-cart">Add To Cart</div>
		   				<div class="btn paypal-button btn-black buy-now">Buy Now</div>
					</div>

					<div id="countdown-area"></div>

					<div class="product-coupons wap hide"></div>					
					<div class="product-share">
						<a class="share-item youtube" style="background-image: url('${APP_PATH}/static/pc/img/follow-us.png');" href="https://www.youtube.com/channel/UCbbrYL1KabTMlXFmQhFWtmw?view_as=subscriber" title="megalook youtube"></a>
						<a class="share-item instagram" style="background-image: url('${APP_PATH}/static/pc/img/follow-us.png');" href="https://www.instagram.com/megalookhair/" title="megalook instagram"></a>
						<div class="share-item share-click facebook" data-url="https://www.facebook.com/sharer/sharer.php?u=" title="share on facebook"></div>
						<div class="share-item share-click pinterest" data-url="https://www.pinterest.com/pin/create/button/?url=" title="share on pinterest"></div>
						<div class="share-item share-click whatsapp" data-url="https://api.whatsapp.com/send?text=" title="share on whatsapp"></div>
					</div>

					<div class="product-service pc">
						<div class="product-service-pc-item"><span class="icon car"></span><span class="text">Free Shipping</span></div>
						<div class="product-service-pc-item"><span class="icon back"></span><span class="text">30 Days Free Returns</span></div>
						<div class="product-service-pc-item"><span class="icon lock"></span><span class="text">Secure Payment</span></div>
						<div class="product-service-pc-item2"><span class="color">Free Gift---</span> Free Gift With Every Order Worth <strong>$50</strong>.</div>
						<div class="product-service-pc-item2"><span class="color">Free Same Day Delivery---</span> For&nbsp;California In Stock Orders.</div>
						<div class="product-service-pc-item2"><span class="color">Fast Turnaround Time---</span> All Orders Processed Within- <strong>72</strong> Hours.</div>
						<div class="product-service-pc-item2"><span class="color">USA Warehouse Shipping---</span> Express: <strong>1-3 Days</strong>; Free: <strong>3-10 Days.</strong></div>
					</div>
				</div>
			</div>
			<div class="product-service wap">
				<div class="product-service-wap-item">Free Same Day Delivery For California In Stock Orders</div>
				<div class="product-service-wap-item">$50 Gifts/ Order</div>
				<div class="product-service-wap-item">30 Days Free Returns</div>
				<div class="product-service-wap-item">Secure Payment</div>
				<div class="product-service-wap-item">72 Hours Online</div>
			</div>
			<div class="product-together-box hide">
				<div class="product-togher-title">Frequently Bought Together</div>
				<div class="product-together-head">
					<div class="product-together-imgs"></div>
					<div class="product-together-add">
						<div class="product-together-cal">
							<span class="product-together-des">Total Price: </span>
							<span class="product-together-dprice"></span>
							<span class="product-together-oprice"></span>
						</div>
						<button class="btn btn-black" id="product-together-sadd">Add selected to cart</button>
					</div>
				</div>
				<div class="product-together-other"></div>
			</div>
			<div class="product-body">
				<div class="product-tab">
					<div class="product-tab-item btn" data-name="desc">Description</div>
					<div class="product-tab-item btn active" data-name="review">Reviews</div>
				</div>
				<div class="product-tab-body">
					<div class="product-tab-container" data-name="desc">
						<div class="product-description"></div>
						<div class="product-fb-reviews"></div>
					</div>
					<div class="product-tab-container active" data-name="review">
						<div class="product-review-title">
							<div class="product-review-cal">
								<div class="product-review-total">Based on <span>0</span> Customer Reviews</div>
								<div class="product-review-avgstar">
									<span class="icon star"></span>
									<span class="icon star"></span>
									<span class="icon star"></span>
									<span class="icon star"></span>
									<span class="icon star"></span>
								</div>
								<div class="product-review-star-list"></div>
							</div>
							<div class="product-review-add">
								<button class="btn btn-black" id="write-review">Write A Review</button>
							</div>
						</div>
						<div class="product-review-body">
							<div class="product-review-list"></div>
							<div id="table-pagination"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="product-might-like"></div>
		</div>
	<!-- main end -->
	<!-- footer nav -->
	<jsp:include page="../layout/footer/footer.jsp" flush="true"></jsp:include>

	<!-- common script -->
	<script src="${APP_PATH}/static/common/jquery.min.js"></script>
	<script>function getCarouselData(area,async,callback){$.ajax({url:"${APP_PATH}/MlbackSlides/getMlbackSlidListByArea",data:JSON.stringify({slideArea:area}),dataType:"json",contentType:"application/json",type:"post",async:async,success:function(data){100==data.code&&callback&&callback(data.extend.mlbackSlideList)}})}function debounce(callback,delay){var timeEnd;delay=delay||100,Date.now()-timeStart>delay&&clearTimeout(timer),timer=setTimeout((function(){callback&&callback()}),delay)}</script>
	<!-- lazy -->
	<script>!function(t,e){"object"==typeof exports?module.exports=e(t):"function"==typeof define&&define.amd?define([],e):t.LazyLoad=e(t)}("undefined"!=typeof global?global:this.window||this.global,function(t){"use strict";function e(t,e){this.settings=o(r,e||{}),this.images=t||document.querySelectorAll(this.settings.selector),this.observer=null,this.init()}"function"==typeof define&&define.amd&&(t=window);const r={src:"data-src",srcset:"data-srcset",selector:".lazyload",root:null,rootMargin:"0px",threshold:0},o=function(){let t={},e=!1,r=0,s=arguments.length;for("[object Boolean]"===Object.prototype.toString.call(arguments[0])&&(e=arguments[0],r++);r<s;r++)!function(r){for(let s in r)Object.prototype.hasOwnProperty.call(r,s)&&(e&&"[object Object]"===Object.prototype.toString.call(r[s])?t[s]=o(!0,t[s],r[s]):t[s]=r[s])}(arguments[r]);return t};if(e.prototype={init:function(){if(!t.IntersectionObserver)return void this.loadImages();let e=this,r={root:this.settings.root,rootMargin:this.settings.rootMargin,threshold:[this.settings.threshold]};this.observer=new IntersectionObserver(function(t){Array.prototype.forEach.call(t,function(t){if(t.isIntersecting){e.observer.unobserve(t.target);let r=t.target.getAttribute(e.settings.src),o=t.target.getAttribute(e.settings.srcset),s=new Image;s.src=r,s.onload=function(e){var s=e.target.width,i=e.target.height;"img"===t.target.tagName.toLowerCase()?(r&&(t.target.src=r),o&&(t.target.srcset=o)):t.target.style.backgroundImage="url("+r+")",t.target.width=s,t.target.height=i,t.target.classList.add("loaded")},s.onerror=function(){}}})},r),Array.prototype.forEach.call(this.images,function(t){e.observer.observe(t)})},loadAndDestroy:function(){this.settings&&(this.loadImages(),this.destroy())},loadImages:function(){if(!this.settings)return;let t=this;Array.prototype.forEach.call(this.images,function(e){let r=e.getAttribute(t.settings.src),o=e.getAttribute(t.settings.srcset);"img"===e.tagName.toLowerCase()?(r&&(e.src=r),o&&(e.srcset=o)):e.style.backgroundImage="url('"+r+"')"})},destroy:function(){this.settings&&(this.observer.disconnect(),this.settings=null)}},t.lazyload=function(t,r){return new e(t,r)},t.jQuery){const r=t.jQuery;r.fn.lazyload=function(t){return(t=t||{}).attribute=t.attribute||"data-src",new e(r.makeArray(this),t),this}}return e});</script>
	<!-- swiper script -->
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<!-- common footer script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<!-- header script  -->
	<jsp:include page="../layout/header/header-script.min.jsp" flush="true"></jsp:include>
	<!-- third lib -->
	<script src="${APP_PATH}/static/pc/js/jqfly/jquery.fly.min.js"></script>
	<!-- product-details script -->
	<jsp:include page="./productdetails-script.jsp" flush="true"></jsp:include>
	<!-- footer script -->
	<jsp:include page="../layout/footer/footer-script.min.jsp" flush="true"></jsp:include>
	<!-- lottery -->
	<jsp:include page="../layout/lottery.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>