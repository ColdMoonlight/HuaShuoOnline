<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>megalook</title>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
</head>

<body>
	<jsp:include page="layout/header.jsp" flush="true"></jsp:include>
	<main><div class="container"></div></main>
	<jsp:include page="layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
	<script>
		$.ajax({
			url: "${APP_PATH}/MlbackFootNav/getOneMlbackFootNavOneAllDetail",
			type: "post",
			data: {"footnavId": '${sessionScope.footnavId}'},
			success: function (data) {
				if (data.code == 100) {
					renderArticle(data.extend.MlbackFootNavOne);
				} else {
					refreshPageModal();
				}
			},
			error: function () {
				refreshPageModal();
			}
		});
		function renderArticle(data) {
			var htmlStr = '';
			htmlStr = '<div class="article">' +
				'<div class="article-title">'+ data.footnavName +'</div>' +
				'<div class="article-content">'+ data.footnavDesc +'</div>' +
			'</div>';
			$('main .container').html(htmlStr);
		}
	</script>
</body>

</html>