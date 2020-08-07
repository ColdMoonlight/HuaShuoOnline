<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Track Info</title>
	<jsp:include page="common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
</head>
<body>
    <jsp:include page="layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="container">
			<div class="search-order-title">Track Order</div>
			<div class="search-order-condition">
				<select class="search-order-type">
					<option value="0">order id</option>
					<option value="1">shipment number</option>
				</select>
				<input type="text" class="search-select-input" id="searchOrderId" placeholder="Please input order-id ..." />
				<input type="text" class="search-select-input hide" id="searchTrackNumber" placeholder="Please input tracking-number ..." />

				<btutton class="btn btn-pink btn-track-order" id="btn-track-order">Track Order</btutton>
			</div>

			<div class="search-track-order-result">
				<p class="track-order-tip">Please input tracking-number/order-id to fetch track-order info...</p>
			</div>
		</div>
	
	<!-- main end -->
	<!-- common script -->
	<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
	<script>
		function getTrackInfo(callback) {
			payLoading();
			if ($('.search-order-type').val() == '0') {
				var payinfoPlatenum = $('#searchOrderId').val();
				if (!payinfoPlatenum.trim()) {
					mlModalTip('The order-id cannot be empty');
				} else {
					$.ajax({
						url: "${APP_PATH}/MlfrontOrderList/getTrackDetailByPayinfoPlatenum",
						type: "post",
						data: {"payinfoPlatenum": payinfoPlatenum},
						success: function (data) {
							if (data.code == 100) {
								callback && callback(data.extend.trackingRes);
							} else {
								mlModalTip('The order-id is invalid !');
							}
						},
						error: function () {
							refreshPageModal();
						},
						complete: function() {
							hidePayLoading();
						}
					});
				}
			} else {
				var trackingNumber = $('#searchTrackNumber').val();
				if (!trackingNumber.trim()) {
					mlModalTip('The tracking number cannot be empty');
				} else {
					$.ajax({
						url: "${APP_PATH}/MlfrontOrderList/getTrackDetailByTrackingNumber",
						type: "post",
						data: {"trackingNumber": trackingNumber},
						success: function (data) {
							if (data.code == 100) {
								callback && callback(data.extend.trackingRes);
							} else {
								mlModalTip('The tracking number is invalid !');
							}
						},
						error: function () {
							refreshPageModal();
						},
						complete: function() {
							hidePayLoading();
						}
					});
				}
			}
		}
		function renderTrackInfo(data) {
			function generateTimelineHtml(data) {
				var html = '';
				var len = data.length - 1;
				for(var i = len; i >= 0; i -= 1) {
					var item = data[i];
					html += '<div class="time-line-item'+ (i == len ? ' active' : '') +'">' +
							'<div class="time-line-date">'+ item.checkpointTime +'</div>' +
							'<div class="time-line-tag"><span class="name">tag: </span><span class="value">'+ (item.tag || '') +'</span></div>' +
							'<div class="time-line-location"><span class="name">location: </span><span class="value">'+ (item.location || '') +'</span></div>' +
							'<div class="time-line-msg"><span class="name">msg: </span><span class="value">'+ (item.message || '') +'</span></div>' +
						'</div>';
				}
				return html;
			}
			var trackOrderHtml = '<div class="track-result-header">' +
					'<div clsass="tracking-name"><span class="name">Tracking Name: </span><span class="value">'+ data.slug +'</span></div>' +
					'<div clsass="tracking-number"><span class="name">Tracking Number: </span><span class="value">'+ data.trackingNumber +'</span></div>' +
					'<div clsass="tracking-adress"><span class="name">Tracking Adress: </span><span class="value">'+ data.originCountryISO3 + ' → ' + data.destinationCountryISO3 +'</span></div>' +
				'</div>' +
				'<div class="track-result-body">' +
					'<div class="time-line">' + generateTimelineHtml(data.checkpoints) + '</div>' +
				'</div>';
			$('.search-track-order-result').html(trackOrderHtml);
		}
		$('.search-order-type').on('change', function() {
			$('.search-select-input').addClass('hide');
			if ($(this).val() == '1') {
				$('#searchTrackNumber').removeClass('hide');
			} else {
				$('#searchOrderId').removeClass('hide');
			}
		});
		$('#btn-track-order').on('click', function() {
			getTrackInfo(renderTrackInfo);
		});
	</script>
	<!-- footer nav -->
	<jsp:include page="layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>