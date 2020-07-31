<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title>Product List</title>
	<jsp:include page="common/processor.jsp" flush="true"></jsp:include>
	<script>
		var categorySeo = '${sessionScope.categorySeo}';
		var seoDescription = '${sessionScope.categoryMetaDesc}';
		var seoKeywords = '${sessionScope.categoryMetaKeyWords}';
		document.title = categorySeo;
		addMeta('keyword', seoKeywords);
		addMeta('description', seoDescription);
	</script>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
</head>

<body>
    <jsp:include page="layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="category-condition">
				<span class="category-condition-name">style</span>
				<select class="category-select"></select>
			</div>
			<div class="product-list"></div>		
		</div>
	</main>
	<jsp:include page="layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<script>
		function getProductListByCategorySeo(categorySeo, hasCategory) {
			$.ajax({
				url: "${APP_PATH}/MlbackCategory/searchBycategorySeo",
				type: "post",
				data: JSON.stringify({"categorySeo": categorySeo}),
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						renderCategorySeo(data.extend, hasCategory);
					} else {
						refreshPageModal();
					}
				},
				error: function () {
					refreshPageModal();
				}
			});
		}
		function renderCategorySeo(data, hasCategory) {
			if (!hasCategory) renderCategorySelect(data.mlbackCategorydownList);
			renderProductList(data.mlbackProductResList);
		}
		function renderProductList(data) {
			var htmlStr = '';
			if(data.length) {
				data.forEach(function(item) {
					var productLink = '${APP_PATH}/'+ item.productSeo +'.html';
					htmlStr += '<div class="product-item-box"><div class="product-item" data-productid="'+ item.productId +'">' +
					    '<span class="product-discount-label'+ (item.productDiscoutimgShow ? ' show' : '') +'" style="background-image: url('+ (item.productDiscoutimgurl || '') +');"></span>' +
						'<div class="product-img">' +
							'<a href="'+ productLink +'" class="lazyload" data-src="'+ item.productMainimgurl +'"></a>' +
						'</div>' +
						'<div class="product-desc">' +
							'<div class="product-name"><a href="'+ productLink +'">'+ item.productName +'</a></div>' +
							'<div class="product-data">' +
								'<span class="product-pay-num">'+ (item.productHavesalenum || 0) +' Order(s)</span>' +
								'<span class="product-review-num">'+ (item.productReviewnum || 0) +' Review(s)</span>' +
							'</div>' +
							'<div class="product-price">' +
								'<span class="product-define-price">$'+ (item.productOriginalprice || 0) +'</span>' +
								'<span class="product-now-price">$'+ (item.productOriginalprice && item.productActoffoff ? (item.productOriginalprice * item.productActoffoff / 100).toFixed(2) : 0) +'</span>' +
							'</div>' +
						'</div>' +
					'</div></div>';					
				});
			} else {
				htmlStr += '<p class="data-info">Relevant product classification products have been removed from the shelves!</p>';
			}
			
			$('.product-list').html(htmlStr);
			// lazyload
			new LazyLoad($('.product-list').find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
		}
		function renderCategorySelect(data) {
			var htmlStr = '';
			data.forEach(function(item) {
				htmlStr += '<option value="'+ item.categorySeo +'" '+ (categorySeo == item.categorySeo ? 'selected' : '') +'>'+ item.categoryName +'</option>';
			});
			$('.category-select').html(htmlStr);
		}
		getProductListByCategorySeo(categorySeo, false);
		$(document.body).on('change', '.category-select', function() {
			getProductListByCategorySeo($(this).val(), true);
		});

		// get introduct product
		getProductSlideArea(function(data) {
			var $el = $('<div id="introduce-product" />');
			$('main .container').append($el);
			data.length && (renderIntroduceProductSlide($el, data),
			new LazyLoad($el.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			}));
		});
		addTidio();
	</script>
</body>

</html>