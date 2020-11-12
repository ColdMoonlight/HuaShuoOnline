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
		.product_list_box ul li{width:23%;margin: 0 1% 2%; background: ;}
		.product_list_box ul li .lazyload{background-color: transparent;}
		.product_list_box ul li a{display: block;width: 100%; padding-top:151%;}
		.product_list_box ul li img{max-width: 100%; height: auto;}
		.banner_top8{width: 100%; height:auto; padding: 0 0 30px; margin:0;background: url(${APP_PATH }/static/pc/img/friday/hg_02.jpg) no-repeat top center; background-size:100% 100%;}
        .top_bg{width: 100%; height: 36px; background: url(${APP_PATH }/static/pc/img/friday/bg_03.png) no-repeat; background-size:100% 100%;}
		.bot_bg{width: 100%; height: 36px;background: url(${APP_PATH }/static/pc/img/friday/bg_06.png) no-repeat; background-size:100% 100%;}
        .box_img{width: 100%; height: auto; margin: 0 auto; text-align: center; padding: 30px 0 0;}
        .box_img img{max-width: 100%; display: inline-block;}
        .banner_pd10{padding: 20px 0 0;}
		.banner_pd10 img{padding: 0 0 20px;}
		.bg_tp{width: 100%;clear: both;}
		@media only screen and (max-width: 1366px) { 
			.product_list_box{width: 100%;padding: 0 5%;}
		}
		@media only screen and (max-width: 780px) {
			.product_list_box ul li{width:48%;; margin: 0 1% 2%;}
			.top_bg{width: 100%; height: 16px; background: url(${APP_PATH }/static/pc/img/friday/bg_03.png) no-repeat; background-size:100% 16px;}
			.bot_bg{width: 100%; height: 16px;background: url(${APP_PATH }/static/pc/img/friday/bg_06.png) no-repeat; background-size:100% 16px;}
		}
		@media only screen and (max-width: 575px) {
			.black-banner .wap{display: block;opacity: 1;visibility: visible;padding-top: 58%;} 
			.banner_top2 .wap{display: block;opacity: 1;visibility: visible;padding-top: 49.3%;}
			.banner_top3 .wap{display: block;opacity: 1;visibility: visible;padding-top: 52%;}
			.banner_top4 .wap{display: block;opacity: 1;visibility: visible;padding-top: 39.4%;}
			.banner_top5 .wap{display: block;opacity: 1;visibility: visible;padding-top: 39.4%;}
			.banner_top6 .wap{display: block;opacity: 1;visibility: visible;padding-top: 40.9%;}
			.banner_top7 .wap{display: block;opacity: 1;visibility: visible;padding-top: 66%;}
			.banner_top9 .wap{display: block;opacity: 1;visibility: visible;padding-top: 58.00%;}
			.box_img .pc{display:none}
			/* .banner_top8 .wap{display: block;opacity: 1;visibility: visible;padding-top: 11.866%;} */
		}
		@media only screen and (min-width: 576px) {
			.black-banner .pc{;display: block;opacity: 1;visibility: visible;padding-top: 36.458%}
			.banner_top2 .pc{display: block;opacity: 1;visibility: visible;padding-top: 27.5%;}
			.banner_top3 .pc{display: block;opacity: 1;visibility: visible;padding-top:30.156%;}
			.banner_top4 .pc{display: block;opacity: 1;visibility: visible;padding-top:24.322%;}
			.banner_top5 .pc{display: block;opacity: 1;visibility: visible;padding-top:24.322%;}
			.banner_top6 .pc{display: block;opacity: 1;visibility: visible;padding-top:24.635%;}
			.banner_top7 .pc{display: block;opacity: 1;visibility: visible;padding-top:37.083%;}
			.banner_top9 .pc{display: block;opacity: 1;visibility: visible;padding-top:32.8%;}
			.box_img .wap{display:none}
			
			
			/* .banner_top8 .pc{display: block;opacity: 1;visibility: visible;padding-top:6.979%;} */
		}
	</style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="black-banner"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_01.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_01.jpg"></div></div>
		<div class="bg_tp banner_top2"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_02.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_02.jpg"></div></div>
		<div class="bg_tp banner_top3"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_03.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_04.jpg"></div></div>
		<div class="bg_tp banner_top4"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_04.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_05.jpg"></div></div>
		<div class="bg_tp banner_top5"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_05.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_06.jpg"></div></div>
		<div class="bg_tp banner_top6"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_06.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_07.jpg"></div></div>
		<div class="bg_tp banner_top7"><div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_07.jpg"></div><div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw_08.jpg"></div></div>
		<div class="banner_top8">
			<div class="product_list_box product_list_box_1">
				<div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp01.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp02.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp03.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp04.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
				</ul>
				<div class="bot_bg"></div>
			</div>
			<div class="box_img"><img class="wap" src="${APP_PATH }/static/pc/img/friday/btn_06.png" /><img class="pc" src="${APP_PATH }/static/pc/img/friday/btn_03.png" /></div>
		</div>
		<div class="banner_top8">
			<div class="product_list_box product_list_box_1">
				<div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp05.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp06.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp07.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp08.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
				</ul>
				<div class="bot_bg"></div>
			</div>
		</div>
		<div class="banner_top9">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/friday/sjhw_12.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/friday/hw12.jpg"></div>
		</div>
		<div class="banner_top8 banner_pd10">
			<div class="product_list_box product_list_box_1">
				<div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp10.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp11.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp12.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp13.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
				</ul>
				<div class="bot_bg"></div>
			</div>
			<div class="box_img"><img class="wap" src="${APP_PATH }/static/pc/img/friday/btn_08.png" /><img class="pc" src="${APP_PATH }/static/pc/img/friday/btn_07.png" /></div>
		</div>
		<div class="banner_top8">
			<div class="product_list_box product_list_box_1">
				<div class="top_bg"></div>
				<ul>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp14.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp15.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp16.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/cp17.jpg" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot18.png" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot19.png" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot20.png" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
					<li><a class="lazyload" data-src="${APP_PATH }/static/pc/img/friday/bot21.png" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html"></a></li>
				</ul>
				<div class="bot_bg"></div>
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