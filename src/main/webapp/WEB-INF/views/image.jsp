<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>上传文件</title>
</head>
<body>
<div>
	<div class="bheader">
		<h2>--图片上传--</h2>
	</div>
	<div class="bbody">
		
		<form id="upload_from"<%--  enctype="multipart/form-data" method="post" action="${APP_PATH}/thumImageUrlImg/thumImage" --%>>
		
		<h2>请选择上传图片</h2>
		<div>
			<input type="file" name="image" id="image">
			<button type="submit">上传</button>
		</div>
		</form>
		
	</div>
</div>
</body>
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script>
$('#upload_from button').on('click', function() {
	var formData = 'image=' + $('#image')[0].files[0];
	$.ajax({
		url: "${APP_PATH}/thumImageUrlImg/thumImage",
		type: "post",
		data: formData,
		success: function (data) {
			if (data.code == 100) {
				console.log(data)
			}
		},
		error: function (err) {
			toastr.error(err);
		},
		complete: function () {
			conosle.log('xxx')
		}
	});	
})
</script>
</html>