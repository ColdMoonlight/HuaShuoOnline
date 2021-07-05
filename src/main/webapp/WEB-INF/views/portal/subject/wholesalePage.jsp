<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Best Wholesale Hair | megalook.com</title>
	<meta name="keywords" content="Lace Front Wigs, Human Hair Extensions,Brazilian Virgin Hair,Affordable Human Hair" />
	<meta name="description" content="Megalook Hair Official Website Sells Best Virgin Hair, Full Lace Wig, Transparent Lace Wig, 360 Lace Wig, Frontal Lace Wig, Closure Lace Wig, Bundles with Closure, Bundles with Frontal, Free Wig Making Service. Hottest Products, Free Gifts, Free & Fast Shipping. No Shedding, No Tangles, Save Big! Lowest Price For U.">
    <!-- google rule -->
	<meta name="robots" content="INDEX,FOLLOW">
    <link rel="alternate" href="https://megalook.com/Customer/Wholesale.html" hreflang="en-us" />
	<link rel="canonical" href="https://megalook.com/Customer/Wholesale.html" />
	<!-- socail meta -->
	<meta name="twitter:site" content="@megalookhair">
	<meta name="twitter:card" content="summary">
	<meta name="twitter:title" content="Megalook Hair, Virgin Remy Human Hair Wigs, Lace Front Wigs, Best Wigs | megalook.com">
	<meta name="twitter:description" content="Megalook Hair Official Website Sells Best Virgin Hair, Full Lace Wig, Transparent Lace Wig, 360 Lace Wig, Frontal Lace Wig, Closure Lace Wig, Bundles with Closure, Bundles with Frontal, Free Wig Making Service. Hottest Products, Free Gifts, Free & Fast Shipping. No Shedding, No Tangles, Save Big! Lowest Price For U.">
	<meta property="og:type" content="website">
	<meta property="og:title" content="Megalook Hair, Virgin Remy Human Hair Wigs, Lace Front Wigs, Best Wigs | megalook.com">
	<meta property="og:url" content="https://megalook.com/Customer/Wholesale.html">
	<meta property="og:site_name" content="Megalook Hair">
	<meta property="og:image" content="https://www.megalook.com/static/apple/micon1.png" />
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin: 0; } }
		@media only screen and (max-width: 1078px) and (min-width: 576px) { main { margin: 0; } }
		@media only screen and (min-width: 576px){
			.ins-banner .pc { padding-top: 38.333333%; }
		}
		/* wholesale */
		.wholesale-form {margin: 0 auto;}
		.wholesale-form .form-group .form-label{padding-right: 10px; vertical-align: top; text-align: right;}
		.wholesale-form .form-group .form-label i {margin-right: .25rem;}
		.wholesale-form .form-radio {display: inline-block; margin-right: 1rem; margin-bottom: .5rem;}
		.wholesale-form .form-radio input {margin-right: .25rem; width: 1rem; height: 1rem;}
		.wholesale-form .form-group textarea {width: 100%; height: 100px; border-color: #a9a9a9;}
		.wholesale-form .form-group i{color:#ff6f5e;}
		.wholesale-form .form-group #Submit{background: #f82d98; border:none; color: #fff; line-height: 30px;}
		.wholesale-info { margin: 0; font-size: 12px; color: #ff0000; font-style: italic; }
		
		@media only screen and (min-width: 567px) {
			.wholesale-form{width: 80%; max-width: 800px;}
			.wholesale-form .form-group {display: flex; margin: 20px 0 0;}
			.wholesale-form .form-group .form-input{display: inline-block;}
			.wholesale-form .form-group .form-label{width: 20%; font-size: 20px;}
			.wholesale-form .form-group .form-input{width: 80%;}
			.wholesale-form .form-group input{padding: .75rem; border: 2px solid #ccc;}
		}
		@media only screen and (max-width: 568px) {
			.wholesale-form{width: 90%;}
			.wholesale-form .form-group+.form-group {margin-top: 16px;}
			.wholesale-form .form-group .form-control{margin-top: .5rem;}
			.wholesale-form .form-group .form-label{width: 35%; font-weight: 600; font-size: 16px;}
			.wholesale-form .form-group input{padding: .5rem; border: 1px solid #ccc;}
		}
	</style>
</head>
<body>
    <jsp:include page="../layout/header/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="ins-banner">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/wh/wap.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/wh/pc.jpg"></div>
		</div>		

		<div class="wholesale-form">
			<div class="info_box">
				<div class="form-group required">
					<label for="wholesaleCustomerName" class="form-label"><i>*</i>Your name :</label>
					<div class="form-input">
						<input type="text" name="wholesaleCustomerName" id="wholesaleCustomerName" class="form-control">
					</div>
				</div>
				<div class="form-group required">
					<label for="wholesaleCustomerEmail" class="form-label"><i>*</i>Email Address :</label>
					<div class="form-input">
						<input type="text" name="wholesaleCustomerEmail" id="wholesaleCustomerEmail" class="form-control">
					</div>
				</div>
				<div class="form-group required">
					<label for="wholesaleCustomerTelephone" class="form-label"><i>*</i>Telephone :</label>
					<div class="form-input">
						<input type="text" name="wholesaleCustomerTelephone" id="wholesaleCustomerTelephone" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label for="wholesaleCustomerWatsapp" class="form-label">Watsapp :</label>
					<div class="form-input">
						<input type="text" name="wholesaleCustomerWatsapp" id="wholesaleCustomerWatsapp" class="form-control">
					</div>
				</div>
				<div class="form-group required">
					<label for="wholesaleCustomerCountry" class="form-label"><i>*</i>Country :</label>
					<div class="form-input">
						<input type="text" name="wholesaleCustomerCountry" id="wholesaleCustomerCountry" class="form-control">
					</div>
				</div>
				<div class="form-group required">
					<label for="wholesaleCustomerTypeName" class="form-label"><i>*</i>Business Type :</label>
					<input name="wholesaleCustomerTypeName" class="form-control" id="wholesaleCustomerTypeName" hidden>
					<div class="form-input">
						<span class="form-radio">
		                  <input type="radio" name="customerTypeName" value="Wholesale & Distributer" id="wholesaleCustomerTypeName-1" class="form-control">
		                  <label for="wholesaleCustomerTypeName-1">Wholesale & Distributer</label>
		                </span>
		                <span class="form-radio">
		                  <input type="radio" name="customerTypeName" value="Store Owner" id="wholesaleCustomerTypeName-2" class="form-control">
		                  <label for="wholesaleCustomerTypeName-2">Store Owner</label>
		                </span>
		                <span class="form-radio">
		                  <input type="radio" name="customerTypeName" value="Personal Use" id="wholesaleCustomerTypeName-3"  class="form-control">
		                  <label for="wholesaleCustomerTypeName-3">Personal Use</label>
		                </span>
		                <span class="form-radio">
		                  <input type="radio" name="customerTypeName"  value="Stylist" id="wholesaleCustomerTypeName-4" class="form-control">
		                  <label for="wholesaleCustomerTypeName-4">Stylist</label>
		                </span>
		                <span class="form-radio">
		                  <input type="radio" name="customerTypeName"  value="Start Business" id="wholesaleCustomerTypeName-5"  class="form-control">
		                  <label for="wholesaleCustomerTypeName-5">Start Business</label>
		                </span>
		                <span class="form-radio">
		                  <input type="radio" name="customerTypeName"  value="Salon Owner" id="wholesaleCustomerTypeName-6"  class="form-control">
		                  <label for="wholesaleCustomerTypeName-6">Salon Owner</label>
		                </span>
					</div>
				</div>
				<div class="form-group required">
					<label for="wholesaleCustomerMessage" class="form-label"><i>*</i>Comment :</label>
					<div class="form-input">
						<textarea rows="2" cols="" class="form-control" id="wholesaleCustomerMessage" placeholder="Write your detailed requiry,hair types,hair quantity,hair length,hair color..."></textarea>
						<span><span>Tips: We will contact you with 24 hours after we receive your request</span>
					</div>
				</div>
				
				<p class="wholesale-info hide"></p>
			</div>
			<div class="form-group">
				<label class="form-label"></label>
				<div class="form-input">
					<input type="button" value="Submit" id="Submit" />
				</div>
			</div>
	   	  </div>
	<!-- main end -->
	<!-- footer nav -->
	<jsp:include page="../layout/footer/footer.jsp" flush="true"></jsp:include>

	<!-- common script -->
	<script src="${APP_PATH}/static/common/jquery.min.js"></script>
	<script>function getCarouselData(area,async,callback){$.ajax({url:"${APP_PATH}/MlbackSlides/getMlbackSlidListByArea",data:JSON.stringify({slideArea:area}),dataType:"json",contentType:"application/json",type:"post",async:async,success:function(data){100==data.code&&callback&&callback(data.extend.mlbackSlideList)}})}function debounce(callback,delay){var timeEnd;delay=delay||100,Date.now()-timeStart>delay&&clearTimeout(timer),timer=setTimeout((function(){callback&&callback()}),delay)}</script>
	<!-- lazy -->
	<script>!function(t,e){"object"==typeof exports?module.exports=e(t):"function"==typeof define&&define.amd?define([],e):t.LazyLoad=e(t)}("undefined"!=typeof global?global:this.window||this.global,function(t){"use strict";function e(t,e){this.settings=o(r,e||{}),this.images=t||document.querySelectorAll(this.settings.selector),this.observer=null,this.init()}"function"==typeof define&&define.amd&&(t=window);const r={src:"data-src",srcset:"data-srcset",selector:".lazyload",root:null,rootMargin:"0px",threshold:0},o=function(){let t={},e=!1,r=0,s=arguments.length;for("[object Boolean]"===Object.prototype.toString.call(arguments[0])&&(e=arguments[0],r++);r<s;r++)!function(r){for(let s in r)Object.prototype.hasOwnProperty.call(r,s)&&(e&&"[object Object]"===Object.prototype.toString.call(r[s])?t[s]=o(!0,t[s],r[s]):t[s]=r[s])}(arguments[r]);return t};if(e.prototype={init:function(){if(!t.IntersectionObserver)return void this.loadImages();let e=this,r={root:this.settings.root,rootMargin:this.settings.rootMargin,threshold:[this.settings.threshold]};this.observer=new IntersectionObserver(function(t){Array.prototype.forEach.call(t,function(t){if(t.isIntersecting){e.observer.unobserve(t.target);let r=t.target.getAttribute(e.settings.src),o=t.target.getAttribute(e.settings.srcset),s=new Image;s.src=r,s.onload=function(e){var s=e.target.width,i=e.target.height;"img"===t.target.tagName.toLowerCase()?(r&&(t.target.src=r),o&&(t.target.srcset=o)):t.target.style.backgroundImage="url("+r+")",t.target.width=s,t.target.height=i,t.target.classList.add("loaded")},s.onerror=function(){}}})},r),Array.prototype.forEach.call(this.images,function(t){e.observer.observe(t)})},loadAndDestroy:function(){this.settings&&(this.loadImages(),this.destroy())},loadImages:function(){if(!this.settings)return;let t=this;Array.prototype.forEach.call(this.images,function(e){let r=e.getAttribute(t.settings.src),o=e.getAttribute(t.settings.srcset);"img"===e.tagName.toLowerCase()?(r&&(e.src=r),o&&(e.srcset=o)):e.style.backgroundImage="url('"+r+"')"})},destroy:function(){this.settings&&(this.observer.disconnect(),this.settings=null)}},t.lazyload=function(t,r){return new e(t,r)},t.jQuery){const r=t.jQuery;r.fn.lazyload=function(t){return(t=t||{}).attribute=t.attribute||"data-src",new e(r.makeArray(this),t),this}}return e});</script>
	<!-- common footer script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<!-- header script  -->
	<jsp:include page="../layout/header/header-script.min.jsp" flush="true"></jsp:include>
	<script>
		// //check user input info
		function checkInputAdressInfo() {
			var flag = true;
			for(var idx = 0, len = $('.info_box .form-group.required').length; idx < len; idx += 1) {
				var item = $('.info_box .form-group.required')[idx];
		
				if (!$(item).find('.form-control').val().trim()) {
					mlModalTip('Address information <i style="color: #f00">'+ $(item).find('.form-label').text() +"</i> can't be empty !");
					$(item).find('.form-control').focus();
					flag = false;
					break;
				}
			}
			return flag;
		}
		function getFormData() {
			var data = {};
			data.wholesaleCustomerName = $('#wholesaleCustomerName').val();
			data.wholesaleCustomerEmail = $('#wholesaleCustomerEmail').val();
			data.wholesaleCustomerCountry = $('#wholesaleCustomerCountry').val();
			data.wholesaleCustomerTelephone = $('#wholesaleCustomerTelephone').val();
			data.wholesaleCustomerWatsapp = $('#wholesaleCustomerWatsapp').val();
			data.wholesaleCustomerMessage = $('#wholesaleCustomerMessage').val();
			data.wholesaleCustomerTypeName = $('#wholesaleCustomerTypeName').val();
			return data;
		}
		// save user info
		function orderSaveAddress(reqData, callback) {
			$.ajax({
				url: '${APP_PATH}/CustomerWholesale/save',
				type: 'post',
				dataType: 'json',
				data: JSON.stringify(reqData),
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend);
						var wholsaleModal = createModal({
							body: {
								html: "<p style='color:red'>Thanks again for your inquiry,our staff will contact you soon!</p>",
							}
						}, function() {
							window.location.reload();
						});
					} else {
						sysModalTip();
					}  
				},
				error: function () {
					sysModalTip();
				}
			});
		}
		var wholesaleCustomerTypeName;
		new LazyLoad($('main').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
		$('input[name="customerTypeName"]').on('change', function() {
			$('#wholesaleCustomerTypeName').val($(this).val());
		});
		$(document.body).on('click', '#Submit', function() {
			if (checkInputAdressInfo()) {
				var reqData = getFormData();
				if ((reqData.wholesaleCustomerMessage).length > 2000) {
					$('.wholesale-info').removeClass('hide').text('The maximum message length is 2000 characters...');
					return false;
				}
				orderSaveAddress(reqData);
			}
		});
		$(document.body).on('focus', '#wholesaleCustomerMessage', function() {
			if (!$('#wholesaleCustomerMessage').hasClass('hide')) {
			 	$('.wholesale-info').addClass('hide').text('');
			}
		});
	</script>
	<!-- footer script -->
	<jsp:include page="../layout/footer/footer-script.min.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>