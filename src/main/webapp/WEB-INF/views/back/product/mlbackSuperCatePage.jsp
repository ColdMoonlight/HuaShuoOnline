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
							<span class="c-option-title">SuperCate</span>
							<button class="btn btn-primary btn-create">Create SuperCate</button>
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
											<th>序号</th>
											<th>分类名</th>
											<th>图片</th>
											<th>操作</th>
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
							<span class="c-option-title">Edit SuperCate</span>
							<div class="group">
								<button class="btn btn-secondary btn-cancel">Cancel</button>
								<button class="btn btn-primary btn-save">Save SuperCate</button>
							</div>
						</div>
						<div class="c-form">
							<input id="supercateId" hidden>
							<div class="card">
								<div class="card-body">
									<div class="form-group">
				                        <label class="col-form-label" for="supercateName">Title</label>
				                        <div class="controls">
					                         <input class="form-control" id="supercateName" type="text" />
				                        </div>
			                      	</div>						
									<div class="form-group">
				                        <label class="col-form-label" for="supercateSortOrder">Sort</label>
				                        <div class="controls">
					                         <input class="form-control" id="supercateSortOrder" type="number" />
				                        </div>
			                      	</div>
			                      	<div class="form-group row">
				                        <label class="col-md-3 col-form-label" for="supercateStatus">Status</label>
				                        <div class="controls col-md-3">
					                         <label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="supercateStatus" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
				                        </div>
			                      	</div>
								</div>
							</div>
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">SuperCate Image</div>
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
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Search engine listing preview</div>
									
									<div class="form-group row">
				                        <label class="col-md-3 col-form-label" for="supercateSeo">Enable SEO</label>
				                        <div class="controls col-md-3">
					                         <label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="supercateSeo" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
				                        </div>
			                      	</div>
									<%-- <div class="cartegory-name"></div>
									<div class="category-link></div>
									<div class="caetegory-desc></div> --%>
								</div>
								<div class="card-body">
									<div class="form-group">
				                        <label class="col-form-label" for="supercateMetatitle">Page title</label>
				                        <div class="controls">
					                         <input class="form-control" id="supercateMetatitle" type="text" />
				                        </div>
			                      	</div>
			                      	<div class="form-group">
				                        <label class="col-form-label" for="supercateMetakeywords">Page keywords</label>
				                        <div class="controls">
					                         <textarea class="form-control" height="100" id="supercateMetakeywords"></textarea>
				                        </div>
			                      	</div>
			                      	<div class="form-group">
				                        <label class="col-form-label" for="supercateMetadesc">Page Description</label>
				                        <div class="controls">
					                         <textarea class="form-control" height="100" id="supercateMetadesc"></textarea>
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
		
		<script src="${APP_PATH}/static/back/lib/tagsinput/bootstrap-tagsinput.min.js"></script>
		<script src="${APP_PATH}/static/back/lib/summernote/summernote.min.js"></script>
		<!-- custom script -->
		<script>
			var inputSearchEl = $('input[name="searchCollection"]');
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
				getCollectionId();
				// tagsinput
				$('#tagsinput').tagsinput({
					onTagExists: function(item, $tag) {
						toastr.error('Youve already used the option "'+ item + '"');
					}
				});
				$('.bootstrap-tagsinput input').on('focus', function(e) {
					$(this).parent().addClass('active')
				});
				$('.bootstrap-tagsinput input').on('blur', function(e) {
					$(this).parent().removeClass('active')
				});
				// rich text
				$('#summernote').summernote({
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
			});
			// edit collection
			$(document.body).on('click', '.btn-edit', function(e) {
				$('.c-create c-option-title').text('Edit Collection');
				showCreateBlock();
				$('#summernote').summernote({
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
			});
			// delete collection
			$(document.body).on('click', '.btn-delete', function(e) {
				var cId = $(this).data('id');
				getCollectionsData();
			});
			// save collection
			$('.btn-save').on('click', function() {
				showInitBlock();
				getCollectionsData();
				saveCollectionData(getFormData());
			});
			// cancel collection save
			$('.btn-cancel').on('click', function() {
				showInitBlock();
				resetFormData();
			});
			function showCreateBlock() {
				$('.c-init').addClass('hide');
				$('.c-create').removeClass('hide');
			}
			function showInitBlock() {
				$('.c-init').removeClass('hide');
				$('.c-create').addClass('hide');
			}
			function resetFormData() {
				
			}
			function getFormData() {
				var data = {};
				/* 
					supercateId: 29
					supercateImgurl: null
					supercateMetadesc: null
					supercateMetakeywords: null
					supercateMetatitle: null
					supercateMotifytime: null
					supercateName: null
					supercateSeo: null
					supercateSortOrder: null
					supercateStatus: null
				*/
				data.supercateId = $('#supercateId').val();
				data.supercateName = $('#supercateName').val();
				data.supercateSortOrder = $('#supercateSortOrder').val();
				data.supercateStatus = $('#supercateStatus').prop('checked');

				data.supercateImgurl = $('#supercateImgurl').val();

				data.supercateSeo = $('#supercateSeo').prop('checked');
				data.supercateMetatitle = $('#supercateMetatitle').val();
				data.supercateMetakeywords = $('#supercateMetakeywords').val();
				data.supercateMetadesc = $('#supercateMetadesc').val();

				return data;
			}
			function getCollectionId() {
				$('.c-mask').show();
				$.ajax({
					url: "${APP_PATH }/MlbackSuperCate/initializaSuperCate",
					type: "post",
					dataType: "json",
					contentType: 'application/json',
					async: false,
					success: function (data) {
						if (data.code == 100) {
							$('#supercateId').val(data.extend.mlbackSuperCate.supercateId);
							toastr.success(data.msg);
						} else {
							toastr.error(data.msg);
						}
					},
					error: function() {
						toastr.error('获取分类失败，请刷新页面重新获取！');
					},
					complete: function() {
						$('.c-mask').hide();
					}
				});
			}
			function getCollectionsData(val, pn) {
				$('.c-mask').show();
				var data = {
						pn: getPageNum(),
					};
				$.ajax({
					url: "${APP_PATH }/MlbackSuperCate/getMlbackSuperCateByPage",
					type: "post",
					dataType: "json",
					contentType: 'application/json',
					data: JSON.stringify(data),
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
						toastr.error('获取分类失败，请刷新页面重新获取！');
					},
					complete: function() {
						$('.c-mask').hide();
					}
				});
			}
			function saveCollectionData(data) {
				$('.c-mask').show();
				$.ajax({
					url: "${APP_PATH }/MlbackSuperCate/getMlbackSuperCateByPage",
					type: "post",
					dataType: "json",
					contentType: 'application/json',
					data: JSON.stringify(data),
					success: function (data) {
						if (data.code == 100) {
							toastr.success(data.msg);
						} else {
							toastr.error(data.msg);
						}
					},
					error: function() {
						toastr.error('获取分类失败，请刷新页面重新获取！');
					},
					complete: function() {
						$('.c-mask').hide();
					}
				});
			}
			function renderTable(data) {
				var htmlStr = '';
				for (var i=0, len=data.length; i<len; i+=1) {
					htmlStr += '<tr><td>'+ (i+1) +'</td>' +
						'<td>'+ data[i].categoryName +'</td>' +
						'<td><div class="c-table-img" style="background-image: url('+data[i].categoryImgurl+');"></div></td>' +
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