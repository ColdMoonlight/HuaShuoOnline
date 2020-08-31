<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
	<head>
		<title>Megalook Hair - Megalook Offical Store</title>
		<meta name="keyword" content="Megalook,MegaLook Hair,Human Hair Wig,Full Lace Wig, 360 Lace Front Wig, Lace Front Wig,Bundles with Closure,straight Human Hair,Body Wave Human Hair,Water Wave Human Hair,Deep Wave Wig,Loose Wave Wig,kinky Curly Wig,Jerry Curly Wig,Bob Wig,Yaki Straight Wig,Full Lace Wig,Transparent Lace Wig,613 Blonde Wig,Ombre Color Wig,613 blonde hair">
		<meta name="description" content="Megalook Hair Official Website Sells Best Virgin Hair, Full Lace Wig, Transparent Lace Wig, 360 Lace Wig, Frontal Lace Wig, Closure Lace Wig, Bundles with Closure, Bundles with Frontal, Free Wig Making Service. Hottest Products, Free Gifts, Free & Fast Shipping. No Shedding, No Tangles, Save Big! Lowest Price For U.">
		<jsp:include page="WEB-INF/views/portal/common/processor.jsp" flush="true"></jsp:include>
		<jsp:include page="WEB-INF/views/portal/common/header.jsp" flush="true"></jsp:include>
		<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
		<style> main { margin: -16px 0 0 0; background-color: #f5f5f5;}</style>
	</head>
	<body>
		<jsp:include page="WEB-INF/views/portal/layout/header.jsp" flush="true"></jsp:include>
		<!-- main start -->
			<div class="ml-index-carousel swiper-container">
				<div class="swiper-wrapper"></div>
		   		<div class="swiper-pagination"></div>
			    <div class="swiper-btn swiper-button-next"></div>
	            <div class="swiper-btn swiper-button-prev"></div>
			</div>
			<div id="hot-five" class="hot-five"></div>
			<div id="hot-two" class="hot-two"></div>
			<div id="hot-coupon" class="hot-coupon"></div>
			<div id="activity-product" class="activity-product"></div>
			<div id="hot-collection" class="hot-collection"></div>
			<div id="showAreaOne" class="showarea showAreaOne"></div>
			<div id="showAreaTwo" class="showarea showAreaTwo"></div>
			<div id="showAreaThree" class="showarea showAreaThree"></div>
		<!-- main end -->
		<!-- common script -->
		<jsp:include page="WEB-INF/views/portal/common/footer.jsp" flush="true"></jsp:include>
		<!-- third lib -->
		<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
		<!-- index script -->
		<jsp:include page="index-script.min.jsp" flush="true"></jsp:include>
		<!-- footer nav -->
		<jsp:include page="WEB-INF/views/portal/layout/footer.jsp" flush="true"></jsp:include>
		<!-- lottery -->
		<jsp:include page="WEB-INF/views/portal/layout/lottery.jsp" flush="true"></jsp:include>
		<script> addTidio(); </script>
	</body>
</html>