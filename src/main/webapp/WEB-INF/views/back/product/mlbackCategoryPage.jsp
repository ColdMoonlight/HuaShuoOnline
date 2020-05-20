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
								<div class="c-table-tab-item active">All</div>
							</div>
							<div class="c-table-content">
								<div class="input-group c-search">
									<svg class="c-icon">
										<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-magnifying-glass"></use>
									</svg>
									<input class="form-control" name="searchCollection" type="text" placeholder="Search Collections">
									<a class="btn btn-primary input-group-addon btn-save-search">Save search</a>
								</div>
								<table class="c-table-table table table-responsive-sm">
									<thead>
										<tr>
											<th>id</th>
											<th>image</th>
											<th>name</th>
											<th>parent Id</th>
											<th>parent name</th>
											<th>tag</th>
											<th>status</th>
											<th>order</th>
											<th>path desc</th>
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
							<!-- /*
							"categoryId": 167,
			                "categoryName": "6x6 Lace Closure Wig",
			                "categoryImgurl": "http://localhost:8080/ShopTemplate/static/img/category/cateid167time611325.jpg",
			                "categoryParentId": 65,
			                "categoryParentName": "Wig By Cap",
			                "categoryStatus": 1,
			                "categoryLable": 0,
			                "categorySeo": "6x6-Closure-Wig",
			                "categorySortOrder": 8,
			                "categoryCreatetime": null,
			                "categoryMotifytime": "2020-03-27 16:29:17",
			                "categoryDesc": "HUMAN HAIR WIG>Wig By Cap>6x6 Lace Closure Wig",
			                "categoryProductIds": "291,292",
			                "categoryProductNames": "6x6 Lace Closure Wigs 180% Density Brazilian Human Hair Body Wave Straight Hair,6x6 Lace Closure Wigs 180% Density Brazilian Deep Wave Water Wave Jerry Curly Hair",
			                "categoryImgpcurl": null,
			                "categoryMetatitle": null,
			                "categoryMetakeywords": null,
			                "categoryMetadesc": null
			                */ -->
							<input id="categoryId" hidden>
							<!-- left panel  -->
							<div class="left-panel col-lg-7 col-md-12">
								<div class="card">
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
													 <option value="0">Please select tag...</option>
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
													 <option value="0">Please Select parent-category</option>
												 </select>
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
										<div class="card-title-name">Search engine listing preview</div>
										
										<div class="form-group row">
											<label class="col-md-3 col-form-label" for="categorySeo">Enable SEO</label>
											<div class="controls col-md-3">
												 <label class="c-switch c-switch-primary">
													<input class="c-switch-input" id="categorySeo" type="checkbox">
													<span class="c-switch-slider"></span>
												</label>
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
			var inputSearchEl = $('input[name="searchCollection"]');
			var hasSuperCategory = false;
			var hasParentCategory = false;
			// init
			renderTabItems();
			getCollectionsData();
			// search
			$('.btn-save-search').on('click', function() {
				var searchCollectionVal = inputSearchEl.val().trim();
				if(searchCollectionVal) {
					addCollectionItem(searchCollectionVal);
					addTabItemEl(searchCollectionVal);
				}
			});
			// tab-item click
			$(document.body).on('click', '.c-table-tab-item', function() {
				$('.c-table-tab-item').removeClass('active');
				$(this).addClass('active');
				setPageNum(1);
				getCollectionsData($(this).text());
			});
			// tab delete
			$(document.body).on('click', '.delete-table-tab-item', deleteCollectionEl);
			// pagination
			$(document.body).on('click', '#table-pagination li', function(e) {
				getCollectionsData($(this).text());
			});
			// create collection
			$('.btn-create').on('click', function() {
				$('.c-create c-option-title').text('Create Collection');
				showCreateBlock();
				// init formData
				resetFormData();
				getCollectionId();
			});
			// edit collection
			$(document.body).on('click', '.btn-edit', function(e) {
				var cId = $(this).data('id');
				$('.c-create c-option-title').text('Edit Collection');
				showCreateBlock();
				resetFormData();
				initFormData(categoryData[cId]);
			});
			// delete collection
			$(document.body).on('click', '.btn-delete', function(e) {
				var categoryId = parseInt($(this).data('id'));
				$('#deleteModal').find('.modal-title').html('Delete collection!');
				$('#deleteModal').modal('show');
				$('#deleteModal .btn-ok').on('click', function() {
					deleteCollectionData({
						categoryId: categoryId,
					}, getCollectionsData);
				});
			});
			// save collection
			$('.btn-save').on('click', function() {
				showInitBlock();
				saveCollectionData(getFormData(), getCollectionsData);
			});
			// cancel collection save
			$('.btn-cancel').on('click', function() {
				showInitBlock();
			});
			function showCreateBlock() {
				$('.c-init').addClass('hide');
				$('.c-create').removeClass('hide');
				
				if (!hasSuperCategory) getSuperCategoryData(renderSuperCategory);

				if (!hasParentCategory) getSuperCategoryData(renderParentCategory);
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
				$('#categorySortOrder').val('');
				$('#categoryStatus').prop('checked', false);
				$('#categoryLable').val('0');				
				$('#categoryDesc').val('');

				$('#categoryImgurl').val('');
				
				$('#categorySuperCateId').val('0');
				$('#categoryParentId').val('0');

				$('#categorySeo').prop('checked', false);
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
				data.categorySortOrder =  $('#categorySortOrder').val();
				data.categoryLable =  parseInt($('#categoryLable').val());
				data.categoryDesc = $('#categoryDesc').val();

				data.categoryImgurl = $('#categoryImgurl').val();

				data.categorySuperCateId = $('#categorySuperCateId').val();
				data.categorySuperCateName = $('#categorySuperCateId').find('option:selected').text();
				
				data.categoryParentId = $('#categoryParentId').val();
				data.categoryParentName = $('#categoryParentId').find('option:selected').text();

				data.categorySeo = String($('#categorySeo').prop('checked'));
				data.categoryMetatitle = $('#categoryMetatitle').val();
				data.categoryMetakeywords = $('#categoryMetakeywords').val();
				data.categoryMetadesc = $('#categoryMetadesc').val();

				return data;
			}
			// initFormData
			function initFormData(data) {
				$('#categoryId').val(data.categoryId);
				$('#categoryName').val(data.categoryName);
				$('#categorySortOrder').val(data.categorySortOrder);
				$('#categoryStatus').prop('checked', data.categoryStatus);
				$('#categoryLable').val( data.categoryLable);
				$('#categoryDesc').val(data.categoryDesc);
				
				$('#categorySuperCateId').val(data.categorySuperCateId ? data.categorySuperCateId : 0);
				$('#categoryParentId').val(data.categoryParentId);

				$('#categoryImgurl').val(data.categoryImgurl);

				$('#categorySeo').prop('checked', data.categorySeo);
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
							$('#categoryId').val(data.mlbackCategory.categoryId);
							toastr.success(data.msg);
						} else {
							toastr.error(data.msg);
						}
					},
					error: function() {
						toastr.error('Failed to Save Categeory, please save-data again！');
					},
					complete: function() {
						$('.c-mask').hide();
					}
				});
			}
			// callback get data
			function getCollectionsData(val) {
				$('.c-mask').show();
				var pnNUm = getPageNum();
				$.ajax({
					url: "${APP_PATH }/MlbackCategory/getMlbackCategoryByPage",
					type: "post",
					data: "pn=" + pnNUm,
					success: function (data) {
						if (data.code == 100) {
							renderTable(data.extend.pageInfo.list);
							renderTablePagination(data.extend.pageInfo);
							toastr.success(data.msg);
						} else {
							toastr.error(data.msg);
						}
					},
					error: function() {
						toastr.error('Failed to get Categeory, please refresh the page to get again！');
					},
					complete: function() {
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
							toastr.success(data.msg);
							callback();
						} else {
							toastr.error(data.msg);
						}
					},
					error: function(err) {
						toastr.error(err);
					},
					complete: function() {
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
							toastr.success(data.msg);
							$('#deleteModal').modal('hide');
							callback();
						} else {
							toastr.error(data.msg);
						}
					},
					error: function(err) {
						toastr.error(err);
					},
					complete: function() {
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
							toastr.success(data.msg);
							callback(data.extend.mlbackSuperCateResList);
						} else {
							toastr.error(data.msg);
						}
					},
					error: function(err) {
						toastr.error(err);
					},
					complete: function() {
						$('.c-mask').hide();
					}
				});
			}

			// callback parentCategory
			function getParentCategoryData(callback) {
				$('.c-mask').show();
				$.ajax({
					url: "${APP_PATH}/MlbackCategory/getParentCategoryDownList",
					type: "post",
					contentType: 'application/json',
					success: function (data) {
						if (data.code == 100) {
							toastr.success(data.msg);
							callback(data.extend.mlbackSuperCateResList);
						} else {
							toastr.error(data.msg);
						}
					},
					error: function(err) {
						toastr.error(err);
					},
					complete: function() {
						$('.c-mask').hide();
					}
				});
			}
			// init table-list
			function renderTable(data) {
				var htmlStr = '';
				for (var i=0, len=data.length; i<len; i+=1) {
					categoryData[data[i].categoryId] = data[i];
					htmlStr += '<tr><td>'+ data[i].categoryId +'</td>' +
						'<td><div class="c-table-img" style="background-image: url('+data[i].categoryImgurl+');"></div></td>' +
						'<td>'+ data[i].categoryName +'</td>' +
						'<td>'+ data[i].categoryParentId +'</td>' +
						'<td>'+ data[i].categoryParentName +'</td>' +
						'<td>'+ data[i].categoryLable +'</td>' +
						'<td>'+ (data[i].categoryStatus ? 'enable' : 'disable') +'</td>' +
						'<td>'+ data[i].categorySortOrder +'</td>' +
						'<td>'+ data[i].categoryDesc +'</td>' +
						'<td>'+
							'<button class="btn btn-primary btn-edit" data-id="'+data[i].categoryId+'">'+
								'<svg class="c-icon">'+
									'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>'+
								'</svg>'+
							'</button>' +
							'<button class="btn btn-danger btn-delete" data-id="'+data[i].categoryId+'">'+
								'<svg class="c-icon">'+
									'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>'+
								'</svg>'+
							'</button>' +
						'</td></tr>';
				}
				$('.c-table-table tbody').html(htmlStr);
			}
			// render superCategoryData
			function renderSuperCategory(data) {
				var htmlStr = $('#categorySuperCateId').html();
				for (var i=0, len=data.length; i<len; i+=1) {
					htmlStr += '<option value="'+ data[i].supercateId +'">'+ data[i].supercateName +'</option>';
				}
				$('#categorySuperCateId').html(htmlStr);
				hasSuperCategory = true;
			}
			// render parentCategoryData
			function renderParentCategory(data) {
				var htmlStr = $('#categoryParentId').html();
				for (var i=0, len=data.length; i<len; i+=1) {
					htmlStr += '<option value="'+ data[i].categoryId +'">'+ data[i].categoryDesc +'</option>';
				}
				$('#categoryParentId').html(htmlStr);
				hasParentCategory = true;
			}
			function renderTabItems() {
				var collections = getCollectionList(),
					len = collections.length,
					htmlStr = '';
				if (len > 0) {
					for (var i=0; i<len; i+=1) {
						htmlStr += createCollectionItem(collections[i])[0].outerHTML;
					}
					$('.c-table-tab').append(htmlStr);
					$('.c-table-tab-item').removeClass('active').eq(0).addClass('active');
				}
			}
			function addTabItemEl(val) {
				$('.c-table-tab-item').removeClass('active');
				$('.c-table-tab').append(createCollectionItem(val));
			}
			function createCollectionItem(val) {
				return $('<div class="c-table-tab-item active">'+ val +
						'<svg class="delete-table-tab-item c-icon" data-item="'+ val +'">'+
						'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-x"></use>'+
						'</svg></div>');
			}
			function deleteCollectionEl(e) {
				e.stopPropagation();
				var targetEl = $(e.target),
					itemVal = targetEl.data('item'),
					parentEl = targetEl.parent('.c-table-tab-item');
				deleteCollectionItem(itemVal);
				$(parentEl).remove();
				$('.c-table-tab-item').eq(0).addClass('active');
				getCollectionsData();
			}
			function getCollectionList() {
				return JSON.parse(storage.getItem('collections')) || [];
			}
			function deleteCollectionItem(name) {
				var oldCollections = getCollectionList();
				var newCollections = oldCollections.filter(function(item) {
					if (item != name) return item;
				});
				storage.setItem('collections', JSON.stringify(newCollections));
			}
			function addCollectionItem(name) {
				var collections = getCollectionList();
				collections.unshift(name);
				storage.setItem('collections', JSON.stringify(collections));
			}
		</script>
	</body>
</html>