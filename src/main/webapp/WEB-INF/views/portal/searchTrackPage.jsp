<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Search Track Info</title>
	<jsp:include page="common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="common/header.jsp" flush="true"></jsp:include>
</head>
<body>
    <jsp:include page="layout/header/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="container">
			<div class="search-order-title">Track Order</div>
			<div class="search-order-condition">
				<select class="search-order-type">
					<option value="0">order id</option>
					<option value="1">shipment number</option>
				</select>
				<input type="text" class="search-select-input" id="searchOrderId" placeholder="Please input order-id ..." />
				<input type="text" class="search-select-input hide" id="searchTrackNumber" placeholder="Please input tracking-number ..." />

				<button class="btn btn-pink btn-track-order" id="btn-track-order">Track Order</button>
			</div>

			<div class="search-track-order-result">
				<p class="track-order-tip">Please input tracking-number/order-id to fetch track-order info...</p>
			</div>
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
		function getTrackInfo(callback) {
			payLoading();
			if ($('.search-order-type').val() == '0') {
				var payinfoPlatenum = $('#searchOrderId').val();
				if (!payinfoPlatenum.trim()) {
					mlModalTip('The order-id cannot be empty');
					hidePayLoading();
				} else {
					$.ajax({
						url: "${APP_PATH}/MlfrontOrderList/getTrackDetailByPayinfoPlatenum",
						type: "post",
						data: {"payinfoPlatenum": payinfoPlatenum},
						success: function (data) {
							if (data.code == 100) {
								callback && callback(data.extend.trackingRes);
							} else {
								mlModalTip(data.extend.resMsg);
							}
						},
						error: function () {
							refreshPageModal();
						},
						complete: function() {
							hidePayLoading();
						}
					});
				}
			} else {
				var trackingNumber = $('#searchTrackNumber').val();
				if (!trackingNumber.trim()) {
					mlModalTip('The tracking number cannot be empty');
					hidePayLoading();
				} else {
					$.ajax({
						url: "${APP_PATH}/MlfrontOrderList/getTrackDetailByTrackingNumber",
						type: "post",
						data: {"trackingNumber": trackingNumber},
						success: function (data) {
							if (data.code == 100) {
								callback && callback(data.extend.trackingRes);
							} else {
								mlModalTip('The tracking number is invalid !');
							}
						},
						error: function () {
							refreshPageModal();
						},
						complete: function() {
							hidePayLoading();
						}
					});
				}
			}
		}
		function renderTrackInfo(data) {
			function generateTimelineHtml(data) {
				var html = '';
				var len = data.length - 1;
				for(var i = len; i >= 0; i -= 1) {
					var item = data[i];
					html += '<div class="time-line-item'+ (i == len ? ' active' : '') +'">' +
							'<div class="time-line-date">'+ item.checkpointTime +'</div>' +
							'<div class="time-line-tag"><span class="name">tag: </span><span class="value">'+ (item.tag || '') +'</span></div>' +
							'<div class="time-line-location"><span class="name">location: </span><span class="value">'+ (item.location || '') +'</span></div>' +
							'<div class="time-line-msg"><span class="name">msg: </span><span class="value">'+ (item.message || '') +'</span></div>' +
						'</div>';
				}
				return html;
			}
			var trackOrderHtml;
			if (data.checkpoints && $.isArray(data.checkpoints) && data.checkpoints.length) {
				trackOrderHtml= '<div class="track-result-header">' +
						'<div clsass="tracking-name"><span class="name">Tracking Name: </span><span class="value">'+ data.slug +'</span></div>' +
						'<div clsass="tracking-number"><span class="name">Tracking Number: </span><span class="value">'+ data.trackingNumber +'</span></div>' +
						'<div clsass="tracking-adress"><span class="name">Tracking Adress: </span><span class="value">'+ data.originCountryISO3 + ' → ' + data.destinationCountryISO3 +'</span></div>' +
					'</div>' +
					'<div class="track-result-body">' +
						'<div class="time-line">' + generateTimelineHtml(data.checkpoints) + '</div>' +
					'</div>';
				$('.search-track-order-result').html(trackOrderHtml);
			} else {
				mlModalTip('The product you purchased has been sent out and is waiting for the courier. If you have other questions, please consult customer service.');
				return;
			}
		}
		$('.search-order-type').on('change', function() {
			$('.search-select-input').addClass('hide');
			if ($(this).val() == '1') {
				$('#searchTrackNumber').removeClass('hide');
			} else {
				$('#searchOrderId').removeClass('hide');
			}
		});
		$('#btn-track-order').on('click', function() {
			getTrackInfo(renderTrackInfo);
		});
	</script>
	<!-- footer script -->
	<jsp:include page="layout/footer/footer-script.min.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>