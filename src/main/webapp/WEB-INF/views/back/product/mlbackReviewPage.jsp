<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Reviews</title>
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
						<span class="c-option-title">Reviews</span>
						<button class="btn btn-primary btn-create">Create Review</button>
					</div>
					<div class="c-table">
						<div class="c-table-content">
							<table class="c-table-table table table-responsive-sm">
								<thead>
									<tr>
										<th>id</th>
										<th>Profile Picture</th>
										<th>Review Customer</th>
										<th>Product Id</th>
										<th>Review Time</th>
										<th>Review Status</th>
										<th>Rating Star</th>
										<th>Review Source</th>
										<th>operate</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
							<div id="table-pagination"></div>
						</div>
					</div>
				</div>
				<!-- edit or create -->
				<div class="c-create hide">
					<div class="c-option">
						<span class="c-option-title">Edit Products</span>
						<div class="group">
							<button class="btn btn-secondary btn-cancel">Cancel</button>
							<button class="btn btn-primary btn-save">Save Review</button>
						</div>
					</div>
					<div class="c-form row">
						<input id="reviewId" hidden>
						<!-- left panel  -->
						<div class="left-panel col-lg-7 col-md-12">
							<!-- general -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">General</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="productName">Customer Name</label>
										<div class="controls">
											<input class="form-control" id="reviewUname" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="reviewProstarnum">Rating Star</label>
										<div class="controls">
											 <select class="form-control" id="reviewProstarnum" />
												<option value="1">1 star</option>
												<option value="2">2 star</option>
												<option value="3">3 star</option>
												<option value="4">4 star</option>
												<option value="5">5 star</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="reviewFrom">Review Source</label>
										<div class="controls">
											<select class="form-control" id="reviewFrom" />
												<option value="0">self</option>
												<option value="1">customer</option>
											</select>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 col-form-label" for="reviewStatus">Status</label>
										<div class="controls col-md-3">
											<label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="reviewStatus" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="reviewDetailstr">Review Text</label>
										<div class="controls">
											<textarea class="form-control" rows="5" id="reviewDetailstr"></textarea>
										</div>
									</div>
								</div>
							</div>
							<!-- review time -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Review Time</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<input id="reviewCreatetime" hidden type="text" />
										<input id="reviewConfirmtime" hidden type="text" />
										<label class="col-form-label" for="reviewTime">Range Time</label>
										<div class="controls">
											<input type="text" class="form-control datetimepicker" id="reviewTime" placeholder="example: 2020-08-01 00:00:00 - 2020-08-01 23:59:59" />
										</div>
									</div>
								</div>
							</div>
							<!-- media picture -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Review Media</div>
								</div>
								<div class="card-body">
									<div class="row">
										<!-- main img  -->
										<div class="col-md-6">
											<h3>Profile Picture</h3>
											<div class="c-upload-img">
												<svg class="c-icon">
													<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image-plus"></use>
												</svg>
												<div class="c-backshow"></div>						
												<input id="reviewUimgurl" type="file" accept="image/png, image/jpeg, image/gif" />										
												<!-- spinner -->
												<div class="spinner">
													<div class="spinner-border" role="status" aria-hidden="true"></div>
												</div>
											</div>
										</div>
									</div>
									<div class="pictureDetails">
										<h3>Review Details Picture</h3>
										<i class="text-danger">Upload up to 6 images！</i>
										<div class="product-img-list">
											<div class="product-img-item c-upload-img">
												<svg class="c-icon">
													<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image-plus"></use>
												</svg>
												<div class="c-backshow"></div>						
												<input class="productAllImgurl" data-order="1" type="file" accept="image/png, image/jpeg, image/gif" />										
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
						<!-- right panel  -->
						<div class="right-panel col-lg-5 col-md-12">
							<!-- sell data  -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Belong</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="reviewProduct">Product</label>
										<div class="controls">
											<select class="form-control" id="reviewProduct" /></select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- mask -->
				<div class="c-mask">
					<div class="spinner-border"></div>
				</div>
			</div>
		</div>
		<jsp:include page="../layout/backfooter.jsp" flush="true"></jsp:include>
	</div>

	<jsp:include page="../common/backfooter.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/deleteModal.jsp" flush="true"></jsp:include>

	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/moment.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/datetimepicker/daterangepicker.js"></script>
	<!-- custom script -->
	<script>
		var isCreate = false;

		getReviewsData();
		getAllProductData(renderAllProduct);
		bindDateRangeEvent(function(startTime, endTime) {
			$('#reviewCreatetime').val(startTime);
			$('#reviewConfirmtime').val(endTime);
		});
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getReviewsData();
		});
		// create review
		$('.btn-create').on('click', function () {
			$('.c-create .c-option-title').text('Create Review');
			showCreateBlock();
			// init formData
			resetFormData();
			getProductId();
			isCreate = true;
		});
		// edit review
		$(document.body).on('click', '.btn-edit', function (e) {
			var reqData = { "reviewId": $(this).data('id') };
			getOneReviewData(reqData, function(resData) {
			 	$('.c-create .c-option-title').text('Edit Review');
				showCreateBlock();
				initFormData(resData);
			});
		});
		// delete review
		$(document.body).on('click', '.btn-delete', function (e) {
			var reviewId = parseInt($(this).data('id'));
			$('#deleteModal').find('.modal-title').html('Delete Review!');
			$('#deleteModal').modal('show');
			$('#deleteModal .btn-ok').one('click', function () {
				deleteReviewData({
					"reviewId": reviewId,
				}, function() {
					getReviewsData();
				});
			});
		});
		// save review
		$('.c-create .btn-save').on('click', function () {
			var reqData = getFormData();
			if (reqData.reviewCreatetime > reqData.reviewConfirmtime) {
				toastr.error('The start time must be less than the end time !');
				$('#reviewTime').focus();
				return false;
			}
			saveReviewData(reqData, function() {
				// redirect tab-active & then search-data
				if (isCreate) {
					isCreate = false;
				}
				showInitBlock();
			});
		});
		// cancel review save
		$('.c-create .btn-cancel').on('click', function () {
			if (isCreate) {
				// delete null review
				deleteReviewData({
					productId: $('#productId').val(),
				}, function() {
					console.log("cancel create-product");
				});
			}
			showInitBlock();
		});
		$(window).on('beforeunload', function() {
			if (isCreate) {
				// delete null product
				deleteReviewData({
					productId: $('#productId').val(),
				}, function() {
					console.log("cancel create-product");
				});
			}
		});

		// upload main img
		$('#productImgurl').on('change', function(e) {
			var $this = $(this);
			var file = $this[0].files[0];
			var formData = new FormData();

			if (!file) return false;

			$this.parent().find('.spinner').show();

			formData.append('type', 'product');
			formData.append('image', file);
			formData.append('productId', parseInt($('#productId').val()));
			formData.append('productSeo', $('#productSeo').val());

			$.ajax({
				url: "${APP_PATH}/ImageUpload/thumImageProduct",
				type: "post",
				data: formData,
				processData: false,
				contentType: false,
				cache: false,
				dataType: 'json',
				success: function (data) {
					if (data.code == 100) {
						addPicture($this, {
							imageUrl: data.extend.sqlimageUrl,
							thumImageUrl: data.extend.sqlthumImageUrl
						});
					} else {
						toastr.error('网络错误， 请稍后重试！');	
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$this.parent().find('.spinner').hide();
				}
			});
		});
		// upload details img
		$(document.body).on('change', '.productAllImgurl', function(e) {
			var $this = $(this);
			var file = $this[0].files[0];
			var formData = new FormData();

			if (!file) return false;

			$this.parent().find('.spinner').show();
			
			formData.append('imageAll', file);
			formData.append('productId', parseInt($('#productId').val()));
			formData.append('productimgSortOrder', $this.data('order'));

			$.ajax({
				url: "${APP_PATH}/ImageUpload/thumImageProductAll",
				type: "post",
				data: formData,
				processData: false,
				contentType: false,
				cache: false,
				dataType: 'json',
				success: function (data) {
					if (data.code == 100) {
						var count = $('.product-img-item').length;
						if (count < 6 && !$this.attr('data-val')) {
							addUploadBlock(count + 1);
						}
						addPicture($this, {
							imageUrl: data.extend.sqlimageUrl,
							thumImageUrl: data.extend.sqlthumImageUrl
						});
					} else {
						toastr.error('网络错误， 请稍后重试！');	
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$this.parent().find('.spinner').hide();
				}
			});
		});
		function addPicture(el, data) {
			var parentEl = el.parent();
			el.attr('data-val', JSON.stringify(data));
			parentEl.addClass('active');
			parentEl.find('.c-backshow').html('<img src="'+ encodeUrl(data.thumImageUrl) + '" />');
		}
		function resetPicture(el) {
			var parentEl = el.parent();
			el.attr('data-val', '');
			parentEl.removeClass('active');
			parentEl.find('.c-backshow').html('');
		}
		function addUploadBlock(idx) {
			var htmlStr = '<div class="product-img-item c-upload-img">' +
				'<svg class="c-icon">' +
					'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image-plus"></use>' +
				'</svg>' +
				'<div class="c-backshow"></div>' +
				'<input class="productAllImgurl" data-order="'+ idx +'" type="file" accept="image/png, image/jpeg, image/gif" />' +
				'<div class="spinner">' +
					'<div class="spinner-border" role="status" aria-hidden="true"></div>' +
				'</div>' +
			'</div>';
			$('.product-img-list').append($(htmlStr));
		}
		function showCreateBlock() {
			$('.c-init').addClass('hide');
			$('.c-create').removeClass('hide');
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-create').addClass('hide');
		}
		// handle formData
		// reset data
		function resetFormData() {
			$('#reviewId').val('');
			$('#reviewUname').val('');
			$('#reviewStatus').prop('checked', false);
			$('#reviewProstarnum').val('0');

			$('#reviewDetailstr').val('');

			$('#reviewFrom').val('0');

			var initTime = initDate();
			$('#reviewCreatetime').val(initTime);
			$('#reviewConfirmtime').val(initTime);
			$('.datetimepicker').data('daterangepicker').setStartDate(initTime);
			$('.datetimepicker').data('daterangepicker').setEndDate(initTime);
			
			resetPicture($('#reviewUimgurl'));

			// reset product-img-list
			$('.product-img-list').html('');
			addUploadBlock(1);

			$('#reviewProduct').val('-1');
		}
		// getFormdData
		function getFormData() {
			var data = {};
			data.reviewId = parseInt($('#reviewId').val());
			data.reviewUname = $('#reviewUname').val();
			data.reviewStatus = $('#reviewStatus').prop('checked') ? 1 : 0;
			data.reviewProstarnum = parseInt($('#reviewProstarnum').val());
			data.reviewDetailstr = $('#reviewDetailstr').val();
			
			data.reviewFrom = $('#reviewFrom').val();

			data.reviewCreatetime = $('#reviewCreatetime').val();
			data.reviewConfirmtime = $('#reviewConfirmtime').val();

			var imageData = $('#reviewUimgurl').attr('data-val') && JSON.parse($('#reviewUimgurl').attr('data-val'));
			data.reviewUimgurl = imageData.imageUrl || null;

			var $ReviewProductSelected = $('#reviewProduct').find('option:checked');
			data.reviewPid = $('#reviewProduct').val();
			data.reviewPname = $ReviewProductSelected.data('name');
			data.reviewSupercateidstr = $ReviewProductSelected.data('supercate');

			return data;
		}
		// initFormData
		function initFormData(data) {
			$('#reviewId').val(data.reviewId);
			$('#reviewUname').val(data.reviewUname);
			$('#reviewStatus').prop('checked', data.reviewStatus);
			$('#reviewProstarnum').val(data.reviewProstarnum || 1);
			$('#reviewDetailstr').val(data.reviewDetailstr);

			$('#reviewFrom').val(data.reviewFrom || 0);

			var startTime = data.reviewCreatetime || initDate();
			var endTime = data.reviewConfirmtime || initDate();
			$('#reviewCreatetime').val(startTime);
			$('#reviewConfirmtime').val(endTime);
			$('.datetimepicker').data('daterangepicker').setStartDate(startTime);
			$('.datetimepicker').data('daterangepicker').setEndDate(endTime);
			
			
			if (data.reviewUimgurl) {
				addPicture($('#reviewUimgurl'), {
					imageUrl: data.reviewUimgurl
				});
			} else {
				resetPicture($('#productImgurl'));
			}
			
			getReviewAllImgData({
				productId: data.reviewPid
			}, renderReviewAllImgData);

			$('#reviewProduct').val(data.reviewPid || -1);
		}
		// callback get id
		function getProductId() {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackProduct/initializaProduct",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						var productId = data.extend&& data.extend.mlbackProduct && data.extend.mlbackProduct.productId;
						if (productId) {
							$('#productId').val(data.extend.mlbackProduct.productId);
							toastr.success(data.extend.resMsg);
						} else {
							toastr.error('create collecion fail! Please try again.');
						}
					} else {
						showInitBlock();
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get all data
		function getReviewsData() {
			$('.c-mask').show();

			var formData = new FormData();
			formData.append('pn', getPageNum());

			$.ajax({
				url: "${APP_PATH}/MlfrontReview/getMlfrontReviewByPage",
				type: "post",
				processData: false,
				contentType: false,
				cache: false,
				data: formData,
				success: function (data) {
					if (data.code == 100) {
						renderTable(data.extend.pageInfo.list);
						renderTablePagination(data.extend.pageInfo);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function () {
					toastr.error('Failed to get Reviews, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get one data
		function getOneReviewData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlfrontReview/getOneMlfrontReviewDetailById",
				type: "post",
				data: JSON.stringify(reqData),
				dataType: "json",
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlfrontReviewOne);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function () {
					toastr.error('Failed to get review details, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback save
		function saveReviewData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlfrontReview/save",
				type: "post",
				cache: false,
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						callback();
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback delete
		function deleteReviewData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlfrontReview/delete",
				type: "post",
				cache: false,
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						$('#deleteModal').modal('hide');
						callback();
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get all img data
		function getReviewAllImgData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackProductImg/getMlbackProductImgListByProductId",
				type: "post",
				cache: false,
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						callback(data.extend.mbackProductImgResList);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get all product
		function getAllProductData(callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackProduct/lownLoadProduct",
				type: "post",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						callback(data.extend.mlbackProductResList);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error(err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// render all product data
		function renderAllProduct(data) {
			var htmlStr = '<option value="-1">Please Select product</option>';
			for (var i = 0; i < data.length; i += 1) {
					htmlStr += '<option value="' + data[i].productId + '" data-name="'+ data[i].productName + '" data-supercate="' + data[i].productSupercateid + '">' + data[i].productId + ' * '+ data[i].productName + '</option>';
				}
			$('#reviewProduct').html(htmlStr);
		}
		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<tr><td>' + data[i].reviewId + '</td>' +
					'<td>' +
						(data[i].reviewUimgurl ?
							'<div class="c-table-img"><img src="'+ encodeUrl(data[i].reviewUimgurl) +'" /></div>'
							: '<div class="c-table-icon"><svg class="c-icon"><use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image1"></use></svg></div>') +
					'</td>' +
					'<td>' + data[i].reviewUname + '</td>' +
					'<td>' + data[i].reviewPid + '</td>' +
					'<td>' + data[i].reviewCreatetime + '</td>' +
					'<td><a class="badge '+ (data[i].reviewStatus ? 'badge-success': 'badge-danger') +'" href="javascript:;">' + (data[i].reviewStatus ? 'enable' : 'disable') + '</a></td>' +
					'<td>' + data[i].reviewProstarnum + '</td>' +
					'<td>' + (data[i].from ? 'customer' : 'self') + '</td>' +
					'<td>' +
						'<button class="btn btn-primary btn-edit" data-id="'+ data[i].reviewId +'">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
							'</svg>' +
						'</button>' +
						'<button class="btn btn-danger btn-delete" data-id="' + data[i].reviewId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
		// render review all img data
		function renderReviewAllImgData(data) {
			var len = data.length;
			$('.product-img-list').html('');

			for (var i = 0; i < len; i+=1) {
				addUploadBlock(data[i].productimgSortOrder);
				addPicture($('.product-img-item').last().find('.productAllImgurl'), {
					imageUrl: data[i].productimgurl,
					thumImageUrl: data[i].productimgSmallturl
				});
			}

			if (len < 0) addUploadBlock(1);

			if (len < 6) addUploadBlock(len);
		}
	</script>
</body>

</html>