<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Video Area List</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin: -1rem 0 0 0; } }
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<!-- video list -->
		<div class="video-list"></div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		function renderTwoVideoData(videoLink, urlName, urlLink) {
			var videoHtml = '<div class="video-box">'+
					'<iframe frameborder="0" allowfullscreen="1" allow="autoplay; encrypted-media" title="YouTube video player" src="'+ videoLink +'"></iframe>'+
					'<div class="video-box-data">' +
						'<div class="video-box-name">'+ urlName +'</div>'+
						'<a class="btn btn-pink" href="'+ urlLink +'">See It</a>'+
					'</div>'+
				'</div>';
			var videoHotModal = createModal({
				header: {
					html: '<p>Hot Video...</p>'
				},
				body: {
					html: videoHtml
				}
			});
		}
		function getVideoAreaData(num, callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackVideo/getMlbackVideoListByVideoArea',
				data: JSON.stringify({
					"videoArea": num
				}),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function(data) {
					if (data.code == 100) {
						callback && callback(data.extend.mlbackVideoList);
					} else {
						sysModalTip();
					}
				},
				error: function() {
					sysModalTip();
				}
			});
		}
		function renderVideoArea($el, data) {
			var htmlStr = '';
			data.forEach(function(item, idx) {
				var itemName, itemSeo, itemLink;
				if (item.videoIfproorcateorpage == 0) {
					itemSeo = item.videoProname;
					itemName = item.videoSeoname;
				}
				// collection
				if (item.videoIfproorcateorpage == 1) {
					itemSeo = 'search/' + item.videoCateseoname;
					itemName = item.videoCatename;
				}
				// subject
				if (item.videoIfproorcateorpage == 2) {
					itemSeo = item.videoPageseoname;
					itemName = item.videoPagename;
				}
				itemLink = itemSeo ? itemSeo + '.html' : 'javascript:;';
				htmlStr += '<div class="video-list-item shadow-radius" data-tag="'+ item.videoIfproorcateorpage +'" data-id="'+ item.videoProid +'" data-name="'+ itemName +'" data-link="'+ itemLink +'" data-video="'+ item.videoUrl +'">' +
						'<div class="video-list-item-img lazyload" data-src="'+ item.videoImgurl +'"></div>' +
						'<div class="video-list-item-name">'+ item.videoName +'</div>' +
					'</div>';
			});
			$el.html(htmlStr);
		}
		getVideoAreaData('${sessionScope.videoArea}', function(data) {
			var $el = $('.video-list');
			data.length && renderVideoArea($el, data);
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
		$(document.body).on('click', '.video-list-item', function() {
			var tag = $(this).data('tag');
			var productId = $(this).data('id');
			var videoLink = $(this).data('video');
			var urlLink = $(this).data('link');
			var urlName = $(this).data('name');
			videoLink = videoLink && ('https://www.youtube.com/embed/' + matchYoutubeUrl(videoLink));
			if (tag == 0) {
				productId && getOneProductData({ "productId": productId }, function(data) {
					renderVideoData(data, videoLink);
				});
			} else {
				renderTwoVideoData(videoLink, urlName, urlLink);
			}
		});
		addTidio();
	</script>
</body>
</html>