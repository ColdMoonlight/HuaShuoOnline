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
			.dashboard-condition .form-group {
				display: flex;
				align-items: center;
			}
			.dashboard-condition .form-group .controls {
				width: 20rem;
				margin-left: .5rem;
			}
			.card-header {
				font-size: 1.25rem;
				color: #333;
			}
			.chart-quantity { font-size: 1.5rem; }
			.card-body { padding-left: 0; padding-right: 0; }
		</style>
	</head>

	<body class="c-app">
		<jsp:include page="layout/backheader.jsp" flush="true"></jsp:include>
		<jsp:include page="layout/backsidebar.jsp" flush="true"></jsp:include>
		<div class="c-wrapper">
			<div class="c-body">
				<div class="c-main">
					<div class="dashboard-condition">
						<div class="form-group">
							<label class="col-form-label" for="search-time">
								<svg class="c-icon">
									<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-av-timer"></use>
								</svg>
							</label>
							<div class="controls">
								<input hidden id="search-create-time" />
								<input hidden id="search-confirm-time" />
								<input class="form-control daterangetimepicker" id="search-time" type="text">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="card">
								<div class="card-header">Total Sales</div>
								<div class="card-body">
									<div class="chart-title">
										<div class="chart-quantity payinfo-total-money"></div>
									</div>
									<div class="chart-body" id="payinfo-total-chart"></div>
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
									<div class="chart-title">
										<div class="chart-quantity user-quantity"></div>
									</div>
									<div class="chart-body" id="user-chart"></div>
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
									<div class="chart-title">
										<div class="chart-quantity payinfo-avg-money"></div>
									</div>
									<div class="chart-body" id="payinfo-avg-chart"></div>
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
								<div class="card-body"></div>
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
					</div>
				</div>
			</div>
			<jsp:include page="layout/backfooter.jsp" flush="true"></jsp:include>
		</div>

		<jsp:include page="common/backfooter.jsp" flush="true"></jsp:include>
		<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/moment.min.js"></script>
		<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.js"></script>
		<script type="text/javascript" src="${APP_PATH}/static/back/lib/echarts/echarts.min.js"></script>
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
			// cal user data
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
						var year = getYears(item.userCreatetime);
						var month = getMonths(item.userCreatetime);
						if (staticsObj[year + '-' + month]) {
							staticsObj[year + '-' + month] += 1;
						} else {
							staticsObj[year + '-' + month] = 1;
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
			// cal payinfo data
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
						var year = getYears(item.payinfoCreatetime);
						var month = getMonths(item.payinfoCreatetime);
						if (staticsObj[year + '-' + month]) {
							staticsObj[year + '-' + month].quantity += 1;
							staticsObj[year + '-' + month].money += item.payinfoMoney;
						} else {
							staticsObj[year + '-' + month] = {
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
							yData = data.result[i] ? (data.result[i].money).toFixed(2) : 0;
						}
						if (type == 'payinfoavg') {
							yData = data.result[i] ? (data.result[i].money / data.result[i].quantity).toFixed(2) : 0;
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
					coordinates.x = dayMap;
					for (var i = 0, len = dayMap.length; i < len; i += 1) {
						if (type == 'user') {
							yData = data.result[dayMap[i]] ? data.result[dayMap[i]] : 0;
						}
						if (type == 'payinfo') {
							yData = data.result[dayMap[i]] ? (data.result[dayMap[i]].money).toFixed(2) : 0;
						}
						if (type == 'payinfoavg') {
							yData = data.result[dayMap[i]] ? (data.result[dayMap[i]].money / data.result[dayMap[i]].quantity).toFixed(2) : 0;
						}
						coordinates.y.push(yData);
					}
				}
				if (data.type == 'month') {
					function makeMonthMap() {
						var map = [];
						var createTime = $('#search-create-time').val();
						var endTime = $('#search-confirm-time').val();
						if (getYears(createTime) == getYears(endTime)) {
							var year = getYears(createTime);
							var startMonth = getMonths(createTime);
							var endMonth = getMonths(endTime);
							for (var i = startMonth; i <= endMonth; i += 1) {
								map.push(year + '-' + i);
							}
						} else {
							var year = getYears(createTime);
							var year2 = getYears(endTime);
							var month = getMonths(createTime);
							var month2 = getMonths(endTime);
							for (var i = month; i <= 12; i += 1) {
								map.push(year + '-' + i);
							}

							for (var j = 1; j <= month2; j += 1) {
								map.push(year2 + '-' + j);
							}
						}
						return map;
					}
					var monthMap = makeMonthMap();
					coordinates.x = monthMap;
					for (var i = 0, len = monthMap.length; i < len; i += 1) {
						if (type == 'user') {
							yData = data.result[monthMap[i]] ? data.result[monthMap[i]] : 0;
						}
						if (type == 'payinfo') {
							yData = data.result[monthMap[i]] ? (data.result[monthMap[i]].money).toFixed(2) : 0;
						}
						if (type == 'payinfoavg') {
							yData = data.result[monthMap[i]] ? (data.result[monthMap[i]].money / data.result[monthMap[i]].quantity).toFixed(2) : 0;
						}
						coordinates.y.push(yData);
					}
				}
				return coordinates;
			}
			// generate chart
			function generateChart($el, coordinates) {
				// console.log(coordinates)
				$el.css('height', parseInt($el.width() / 16 * 9));
				var instance = echarts.init($el[0]);
				instance.setOption({
					enableBasicAutocompletion: !0,
			        enableSnippets: !0,
			        enableLiveAutocompletion: !0,
					tooltip: {
						formatter: '{b0} : {c0}'
					},
				    xAxis: {
				        type: 'category',
				        data: coordinates.x
				    },
				    yAxis: {
				        type: 'value'
				    },
				    series: [{
				        data: coordinates.y,
				        type: 'line'
				    }]
				});
				chartInstance.push(instance);
				$el.parents('.card').find('.card-mask').hide();
			}
			// generate dashboard
			function generateDashBoard(startTime, endTime) {
				$('#search-create-time').val(startTime);
				$('#search-confirm-time').val(endTime);
				getStaticsPayinfoData(function(data) {
					function getCalPayinfoMoney(data) {
						var acc = 0;
						for (var key in data) {
							acc += data[key].money;
						}
						return acc;
					}
					function getCalPayinfoQuantity(data) {
						var acc = 0;
						for (var key in data) {
							acc += data[key].quantity;
						}
						return acc;
					}
					var calPayinfo = calStaticsPayinfoData(data);
					var allCalPayinfoMoney = (calPayinfo.result && getCalPayinfoMoney(calPayinfo.result)) || 0;
					var allCalPayinfoQuantity = (calPayinfo.result && getCalPayinfoQuantity(calPayinfo.result)) || 0;
					var calPayinfoAvgMoney = allCalPayinfoMoney && allCalPayinfoQuantity ? (allCalPayinfoMoney / allCalPayinfoQuantity).toFixed(2) : 0;
					// total
					$('.payinfo-total-money').text('$' + allCalPayinfoMoney.toFixed(2) );
					generateChart($('#payinfo-total-chart'), generateCoordinatesData(calPayinfo, 'payinfo'));
					// avg
					$('.payinfo-avg-money').text('$' + calPayinfoAvgMoney);
					generateChart($('#payinfo-avg-chart'), generateCoordinatesData(calPayinfo, 'payinfoavg'));
				});
				getStaticsUserData(function(data) {
					function getCalUserQuantity(data) {
						var acc = 0;
						for (var key in data) {
							acc += data[key];
						}
						return acc;
					}
					var calUser = calStaticsUserData(data);
					var allCalUserQuantity = (calUser.result && getCalUserQuantity(calUser.result)) || 0;
					$('.user-quantity').text(allCalUserQuantity);
					generateChart($('#user-chart'), generateCoordinatesData(calUser, 'user'));
				});
			}
			/* init */
			var chartInstance = []
			var date = new Date();
			var ymd = date.getUTCFullYear() + '-' + (date.getUTCMonth() + 1) + '-' + date.getUTCDate();
			bindDateRangeEvent(generateDashBoard);
			generateDashBoard(ymd + ' 00:00:00', ymd + ' 23:59:59');
			// resize for chart
			$(window).on('resize', function() {
				if (chartInstance.length) {
					chartInstance.forEach(function(item, idx) {
						item.resize();
					});
				} else {
					generateDashBoard($('#search-create-time').val(), $('#search-confirm-time').val());
				}
			});
		</script>
	</body>
</html>