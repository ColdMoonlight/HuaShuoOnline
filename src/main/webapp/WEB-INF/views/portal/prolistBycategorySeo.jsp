<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Insert title here</title>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
</head>

<body>
    <jsp:include page="layout/header.jsp" flush="true"></jsp:include>
	<main> </main>
	<jsp:include page="layout/footer.jsp" flush="true"></jsp:include>
	<script>
	var categorySeo = '${sessionScope.categorySeo}';
		$.ajax({
			url: "${APP_PATH}/MlbackCategory/searchBycategorySeo",
			type: "post",
			data: JSON.stringify({"categorySeo": categorySeo}),
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					renderCategorySeo(data.extend);
					// toastr.success(data.extend.resMsg);
				} else {
					// toastr.error(data.extend.resMsg);
				}
			},
			error: function () {
				// toastr.error('please refresh the page to get again！');
			},
			complete: function () {}
		});
		function renderCategorySeo(data) {
			renderCategorySelect(data.mlbackCategorydownEr);
			renderProductList(data.mlbackProductResList);
		}
		function renderProductList(data) {
			var htmlStr = '';
			if(data.length) {
				data.forEach(function(item) {
					htmlStr += '<div class="product-item" data-productid="'+ item.productId +'">' +
					    '<span class="product-discount-label"></span>'+
						'<div class="product-img">' +
							'<a href="${APP_PATH}/'+ item.productSeo +'.html">' +
								'<img src="'+ item.productMainimgurl +'" alt="">' +
							'</a>' +
						'</div>' +
						'<div class="product-desc">' +
							'<div class="product-name">'+ item.productName +'</div>' +
							'<div class="product-data">' +
								'<span class="product-pay-num">'+ (item.productHavesalenum || 0) +' Order(s)</span>' +
								'<span class="product-review-num">'+ (item.productReviewnum || 0) +' Review(s)</span>' +
							'</div>' +
							'<div class="product-price">' +
								'<span class="product-now-price">$'+ (item.productOriginalprice && item.productActoffoff ? (item.productOriginalprice * item.productActoffoff / 100).toFixed(2) : 0) +'</span>' +
								'<span class="product-define-price">$'+ (item.productOriginalprice || 0) +'</span>' +
							'</div>' +
						'</div>' +
					'</div>';					
				});
			} else {
				htmlStr += '<p class="data-info">Relevant product classification products have been removed from the shelves!</p>';
			}
			
			$('main').append('<div class="product-list">'+ htmlStr + '</div>');
		}
		function renderCategorySelect(data) {
			var htmlStr = '';
			data.forEach(function(item) {
				htmlStr += '<option value="'+ item.categoryId +'" '+ (categorySeo == item.categorySeo ? 'selected' : '') +'>'+ item.categoryName +'</option>';
			});
			$('main').append('<div class="category-condition">' +
				'<span class="category-condition-name">style</span>' +
				'<select class="category-select">' + htmlStr + '</select>' +
			'</div>');
		}
	</script>
</body>

</html>