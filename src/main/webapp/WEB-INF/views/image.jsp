<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>上传文件</title>
		<jsp:include page="back/common/backheader.jsp" flush="true"></jsp:include>
		<style>
			.upload-list {
				border: 1px solid #3d3d3d;
				padding: 0 .5rem .5rem 0;
				margin-top: 1rem;
			}
			.upload-list-item {
				width: 180px;
				height: 180px;
				margin-top: .5rem;
				margin-left: .5rem;
				
				background-size: 100% auto;
				background-repeat: no-repeat;
				border: 1px solid #ccc;
			}
		</style>		
	</head>
	<body>
		<div>
			<div class="bheader">
				<h2>--图片上传--</h2>
			</div>			
			<form id="upload_from">
				<h2>请选择上传图片</h2>
				<div id="uploadImg" class="c-upload-img">
					<svg class="c-icon">
						<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image-plus"></use>
					</svg>
					<div class="c-backshow"></div>
					<input id="image" type="file" />						
					<!-- spinner -->
					<div class="spinner">
						<div class="spinner-border" role="status" aria-hidden="true"></div>
					</div>
				</div>
			</form>
			<div class="upload-list"></div>
		</div>
		<jsp:include page="back/common/backfooter.jsp" flush="true"></jsp:include>
		<script>
		$('#upload_from #image').on('change', function(e) {
			var $this = $(this);
			$('.c-upload-img .spinner').show();
			var formData = new FormData();
			formData.append('image', $('#image')[0].files[0]);
			// formData.append('pname', "hjdhgjd")
			$.ajax({
				url: "${APP_PATH}/thumImageUrlImg/thumImage",
				type: "post",
				data: formData,
				processData: false,
				contentType: false,
				cache: false,
				dataType: 'json',
				success: function (data) {
					if (data.code == 100) {
						var parentEl = $this.parent();
						parentEl.addClass('active');
						parentEl.find('.c-backshow').css('background-image', 'url('+ encodeUrl('${APP_PATH}' + data.extend.thumImageUrl) + ')');
						addUploadListItem(data.extend.imageUrl);
					} else {
						toastr.error('网络错误， 请稍后重试！');	
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-upload-img .spinner').hide();
				}
			});
		});
		
		function addUploadListItem(imgUrl) {
			var item = $('<div class="upload-list-item" style="background-image: url('+ encodeUrl('${APP_PATH}'+ imgUrl) +');" />');

			$('.upload-list').append(item);
		}
		</script>
	</body>
</html>