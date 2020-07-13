<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Customer Voice</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 575px) {
			main { margin: -1rem 0 0 0; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="video-banner">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-banner.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-banner.jpg"></div>
		</div>
		<div class="video-dicount">			
			<div class="video-discount-title wap lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-dis-title.jpg"></div>
			<div class="video-discount-title pc lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-dis-title.jpg"></div>
			<div class="video-discount-body wap lazyload" data-src="${APP_PATH }/static/pc/img/video/pc-discount.png"></div>				
			<div class="video-discount-body pc lazyload" data-src="${APP_PATH }/static/pc/img/video/wap-discount.jpg"></div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
	</script>
</body>
</html>