<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Friday</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin: -1rem 0 0 0; } }
		@media only screen and (max-width: 1078px) and (min-width: 576px) { main { margin: -1rem 0 0 0; } }
	</style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="ins-banner">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/ins/wap-banner.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/ins/pc-banner.jpg"></div>
		</div>
		
	<!-- main end -->
	<!-- common script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		
		
		
		
		
		
		
	</script>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>