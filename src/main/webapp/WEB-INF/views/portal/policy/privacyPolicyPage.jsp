<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Privacy policy</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
	<!-- icon -->
	<link rel="icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
	<link rel="apple-touch-icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
	<link rel="apple-touch-icon" sizes="180x180" href="${APP_PATH }/static/apple/micon2.png">
	<!-- common css -->
	<link href="${APP_PATH}/static/pc/css/main.min.css" rel="stylesheet">
</head>
<body>
	<main><div class="container"><div id="init-loading"></div></div></main>
	<!-- common script -->
	<script src="${APP_PATH}/static/common/jquery.min.js"></script>
	<!-- common footer script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
	    $.ajax({
			url: "${APP_PATH}/MlbackFootNav/getOneMlbackFootNavOneAllDetail",
			type: "post",
			data: {"footnavId": '3'},
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