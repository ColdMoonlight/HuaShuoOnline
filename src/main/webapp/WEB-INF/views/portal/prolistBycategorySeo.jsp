<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:choose>
<c:when test="${sessionScope.categorySeo==null}"><title>Product List</title></c:when>
<c:otherwise><title>${ sessionScope.categorySeo }</title></c:otherwise>
</c:choose>
	<jsp:include page="common/processor.jsp" flush="true"></jsp:include>
    <meta name="keyword" content="${sessionScope.categoryMetaKeyWords}">
    <meta name="description" content="${sessionScope.categoryMetaDesc}">
	<script>
		var categorySeo = '${sessionScope.categorySeo}';
	</script>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
	<style>@media only screen and (max-width: 1023px) { main { margin: 0; } main .container { margin: 1rem; } } @media only screen and (min-width: 1024px) { main .container { margin-top: 1rem; } }</style>
</head>
<body>
    <jsp:include page="layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="search-product-banner"></div>
		<div class="container">
			<div class="category-condition">
				<span class="category-condition-name">style</span>
				<select class="category-select"></select>
			</div>
			<div class="product-list"></div>		
		</div>
	<!-- main end -->
	<!-- common script -->
	<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
	<!-- third lib -->
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<script>
		function getProductListByCategorySeo(categorySeo, hasCategory) {
			$.ajax({
				url: "${APP_PATH}/MlbackCategory/searchBycategorySeo",
				type: "post",
				data: JSON.stringify({"categorySeo": categorySeo}),
				dataType: 'json',
				contentType: 'application/json',
				async: false,
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
			renderSearchBanner({
				imgStatus: data.cateImgStatus,
				imgUrl: data.cateImg
			});
			if (!hasCategory) renderCategorySelect(data.mlbackCategorydownList || []);
			renderProductList(descPrdouct(data.mlbackProductResList || []));
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
								'<span class="product-pay-num"><i>'+ (item.productHavesalenum || 0) +'</i> Order(s)</span>' +
								'<span class="product-review-num">'+ (item.productReviewnum || 0) +' Review(s)</span>' +
							'</div>' +
							'<div class="product-price">' +
								'<span class="product-define-price">$'+ (item.productOriginalprice || 0).toFixed(2) +'</span>' +
								'<span class="product-now-price">$'+ (item.productOriginalprice && item.productActoffoff ? accuracyCal(item.productOriginalprice, item.productActoffoff) : 0) +'</span>' +
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
			data.length && data.forEach(function(item) {
				htmlStr += '<option value="'+ item.categorySeo +'" '+ (categorySeo == item.categorySeo ? 'selected' : '') +'>'+ item.categoryName +'</option>';
			});
			$('.category-select').html(htmlStr);
		}
		function renderSearchBanner(data) {
			var $searchBanner = $('.search-product-banner');
			if (data.imgStatus && data.imgUrl) {
				$searchBanner.attr('data-src')
				var htmlStr = '<div class="wap lazyload" data-src="'+ data.imgUrl +'"></div>' +
					'<div class="pc lazyload" data-src="'+ data.imgUrl +'"></div>'
					$searchBanner.html(htmlStr);
			} else {
				$searchBanner.addClass('hide');
			}
			// lazyload
			new LazyLoad($searchBanner.find('.lazyload'), {
				root: null,
				rootMargin: "10px",
				threshold: 0
			});
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
	</script>
	<!-- footer nav -->
	<jsp:include page="layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>

</html>