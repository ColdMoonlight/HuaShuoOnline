<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>User Center</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
	<style>
		@media only screen and (max-width: 575px) {
			main { margin: 0; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="usercenter-title">Personal Center</div>
			<div class="usercenter-body">
				<div class="usercenter-profile">
					<div class="usercenter-name"></div>
					<div class="usercenter-tip">Welcome</div>
				</div>
				<div class="usercenter-list">
					<a class="usercenter-item" href="javascript:goToUserCenerOrder();">
						<span class="icon order"></span>
						<span class="text">My Order</span>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item" href="javascript:goToCartList();">
						<span class="icon cart"></span>
						<span class="text">Shopping Cart</span>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item" href="javascript:goToUserCenerCoupon();">
						<span class="icon coupon"></span>
						<span class="text">Coupon</span>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item" href="javascript:goToUserCenerPersonal();">
						<span class="icon card"></span>
						<span class="text">Personal Info</span>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item">
						<span class="icon data"></span>
						<span class="text">Integral Details</span>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item">
						<span class="icon more"></span>
						<span class="text">More</span>
						<span class="icon right"></span>
					</a>
					<a id="logout" class="usercenter-item">
						<span class="icon logout"></span>
						<span class="text">Drop Out</span>
						<span class="icon right"></span>
					</a>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<script>
	function addUserInfo() {
		var firstname = '${sessionScope.loginUser.userFirstname}',
			lastname = '${sessionScope.loginUser.userLastname}',
			userEmail = '${sessionScope.loginUser.userEmail}';
		if (firstname && lastname) {
			$(".usercenter-name").html(firstname + ' ' + lastname);
		} else if (userEmail) {
			$(".usercenter-name").html(userEmail);
		} else {
			$(".usercenter-name").html('Customer');
		}
	}
	addUserInfo();
	$('#logout').on('click', function () {
		$.ajax({
			url: "${APP_PATH }/MlfrontUser/exit",
			type: 'POST',
			success: function (data) {
				if (data.code == 100 && data.extend.exitInt == 0) {
					window.location.href = "${APP_PATH }";
				} else {
					mlModalTip('Logout failed, please try again later!');					
				}
			},
			error: function(err) {
				mlModalTip('Logout failed, please try again later!');
			}
		})
	});
	</script>
</body>
</html>