<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% pageContext.setAttribute("APP_PATH" , request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>coupon list</title>
	<jsp:include page="../common/backheader.jsp" flush="true"></jsp:include>
	<link rel="stylesheet" href="${APP_PATH}/static/back/lib/daterangepicker/datepicker.css">
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
						<span class="c-option-title">Coupon list</span>
						<button class="btn btn-primary btn-create">Create Coupon</button>
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
								<div  class="form-control">
									<input name="searchCollection" id="searchCollection" type="text"  placeholder="Search Collections" />
								</div>
								<a class="btn btn-primary input-group-addon btn-save-search">Save search</a>
							</div>
							<table class="c-table-table table table-responsive-sm">
								<thead>
									<tr>
										<th>id</th>
										<th>Name</th>
										<th>scope</th>
										<th>couponType</th>
										<th>couponPrice</th>
										<th>couponPriceoff</th>
										<th>couponCode</th>
										<th>Draw or no</th>
										<th>Weight</th>
										<th>Product or no</th>
										<th>state</th>
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
						<span class="c-option-title">Edit Coupon</span>
						<div class="group">
							<button class="btn btn-secondary btn-cancel">Cancel</button>
							<button class="btn btn-primary btn-save">Save Coupon</button>
						</div>
					</div>
					<div class="c-form row">
						<input id="couponId" hidden>
						<!-- left panel -->
						<div class="left-panel col-lg-7 col-md-12">
							<div class="card">
								<div class="card-body">
									<div class="form-group row">
										<label class="col-md-3 col-form-label" for="couponStatus">Status</label>
										<div class="controls col-md-3">
											<label class="c-switch c-switch-primary">
												<input class="c-switch-input" id="couponStatus" type="checkbox">
												<span class="c-switch-slider"></span>
											</label>
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="couponName">Coupon Name</label>
										<div class="controls">
											<input class="form-control" id="couponName" type="text" />
										</div>
									</div>
									<div class="form-group">
										<label class="col-form-label" for="couponPriceBaseline">Scope of application</label>
										<div class="controls">
											<input class="form-control" id="couponPriceBaseline" type="text" />
										</div>
									</div>
									<div class="form-group choose_coup">
										<label class="col-form-label" for="couponType">Coupon type</label>
										<div class="controls">
											<select class="form-control" id="couponType" />
												<option value="0" selected="selected">0-Full decrement</option>
												<option value="1">1-Discount volume</option>
											</select>
										</div>
									</div>
									
									<div class="form-group open_0">
										<label class="col-form-label" for="couponPrice">Preferential strength</label>
										<div class="controls">
											<input class="form-control" id="couponPrice" type="text" />
										</div>
									</div>
									<div class="form-group open_1" style="display: none;">
										<label class="col-form-label" for="couponPriceoff">Preferential percentage</label>
										<div class="controls">
											<select id="couponPriceoff" name="couponPriceOff" class="form-control">
											   <option value="5" selected="selected">5%</option>
											   <option value="6">6%</option>
											   <option value="7">7%</option>
											   <option value="8">8%</option>
											   <option value="9">9%</option>
											   <option value="10">10%</option>
											   <option value="11">11%</option>
											   <option value="12">12%</option>
											   <option value="13">13%</option>
											   <option value="14">14%</option>
											   <option value="15">15%</option>
											   <option value="16">16%</option>
											   <option value="17">17%</option>
											   <option value="18">18%</option>
											   <option value="19">19%</option>
											   <option value="20">20%</option>
											</select>
										</div>
									</div>
									
									<div class="form-group">
										<label class="col-form-label" for="couponCode">Discount code:</label>
										<div class="controls">
											<input class="form-control" id="couponCode" type="text" />
										</div>
									</div>
									<div class="form-group choose_draw">
										<label class="col-form-label" for="couponLuckdrawType">Lottery draw</label>
										<div class="controls">
											<select class="form-control" id="couponLuckdrawType" />
												<option value="0" selected="selected">0-Support lottery</option>
												<option value="1">1-Lottery not supported</option>
											</select>
										</div>
									</div>
									<div class="form-group open_draw" style="display: none;">
										<label class="col-form-label" for="couponLuckdrawWeight">Draw weight ratio:</label>
										<div class="controls">
											<select name="couponLuckdrawWeight" id="couponLuckdrawWeight" class="form-control">
											   <option value="0">0%</option>
											   <option value="5">5%</option>
											   <option value="10">10%</option>
											   <option value="15">15%</option>
											   <option value="20">20%</option>
											   <option value="25">25%</option>
											   <option value="30">30%</option>
											   <option value="35">35%</option>
											   <option value="40">40%</option>
											   <option value="45">45%</option>
											   <option value="50">50%</option>
											   <option value="55">55%</option>
											   <option value="60">60%</option>
											   <option value="65">65%</option>
											   <option value="70">70%</option>
											   <option value="75">75%</option>
											   <option value="80">80%</option>
											   <option value="85">85%</option>
											   <option value="90">90%</option>
											   <option value="95">95%</option>
											   <option value="100">100%</option>
											</select>
										</div>
									</div>
								</div>
							</div>

						</div>
						<!-- right panel -->
						<div class="right-panel col-lg-5 col-md-12">
							<div class="card">
								<div class="card-title">
									<div class="card-title-name">Bind product or not</div>
								</div>
								<div class="card-body">
									<div class="form-group choose_product">
										<label class="col-form-label" for="couponProductonlyType">Bind product or not</label>
										<div class="controls">
											<select class="form-control" id="couponProductonlyType" />
											<option value="0" selected="selected">no</option>
											<option value="1">yes</option>
											</select>
										</div>
									</div>
									<div class="form-group open_product" style="display:none">
										<label class="col-form-label" for="couponProductonlyPidstr">Product list </label>
										<div class="controls">
											<select class="form-control" id="couponProductonlyPidstr" />
											</select>
										</div>
									</div>
									<div class="date-timepicker2">
										<div class="form-group">
											<label for="couponStarttime" class="control-label">Start time:</label>
											<div class="controls J-datepicker">
												<input type="text" id="couponStarttime" value="" autocomplete="off" class="form-control countdown-start" placeholder="example: 2020-08-01 12:30:00" name="couponStarttime">
											</div>
										</div>
										<div class="form-group">
											<label for="couponEndtime" class="control-label">End time:</label>
											<div class="controls J-datepicker">
												<input type="text" id="couponEndtime" autocomplete="off" class="form-control countdown-end" placeholder="example: 2020-08-01 12:30:00" name="couponStarttime">
											</div>
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
	
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/daterangepicker/moment.min.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/back/lib/daterangepicker/datepicker.min.js"></script>
	
	
	<!-- custom script -->
	<script>
		var hasParentCategory = false;
		var isCreate = false;
		// init
		getCollectionsData();
		renderTabItems();
		$('.btn-save-search').on('click', function () {
			var searchCollectionVal = {
				// supercate: $('#searchSupercate').find('option:selected').text(),
				// supercateId: $('#searchSupercate').val(),
				collection: $('#searchCollection').val()
			};
			// cancel repeat add save-search
			if (checkNewItem(searchCollectionVal)) return;
			// if (parseInt(searchCollectionVal.supercateId) < 0) searchCollectionVal.supercate = "";
			if (searchCollectionVal.collection) {
				addCollectionItem(searchCollectionVal);
				createCollectionItem(searchCollectionVal).addClass('active')
				addTableTabItem(searchCollectionVal);
				$('.c-table-tab-tempory').html('');
			}
		});
		// search it

		var oldTime = (new Date()).getTime(),
			timer = null;
		$('#searchCollection').on('keyup', function() {
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
			var searchCollectionVal = {
				collection: $('#searchCollection').val()
			};
			// inital pagination num
			setPageNum(1);
			// check searchCollection
		
			$('.c-table-tab-item.active').removeClass('active');
			$('.c-table-tab-tempory').html(createCollectionItem(searchCollectionVal).addClass('active'));
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
				$('#searchCollection').val(dataVal.collection || '');
				getSearchCollectionsData();
			} else {
				$('#searchCollection').val('');
				getCollectionsData();
			}
		}
		// tab delete
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
			getProductList(renderProductList);
			isCreate = true;
		});
		// edit collection
		$(document.body).on('click', '.btn-edit', function (e) {
			var couponId = parseInt($(this).data('id'));
			getOneCollectionData({
				couponId: couponId
			}, function(resData) {
				$('.c-create c-option-title').text('Edit Collection');
				showCreateBlock();
				initFormData(resData);
				// getProductList(renderProductList);
			});
		});
		// delete collection
		$(document.body).on('click', '.btn-delete', function (e) {
			var couponId = parseInt($(this).data('id'));
			$('#deleteModal').find('.modal-title').html('Delete SuperCategory!');
			$('#deleteModal').modal('show');
			$('#deleteModal .btn-ok').one('click', function () {
				deleteCollectionData({
					couponId: couponId,
				}, function() {
					getCollectionsData();
					getProductList(renderProductList);
				});

			});
		});
		// save collection
		$('.c-create .btn-save').on('click', function () {
			saveCollectionData(getFormData(), function() {
				showInitBlock();
				getCollectionsData();
				getProductList(renderProductList);
				isCreate = false;
			});
		});
		// cancel collection save
		$('.c-create .btn-cancel').on('click', function () {
			if (isCreate) {
				deleteCollectionData({
					couponId: $('#couponId').val(),
				}, function() {
					showInitBlock();
					isCreate = false;					
				});
			}

			showInitBlock();
		});
		// tab create/init
		function showCreateBlock() {
			$('.c-init').addClass('hide');
			$('.c-create').removeClass('hide');
			if (!hasParentCategory) getProductList(renderProductList);
		}
		function showInitBlock() {
			$('.c-init').removeClass('hide');
			$('.c-create').addClass('hide');
		}
		// handle formData
		// reset data
		function resetFormData() {
			$('#couponId').val('');
			$('#couponName').val('');
			$('#couponPrice').val('');
			$('#couponStatus').prop('checked', false);
			$('#couponPriceBaseline').val('');
			$('#couponCode').val('');
			$('#couponPriceoff').val('5');
			$('#couponType').val('0');
			$('#couponLuckdrawType').val('0');
			$('#couponLuckdrawWeight').val('');
			$('#couponProductonlyType').val('0');
			$('#couponProductonlyPidstr').val('-1');
			$('#couponStarttime').val('');
			$('#couponEndtime').val('');
			
		}
		// getFormdData
		function getFormData() {
			var data = {};
			data.couponId = parseInt($('#couponId').val());
			data.couponName = $('#couponName').val();
			data.couponPrice = $('#couponPrice').val();
			data.couponStatus = $('#couponStatus').prop('checked') ? 1 : 0;
			data.couponPriceBaseline = $('#couponPriceBaseline').val();
			data.couponPriceoff = $('#couponPriceoff').val();
			data.couponCode = $('#couponCode').val();
			data.couponType = $('#couponType').val();
			data.couponLuckdrawType = $('#couponLuckdrawType').val();
            data.couponLuckdrawWeight = $('#couponLuckdrawWeight').val();
			data.couponProductonlyType = $('#couponProductonlyType').val();
			data.couponProductonlyPidstr = $('#couponProductonlyPidstr').val();
			// data.couponProductonlyPidstr = $('#couponProductonlyPidstr').find('option:selected').val();
			data.couponProductonlyPidstr = $('#couponProductonlyPidstr').find('option:selected').val();
			
			
			
			data.couponStarttime = $('#couponStarttime').val();
			data.couponEndtime = $('#couponEndtime').val();
			return data;
		}
		// initFormData
		function initFormData(data) {
			$('#couponId').val(data.couponId);
			$('#couponName').val(data.couponName);
			$('#couponStatus').prop('checked', data.couponStatus);
			$('#couponPrice').val(data.couponPrice);
			$('#couponPriceoff').val(data.couponPriceoff);
			$('#couponPriceBaseline').val(data.couponPriceBaseline);
			$('#couponCode').val(data.couponCode);
			$('#couponType').val(data.couponType);
			var coupontypezt = data.couponType;
			console.log(coupontypezt)
			if(coupontypezt==0){
				$(".open_0").show()
			}else if(coupontypezt==1){
				$(".open_1").show()
				$(".open_0").hide()
			}
			$('#couponLuckdrawType').val(data.couponLuckdrawType);
			var drawtype = data.couponLuckdrawType;
			if(drawtype==0){
				$(".open_draw").hide()
			}else if(drawtype==1){
				$(".open_draw").show()
			}
			$('#couponLuckdrawWeight').val(data.couponLuckdrawWeight);
			$('#couponProductonlyType').val(data.couponProductonlyType);
			var showproduct = data.couponProductonlyType;
			if(showproduct==1){
				$(".open_product").show();
			};
			$('#couponProductonlyPidstr').val(data.couponProductonlyPidstr || '-1');
			$('#couponProductonlyPidstr').attr('data-val', data.couponProductonlyPidstr || '-1');
			$("#couponStarttime").val(data.couponStarttime);
			$("#couponEndtime").val(data.couponEndtime);
			
			
		}
		// callback id
		function getCollectionId() {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH }/MlbackCoupon/initializaCoupon",
				type: "post",
				dataType: "json",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					console.log(data)
					if (data.code == 100) {
						$('#couponId').val(data.extend.mlbackCoupon.couponId);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('initial superCate fail：' + err);
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		//  callback get all
		function getCollectionsData(val) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCoupon/getMlbackCouponByPage",
				type: "post",
				data: "pn=" + getPageNum(),
				success: function (data) {
					console.log(data)
					if (data.code == 100) {
						renderTable(data.extend.pageInfo.list);
						renderTablePagination(data.extend.pageInfo);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('Failed to get Super-Categeory, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		
		function getOneCollectionData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCoupon/getOneMlbackCouponDetailById",
				type: "post",
				data: reqData,
				// data: JSON.stringify(reqData),
				// dataType: 'json',
				// contentType: 'application/json', 
				success: function (data) {
					if (data.code == 100) {
						console.log(data.extend.mlbackCouponOne)
						callback(data.extend.mlbackCouponOne);
						toastr.success(data.extend.resMsg);
					} else {
						toastr.error(data.extend.resMsg);
					}
				},
				error: function (err) {
					toastr.error('Failed to get Super-Categeory, please refresh the page to get again！');
				},
				complete: function () {
					$('.c-mask').hide();
				}
			});
		}
		/**************/
		// callback save
		function saveCollectionData(reqData, callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackCoupon/save",
				data: JSON.stringify(reqData),
				dataType: "json",
				contentType: 'application/json',
				type: "post",
				success: function (data) {
					console.log(data)
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
				url: "${APP_PATH}/MlbackCoupon/delete",
				type: "post",
				cache: false,
				dataType: "json",
				contentType: 'application/json',
				data: JSON.stringify(reqData),
				success: function (data) {
					console.log(data)
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
				var coupontype =data[i].couponType;
			    var couponLuckdrawtype = data[i].couponLuckdrawType;
				
				// var couponPrice = $("<td></td>").append(type == 0 ? parseFloat(item.couponPrice) : '');
				// var couponPriceOff = $("<td></td>").append(type == 1 ? item.couponPriceOff + '%' : '');
				
				htmlStr += '<tr><td>' + data[i].couponId + '</td>' +
					'<td>' + data[i].couponName + '</td>' +
					 '<td>' + data[i].couponPriceBaseline + '</td>' +
					 '<td>'+(coupontype == 1 ? 'Discount' : 'Full')+'</td>' +
					 // '<td>' + data[i].couponPrice + '</td>' +
					 '<td>' +(coupontype == 0 ? parseFloat(data[i].couponPrice) : '')+ '</td>' +
					 // '<td>' + data[i].couponPriceoff + '%</td>' +
					  '<td>' +(coupontype == 1 ? parseFloat(data[i].couponPriceoff)+'%' : '')+ '</td>' +
					 '<td>' + data[i].couponCode + '</td>' +
					 '<td>'+(couponLuckdrawtype == 1 ? 'yes' : 'no')+'</td>' +
					  '<td>' + data[i].couponLuckdrawWeight + '%</td>' +
					   '<td>' + data[i].couponProductonlyType +'</td>' +
					   
					   '<td>' + (data[i].couponStatus ? 'enable' : 'disable') + '</td>' +
					 
					'<td>' +
					'<button class="btn btn-primary btn-edit" data-id="' + data[i].couponId + '">' +
					'<svg class="c-icon">' +
					'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-pencil"></use>' +
					'</svg>' +
					'</button>' +
					'<button class="btn btn-danger btn-delete" data-id="' + data[i].couponId + '">' +
					'<svg class="c-icon">' +
					'<use xlink:href="${APP_PATH}/static/back/img/svg/free.svg#cil-trash"></use>' +
					'</svg>' +
					'</button>' +
					'</td></tr>';
			}
			$('.c-table-table tbody').html(htmlStr);
		}
		/************/
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
		
				$('.c-table-tab-list').append(htmlStr);
			}
			// check activeItem exsits or not.
			if ($('.c-table-tab-item.active').length < 1) {
				$('.c-table-tab-item').eq(0).addClass('active');
			}
		
			getTabSearchData($('.c-table-tab-item.active'));
		}
		function checkNewItem(val) {
			var collecitonList = getCollectionList();
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
			$('.c-table-tab-list').append(createCollectionItem(val).addClass('active'));
			setActiveItemNum($('.c-table-tab-item').length - 1);
		}
		function createCollectionItem(val) {
			var textArr = [];
			// if (val.supercate) {
			// 	textArr.push(val.supercate)
			// }
			if (val.collection) {
				textArr.push(val.collection)
			}
		
			return $('<div class="c-table-tab-item">' + textArr.join("-") + '<div class="delete-table-tab-item c-icon">x</div></div>').attr('data-val', JSON.stringify(val));
		}
		function deleteTableTabItem(e) {
			e.stopPropagation();
			var targetEl = $(e.target),
				parentEl = targetEl.parent('.c-table-tab-item'),
				itemVal = $(parentEl).data('val');

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
		/************************************************************************************/
		function getProductList(callback) {
			$('.c-mask').show();
			$.ajax({
				url: "${APP_PATH}/MlbackProduct/lownLoadProduct",
				type: "post",
				contentType: 'application/json',
				async: false,
				success: function (data) {
					console.log(data)
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
		function renderProductList(data) {
			var htmlStr = '<option value="-1">Please Select parent-category</option>';
			for (var i = 0; i < data.length; i += 1) {
					htmlStr += '<option value="' + data[i].productId + '">'+ data[i].productId+"    " + data[i].productName + '</option>';
				}
			$('#couponProductonlyPidstr').html(htmlStr);
			hasParentCategory = true;
			initFormFiled();
		}
		function initFormFiled() {
			$('#couponProductonlyPidstr').val($('#couponProductonlyPidstr').data('val') || '-1');
		}


		$(".choose_coup select").change(function () {
			if ($(this).val() == 0) {
				$(".open_1").hide();
				$(".open_0").show();
			} else if ($(this).val() == 1) {
				$(".open_1").show();
				$(".open_0").hide();
			}
		});
		$(".choose_draw select").change(function () {
			if ($(this).val() == 0) {
				$(".open_draw").hide();
			} else if ($(this).val() == 1) {
				$(".open_draw").show();
			}
		});
		$(".choose_product select").change(function () {
			if ($(this).val() == 0) {
				$(".open_product").hide();
			} else if ($(this).val() == 1) {
				$(".open_product").show();
			}
		});
		/********************************/
		// callback get search data
		function getSearchCollectionsData(data) {
			$('.c-mask').show();
		
			var formData = new FormData();
			formData.append('couponName', $('#searchCollection').val());
			formData.append('pn', getPageNum());
			$.ajax({
				url: "${APP_PATH }/MlbackCoupon/backSearchByCoupon",
				type: "post",
				processData: false,
				contentType: false,
				cache: false,
				data: formData,
				success: function (data) {
					if (data.code == 100) {
						console.log("******************")
						console.log(data)
						console.log("******************")
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
		
		
		/*****************************/
		function  datePickerint(){
			$('.J-datepicker').datePicker({
			  hasShortcut:true,
			  min:'2018-01-01 04:00:00',
			  max:'2050-09-09 20:59:59',
			  shortcutOptions:[{
				name: '今天',
				day: '0'
			  }, {
				name: '昨天',
				day: '-1',
				time: '00:00:00'
			  }, {
				name: '一周前',
				day: '-7'
			  }],
			  hide:function(){
				console.info(this)
			  }
			}); 
		}
			$(function () {
				 datePickerint()
				
			});
		
		
		
	</script>
</body>

</html>