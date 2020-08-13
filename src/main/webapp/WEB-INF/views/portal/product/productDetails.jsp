<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Details</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<script>
		var productId = '${sessionScope.productDetailId}';
		var productSeo;
		var productName;
		var seoTitle = '${sessionScope.mlbackProductMetaTitle}';
		var seoDescription = '${sessionScope.mlbackProductMeteDesc}';
		var seoKeywords = '${sessionScope.mlbackProductMetaKeyWords}';
		document.title = seoTitle;
		addMeta('keyword', seoKeywords);
		addMeta('description', seoDescription);
	</script>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<link href="${APP_PATH}/static/common/swiper/swiper.min.css" rel="stylesheet">
	<link href="${APP_PATH}/static/pc/js/jqzoom/jqzoom.css" rel="stylesheet">
	<style>
		main {margin-top: 1rem;}
		@media only screen and (max-width: 575px) {
			main { margin: 0 }
			.product-details, .product-body, .product-footer { margin-left: 1rem; margin-right: 1rem; }
		}
	</style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
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
	<script src="${APP_PATH}/static/pc/js/jqzoom/jquery.jqzoom.js"></script>
	<script src="${APP_PATH}/static/pc/js/jqfly/jquery.fly.min.js"></script>
	<script>function generateFlyBubble(event,callback){$('<img class="ml-flyer" src="'+mainUrl+'" />').fly({start:{left:event.pageX-window.pageXOffset,top:event.pageY-window.pageYOffset},end:{left:window.innerWidth-30,top:150,width:0,height:0},onEnd:function(){this.destroy(),callback()}})}function updateProductData(selectedKeys){var productQty=mapSet[selectedKeys.join(",")],productSku=mapItems[selectedKeys.join(",")]||{};if(Object.keys(mapSet).length&&Object.keys(mapItems).length){$(".product-qty .product-num").data("count",productQty.count).data("productsku",productSku);var productSkuMoney=productSku.productskuMoney;productSkuMoney?updateProductPrice(productSkuMoney):updateProductPrice()}else mlModalTip("I'm sorry that the product cannot be purchased for the time being. If necessary, please contact customer service !")}function updateProductPrice(price){var data=$(".product-details").data("product");function getSkuPrice(){return price&&parseFloat(price)?parseFloat(price):0}$(".product-define-price").text("$"+(data.productPrice+getSkuPrice()).toFixed(2)),$(".product-now-price").text("$"+accuracyCal(data.productPrice+getSkuPrice(),data.productDiscount))}function getProductData(){var productData={},productDetails=$(".product-details").data("product")||{},productSKu=$(".product-qty .product-num").data("productsku");return!(!productSKu||!Object.keys(productSKu).length)&&(productData.cartitemProductId=productDetails.proudctId,productData.cartitemProductSeoName=productDetails.productSeo,productData.cartitemProductName=productDetails.productName,productData.cartitemProductOriginalprice=productDetails.productPrice,productData.cartitemProductMainimgurl=productDetails.productMainImgUrl,productData.cartitemProductActoff=productDetails.productDiscount,productData.cartitemProductskuIdstr=optionIdArr.join(","),productData.cartitemProductskuIdnamestr=Object.keys(optionObj).join(","),productData.cartitemProductskuId=productSKu.productskuId,productData.cartitemProductskuName=productSKu.productskuName,productData.cartitemProductskuCode=productSKu.productskuCode,productData.cartitemProductskuMoneystr=productSKu.productskuMoney,productData.cartitemProductNumber=parseInt($(".product-qty .product-num").val()),productData)}function addToCart(reqData,callback){$.ajax({url:"${APP_PATH}/MlbackCart/toAddToCart",data:JSON.stringify(reqData),type:"post",dataType:"json",contentType:"application/json",success:function(data){100==data.code?callback&&callback():mlModalTip("Failed to add products to cart !</p>")},error:function(err){sysModalTip()}})}function toBuyNow(reqData,callback){$.ajax({url:"${APP_PATH}/MlbackCart/toBuyNow",data:JSON.stringify(reqData),type:"post",dataType:"json",contentType:"application/json",success:function(data){100==data.code?callback():mlModalTip("I'm sorry, temporarily unable to settlement, please try again later !")},error:function(err){sysModalTip()}})}function renderProductMedia(data){function stopVideo(){$("#ml-video")[0].pause()}var htmlStr="",htmlVideoThumb="",htmlVideo="";data.imgs&&data.imgs.forEach((function(item,idx){htmlStr+='<div class="swiper-slide"><div class="lazyload img" data-src="'+item.productimgUrl+'" rel="'+item.productimgUrl+'"></div></div>'})),data.video&&(htmlVideoThumb='<div class="swiper-slide"><div class=" lazyload" data-src="'+data.video.posterUrl+'"></div></div>',htmlVideo='<div class="swiper-slide"><video id="ml-video" controls preload="none" poster="'+data.video.posterUrl+'"><source src="'+data.video.videoUrl+'" type="video/mp4" /></video></div>'),$(".product-thumb-slide .swiper-wrapper").html(htmlVideoThumb+htmlStr),$(".product-slide .swiper-wrapper").html(htmlVideo+htmlStr),new LazyLoad($(".product-media .lazyload"),{root:null,rootMargin:"10px",threshold:0});var swiperThumb=new Swiper(".product-thumb-slide",{direction:"vertical",slidesPerView:6,spaceBetween:5,freeMode:!0,navigation:{nextEl:".swiper-button-next",prevEl:".swiper-button-prev"},on:{slideChangeTransitionStart:function(){stopVideo()}}}),swiperMain=new Swiper(".product-slide",{pagination:{el:".swiper-pagination",clickable:!0},navigation:{nextEl:".swiper-button-next",prevEl:".swiper-button-prev"},on:{slideChangeTransitionStart:function(){stopVideo()}},thumbs:{swiper:swiperThumb}});imageZoomEvent()}function renderProductDetails(data){$(".product-details").data("product",{proudctId:data.productId,productName:data.productName,productDiscount:data.productActoffoff,productMainImgUrl:data.productMainimgurl,productPrice:data.productOriginalprice,productSeo:data.productSeo}),$(".product-name").text(data.productName),$(".product-price").html('<div class="name">Total Price: </div><div class="product-define-price">$'+data.productOriginalprice.toFixed(2)+'</div><div class="product-now-price">$'+accuracyCal(data.productOriginalprice,data.productActoffoff)+"</div>"),$('.product-tab-container[data-name="desc"]').html(data.productDesc)}function getProductImgs(callback){$.ajax({url:"${APP_PATH}/MlbackProductImg/getMlbackProductImgListByProductId",data:JSON.stringify({productId:productId}),dataType:"json",contentType:"application/json",type:"post",success:function(data){100==data.code&&callback(data.extend.mbackProductImgResList)}})}function createReviewSwiper(imgs,activeNum){var slideImgs=imgs.reduce((function(acc,img){return acc+='<div class="swiper-slide"><img class="lazyload" src="'+img+'" /></div>'}),"");if(reviewSwiper)$(".review-swiper-box .swiper-wrapper").html(slideImgs),reviewSwiper.updateSlides(),reviewSwiper.slideTo(activeNum,0,!1),$(".review-swiper-box").show(),addFixed();else{var $reviewSwiper=$('<div class="review-swiper-box"><div id="review-swiper" class="swiper-container"><div class="swiper-wrapper">'+slideImgs+'</div><div class="swiper-pagination"></div><div class="swiper-button-next"></div><div class="swiper-button-prev"></div></div><div class="review-swiper-close"><span class="icon close"></span></div><div>');$(document.body).append($reviewSwiper),addFixed(),(reviewSwiper=new Swiper("#review-swiper",{pagination:{el:".swiper-pagination",type:"fraction"},navigation:{nextEl:".swiper-button-next",prevEl:".swiper-button-prev"}})).slideTo(activeNum,0,!1)}}function getProductDetails(callback){$.ajax({url:"${APP_PATH}/MlbackProduct/getOneMlbackProductDetail",data:JSON.stringify({productId:productId}),dataType:"json",contentType:"application/json",type:"post",async:!1,success:function(data){100==data.code&&callback(data.extend.mlbackProductOne)}})}function selectCartOrCheckout(data){var cartCheckoutHtml='<div class="cart-checkout-product"><div class="lazyload" data-src="'+data.cartitemProductMainimgurl+'"></div><div class="cart-checkout-data"><div class="cart-checkout-productname">'+data.cartitemProductName+'</div><div class="cart-checkout-productprice"><div class="name">Price: </div><div class="value">$'+accuracyCal(data.cartitemProductOriginalprice+parseFloat(data.cartitemProductskuMoneystr),data.cartitemProductActoff)+'</div></div><div class="btn-group"><a class="btn" href="javascript:goToCartList();">View Cart</a><a class="btn btn-pink buy-now">Checkout</a></div></div></div>',cartOrCheckoutModal=createModal({header:{html:"<p>Product successfully added to your cart!</p>"},body:{html:cartCheckoutHtml},footer:{isShow:!0,html:"Free Gift For Every Order!"},autoClose:!1});new LazyLoad(cartOrCheckoutModal.find(".lazyload"),{root:null,rootMargin:"10px",threshold:0}),cartOrCheckoutModal.addClass("cart-checkout"),setTimeout((function(){removeModal(cartOrCheckoutModal)}),5e3)}function toPayInstance(reqData){$.ajax({url:"${APP_PATH}/ProPay/toBuyNowPay",data:JSON.stringify(reqData),type:"post",dataType:"json",contentType:"application/json",success:function(data){100==data.code?$.ajax({url:"${APP_PATH}/MlfrontOrder/proDetailOrderToPayInfo",data:JSON.stringify({orderId:data.extend.OrderIdBuyNowPay,orderPayPlate:1,orderProNumStr:reqData.cartitemProductNumber}),type:"post",dataType:"json",contentType:"application/json",success:function(data){100==data.code?goTopayInstance():sysModalTip()},error:function(err){sysModalTip()}}):sysModalTip()},error:function(data){sysModalTip()}})}function getReviewCalData(callback){$.ajax({url:"${APP_PATH}/MlfrontReview/getMlfrontReviewCount",data:JSON.stringify({reviewPid:productId}),type:"post",dataType:"json",contentType:"application/json",success:function(data){100==data.code?callback&&callback(data.extend):refreshPageModal()},error:function(err){refreshPageModal()}})}function getReviewListData(){$.ajax({url:"${APP_PATH}/MlfrontReview/getMlfrontReviewByProductIdAndPage",data:JSON.stringify({reviewPid:productId,reviewUid:getPageNum()}),type:"post",dataType:"json",contentType:"application/json",async:!1,success:function(data){if(100==data.code){var pageInfo=data.extend.pageInfo;pageInfo.list.length?(renderProductReviewList(pageInfo.list,data.extend.imgUrlStrListst),renderTablePagination(pageInfo)):$(".product-review-body").html('<p class="text-error">here are no comments yet, you can just click the <i>Write a Reveiw</i> button to write a comment !</p>')}else refreshPageModal()},error:function(err){refreshPageModal()}})}function renderProudctReviewCal(data){var reviewNum=data.allReviewNum,reviewStarList=data.StartNumList,total=reviewStarList?reviewStarList.reduce((function(acc,item){return acc+=item.startCount}),0):0,avgStar=Math.ceil(total/reviewNum);htmlStr="";for(var i=4,percent=0;i>=0;i-=1)percent=total?100*reviewStarList[i].startCount/total:0,htmlStr+='<div class="product-review-star-item"><div class="stars">'+(i+1)+' star</div><div class="progress"><div class="progress-inner" style="width: '+percent+'%"></div></div><div class="data">'+percent.toFixed(2)+"%</div></div>";$(".product-review-avgstar .icon").each((function(idx,item){idx<avgStar&&$(item).removeClass(".star").addClass("star2")})),$(".product-review-star-list").html(htmlStr)}function renderProductReviewList(reviewList,imgList){for(var htmlStr="",i=0,len=reviewList.length;i<len;i++){htmlStr+='<div class="product-review-item"><div class="product-review-item-title"><div class="product-reivewer-img lazyload" data-src="'+reviewList[i].reviewUimgurl+'"></div><div class="product-review-item-data"><div class="product-review-stars">';for(var j=0;j<5;j++)j<reviewList[i].reviewProstarnum?htmlStr+='<span class="icon star2"></span>':htmlStr+='<span class="icon star"></span>';htmlStr+='</div><div class="product-review-author">'+reviewList[i].reviewUname+'</div></div><div class="product-review-date">'+reviewList[i].reviewCreatetime+'</div></div><div class="proudct-review-item-text">'+reviewList[i].reviewDetailstr+'</div><div class="product-review-item-imgs">';for(var imgLen=imgList[i].length<=6?imgList[i].length:6,k=0;k<imgLen;k++)htmlStr+='<div class="product-review-imgs-item lazyload" data-src="'+imgList[i][k]+'"></div>';htmlStr+="</div></div>"}$(".product-review-list").html(htmlStr),new LazyLoad($(".product-review-list .lazyload"),{root:null,rootMargin:"10px",threshold:0})}function deleteReviewId(){reviewId&&$.ajax({url:"${APP_PATH }/MlfrontReview/delete",type:"post",dataType:"json",contentType:"application/json",data:JSON.stringify({reviewId:reviewId}),success:function(data){}})}function getReviewId(){deleteReviewId(),$.ajax({url:"${APP_PATH }/MlfrontReview/initializaReview",type:"post",dataType:"json",contentType:"application/json",async:!1,success:function(data){100==data.code?reviewId=data.extend&&data.extend.mlfrontReview&&data.extend.mlfrontReview.reviewId:sysModalTip()},error:function(err){sysModalTip()}})}function saveReviewData(reqData,callback){$.ajax({url:"${APP_PATH}/MlfrontReview/save",type:"post",data:JSON.stringify(reqData),dataType:"json",contentType:"application/json",async:!1,success:function(result){100==result.code?(mlModalTip("Successful operation. New comment information needs to be reviewed before it can be displayed !"),reviewId=null,callback&&callback()):mlModalTip("Operation Failed !")},error:function(){mlModalTip("Operation Failed !")}})}var mediaData={},productData={},mainUrl,reviewSwiper,reviewModal,reviewId,hasReivewData=!1;function imageZoomEvent(){window.innerWidth<1024?$(".product-slide.product-zoom").find(".img").off("mouseover"):$(".product-slide.product-zoom").find(".img").imagezoom()}getProductDetails((function(data){mainUrl=data.productMainimgurl,data.productVideoUrl&&data.productVideoImgUrl&&(mediaData.video={videoUrl:data.productVideoUrl,posterUrl:data.productVideoImgUrl,isVideo:!0}),getProductImgs((function(data){mediaData.imgs=data,renderProductMedia(mediaData)})),productSeo=data.productSeo,productName=data.proudctName,renderProductDetails(data),getCouponAreaData(renderCouponAreaData),getProductOption((function(data){renderProductOptions(data)})),getProductSkus((function(data){data.length&&buildResult(data)}));var fbpid=data.productId,fbprice=accuracyCal(data.productOriginalprice,data.productActoffoff);fbq("track","PageView",{content_ids:fbpid,contents:[{id:fbpid,quantity:999,item_price:fbprice}],content_type:"product",value:fbprice,currency:"USD"}),fbq("track","ViewContent",{content_ids:fbpid,contents:[{id:fbpid,quantity:999,item_price:fbprice}],content_type:"product",value:fbprice,currency:"USD"})})),$(window).on("resize",imageZoomEvent),$(".share-item").on("click",(function(){window.open($(this).data("url")+encodeURIComponent(window.location.href))})),$("#product-num-add").on("click",(function(){productAdd($(this))})),$("#product-num-sub").on("click",(function(){productSub($(this))})),$(".product-tab-item").on("click",(function(){var $this=$(this),tabName=$this.data("name");$this.hasClass("active")||$('.product-tab-container[data-name="'+tabName+'"]').addClass("active").siblings().removeClass("active"),"review"!=tabName||hasReivewData||(getReviewCalData((function(data){$(".product-review-total span").text(data.allReviewNum),renderProudctReviewCal(data)})),getReviewListData(),hasReivewData=!0,$("#loader-box").hide())})),$(document.body).on("click","#table-pagination li",(function(e){getReviewListData()})),$("#add-to-cart").on("click",(function(evt){debounce((function(){if(isCorrectProduct()){var reqData=getProductData();if(!reqData)return removeModal(reviewModal),cannotBuyProductModal(),!1;addToCart(reqData,(function(){window.innerWidth>1023?generateFlyBubble(evt,updateProructNumberInCart):(updateProructNumberInCart(),selectCartOrCheckout(reqData))})),fbq("track","AddToCart",{content_ids:reqData.cartitemProductId,content_type:"product",value:reqData.cartitemProductOriginalprice,currency:"USD"})}}),300)})),$(document.body).on("click",".buy-now",(function(){var reqData=getProductData();isCorrectProduct()&&reqData&&fbq("track","InitiateCheckout",{content_ids:reqData.cartitemProductId,content_type:"product",value:accuracyCal(reqData.cartitemProductOriginalprice+parseFloat(reqData.cartitemProductskuMoneystr),reqData.cartitemProductActoff),currency:"USD"}),toBuyNow(reqData,goToCheckout)})),$(".paypal-button.paypal-now").on("click",(function(){var reqData=getProductData();isCorrectProduct()&&reqData&&(payLoading(),fbq("track","AddPaymentInfo",{content_ids:reqData.cartitemProductId,content_type:"product",value:accuracyCal((reqData.cartitemProductOriginalprice+parseFloat(reqData.cartitemProductskuMoneystr))*reqData.cartitemProductNumber,reqData.cartitemProductActoff),currency:"USD"}),toPayInstance(reqData))})),$(document.body).on("click",".product-review-imgs-item",(function(){var activeImg=$(this).data("src"),activeNum=0,imgs=[];$(this).parent().find(".lazyload").each((function(idx,item){var img=$(item).data("src");img==activeImg&&(activeNum=idx),imgs.push(img)})),createReviewSwiper(imgs,activeNum)})),$(document.body).on("click",".review-swiper-close",(function(){$(".review-swiper-box").hide(),removeFixed()})),$("#write-review").on("click",(function(e){var writeReviewHtml='<div class="write-review-content"><div class="input-group"><label for="write-review-name">User Name</label><input type="text" id="write-review-name" placeholder="Enter your name (public)"></div><div class="input-group"><label class="name">Star Rating</label><div class="write-review-star"><span class="icon star" data-id="1"></span><span class="icon star" data-id="2"></span><span class="icon star" data-id="3"></span><span class="icon star" data-id="4"></span><span class="icon star" data-id="5"></span></div></div><div class="input-group"><label for="write-review-details">Review Text</label><textarea id="write-review-details" placeholder="Write your comments here" rows="5"></textarea></div><div class="input-group"><label>Picture Zone (optional)</label><div class="write-review-img-box"><div class="ml-upload"><input class="upload-review-picture" type="file"><i class="icon plus"></i><div class="spinner"><div class="spinner-border" role="status" aria-hidden="true"></div></div></div><div class="write-review-imglist hide"></div></div></div><div class="input-group"><button class="btn btn-pink write-review-publish">publish</button></div></div>';getReviewId(),(reviewModal=createModal({header:{html:"<p>Write A Review...</p>"},body:{html:writeReviewHtml}})).addClass("review-modal")})),$(document.body).on("click",".write-review-star .icon",(function(e){$(".write-review-star").data("star",$(this).data("id")),$(this).removeClass("star").addClass("star2").prevAll(".icon").removeClass("star").addClass("star2"),$(this).nextAll(".icon").removeClass("star2").addClass("star")})),$(document.body).on("change",".upload-review-picture",(function(e){var $this=$(this),file=$this[0].files[0],formData=new FormData,reviewImgLen=$(".write-review-imglist-item").length||0,reviewImgOrder=reviewImgLen+1;return!!file&&($this.parent().find(".spinner").show(),$this.val(""),formData.append("image",file),formData.append("type","reviewDetail"),formData.append("productSeo",productSeo),formData.append("reviewId",reviewId),formData.append("reviewimgSortOrder",reviewImgOrder),reviewImgLen>=6?(mlModalTip("Upload up to 6 pictures !"),!1):void $.ajax({url:"${APP_PATH}/ImageUpload/thumImageReviewAll",type:"post",data:formData,processData:!1,contentType:!1,cache:!1,dataType:"json",success:function(data){100==data.code?($(".write-review-imglist").hasClass("hide")&&$(".write-review-imglist").removeClass("hide"),$(".write-review-imglist").append($('<div class="write-review-imglist-item"><img src="'+data.extend.sqlimageUrl+'"></div>'))):mlModalTip("Failed to upload comment picture !")},error:function(err){mlModalTip("Failed to upload comment picture !")},complete:function(){$this.parent().find(".spinner").hide()}}))})),$(document.body).on("click",".write-review-publish",(function(e){var username=$("#write-review-name").val(),starNum=$(".write-review-star").data("star"),details=$("#write-review-details").val();username&&username.trim()?starNum?details&&details.trim()?saveReviewData({reviewId:reviewId,reviewUname:username,reviewPid:productId,reviewPseoname:productSeo,reviewPname:productName,reviewDetailstr:details,reviewProstarnum:starNum,reviewFrom:1},(function(){removeModal(reviewModal)})):mlModalTip("Comment content cannot be empty !"):mlModalTip("Please Rating Star !"):mlModalTip("Please enter user name !")})),getProductSlideArea((function(data){var $el=$(".product-footer");data.length&&(renderIntroduceProductSlide($el,data),new LazyLoad($el.find(".lazyload"),{root:null,rootMargin:"10px",threshold:0}))})),$(window).on("beforeunload",(function(){deleteReviewId(),setPageNum(1)}));</script>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>