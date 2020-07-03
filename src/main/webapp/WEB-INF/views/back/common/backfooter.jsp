<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<!-- common script -->
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script src="${APP_PATH}/static/common/toastr/toastr.min.js"></script>
<script src="${APP_PATH}/static/back/lib/bootstrap/bootstrap.min.js"></script>
<script src="${APP_PATH}/static/back/js/main.js"></script>
<script>
	var format = 'YYYY-MM-DD HH:mm:ss';

	// intitial date
	function initDate() {
		return moment(new Date()).format(format);
	}

	// daterange
	function bindDateRangeEvent(callback) {
		$('.daterangetimepicker').daterangepicker({
			timePicker: true,
			timePicker24Hour: true,
			timePickerSeconds: true,
			showWeekNumbers: true,
			locale: {
				format: format,
			},
			ranges: {
		        'Today': [moment(), moment()],
		        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
		        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
		        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
		        'This Month': [moment().startOf('month'), moment().endOf('month')],
		        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
		    }
		}, function(start, end, label) {
			var startTime = moment(new Date(start)).format(format);
			var endTime = moment(new Date(end)).format(format);
			callback && callback(startTime, endTime);
		});
	}
	
	// timepicker
	function bindDateTimepicker() {
		$('.datetimepicker').daterangepicker({
			singleDatePicker: true,
			timePicker: true,
			timePickerSeconds: true,
			showWeekNumbers: true,
			locale: {
				format: format,
			},
		});
	}
</script>
