<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Customer Voice</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) {
			main { margin: -1rem 0 0 0; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="video-banner">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-banner.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-banner.jpg"></div>
		</div>
		<!-- video discount -->
		<div class="video-dicount">			
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
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		new LazyLoad($('main').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
		$(document.body).on('click', '.video-recommend-item', function() {
			var productId = $(this).data('id');
			var videoLink = $(this).data('video');
			productId && getOneProductData({ "productId": productId }, function(data) {
				var videoRecommendHtml = '<div class="video-recommend">'+
						'<div class="video-recommend-img"><iframe frameborder="0" allowfullscreen="1" allow="autoplay; encrypted-media" title="YouTube video player" width="100%" height="300" src="'+ videoLink +'"></iframe></div>'+
						'<div class="video-recommend-name">'+ data.productName +'</div>'+
						'<div class="video-recommend-dprice"><span class="">Regular Price :</span><span class="value">$'+ data.productOriginalprice +'</span></div>'+
						'<div class="video-recommend-nprice"><span class="name">Sale Price :</span><span class="value">$'+ (data.productOriginalprice && data.productActoffoff ? (data.productOriginalprice * data.productActoffoff / 100).toFixed(2) : 0) +'</span></div>'+
						'<a class="btn btn-pink" href="'+ (data.productSeo ? ('${APP_PATH}/' + data.productSeo +'.html') : 'jvascrtip:;') +'">Buy Now</a>'+
					'</div>';
				var videoRecommendModal = createModal({
					header: {
						html: '<p>Hot Video Recommend...</p>'
					},
					body: {
						html: videoRecommendHtml
					}
				});
			});
		})
	</script>
</body>
</html>