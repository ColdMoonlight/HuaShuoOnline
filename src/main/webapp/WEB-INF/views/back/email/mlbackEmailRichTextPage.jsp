<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Email Template</title>
	<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	<link rel="stylesheet" href="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.css">
	<style>
		.email-notification {
			margin-top: 1rem;
		}
		.email-notification-item {
			display: flex;
			padding: .5rem;
		}
		.email-notification-item+.email-notification-item {
			border-top: 1px solid #ccc;
		}
		.email-notification-name {
			width: 180px;
			color: #006fbb;
			font-weight: 500;
			font-size: .875rem;
			cursor: pointer;
		}
		.email-notification-info {
			margin-left: 1rem;
			font-size: .75rem;
			color: #333;
		}
	</style>
</head>

<body class="c-app">
	<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
	<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
	<div class="c-wrapper">
		<div class="c-body">
			<div class="c-main">
				<div class="c-init">
					<div class="c-option">
						<span class="c-option-title">Email Notifications</span>
						<button class="btn btn-primary btn-create">Create Email-Notification</button>
					</div>
					<div class="c-table">
						<div class="c-table-content">
							<div class="c-table-table table-responsive-sm">
								<table class="table">
									<thead>
										<tr>
											<th>id</th>
											<th>title</th>
											<th>operate</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
							<div id="table-pagination"></div>
							
						</div>
					</div>
				</div>
				<!-- edit or create -->
				<div class="c-create hide">
					<div class="c-option">
						<span class="c-option-title">Edit Email-Notification</span>
						<div class="group">
							<button class="btn btn-secondary btn-cancel">Cancel</button>
							<button class="btn btn-primary btn-save">Save Email-Notification</button>
						</div>
					</div>
					<div class="c-form row">
						<input id="emailrichtextId" hidden>
						<!-- left panel  -->
						<div class="left-panel col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">General</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="emailrichtextTitle">Email Subject</label>
										<div class="controls">
											<input class="form-control" id="emailrichtextTitle" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="emailrichtextTemplate">Email Body</label>
										<div class="controls">
											<textarea class="form-control" rows="15" id="emailrichtextTemplate"></textarea>
										</div>
									</div>
								</div>
							</div>
							
						</div>
					</div>
				</div>
				<!-- mask -->
				<div class="c-mask">
					<div class="spinner-border"></div>
				</div>
			</div>
		</div>
		<jsp:include page="../layout/backfooter.jsp" flush="true"></jsp:include>
	</div>

	<jsp:include page="../common/backfooter.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/deleteModal.jsp" flush="true"></jsp:include>

	<script src="${APP_PATH}/static/back/lib/tagsinput/bootstrap-tagsinput.min.js"></script>
	<script src="${APP_PATH}/static/back/lib/summernote/summernote.min.js"></script>
	<!-- custom script -->
	<script>
		var isCreate = false;

		// init
		getEmailNotificationsData();
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getEmailNotificationsData();
		});
		// create Email-Notification
		$('.btn-create').on('click', function () {
			$('.c-create .c-option-title').text('Create Email-Notification');
			showCreateBlock();
			// init formData
			resetFormData();
			getEmailNotificationId();
			isCreate = true;
		});
		// edit Email-Notification
		$(document.body).on('click', '.btn-edit', function (e) {
			var emailrichtextId = $(this).data('id');
			getOneEmailNotificationData({
				emailrichtextId: emailrichtextId
			}, function(resData) {
			 	$('.c-create .c-option-title').text('Edit Email-Notification');
				showCreateBlock();
				initFormData(resData);
			});			
		});
		// delete Email-Notification
		$(document.body).on('click', '.btn-delete', function (e) {
			var emailrichtextId = parseInt($(this).data('id'));
			$('#deleteModal').find('.modal-title').html('Delete Email-Notification!');
			$('#deleteModal').modal('show');
			$('#deleteModal .btn-ok').one('click', function () {
				deleteEmailNotificationData({
					emailrichtextId: emailrichtextId,
				}, function() {
					getEmailNotificationsData();
				});
			});
		});
		$(window).on('beforeunload', function() {
			var emailrichtextId = $('#emailrichtextId').val();
			isCreate && emailrichtextId && deleteEmailNotificationData({
				emailrichtextId: emailrichtextId,
			});
		});
		// save Email-Notification
		$('.c-create .btn-save').on('click', function () {
			saveEmailNotificationData(getFormData(), function() {
				// redirect tab-active & then search-data
				getEmailNotificationsData();
				showInitBlock();
				$('#emailrichtextId').val('');
			});
		});
		// cancel Email-Notification save
		$('.c-create .btn-cancel').on('click', function () {
			if (isCreate) {
				isCreate = false;
				deleteEmailNotificationData({
					emailrichtextId: $('#emailrichtextId').val(),
				}, function() {
					console.log("cancel create-Email-Notification");
				});
			}

			showInitBlock();
		});
		function showCreateBlock() {
			$('.c-init').addClass('hide');
			$('.c-create').removeClass('hide');
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-create').addClass('hide');
		}
		// handle formData
		// reset data
		function resetFormData() {
			$('#emailrichtextId').val('');
			$('#emailrichtextTitle').val('');
			$('#emailrichtextTemplate').val('');
		}
		// getFormdData
		function getFormData() {
			var data = {};
			data.emailrichtextId = parseInt($('#emailrichtextId').val());
			data.emailrichtextTitle = $('#emailrichtextTitle').val();
			data.emailrichtextTemplate = $('#emailrichtextTemplate').val();

			return data;
		}
		// initFormData
		function initFormData(data) {
			$('#emailrichtextId').val(data.emailrichtextId);
			$('#emailrichtextTitle').val(data.emailrichtextTitle);	
			$('#emailrichtextTemplate').val(data.emailrichtextTemplate);
		}
		// callback get id
		function getEmailNotificationId() {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackEmailRichText/initializaEmailRichText",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						var emailrichtextId = data.extend&& data.extend.MlbackEmailRichText && data.extend.MlbackEmailRichText.emailrichtextId;
						if (emailrichtextId) {
							$('#emailrichtextId').val(data.extend.MlbackEmailRichText.emailrichtextId);
							toastr.success(data.extend.resMsg);
						} else {
							toastr.error('create Email-Notification fail! Please try again.');
						}
					} else {
						showInitBlock();
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get all data
		function getEmailNotificationsData() {
			$('.c-mask').show();

			var formData = new FormData();
			formData.append('pn', getPageNum());

			$.ajax({
				url: "${APP_PATH }/MlbackEmailRichText/getMlbackEmailRichTextByPage",
				type: "post",
				processData: false,
				contentType: false,
				cache: false,
				data: formData,
				success: function (data) {
					if (data.code == 100) {
						renderTable(data.extend.pageInfo.list);
						renderTablePagination(data.extend.pageInfo);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function () {
					toastr.error('Failed to get Email-Notification, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get one data
		function getOneEmailNotificationData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackEmailRichText/getOneMlbackEmailRichTextOneAllDetail",
				type: "post",
				data: JSON.stringify(reqData),
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.MlbackEmailRichTextOne);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function () {
					toastr.error('Failed to get Email-Notification, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback save
		function saveEmailNotificationData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackEmailRichText/save",
				type: "post",
				cache: false,
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						callback && callback();
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback delete
		function deleteEmailNotificationData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackEmailRichText/delete",
				type: "post",
				cache: false,
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						$('#deleteModal').modal('hide');
						callback();
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}

		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<tr><td>' + data[i].emailrichtextId + '</td>' +
					'<td>' + data[i].emailrichtextTitle + '</td>' +
					'<td>' +
						'<button class="btn btn-primary btn-edit" data-id="' + data[i].emailrichtextId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
							'</svg>' +
						'</button>' +
						'<button class="btn btn-danger btn-delete" data-id="' + data[i].emailrichtextId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
	</script>
</body>

</html>