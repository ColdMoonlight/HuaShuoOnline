<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Collection</title>
		<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	</head>

	<body class="c-app">
		<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
		<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
		<div class="c-wrapper">
			<div class="c-body">
				<div class="c-main">
					<div class="c-option">
						<span class="c-option-title">Collections</span>
						<button class="btn btn-primary btn-create">Create collection</button>
					</div>
					<div class="c-table">
						<div class="c-table-tab">
							<div class="c-table-tab-item active">All</div>
						</div>
						<div class="c-table-content">
							<div class="input-group c-search">
								<svg class="c-icon">
									<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-magnifying-glass"></use>
								</svg>
								<input class="form-control" name="searchCollection" type="text" placeholder="Search Collections">
								<a class="btn btn-primary input-group-addon btn-save-search">Save search</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../layout/backfooter.jsp" flush="true"></jsp:include>
		</div>

		<jsp:include page="../common/backfooter.jsp" flush="true"></jsp:include>
		<!-- custom script -->
	</body>
</html>