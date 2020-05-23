<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Collection</title>
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
						<span class="c-option-title">Collections</span>
						<button class="btn btn-primary btn-create">Create collection</button>
					</div>
					<div class="c-table">
						<div class="c-table-tab">
							<div class="c-table-tab-item" data-idx="0">All</div>
						</div>
						<div class="c-table-content">
							<div class="input-group c-search">
								<svg class="c-icon">
									<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-magnifying-glass"></use>
								</svg>
								<div class="form-control">
									<input id="searchCollection" type="text" placeholder="Search Collections">						
									<select id="searchSupercate"></select>
								</div>
								<a class="btn btn-primary input-group-addon btn-save-search">Save search</a>
							</div>
							<table class="c-table-table table table-responsive-sm">
								<thead>
									<tr>
										<th>id</th>
										<th>image</th>
										<th>name</th>
										<th>parent-id</th>
										<th>parent-name</th>
										<th>tag</th>
										<th>status</th>
										<th>order</th>
										<th>path-desc</th>
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
						<span class="c-option-title">Edit Collections</span>
						<div class="group">
							<button class="btn btn-secondary btn-cancel">Cancel</button>
							<button class="btn btn-primary btn-save">Save collection</button>
						</div>
					</div>
					<div class="c-form row">
						<input id="categoryId" hidden>
						<!-- left panel  -->
						<div class="left-panel col-lg-7 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">General</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="categoryName">Collection Name</label>
										<div class="controls">
											<input class="form-control" id="categoryName" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categorySortOrder">Sort</label>
										<div class="controls">
											<select class="form-control" id="categorySortOrder" />
												<option value="0">Please select category sort-order</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">9</option>
												<option value="10">10</option>
											</select>
										</div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 col-form-label" for="categoryStatus">Status</label>
										<div class="controls col-md-3">
											<label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="categoryStatus" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categoryLable">Label</label>
										<div class="controls">
											<select class="form-control" id="categoryLable" />
												<option value="0" selected="selected">0-无图</option>
												<option value="1">1-hot</option>
												<option value="2">2-new</option>
												<option value="3">3-62% off</option>
												<option value="4">4-65% off</option>
												<option value="5">5-ins</option>
												<option value="6">6-review</option>
												<option value="7">7-video</option>
												<option value="8">8-Best Quality</option>
												<option value="9">8-15A</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categoryDesc">Description</label>
										<div class="controls">
											<input class="form-control" id="categoryDesc" type="text" disabled />
										</div>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Collection Image</div>
								</div>
								<div class="card-body">
									<div id="uploadImg" class="c-upload-img">
										<svg class="c-icon">
											<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image-plus"></use>
										</svg>
										<input type="file" />
									</div>
								</div>
							</div>
						</div>
						<!-- right panel  -->
						<div class="right-panel col-lg-5 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Super Category & Parent Category</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="categorySuperCateId">Super Category</label>
										<div class="controls">
											<select class="form-control" id="categorySuperCateId" />
												<option value="0">Please Select Super-category</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categoryParentId">Parent Category</label>
										<div class="controls">
											<select class="form-control" id="categoryParentId" />
											<option value="-1">Please Select parent-category</option>
											</select>
										</div>
									</div>
								</div>
							</div>
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Search engine listing preview</div>

									<div class="form-group">
										<label class="col-form-label" for="categorySeo">Collection SEO</label>
										<div class="controls">
											 <input class="form-control" id="categorySeo" type="text">
										</div>
									</div>
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
											<textarea class="form-control" height="100" id="categoryMetakeywords"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categoryMetadesc">Page Description</label>
										<div class="controls">
											<textarea class="form-control" height="100" id="categoryMetadesc"></textarea>
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

	<script src="${APP_PATH}/static/back/lib/tagsinput/bootstrap-tagsinput.min.js"></script>
	<script src="${APP_PATH}/static/back/lib/summernote/summernote.min.js"></script>
	<!-- custom script -->
	<script>
		var categoryData = {};
		var hasSuperCategory = false;
		var hasParentCategory = false;
		var isCreate = false;

		if (!hasSuperCategory) getSuperCategoryData(renderSuperCategory);

		// init
		renderTabItems();
		// save search
		$('.btn-save-search').on('click', function () {
			var searchCollectionVal = {
				supercate: $('#searchSupercate').find('option:selected').text(),
				supercateId: $('#searchSupercate').val(),
				collection: $('#searchCollection').val()
			};
			// cancel repeat add save-search
			if (checkNewItem(searchCollectionVal)) return;
			if (parseInt(searchCollectionVal.supercateId) == 0) searchCollectionVal.supercate = ""
			if (searchCollectionVal.supercate || searchCollectionVal.collection) {
				addCollectionItem(searchCollectionVal);
				addTableTabItem(searchCollectionVal);
			}
		});
		// search it
		/* $('#searchCollection, #searchSupercate').on('click', function() {
			$(this).one('change', function() {
				getSearchCollectionsData();
			});
		}); */
		$('#searchSupercate').on('change', function() {
			getSearchCollectionsData();
		});
		var oldTime = (new Date()).getTime(),
			timer = null;
		$('#searchCollection').on('keyup', function() {
			var distanceTime = 1000,
				newTime =  (new Date()).getTime();
			if (newTime - oldTime < 1000) clearTimeout(timer);
			oldTime = newTime;
			timer = setTimeout(function() {
				getSearchCollectionsData();
			}, distanceTime);
		})
		// tab-item click
		$(document.body).on('click', '.c-table-tab-item', function (e) {
			$('.c-table-tab-item').removeClass('active');
			$(this).addClass('active');
			setPageNum(1);
			setActiveItemNum($(this).data('idx'));
			getTabSearchData($(this));
		});
		// get Data for table
		function getTabSearchData($this) {
			setPageNum(1);
			var dataVal = $this.data('val') && JSON.parse($this.data('val').replace(/\'/g, '"'));
			if (dataVal) {
				// $('#searchCollection, #searchSupercate').off('change');
				setTimeout(function() {
					$('#searchCollection').val(dataVal.collection ? dataVal.collection : '');
					$('#searchSupercate').val(dataVal.supercateId ? dataVal.supercateId : '0');
					getSearchCollectionsData();
				}, 100)
			} else {
				getCollectionsData();
				$('#searchSupercate').val('0');
				$('#searchCollection').val('');
			}		
		}
		// tab delete
		$(document.body).on('click', '.delete-table-tab-item', deleteTableTabItem);
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {			
			getTabSearchData($('.c-table-tab-item.active'));
		});
		// create collection
		$('.btn-create').on('click', function () {
			$('.c-create c-option-title').text('Create Collection');
			showCreateBlock();
			// init formData
			resetFormData();
			getCollectionId();
			isCreate = true;
		});
		// edit collection
		$(document.body).on('click', '.btn-edit', function (e) {
			var cId = $(this).data('id');
			$('.c-create c-option-title').text('Edit Collection');
			showCreateBlock();
			resetFormData();
			initFormData(categoryData[cId]);
		});
		// delete collection
		$(document.body).on('click', '.btn-delete', function (e) {
			var categoryId = parseInt($(this).data('id'));
			$('#deleteModal').find('.modal-title').html('Delete collection!');
			$('#deleteModal').modal('show');
			$('#deleteModal .btn-ok').one('click', function () {
				deleteCollectionData({
					categoryId: categoryId,
				}, getCollectionsData);
			});
			$('#deleteModal .btn-cancel').on('click', function() {
				$('#deleteModal .btn-ok').off('click');
			});
		});
		// save collection
		$('.btn-save').on('click', function () {
			saveCollectionData(getFormData(), function() {
				getCollectionsData();
				showInitBlock();
				isCreate = false;
				initActiveItemNum();
			});
		});
		// cancel collection save
		$('.btn-cancel').on('click', function () {
			if (isCreate) {
				getCollectionsData();
				isCreate = false;
				initActiveItemNum();
			}

			showInitBlock();
		});
		// status combinewith supercate
		$('#categoryStatus').on('click', function(e) {
			if ($('#categorySuperCateId').val() == '0') {
				toastr.info('Please Select super-category!');
				$('#categorySuperCateId').focus();
				$('#categoryStatus').prop('checked', false)
			}
		})
		function showCreateBlock() {
			$('.c-init').addClass('hide');
			$('.c-create').removeClass('hide');

			if (!hasParentCategory) getParentCategoryData(renderParentCategory);
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-create').addClass('hide');
		}
		// handle formData
		// reset data
		function resetFormData() {
			$('#categoryId').val('');
			$('#categoryName').val('');
			$('#categorySortOrder').val('0');
			$('#categoryStatus').prop('checked', false);
			$('#categoryLable').val('0');
			$('#categoryDesc').val('');

			$('#categoryImgurl').val('');

			setTimeout(function() {
				$('#categorySuperCateId').val('0');
				$('#categoryParentId').val('-1');				
			});

			$('#categorySeo').val('');
			$('#categoryMetatitle').val('');
			$('#categoryMetakeywords').val('');
			$('#categoryMetadesc').val('');
		}
		// getFormdData
		function getFormData() {
			var data = {};
			data.categoryId = parseInt($('#categoryId').val());
			data.categoryName = $('#categoryName').val();
			data.categoryStatus = $('#categoryStatus').prop('checked') ? 1 : 0;
			data.categorySortOrder = $('#categorySortOrder').val();
			data.categoryLable = parseInt($('#categoryLable').val());
			data.categoryDesc = $('#categoryDesc').val();

			data.categoryImgurl = $('#categoryImgurl').val();

			data.categorySuperCateId = $('#categorySuperCateId').val();
			data.categorySuperCateName = $('#categorySuperCateId').find('option:selected').text();

			data.categoryParentId = $('#categoryParentId').val();
			data.categoryParentName = $('#categoryParentId').find('option:selected').data('name');

			data.categorySeo = $('#categorySeo').val();
			data.categoryMetatitle = $('#categoryMetatitle').val();
			data.categoryMetakeywords = $('#categoryMetakeywords').val();
			data.categoryMetadesc = $('#categoryMetadesc').val();

			return data;
		}
		// initFormData
		function initFormData(data) {
			$('#categoryId').val(data.categoryId);
			$('#categoryName').val(data.categoryName);
			$('#categorySortOrder').val(data.categorySortOrder ? data.categorySortOrder : '0');
			$('#categoryStatus').prop('checked', (data.categorySuperCateId > 0 ? data.categoryStatus : 0));
			$('#categoryLable').val(data.categoryLable);
			$('#categoryDesc').val(data.categoryDesc);

			$('#categorySuperCateId').val(data.categorySuperCateId ? data.categorySuperCateId : 0);
			$('#categoryParentId').val(data.categoryParentId);

			$('#categoryImgurl').val(data.categoryImgurl);

			$('#categorySeo').val(data.categorySeo);
			$('#categoryMetatitle').val(data.categoryMetatitle);
			$('#categoryMetakeywords').val(data.categoryMetakeywords);
			$('#categoryMetadesc').val(data.categoryMetadesc);
		}
		// callback get id
		function getCollectionId() {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackCategory/initializaCategory",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						var categoryId = data.extend&& data.extend.mlbackCategory && data.extend.mlbackCategory.categoryId;
						if (categoryId) {
							$('#categoryId').val(data.extend.mlbackCategory.categoryId);
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
		// callback get data
		function getCollectionsData() {
			$('.c-mask').show();
			var formData = 'pn=' + getPageNum();
			$.ajax({
				url: "${APP_PATH }/MlbackCategory/getMlbackCategoryByPage",
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
		// callback get search data
		function getSearchCollectionsData(data) {
			$('.c-mask').show();
			var formData = '';
			formData += 'categoryName=' + $('#searchCollection').val();
			formData += '&categorySuperCateId=' + ($('#searchSupercate').val() || '0');
			formData += '&pn=' + getPageNum();
			$.ajax({
				url: "${APP_PATH }/MlbackCategory/backSearchBycategory",
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
		function saveCollectionData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCategory/save",
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
		function deleteCollectionData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCategory/delete",
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

		// callback parentCategory
		function getParentCategoryData(callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCategory/getOneMlbackCategoryParentDetail",
				type: "post",
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						toastr.success(data.extend.resMsg);
						callback(data.extend.mlbackCategorydownList);
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
				categoryData[data[i].categoryId] = data[i];
				htmlStr += '<tr><td>' + data[i].categoryId + '</td>' +
					'<td><div class="c-table-img" style="background-image: url(' + data[i].categoryImgurl + ');"></div></td>' +
					'<td>' + data[i].categoryName + '</td>' +
					'<td>' + data[i].categoryParentId + '</td>' +
					'<td>' + data[i].categoryParentName + '</td>' +
					'<td>' + data[i].categoryLable + '</td>' +
					'<td>' + (data[i].categoryStatus ? 'enable' : 'disable') + '</td>' +
					'<td>' + data[i].categorySortOrder + '</td>' +
					'<td>' + data[i].categoryDesc + '</td>' +
					'<td>' +
					'<button class="btn btn-primary btn-edit" data-id="' + data[i].categoryId + '">' +
					'<svg class="c-icon">' +
					'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
					'</svg>' +
					'</button>' +
					'<button class="btn btn-danger btn-delete" data-id="' + data[i].categoryId + '">' +
					'<svg class="c-icon">' +
					'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
					'</svg>' +
					'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
		// render superCategoryData
		function renderSuperCategory(data) {
			var htmlStr = $('#categorySuperCateId').html();
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<option value="' + data[i].supercateId + '">' + data[i].supercateName + '</option>';
			}
			$('#categorySuperCateId').html(htmlStr);
			$('#searchSupercate').html(htmlStr);
			hasSuperCategory = true;
		}
		// render parentCategoryData
		function renderParentCategory(data) {
			var htmlStr = $('#categoryParentId').html();
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<option value="' + data[i].categoryId + '" data-name="' + data[i].categoryName + '">' + data[i].categoryDesc + '</option>';
			}
			$('#categoryParentId').html(htmlStr);
			hasParentCategory = true;
		}
		function renderTabItems() {
			var collections = getCollectionList(),
				len = collections.length,
				htmlStr = '',
				activeNum = parseInt(getActiveItemNum());

			if (len > 0) {
				for (var i = 0; i < len; i += 1) {
					var $item = createCollectionItem(collections[i]);
					$item.attr('data-idx', i+1);

					if (activeNum == i + 1) {
						$item.addClass('active')
					}

					htmlStr += $item[0].outerHTML;
				}

				$('.c-table-tab').append(htmlStr);
			}
			// check activeItem exsits or not.
			if ($('.c-table-tab-item.active').length < 1) {
				$('.c-table-tab-item').eq(0).addClass('active');
			}

			getTabSearchData($('.c-table-tab-item.active'));
		}
		function checkNewItem(val) {
			var filterArr = getCollectionList().filter(function(item) {
				if (JSON.stringify(val) === JSON.stringify(item)) {
					return item;
				}
			});
			return filterArr.length ? true : false;
		}
		function addTableTabItem(val) {
			$('.c-table-tab-item').removeClass('active');
			$('.c-table-tab').append(createCollectionItem(val).addClass('active'));
			setActiveItemNum($('.c-table-tab-item').length - 1);
		}
		function createCollectionItem(val) {
			var textArr = [];
			if (val.supercate) {
				textArr.push(val.supercate)
			}
			if (val.collection) {
				textArr.push(val.collection)
			}

			return $('<div class="c-table-tab-item" data-val="'+ JSON.stringify(val).replace(/\"/g, "'") +'">' + textArr.join("-") +
				'<div class="delete-table-tab-item c-icon">x</div></div>');
		}
		function deleteTableTabItem(e) {
			e.stopPropagation();
			var targetEl = $(e.target),
				parentEl = targetEl.parent('.c-table-tab-item'),
				itemVal = JSON.parse($(parentEl).data('val').replace(/\'/g, '"'));

			deleteCollectionItem(itemVal);
			$(parentEl).remove();

			$('.c-table-tab-item').eq(0).addClass('active');
			getTabSearchData($('.c-table-tab-item').eq(0));
		}
		function getCollectionList() {
			return JSON.parse(storage.getItem('collections')) || [];
		}
		function deleteCollectionItem(name) {
			var oldCollections = getCollectionList();
			var newCollections = oldCollections.filter(function (item) {
				if (JSON.stringify(item) != JSON.stringify(name)) return item;
			});
			storage.setItem('collections', JSON.stringify(newCollections));
		}
		function addCollectionItem(name) {
			var collections = getCollectionList();
			collections.push(name);
			storage.setItem('collections', JSON.stringify(collections));
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