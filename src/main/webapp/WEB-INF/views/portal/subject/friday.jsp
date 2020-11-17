<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Friday</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin:0; } }
		@media only screen and (max-width: 1078px) and (min-width: 576px) { main { margin: 0; } }
		ul{list-style:none;}
		*{margin: 0; padding: 0;}
		body{padding:0px;margin:0px;}
		.product_list_box{width:1224px; margin: 0 auto;}
		.product_list_box ul{width: 100%; padding: 0 2%; display: flex;flex-wrap: wrap; background: url(${APP_PATH }/static/pc/img/friday/bg_05.png) no-repeat; background-size:100% 100%;}
		.product_list_box ul li{width:23%;margin: 0 1% 2%;}
		.pro_cont .lazyload{background-color: transparent;}
		.product_list_box ul li a{display: block;width: 100%; padding-top:151%;}
		.product_list_box ul li:nth-of-type(5) a,.product_list_box ul li:nth-of-type(6) a,.product_list_box ul li:nth-of-type(7) a,.product_list_box ul li:nth-of-type(8) a{padding-top:141%;}
		.product_list_box ul li img{max-width: 100%; height: auto;}
		.banner_top8{width: 100%; height:auto; padding: 0 0 30px; margin:-.05em 0 0;background: url(${APP_PATH }/static/pc/img/friday/hg_02.jpg) no-repeat top center; background-size:cover;}
        .top_bg{width: 100%; height: 36px; margin-bottom: -.1rem; background: url(${APP_PATH }/static/pc/img/friday/bg_03.png) no-repeat; background-size:100% 100%;}
		.bot_bg{width: 100%; height: 36px;margin-top: -.1rem; background: url(${APP_PATH }/static/pc/img/friday/bg_06.png) no-repeat; background-size:100% 100%;}
        .box_img{width: 100%; height: auto; margin: 0 auto; text-align: center; padding: 30px 0 0;}
        .box_img img{max-width: 100%; display: inline-block;}
        .banner_pd10{padding: 20px 0 0;}
		.banner_pd10 img{padding: 0 0 20px;}
		.bg_tp{width: 100%;clear: both;margin-top:-.03em;}
		.banner_top7{width:100%; height:auto; padding: 0 0 20px; background: url(${APP_PATH }/static/pc/img/friday/dbg.jpg) no-repeat top center; background-size:100% 100%;}
		.banner_top7cont{width:1040px;display: flex;align-items: flex-start;margin: 0 auto;}
		.pro_cont{width: 50%; position:relative;}
		@media only screen and (max-width: 1366px) { 
			.product_list_box{width: 100%;padding: 0 5%;}
		}
		@media only screen and (max-width:1200px) {
			.banner_top7cont{width:100%;padding: 0 5%;}
		}
		@media only screen and (max-width: 780px) {
			.product_list_box ul li{width:48%;; margin: 0 1% 2%;}
			.top_bg{width: 100%; height: 16px; background: url(${APP_PATH }/static/pc/img/friday/bg_03.png) no-repeat; background-size:100% 100%;}
			.bot_bg{width: 100%; height: 16px;background: url(${APP_PATH }/static/pc/img/friday/bg_06.png) no-repeat;background-size:100% 100%;}
		}
		@media only screen and (max-width: 575px) {
			.bg_tp .wap{display: block;opacity: 1;visibility: visible; position:relative;}
			.black-banner .wap{padding-top: 58%;} 
			.banner_top2 .wap{padding-top: 49.3%;}
			.banner_top3 .wap{padding-top: 52%;}
			.banner_top4 .wap{padding-top: 39.4%;}
			.banner_top5 .wap{padding-top: 39.4%;}
			.banner_top6 .wap{padding-top: 40.9%;}
			.banner_top9 .wap{padding-top: 58.00%;}
			.pro_cont .wap{padding-top: 117.272%;}
			.box_img .pc{display:none}
		}
		@media only screen and (min-width: 576px) {
			.bg_tp .pc{display: block;opacity: 1;visibility: visible;}
			.black-banner .pc{padding-top: 36.458%}
			.banner_top2 .pc{padding-top: 27.5%;}
			.banner_top3 .pc{padding-top:30.156%;}
			.banner_top4 .pc{padding-top:24.322%;}
			.banner_top5 .pc{padding-top:24.322%;}
			.banner_top6 .pc{padding-top:24.635%;}
			.banner_top9 .pc{padding-top:32.8%;}
			.pro_cont .pc{padding-top:104.6153%;}
			.box_img .wap{display:none}
		}
	</style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="black-banner"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_01.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_01.jpg"></div></div>
		<div class="bg_tp banner_top2"><a class="wap lazyload" href="javascript:;" data-src="${APP_PATH }/static/pc/img/friday/sjhw_02.jpg"></a><a class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_02.jpg"></a></div>
		<div class="bg_tp banner_top3"><a class="wap lazyload" href="javascript:;"  data-src="${APP_PATH }/static/pc/img/friday/sjhw_03.jpg"></a><a class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_04.jpg"></a></div>
		<div class="bg_tp banner_top4"><a class="wap lazyload" href="${APP_PATH }/B-13x4-Straight-Transparent-Lace-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/sjhw_04.jpg"></a><a class="pc lazyload" href="${APP_PATH }/B-13x4-Straight-Transparent-Lace-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/hw_05.jpg"></a></div>
		<div class="bg_tp banner_top5"><a class="wap lazyload" href="${APP_PATH }/B-13x4-Straight-Wave-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/sjhw_05.jpg"></a><a class="pc lazyload" href="${APP_PATH }/B-13x4-Straight-Wave-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/hw_06.jpg"></a></div>
		<div class="bg_tp banner_top6"><a class="wap lazyload" href="${APP_PATH }/B-360-Body-Wave-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/sjhw_06.jpg"></a><a class="pc lazyload" href="${APP_PATH }/B-360-Body-Wave-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/hw_07.jpg"></a></div>
		<div class="bg_tp banner_top7">
			<div class="banner_top7cont">
				<div class="pro_cont left_pro">
					<a class="wap lazyload" href="${APP_PATH }/B-44-Piano-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/twl.png"></a>
					<a class="pc lazyload" href="${APP_PATH }/B-44-Piano-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/tw_03.png"></a>
				</div>
				<div class="pro_cont right_pro">
					<a class="wap lazyload" href="${APP_PATH }/Natural-Color-13x4-Bob-Straight-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/twr.png"></a>
					<a class="pc lazyload" href="${APP_PATH }/Natural-Color-13x4-Bob-Straight-Wig.html" data-src="${APP_PATH }/static/pc/img/friday/tw_04.png"></a>
				</div>
			</div>
		</div>
		<div class="banner_top8">
			<div class="product_list_box product_list_box_1">
				<div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp01.jpg" href="${APP_PATH }/B-13x4-Full-Wave-Lace-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp02.jpg" href="${APP_PATH }/B-13x4-613-Straight-Body-Wave-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp03.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp04.jpg" href="${APP_PATH }/B-4x4-Body-Wave-Wig.html"></a></li>
				</ul>
				<div class="bot_bg"></div>
			</div>
			<div class="box_img"><img class="wap" src="${APP_PATH }/static/pc/img/friday/btn_06.png" /><img class="pc" src="${APP_PATH }/static/pc/img/friday/btn_03.png" /></div>
		</div>
		<div class="banner_top8">
			<div class="product_list_box product_list_box_1"><div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp05.jpg" href="${APP_PATH }/Headband-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp06.jpg" href="${APP_PATH }/Body-Wave-Headband-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp07.jpg" href="${APP_PATH }/Water-Wave-Headband-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp08.jpg" href="${APP_PATH }/Jerry-Curly-Headband-Wig.html"></a></li>
				</ul><div class="bot_bg"></div>
			</div>
		</div>
		<div class="bg_tp banner_top9">
			<a class="wap lazyload" href="${APP_PATH }/search/top-selling.html" data-src="${APP_PATH }/static/pc/img/friday/sjhw_12.jpg"></a>
			<a class="pc lazyload" href="${APP_PATH }/search/top-selling.html" data-src="${APP_PATH }/static/pc/img/friday/hw12.jpg"></a>
		</div>
		<div class="banner_top8 banner_pd10">
			<div class="product_list_box product_list_box_1"><div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp10.jpg" href="${APP_PATH }/B-13x4-Full-Texture-Transparent-Lace-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp11.jpg" href="${APP_PATH }/B-360-Straight-Wave-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp12.jpg" href="${APP_PATH }/2x6-Straight-Wave-Bob-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp13.jpg" href="${APP_PATH }/All-Color-4x4-Bob-Wig.html"></a></li>
				</ul>
				<div class="bot_bg"></div>
			</div>
			<div class="box_img"><img class="wap" src="${APP_PATH }/static/pc/img/friday/btn_08.png" /><img class="pc" src="${APP_PATH }/static/pc/img/friday/btn_07.png" /></div>
		</div>
		<div class="banner_top8">
			<div class="product_list_box product_list_box_1"><div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp14.jpg" href="${APP_PATH }/B-3-Bundles-with-4x4-Closure-Straight-Wave.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp15.jpg" href="${APP_PATH }/B-3-Bundles-with-4x4-Closure-Body-Wave.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp16.jpg" href="${APP_PATH }/M-3-Bundles-Body-Wave-Hair-Weave.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp17.jpg" href="${APP_PATH }/M-3-Bundles-Straight-Wave-Hair-Weave.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot18.png" href="${APP_PATH }/search/13x4-Lace-Frontal-Wig.html.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot19.png" href="${APP_PATH }/search/4x4-Closure-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot20.png" href="${APP_PATH }/search/360-Lace-Frontal-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot21.png" href="${APP_PATH }/search/Transparent-Lace-Wig.html"></a></li>
				</ul><div class="bot_bg"></div>
			</div>
		</div>
	<!-- main end -->
	<!-- common script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		new LazyLoad($('main').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	</script>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>