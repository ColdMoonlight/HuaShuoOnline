<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
</head>
<body>

<jsp:include page="/WEB-INF/views/portal/header.jsp"></jsp:include>
<h1>HuaShuo独立站项目3.0系统</h1>
<jsp:include page="/WEB-INF/views/portal/footer.jsp"></jsp:include>
</body>
</html>