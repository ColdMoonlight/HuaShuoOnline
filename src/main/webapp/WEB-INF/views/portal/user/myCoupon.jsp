<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>My Coupon</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 575px) { main { margin: 0; } }
	</style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="usercenter-back"><a href="javascript:goToUserCenter();"><span class="icon left"></span>Back</a></div>
			<div class="usercoupon-list"></div>
		</div>
	</main>
	<!-- common script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		function getMyCouponData(callback) {
			$.ajax({
				url: "${APP_PATH}/MlbackCoupon/getOneMlbackCouponDetailByUId",
				type: 'post',
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100 && data.extend.userType) {
						callback && callback(data.extend.mlbackCouponReturnList);
					} else {
						sysModalTip();
					}
				},
				error: function(err) {
					sysModalTip();
				}
			})
		}
		function renderMyCouponData (data) {
			var html = '';
			data.length ? data.forEach(function(item, idx) {
				html += '<div class="usercoupon-item">' +
						'<div class="coupon-text">' +
							'<div class="coupon-price">$' + item.couponPrice + '</div>' +
							'<div class="coupon-name">' + item.couponName + '</div>' +
							'<div class="coupon-status">' + (item.couponStatus ? 'You can use' : 'Has the failure') + '</div>' +
						'</div>' +
						'<div class="coupon-code">' + item.couponCode + '</div>' +
					'</div>';
			}) : html = '<p class="usercoupon-tip">There are no coupons yet...<p>';
			$('.usercoupon-list').html(html);
		}
		getMyCouponData(renderMyCouponData);
	</script>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
</body>
</html>