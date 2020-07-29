<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Customer Voice</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/ad.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) {
			main { margin: -1rem 0 0 0; }
		}
		@media only screen and (max-width: 1078px) and (min-width: 576px) {
			main { margin: -1rem 0 0 0; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="ins-banner">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/ins/wap-banner.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/ins/pc-banner.jpg"></div>
		</div>
		<!-- ins list -->
		<div class="ins-box">
			<div class="ins-title">
				<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/ins/wap-title.jpg"></div>
				<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/ins/pc-title.jpg"></div>
			</div>			
			<div class="ins-body"></div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script src="${APP_PATH }/static/pc/js/masonry.min.js"></script>
	<script>
		function getReviewData(num, callback) {
			$.ajax({
				url: '${APP_PATH}/MlfrontReview/selectReviewListFrom',
				data: JSON.stringify({
					"reviewFrom": num
				}),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function(data) {
					if (data.code == 100) {
						callback && callback(data.extend.mlfrontReviewList, data.extend.mlfrontReviewImgList);
					} else {
						sysModalTip();
					}
				},
				error: function() {
					sysModalTip();
				}
			});
		}
		function renderInsReview($el, reviewData, imgData) {
			var htmlStr = '';
			reviewData.forEach(function(item, idx) {
				var itemLink = '${APP_PATH}/' + item.reviewPseoname +'.html';
				htmlStr += '<div class="ins-item shadow-radius">' +
						'<div class="lazyload" data-src="'+ (imgData[idx][0] && imgData[idx][0].reviewimgUrl) +'"></div>' +
						'<div class="ins-details">'+ item.reviewDetailstr +'</div>' +
						'<div class="ins-user">by <b>'+ item.reviewUname +'</b></div>' +
						'<div class="ins-time">'+ item.reviewConfirmtime +'</div>' +
						'<a class="btn btn-black" href="'+ itemLink +'">Shop This Look</a>' +
					'</div>';
			});
			$el.html(htmlStr);
		}
		new LazyLoad($('main').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
		getReviewData(2, function(reviewData, imgData) {
			var $el = $('.ins-body');
			reviewData.length && renderInsReview($el, reviewData, imgData);
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
			// masonry
			$el.masonry({
				itemSelector : '.ins-item',
				isFitWidth: true,
				isRTL:false,
				isResizable: false,
			});
		});
		$(window).on('resize', function() {
			debounce(function() {
				// masonry
				$('.ins-body').masonry({
					itemSelector : '.ins-item',
					isFitWidth: true,
					isRTL:false,
					isResizable: true,
				});
			}, 100);
		});
		addTidio();
	</script>
</body>
</html>