<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>MEGALOOK ADMIN</title>
		<jsp:include page="common/backheader.jsp" flush="true"></jsp:include>
		<link rel="stylesheet" href="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.css">
		<style>
			.c-main .card {
				position: relative;
				min-height: 10rem;
				padding: 1rem;
				overflow: hidden;
			}
			.card-mask {
				position: absolute;
				top: 0;
				right: 0;
				bottom: 0;
				left: 0;
				background-color: rgba(0, 0, 0, .3);
				
				display: flex;
				align-items: center;
				justify-content: center;
			}
		</style>
	</head>

	<body class="c-app">
		<jsp:include page="layout/backheader.jsp" flush="true"></jsp:include>
		<jsp:include page="layout/backsidebar.jsp" flush="true"></jsp:include>
		<div class="c-wrapper">
			<div class="c-body">
				<div class="c-main">
					<div class="dashboard-condition row">
						<div class="form-group col-md-6">
							<label class="col-form-label" for="search-review-time">Range Time</label>
							<div class="controls">
								<input hidden id="search-create-time" />
								<input hidden id="search-confirm-time" />
								<input class="form-control daterangetimepicker" type="text">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Total Sales</div>
								<div class="card-body">
									
								</div>
								<div class="card-mask">
									<div class="spinner-border"></div>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Online Store Sessions</div>
								<div class="card-body">
									
								</div>
								<div class="card-mask">
									<div class="spinner-border"></div>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Returning customer rate</div>
								<div class="card-body">
									
								</div>
								<div class="card-mask">
									<div class="spinner-border"></div>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Online store conversion rate</div>
								<div class="card-body">
									
								</div>
								<div class="card-mask">
									<div class="spinner-border"></div>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Average order value</div>
								<div class="card-body">
									
								</div>
								<div class="card-mask">
									<div class="spinner-border"></div>
								</div>
							</div>
						</div>
						<!-- /.col-->
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Total orders</div>
								<div class="card-body">
									
								</div>
								<div class="card-mask">
									<div class="spinner-border"></div>
								</div>
							</div>
						</div>
						<!-- /.col-->
					</div>
				</div>
			</div>
			<jsp:include page="layout/backfooter.jsp" flush="true"></jsp:include>
		</div>

		<jsp:include page="common/backfooter.jsp" flush="true"></jsp:include>
		<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/moment.min.js"></script>
		<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.js"></script>
		<script>
			/* get statics data */
			function getStaticsUserData(callback) {
				$.ajax({
					url: "${APP_PATH}/BackHome/getBackHomeUserListInfo",
					type: "post",
					dataType: "json",
					contentType: 'application/json',
					data: JSON.stringify({
						'userCreatetime': $('#search-create-time').val(),
						'userMotifytime': $('#search-confirm-time').val()
					}),
					async: false,
					success: function (data) {
						if (data.code == 100) {
							callback && callback(data.extend.mlfrontUserList);
						} else {
							toastr.error(data.extend.resMsg);
						}
					},
					error: function () {
						toastr.error('Failed to get user-data, please refresh the page to get again！');
					}
				});
			}
			function getStaticsPayinfoData(callback) {
				$.ajax({
					url: "${APP_PATH}/BackHome/getBackHomePayInfo",
					type: "post",
					dataType: "json",
					contentType: 'application/json',
					data: JSON.stringify({
						'payinfoCreatetime': $('#search-create-time').val(),
						'payinfoMotifytime': $('#search-confirm-time').val()
					}),
					async: false,
					success: function (data) {
						if (data.code == 100) {
							callback && callback(data.extend.mlfrontPayInfoSuccessList);
						} else {
							toastr.error(data.extend.resMsg);
						}
					},
					error: function () {
						toastr.error('Failed to get payinfo-data, please refresh the page to get again！');
					}
				});
			}
			/* statics cal */
			function calStaticsUserData(data) {
				var createTime = getMilliseconds($('#search-create-time').val());
				var endTime = getMilliseconds($('#search-confirm-time').val());
				var staticsObj = {};
				if (((endTime - createTime) / 3600000) <= 24) {
					data.forEach(function(item) {
						var hour = getHours(item.userCreatetime);
						if (staticsObj[hour]) {
							staticsObj[hour] += statics[hour];
						} else {
							staticsObj[hour] = 1;
						}
					});
					return {
						type: 'hour',
						result: staticsObj
					};
				} else if (((endTime - createTime) / 3600000) > 24 && ((endTime - createTime) / 86400000) < 29) {
					data.forEach(function(item) {
						var day = getDays(item.userCreatetime);
						var month = getMonths(item.userCreatetime);
						if (staticsObj[month+ '-' +day]) {
							staticsObj[month+ '-' +day] += 1;
						} else {
							staticsObj[month+ '-' +day] = 1;
						}
					});
					return {
						type: 'day',
						result: staticsObj
					};
				} else if (((endTime - createTime) / 86400000) < 366) {
					data.forEach(function(item) {
						var month = getMonths(item.userCreatetime);
						if (staticsObj[month]) {
							staticsObj[month] += 1;
						} else {
							staticsObj[month] = 1;
						}
					});
					return {
						type: 'month',
						result: staticsObj
					};
				} else {
					toastr.warning('暂不支持超过一年的数据查询！');
				}
			}
			function calStaticsPayinfoData(data) {
				var createTime = getMilliseconds($('#search-create-time').val());
				var endTime = getMilliseconds($('#search-confirm-time').val());
				var staticsObj = {};
				if (((endTime - createTime) / 3600000) <= 24) {
					data.forEach(function(item) {
						var hour = getHours(item.payinfoCreatetime);
						if (staticsObj[hour]) {
							staticsObj[hour].quantity += 1;
							staticsObj[hour].money += item.payinfoMoney;
						} else {
							staticsObj[hour] = {
								quantity: 1,
								money: item.payinfoMoney
							};
						}
					});
					return {
						type: 'hour',
						result: staticsObj
					};
				} else if (((endTime - createTime) / 3600000) > 24 && ((endTime - createTime) / 86400000) < 29) {
					data.forEach(function(item) {
						var day = getDays(item.payinfoCreatetime);
						var month = getMonths(item.payinfoCreatetime);
						if (staticsObj[month+ '-' +day]) {
							staticsObj[month+ '-' +day].quantity += 1;
							staticsObj[month+ '-' +day].money += item.payinfoMoney;
						} else {
							staticsObj[month+ '-' +day] = {
								quantity: 1,
								money: item.payinfoMoney
							};
						}
					});
					return {
						type: 'day',
						result: staticsObj
					};
				} else if (((endTime - createTime) / 86400000) < 366) {
					data.forEach(function(item) {
						var month = getMonths(item.payinfoCreatetime);
						if (staticsObj[month]) {
							staticsObj[month].quantity += 1;
							staticsObj[month].money += item.payinfoMoney;
						} else {
							staticsObj[month] = {
								quantity: 1,
								money: item.payinfoMoney
							};
						}
					});
					return {
						type: 'month',
						result: staticsObj
					};
				} else {
					toastr.warning('暂不支持超过一年的数据查询！');
				}
			}
			/* generate coordinates data */
			function generateCoordinatesData(data, type) {
				function getDayOfMonth(val, flag) {
					if (val == 2) {
						return flag ? 29 : 28;
					}
					
					return [1, 3, 5, 7, 8, 10, 12].indexOf(val) > -1 ? 31 : 30;
				}
				var coordinates = {
						x: [],
						y: []
					};
				var yData;
				if (data.type == 'hour') {
					for (var i=0; i<24; i+=1) {
						coordinates.x.push(i + ':00');
						if (type == 'user') {
							yData = data.result[i] ? data.result[i] : 0;
						}
						if (type == 'payinfo') {
							yData = data.result[i] ? data.result[i].quantity : 0;
						}
						coordinates.y.push(yData);
					}
				}
				if (data.type == 'day') {
					function makeDayMap() {
						var map = [];
						var createTime = $('#search-create-time').val();
						var endTime = $('#search-confirm-time').val();
						if (getMonths(createTime) == getMonths(endTime)) {
							var month = getMonths(createTime);
							var startDay = getDays(createTime);
							var endDay = getDays(endTime);
							for (var i = startDay; i <= endDay; i += 1) {
								map.push(month + '-' + i);
							}
						} else {
							var month = getMonths(createTime);
							var month2 = getMonths(endTime);
							var day = getDays(createTime);
							var day2 = getDays(endTime);
							var edg = getDayOfMonth(month, isLeapYear(createTime));
							for (var i = day; i <= edg; i += 1) {
								map.push(month + '-' + i);
							}

							for (var j = 1; j <= day2; j += 1) {
								map.push(month2 + '-' + j);
							}
						}
						return map;
					}
					var dayMap = makeDayMap();
					for (var i = 0, len = dayMap.length; i < len; i += 1) {
						coordinates.x.push(dayMap[i]);
						if (type == 'user') {
							yData = data.result[dayMap[i]] ? data.result[dayMap[i]] : 0;
						}
						if (type == 'payinfo') {
							yData = data.result[dayMap[i]] ? data.result[dayMap[i]].quantity : 0;
						}
						coordinates.y.push(yData);
					}
				}
				return coordinates;
			}
			/* init */
			bindDateRangeEvent(function(startTime, endTime) {
				$('#search-create-time').val(startTime);
				$('#search-confirm-time').val(endTime);
				getStaticsUserData(function(data) {
					var calUser = calStaticsUserData(data);
					console.log(generateCoordinatesData(calUser, 'user'));
				});
				getStaticsPayinfoData(function(data) {
					var calPayInfo = calStaticsPayinfoData(data);
					console.log(generateCoordinatesData(calPayInfo, 'payinfo'));
				});
			});
			getStaticsUserData(function(data) {
				console.log(data);
			});
			
			getStaticsPayinfoData(function(data) {
				console.log(data);
			});
		</script>
	</body>
</html>