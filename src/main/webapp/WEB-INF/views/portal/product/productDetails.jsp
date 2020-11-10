<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<c:choose>
<c:when test="${sessionScope.mlbackProductMetaTitle==null}"><title>Product Details</title></c:when>
<c:otherwise><title>${ sessionScope.mlbackProductMetaTitle }</title></c:otherwise>
</c:choose>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
    <meta name="keyword" content="${sessionScope.mlbackProductMetaKeyWords}">
    <meta id="ml-des" name="description" content="${sessionScope.mlbackProductMeteDesc}">
	<script>
		var productId = '${sessionScope.productDetailId}';
		var productSeo;
		var productName;
	</script>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
	<style>
		main {margin-top: 1rem;}
		@media only screen and (max-width: 575px) {
			main { margin: 0 }
			.product-details, .product-body, .product-footer { margin-left: 1rem; margin-right: 1rem; }
			.product-share .instagram {width:2rem;height:2rem;background-position: 0 -2rem;}
		}
		@media only screen and (min-width: 576px) and (max-width: 1023px) { .product-share .instagram {width:2.5rem;height:2.5rem;background-position: 0 -2.5rem;} }		
		@media only screen and (min-width: 1023px) { .product-share .instagram {width:3rem;height:3rem;background-position: 0 -3rem;} }
	</style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="container">
			<div class="product-header">
				<div class="product-media">
					<div class="swiper-container product-slide product-zoom">
						<div class="swiper-wrapper">
							<c:forEach items="${ mbackProductImgResList }" var="pro"><div class="swiper-slide"><div class="lazyload img" data-src="${ pro.productimgUrl }" rel="${ pro.productimgUrl }"></div><noscript><img src="${ pro.productimgUrl }" alt="${ sessionScope.mlbackProductMetaTitle }" /></noscript></div></c:forEach>
						</div>
			   			<div class="swiper-pagination"></div>
					    <div class="swiper-btn swiper-button-next"></div>
			            <div class="swiper-btn swiper-button-prev"></div>
					</div>
					<div class="swiper-container product-thumb-slide">
						<div class="swiper-wrapper"></div>
					    <div class="swiper-button-next"></div>
			            <div class="swiper-button-prev"></div>
					</div>
					<div class="product-share">
						<a class="instagram" style="display: inline-block;background-image: url('${APP_PATH}/static/pc/img/follow-us.png');background-repeat: no-repeat;background-size: 100% auto;" href="https://www.instagram.com/megalookhair/" title="megalook instagram"></a>
						<div class="share-item" data-url="https://plus.google.com/share?url=" title="share on google+"></div>
						<div class="share-item" data-url="https://twitter.com/intent/tweet?url=" title="share on twitter"></div>
						<div class="share-item" data-url="https://www.facebook.com/sharer/sharer.php?u=" title="share on facebook"></div>
						<div class="share-item" data-url="https://www.pinterest.com/pin/create/button/?url=" title="share on pinterest"></div>
						<div class="share-item" data-url="https://api.whatsapp.com/send?text=" title="share on whatsapp"></div>
					</div>
				</div>
				<div class="product-details">
					<div class="product-name"></div>
					<div class="product-coupons hide"></div>
					<div class="product-options"></div>
					<div class="product-price"></div>
					<div class="product-operate">
						<div class="name">Qty:</div>
						<div class="product-qty">
							<span class="group-addon" id="product-num-sub"><i class="icon sub"></i></span>
							<input type="text" class="product-num" value="1" data-count="1" disabled>					 
							<span class="group-addon" id="product-num-add"><i class="icon plus"></i></span>					
						</div>
					</div>
					<div class="product-pay paypal-button-container">
						<div class="btn paypal-button btn-primary" id="add-to-cart">Add To Cart</div>
		   				<div class="btn paypal-button btn-black buy-now">Buy Now</div>
						<!-- <div title="paypal" class="btn paypal-button paypal-now paypal-button-paypal"></div>
				        <div title="credit" class="btn paypal-button paypal-now paypal-button-credit"></div> -->
					</div>
					<div id="countdown-area"></div>
				</div>
			</div>
			<div class="product-body">
				<div class="product-service">
					<div class="product-service-item">
						<div class="icon car"></div>
						<p>Free Shipping</p>
					</div>
					<div class="product-service-item">
						<div class="icon back"></div>
						<p>15 Days Returns</p>
					</div>
					<div class="product-service-item">
						<div class="icon lock"></div>
						<p>Secure Payment</p>
					</div>
				</div>
				<div class="product-tab">
					<div class="product-tab-item btn btn-primary" data-name="desc">Description</div>
					<div class="product-tab-item btn btn-black" data-name="review">Reviews</div>
				</div>
				<div class="product-tab-body">
					<div class="product-tab-container active" data-name="desc"></div>
					<div class="product-tab-container" data-name="review">
						<div class="product-review-title">
							<div class="product-review-cal">
								<div class="product-review-total">Based on <span>0</span> Customer Reviews</div>
								<div class="product-review-avgstar">
									<span class="icon star"></span>
									<span class="icon star"></span>
									<span class="icon star"></span>
									<span class="icon star"></span>
									<span class="icon star"></span>
								</div>
								<div class="product-review-star-list"></div>
							</div>
							<div class="product-review-add">
								<button class="btn btn-black" id="write-review">Write A Review</button>
							</div>
						</div>
						<div class="product-review-body">
							<div class="product-review-list"></div>
							<div id="table-pagination"></div>
						</div>
						<div class="loader-box" id="loader-box">
							<div class="loader"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="product-footer"></div>
		</div>
	<!-- main end -->
	<!-- common script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<!-- third lib -->
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<script src="${APP_PATH}/static/pc/js/jqfly/jquery.fly.min.js"></script>
	<!-- productdetails script -->
	<jsp:include page="./productdetails-script.min.jsp" flush="true"></jsp:include>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>