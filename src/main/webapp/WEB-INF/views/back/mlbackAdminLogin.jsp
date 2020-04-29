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
.c-app>.container {
	width: 100%;
	min-height: 100vh;
}
.header {
	width: 100%;
	height: 78px;
	margin: 20px 0;
}
.header>img {
	display: block;
}
.login-bg {
	min-height: 360px;
	margin-top: 50px;
	background: url('${APP_PATH }/static/back/img/login-bg.png') no-repeat;
	background-size: 100% 100%;;
}
</style>
</head>
<body class="c-app">
    <div class="container">
		<div class="header">
			<img src="${APP_PATH }/static/back/img/logo.png" />
		</div>
      	<div class="row align-items-center justify-content-end login-bg">
            <div class="card col-md-5 col-lg-5">
              <div class="card-body">
                <p class="text-muted">Sign In to your account</p>
                <div class="input-group mb-3">
                  <div class="input-group-prepend"><span class="input-group-text">
                      <svg class="c-icon">
                        <use xlink:href="${APP_PATH }/static/back/lib/icons/svg/free.svg#cil-user"></use>
                      </svg></span></div>
                  <input class="form-control" id="username" type="text" placeholder="Username">
                </div>
                <div class="input-group mb-4">
                  <div class="input-group-prepend"><span class="input-group-text">
                      <svg class="c-icon">
                        <use xlink:href="${APP_PATH }/static/back/lib/icons/svg/free.svg#cil-lock-locked"></use>
                      </svg></span></div>
                  <input class="form-control" id="password" type="password" placeholder="Password">
                </div>
                <div class="row">
                  <div class="col-6">
                    <button class="btn btn-primary px-4" type="button" id="backLogin">Login</button>
                  </div>
                  <div class="col-6 text-right">
                    <button class="btn btn-link px-0" type="button">Forgot password?</button>
                  </div>
                </div>
              </div>
            </div>
      	</div>
      	<div class="footer">
      		<p class="text-center">© 2020-202x MegaLook.com. All rights reserved.</p>
      	</div>
    </div>
	<!-- common script -->
    <script src="${APP_PATH }/static/back/lib/icons/js/svgxuse.min.js"></script>
    <script src="${APP_PATH }/static/common/jquery.min.js"></script>
    <script src="${APP_PATH }/static/common/toastr/toastr.min.js"></script>
    <!-- custom script -->
    <script>
 		$('#backLogin').on('click', function(e) {
	    	var data = {};
	    	data.adminAccname = $('#username').val();
	    	data.adminPassword = $('#password').val();
		    $.ajax({
		        url: "${APP_PATH }/MlbackAdmin/CheakAdminUser",
		        type: "post",
		        dataType: "json",
		        contentType: 'application/json',
		        data: JSON.stringify(data),
		        success: function (data) {
		          	if (data.code == 100) {
		            	toastr.success('登陆成功，正在跳转过程中。');
		          	} else {
		          		toastr.error('用户名和密码不正确，请重新输入！');
		          	}
		        },
		        error: function() {
		        	toastr.error('登录失败，请重新登录！');
		        }
		    });
 		});
    </script>
  </body>
</html>