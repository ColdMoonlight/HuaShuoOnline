<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Product Together</title>
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
						<span class="c-option-title">Product-Together list</span>
						<button class="btn btn-primary btn-create">Create Product-Together</button>
					</div>
					<div class="c-table">
						<div class="c-table-tab">
							<div class="c-table-tab-item" data-idx="0">All</div>
							<div class="c-table-tab-list"></div>
							<div class="c-table-tab-tempory"></div>
						</div>
						<div class="c-table-content">
							<div class="input-group c-search">
								<svg class="c-icon">
									<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-magnifying-glass"></use>
								</svg>
								<div class="form-control">
									<input id="search-name" type="text" placeholder="Search proudct-together name...">						
									<select class="supercate-list" id="search-supercate"></select>
								</div>
								<a class="btn btn-primary input-group-addon btn-save-search">Save search</a>
							</div>
							<div class="c-table-table table-responsive-sm">
								<table class="table">
									<thead>
										<tr>
											<th>id</th>
											<th>name</th>
											<th>status</th>
											<th>operate</th>
										</tr>
									</thead>
									<tbody></tbody>
								</table>
							</div>
							<div id="table-pagination"></div>
						</div>
					</div>
				</div>
				<!-- edit or create -->
				<div class="c-view hide">
					<div class="c-option">
						<span class="c-option-title">View Product-Together</span>
						<div class="group">
							<button class="btn btn-secondary btn-back">Back</button>
							<button class="btn btn-primary btn-save">Save</button>
						</div>
					</div>
					<div class="c-form row">
						<input id="producttogetherId" hidden>
						<!-- left panel -->
						<div class="left-panel col-lg-7 col-md-12">
							<div class="card">
								<div class="card-body">
									<div class="form-group row">
										<label class="col-md-3 col-form-label" for="producttogetherStatus">Status</label>
										<div class="controls col-md-3">
											<label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="producttogetherStatus" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="producttogetherName">ProductTogether Name</label>
										<div class="controls">
											<input class="form-control" id="producttogetherName" type="text" />
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- right panel  -->
						<div class="right-panel col-lg-5 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Super Category & Product-list</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="producttogetherSupercateId">Super Category</label>
										<div class="controls">
											<select class="form-control supercate-list" id="producttogetherSupercateId" /></select>
										</div>
									</div>
									<!-- <div class="form-group">
										<label class="col-form-label" for="profbreviewAreaPid">Product list</label>
										<div class="controls">
											<select class="form-control product-list" id="profbreviewAreaPid" /></select>
										</div>
									</div> -->
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
		var hasSuperCateList = false;
		var isCreate = false, oldTime = (new Date()).getTime(), timer = null, storageName = "product-together";

		if (!hasSuperCateList) getSuperCategoryData(renderSuperCategory);
		$('#search-supercate').val($('#search-supercate').data('val') || -1);

		// init
		renderTabItems();
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getTabSearchData($('.c-table-tab-item.active'));
		});
		// create wholesale
		$('.btn-create').on('click', function () {
			$('.c-view c-option-title').text('Create Product-Together');
			showViewBlock();
			getProductTogetherId();
			isCreate = true;
		});
		$('.btn-back').on('click', function () {
			$('.c-view c-option-title').text('Product-Together List');
			showInitBlock();
			resetFormData();
		});
		// tab-item click
		$(document.body).on('click', '.c-table-tab-item', function (e) {
			$('.c-table-tab-item').removeClass('active');
			$(this).addClass('active');
			// inital pagination num
			setPageNum(1);
			setActiveItemNum($(this).data('idx'));
			getTabSearchData($(this));
		});
		// tab delete
		$(document.body).on('click', '.delete-table-tab-item', deleteTableTabItem);
		// save search
		$('.btn-save-search').on('click', function () {
			var searchVal = {
				supercate: $('#search-supercate').find('option:selected').text(),
				supercateid: $('#search-supercate').val(),
				name: $('#search-name').val()
			};
			// cancel repeat add save-search
			if (checkNewItem(searchVal)) return;

			if (parseInt(searchVal.supercateid) < 0) searchVal.supercate = "";

			if (searchVal.supercate > -1 || searchVal.name) {
				addStorageItem(searchVal);
				$('.c-table-tab-tempory').html('');
				createTableTabItem(searchVal);
				addTableTabItem(searchVal, $('.c-table-tab-item').length);
			}
		});
		// search it
		$('#search-supercate').on('change', function() {
			$(this).attr('data-val', $(this).val());
			updateSearchData();
		});
		$('#search-name').on('keyup', function() {
			var distanceTime = 1000,
				newTime =  (new Date()).getTime();
			if (newTime - oldTime < 1000) clearTimeout(timer);
			oldTime = newTime;
			timer = setTimeout(function() {
				updateSearchData();
			}, distanceTime);
		});
		// edit product-together
		$(document.body).on('click', '.btn-edit', function (e) {
			var producttogetherId = parseInt($(this).data('id') || $(this).find('.btn-edit').data('id'));
			getOneProductTogetherData({
				producttogetherId: producttogetherId
			}, function(resData) {
				$('.c-view c-option-title').text('View Product-Together');
				initFormData(resData);;
				showViewBlock();
			});
		});
		// save product-together
		$('.c-view .btn-save').on('click', function () {
			var reqData = getFormData();
			saveProductTogetherData(reqData, function() {
				showInitBlock();
				getProductTogethersData();
				$('#producttogetherId').val('');
			});
		});
		// delete product-together
		$(document.body).on('click', '.btn-delete', function (e) {
			var producttogetherId = parseInt($(this).data('id'));
			$('#deleteModal').find('.modal-title').html('Delete product-together!');
			$('#deleteModal').modal('show');
			$('#deleteModal .btn-ok').one('click', function () {
				deleteProductTogetherData({
					producttogetherId: producttogetherId,
				}, function() {
					getProductTogethersData();
				});
			});
		});
		// handle formData
		// reset data
		function resetFormData() {
			$('#producttogetherId').val('');
			$('#producttogetherName').val('');
			$('#producttogetherStatus').prop('checked', false);

			$('#producttogetherSupercateId').val('-1');
		}
		// getFormdData
		function getFormData() {
			var data = {};
			data.producttogetherId = parseInt($('#producttogetherId').val());
			data.producttogetherName = $('#producttogetherName').val();
			data.producttogetherStatus = $('#producttogetherStatus').prop('checked') ? 1 : 0;

			data.producttogetherSupercateId = $('#producttogetherSupercateId').val();
			data.producttogetherSupercateName = $('#producttogetherSupercateId').find('option:checked').text();
			return data;
		}
		// initFormData
		function initFormData(data) {
			$('#producttogetherId').val(data.producttogetherId);
			$('#producttogetherName').val(data.producttogetherName);
			$('#producttogetherStatus').prop('checked', (''+data.producttogetherStatus == '0' ? false : true));

			$('#producttogetherSupercateId').val(data.producttogetherSupercateId || '-1');
		}
		// search status change
		function updateSearchData() {
			var searchVal = {
				supercate: $('#search-supercate').find('option:selected').text(),
				supercateid: $('#search-supercate').val(),
				name: $('#search-name').val()
			};
			if (parseInt(searchVal.supercateid) < 0) searchVal.supercate = "";
			// inital pagination num
			setPageNum(1);
			// check search product-together
			$('.c-table-tab-item.active').removeClass('active');
			$('.c-table-tab-tempory').html(createTableTabItem(searchVal).addClass('active'));
			getTabSearchData($('.c-table-tab-tempory .c-table-tab-item'));
		}
		// tab view/init
		function showViewBlock() {
			$('.c-init').addClass('hide');
			$('.c-view').removeClass('hide');
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-view').addClass('hide');
		}
		// get Data for table
		function getTabSearchData($this) {
			var dataVal = $this.data('val');
			if (dataVal && (dataVal.supercate || dataVal.name)) {
				$('#search-name').val(dataVal.name || '');
				$('#search-supercate').attr('data-val', dataVal.supercateid || '-1');
				$('#search-supercate').val(dataVal.supercateid || '-1');
				getSearchProductTogetherData();
			} else {
				$('#search-name').val('');
				$('#search-supercate').val('-1');
				initActiveItemNum();
				getProductTogethersData();
			}
		}
		//  callback get all
		function getProductTogethersData() {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/productTogether/getProductTogetherByPage",
				type: "post",
				data: "pn=" + getPageNum(),
				success: function (data) {
					if (data.code == 100) {
						renderTable(data.extend.pageInfo.list);
						renderTablePagination(data.extend.pageInfo);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('Failed to get Product-Togethers, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get search data
		function getSearchProductTogetherData(data) {
			$('.c-mask').show();

			var formData = new FormData();
			formData.append('producttogetherName', $('#search-name').val());
			formData.append('producttogetherSupercateId', ($('#search-supercate').attr('data-val') || '-1'));
			formData.append('pn', getPageNum());

			$.ajax({
				url: "${APP_PATH}/productTogether/backSearchByProductTogether",
				type: "post",
				data: formData,
				processData: false,
				contentType: false,
				cache: false,
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
					toastr.error('Failed to get Product-Togethers data, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback initial id
		function getProductTogetherId(callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/productTogether/initializaProductTogether",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						var producttogetherId = data.extend&& data.extend.mlbackProductTogether && data.extend.mlbackProductTogether.categoryId;
						if (producttogetherId) {
							$('#producttogetherId').val(data.extend.mlbackProductTogether.producttogetherId);
							toastr.success(data.extend.resMsg);
						} else {
							toastr.error('create Product-together fail! Please try again.');
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
		// callback save
		function saveProductTogetherData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
		  		url: '${APP_PATH}/productTogether/save',
		  		type: 'post',
		  		dataType: 'json',
		  		data: JSON.stringify(reqData),
		  		contentType: 'application/json',
		  		success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						callback && callback();
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
		// callback get one product-together data
		function getOneProductTogetherData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/productTogether/getOneMlbackProductTogetherDetail",
				type: "post",
				data: JSON.stringify(reqData),
				dataType: "json",
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlbackProductTogetherOne);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('Failed to get product-together data, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback delete
		function deleteProductTogetherData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/productTogether/delete",
				type: "post",
				cache: false,
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						$('#deleteModal').modal('hide');
						callback && callback();
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
		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<tr><td>' + data[i].producttogetherId + '</td>' +
					'<td>' + data[i].producttogetherName + '</td>' +
					'<td><a class="badge '+ ('' + data[i].producttogetherStatus == '0' ? 'badge-danger': 'badge-success') +'" href="javascript:;">' + ('' + data[i].producttogetherStatus == '0' ? 'Uncontacted' : 'Contacted') + '</a></td>' +
					'<td>' +
						'<button class="btn btn-primary btn-edit" data-id="' + data[i].producttogetherId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
							'</svg>' +
						'</button>' +
						'<button class="btn btn-danger btn-delete" data-id="' + data[i].producttogetherId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
	</script>
</body>

</html>