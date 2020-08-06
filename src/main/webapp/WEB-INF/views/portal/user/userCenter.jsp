<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>User Center</title>
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
			<div class="usercenter-title">Personal Center</div>
			<div class="usercenter-body">
				<div class="usercenter-profile">
					<div class="usercenter-name"></div>
					<div class="usercenter-tip">Welcome</div>
				</div>
				<div class="usercenter-list">
					<a class="usercenter-item" href="javascript:goToUserCenerOrder();">
						<span class="icon order"></span>
						<div class="text">My Order</div>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item" href="javascript:goToCartList();">
						<span class="icon cart"></span>
						<div class="text">Shopping Cart</div>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item" href="javascript:goToUserCenerCoupon();">
						<span class="icon coupon"></span>
						<span class="text">Coupon</span>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item" href="javascript:goToUserCenerPersonal();">
						<span class="icon card"></span>
						<div class="text">Personal Info</div>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item">
						<span class="icon data"></span>
						<div class="text">Integral Details</div>
						<span class="icon right"></span>
					</a>
					<a class="usercenter-item">
						<span class="icon more"></span>
						<div class="text">More</div>
						<span class="icon right"></span>
					</a>
					<a id="logout" class="usercenter-item">
						<span class="icon logout"></span>
						<div class="text">Drop Out</div>
						<span class="icon right"></span>
					</a>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
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
	var loginStatus = checkUserLoginOrNot();
	
	!loginStatus && loginNotTip();
	loginStatus && addUserInfo();
	$('#logout').on('click', function () {
		$.ajax({
			url: "${APP_PATH}/MlfrontUser/exit",
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