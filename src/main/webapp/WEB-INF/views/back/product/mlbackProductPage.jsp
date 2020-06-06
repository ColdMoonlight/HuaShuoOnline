<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Product List</title>
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
						<span class="c-option-title">Products</span>
						<button class="btn btn-primary btn-create">Create product</button>
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
									<input id="searchProduct" type="text" placeholder="Search Products">						
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
										<th>basic-price</th>
										<th>discount</th>
										<th>tag</th>
										<th>status</th>
										<th>sale(s)</th>
										<th>reivew(s)</th>
										<th>supercate</th>
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
							<button class="btn btn-primary btn-save">Save Product</button>
						</div>
					</div>
					<div class="c-form row">
						<input id="productId" hidden>
						<!-- left panel  -->
						<div class="left-panel col-lg-7 col-md-12">
							<!-- general -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">General</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="productName">Product Name</label>
										<div class="controls">
											<input class="form-control" id="productName" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="productSeo">Product SEO</label>
										<div class="controls">
											 <input class="form-control" id="productSeo" type="text">
										</div>
									</div>
									<div class="form-group row">
										<label class="col-md-3 col-form-label" for="productStatus">Status</label>
										<div class="controls col-md-3">
											<label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="productStatus" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="productLable">Label</label>
										<div class="controls">
											<select class="form-control" id="productLable" />
												<option value="0" selected="selected">0</option>
												<option value="1">1</option>
												<option value="2">2</option>
												<option value="3">3</option>
												<option value="4">4</option>
												<option value="5">5</option>
												<option value="6">6</option>
												<option value="7">7</option>
												<option value="8">8</option>
												<option value="9">8</option>
											</select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="productDesc">Description</label>
										<div class="controls">
											<textarea id="productDesc"><p>Please Input Product Des.</p></textarea>
										</div>
									</div>
								</div>
							</div>
							<!-- price data  -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Price & Discount & Skus</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="productOriginalprice">Basic Price</label>
										<div class="controls">
											<input class="form-control" id="productOriginalprice" type="number" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="productActoffoff">Discount</label>
										<div class="controls">
											<input class="form-control" id="productActoffoff" type="number" />
										</div>
									</div>
								</div>
							</div>
							<!-- price sku  -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Skus</div>
								</div>
								<div class="card-body">
									<div class="product-options">
										<p class="text-center"> no option, please add one option to generate skus. </p>
									</div>
									<button class="product-option-add btn btn-secondary">Add another option</button>
									<div class="product-skus">
										<div class="product-sku-head">
											<div class="product-sku-head-name"> name </div>
											<div class="product-sku-head-stock"> stock </div>
											<div class="product-sku-head-price"> price </div>
											<div class="product-sku-head-sku"> sku </div>
											<div class="product-sku-head-operate"> operate </div>
										</div>
										<div class="product-sku-body">
											<p class="text-center"> no skus ... </p>
										</div>
									</div>
								</div>
							</div>
							<!-- media picture -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Product Media</div>
								</div>
								<div class="card-body">
									<div class="row">
										<!-- main img  -->
										<div class="col-md-6">
											<h3>Main Picture</h3>
											<div id="uploadImg" class="c-upload-img">
												<svg class="c-icon">
													<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image-plus"></use>
												</svg>
												<div class="c-backshow"></div>						
												<input id="productImgurl" type="file" accept="image/png, image/jpeg, image/gif" />										
												<!-- spinner -->
												<div class="spinner">
													<div class="spinner-border" role="status" aria-hidden="true"></div>
												</div>
											</div>
										</div>
										<!-- video -->
										<div class="col-md-6">
											<h3>Video</h3>
											<div class="c-upload-img">
												<svg class="c-icon">
													<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-cloud-upload"></use>
												</svg>
												<div class="c-backshow"></div>						
												<input id="productVideourl" type="file" accept="video/mp4" />										
												<!-- spinner -->
												<div class="spinner">
													<div class="spinner-border" role="status" aria-hidden="true"></div>
												</div>
											</div>
										</div>
									</div>
									<div class="pictureDetails">
										<h3>Product Details Picture</h3>
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
							<!-- parent category -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Super Category & Parent Category</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="productSupercateid">Super Category</label>
										<div class="controls">
											<select class="form-control" id="productSupercateid" /></select>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="categoryParentId">Parents Category</label>
										<input type="hidden" id="productCategoryIdsstr" />
										<input type="hidden" id="productCategoryNamesstr" />
										<div class="controls" style="display: flex;">
											<textarea id="productCategoryList" class="form-control" rows="5" disabled></textarea>
											<button id="editProductCategory" class="btn btn-info" style="margin-left: 1rem;">edit</button>
										</div>
									</div>
								</div>
							</div>
							<!-- sell data  -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Number of Sale & Reviews</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="productReviewnum">Reviews Number</label>
										<div class="controls">
											 <input class="form-control" id="productReviewnum" type="text" disabled />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="productHavesalenum">Sale Number</label>
										<div class="controls">
											<input class="form-control" id="productHavesalenum" type="text" disabled />
										</div>
									</div>
								</div>
							</div>
							<!-- seo -->
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Search engine listing preview</div>
								</div>
								<div class="card-body">
									<div class="form-group">
										<label class="col-form-label" for="productMetaTitle">Page title</label>
										<div class="controls">
											<input class="form-control" id="productMetaTitle" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="productMetaKeywords">Page keywords</label>
										<div class="controls">
											<textarea class="form-control" rows="5" id="productMetaKeywords"></textarea>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="productMetaDesc">Page Description</label>
										<div class="controls">
											<textarea class="form-control" rows="5" id="productMetaDesc"></textarea>
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
	<jsp:include page="../common/editModal.jsp" flush="true"></jsp:include>

	<script src="${APP_PATH}/static/back/lib/tagsinput/bootstrap-tagsinput.min.js"></script>
	<script src="${APP_PATH}/static/back/lib/summernote/summernote.min.js"></script>
	<!-- custom script -->
	<script>
		var hasSuperCategory = false;
		var isCreate = false;
		// init summernote editor for description
		$('#productDesc').summernote({
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
		if (!hasSuperCategory) getSuperCategoryData(renderSuperCategory);

		// init
		renderTabItems();
		// save search
		$('.btn-save-search').on('click', function () {
			var searchProductVal = {
				supercate: $('#searchSupercate').find('option:selected').text(),
				supercateId: $('#searchSupercate').val(),
				product: $('#searchProduct').val()
			};
			// cancel repeat add save-search
			if (checkNewItem(searchProductVal)) return;
			if (parseInt(searchProductVal.supercateId) < 0) searchProductVal.supercate = "";
			if (searchProductVal.supercate || searchProductVal.product) {
				addProductItem(searchProductVal);
				createProductItem(searchProductVal).addClass('active')
				addTableTabItem(searchProductVal);
				$('.c-table-tab-tempory').html('');
			}
		});
		// search it
		$('#searchSupercate').on('change', function() {
			$(this).attr('data-val', $(this).val());
			updateSearchData();
		});
		var oldTime = (new Date()).getTime(),
			timer = null;
		$('#searchProduct').on('keyup', function() {
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
			var searchProductVal = {
				supercate: $('#searchSupercate').find('option:selected').text(),
				supercateId: $('#searchSupercate').val(),
				product: $('#searchProduct').val()
			};
			// inital pagination num
			setPageNum(1);
			// check searchProduct
			if (parseInt(searchProductVal.supercateId) < 0) searchProductVal.supercate = "";

			$('.c-table-tab-item.active').removeClass('active');
			$('.c-table-tab-tempory').html(createProductItem(searchProductVal).addClass('active'));
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
				$('#searchProduct').val(dataVal.product || '');
				$('#searchSupercate').attr('data-val', dataVal.supercateId || '-1');
				$('#searchSupercate').val(dataVal.supercateId || '-1');
				getSearchProductsData();
			} else {
				$('#searchSupercate').val('-1');
				$('#searchProduct').val('');
				getProductsData();
			}
		}
		// tab delete
		$(document.body).on('click', '.delete-table-tab-item', deleteTableTabItem);
		// pagination a-click
		$(document.body).on('click', '#table-pagination li', function (e) {
			getTabSearchData($('.c-table-tab-item.active'));
		});
		// create product
		$('.btn-create').on('click', function () {
			$('.c-create .c-option-title').text('Create Product');
			showCreateBlock();
			// init formData
			resetFormData();
			// init option & skus-list			
			$('.product-options').html('<p class="text-center"> no option, please add one option to generate skus. </p>');
			$('.product-sku-body').html('<p class="text-center"> no skus ... </p>');
			getProductId();
			isCreate = true;
		});
		// edit product
		$(document.body).on('click', '.btn-edit', function (e) {
			var reqData = $(this).data('val');
			getOneProductData(reqData, function(resData) {
			 	$('.c-create .c-option-title').text('Edit Product');
				showCreateBlock();
				initFormData(resData);
			});
			// initial product option & skus
			getProductOptionsData({
				"productattrnamePid": reqData.productId
			}, function(resData) {
				renderProductOption(resData);
				getProductSkusData({
					"productskuPid": reqData.productId
				}, renderProductSkus)
			});
		});
		// delete product
		$(document.body).on('click', '.btn-delete', function (e) {
			var productId = parseInt($(this).data('id'));
			$('#deleteModal').find('.modal-title').html('Delete product!');
			$('#deleteModal').modal('show');
			$('#deleteModal .btn-ok').one('click', function () {
				deleteProductData({
					productId: productId,
				}, function() {
					getProductsData();
				});
			});
		});
		// save product
		$('.c-create .btn-save').on('click', function () {
			if (parseInt($('#productSupercateid').val()) < 0) {
				toastr.info('Please Select super-category!');
				$('#productSupercateid').focus();
				$('#productStatus').prop('checked', false);
				return;
			}
			saveProductData(getFormData(), function() {
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
		// cancel product save
		$('.c-create .btn-cancel').on('click', function () {
			if (isCreate) {
				isCreate = false;
				/* initActiveItemNum(); */
				// delete null product
				deleteProductData({
					productId: $('#productId').val(),
				}, function() {
					console.log("cancel create-product");
				});
				// fetch default product
				// getProductsData();
			}

			showInitBlock();
		});
		// supercate & productStatus combinewith
		$('#productSupercateid').on('change', function(e) {
			if (parseInt($(this).val()) < 0) {
				$('#productStatus').prop('checked', false);
			}
		});
		// eidt product category
		$('#editProductCategory').on('click', function() {
			$('#editModal').find('.modal-title').html('selete category for product');
			$('#editModal').modal('show');
			// get parentCategory data
			getParentCategoryData(renderParentCategory);
			$('#editModal .btn-ok').one('click', function () {
				var checkData = getSelectedCategoryData();
				$('#productCategoryIdsstr').val(checkData.productCategoryIds.join(','));
				$('#productCategoryNamesstr').val(checkData.productCategoryNames.join(','));
				$('#productCategoryList').val(checkData.productCategoryNames.join('\n'));
				$('#editModal').modal('hide');
			});
		});
		function getSelectedCategoryData() {
			var checkedInputs = $('#editModal').find('input:checked');
			var resData = {
					productCategoryIds: [],
					productCategoryNames: []
			};
			for (var i = 0, len = checkedInputs.length; i < len; i+=1) {
				resData.productCategoryIds.push($(checkedInputs[i]).data('id'));
				resData.productCategoryNames.push($(checkedInputs[i]).data('name'));
			}
			return resData;
		}
		// initial product option
		function getProductOptionsData(reqData, callback) {
			// getMlbackProductAttributeNameListByProductId
			$.ajax({
				url: "${APP_PATH }/MlbackProductAttributeName/getMlbackProductAttributeNameListByProductId",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mbackProductAttributeNameResList);
						toastr.success(data.extend.resMsg);
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
		// add product option
		$('.product-option-add').on('click', function() {
			getProductOptionId({
				"productattrnamePid": $('#productId').val(),				
			    "productattrnameSort": ($('.product-options-item').length ? $('.product-options-item').last().data('sort') + 1 : 1)
			}, function(data) {
				if (!$('.product-options-item').length) {
					$('.product-options').html('');	
				}
				createOptionItem(data);
			});
		});
		// save product option name
		$(document.body).on('click', '.product-option-save', function() {
			var parentEl = $(this).parents('.product-options-item');
			var optionName = parentEl.find('.product-option-name').val();
			var optionVal = parentEl.find('.product-option-values').val();
			var optionSort = parentEl.data('sort');
			if (!optionName.trim()) {
				toastr.error('Product-option-name cannot be empty！');
				return;
			}
			saveProductOption({
				"productattrnameName": optionName,
				"productattrnameId": $(this).data('id'),
			    "productattrnameSort": optionSort,
			    "productattrnameValues": optionVal,
				"productattrnamePid": $('#productId').val()
			}, function(data) {
				renderProductSkus(getOptionData(), true);
			});
			
		});
		// render product skus in sav
		function renderProductSkus(data, flag) { 
            var htmlStr = '';
            (flag ? generateSkus(data) : data).forEach(function(item) {
            	htmlStr += '<div class="product-sku-item" data-id="'+ (item.productskuId ? item.productskuId : '') +'">'+
            		'<div class="product-sku-name">'+ (item.productskuName ? item.productskuName.replace(',', '/') : item.join('/')) +'</div>' +
            		'<input class="product-sku-stock" value="'+ (item.productskuStock ? item.productskuStock : '') +'" />' +
            		'<input class="product-sku-price" value="'+ (item.productskuMoney ? item.productskuMoney : '') +'" />' +
            		'<input class="product-sku-sku" value="'+ (item.productskuCode ? item.productskuCode : '') +'" />' +
            		'<div class="product-sku-operate">'+
	            		'<button class="btn btn-primary product-sku-save">' +
		        			'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-save"></use>' +
							'</svg>' +
						'</button>' +
            			'<button class="btn btn-primary product-sku-delete">' +
	            			'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' +
            		'</div>'
            	+'</div>';
            });
            $('.product-sku-body').html(htmlStr || '<p class="text-center"> no skus ... </p>');
		}
		// generate skus
		function generateSkus(data) {
			var skuArrs = [];
			(function cb(res, a, n) {  
                if (n == 0) return res.length ? skuArrs.push(res) : skuArrs;
                for (var i= 0, len=a[n-1].length; i < len; i++) {
                    cb(res.concat(a[n-1][i]), a, n - 1);  
                }
            })([], data.reverse(), data.length);
			return skuArrs;
		}
		// get option data
		function getOptionData() {
			var optionVal = [];
			$('.product-option-values').each(function(idx, item) {
				optionVal.push($(item).val().split(','));
			});
			return optionVal;
		}
		// remove product option
		$(document.body).on('click', '.product-option-remove', function() {
			function removeOptionItem(el) {
				el.parents('.product-options-item').remove();
			}
			var $this = $(this);
			deleteProductOption({
				"productattrnameId": $this.data('id')
			}, function() {
				removeOptionItem($this);
				if (!$('.product-options-item').length) {
					$('.product-options').html('<p class="text-center"> no option, please add one option to generate skus. </p>');
					$('.product-sku-body').html('<p class="text-center"> no skus ... </p>');
				}
				renderProductSkus(getOptionData(), true);
			});
		});
		// delete product option
		function deleteProductOption(reqData, callback) {
			$('.c-mask').show(); 
			$.ajax({
				url: "${APP_PATH }/MlbackProductAttributeName/delete",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						callback();
						toastr.success(data.extend.resMsg);
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
		// save product option
		function saveProductOption(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackProductAttributeName/save",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						callback();
						toastr.success(data.extend.resMsg);
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
		// save product sku
		$(document.body).on('click', '.product-sku-save', function() {
			var skuId = $(this).data('id') || null;
			var parentEl = $(this).parents('.product-sku-item');
			saveProductSkuData({
			    "productskuPid": $('#productId').val(),
				"productskuId": skuId,
				"productskuName": parentEl.find('.product-sku-name').text().split('/').join(','),
			    "productskuStock": parentEl.find('.product-sku-stock').val(),
			    "productskuMoney": parentEl.find('.product-sku-price').val(),
			    "productskuCode": parentEl.find('.product-sku-sku').val(),
			}, function(data) {
				parentEl.attr('data-id', data.productskuId);
			});
		});
		// delete product sku
		$(document.body).on('click', '.product-sku-delete', function() {
			var parentEl = $(this).parents('.product-sku-item');
			var skuId = parentEl.data('id') || null;
			function deleteSkuItem(el) {
				el.remove();
			}
			if (skuId) {
				deleteProductSkuData({ "productskuId": skuId }, parentEl, deleteSkuItem);
			} else {
				deleteSkuItem(parentEl);
				toastr.success('delete product sku success!');
			}
		});
		// get product sku-list
		function getProductSkusData(reqData, callback) {
			$('.c-mask').show(); 
			$.ajax({
				url: "${APP_PATH }/MlbackProductSku/getMlbackProductSkuListByPId",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlbackProductSkuResList);
						toastr.success(data.extend.resMsg);
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
		// save product sku-data
		function saveProductSkuData(reqData, callback) {
			$('.c-mask').show(); 
			$.ajax({
				url: "${APP_PATH }/MlbackProductSku/save",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlbackProductSku);
						toastr.success(data.extend.resMsg);
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
		// delete product sku-data
		function deleteProductSkuData(reqData, el, callback) {
			$('.c-mask').show(); 
			$.ajax({
				url: "${APP_PATH }/MlbackProductSku/delete",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						callback(el);
						toastr.success(data.extend.resMsg);
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
		// get product option id
		function getProductOptionId(reqData, callback) {
			$('.c-mask').show(); 
			$.ajax({
				url: "${APP_PATH }/MlbackProductAttributeName/save",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				data: JSON.stringify(reqData),
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlbackProductAttributeName);
						toastr.success(data.extend.resMsg);
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
		// render product option
		function renderProductOption(data) {
			if (data.length) {
				$('.product-options').html('');
				data.forEach(function(item) {
					createOptionItem(item);
				});				
			} else {
				$('.product-options').html('<p class="text-center"> no option, please add one option to generate skus. </p>');
			}
		}
		// create option item
		function createOptionItem(data) {
			var optionItem = $('<div class="product-options-item" data-sort="'+ data.productattrnameSort +'">' +
				'<div class="product-option-head">' +
					'<div class="product-option-title">Option '+ ($('.product-options-item').length + 1) +'</div>' +
					'<div>' +
						'<a href="javascript:;" class="product-option-save" data-id="'+ data.productattrnameId +'" style="margin-right: 1rem;">Save</a>' +
						'<a href="javascript:;" class="product-option-remove" data-id="'+ data.productattrnameId +'">Remove</a>' +
					'</div>' +
				'</div>' +
				'<div class="product-option-body">' +
					'<input class="product-option-name" type="text" value="'+ (data.productattrnameName || "") +'"  />' +
					'<input class="product-option-values" type="text" value="'+ (data.productattrnameValues || "") +'" />' +										
				'</div>' +
			'</div>');
			optionItem.find('.product-option-values')
			.tagsinput({
				onTagExists: function(item, $tag) {
					toastr.error('Youve already used the option "'+ item + '"');
				}
			})
			$('.product-options').append(optionItem);
		}
		// upload img
		$('#productImgurl').on('change', function(e) {
			var $this = $(this);
			$('.c-upload-img .spinner').show();
			var formData = new FormData();
			formData.append('type', 'product');
			formData.append('image', $this[0].files[0]);
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
					$('.c-upload-img .spinner').hide();
				}
			});
		});
		// upload vieo
		$('#productVideourl').on('change', function(e) {
			var $this = $(this);
			$('.c-upload-img .spinner').show();
			var formData = new FormData();
			formData.append('type', 'product');
			formData.append('image', $this[0].files[0]);
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
					$('.c-upload-img .spinner').hide();
				}
			});
		});
		// upload details img
		$(document.body).on('change', '.productAllImgurl', function(e) {
			var $this = $(this);
			$this.parent().find('.spinner').show();
			var formData = new FormData();
			formData.append('imageAll', $this[0].files[0]);
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
			$('#productId').val('');
			$('#productName').val('');
			$('#productStatus').prop('checked', false);
			$('#productLable').val('0');

			$('#productDesc').summernote('reset');

			$('#productOriginalprice').val('0.00');
			$('#productActoffoff').val('0');
			
			resetPicture($('#productImgurl'));
			// reset product-img-list
			$('.product-img-list').html('');
			addUploadBlock(1);

			$('#productSupercateid').val('-1');
			$('#productCategoryIdsstr').val('');
			$('#productCategoryNamesstr').val('');
			$('#productCategoryList').val('No category!');

			$('#productHavesalenum').val('0');
			$('#productReviewnum').val('0');

			$('#productSeo').val('');
			$('#productMetaTitle').val('');
			$('#productMetaKeywords').val('');
			$('#productMetaDesc').val('');
		}
		// getFormdData
		function getFormData() {
			var data = {};
			data.productId = parseInt($('#productId').val());
			data.productName = $('#productName').val();
			data.productStatus = $('#productStatus').prop('checked') ? 1 : 0;
			data.productLable = parseInt($('#productLable').val());
			data.productDesc = $('#productDesc').val();
			
			data.productOriginalprice = $('#productOriginalprice').val();
			data.productActoffoff = $('#productActoffoff').val();

			var imageData = $('#productImgurl').attr('data-val') && JSON.parse($('#productImgurl').attr('data-val'));
			data.productMainimgurl = imageData ? imageData.imageUrl : null;
			data.productMainimgsmallurl = imageData ? imageData.thumImageUrl : null;

			data.productSupercateid = $('#productSupercateid').val();
			data.productSupercatename = $('#productSupercateid').find('option:checked').text();
			data.productCategoryIdsstr = $('#productCategoryIdsstr').val();
			data.productCategoryNamesstr = $('#productCategoryNamesstr').val();

			data.productHavesalenum = $('#productHavesalenum').val();
			data.productReviewnum = $('#productReviewnum').val();

			data.productSeo = $('#productSeo').val();
			data.productMetaTitle = $('#productMetaTitle').val();
			data.productMetaKeywords = $('#productMetaKeywords').val();
			data.productMetaDesc = $('#productMetaDesc').val();

			return data;
		}
		// initFormData
		function initFormData(data) {
			$('#productId').val(data.productId);
			$('#productName').val(data.productName);
			$('#productStatus').prop('checked', data.productStatus);
			$('#productLable').val(data.productLable);
			$('#productDesc').summernote('code', data.productDesc);

			$('#productOriginalprice').val(data.productOriginalprice || 0.00);
			$('#productActoffoff').val(data.productActoffoff || 0);

			if (hasSuperCategory) {
				// value
				$('#productSupercateid').val(data.productSupercateid || '-1');
			}
			// attr
			$('#productSupercateid').attr('data-val', data.productSupercateid || '-1');

			$('#productCategoryIdsstr').val(data.productCategoryIdsstr);
			$('#productCategoryNamesstr').val(data.productCategoryNamesstr);
			$('#productCategoryList').val(data.productCategoryNamesstr ? ' * ' + data.productCategoryNamesstr.replace(/\,/g, '\n * ') : 'No category！');

			data.productMainimgurl && addPicture($('#productImgurl'), {
				imageUrl: data.productMainimgurl,
				thumImageUrl: data.productMainsmallimgurl
			});
			getProductAllImgData({
				productId: data.productId
			}, renderProductAllData);

			$('#productHavesalenum').val(data.productHavesalenum);
			$('#productReviewnum').val(data.productReviewnum);			

			$('#productSeo').val(data.productSeo);
			$('#productMetaTitle').val(data.productMetaTitle);
			$('#productMetaKeywords').val(data.productMetaKeywords);
			$('#productMetaDesc').val(data.productMetaDesc);
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
		function getProductsData() {
			$('.c-mask').show();
			var formData = 'pn=' + getPageNum();
			$.ajax({
				url: "${APP_PATH }/MlbackProduct/getMlbackProductByPage",
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
					toastr.error('Failed to get Products, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		// callback get one data
		function getOneProductData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackProduct/getOneMlbackProductDetail",
				type: "post",
				data: JSON.stringify(reqData),
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlbackProductOne);
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
		function getSearchProductsData(data) {
			$('.c-mask').show();
			// formdata issue, need to check formdata ?
			var formData = '';
			formData += 'productName=' + $('#searchProduct').val();
			formData += ('&productSupercateid=' + ($('#searchSupercate').attr('data-val') || '-1'));
			formData += '&pn=' + getPageNum();

			$.ajax({
				url: "${APP_PATH }/MlbackProduct/backSearchByProduct",
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
		function saveProductData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackProduct/save",
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
		function deleteProductData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackProduct/delete",
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
			$('#editModal .spinner').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCategory/getOneMlbackCategoryParentDetail",
				type: "post",
				contentType: 'application/json',
				async: false,
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
					$('#editModal .spinner').hide();
				}
			});
		}
		// callback get all img data
		function getProductAllImgData(reqData, callback) {
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
		// init table-list
		function renderTable(data) {
			var htmlStr = '';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<tr><td>' + data[i].productId + '</td>' +
					'<td>' +
						(data[i].productMainsmallimgurl ?
							'<div class="c-table-img"><img src="'+ encodeUrl(data[i].productMainsmallimgurl) +'" /></div>'
							: '<div class="c-table-icon"><svg class="c-icon"><use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-image1"></use></svg></div>') +
					'</td>' +
					'<td>' + data[i].productName + '</td>' +
					'<td>' + data[i].productOriginalprice + '</td>' +
					'<td>' + data[i].productActoffoff + '</td>' +
					'<td>' + data[i].productLable + '</td>' +
					'<td><a class="badge '+ (data[i].productStatus ? 'badge-success': 'badge-danger') +'" href="javascript:;">' + (data[i].productStatus ? 'enable' : 'disable') + '</a></td>' +
					'<td>' + data[i].productHavesalenum + '</td>' +
					'<td>' + data[i].productReviewnum + '</td>' +
					'<td>' + (data[i].productSupercatename || "") + '</td>' +
					'<td>' +
						'<button class="btn btn-primary btn-edit" data-val={"productId":'+ data[i].productId + ',"productSupercateid":' +  data[i].productSupercateid + '}>' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
							'</svg>' +
						'</button>' +
						'<button class="btn btn-danger btn-delete" data-id="' + data[i].productId + '">' +
							'<svg class="c-icon">' +
								'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
							'</svg>' +
						'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
		// render product all img data
		function renderProductAllData(data) {
			var len = data.length;
			$('.product-img-list').html('');

			for (var i = 0; i < len; i+=1) {
				addUploadBlock(data[i].productimgSortOrder);
				addPicture($('.product-img-item').last().find('.productAllImgurl'), {
					imageUrl: data[i].productimgurl,
					thumImageUrl: data[i].productimgSmallturl
				});
			}

			if (len < 6) addUploadBlock(len);
		}
		// render superCategoryData
		function renderSuperCategory(data) {
			var htmlStr = '<option value="-1">Please Select Super-category</option>';
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<option value="' + data[i].supercateId + '">' + data[i].supercateName + '</option>';
			}
			$('#productSupercateid').html(htmlStr);
			$('#searchSupercate').html(htmlStr);
			hasSuperCategory = true;
			// init select default value
			initFormFiled();
		}
		// render parentCategoryData
		function renderParentCategory(data) {
			var htmlStr = '';
			var defaultProductCategory = $('#productCategoryIdsstr').val() && $('#productCategoryIdsstr').val().split(',');
			for (var i = 0, len = data.length; i < len; i += 1) {
				var cagtegoryId = data[i].categoryId;
				var categoryName = data[i].categoryDesc;
				var checkedStatus = defaultProductCategory.indexOf(String(cagtegoryId)) > -1 ? "checked" : "";
				htmlStr += '<div class="col-form-label"><div class="form-check checkbox">' +
						'<input class="form-check-input" '+ checkedStatus +' id="'+ cagtegoryId +'" type="checkbox" value="" data-id="'+ cagtegoryId +'" data-name="'+ categoryName +'"}>' +
						'<label class="form-check-label" for="'+ cagtegoryId +'">No.' + cagtegoryId + ' ' + categoryName +'</label>' +
					'</div></div>';
			}
			$('#editModal .modal-body-body').html(htmlStr);
		}

		function initFormFiled() {
			// search
			$('#searchSupercate').val($('#searchSupercate').data('val') || '-1');
			// form
			$('#productSupercateid').val($('#productSupercateid').data('val') || '-1');
			$('#categoryParentId').val($('#categoryParentId').data('val') || '-1');
		}
		function renderTabItems() {
			var products = getProductList(),
				len = products.length,
				htmlStr = '',
				activeNum = parseInt(getActiveItemNum());

			if (len > 0) {
				for (var i = 0; i < len; i += 1) {
					var $item = createProductItem(products[i]);
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
			var productList = getProductList();
			if (productList.length >= 6) {
				// save-search-item num <= 6
				toastr.info('You can add up to six search records！');
				return true;
			}
				
			var filterArr = productList.filter(function(item) {
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
			$('.c-table-tab-list').append(createProductItem(val).addClass('active'));
			setActiveItemNum($('.c-table-tab-item').length - 1);
		}
		function createProductItem(val) {
			var textArr = [];
			if (val.supercate) {
				textArr.push(val.supercate)
			}
			if (val.product) {
				textArr.push(val.product)
			}

			return $('<div class="c-table-tab-item">' + textArr.join("-") + '<div class="delete-table-tab-item c-icon">x</div></div>').attr('data-val', JSON.stringify(val));
		}
		function deleteTableTabItem(e) {
			e.stopPropagation();
			var targetEl = $(e.target),
				parentEl = targetEl.parent('.c-table-tab-item'),
				itemVal = $(parentEl).data('val');

			deleteProductItem(itemVal);
			$(parentEl).remove();

			$('.c-table-tab-item').eq(0).addClass('active');
			getTabSearchData($('.c-table-tab-item').eq(0));
		}
		function getProductList() {
			return JSON.parse(storage.getItem('products')) || [];
		}
		function deleteProductItem(name) {
			var oldProducts = getProductList();
			var newProducts = oldProducts.filter(function (item) {
				if (JSON.stringify(item) != JSON.stringify(name)) return item;
			});
			storage.setItem('products', JSON.stringify(newProducts));
		}
		function addProductItem(name) {
			var products = getProductList();
			products.push(name);
			storage.setItem('products', JSON.stringify(products));
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