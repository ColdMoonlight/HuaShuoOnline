<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>My Coupon</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="usercenter-body">
				<jsp:include page="usercenter-nav.jsp" flush="true"></jsp:include>
				<div class="usercenter-content">
					<div class="usercoupon-list"></div>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
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
		$('.usercenter-list .usercenter-item').eq(2).addClass('active');
		getMyCouponData(renderMyCouponData);
	</script>
</body>
</html>