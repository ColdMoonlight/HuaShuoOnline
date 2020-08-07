<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
	<title>Customer Voice</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin: -1rem 0 0 0; } }
	</style>
</head>
<body>
	<jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>		
		<div class="container">
			<div class="shop-review-title">
				<div class="left">
					<h3>Customer Reviews</h3>
					<div class="review-toal-num">Based on <span class="data">1868</span> Customer Reviews</div>
					<div class="review-toal-star-list">
						<i class="icon star2"></i>
						<i class="icon star2"></i>
						<i class="icon star2"></i>
						<i class="icon star2"></i>
						<i class="icon star2"></i>
					</div>
				</div>
				<div class="right">
					<div class="review-statics-item five">
						<div class="stars-list">
							<i class="icon star2"></i>
							<i class="icon star2"></i>
							<i class="icon star2"></i>
							<i class="icon star2"></i>
							<i class="icon star2"></i>
						</div>
						<div class="progress">
							<div class="progress-inner" style="width: 93.00%"></div>
						</div>
						<div class="data">93.00%</div>
					</div>
					<div class="review-statics-item four">
						<div class="stars-list">
							<i class="icon star2"></i>
							<i class="icon star2"></i>
							<i class="icon star2"></i>
							<i class="icon star2"></i>
						</div>
						<div class="progress">
							<div class="progress-inner" style="width: 30.00%"></div>
						</div>
						<div class="data">6.00%</div>
					</div>
					<div class="review-statics-item three">
						<div class="stars-list">
							<i class="icon star2"></i>
							<i class="icon star2"></i>
							<i class="icon star2"></i>
						</div>
						<div class="progress">
							<div class="progress-inner" style="width: 5.00%"></div>
						</div>
						<div class="data">1.00%</div>
					</div>
					<div class="review-statics-item two">
						<div class="stars-list">
							<i class="icon star2"></i>
							<i class="icon star2"></i>
						</div>
						<div class="progress">
							<div class="progress-inner" style="width: 0.00%"></div>
						</div>
						<div class="data">0.00%</div>
					</div>
					<div class="review-statics-item one">
						<div class="stars-list">
							<i class="icon star2"></i>
						</div>
						<div class="progress">
							<div class="progress-inner" style="width: 0.00%"></div>
						</div>
						<div class="data">0.00%</div>
					</div>
				</div>
			</div>
			<div class="shop-review-base">Product Reviews(659)</div>
			<!-- ins list -->
			<div class="ins-box">
				<div class="ins-body"></div>
			</div>
		</div>
	</main>
	<!-- third lib -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		function getReviewData(num, callback) {
			$.ajax({
				url: '${APP_PATH}/MlfrontReview/selectReviewListFrom',
				data: JSON.stringify({ "reviewFrom": num }),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend.mlfrontReviewList, data.extend.mlfrontReviewImgList);
					} else {
						sysModalTip();
					}
				},
				error: function () {
					sysModalTip();
				}
			});
		}
		function generateStarEl(num) {
			var htmlStr = '';
			for (var i=0; i<5; i+=1) {
				htmlStr += '<span class="icon '+ ( i < num ? 'star2' : 'star' ) +'"></span>';
			}
			return htmlStr;
		}
		function renderInsReview($el, reviewData, imgData) {
			var htmlStr = '';
			reviewData.forEach(function (item, idx) {
				var itemLink = '${APP_PATH}/' + item.reviewPseoname + '.html';
				htmlStr += '<div class="ins-item shadow-radius">' +
					'<div class="lazyload" data-src="' + (imgData[idx][0] && imgData[idx][0].reviewimgUrl) + '"></div>' +
					'<div class="ins-stars">' + generateStarEl(item.reviewProstarnum) + '</div>' +
					'<div class="ins-details">' + item.reviewDetailstr + '</div>' +
					'<div class="ins-user">by <b>' + item.reviewUname + '</b></div>' +
					'<div class="ins-time">' + item.reviewConfirmtime + '</div>' +
					'<a class="btn btn-black" href="' + itemLink + '">Shop This Look</a>' +
					'</div>';
			});
			$el.html(htmlStr);
		}
		new LazyLoad($('main').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
		getReviewData(1, function (reviewData, imgData) {
			var $el = $('.ins-body');
			reviewData.length && renderInsReview($el, reviewData, imgData);
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		});
	</script>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>