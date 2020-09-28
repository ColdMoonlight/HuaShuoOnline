<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Marketing</title>
	<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	<link rel="stylesheet" href="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.css">
</head>

<body class="c-app">
	<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
	<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
	<div class="c-wrapper">
		<div class="c-body">
			<div class="c-main">
				<div class="c-init">
					<div class="c-option">
						<span class="c-option-title">Download</span>
					</div>
					<div class="row">
						<div class="form-group col-md-4">
							<div class="controls">
								<input hidden id="create-time" />
								<input hidden id="confirm-time" />
								<input class="form-control daterangetimepicker" type="text" />
							</div>
						</div>
						<div class="col-md-8">
							<button class="btn btn-secondary" id="download-email">
								<svg class="c-icon">
									<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-export"></use>
								</svg>
								<span>Export</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="../layout/backfooter.jsp" flush="true"></jsp:include>
	</div>

	<jsp:include page="../common/backfooter.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/verifyModal.jsp" flush="true"></jsp:include>

	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/moment.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.js"></script>
	<!-- custom script -->
	<script>
		var date = new Date();
		var ymd = date.getFullYear() + '-' + (date.getMonth() + 1 > 9 ? date.getMonth() + 1 : '0' + (date.getMonth() + 1)) + '-' + (date.getDate() > 9 ? date.getDate() : '0' + date.getDate());
		
		function downloadUserEmail() {
			var createTime =$('#create-time').val();
			var confirmTime  = $('#confirm-time').val();
			window.location.href = "${APP_PATH}/ExcleDownload/exportUserEmailBydate?userCreatetime="+createTime+"&userMotifytime="+confirmTime;
		}
		
		function checkUserRole(reqData, callback) {
			$.ajax({
				url: "${APP_PATH }/MlbackAdmin/CheakAdminUser",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						toastr.info('正在下载过程中。。。');
						callback && calback();
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function() {
					toastr.error('Login failed, please login again！');
				}
			});
		}

		$('#create-time').val(ymd + ' 00:00:00');
		$('#confirm-time').val(ymd + ' 23:59:59');
		bindDateRangeEvent(function(startTime, endTime, self) {
			$('#create-time').val(startTime);
			$('#confirm-time').val(endTime);
		});

		$('#download-email').on('click', function() {
			$('#verifyModal').modal('show');
		});

		$('#verifyModal .btn-ok').on('click', function() {
			/* var usernameVal = $('#username').val().trim();
			var passwordVal = $('#password').val().trim();
			
			if (!usernameVal) {
				toastr.error('用户名不能为空!!!');
				return;
			}
			if (!passwordVal) {
				toastr.error('密码不能为空!!!');
				return;
			}

			checkUserRole({
				'adminAccname': usernameVal,
				'adminPassword': passwordVal,
			}, function() { */
				downloadUserEmail();
			/* 	$('#verifyModal').modal('hide');				
			});	 */		
		});
	</script>
</body>

</html>