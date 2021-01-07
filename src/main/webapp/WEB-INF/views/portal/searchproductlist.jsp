<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Product List</title>
	<jsp:include page="common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
	<script> var productName = '${sessionScope.productName}'; </script>
	<style>main { margin-top: 1rem; }</style>
</head>
<body>
    <jsp:include page="layout/header/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="container">
			<div class="search-product-banner"></div>
			<div class="product-list"><div id="init-loading"></div></div>		
		</div>
	<!-- main end -->
	<!-- footer nav -->
	<jsp:include page="layout/footer/footer.jsp" flush="true"></jsp:include>

	<!-- common script -->
	<script src="${APP_PATH}/static/common/jquery.min.js"></script>
	<script>function getCarouselData(area,async,callback){$.ajax({url:"${APP_PATH}/MlbackSlides/getMlbackSlidListByArea",data:JSON.stringify({slideArea:area}),dataType:"json",contentType:"application/json",type:"post",async:async,success:function(data){100==data.code&&callback&&callback(data.extend.mlbackSlideList)}})}function debounce(callback,delay){var timeEnd;delay=delay||100,Date.now()-timeStart>delay&&clearTimeout(timer),timer=setTimeout((function(){callback&&callback()}),delay)}</script>
	<!-- lazy -->
	<script>!function(t,e){"object"==typeof exports?module.exports=e(t):"function"==typeof define&&define.amd?define([],e):t.LazyLoad=e(t)}("undefined"!=typeof global?global:this.window||this.global,function(t){"use strict";function e(t,e){this.settings=o(r,e||{}),this.images=t||document.querySelectorAll(this.settings.selector),this.observer=null,this.init()}"function"==typeof define&&define.amd&&(t=window);const r={src:"data-src",srcset:"data-srcset",selector:".lazyload",root:null,rootMargin:"0px",threshold:0},o=function(){let t={},e=!1,r=0,s=arguments.length;for("[object Boolean]"===Object.prototype.toString.call(arguments[0])&&(e=arguments[0],r++);r<s;r++)!function(r){for(let s in r)Object.prototype.hasOwnProperty.call(r,s)&&(e&&"[object Object]"===Object.prototype.toString.call(r[s])?t[s]=o(!0,t[s],r[s]):t[s]=r[s])}(arguments[r]);return t};if(e.prototype={init:function(){if(!t.IntersectionObserver)return void this.loadImages();let e=this,r={root:this.settings.root,rootMargin:this.settings.rootMargin,threshold:[this.settings.threshold]};this.observer=new IntersectionObserver(function(t){Array.prototype.forEach.call(t,function(t){if(t.isIntersecting){e.observer.unobserve(t.target);let r=t.target.getAttribute(e.settings.src),o=t.target.getAttribute(e.settings.srcset),s=new Image;s.src=r,s.onload=function(e){var s=e.target.width,i=e.target.height;"img"===t.target.tagName.toLowerCase()?(r&&(t.target.src=r),o&&(t.target.srcset=o)):t.target.style.backgroundImage="url("+r+")",t.target.width=s,t.target.height=i,t.target.classList.add("loaded")},s.onerror=function(){}}})},r),Array.prototype.forEach.call(this.images,function(t){e.observer.observe(t)})},loadAndDestroy:function(){this.settings&&(this.loadImages(),this.destroy())},loadImages:function(){if(!this.settings)return;let t=this;Array.prototype.forEach.call(this.images,function(e){let r=e.getAttribute(t.settings.src),o=e.getAttribute(t.settings.srcset);"img"===e.tagName.toLowerCase()?(r&&(e.src=r),o&&(e.srcset=o)):e.style.backgroundImage="url('"+r+"')"})},destroy:function(){this.settings&&(this.observer.disconnect(),this.settings=null)}},t.lazyload=function(t,r){return new e(t,r)},t.jQuery){const r=t.jQuery;r.fn.lazyload=function(t){return(t=t||{}).attribute=t.attribute||"data-src",new e(r.makeArray(this),t),this}}return e});</script>
	<!-- common footer script -->
	<jsp:include page="common/footer.jsp" flush="true"></jsp:include>
	<!-- header script  -->
	<jsp:include page="layout/header/header-script.min.jsp" flush="true"></jsp:include>
	<script>
		function getProductListBySearch(productName, callback) {
			$.ajax({
				url: "${APP_PATH}/MlbackProduct/searchProductLike",
				type: "post",
				data: {"productName": productName},
				async: false,
				success: function (data) {
					if (data.code == 100) {
						callback && callback(descPrdouct(data.extend.mlbackProductResList));
					} else {
						refreshPageModal();
					}
				},
				error: function () {
					refreshPageModal();
				}
			});
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
		getProductListBySearch(productName, renderProductList);
	</script>
	<!-- footer script -->
	<jsp:include page="layout/footer/footer-script.min.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>