<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Best Wholesale Hair</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>
		@media only screen and (max-width: 1023px) { main { margin: -1rem 0 0 0; } }
		@media only screen and (max-width: 1078px) and (min-width: 576px) { main { margin: -1rem 0 0 0; } }
	</style>
	
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="ins-banner">
			<div class="wap lazyload" data-src="${APP_PATH }/static/pc/img/wholesale/a_02.jpg"></div>
			<div class="pc lazyload" data-src="${APP_PATH }/static/pc/img/wholesale/a_01.jpg"></div>
		</div>
		<div class="container">
			<!-- Wholesale-body -->
		   <div class="Wholesale-body clearfix">
			   <div class="title_tips"><h3>Min amount $500 qualifies for special wholesale rate!</h3></div>
		   </div>
		   <div class="Wholesale_cont clearfix">
		   	  <div class="wholesale-form">
				  <h2>Send Inquiry To Become A UNice Vendor  </h2>
				  <div class="form-group">
				  	<label for="addressUsername" class="form-label">Your name</label>
				  	<div class="form-input">
				  		<input type="text" name="addressUsername" id="addressUsername" class="form-control">
				  	</div>
				  </div>
				<div class="info_box">
					<div class="form-group">
						<label for="addressEmail" class="form-label">Email<i>*</i></label>
						<div class="form-input">
							<input type="text" name="addressEmail" id="addressEmail" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="addressTelephone" class="form-label">Telephone<i>*</i></label>
						<div class="form-input">
							<input type="text" name="addressTelephone" id="addressTelephone" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="addressCountry" class="form-label">Country<i>*</i></label>
						<div class="form-input">
							<input type="text" name="addressCountry" id="addressCountry" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label for="addressUserMessages" class="form-label">Messages<i>*</i></label>
						<div class="form-input">
							<textarea rows="2" cols="" class="form-control"></textarea>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="form-input">
						<input type="button" value="Submit" id="Submit" />
					</div>
				</div>
				
		   	  </div>
			  
			  
			  <div class="wholesale-chat">
				  <h2> 24-Hours Online Service Waiting For You!  </h2>
				  <p class="a-center">
					  <img alt="Wholesale Hair Extensions" src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/wholesale-contact.jpg" width="20%">
				  </p>
				  <ul>
					  <li class="live">
						  <span></span><a href="javascript:void($zopim.livechat.window.show())">Live chat----</a>
					  </li>
					  <li class="whatsapp">
						  <span></span>
						  <a class="" href="" title=""> +8617639072910 </a><br />
						  <a class="" href="" title=""> +8617639072910 </a><br />
						  <a class="" href="" title=""> +8617639072910 </a> 
					  </li>
					  <li class="email">
						  <span></span>
						  <a style="color: #f92d96;" href="mailto:support@unice.com">support@unice.com</a>
					  </li>
					  <li class="tel">
						  <span></span>
						  (626) 782-4321
					  </li>
				  </ul>
			  </div>
		   </div>
		   <div class="wholesale-container">
		           <h3>
		               <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/hot-sale.jpg" alt="Hot sale wholesale products">
		           </h3>
		           <div class="clearfix wholesale-type">
		               <a class="wholesale-type_link" href="https://www.unice.com/human-hair.html">
		                   <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/type1.jpg" alt="Hair Weave Bundles">
		               </a>
		               <a class="wholesale-type_link" href="https://www.unice.com/human-hair.html">
		                   <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/type2.jpg" alt="4*4 Lace Closure">
		               </a>
		               <a class="wholesale-type_link" href="https://www.unice.com/human-hair.html">
		                   <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/type3.jpg" alt="Lace Frontal Hair Closure">
		               </a>
		               <a class="wholesale-type_link" href="https://www.unice.com/human-hair.html">
		                   <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/type4.jpg" alt="360 Lace Frontal">
		               </a>
		           </div>
		           <h3>
		               <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/wholesale_reward.jpg" alt="Wholesale Reward">
		           </h3>
		           <p><img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/wholesale_reward-con.jpg" alt="Wholesale Reward Rules"></p>
		           <h3>
		               <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/why_choose_us.jpg" alt="Why choose us">
		           </h3>
		           <p><img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/why_choose_us-con.jpg" alt="UNice Hair Customer Show"></p>
		           <h3>
		               <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/large_wholesale_customers.jpg" alt="Large Wholesale Customers">
		           </h3>
		           <div class="wholesale-large clearfix">
		               <p class="wholesale-large_left">
		                   UNice Hair, as one of the leading manufacturers and brand from China, we focus on providing reliable and natural 100% virgin human hair. &nbsp;We source the globe, to provide
		                   different region of hair such as Brazilian, Malaysian, Peruvian &amp; Indian hair to distributor business owners &amp; wholesale vendors all around the world. &nbsp;Our
		                   capacity &amp; capability allow for us to not only handle volume of production &amp; order but also maintain the highest quality of virgin human hair. &nbsp;Therefore, we’re
		                   able to pass on the amazing competitive rate for our clientele to grow with us. &nbsp;<br><br>
		                   Since the launch of our company, over the many years, we have carefully and maintained strong &amp; enduring relationship with each of our business partners, vendors and loyal
		                   fans. <br><br>
		                   Fans around the world shared their love of UNice hair through YouTube, Facebook, Instagram and many other social media platforms. &nbsp;We are so grateful for our fans!
		                   &nbsp;<br><br>
		                   To service our customer base to the highest quality possible, we setup our CA warehouse to enable us to provide domestic shipping on a timely fashion for all our USA UNIce
		                   customers. &nbsp;UNice, A Natural extension of U!<br><br>
		                   <span><strong>● 20 Years of Hair R &amp; D, Manufacturing Experience &amp; Capability</strong></span>
		                   <span><strong>● Direct from Manufacturer; Guaranteed Competitive Low Rate</strong></span>
		                   <span><strong>● Unmatched &amp; Strict Quality Assurance </strong></span>
		                   <span><strong>● Complete Customization Options for Wholesalers</strong></span>
		                   <span><strong>● 24-Hours Online Customer Service Support</strong></span>
		                   <span><strong>● Express &amp; Expedited Shipping Available</strong></span>
		                   <span><strong>● California Based Warehouse for Timely Domestic Shipping</strong></span>
		               </p>
		               <p class="wholesale-large_right float-r"><img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/wholesale_customers_show_r.jpg" alt="UNice Wholesale Customers Show"></p>
		           </div>
		           <h3>
		               <img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/the_factory_preparation.jpg" alt="The Factory Preparation">
		           </h3>
		           <p><img src="https://www.unice.com/skin/frontend/longqi/pc/images/cmspage/wholesale/production_process.jpg" alt="UNice Hair Production Process"></p>
		       </div>
		   
				
		</div>
	<!-- main end -->
	<!-- common script -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
      // check user input info
      function checkInputAdressInfo() {
      	var flag = true;
      	for(var idx = 0, len = $('.info_box .form-group').length; idx < len; idx += 1) {
      		var item = $('.info_box .form-group')[idx];
      		if ($(item).find('.form-control').data('status')) continue;
      		if (!$(item).find('.form-control').val() || $(item).find('.form-control').val() == 'state') {
      			mlModalTip('Address information <i style="color: #f00">'+ $(item).find('.form-label').text() +"</i> can't be empty !");
      			$(item).find('.form-control').focus();
      			flag = false;
      			break;
      		}
      	}
      	return flag;
      }
	  // save user info
	  // function orderSaveAddress(reqData, callback) {
	  // 	$.ajax({
	  // 		url: '${APP_PATH}/MlfrontAddress/save',
	  // 		type: 'post',
	  // 		// dataType: 'json',
	  // 		data: JSON.stringify(reqData),
	  // 		contentType: 'application/json',
	  // 		success: function (data) {
				
			// 		console.log(data)
					
	  // 			// if (data.code == 100) {
	  // 			// 	callback && callback(data.extend.mlfrontAddress);
	  // 			// 	console.log(data)
	  				
	  // 			// } else {
	  // 			// 	sysModalTip();
	  // 			// }
	  // 		},
	  // 		error: function () {
	  // 			sysModalTip();
	  // 		}
	  // 	});
	  // }
	  
	  $(document.body).on('click', '#Submit', function() {
	  	if (checkInputAdressInfo()) {
	  		orderSaveAddress();
			
			
			
	  	}
	  });
	  


		new LazyLoad($('main').find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});

	</script>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<!-- <script> addTidio(); </script> -->
</body>
</html>