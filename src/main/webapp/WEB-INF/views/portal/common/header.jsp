<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
<!-- icon -->
<link rel="icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
<link rel="apple-touch-icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
<link rel="apple-touch-icon" sizes="180x180" href="${APP_PATH }/static/apple/micon2.png">
<!-- common css -->
<link href="${APP_PATH}/static/pc/css/main.css" rel="stylesheet">
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script>
	function addMeta(name, content) {
		var meta = document.createElement('meta');
		meta.name = name;
		meta.content = content;
		document.head.appendChild(meta);
	}
</script>