<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Reviews</title>
</head>

<body>

	<button id="excleImport">
	导入产品
	</button>


	<script type="text/javascript" src="${APP_PATH}/static/common/jquery.min.js"></script>
	<!-- custom script -->
	<script>
	
	$('#excleImport').on('change', function(e) {
		var $this = $(this);
		var excleFile = $this[0].files[0];
		var resVideoData = {};

		if (!excleFile) return false;

		$this.parent().find('.spinner').show();
		$this.val('');
		
		// video
		var videoFormData = new FormData();
		videoFormData.append('file', excleFile);
		
		
		$.ajax({
			url: "${APP_PATH}/VideoUpload/uploadProSmallVideo",
			type: "post",
			data: videoFormData,
			processData: false,
			contentType: false,
			cache: false,
			dataType: 'json',
			success: function (data) {
				console.log(data);
			},
			error: function (err) {
				toastr.error(err);
			},
			complete: function () {
				$this.parent().find('.spinner').hide();
			}
		});
	});

	</script>
</body>

</html>