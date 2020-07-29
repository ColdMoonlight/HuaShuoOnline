<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>User Center</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/ad.jsp" flush="true"></jsp:include>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="usercenter-title">Personal Center</div>
			<div class="usercenter-body">
				<jsp:include page="usercenter-nav.jsp" flush="true"></jsp:include>
				<div class="usercenter-content">
					<div class="usercenter-profile"></div>
					<div class="usercenter-hi">
						<div class="usercenter-tip">Welcome</div>
						<div class="usercenter-name"></div>
					</div>
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