<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Collection</title>
		<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	</head>

	<body class="c-app">
		<jsp:include page="../layout/backheader.jsp" flush="true"></jsp:include>
		<jsp:include page="../layout/backsidebar.jsp" flush="true"></jsp:include>
		<div class="c-wrapper">
			<div class="c-body">
				<div class="c-main">
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
						<div class="c-table-mask">
							<div class="spinner-border"></div>
						</div>
					</div>
				</div>
			</div>
			<jsp:include page="../layout/backfooter.jsp" flush="true"></jsp:include>
		</div>

		<jsp:include page="../common/backfooter.jsp" flush="true"></jsp:include>
		<!-- custom script -->
		<script>
			var inputSearchEl = $('input[name="searchCollection"]');
			// init
			renderTabItems();
			getCollectionsData();
			// listener
			$('.btn-save-search').on('click', function() {
				var searchCollectionVal = inputSearchEl.val().trim();
				if(searchCollectionVal) {
					addCollectionItem(searchCollectionVal);
					addTabItemEl(searchCollectionVal);
				}
			});
			$(document.body).on('click', '.c-table-tab-item', function() {
				$('.c-table-tab-item').removeClass('active');
				$(this).addClass('active');
				setPageNum(1);
				getCollectionsData($(this).text());
			});
			$(document.body).on('click', '.delete-table-tab-item', deleteCollectionEl);
			$(document.body).on('click', '#table-pagination li', function(e) {
				getCollectionsData($(this).text());
			});
			function getCollectionsData(val, pn) {
				var data = {
						pn: getPageNum(),
					};
				$.ajax({
					url: "${APP_PATH }/MlbackCategory/getMlbackCategoryByPage",
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
						$('.c-table-mask').hide();
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
				var targetEl = $(e.target),
					itemVal = targetEl.data('item'),
					parentEl = targetEl.parent('.c-table-tab-item');
				deleteCollectionItem(itemVal);
				$(parentEl).remove();
				$('.c-table-tab-item').eq(0).addClass('active');
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
				console.log(collections, name)
				storage.setItem('collections', JSON.stringify(collections));
			}
		</script>
	</body>
</html>