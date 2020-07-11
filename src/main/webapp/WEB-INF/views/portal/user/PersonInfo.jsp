<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Personal Info</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
	<style>
		@media only screen and (max-width: 575px) {
			main { margin: -1rem 0 0 0; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="usercenter-back"><a href="javascript:goToUserCenter();"><span class="icon left"></span>Back</a></div>
			<div class="usercenter-list user-personinfo">
				<div class="usercenter-item" data-name="username">
					<div class="text">User Name</div>
					<div class="right-data">
						<span class="username input-data empty">please add</span>
						<span class="icon right"></span>
					</div>
				</div>
				<div class="usercenter-item" data-name="useremail">
					<div class="text">E-mail</div>
					<div class="right-data">
						<span class="useremail input-data empty">please add</span>
						<span class="icon right"></span>
					</div>
				</div>
				<div class="usercenter-item" data-name="usertelephone">
					<div class="text">Telephone</div>
					<div class="right-data">
						<span class="usertelephone input-data empty">please add</span>
						<span class="icon right"></span>
					</div>
				</div>
				<div class="usercenter-item" data-name="userpassword">
					<div class="text">Password</div>
					<div class="right-data">
						<span class="userpassword input-data empty">please add</span>
						<span class="icon right"></span>
					</div>
				</div>
				<div class="usercenter-item" data-name="useraddress">
					<div class="text">Address</div>
					<div class="right-data">
						<span class="useraddress input-data empty">please add</span>
						<span class="icon right"></span>
					</div>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<script>
		function getUserInfo(callback) {
			$.ajax({
				url: "${APP_PATH }/MlfrontUser/getLoginUserDetail",
				type: 'post',
				success: function (data) {
					if(data.code == 100){
						callback && callback(data.extend.mlfrontUserOne);
					} else {
						sysModalTip();
					}
				},
				error: function(err) {
					sysModalTip();
				}
			})
		}
		function renderUserInfo(data) {
			
		}
		var userInfoModal;
		getUserInfo(function(data) {
			console.log(data)
		});
		$('.usercenter-item').on('click', function() {
			var usernameHtml = '<div class="input-group">' +
					'<label for="userFirstname">First Name</label>' +
					'<input type="text" id="userFirstname" name="userFirstname" placeholder="please input first name" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="userLastname">Last Name</label>' +
					'<input type="text" id="userLastname" name="userLastname" placeholder="please input last name" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black register"> SUBMIT </a>' +
				'</div>';
			var useremailHtml = '<div class="input-group">' +
					'<label for="userEmail">E-mail</label>' +
					'<input type="email" id="userEmail" name="userEmail" placeholder="please input eamil" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black register"> SUBMIT </a>' +
				'</div>';
			var userpasswordHtml = '<div class="input-group">' +
					'<label for="userPassword">Password</label>' +
					'<input type="text" id="userPassword" name="userPassword" placeholder="please input password" min="6" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black register"> SUBMIT </a>' +
				'</div>';
			var usertelephoneHtml = '<div class="input-group">' +
					'<label for="userTelephone">Telphone</label>' +
					'<input type="text" id="userTelephone" name="userTelephone" placeholder="please input telephone number" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black register"> SUBMIT </a>' +
				'</div>';
			var useraddressHtml = '<div class="input-group">' +
					'<label for="addressCountry">Country</label>' +
					'<input type="text" id="addressCountry" name="addressCountry" placeholder="please input country" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="addressProvince">State/province</label>' +
					'<input type="text" id="addressProvince" name="addressProvince" placeholder="please input province/state" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="addressCity">City</label>' +
					'<input type="text" id="addressCity" name="addressCity" placeholder="please input city" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="addressPost">Zip/Post code</label>' +
					'<input type="text" id="addressPost" name="addressProvince" placeholder="please input province/state" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black register"> SUBMIT </a>' +
				'</div>';
			var self = this;
			var mapHtml = {
					username: usernameHtml,
					useremail: useremailHtml,
					userpassword: userpasswordHtml,
					usertelephone: usertelephoneHtml,
					useraddress: useraddressHtml,
			}
			console.log(mapHtml[$(self).data('name')]);
			userInfoModal = createModal({
				header: {
					html: '<p>add/update user info...</p>'
				},
    			body: {
    				html: mapHtml[$(self).data('name')],
    			}
			});
			userInfoModal.addClass('userinfo-modal');
		});
	</script>
</body>
</html>