<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>footer nav</title>
	<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/back/lib/summernote/summernote.min.css" rel="stylesheet">
	<link href="${APP_PATH}/static/back/lib/tagsinput/bootstrap-tagsinput.css" rel="stylesheet">
</head>

<body class="c-app">
	<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
	<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
	<div class="c-wrapper">
		<div class="c-body">
			<div class="c-main">
				<div class="c-init">
					<div class="c-option">
						<span class="c-option-title">Footer Navs</span>
						<button class="btn btn-primary btn-create">Create FooterNav</button>
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
									<input id="searchFootnav" type="text" placeholder="Search FooterNavs">
									<select id="searchSupercate"></select>
								</div>
								<a class="btn btn-primary input-group-addon btn-save-search">Save search</a>
							</div>
							<table class="c-table-table table table-responsive-sm">
								<thead>
									<tr>
										<th>id</th>
										<th>name</th>
										<th>supercate</th>
										<th>column</th>
										<th>row</th>
										<th>status</th>
										<th>isClick</th>
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
						<span class="c-option-title">Edit FooterNav</span>
						<div class="group">
							<button class="btn btn-secondary btn-cancel">Cancel</button>
							<button class="btn btn-primary btn-save">Save FooterNav</button>
						</div>
					</div>
					<div class="c-form row">
						<input id="footnavId" hidden>
						<!-- left panel  -->
						<div class="left-panel col-lg-7 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">General</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="footnavName">FooterNav Name</label>
										<div class="controls">
											<input class="form-control" id="footnavName" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="footnavLie">Column</label>
										<div class="controls">
											<select class="form-control" id="footnavLie" />
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="footnavHang">Row</label>
										<div class="controls">
											<select class="form-control" id="footnavHang" />
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">9</option>
											</select>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 col-form-label" for="footnavIfshow">Status</label>
										<div class="controls col-md-3">
											<label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="footnavIfshow" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 col-form-label" for="footnavIfincome">isClick</label>
										<div class="controls col-md-3">
											<label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="footnavIfincome" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="footnavDesc">Description</label>
										<div class="controls">
											<textarea class="form-control" id="footnavDesc" row="6"></textarea>
										</div>
									</div>
								</div>
							</div>
						</div>
						<!-- right panel  -->
						<div class="right-panel col-lg-5 col-md-12">
							<!-- parent category -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Super Category</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="footnavSuperCateId">Super Category</label>
										<div class="controls">
											<select class="form-control" id="footnavSuperCateId"></select>
										</div>
									</div>
								</div>
							</div>
							<!-- seo -->
							<!-- <div class="card">
								<div class="card-title">
									<div class="card-title-name">Search engine listing preview</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="categoryMetatitle">Page title</label>
										<div class="controls">
											<input class="form-control" id="categoryMetatitle" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categoryMetakeywords">Page keywords</label>
										<div class="controls">
											<textarea class="form-control" rows="5" id="categoryMetakeywords"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categoryMetadesc">Page Description</label>
										<div class="controls">
											<textarea class="form-control" rows="5" id="categoryMetadesc"></textarea>
										</div>
									</div>
								</div>
							</div> -->
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

	<script src="${APP_PATH}/static/back/lib/tagsinput/bootstrap-tagsinput.min.js"></script>
	<script src="${APP_PATH}/static/back/lib/summernote/summernote.min.js"></script>
	<!-- custom script -->
	<script>
		var hasSuperCategory = false;
		var isCreate = false;

		// init
		renderTabItems();
		// init summernote editor for description
		$('#footnavDesc').summernote({
			height: 300,
	        toolbar: [
				['style', ['style', 'bold', 'italic', 'underline', 'clear']],
				['fontsize', ['fontsize']],
				['height', ['height']],
				['color', ['color']],
				['para', ['ul', 'ol', 'paragraph']],
				['table', ['table']],
				['insert', ['link', 'picture', 'video']],
				['view', ['codeview']]
	        ]
	   	});
		// inital supercategory
		if (!hasSuperCategory) getSuperCategoryData(renderSuperCategory);
		// save search
		$('.btn-save-search').on('click', function () {
			var searchFootnavVal = {
				footnav: $('#searchFootnav').val(),
				supercate: $('#searchSupercate').find('option:selected').text(),
				supercateId: $('#searchSupercate').val(),
			};
			// cancel repeat add save-search
			if (checkNewItem(searchFootnavVal)) return;
			if (parseInt(searchProductVal.supercateId) < 0) searchProductVal.supercate = "";
			if (searchFootnavVal.supercate || searchFootnavVal.footnav) {
				addFootnavItem(searchFootnavVal);
				createFootnavItem(searchFootnavVal).addClass('active')
				addTableTabItem(searchFootnavVal);
				$('.c-table-tab-tempory').html('');
			}
		});
		var oldTime = (new Date()).getTime(),
			timer = null;
		$('#searchFootnav').on('keyup', function() {
			var distanceTime = 1000,
				newTime =  (new Date()).getTime();
			if (newTime - oldTime < 1000) clearTimeout(timer);
			oldTime = newTime;
			timer = setTimeout(function() {
				updateSearchData();
			}, distanceTime);
		});
		// search status change
		function updateSearchData() {
			var searchFootnavVal = {
				supercate: $('#searchSupercate').find('option:selected').text(),
				supercateId: $('#searchSupercate').val(),
				footnav: $('#searchFootnav').val()
			};
			// inital pagination num
			setPageNum(1);

			$('.c-table-tab-item.active').removeClass('active');
			$('.c-table-tab-tempory').html(createFootnavItem(searchFootnavVal).addClass('active'));
			getTabSearchData($('.c-table-tab-tempory .c-table-tab-item'));
		}
		// tab-item click
		$(document.body).on('click', '.c-table-tab-item', function (e) {
			$('.c-table-tab-item').removeClass('active');
			$(this).addClass('active');
			// inital pagination num
			setPageNum(1);
			setActiveItemNum($(this).data('idx'));
			getTabSearchData($(this));
		});
		// get Data for table
		function getTabSearchData($this) {
			var dataVal = $this.data('val');
			if (dataVal) {
				$('#searchSupercate').attr('data-val', dataVal.supercateId || '-1');
				$('#searchSupercate').val(dataVal.supercateId || '-1');
				$('#searchFootnav').val(dataVal.footnav || '');
				getSearchFootnavsData();
			} else {
				$('#searchSupercate').val('-1');
				$('#searchFootnav').val('');
				getFootnavsData();
			}
		}
		// tab delete
		$(document.body).on('click', '.delete-table-tab-item', deleteTableTabItem);
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getTabSearchData($('.c-table-tab-item.active'));
		});
		// create Footnav
		$('.btn-create').on('click', function () {
			$('.c-create .c-option-title').text('Create FooterNav');
			showCreateBlock();
			// init formData
			resetFormData();
			getFootnavId();
			isCreate = true;
		});
		// edit Footnav
		$(document.body).on('click', '.btn-edit', function (e) {
			var footnavId = $(this).data('id');
			getOneFootnavData({
				"footnavId": footnavId
			}, function(resData) {
			 	$('.c-create .c-option-title').text('Edit FooterNav');
				showCreateBlock();
				initFormData(resData);
			});			
		});
		// delete Footnav
		$(document.body).on('click', '.btn-delete', function (e) {
			var footnavId = parseInt($(this).data('id'));
			$('#deleteModal').find('.modal-title').html('Delete FooterNav!');
			$('#deleteModal').modal('show');
			$('#deleteModal .btn-ok').one('click', function () {
				deleteFootnavData({
					footnavId: footnavId,
				}, getFootnavsData);
			});
		});
		// save Footnav
		$('.c-create .btn-save').on('click', function () {
			var reqData = getFormData();
			if (!reqData.footnavName.trim()) {
				toastr.error('Footernav name cannot be empty！');
				return ;
			}
			saveFootnavData(reqData, function() {
				// redirect tab-active & then search-data
				if (isCreate) {
					isCreate = false;
					initActiveItemNum();
					$('.c-table-tab-item').removeClass('active').eq(0).addClass('active');
				}

				getTabSearchData($('.c-table-tab-item.active'));
				showInitBlock();
			});
		});
		// cancel Footnav save
		$('.c-create .btn-cancel').on('click', function () {
			if (isCreate) {
				isCreate = false;
				/* initActiveItemNum(); */
				// delete null Footnav
				deleteFootnavData({
					"footnavId": $('#footnavId').val(),
				}, function() {
					console.log("cancel create-Footnav");
				});
				// fetch default Footnav
				// getFootnavsData();
			}

			showInitBlock();
		});
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
			$('#footnavId').val('');
			$('#footnavName').val('');
			$('#footnavLie').val('0');
			$('#footnavHang').val('0');
			$('#footnavIfshow').prop('checked', false);
			$('#footnavIfincome').prop('checked', false);
			$('#footnavDesc').summernote('reset'); 

			$('#footnavSuperCateId').val('-1');
			
			/* $('#footnavSeo').val('');
			$('#footnavMetatitle').val('');
			$('#footnavMetakeywords').val('');
			$('#footnavMetadesc').val(''); */
		}
		// getFormdData
		function getFormData() {
			var data = {};
			data.footnavId = parseInt($('#footnavId').val());
			data.footnavName = $('#footnavName').val();
			data.footnavLie = $('#footnavLie').val();
			data.footnavHang = $('#footnavHang').val();
			data.footnavIfshow = $('#footnavIfshow').prop('checked') ? 1 : 0;
			data.footnavIfincome = $('#footnavIfincome').prop('checked') ? 1 : 0;
			data.footnavDesc = $('#footnavDesc').val();
			
			data.footnavSuperCateId = $('#footnavSuperCateId').val();
			data.footnavSuperCateName = $('#footnavSuperCateId').find('option:checked').text().trim();

			/* data.footnavSeo = $('#footnavSeo').val();
			data.footnavMetatitle = $('#footnavMetatitle').val();
			data.footnavMetakeywords = $('#footnavMetakeywords').val();
			data.footnavMetadesc = $('#footnavMetadesc').val(); */

			return data;
		}
		// initFormData
		function initFormData(data) {
			$('#footnavId').val(data.footnavId);
			$('#footnavName').val(data.footnavName);
			$('#footnavLie').val(data.footnavLie);
			$('#footnavHang').val(data.footnavHang);
			$('#footnavIfshow').prop('checked', (data.footnavIfshow > 0 ? data.footnavIfshow : 0));
			$('#footnavIfincome').prop('checked', (data.footnavIfincome > 0 ? data.footnavIfincome : 0));
			$('#footnavDesc').summernote('code', data.footnavDesc);
			
			$('#footnavSuperCateId').val(data.footnavSuperCateId);

			$('#footnavSeo').val(data.footnavSeo);
			$('#footnavMetatitle').val(data.footnavMetatitle);
			$('#footnavMetakeywords').val(data.footnavMetakeywords);
			$('#footnavMetadesc').val(data.footnavMetadesc);
		}
		// callback superCategory
		function getSuperCategoryData(callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackSuperCate/getSuperCateDownList",
				type: "post",
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						callback(data.extend.mlbackSuperCateResList);
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
		// render superCategoryData
		function renderSuperCategory(data) {
			var htmlStr = '<option value="-1">Please Select Super-category</option>';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<option value="' + data[i].supercateId + '">' + data[i].supercateName + '</option>';
			}
			$('#footnavSuperCateId').html(htmlStr);
			$('#searchSupercate').html(htmlStr);
			hasSuperCategory = true;
		}
		// callback get id
		function getFootnavId() {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackFootNav/initializaFootNav",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						var footnavId = data.extend&& data.extend.mlbackFootNav && data.extend.mlbackFootNav.footnavId;
						if (footnavId) {
							$('#footnavId').val(footnavId);
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
		function getFootnavsData() {
			$('.c-mask').show();
			var formData = 'pn=' + getPageNum();
			$.ajax({
				url: "${APP_PATH }/MlbackFootNav/getMlbackFootNavByPage",
				type: "post",
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
					toastr.error('Failed to get Categeory, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get one data
		function getOneFootnavData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackFootNav/getOneMlbackFootNavOneAllDetail",
				type: "post",
				data: reqData,
				/* data: JSON.stringify(reqData),
				/* dataType: 'json',
				contentType: 'application/json', */
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.MlbackFootNavOne);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function () {
					toastr.error('Failed to get Categeory, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get search data
		function getSearchFootnavsData(data) {
			$('.c-mask').show();
			// formdata issue, need to check formdata ?
			var formData = '';
			formData += 'categoryName=' + $('#searchFootnav').val();
			formData += ('&categorySuperCateId=' + ($('#searchSupercate').attr('data-val') || '-1'));
			formData += '&pn=' + getPageNum();

			$.ajax({
				url: "${APP_PATH }/MlbackFootNav/backSearchBycategory",
				type: "post",
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
					toastr.error('Failed to get Categeory, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback save
		function saveFootnavData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackFootNav/save",
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
		function deleteFootnavData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackFootNav/delete",
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
		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<tr><td>' + data[i].footnavId + '</td>' +
					'<td>' + data[i].footnavName + '</td>' +
					'<td>' + data[i].footnavSuperCateName + '</td>' +
					'<td>' + data[i].footnavLie + '</td>' +
					'<td>' + data[i].footnavHang + '</td>' +
					'<td><a class="badge '+ (data[i].footnavIfshow ? 'badge-success': 'badge-danger') +'" href="javascript:;">' + (data[i].footnavIfshow ? 'enable' : 'disable') + '</a></td>' +
					'<td><a class="badge '+ (data[i].footnavIfincome ? 'badge-success': 'badge-danger') +'" href="javascript:;">' + (data[i].footnavIfincome ? 'enable' : 'disable') + '</a></td>' +
					'<td>' +
						'<button class="btn btn-primary btn-edit" data-id="' + data[i].footnavId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
							'</svg>' +
						'</button>' +
						'<button class="btn btn-danger btn-delete" data-id="' + data[i].footnavId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
		function renderTabItems() {
			var footnavs = getFootnavList(),
				len = footnavs.length,
				htmlStr = '',
				activeNum = parseInt(getActiveItemNum());

			if (len > 0) {
				for (var i = 0; i < len; i += 1) {
					var $item = createFootnavItem(footnavs[i]);
					$item.attr('data-idx', i+1);

					if (activeNum == i + 1) {
						$item.addClass('active')
					}

					htmlStr += $item[0].outerHTML;
				}

				$('.c-table-tab-list').append(htmlStr);
			}
			// check activeItem exsits or not.
			if ($('.c-table-tab-item.active').length < 1) {
				$('.c-table-tab-item').eq(0).addClass('active');
			}

			getTabSearchData($('.c-table-tab-item.active'));
		}
		function checkNewItem(val) {
			var collecitonList = getFootnavList();
			if (collecitonList.length >= 6) {
				// save-search-item num <= 6
				toastr.info('You can add up to six search records！');
				return true;
			}
				
			var filterArr = collecitonList.filter(function(item) {
				if (JSON.stringify(val) === JSON.stringify(item)) {
					return item;
				}
			});

			if (filterArr.length > 0) {
				toastr.info('You can not add it repeatedly！');
				return true;
			}
			return false;
		}
		function addTableTabItem(val) {
			$('.c-table-tab-item').removeClass('active');
			$('.c-table-tab-list').append(createFootnavItem(val).addClass('active'));
			setActiveItemNum($('.c-table-tab-item').length - 1);
		}
		function createFootnavItem(val) {
			var textArr = [];
			if (val.supercate) {
				textArr.push(val.supercate)
			}
			if (val.footnav) {
				textArr.push(val.footnav)
			}

			return $('<div class="c-table-tab-item">' + textArr.join("-") + '<div class="delete-table-tab-item c-icon">x</div></div>').attr('data-val', JSON.stringify(val));
		}
		function deleteTableTabItem(e) {
			e.stopPropagation();
			var targetEl = $(e.target),
				parentEl = targetEl.parent('.c-table-tab-item'),
				itemVal = $(parentEl).data('val');

			deleteFootnavItem(itemVal);
			$(parentEl).remove();

			$('.c-table-tab-item').eq(0).addClass('active');
			getTabSearchData($('.c-table-tab-item').eq(0));
		}
		function getFootnavList() {
			return JSON.parse(storage.getItem('footnavs')) || [];
		}
		function deleteFootnavItem(name) {
			var oldFootnavs = getFootnavList();
			var newFootnavs = oldFootnavs.filter(function (item) {
				if (JSON.stringify(item) != JSON.stringify(name)) return item;
			});
			storage.setItem('footnavs', JSON.stringify(newFootnavs));
		}
		function addFootnavItem(name) {
			var footnavs = getFootnavList();
			footnavs.push(name);
			storage.setItem('footnavs', JSON.stringify(footnavs));
		}
		// tab active-item cache (get & set)
		function getActiveItemNum() {
			return storage.getItem('itemNum') || 0;
		}
		function setActiveItemNum(num) {
			storage.setItem('itemNum', num);
		}
		// initial activeItem
		function initActiveItemNum() {
			$('.c-table-tab-item').removeClass('active').eq(0).addClass('active');
			setActiveItemNum(0);
			setPageNum(1);
		}
	</script>
</body>

</html>