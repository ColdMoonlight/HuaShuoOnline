<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>coupon analysis</title>
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
						<span class="c-option-title">Coupon Analysis</span>
					</div>
					<div class="row">
						<div class="form-group col-md-4">
							<div class="controls">
								<input hidden id="create-time" />
								<input hidden id="confirm-time" />
								<input class="form-control daterangetimepicker" id="coupon-time" type="text" />
							</div>
						</div>
					</div>
					<div class="c-table">
						<div class="c-table-content">
							<div class="c-table-table table-responsive-sm">
								<table class="table">
									<thead>
										<tr>
										<th>coupon-name</th>
										<th>order-num</th>
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
						<span class="c-option-title">View order-list</span>
						<div class="group">
							<button class="btn btn-secondary btn-cancel">Cancel</button>
						</div>
					</div>

					<div class="c-form row">
						
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
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/moment.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.js"></script>
	<!-- custom script -->
	<script>
		// init
		var date = new Date();
		var ymd = date.getFullYear() + '-' + (date.getMonth() + 1 > 9 ? date.getMonth() + 1 : '0' + (date.getMonth() + 1)) + '-' + (date.getDate() > 9 ? date.getDate() : '0' + date.getDate());
		$('#create-time').val(ymd + ' 00:00:00');
		$('#confirm-time').val(ymd + ' 23:59:59');
		bindDateRangeEvent(function(startTime, endTime, self) {
			$('#create-time').val(startTime);
			$('#confirm-time').val(endTime);		
		});
		getSearchCouponsData({
			start: $('#create-time').val(),
			end: $('#confirm-time').val()
		});
		$('#coupon-time').on('change', function() {
			getSearchCouponsData({
				start: $('#create-time').val(),
				end: $('#confirm-time').val()
			});
		});
		// pagination a-click
		$(document.body).on('click', '.order-item', function (e) {
			var self = this;
			getOrdersByCoupon({
				'searchContent': $(self).data('coupon'),
				'searchCreatetime': $('#create-time').val(),
				'searchMotifytime': $('#confirm-time').val(),
			}, renderOrdersWithCoupon);
		});
		// cancel
		$('.btn-cancel').on('click', function () {
			$('.c-view c-option-title').text('Coupon analysis');
			showInitBlock();
		});
		// tab create/init
		function showCreateBlock() {
			$('.c-init').addClass('hide');
			$('.c-create').removeClass('hide');
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-create').addClass('hide');
		}
		// render orders about coupon
		function renderOrdersWithCoupon(data) {
			
		}
		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			var len = data.length;
			if (len) {
				for (var i = 0, len = data.length; i < len; i += 1) {
					htmlStr += '<tr style="cursor: pointer;">' +
							'<td>' + data[i].urlString + '</td>' +
							'<td class="order-item" data-coupon="'+ data[i].urlString +'"><b>' + (data[i].urlStringNum || '') + '</b></td>' +
						'</tr>';
				}
			} else {
				htmlStr = '<p class="text-align;">没有任何数据记录...</p>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
		//  callback get orders		
		function getOrdersByCoupon(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCoupon/getCouponUsedDetailListByTime",
				type: "post",
				data: JSON.stringify(reqData),
				dataType: "json",
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlbackCouponOne);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('Failed to get Super-Categeory, please refresh the page to get again!');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get search data
		function getSearchCouponsData(time) {
			$('.c-mask').show();

			$.ajax({
				url: "${APP_PATH }/MlbackCoupon/getSearchListByTime",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify({
					'searchCreatetime': time.start,
					'searchMotifytime': time.end,
				}),
				success: function (data) {
					if (data.code == 100) {
						renderTable(data.extend.urlCountList);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function () {
					toastr.error('Failed to get Categeory, please refresh the page to get again!');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
	</script>
</body>

</html>