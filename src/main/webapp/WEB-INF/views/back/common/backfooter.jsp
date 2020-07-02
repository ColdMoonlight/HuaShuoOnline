<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<!-- common script -->
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script src="${APP_PATH}/static/common/toastr/toastr.min.js"></script>
<script src="${APP_PATH}/static/back/lib/bootstrap/bootstrap.min.js"></script>
<script src="${APP_PATH}/static/back/js/main.js"></script>
<script>
	var format = 'YYYY-MM-DD hh:mm:ss';

	// intitial date
	function initDate() {
		return moment(new Date()).format(format);
	}
</script>
