<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Personal Info</title>
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
					<div class="user-personinfo">
						<div class="usercenter-item" data-name="username">
							<div class="text">User Name</div>
							<div class="right-data">
								<input class="username input-data empty" disabled placeholder="please add">
								<span class="icon right"></span>
							</div>
						</div>
						<div class="usercenter-item" data-name="useremail">
							<div class="text">E-mail</div>
							<div class="right-data">
								<input class="useremail input-data empty" disabled placeholder="please add">
								<span class="icon right"></span>
							</div>
						</div>
						<div class="usercenter-item" data-name="usertelephone">
							<div class="text">Telephone</div>
							<div class="right-data">
								<input class="usertelephone input-data empty" disabled placeholder="please add">
								<span class="icon right"></span>
							</div>
						</div>
						<div class="usercenter-item" data-name="userpassword">
							<div class="text">Password</div>
							<div class="right-data">
								<input class="userpassword input-data empty" disabled placeholder="please add">
								<span class="icon right"></span>
							</div>
						</div>
						<div class="usercenter-item" data-name="useraddress">
							<div class="text">Address</div>
							<div class="right-data">
								<input class="useraddress input-data empty" disabled placeholder="please add">
								<span class="icon right"></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		function getUserInfo(callback) {
			$.ajax({
				url: "${APP_PATH }/MlfrontUser/getLoginUserDetail",
				dataType: 'json',
				contentType: 'application/json',
				type: "post",
				async: false,
				success: function (data) {
					if(data.code == 100){
						callback && callback(data.extend.mlfrontUserOne);
					} else {
						sysModalTip();
						setTimeout(goToIndex, 2000);
					}
				},
				error: function(err) {
					sysModalTip();
					setTimeout(goToIndex, 2000);
				}
			})
		}
		function renderUserInfo(data) {
			if (data.userFirstname && data.userLastname) {
				$('.username').val(data.userLastname + ' ' + data.userFirstname)
			}
			if (data.userEmail) {
				$('.useremail').val(data.userEmail)
			}
			if (data.userTelephone) {
				$('.usertelephone').val(data.userTelephone);
			}
			if (data.userPassword) {
				$('.userpassword').val(data.userPassword);
			}
			if (data.userAddressCountry && data.userAddressProvince) {
				$('.useraddress').val(data.userAddressCountry + ' ' + data.userAddressProvince);
			}
		}
		function initFormData($el) {
			$el.each(function(idx, item) {
				$(item).val(userData[item.name]);
			});
		}
		function updateUserInfo(reqData, callback) {
			$.ajax({
				url: "${APP_PATH }/MlfrontUser/update",
				type: 'post',
				data: JSON.stringify(reqData),
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code === 100) {
						var timer = null;
						callback && callback();
					} else {
						sysModalTip();
					}
				},
				error: function() {
					sysModalTip();
				}
			})
		}
		function checkUserInput($el) {
			var flag = true;
			$el.each(function(idx, item) {
				var val = $(item).val();
				if (item.name == 'userEmail') {
					if (!val || !emailPattern.test(val)) {
						mlModalTip('It is illegal to enter an email address !');
						flag = false;
					}
				} else {
					if (!val.trim()) {
						mlModalTip('<b>'+ item.name +'</b> cannot be empty !')
						flag = false;
					}
				}				
			});
			return flag;			
		}
		function resetUserData($el) {
			$el.each(function(idx, item) {
				userData[item.name] = $(item).val();
			});
		}
		var userInfoModal, userData;
		$('.usercenter-list .usercenter-item').eq(3).addClass('active');
		getUserInfo(function(data) {
			userData = data;
			renderUserInfo(data);
		});
		$('.user-personinfo .usercenter-item').on('click', function() {
			var usernameHtml = '<div class="input-group">' +
					'<label for="userFirstname">First Name</label>' +
					'<input type="text" id="userFirstname" name="userFirstname" placeholder="please input first name" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="userLastname">Last Name</label>' +
					'<input type="text" id="userLastname" name="userLastname" placeholder="please input last name" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black user-update"> SUBMIT </a>' +
				'</div>';
			var useremailHtml = '<div class="input-group">' +
					'<label for="userEmail">E-mail</label>' +
					'<input type="email" id="userEmail" name="userEmail" placeholder="please input eamil" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black user-update"> SUBMIT </a>' +
				'</div>';
			var userpasswordHtml = '<div class="input-group">' +
					'<label for="userPassword">Password</label>' +
					'<input type="text" id="userPassword" name="userPassword" placeholder="please input password" min="6" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black user-update"> SUBMIT </a>' +
				'</div>';
			var usertelephoneHtml = '<div class="input-group">' +
					'<label for="userTelephone">Telphone</label>' +
					'<input type="text" id="userTelephone" name="userTelephone" placeholder="please input telephone number" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black user-update"> SUBMIT </a>' +
				'</div>';
			var useraddressHtml = '<div class="input-group">' +
					'<label for="userAddressCountry">Country</label>' +
					'<input type="text" id="userAddressCountry" name="userAddressCountry" placeholder="please input country" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="userAddressProvince">State/province</label>' +
					'<input type="text" id="userAddressProvince" name="userAddressProvince" placeholder="please input province/state" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="userAddressCity">City</label>' +
					'<input type="text" id="userAddressCity" name="userAddressCity" placeholder="please input city" required>' +
				'</div>' +
				'<div class="input-group">' +
					'<label for="userAddressPostalcode">Zip/Post code</label>' +
					'<input type="text" id="userAddressPostalcode" name="userAddressPostalcode" placeholder="please input province/state" required>' +
				'</div>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black user-update"> SUBMIT </a>' +
				'</div>';
			var self = this;
			var mapHtml = {
					username: usernameHtml,
					useremail: useremailHtml,
					userpassword: userpasswordHtml,
					usertelephone: usertelephoneHtml,
					useraddress: useraddressHtml,
			}
			userInfoModal = createModal({
				header: {
					html: '<p>add/update user info...</p>'
				},
    			body: {
    				html: mapHtml[$(self).data('name')],
    			}
			});
			userInfoModal.addClass('userinfo-modal');
			initFormData($('.userinfo-modal input'));
		});
		// update user info
		$(document.body).on('click', '.user-update', function() {
			var flag = checkUserInput($('.userinfo-modal input'));
			flag && (resetUserData($('.userinfo-modal input')), updateUserInfo(userData, function() {
				mlModalTip('Updae user info successfully.');
				renderUserInfo(userData);
				setTimeout(function() {
					removeModal(userInfoModal);
				}, 2000);
			}));
		});
	</script>
</body>
</html>