<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Christmas | megalook.com</title>
	<meta name="keywords" content="Lace Front Wigs, Human Hair Extensions,Brazilian Virgin Hair,Affordable Human Hair" />
	<meta name="description" content="Megalook Hair Official Website Sells Best Virgin Hair, Full Lace Wig, Transparent Lace Wig, 360 Lace Wig, Frontal Lace Wig, Closure Lace Wig, Bundles with Closure, Bundles with Frontal, Free Wig Making Service. Hottest Products, Free Gifts, Free & Fast Shipping. No Shedding, No Tangles, Save Big! Lowest Price For U.">
	<!-- google rule -->
	<meta name="robots" content="INDEX,FOLLOW">
    <link rel="alternate" href="https://megalook.com/PortalHome/ChristmasPage.html" hreflang="en-us" />
	<link rel="canonical" href="https://megalook.com/PortalHome/ChristmasPage.html" />
	<!-- socail meta -->
	<meta name="twitter:site" content="@megalookhair">
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="Megalook Hair, Virgin Remy Human Hair Wigs, Lace Front Wigs, Best Wigs | megalook.com">
	<meta name="twitter:description" content="Megalook Hair Official Website Sells Best Virgin Hair, Full Lace Wig, Transparent Lace Wig, 360 Lace Wig, Frontal Lace Wig, Closure Lace Wig, Bundles with Closure, Bundles with Frontal, Free Wig Making Service. Hottest Products, Free Gifts, Free & Fast Shipping. No Shedding, No Tangles, Save Big! Lowest Price For U.">
	<meta property="og:type" content="website">
	<meta property="og:title" content="Megalook Hair, Virgin Remy Human Hair Wigs, Lace Front Wigs, Best Wigs | megalook.com">
	<meta property="og:url" content="https://megalook.com/PortalHome/ChristmasPage.html">
	<meta property="og:site_name" content="Megalook Hair">
	<meta property="og:image" content="https://www.megalook.com/static/apple/micon1.png" />
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin:0; } }
		@media only screen and (max-width: 1078px) and (min-width: 576px) { main { margin: 0; } }
		ul{list-style:none;}
		*{margin: 0; padding: 0;}
		body{padding:0px;margin:0px;}
			.box{width: 100%;}
			.lazyloadnew{background-image:url(${APP_PATH }/static/pc/img/loading.gif); display: block; background-size:contain;background-repeat: no-repeat;background-position: center;opacity: 1;}
			.boxbg{background: url(${APP_PATH }/static/pc/img/sdj/sd_bg.jpg) repeat-y; background-size:100%;}
		    .box_cont{width:70%; margin: 0 15%; display: flex;align-items: flex-start;}
			.left_box,.right_box{width:50%; position:relative;}
			.box_img {width: 100%; text-align: center;}
			.box_img img{display: inline-block;max-width: 100%;}
			.no_tips{padding: 20px 0 0;}
			.product_list_box{width:100%; margin: 0 auto;}
			.product_list_box ul{width: 100%; display: flex;flex-wrap: wrap;}
			.product_list_box ul li{width:23%;margin: 0 1%;}
			.pro_cont .lazyload{background-color: transparent;}
			.product_list_box ul li a{display: block;width: 100%; padding-top:143.75% }
			.product_list_box ul li:nth-of-type(5) a,.product_list_box ul li:nth-of-type(6) a,.product_list_box ul li:nth-of-type(7) a,.product_list_box ul li:nth-of-type(8) a{padding-top:141%;}
			.product_list_box ul li img{max-width: 100%; height: auto;}
			@media only screen and (max-width: 780px) {
				.product_list_box ul li{width:48%;; margin: 0 1% 1%;}
			}
			
			@media only screen and (max-width: 575px) {
				.box_cont{width:100%;margin: 0; display: flex;align-items: flex-start;}
				.left_box,.right_box{width:48%;margin: 0 1%; position:relative;}
				.top_01 .wap{padding-top:41.2%;}
				.top_02 .wap{padding-top:40.4%;}
				.top_03 .wap,.top_04 .wap,.top_05 .wap,.top_06 .wap{padding-top:47.94%;}
				.top_10 .wap{padding-top:57.33%;}
				.box_cont .wap{padding-top:146.66%;}
			   .pc{display:none}
			   .box_img .pc2{display:none}
				.boxbg{padding: 0 1% 15px;}
			}
			@media only screen and (min-width: 576px) {
				.top_01 .pc{padding-top:45.41%;}
				.top_02 .pc{padding-top:25.25%;}
				.top_03 .pc,.top_04 .pc,.top_05 .pc,.top_06 .pc{padding-top:40%;}
				.top_10 .pc{padding-top:39.9%;}
				.box_cont .pc{padding-top:134.61%;}
				.wap{display:none}
				.box_img .wap2{display:none}
				.boxbg{padding: 0 12% 15px}
			}
	</style>
</head>
<body>
    <jsp:include page="../layout/header/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		fAQuestionPage
	<!-- main end -->
	
	<!-- footer nav -->
	<jsp:include page="../layout/footer/footer.jsp" flush="true"></jsp:include>
	<!-- common script -->
	<script src="${APP_PATH}/static/common/jquery.min.js"></script>
	<script>function getCarouselData(area,async,callback){$.ajax({url:"${APP_PATH}/MlbackSlides/getMlbackSlidListByArea",data:JSON.stringify({slideArea:area}),dataType:"json",contentType:"application/json",type:"post",async:async,success:function(data){100==data.code&&callback&&callback(data.extend.mlbackSlideList)}})}function debounce(callback,delay){var timeEnd;delay=delay||100,Date.now()-timeStart>delay&&clearTimeout(timer),timer=setTimeout((function(){callback&&callback()}),delay)}</script>
	<!-- lazy -->
	<script>!function(t,e){"object"==typeof exports?module.exports=e(t):"function"==typeof define&&define.amd?define([],e):t.LazyLoad=e(t)}("undefined"!=typeof global?global:this.window||this.global,function(t){"use strict";function e(t,e){this.settings=o(r,e||{}),this.images=t||document.querySelectorAll(this.settings.selector),this.observer=null,this.init()}"function"==typeof define&&define.amd&&(t=window);const r={src:"data-src",srcset:"data-srcset",selector:".lazyload",root:null,rootMargin:"0px",threshold:0},o=function(){let t={},e=!1,r=0,s=arguments.length;for("[object Boolean]"===Object.prototype.toString.call(arguments[0])&&(e=arguments[0],r++);r<s;r++)!function(r){for(let s in r)Object.prototype.hasOwnProperty.call(r,s)&&(e&&"[object Object]"===Object.prototype.toString.call(r[s])?t[s]=o(!0,t[s],r[s]):t[s]=r[s])}(arguments[r]);return t};if(e.prototype={init:function(){if(!t.IntersectionObserver)return void this.loadImages();let e=this,r={root:this.settings.root,rootMargin:this.settings.rootMargin,threshold:[this.settings.threshold]};this.observer=new IntersectionObserver(function(t){Array.prototype.forEach.call(t,function(t){if(t.isIntersecting){e.observer.unobserve(t.target);let r=t.target.getAttribute(e.settings.src),o=t.target.getAttribute(e.settings.srcset),s=new Image;s.src=r,s.onload=function(e){var s=e.target.width,i=e.target.height;"img"===t.target.tagName.toLowerCase()?(r&&(t.target.src=r),o&&(t.target.srcset=o)):t.target.style.backgroundImage="url("+r+")",t.target.width=s,t.target.height=i,t.target.classList.add("loaded")},s.onerror=function(){}}})},r),Array.prototype.forEach.call(this.images,function(t){e.observer.observe(t)})},loadAndDestroy:function(){this.settings&&(this.loadImages(),this.destroy())},loadImages:function(){if(!this.settings)return;let t=this;Array.prototype.forEach.call(this.images,function(e){let r=e.getAttribute(t.settings.src),o=e.getAttribute(t.settings.srcset);"img"===e.tagName.toLowerCase()?(r&&(e.src=r),o&&(e.srcset=o)):e.style.backgroundImage="url('"+r+"')"})},destroy:function(){this.settings&&(this.observer.disconnect(),this.settings=null)}},t.lazyload=function(t,r){return new e(t,r)},t.jQuery){const r=t.jQuery;r.fn.lazyload=function(t){return(t=t||{}).attribute=t.attribute||"data-src",new e(r.makeArray(this),t),this}}return e});</script>
	<!-- common footer script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<!-- header script  -->
	<jsp:include page="../layout/header/header-script.min.jsp" flush="true"></jsp:include>
	<script>
		new lazyload($('main').find('.lazyloadnew'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	</script>
	<!-- footer script -->
	<jsp:include page="../layout/footer/footer-script.min.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>