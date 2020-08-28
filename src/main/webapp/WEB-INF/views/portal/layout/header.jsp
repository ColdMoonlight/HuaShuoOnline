<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<header>
	<div class="pc-header">
		<div class="ml-ad"></div>
		<div class="ml-search">
			<div class="container">
				<a class="logo" href="javascript:goToIndex();">
					<img src="${APP_PATH }/static/common/dblogo.png" alt="megalook" title="megalook">
				</a>
				<div class="search-box">
					<div class="search-inputgroup">
						<input type="text" class="search-input" placeholder="Search Products..." />
						<button class="btn btn-search" type="submit"><i class="icon search"></i></button>
					</div>
				</div>
				<div class="right-box">
					<a class="track-order" href="javascript:goToSearchTrack();" title="search your tracking info...">Track Order</a>
					<div class="login" title="login/register">
						<i class="icon person"></i>
					</div>				
				</div>
			</div>
		</div>
		<div class="pc-nav">
			<div class="container">
				<ul class="ml-nav"></ul>
			</div>
		</div>
		<a href="${APP_PATH}/MlbackCart/toCartList" class="icon cart"><span class="num">0</span></a>
	</div>
	<div class="wap-header">
		<div class="ml-ad"></div>
		<div class="wap-search-track">
			<a class="wap-track-order" id="search-product">
				<span class="icon search"></span>
				<span class="wap-track-order-text">Search Product...</span>
			</a>
		</div>
		<div class="wap-navbar">
			<span id="menu" class="icon menu"></span>
			<span class="icon person" title="login/register"></span>
			<a href="TEL:(501)7226336" class="icon phone"></a>
			<a class="logo" href="javascript:goToIndex();">
				<img src="${APP_PATH}/static/common/dblogo.png" alt="megalook" title="megalook">
			</a>
			<span class="icon" id="iphone-share"></span>
			<a href="${APP_PATH}/MlbackCart/toCartList" class="icon cart"><span class="num">0</span></a>
			<a href="javascript:goToSearchTrack();" class="icon shipping"></a>
			<div class="search-box">
				<div class="title">What are you Looking for?</div>
				<div class="search-inputgroup">
					<input type="text" class="search-input" placeholder="Search Products..." />
					<button class="btn btn-search" type="submit">Search</button>
				</div>
			</div>
		</div>
	</div>
</header>
<!-- wap menu-list -->
<div class="wap-nav-box">
	<div class="wap-nav-header">
		<i class="icon close"></i>
	</div>
	<div class="wap-nav-body">
		<ul class="wap-nav ml-nav"></ul>
	</div>
	<div class="wap-nav-footer"></div>
</div>
<!-- search result -->
<div class="search-result-box">
	<span class="icon close"></span>
	<ul class="search-result"></ul>
</div>
<!-- split main start -->
<main>
<script>function getOneProductData(reqData,callback){$.ajax({url:"${APP_PATH}/MlbackProduct/getOneProductSimple",data:JSON.stringify(reqData),type:"post",dataType:"json",contentType:"application/json",success:function(data){100==data.code?callback&&callback(data.extend.mlbackProductOne):sysModalTip()},error:function(){sysModalTip()}})}function matchYoutubeUrl(url){return url.split("watch?v=")[1]}function renderVideoData(data,videoLink){var videoRecommendHtml='<div class="video-recommend"><iframe frameborder="0" allowfullscreen="1" allow="autoplay; encrypted-media" title="YouTube video player" width="100%" height="300" src="'+videoLink+'"></iframe><div class="video-recommend-product"><div class="video-recommend-img lazyload" data-src="'+data.productMainimgurl+'"></div><div class="video-recommend-data"><div class="video-recommend-name">'+data.productName+'</div><div class="video-recommend-dprice"><span class="">Regular Price :</span><span class="value">$'+data.productOriginalprice.toFixed(2)+'</span></div><div class="video-recommend-nprice"><span class="name">Sale Price :</span><span class="value">$'+(data.productOriginalprice&&data.productActoffoff?accuracyCal(data.productOriginalprice,data.productActoffoff):0)+'</span></div><a class="btn btn-pink" href="'+(data.productSeo?"${APP_PATH}/"+data.productSeo+".html":"jvascrtip:;")+'">Buy Now</a></div></div></div>',videoRecommendModal=createModal({header:{html:"<p>Hot Video Recommend...</p>"},body:{html:videoRecommendHtml}});new LazyLoad(videoRecommendModal.find(".lazyload"),{root:null,rootMargin:"10px",threshold:0})}function getLabelClass(id){return 1==id?"label-hot":2==id?"label-new":3==id?"label-sale":4==id?"label-doubledrawn":9==id?"label-15a":""}function renderMainCategory(parentEl,data1,data2){for(var menuHhtml="",i=0;i<data1.length;i++){var labelClass=getLabelClass(data1[i].catalogLable),secondNavSeo;if(0==data1[i].catalogIfproorcateorpage&&(secondNavSeo=data1[i].catalogSeoname),1==data1[i].catalogIfproorcateorpage&&(secondNavSeo="search/"+data1[i].catalogCateseoname),2==data1[i].catalogIfproorcateorpage&&(secondNavSeo=data1[i].catalogPageseoname),menuHhtml+='<li class="menu-item label '+labelClass+'">',menuHhtml+='<a href="'+(data1[i].catalogIfinto?"${APP_PATH}/"+secondNavSeo+".html":"javascript:;")+'">'+data1[i].catalogName+"</a>",data2&&data2.length>0&&data2[i]&&data2[i].length>0){var subMenuHtml="",isWrap=!0,subMenuLen=data2[i].length;subMenuLen&&(menuHhtml+='<div class="operate wap-op-one"><i class="icon plus"></i></div>');for(var j=0;j<subMenuLen;j+=1)if(data2[i][j]&&data2[i][j].length>0){subMenuHtml+='<dl class="sub-menu-item">';for(var thirdMenuLen=data2[i][j].length,k=0;k<thirdMenuLen;k+=1){var labelClass=getLabelClass(data2[i][j][k].catalogLable),thirdNavSeo;0==data2[i][j][k].catalogIfproorcateorpage&&(thirdNavSeo=data2[i][j][k].catalogSeoname),1==data2[i][j][k].catalogIfproorcateorpage&&(thirdNavSeo="search/"+data2[i][j][k].catalogCateseoname),2==data2[i][j][k].catalogIfproorcateorpage&&(thirdNavSeo=data2[i][j][k].catalogPageseoname),0==k?subMenuHtml+='<dt><a href="'+(data2[i][j][k].catalogIfinto?"${APP_PATH}/"+thirdNavSeo+".html":"javascript:;")+'">'+data2[i][j][k].catalogName+"</a>"+(thirdMenuLen>1?'<div class="operate wap-op-two"><i class="icon plus"></i></div>':"")+"</dt>":(isWrap=!1,subMenuHtml+='<dd><a href="'+(data2[i][j][k].catalogIfinto?"${APP_PATH}/"+thirdNavSeo+".html":"javascript:;")+'">'+data2[i][j][k].catalogName+"</a></dd>")}subMenuHtml+="</dl>"}menuHhtml+='<div class="sub-menu-container"><div class="sub-menu'+(isWrap?" nowrap":"")+'">'+subMenuHtml+"</div></div>"}menuHhtml+="</li>"}parentEl.html(menuHhtml)}function addNavEvent(){var timer=null;$(".pc-nav .menu-item").on("mouseenter",(function(e){var $this=$(this);timer=setTimeout((function(){enterEvent($this,e)}),300)})).on("mouseleave",(function(e){var $this=$(this);clearTimeout(timer),$this.find(".sub-menu-container").removeClass("active"),$this.find("a").removeClass("active")}))}function addWapNavEvent(){$("#menu").on("click",(function(){$(".wap-nav-box").addClass("active"),addFixed(),$(".lottery").length&&$(".lottery").addClass("hide")})),$(".wap-nav-box").on("click",(function(e){this==e.target&&($(".wap-nav-box").removeClass("active"),removeFixed())})),$(".wap-nav-box .close").on("click",(function(){$(".wap-nav-box").removeClass("active"),removeFixed(),$(".lottery").length&&$(".lottery").removeClass("hide")})),$(".wap-op-one").click((function(e){e.stopPropagation();var $this=$(this),str;"none"==$this.next(".sub-menu-container").css("display")?($this.next(".sub-menu-container").show(200),$this.find(".icon").addClass("sub").removeClass("plus")):($this.next(".sub-menu-container").hide(200),$this.find(".icon").removeClass("sub").addClass("plus")),$this.parent(".menu-item").siblings(".menu-item").find(".wap-op-one .sub").removeClass("sub").addClass("plus").parent().next(".sub-menu-container").hide(200).find("dd").hide().parent().find(".wap-op-two .sub").removeClass("sub").addClass("plus")})),$(".wap-op-two").click((function(e){e.stopPropagation();var $this=$(this);$this.find(".icon").hasClass("sub")?$this.find(".icon").removeClass("sub").addClass("plus").parents("dl").find("dd").hide(200):($(".wap-op-two .sub").removeClass("sub").addClass("plus").parents("dl").find("dd").hide(200),$this.find(".icon").addClass("sub").removeClass("plus").parents("dl").find("dd").show(200))}))}function enterEvent($this,e){var targetEl=$this.find(".sub-menu-container"),outerWidth=0,clientRect=$this[0].getBoundingClientRect(),navulClientRect=$(".pc-nav .ml-nav")[0].getBoundingClientRect(),offsetWidth=window.innerWidth>navulClientRect.width?navulClientRect.width:window.innerWidth,offsetLeft=clientRect.left-navulClientRect.left,offsetBottom=clientRect.bottom-navulClientRect.top;if(targetEl.addClass("active"),(outerWidth=targetEl.outerWidth())>=offsetWidth)targetEl.css({width:offsetWidth+"px",left:"0px",top:offsetBottom+"px"});else if(offsetLeft<(outerWidth-clientRect.width)/2&&offsetLeft+clientRect.width/2<offsetWidth/2)targetEl.css({left:"0px",top:offsetBottom+"px"});else if(offsetLeft+clientRect.width+(outerWidth-clientRect.width)/2>=offsetWidth&&offsetLeft+clientRect.width/2>offsetWidth/2)targetEl.css({left:"unset",right:"0px",top:offsetBottom+"px"});else{var defaultLeft=offsetLeft-(outerWidth-clientRect.width)/2;targetEl.css({left:defaultLeft+"px",top:offsetBottom+"px"})}$this.find("a").addClass("active")}function getNavMenuData(callback){$.ajax({url:"${APP_PATH}/MlbackCatalog/getCatalogSuperMenu",method:"post",async:!1,success:function(data){100==data.code?callback&&callback(data.extend):mlModalTip("Failed to get to the relevant data !")},error:function(err){sysModalTip()}})}function updateProructNumberInCart(){$.ajax({url:"${APP_PATH}/MlbackCart/getCartProductNumber",method:"post",success:function(data){100==data.code&&$(".cart .num").html(data.extend.number||0)}})}function renderIntroduceSearch(){var data,searchRsultHtml="";["U part","Deep Wave","Closure Wig","99J","Highlight","Bob","Water Wave","Pixie Cut","Glueless","Ponytail","Piano Color","Affordable","Lace Closure Wig","Full Lace Wig","Bundles","360 Lace Frontal Wig","613"].forEach((function(item,idx){searchRsultHtml+='<li class="search-result-item" data-name="'+item+'">'+item+"</li>"})),$(".search-result").html(searchRsultHtml)}function checkUserLoginOrNot(){var flag=!1;return $.ajax({url:"${APP_PATH}/MlfrontUser/ifLogin",type:"post",async:!1,success:function(data){100==data.code&&(flag=!!data.extend.ifLogin)}}),flag}function updateUserLoginStatus(){var loginStatus=checkUserLoginOrNot(),$pserson=$(".icon.person");loginStatus&&!$pserson.hasClass("active")&&$pserson.addClass("active"),!loginStatus&&$pserson.hasClass("active")&&$person.removeClass("active")}function registerFn(reqData,callback){payLoading(),$.ajax({url:"${APP_PATH }/MlfrontUser/register",type:"post",data:JSON.stringify(reqData),dataType:"json",contentType:"application/json",success:function(data){data.extend.registerYes?(mlModalTip("Registered successfully !"),callback&&callback()):mlModalTip(data.extend.resMsg)},error:function(){sysModalTip()},complete:function(){hidePayLoading()}})}function forgetFn(reqData,callback){payLoading(),$.ajax({url:"${APP_PATH}/MlfrontUser/reSetPwd",type:"post",data:JSON.stringify(reqData),dataType:"json",contentType:"application/json",success:function(data){100==data.code?(mlModalTip("Password change successfully !"),callback&&callback()):mlModalTip("Password change failed !")},error:function(){sysModalTip()},complete:function(){hidePayLoading()}})}function loginFn(reqData,callback){payLoading(),$.ajax({url:"${APP_PATH }/MlfrontUser/login",type:"post",data:JSON.stringify(reqData),dataType:"json",contentType:"application/json",success:function(data){data.extend.loginYes?(mlModalTip("Login successfully !"),callback&&callback()):mlModalTip(data.extend.resMsg)},error:function(){sysModalTip()},complete:function(){hidePayLoading()}})}function loginRegisterBox(){var loginRegisterHtml;(loginRegisterModal=createModal({header:{html:"<p>MegaLook</p>"},body:{html:'<div class="left-box"><div class="tab"><div class="tab-item active" data-id="signin">Sign In</div><div class="tab-item" data-id="register">Register</div></div><div class="tab-pane signin active"><form id="signin"><div class="input-group"><label for="suserEmail">E-mail</label><input type="email" id="suserEmail" name="userEmail" placeholder="eamil" required></div><div class="input-group"><label for="suserPassword">Password</label><input type="password" id="suserPassword" name="userPassword" placeholder="password at least six figures"></div></form><div class="btn-group"><a href="javascript:;" class="btn btn-black sigin">SIGN IN</a></div><p class="forget-password"><a id="forget-password">Forget PassWord?</a></p></div><div class="tab-pane register"><form id="register"><div class="input-group"><label for="ruserEmail">E-mail</label><input type="email" id="ruserEmail" name="userEmail" placeholder="please input eamil" required></div><div class="input-group"><label for="ruserPassword">Password</label><input type="password" id="ruserPassword" name="userPassword" placeholder="password at least six figures"></div><div class="input-group"><label for="rConfirmPassword">ConfirmPassword</label><input type="password" id="rConfirmPassword" name="ConfirmPassword" placeholder="ConfirmPassword"></div></form><div class="btn-group"><a href="javascript:;" class="btn btn-black register"> REGISTER </a><a href="javascript:goToIndex();" class="btn btn-pink">Go Home</a></div></div></div><div class="right-box"><form id="forget-password"><div class="input-group"><label for="fuserEmail">E-mail</label><input type="email" id="fuserEmail" name="userEmail" placeholder="please input eamil" required></div><div class="input-group"><label for="fuserPassword">Password</label><input type="password" id="fuserPassword" name="userPassword" placeholder="password at least six figures"></div><div class="input-group"><label for="fConfirmPassword">ConfirmPassword</label><input type="password" id="fConfirmPassword" name="ConfirmPassword" placeholder="ConfirmPassword"></div></form><div class="btn-group"><a href="javascript:;" class="btn btn-black forget-password"> Confirm </a></div>'}})).addClass("login-register")}function renderHeaderAd(data){var adSeo,adLink;0==data.slideIfproorcateorpage&&(adSeo=data.slideSeoname),1==data.slideIfproorcateorpage&&(adSeo="search/"+data.slideCateseoname),2==data.slideIfproorcateorpage&&(adSeo=data.slidePageseoname),adLink=data.slideIfinto?"${APP_PATH}/"+adSeo+".html":"javascript:;",data.slideWapstatus&&$(".wap-header .ml-ad").html('<a class="lazyload" href="'+adLink+'" data-src="'+data.slideWapimgurl+'"></a>'),data.slidePcstatus&&$(".pc-header .ml-ad").html('<a class="lazyload" href="'+adLink+'" data-src="'+data.slidePcimgurl+'"></a>'),new LazyLoad($(".ml-ad .lazyload"),{root:null,rootMargin:"10px",threshold:0})}function goToSearchProduct(searchName){window.location.href="${APP_PATH}/MlbackProduct/toSearchPage?searchProductName="+searchName}function checkSearchInput(value){return!!value.trim()||(mlModalTip("The search content cannot be empty !"),!1)}function refreshPage(){var currentUrl=window.location.href;"${APP_PATH}/MlbackCart/toCheakOut"==currentUrl&&(window.location.href=currentUrl)}function initIphoneShare(){var isIOS;navigator.userAgent&&navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/)?$("#iphone-share").addClass("share"):$("#iphone-share").removeClass("share")}function showSearchBox(){addFixed(),$(".search-result-box").addClass("active").slideDown(300),window.innerWidth<1023?($(".wap-navbar .search-box").show(),$(".search-result-box").css("top",$(".wap-navbar .search-box").outerHeight())):$(".search-result-box").css("top",$(".pc-header").outerHeight()-$(".pc-nav").height()),renderIntroduceSearch()}getCarouselData(5,(function(data){var hData=data[0];hData&&renderHeaderAd(hData)})),getNavMenuData((function(data){renderMainCategory($(".ml-nav"),data.CatalogFirstList,data.MlbackCatalogSuperList),initIphoneShare(),$("main").css({paddingTop:$("header").height()}),addNavEvent(),addWapNavEvent()})),updateProructNumberInCart(),updateUserLoginStatus(),$(".pc-header .search-input,#search-product").on("click",showSearchBox),$(".search-result-box").on("click",(function(e){e.target==this&&(removeFixed(),window.innerWidth<1023&&$(".wap-navbar .search-box").slideUp(300),$(this).removeClass("active").slideUp(300))})),$(".search-result-box .close").on("click",(function(){removeFixed(),window.innerWidth<1023&&$(".wap-navbar .search-box").slideUp(),$(".search-result-box").removeClass("active").slideUp()})),$(".btn-search").on("click",(function(){var searchName=$(this).parent().find(".search-input").val();checkSearchInput(searchName)&&goToSearchProduct(searchName)})),$(".search-input").on("keyup",(function(e){if(13==e.keyCode){var searchName=$(".search-input").val();checkSearchInput(searchName)&&goToSearchProduct(searchName)}})),$(document.body).on("click",".search-result-item",(function(){var searchName=""+$(this).data("name");checkSearchInput(searchName)&&goToSearchProduct(searchName)}));var startY=0,loginRegisterModal=null;$(window).on("scroll",(function(){var currentY=window.pageYOffset,isPc=window.innerWidth>1024;currentY>=startY&&currentY>60&&isPc&&!$(".ml-search").hasClass("down")&&($(".ml-search").addClass("hide down").removeClass("up"),$("main").css({paddingTop:$("header").height()})),currentY<startY&&currentY<60&&isPc&&!$(".ml-search").hasClass("up")&&($(".ml-search").removeClass("down").removeClass("hide").addClass("up"),$("main").css({paddingTop:$("header").height()})),startY=currentY})),$(window).on("resize",(function(){debounce((function(){$("main").css({paddingTop:$("header").height()}),$(".search-result-box").hasClass("active")&&showSearchBox(),initIphoneShare()}),100)})),$("#iphone-share").on("click",(function(){var $iphoneAdvice=$(".iphone-advice");$iphoneAdvice.length||($iphoneAdvice=$('<div class="iphone-advice"><img src="${APP_PATH}/static/pc/img/iphone-advice.gif" /><span class="icon close"></span></div>'),$(document.body).append($iphoneAdvice),addFixed()),$iphoneAdvice.show()})),$(document.body).on("click",".iphone-advice .close",(function(){$(".iphone-advice").hide(),removeFixed()})),$(".icon.person").on("click",(function(){$(this).hasClass("active")?goToUserCenter():loginRegisterBox()})),$(document.body).on("click",".login-register .tab-item",(function(){$(this).hasClass("active")||($(this).addClass("active").siblings().removeClass("active"),$(".tab-pane."+$(this).data("id")).addClass("active").siblings().removeClass("active"))})),$(document.body).on("click","#forget-password",(function(){$(".left-box").hide(),$(".right-box").show()})),$(document.body).on("click",".btn.sigin",(function(){var email=$("#signin input[name=userEmail]").val(),password=$("#signin input[name=userPassword]").val();email&&emailPattern.test(email)?password.length<6?mlModalTip("The password entered is invalid !"):loginFn({userEmail:email,userPassword:password},(function(){removeModal(loginRegisterModal),updateProructNumberInCart(),$(".icon.person").addClass("active"),refreshPage()})):mlModalTip("It is illegal to enter an email address !")})),$(document.body).on("click",".btn.register",(function(){var email=$("#register input[name=userEmail]").val(),password=$("#register input[name=userPassword]").val(),password2=$("#register input[name=ConfirmPassword]").val();if(email&&emailPattern.test(email))if(password.length<6)mlModalTip("The password entered is invalid !");else if(password2.length){if(!(password2.length<6))return password!=password2?(mlModalTip("Twice the password is double, please re-enter the password !"),void $("#register input[name=ConfirmPassword]").val("")):void registerFn({userEmail:email,userPassword:password},(function(){removeModal(loginRegisterModal),updateProructNumberInCart(),$(".icon.person").addClass("active"),refreshPage(),setTimeout((function(){mlModalTip("The new account has been automatically logged in !")}),2e3),fbq("track","CompleteRegistration")}));mlModalTip("The confirm password entered is invalid !")}else mlModalTip("Please enter a confirmation password !");else mlModalTip("It is illegal to enter an email address !")})),$(document.body).on("click",".btn.forget-password",(function(){var email=$("#forget-password input[name=userEmail]").val(),password=$("#forget-password input[name=userPassword]").val(),password2=$("#forget-password input[name=ConfirmPassword]").val();if(email&&emailPattern.test(email))if(password.length<6)mlModalTip("The password entered is invalid !");else if(password2.length){if(!(password2.length<6))return password!=password2?(mlModalTip("Twice the password is double, please re-enter the password !"),void $("#register input[name=ConfirmPassword]").val("")):void forgetFn({userEmail:email,userPassword:password},(function(){$(".left-box").show(),$(".right-box").hide()}));mlModalTip("The confirm password entered is invalid !")}else mlModalTip("Please enter a confirmation password !");else mlModalTip("It is illegal to enter an email address !")}));</script>