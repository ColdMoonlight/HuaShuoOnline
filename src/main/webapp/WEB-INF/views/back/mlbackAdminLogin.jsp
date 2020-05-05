<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- common css -->
<link href="${APP_PATH }/static/back/css/style.css" rel="stylesheet">
<!-- toastr css -->
<link href="${APP_PATH }/static/common/toastr/toastr.min.css" rel="stylesheet">
<!-- login style  -->
<style>
.c-app { background-color: #f5feff; }
.c-app>.container { width: 1300px; min-height: 100vh; }
.header { width: 100%; height: 78px; margin: 20px 0; }
.header>img, .login-bg>img { display: block; }
.login-box { display: flex; align-items: center; justify-content: center;}
.login-bg>img { width: 100%; }
#reset-password-form, .spinner>.spinner-border { display: none; }
.input-group { margin-bottom: 16px; }
@media screen and (max-width: 1000px) {
	.md-down-none { display: none; }
	.card { width: 60%; margin-bottom: 20px; }
}
</style>
</head>
<body class="c-app">
    <div class="container">
		<div class="header">
			<img src="${APP_PATH }/static/back/img/logo.png" />
		</div>
      	<div class="row login-box">
      		<div class="col-md-8 col-lg-8 login-bg md-down-none">
      			<img src="${APP_PATH }/static/back/img/login-bg.jpg" />
      		</div>
            <div class="card col-md-4 col-lg-4">
            	 <form id="login-form">
		              <div class="card-body">
		                <p class="text-muted">Sign In to your account</p>
		                <div class="input-group">
		                  <span class="input-group-addon">
		                      <svg class="c-icon">
		                        <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-user"></use>
		                      </svg></span>
		                  <input class="form-control" name="adminAccname" type="text" placeholder="Username">
		                </div>
		                <div class="input-group">
		                  <span class="input-group-addon">
		                      <svg class="c-icon">
		                        <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-lock-locked"></use>
		                      </svg></span>
		                  <input class="form-control" name="adminPassword" type="password" placeholder="Password">
		                </div>
		                <div class="row">
		                  <div class="col-sm-6">
		                    <button class="btn btn-primary spinner" type="button" id="back-login">
		                    	<span class="spinner-text">Login</span>
		                    	<span class="spinner-border" role="status" aria-hidden="true"></span>
		                    </button>
		                  </div>
		                  <div class="col-sm-6 text-right">
		                    <button class="btn btn-link px-0" id="change-password" type="button">Change Password</button>
		                  </div>
		                </div>
		              </div>            	 
            	 </form>
            	 <form id="reset-password-form">
            	 	<div class="card-body">
		                <p class="text-muted">Change Your Password</p>
		                <div class="input-group">
		                  <span class="input-group-addon">
		                      <svg class="c-icon">
		                        <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-user"></use>
		                      </svg></span>
		                  <input class="form-control" name="adminAccname" type="text" placeholder="Username">
		                </div>
		                <div class="input-group">
		                  <span class="input-group-addon">
		                      <svg class="c-icon">
		                        <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-lock-locked"></use>
		                      </svg></span>
		                  <input class="form-control" name="adminPassword" type="password" placeholder="Old Password">
		                </div>
		                <div class="input-group">
		                  <span class="input-group-addon">
		                      <svg class="c-icon">
		                        <use xlink:href="${APP_PATH }/static/back/img/svg/free.svg#cil-lock-locked"></use>
		                      </svg></span>
		                  <input class="form-control" name="adminOperatername" type="password" placeholder="New Password">
		                </div>
		                <div class="row">
		                  <div class="col-sm-6">
		                    <button class="btn btn-primary spinner" type="button" id="back-reset">                   	
		                    	<span class="spinner-text">Rseset</span>
		                    	<span class="spinner-border" role="status" aria-hidden="true"></span>
		                    </button>
		                  </div>
		                  <div class="col-sm-6 text-right">
		                    <button class="btn btn-link px-0" id="go-signin" type="button">Back SignIn</button>
		                  </div>
		                </div>
		              </div> 
            	 </form>
            </div>
      	</div>
      	<div class="footer">
      		<p class="text-center">© 2020-202x MegaLook.com. All rights reserved.</p>
      	</div>
    </div>
	<!-- common script -->
    <script src="${APP_PATH }/static/common/jquery.min.js"></script>
    <script src="${APP_PATH }/static/common/toastr/toastr.min.js"></script>
    <script src="${APP_PATH }/static/back/js/main.js"></script>
    <!-- custom script -->
    <script>
 		$('#back-login').on('click', function(e) {
 			var self = this;
 			showSpinner(self);
	    	var data = $('#login-form').serializeArray().reduce(function(acc, item) {acc[item.name] = item.value; return acc;}, {});
		   $.ajax({
		        url: "${APP_PATH }/MlbackAdmin/CheakAdminUser",
		        type: "post",
		        dataType: "json",
		        contentType: 'application/json',
		        data: JSON.stringify(data),
		        success: function (data) {
		          	if (data.code == 100) {
		            	toastr.success(data.extend.resMsg + ', 稍后将进行跳转');
		          	} else {
		          		toastr.error(data.extend.resMsg);
		          	}
		        },
		        error: function() {
		        	toastr.error('登录失败，请重新登录！');
		        },
		        complete: function() {
		        	hideSpinner(self);
		        }
		    });
 		});
 		$('#back-reset').on('click', function(e) {
 			var self = this;
 			showSpinner(self);
	    	var data = $('#reset-password-form').serializeArray().reduce(function(acc, item) {acc[item.name] = item.value; return acc;}, {});
		    $.ajax({
		        url: "${APP_PATH }/MlbackAdmin/UpdateAdminUserInfo",
		        type: "post",
		        dataType: "json",
		        contentType: 'application/json',
		        data: JSON.stringify(data),
		        success: function (data) {
		          	if (data.code == 100) {
		            	toastr.success(data.extend.resMsg + ', 请点击下方返回登录按钮重新登录');
		          	} else {
		          		toastr.error(data.extend.resMsg);
		          	}
		        },
		        error: function() {
		        	toastr.error('修改密码失败，请重新提交！');
		        },
		        complete: function() {
		        	hideSpinner(self);
		        }
		    });
 		});
 		$('#change-password').on('click', function(e) {
 			$('#login-form').slideUp();
 			$('#reset-password-form').slideDown();
 		});
 		$('#go-signin').on('click', function(e) {
 			$('#login-form').slideDown();
 			$('#reset-password-form').slideUp();
 		});
    </script>
  </body>
</html>