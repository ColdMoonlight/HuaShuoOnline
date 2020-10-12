<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Video</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin: -1rem 0 0 0; } }
	</style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<!-- video banner -->
		<div class="video-banner">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-banner.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-banner.jpg"></div>
		</div>

		<div class="container">
			<!-- video discount -->
			<div class="video-discount">			
				<div class="video-discount-title wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-dis-title.jpg"></div>
				<div class="video-discount-title pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-dis-title.jpg"></div>
				<div class="video-discount-body wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-discount.jpg"></div>
				<div class="video-discount-body pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-discount.png"></div>				
			</div>
			<!-- video recommend -->
			<div class="video-recommend-box">
				<div class="video-recommend-title">
					<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-recommend.jpg"></div>
					<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-recommend.jpg"></div>
				</div>			
				<div class="video-recommend-body">
					<div class="video-recommend-item shadow-radius lazyload" data-id="157" data-video="https://www.youtube.com/embed/zD5dgYYDb08" data-src="${APP_PATH }/static/pc/img/video/pro/vd1.jpg"></div>
					<div class="video-recommend-item shadow-radius lazyload" data-id="109" data-video="https://www.youtube.com/embed/qp91g1hg9nM" data-src="${APP_PATH }/static/pc/img/video/pro/vd2.jpg"></div>
					<div class="video-recommend-item shadow-radius lazyload" data-id="193" data-video="https://www.youtube.com/embed/u9M_pFxuLOA" data-src="${APP_PATH }/static/pc/img/video/pro/vd3.jpg"></div>
					<div class="video-recommend-item shadow-radius lazyload" data-id="84" data-video="https://www.youtube.com/embed/2cJvNAYpI6Y" data-src="${APP_PATH }/static/pc/img/video/pro/vd4.jpg"></div>
					<div class="video-recommend-item shadow-radius lazyload" data-id="110" data-video="https://www.youtube.com/embed/BYgVHjc6P3k" data-src="${APP_PATH }/static/pc/img/video/pro/vd5.jpg"></div>
					<div class="video-recommend-item shadow-radius lazyload" data-id="80" data-video="https://www.youtube.com/embed/TD4mGC5xNcU" data-src="${APP_PATH }/static/pc/img/video/pro/vd6.jpg"></div>
					<div class="video-recommend-item shadow-radius lazyload" data-id="140" data-video="https://www.youtube.com/embed/TD4mGC5xNcU" data-src="${APP_PATH }/static/pc/img/video/pro/vd7.jpg"></div>
					<div class="video-recommend-item shadow-radius lazyload" data-id="251" data-video="https://www.youtube.com/embed/zoZm8cPDLKM" data-src="${APP_PATH }/static/pc/img/video/pro/vd8.jpg"></div>
				</div>
			</div>
			<!-- video collection -->
			<div class="video-collection">
				<div class="video-collection-title">
					<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-collection.jpg"></div>
					<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-collection.jpg"></div>
				</div>
				<div class="video-collection-body"></div>
			</div>
			<!-- video top sale -->
			<div class="video-topsale">
				<div class="video-topsale-title">
					<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-top-sale.jpg"></div>
					<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-top-sale.jpg"></div>
				</div>
				<div class="video-topsale-body">
					<div class="video-topsale-style one">
						<div class="video-topsale-style-item">
							<a class="lazyload" href="${APP_PATH }/B-Piano-Color-13x4-Straight-Hair-Wig.html" data-src="${APP_PATH }/static/pc/img/video/pro/c4.jpg"></a>
							<div class="video-topsale-style-name">Piano Color Lace Frontal Wigs</div>
						</div>
						<div class="video-topsale-style-item">
							<a class="lazyload" href="${APP_PATH }/B-360-Body-Wave-Wig.html" data-src="${APP_PATH }/static/pc/img/video/pro/c2.jpg"></a>
							<div class="video-topsale-style-name">360 Lace Frontal Wigs Body Wave</div>					
						</div>
						<div class="video-topsale-style-item">
							<a class="lazyload" href="${APP_PATH }/B-13x4-Straight-Wave-Wig.html" data-src="${APP_PATH }/static/pc/img/video/pro/c1.jpg"></a>
							<div class="video-topsale-style-name">13x4 Lace Frontal Wig Natural Color</div>					
						</div>
						<div class="video-topsale-style-item">
							<a class="lazyload" href="${APP_PATH }/B-13x4-Water-Wave-Wig.html" data-src="${APP_PATH }/static/pc/img/video/pro/c3.jpg"></a>
							<div class="video-topsale-style-name">13x4 Lace Frontal Wig Water Wave Hair</div>					
						</div>
					</div>
					<div class="video-topsale-style two">
						<div class="video-topsale-style-item">
							<a class="lazyload" href="${APP_PATH }/13x4-Bob-Wig-1B-30-Color-Straight-Lace-Wig.html" data-src="${APP_PATH }/static/pc/img/video/pro/cp5.jpg"></a>
							<div class="video-topsale-style-name">13x4 1b/30 Bob Lace Frontal Straight Wig</div>					
						</div>
						<div class="video-topsale-style-item">
							<a class="lazyload" href="${APP_PATH }/All-Color-4x4-Bob-Wig.html" data-src="${APP_PATH }/static/pc/img/video/pro/cp6.jpg"></a>
							<div class="video-topsale-style-name">4x4 Bob Wigs All Color Straight Hair</div>					
						</div>
						<div class="video-topsale-style-item">
							<a class="lazyload" href="${APP_PATH }/2x6-Straight-Wave-Bob-Wig.html" data-src="${APP_PATH }/static/pc/img/video/pro/cp7.jpg"></a>
							<div class="video-topsale-style-name">Kim K 2x6 Straight Lace Closure Bob Wig</div>					
						</div>
					</div>
				</div>
			</div>
		</div>
	<!-- main end -->
	<!-- common script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		function getVideoCollectionData(num, callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackVideoShowArea/getMlbackVideoShowAreawapListByArea',
				data: JSON.stringify({
					"videoshowareaAreanum": num
				}),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function(data) {
					if (data.code == 100) {
						callback && callback(data.extend.mlbackVideoShowAreaList, data.extend.videoNumByAreaListList);
					} else {
						sysModalTip();
					}
				},
				error: function() {
					sysModalTip();
				}
			});
		}
		function renderVideoArea($el, videoData, numData) {
			var htmlStr = '';
			videoData.forEach(function(item, idx) {
				var itemLink = '${APP_PATH}/MlbackVideo/toVideoAreaPage?videoArea='+ item.videoshowareaId;
				htmlStr += '<div class="video-area-item">' +
						'<a class="lazyload wap" href="'+ itemLink +'" data-src="'+ item.videoshowareaWapimgurl +'"></a>' +
						'<a class="lazyload pc" href="'+ itemLink +'" data-src="'+ item.videoshowareaPcimgurl +'"></a>' +
						'<div class="video-areaitem-content">' +
							'<a class="video-areaitem-name" href="'+ itemLink +'">'+ item.videoshowareaName +'</a>' +
							'<div class="video-areaitem">('+ numData[idx] +')</div>' +
						'</div>' +
					'</div>';
			});
			$el.html(htmlStr);
		}
		new LazyLoad($('main').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
		getVideoCollectionData(2, function(videoData, numData) {
			var $el = $('.video-collection-body');
			videoData.length && renderVideoArea($el, videoData, numData);
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
		$(document.body).on('click', '.video-recommend-item', function() {
			var productId = $(this).data('id');
			var videoLink = $(this).data('video');
			productId && getOneProductData({ "productId": productId }, function(data) {
				renderVideoData(data, videoLink);
			});
		});
	</script>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>