<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title></title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
	<link href="${APP_PATH}/static/pc/js/jqzoom/jqzoom.css" rel="stylesheet">
	<link href="${APP_PATH}/static/pc/js/video/video.min.css" rel="stylesheet">
	<script>
		// console.log('${sessionScope}')
		var productId = '${sessionScope.productDetailId}';
		var seoTitle = '${sessionScope.mlbackProductMetaTitle}';
		var seoDescription = '${sessionScope.mlbackProductMeteDesc}';
		var seoKeywords = '${sessionScope.mlbackProductMetaKeyWords}';
		document.title = seoTitle;
		addMeta('keyword', seoKeywords);
		addMeta('description', seoDescription);
	</script>
	<style>
		@media only screen and (max-width: 1023px) {
			main { margin: 0 }
			.product-details, .product-body, .product-footer { margin-left: 1rem; margin-right: 1rem; }
		}
	</style>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container">
			<div class="product-header">
				<div class="product-media">
					<div class="swiper-container product-slide product-zoom">
						<div class="swiper-wrapper"></div>
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
						<div class="share-item" data-url="https://plus.google.com/share?url=" title="share on google+">google + </div>
						<div class="share-item" data-url="https://twitter.com/intent/tweet?url=" title="share on twitter">twitter</div>
						<div class="share-item" data-url="https://www.facebook.com/sharer/sharer.php?u=" title="share on facebook">facebook</div>
						<div class="share-item" data-url="https://www.pinterest.com/pin/create/button/?url=" title="share on pinterest">pinterest</div>
						<div class="share-item" data-url="https://api.whatsapp.com/send?text=" title="share on whatsapp">whatsapp</div>
					</div>
				</div>
				<div class="product-details">
					<div class="product-name"></div>
					<div class="product-coupons">
						<img class="left" src="http://megalook.com:80/static/img/CouponDescTitle/couponTitlepcId1time8154942.jpg">
						<div class="right">
							<div class="title">Mid-Year Sale  Screaming Price</div>
							<ul class="body">
								<li>Extra&nbsp;<span>&nbsp;6% Off&nbsp;</span>&nbsp;With No Limit, Code :&nbsp;<b>&nbsp;MY6</b></li>
								<li>Over $99&nbsp;<span>&nbsp;Get Extra 12%&nbsp;</span>&nbsp;Off ! Code :&nbsp;<b>&nbsp;MY12</b></li>
							</ul>
						</div>
					</div>
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
		   				<div class="btn paypal-button btn-black" id="buy-now">Buy Now</div>
						<div title="paypal" class="btn paypal-button paypal-button-paypal">
				            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMzIiIHZpZXdCb3g9IjAgMCAyNCAzMiIgcHJlc2VydmVBc3BlY3RSYXRpbz0ieE1pbllNaW4gbWVldCIgeG1sbnM9Imh0dHA6JiN4MkY7JiN4MkY7d3d3LnczLm9yZyYjeDJGOzIwMDAmI3gyRjtzdmciPjxwYXRoIGZpbGw9IiMwMDljZGUiIG9wYWNpdHk9IjEiIGQ9Ik0gMjAuOTI0IDcuMTU3IEMgMjEuMjA0IDUuMDU3IDIwLjkyNCAzLjY1NyAxOS44MDEgMi4zNTcgQyAxOC41ODMgMC45NTcgMTYuNDMgMC4yNTcgMTMuNzE2IDAuMjU3IEwgNS43NTggMC4yNTcgQyA1LjI5IDAuMjU3IDQuNzI5IDAuNzU3IDQuNjM0IDEuMjU3IEwgMS4zNTggMjMuNDU3IEMgMS4zNTggMjMuODU3IDEuNjM5IDI0LjM1NyAyLjEwNyAyNC4zNTcgTCA2Ljk3NSAyNC4zNTcgTCA2LjY5NCAyNi41NTcgQyA2LjYgMjYuOTU3IDYuODgxIDI3LjI1NyA3LjI1NSAyNy4yNTcgTCAxMS4zNzUgMjcuMjU3IEMgMTEuODQ0IDI3LjI1NyAxMi4zMTEgMjYuOTU3IDEyLjQwNSAyNi40NTcgTCAxMi40MDUgMjYuMTU3IEwgMTMuMjQ3IDIwLjk1NyBMIDEzLjI0NyAyMC43NTcgQyAxMy4zNDEgMjAuMjU3IDEzLjgwOSAxOS44NTcgMTQuMjc3IDE5Ljg1NyBMIDE0Ljg0IDE5Ljg1NyBDIDE4Ljg2NCAxOS44NTcgMjEuOTU0IDE4LjE1NyAyMi44OSAxMy4xNTcgQyAyMy4zNTggMTEuMDU3IDIzLjE3MiA5LjM1NyAyMi4wNDggOC4xNTcgQyAyMS43NjcgNy43NTcgMjEuMjk4IDcuNDU3IDIwLjkyNCA3LjE1NyBMIDIwLjkyNCA3LjE1NyI+PC9wYXRoPjxwYXRoIGZpbGw9IiMwMTIxNjkiIG9wYWNpdHk9IjEiIGQ9Ik0gMjAuOTI0IDcuMTU3IEMgMjEuMjA0IDUuMDU3IDIwLjkyNCAzLjY1NyAxOS44MDEgMi4zNTcgQyAxOC41ODMgMC45NTcgMTYuNDMgMC4yNTcgMTMuNzE2IDAuMjU3IEwgNS43NTggMC4yNTcgQyA1LjI5IDAuMjU3IDQuNzI5IDAuNzU3IDQuNjM0IDEuMjU3IEwgMS4zNTggMjMuNDU3IEMgMS4zNTggMjMuODU3IDEuNjM5IDI0LjM1NyAyLjEwNyAyNC4zNTcgTCA2Ljk3NSAyNC4zNTcgTCA4LjI4NiAxNi4wNTcgTCA4LjE5MiAxNi4zNTcgQyA4LjI4NiAxNS43NTcgOC43NTQgMTUuMzU3IDkuMzE1IDE1LjM1NyBMIDExLjY1NSAxNS4zNTcgQyAxNi4yNDMgMTUuMzU3IDE5LjgwMSAxMy4zNTcgMjAuOTI0IDcuNzU3IEMgMjAuODMxIDcuNDU3IDIwLjkyNCA3LjM1NyAyMC45MjQgNy4xNTciPjwvcGF0aD48cGF0aCBmaWxsPSIjMDAzMDg3IiBvcGFjaXR5PSIxIiBkPSJNIDkuNTA0IDcuMTU3IEMgOS41OTYgNi44NTcgOS43ODQgNi41NTcgMTAuMDY1IDYuMzU3IEMgMTAuMjUxIDYuMzU3IDEwLjM0NSA2LjI1NyAxMC41MzIgNi4yNTcgTCAxNi43MTEgNi4yNTcgQyAxNy40NjEgNi4yNTcgMTguMjA4IDYuMzU3IDE4Ljc3MiA2LjQ1NyBDIDE4Ljk1OCA2LjQ1NyAxOS4xNDYgNi40NTcgMTkuMzMzIDYuNTU3IEMgMTkuNTIgNi42NTcgMTkuNzA3IDYuNjU3IDE5LjgwMSA2Ljc1NyBDIDE5Ljg5NCA2Ljc1NyAxOS45ODcgNi43NTcgMjAuMDgyIDYuNzU3IEMgMjAuMzYyIDYuODU3IDIwLjY0MyA3LjA1NyAyMC45MjQgNy4xNTcgQyAyMS4yMDQgNS4wNTcgMjAuOTI0IDMuNjU3IDE5LjgwMSAyLjI1NyBDIDE4LjY3NyAwLjg1NyAxNi41MjUgMC4yNTcgMTMuODA5IDAuMjU3IEwgNS43NTggMC4yNTcgQyA1LjI5IDAuMjU3IDQuNzI5IDAuNjU3IDQuNjM0IDEuMjU3IEwgMS4zNTggMjMuNDU3IEMgMS4zNTggMjMuODU3IDEuNjM5IDI0LjM1NyAyLjEwNyAyNC4zNTcgTCA2Ljk3NSAyNC4zNTcgTCA4LjI4NiAxNi4wNTcgTCA5LjUwNCA3LjE1NyBaIj48L3BhdGg+PC9zdmc+">
				            <span class="paypal-button-space"></span>
				            <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMTAwIiBoZWlnaHQ9IjMyIiB2aWV3Qm94PSIwIDAgMTAwIDMyIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWluWU1pbiBtZWV0IiB4bWxucz0iaHR0cDomI3gyRjsmI3gyRjt3d3cudzMub3JnJiN4MkY7MjAwMCYjeDJGO3N2ZyI+PHBhdGggZmlsbD0iIzAwMzA4NyIgZD0iTSAxMi4yMzcgMi40NDQgTCA0LjQzNyAyLjQ0NCBDIDMuOTM3IDIuNDQ0IDMuNDM3IDIuODQ0IDMuMzM3IDMuMzQ0IEwgMC4yMzcgMjMuMzQ0IEMgMC4xMzcgMjMuNzQ0IDAuNDM3IDI0LjA0NCAwLjgzNyAyNC4wNDQgTCA0LjUzNyAyNC4wNDQgQyA1LjAzNyAyNC4wNDQgNS41MzcgMjMuNjQ0IDUuNjM3IDIzLjE0NCBMIDYuNDM3IDE3Ljc0NCBDIDYuNTM3IDE3LjI0NCA2LjkzNyAxNi44NDQgNy41MzcgMTYuODQ0IEwgMTAuMDM3IDE2Ljg0NCBDIDE1LjEzNyAxNi44NDQgMTguMTM3IDE0LjM0NCAxOC45MzcgOS40NDQgQyAxOS4yMzcgNy4zNDQgMTguOTM3IDUuNjQ0IDE3LjkzNyA0LjQ0NCBDIDE2LjgzNyAzLjE0NCAxNC44MzcgMi40NDQgMTIuMjM3IDIuNDQ0IFogTSAxMy4xMzcgOS43NDQgQyAxMi43MzcgMTIuNTQ0IDEwLjUzNyAxMi41NDQgOC41MzcgMTIuNTQ0IEwgNy4zMzcgMTIuNTQ0IEwgOC4xMzcgNy4zNDQgQyA4LjEzNyA3LjA0NCA4LjQzNyA2Ljg0NCA4LjczNyA2Ljg0NCBMIDkuMjM3IDYuODQ0IEMgMTAuNjM3IDYuODQ0IDExLjkzNyA2Ljg0NCAxMi42MzcgNy42NDQgQyAxMy4xMzcgOC4wNDQgMTMuMzM3IDguNzQ0IDEzLjEzNyA5Ljc0NCBaIj48L3BhdGg+PHBhdGggZmlsbD0iIzAwMzA4NyIgZD0iTSAzNS40MzcgOS42NDQgTCAzMS43MzcgOS42NDQgQyAzMS40MzcgOS42NDQgMzEuMTM3IDkuODQ0IDMxLjEzNyAxMC4xNDQgTCAzMC45MzcgMTEuMTQ0IEwgMzAuNjM3IDEwLjc0NCBDIDI5LjgzNyA5LjU0NCAyOC4wMzcgOS4xNDQgMjYuMjM3IDkuMTQ0IEMgMjIuMTM3IDkuMTQ0IDE4LjYzNyAxMi4yNDQgMTcuOTM3IDE2LjY0NCBDIDE3LjUzNyAxOC44NDQgMTguMDM3IDIwLjk0NCAxOS4zMzcgMjIuMzQ0IEMgMjAuNDM3IDIzLjY0NCAyMi4xMzcgMjQuMjQ0IDI0LjAzNyAyNC4yNDQgQyAyNy4zMzcgMjQuMjQ0IDI5LjIzNyAyMi4xNDQgMjkuMjM3IDIyLjE0NCBMIDI5LjAzNyAyMy4xNDQgQyAyOC45MzcgMjMuNTQ0IDI5LjIzNyAyMy45NDQgMjkuNjM3IDIzLjk0NCBMIDMzLjAzNyAyMy45NDQgQyAzMy41MzcgMjMuOTQ0IDM0LjAzNyAyMy41NDQgMzQuMTM3IDIzLjA0NCBMIDM2LjEzNyAxMC4yNDQgQyAzNi4yMzcgMTAuMDQ0IDM1LjgzNyA5LjY0NCAzNS40MzcgOS42NDQgWiBNIDMwLjMzNyAxNi44NDQgQyAyOS45MzcgMTguOTQ0IDI4LjMzNyAyMC40NDQgMjYuMTM3IDIwLjQ0NCBDIDI1LjAzNyAyMC40NDQgMjQuMjM3IDIwLjE0NCAyMy42MzcgMTkuNDQ0IEMgMjMuMDM3IDE4Ljc0NCAyMi44MzcgMTcuODQ0IDIzLjAzNyAxNi44NDQgQyAyMy4zMzcgMTQuNzQ0IDI1LjEzNyAxMy4yNDQgMjcuMjM3IDEzLjI0NCBDIDI4LjMzNyAxMy4yNDQgMjkuMTM3IDEzLjY0NCAyOS43MzcgMTQuMjQ0IEMgMzAuMjM3IDE0Ljk0NCAzMC40MzcgMTUuODQ0IDMwLjMzNyAxNi44NDQgWiI+PC9wYXRoPjxwYXRoIGZpbGw9IiMwMDMwODciIGQ9Ik0gNTUuMzM3IDkuNjQ0IEwgNTEuNjM3IDkuNjQ0IEMgNTEuMjM3IDkuNjQ0IDUwLjkzNyA5Ljg0NCA1MC43MzcgMTAuMTQ0IEwgNDUuNTM3IDE3Ljc0NCBMIDQzLjMzNyAxMC40NDQgQyA0My4yMzcgOS45NDQgNDIuNzM3IDkuNjQ0IDQyLjMzNyA5LjY0NCBMIDM4LjYzNyA5LjY0NCBDIDM4LjIzNyA5LjY0NCAzNy44MzcgMTAuMDQ0IDM4LjAzNyAxMC41NDQgTCA0Mi4xMzcgMjIuNjQ0IEwgMzguMjM3IDI4LjA0NCBDIDM3LjkzNyAyOC40NDQgMzguMjM3IDI5LjA0NCAzOC43MzcgMjkuMDQ0IEwgNDIuNDM3IDI5LjA0NCBDIDQyLjgzNyAyOS4wNDQgNDMuMTM3IDI4Ljg0NCA0My4zMzcgMjguNTQ0IEwgNTUuODM3IDEwLjU0NCBDIDU2LjEzNyAxMC4yNDQgNTUuODM3IDkuNjQ0IDU1LjMzNyA5LjY0NCBaIj48L3BhdGg+PHBhdGggZmlsbD0iIzAwOWNkZSIgZD0iTSA2Ny43MzcgMi40NDQgTCA1OS45MzcgMi40NDQgQyA1OS40MzcgMi40NDQgNTguOTM3IDIuODQ0IDU4LjgzNyAzLjM0NCBMIDU1LjczNyAyMy4yNDQgQyA1NS42MzcgMjMuNjQ0IDU1LjkzNyAyMy45NDQgNTYuMzM3IDIzLjk0NCBMIDYwLjMzNyAyMy45NDQgQyA2MC43MzcgMjMuOTQ0IDYxLjAzNyAyMy42NDQgNjEuMDM3IDIzLjM0NCBMIDYxLjkzNyAxNy42NDQgQyA2Mi4wMzcgMTcuMTQ0IDYyLjQzNyAxNi43NDQgNjMuMDM3IDE2Ljc0NCBMIDY1LjUzNyAxNi43NDQgQyA3MC42MzcgMTYuNzQ0IDczLjYzNyAxNC4yNDQgNzQuNDM3IDkuMzQ0IEMgNzQuNzM3IDcuMjQ0IDc0LjQzNyA1LjU0NCA3My40MzcgNC4zNDQgQyA3Mi4yMzcgMy4xNDQgNzAuMzM3IDIuNDQ0IDY3LjczNyAyLjQ0NCBaIE0gNjguNjM3IDkuNzQ0IEMgNjguMjM3IDEyLjU0NCA2Ni4wMzcgMTIuNTQ0IDY0LjAzNyAxMi41NDQgTCA2Mi44MzcgMTIuNTQ0IEwgNjMuNjM3IDcuMzQ0IEMgNjMuNjM3IDcuMDQ0IDYzLjkzNyA2Ljg0NCA2NC4yMzcgNi44NDQgTCA2NC43MzcgNi44NDQgQyA2Ni4xMzcgNi44NDQgNjcuNDM3IDYuODQ0IDY4LjEzNyA3LjY0NCBDIDY4LjYzNyA4LjA0NCA2OC43MzcgOC43NDQgNjguNjM3IDkuNzQ0IFoiPjwvcGF0aD48cGF0aCBmaWxsPSIjMDA5Y2RlIiBkPSJNIDkwLjkzNyA5LjY0NCBMIDg3LjIzNyA5LjY0NCBDIDg2LjkzNyA5LjY0NCA4Ni42MzcgOS44NDQgODYuNjM3IDEwLjE0NCBMIDg2LjQzNyAxMS4xNDQgTCA4Ni4xMzcgMTAuNzQ0IEMgODUuMzM3IDkuNTQ0IDgzLjUzNyA5LjE0NCA4MS43MzcgOS4xNDQgQyA3Ny42MzcgOS4xNDQgNzQuMTM3IDEyLjI0NCA3My40MzcgMTYuNjQ0IEMgNzMuMDM3IDE4Ljg0NCA3My41MzcgMjAuOTQ0IDc0LjgzNyAyMi4zNDQgQyA3NS45MzcgMjMuNjQ0IDc3LjYzNyAyNC4yNDQgNzkuNTM3IDI0LjI0NCBDIDgyLjgzNyAyNC4yNDQgODQuNzM3IDIyLjE0NCA4NC43MzcgMjIuMTQ0IEwgODQuNTM3IDIzLjE0NCBDIDg0LjQzNyAyMy41NDQgODQuNzM3IDIzLjk0NCA4NS4xMzcgMjMuOTQ0IEwgODguNTM3IDIzLjk0NCBDIDg5LjAzNyAyMy45NDQgODkuNTM3IDIzLjU0NCA4OS42MzcgMjMuMDQ0IEwgOTEuNjM3IDEwLjI0NCBDIDkxLjYzNyAxMC4wNDQgOTEuMzM3IDkuNjQ0IDkwLjkzNyA5LjY0NCBaIE0gODUuNzM3IDE2Ljg0NCBDIDg1LjMzNyAxOC45NDQgODMuNzM3IDIwLjQ0NCA4MS41MzcgMjAuNDQ0IEMgODAuNDM3IDIwLjQ0NCA3OS42MzcgMjAuMTQ0IDc5LjAzNyAxOS40NDQgQyA3OC40MzcgMTguNzQ0IDc4LjIzNyAxNy44NDQgNzguNDM3IDE2Ljg0NCBDIDc4LjczNyAxNC43NDQgODAuNTM3IDEzLjI0NCA4Mi42MzcgMTMuMjQ0IEMgODMuNzM3IDEzLjI0NCA4NC41MzcgMTMuNjQ0IDg1LjEzNyAxNC4yNDQgQyA4NS43MzcgMTQuOTQ0IDg1LjkzNyAxNS44NDQgODUuNzM3IDE2Ljg0NCBaIj48L3BhdGg+PHBhdGggZmlsbD0iIzAwOWNkZSIgZD0iTSA5NS4zMzcgMi45NDQgTCA5Mi4xMzcgMjMuMjQ0IEMgOTIuMDM3IDIzLjY0NCA5Mi4zMzcgMjMuOTQ0IDkyLjczNyAyMy45NDQgTCA5NS45MzcgMjMuOTQ0IEMgOTYuNDM3IDIzLjk0NCA5Ni45MzcgMjMuNTQ0IDk3LjAzNyAyMy4wNDQgTCAxMDAuMjM3IDMuMTQ0IEMgMTAwLjMzNyAyLjc0NCAxMDAuMDM3IDIuNDQ0IDk5LjYzNyAyLjQ0NCBMIDk2LjAzNyAyLjQ0NCBDIDk1LjYzNyAyLjQ0NCA5NS40MzcgMi42NDQgOTUuMzM3IDIuOTQ0IFoiPjwvcGF0aD48L3N2Zz4=">
				        </div>
				        <div title="credit" class="btn paypal-button paypal-button-credit" style="background-size: 100% 100%; background-image: url(data:image/webp;base64,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)"></div>
					</div>
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
					<div class="product-tab-container" data-name="review"> review list</div>
				</div>
			</div>
			<div class="product-footer"></div>
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script src="${APP_PATH}/static/common/swiper/swiper.min.js"></script>
	<script src="${APP_PATH}/static/pc/js/jqzoom/jquery.jqzoom.js"></script>
	<script src="${APP_PATH}/static/pc/js/video/video.min.js"></script>
	<script src="${APP_PATH}/static/pc/js/jqfly/jquery.fly.min.js"></script>
	<script>
		var mediaData = {}, productData = {}, mainUrl;
		getProductDetails(function(data) {
			mainUrl = data.productMainimgurl;
			// media
			if (data.productVideoUrl && data.productVideoImgUrl) {
				mediaData.video = {
					videoUrl: data.productVideoUrl,
					posterUrl: data.productVideoImgUrl,
					isVideo: true
				};
			}
			getProductImgs(function(data) {
				mediaData.imgs = data;
				renderProductMedia(mediaData);
			});
			// details
			renderProductDetails(data);
			// option
			getProductOption(function(data) {
				renderProductOptions(data);
			});
			// skus
			getProductSkus(function(data) {
				data.length && buildResult(data);				
			});
		});
		// fly bubble
		function generateFlyBubble(event, callback) {
			$('<img class="ml-flyer" src="'+ mainUrl +'" />').fly({
			    start:{
			    	left: event.pageX - window.pageXOffset,
					top: event.pageY - window.pageYOffset
			    },
			    end:{
			        left: window.innerWidth - 30,
			        top: 150,
			        width: 0,
			        height: 0,
			    },
			    onEnd: function() {
			    	this.destroy();
			    	callback();
			    }
			});
		}
		// update product details attr-data
        function updateProductData() {
        	var productQty = mapSet[selectedKeys.join(',')];
            var productSku = mapItems[selectedKeys.join(',')] || {};
           	$('.product-qty .product-num').data('count', productQty.count).data('productsku', productSku);
           	var productSkuMoney = productSku.productskuMoney
           	productSkuMoney ? updateProductPrice(productSkuMoney) : updateProductPrice();
        }
		// update product price
        function updateProductPrice(price) {
        	var data = $('.product-details').data('product');
			function getSkuPrice() {
				return price ? (parseFloat(price) ? parseFloat(price) : 0) : 0
			}
       		$('.product-define-price').text('$'+ (data.productPrice + getSkuPrice()).toFixed(2));
       		$('.product-now-price').text('$'+ (data.productDiscount * (data.productPrice +getSkuPrice()) / 100).toFixed(2));
        }
		// event
		$(window).on('resize', imageZoomEvent);
		// image zoom resize
		function imageZoomEvent() {
			if (window.innerWidth < 1024) {
				$('.product-slide.product-zoom').find('.img').off('mouseover');
			} else {
				$('.product-slide.product-zoom').find('.img').imagezoom();
			}
		}
		// product share
		$('.share-item').on('click', function() {
			window.open($(this).data('url') + encodeURIComponent('https://megalook.com/B-3-Bundles-with-4x4-Closure-Deep-Wave.html'));
		});
		// add to cart
		$('#add-to-cart').on('click', function(evt) {
			function getProductData () {
				var productData = {};
				var productDetails = $('.product-details').data('product') || {};
				var productSKu = $('.product-qty .product-num').data('productsku') || {};

				productData["cartitemProductId"] = productDetails.proudctId;
				productData["cartitemProductName"] = productDetails.productName;
				productData["cartitemProductOriginalprice"] = productDetails.productPrice;
				productData["cartitemProductMainimgurl"] = productDetails.productMainImgUrl;
				productData["cartitemProductActoff"] = productDetails.productDiscount;

				productData["cartitemProductskuIdstr"] = optionIdArr.join(',');
				productData["cartitemProductskuIdnamestr"] = Object.keys(optionObj).join(',');

				productData["cartitemProductskuId"] = productSKu.productskuId;
				productData["cartitemProductskuName"] = productSKu.productskuName;
				productData["cartitemProductskuCode"] = productSKu.productskuCode;
				productData["cartitemProductskuMoneystr"] = productSKu.productskuMoney;
				productData["cartitemProductNumber"] =  parseInt($('.product-qty .product-num').val());
				
				return productData;
			}
			function addToCart(reqData, callback) {
				$.ajax({
					url: '${APP_PATH}/MlbackCart/toAddToCart',
					data: JSON.stringify(reqData),
					type: "post",
					dataType: 'json',
					contentType: 'application/json',
					success: function (data) {
						if (data.code == 100) {
							callback();
						} else {
							var modal = createModal({
			        			body: {
			        				html: '<p>Failed to add products to cart !</p>'
			        			},
				    			autoClose: true
			        		});
						}
					},
					error: function (err) {
						var modal = createModal({
			    			body: {
			    				html: '<p>Error: '+ err + '</p>'
			    			},
			    			autoClose: true
			    		});
					}
				});
			}
			var timeEnd = Date.now();
			if (timeEnd - timeStart < 300) clearTimeout(timer);
			timeStart = timeEnd;
			timer = setTimeout(function() {
				if (isCorrectProduct()) {
					addToCart(getProductData(), function() {
						if (window.innerWidth > 1023) {
							generateFlyBubble(evt, updateProructNumberInCart);							
						} else {
							updateProructNumberInCart();
						}
					});
				}
			}, 300);
		});
		// buy now
		$('#buy-now').on('click', function() {
			if (isCorrectProduct()) {
				window.location.href = '${APP_PATH}/MlbackCart/toCheakOut';
			}
		});
		// add product
		$('#product-num-add').on('click', function() {
			productAdd($(this), false);
		});
		// sub product
		$('#product-num-sub').on('click', function() {
			productSub($(this), false);
		});
		// product-body product-tab
		$('.product-tab-item').on('click', function() {
			var $this = $(this);
			if (!$this.hasClass('active')) $('.product-tab-container[data-name="'+ $this.data('name') +'"]').addClass('active').siblings().removeClass('active');
		});
		
		function renderProductMedia(data) {
			var htmlStr = '';
			var htmlVideoThumb = '';
			var htmlVideo = '';
			data.imgs && data.imgs.forEach(function(item, idx) {
				htmlStr += '<div class="swiper-slide">' +
					'<img class="img" src="' + item.productimgUrl + '" rel="' + item.productimgUrl + '">' +
				'</div>';
			});
			if (data.video) {
				htmlVideoThumb = '<div class="swiper-slide">' +
					'<img class="img" src="' + data.video.posterUrl + '">' +
				'</div>';
				
				htmlVideo = '<div class="swiper-slide">' +
					'<video id="ml-video" class="video-js" controls preload="auto" width="500" height="500" poster="' + data.video.posterUrl + '">' +
				    	'<source src="'+ data.video.videoUrl +'" type="video/mp4" />' +
				  	'</video>' +
				'</div>';
			}
			$('.product-thumb-slide .swiper-wrapper').html(htmlVideoThumb + htmlStr);
			$('.product-slide .swiper-wrapper').html(htmlVideo + htmlStr);
			// media video
			var player = null;
			if ($('#ml-video').length) {
				player = videojs('ml-video', {
	                autoPlay: false,
	                preload: 'auto',
	                controls: true,
	            });
			}
			// video play event
            function listenPlay() {
                player && player.on('play', function(e) {
                    this.bigPlayButton.eventBusEl_.style.display = 'none';
                    player.off('play');
                    listenPause();
                });
            }
			// video pause
            function listenPause() {
            	 player && player.on('pause', function(e) {
                    // console.log('pause');
                    this.bigPlayButton.eventBusEl_.style.display = 'block';
                    player.off('pause');
                    listenPlay();
                });
            }

            listenPause();
 			// media imgs
			var swiperThumb = new Swiper('.product-thumb-slide', {
				direction: 'vertical',
				slidesPerView: 6,
				spaceBetween: 5,
				freeMode: true,
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev',
				},
				on: {
					slideChangeTransitionStart: function() {
						 player && player.pause(); // swiper slide start, stop video play
					},
				},
			});
			var swiperMain = new Swiper('.product-slide', {
				pagination: {
					el: '.swiper-pagination',
					clickable: true
				},
				navigation: {
					nextEl: '.swiper-button-next',
					prevEl: '.swiper-button-prev',
				},
				on: {
					slideChangeTransitionStart: function() {
						 player && player.pause(); // swiper slide start, stop video play
					},
				},
				thumbs: { swiper: swiperThumb },
			});
			imageZoomEvent();
		}
		function renderProductDetails(data) {
			$('.product-details').data('product', {
				'proudctId': data.productId,
				'productName': data.productName,
				'productDiscount': data.productActoffoff,
				'productMainImgUrl': data.productMainimgurl,
				'productPrice': data.productOriginalprice,
			});
			$('.product-name').text(data.productName);
			$('.product-price').html('<div class="name">Total Price: </div><div class="product-define-price">$'+ (data.productOriginalprice).toFixed(2) +'</div><div class="product-now-price">$'+ (data.productActoffoff * data.productOriginalprice / 100).toFixed(2) +'</div>');
			$('.product-tab-container[data-name="desc"]').html(data.productDesc);
		}
		/* product imgs */
		function getProductImgs(callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackProductImg/getMlbackProductImgListByProductId',
				data: JSON.stringify({ "productId": productId }),
				dataType: 'json',
				contentType: 'application/json',
				type: "post",
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mbackProductImgResList);
					}
				}
			});			
		}
		/* details of main */
		function getProductDetails(callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackProduct/getOneMlbackProductDetail',
				data: JSON.stringify({ "productId": productId }),
				dataType: 'json',
				contentType: 'application/json',
				type: "post",
				async: false,
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlbackProductOne);
					}
				}
			});			
		}	
	</script>
</body>
</html>