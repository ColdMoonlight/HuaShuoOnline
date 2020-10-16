<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Upload Email</title>
	<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	<link rel="stylesheet" href="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.css">	
</head>

<body class="c-app">
	<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
	<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
	<div class="c-wrapper">
		<div class="c-body">
			<div class="c-main">
				<div class="c-init">
					<div class="c-option">
						<span class="c-option-title">Email</span>
					</div>
					<div class="c-table">
						<div class="c-table-header">
							<div class="row">
								
								<div class="form-group col-md-12">
									<div class="col-md-2">
										<h3 style="font-size: 16px;">下载模板</h3>
										<div class="c-upload-img" id="download" style="width: 4rem; height: 4rem; padding: 1rem;">
										  <svg class="c-icon" style="width: 2rem; height: 2rem;">
										  	<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-downloadwd"></use>
										  </svg>
										</div>
									</div>
									<div class="col-md-2">
										<h3 style="font-size: 16px;">上传文档</h3>
										<div class="c-upload-img" style="width: 4rem; height: 4rem;padding: 1rem;">
											<svg class="c-icon" style="width: 2rem; height: 2rem;">
												<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-uploadwd"></use>
											</svg>
											<div class="c-backshow"></div>	
												<!-- <input type="file" id="file" name="myfile" style="display: none" />
												<input type="text" id="filename" style="display:none"></span>
												<input type="button" onclick="upload()" value="选择文件上传" /> -->
											<input id="excleImport" type="file" name="file" />										
											<!-- spinner -->
											<div class="spinner">
												<div class="spinner-border" role="status" aria-hidden="true"></div>
											</div>
										</div>
									</div>
									<div class="col-md-2">
										<h3 style="font-size: 16px;">上传文档</h3>
										<div class="c-upload-img" style="width: 4rem; height: 4rem;padding: 1rem;">
											<svg class="c-icon" style="width: 2rem; height: 2rem;">
												<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-uploadwd"></use>
											</svg>
											<div class="c-backshow"></div>	
												<!-- <input type="file" id="file" name="myfile" style="display: none" />
												<input type="text" id="filename" style="display:none"></span>
												<input type="button" onclick="upload()" value="选择文件上传" /> -->
											<input id="excleImport" type="file" name="file" />										
											<!-- spinner -->
											<div class="spinner">
												<div class="spinner-border" role="status" aria-hidden="true"></div>
											</div>
										</div>
									</div>
									<div class="col-md-2">
										<h3 style="font-size: 16px;">上传文档</h3>
										<div class="c-upload-img" style="width: 4rem; height: 4rem;padding: 1rem;">
											<svg class="c-icon" style="width: 2rem; height: 2rem;">
												<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-uploadwd"></use>
											</svg>
											<div class="c-backshow"></div>	
												<!-- <input type="file" id="file" name="myfile" style="display: none" />
												<input type="text" id="filename" style="display:none"></span>
												<input type="button" onclick="upload()" value="选择文件上传" /> -->
											<input id="excleImport" type="file" name="file" />										
											<!-- spinner -->
											<div class="spinner">
												<div class="spinner-border" role="status" aria-hidden="true"></div>
											</div>
										</div>
									</div>
									<div class="col-md-2">
										<h3 style="font-size: 16px;">上传文档</h3>
										<div class="c-upload-img" style="width: 4rem; height: 4rem;padding: 1rem;">
											<svg class="c-icon" style="width: 2rem; height: 2rem;">
												<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-uploadwd"></use>
											</svg>
											<div class="c-backshow"></div>	
												<!-- <input type="file" id="file" name="myfile" style="display: none" />
												<input type="text" id="filename" style="display:none"></span>
												<input type="button" onclick="upload()" value="选择文件上传" /> -->
											<input id="excleImport" type="file" name="file" />										
											<!-- spinner -->
											<div class="spinner">
												<div class="spinner-border" role="status" aria-hidden="true"></div>
											</div>
										</div>
									</div>
									<div class="col-md-2">
										<h3 style="font-size: 16px;">上传文档</h3>
										<div class="c-upload-img" style="width: 4rem; height: 4rem;padding: 1rem;">
											<svg class="c-icon" style="width: 2rem; height: 2rem;">
												<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-uploadwd"></use>
											</svg>
											<div class="c-backshow"></div>	
												<!-- <input type="file" id="file" name="myfile" style="display: none" />
												<input type="text" id="filename" style="display:none"></span>
												<input type="button" onclick="upload()" value="选择文件上传" /> -->
											<input id="excleImport" type="file" name="file" />										
											<!-- spinner -->
											<div class="spinner">
												<div class="spinner-border" role="status" aria-hidden="true"></div>
											</div>
										</div>
									</div>
									<div class="col-md-2">
										<h3 style="font-size: 16px;">上传文档</h3>
										<div class="c-upload-img" style="width: 4rem; height: 4rem;padding: 1rem;">
											<svg class="c-icon" style="width: 2rem; height: 2rem;">
												<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-uploadwd"></use>
											</svg>
											<div class="c-backshow"></div>	
												<!-- <input type="file" id="file" name="myfile" style="display: none" />
												<input type="text" id="filename" style="display:none"></span>
												<input type="button" onclick="upload()" value="选择文件上传" /> -->
											<input id="excleImport" type="file" name="file" />										
											<!-- spinner -->
											<div class="spinner">
												<div class="spinner-border" role="status" aria-hidden="true"></div>
											</div>
										</div>
									</div>
								</div>
								
							</div>
							
						</div>
						
					</div>
				</div>
				<!-- edit or create -->
				
				<!-- mask -->
				
			</div>
		</div>
		<jsp:include page="../layout/backfooter.jsp" flush="true"></jsp:include>
	</div>

	<jsp:include page="../common/backfooter.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/deleteModal.jsp" flush="true"></jsp:include>

	<!-- <script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/moment.min.js"></script> -->
	<!-- <script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.js"></script> -->
	<!-- custom script -->
	<script>
	
		/***2020-08-25新增*******************/
		$('#download').on('click', function() {
			window.location.href = "${APP_PATH}/excleImport/exportReviewsImportDemo";
		});
		
		
		
		$('#excleImport').on('change', function(e) {
			var $this = $(this);
			var excleFile = $this[0].files[0];
			if (!excleFile) return false;
			var name = $this.val('');
			var exclFormData = new FormData();
			exclFormData.append('file', excleFile);
			exclFormData.append('name', name);
			// console.log(exclFormData)
			var file_typename =  excleFile.name.substring(excleFile.name.lastIndexOf('.'));
			if (file_typename === '.xlsx' || file_typename === '.xls') {
				$.ajax({
					url: "${APP_PATH}/excleImport/inportPaySuccessEmail",
					type: "post",
					data: exclFormData,
					processData: false,
					contentType: false,
					cache: false,
					// dataType: 'json',
					success: function (data) {
						// console.log(data);
						alert("Upload successful ！");
						 window.location.reload();
						
					},
					error: function (err) {
						toastr.error(err);
						// console.log("出错了")
					},
					complete: function () {
						$this.parent().find('.spinner').hide();
					}
				});
				
			}else{
				console.log("The file format is incorrect")
				alert("The file format is incorrect")
			}
			
			
			
			
		});
		
		
		
		
		
	</script>
</body>

</html>