<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!-- split main end -->
</main>
<footer>
	<div class="footer-page-header">
		<div class="container">
			<div class="follow-us">
				<h3 class="follow-us-title wap-follow-us">FOLLOW US</h3>
				<div class="follow-us-title pc-follow-us">
					<img src="${APP_PATH }/static/common/dblogo.png" alt="" title="megalook" style="width:150px">
					<div style="margin-top:6px;">My New Look </div>
				</div>
				<ul class="follow-us-list">
					<li class="follow-icon instagram" title="megalook instagram"><a href="https://www.instagram.com/megalookhair1/"></a></li>
					<li class="follow-icon youtube" title="megablook youtube"><a href="https://www.youtube.com/channel/UCbbrYL1KabTMlXFmQhFWtmw?view_as=subscriber"></a></li>
					<li class="follow-icon facebook" title="megalook facebook"><a href="https://www.facebook.com/MegalookHairCompany/"></a></li>
					<li class="follow-icon pinterest" title="megalook pinterest"><a href="https://www.pinterest.com/amegalook/"></a></li>
					<li class="follow-icon snapchat" title="megalook snapchat"><a href="https://www.snapchat.com/add/megalook-hair"></a></li>
				</ul>
			</div>
			<div class="footer-nav pc-footer"></div>
			<div class="footer-nav wap-footer"></div>	
		</div>
	</div>
	<div class="footer-page-footer">
		<div class="container">
			<p class="copyright">Copyright © 2019, MegaLook, All Rights Reserved</p>
			<img src="${APP_PATH }/static/pc/img/paypalcard.jpg" title="paypal card">
		</div>
	</div>
</footer>
<script>function initFooterData(data){for(var key in footerData){var blockData=data[footerData[key]["data-key"]];for(var key2 in blockData)blockData[key2].footnavIfincome?footerData[key].children.push({name:blockData[key2].footnavName,icon:"",link:"${APP_PATH}/MlbackFootNav/toFootNavPage?footnavId="+blockData[key2].footnavId}):footerData[key].children.push({name:blockData[key2].footnavName,icon:"",link:"javascritp:;"})}}function renderFooterNav(parent,data){for(var htmlStr="",i=0,len=data.length;i<len;i+=1){htmlStr+='<div class="footer-nav-item '+data[i].name.toLowerCase()+'"><h4 class="footer-nav-title">'+data[i].name.replace(/\_/g," ")+'<i class="icon '+data[i].icon+'"></i></h4>';var children=data[i].children,len2=children&&data[i].children.length||0;if(len2){for(htmlStr+='<ul class="footer-nav-body footer-nav-submenu">',j=0;j<len2;j+=1)htmlStr+='<li class="footer-nav-submenu-item"><a href="'+children[j].link+'">'+children[j].name+"</a></li>";htmlStr+="</ul>"}htmlStr+="</div>"}parent.html(htmlStr)}function addWapFooterNavEvent(){$(".client_service_support").find(".icon").addClass("sub").removeClass("plus").parents(".footer-nav-item").find(".footer-nav-body").slideDown(),$(document.body).on("click",".footer-nav-title",(function(){$(".footer-nav-body").slideUp().parents(".footer-nav").find(".icon").removeClass("sub").addClass("plus"),$(this).find(".icon").addClass("sub").removeClass("plus").parents(".footer-nav-item").find(".footer-nav-body").slideDown()}))}function backTop(){function toTop(){if(window.pageYOffset>window.innerHeight){var $backTop=$(".back-top");$backTop.length||($backTop=$('<div id="back-top" class="back-top" title="back top"><span class="icon backtop"></span></div>'),$(document.body).append($backTop)),setTimeout((function(){$backTop.addClass("active")}),100)}else $(".back-top").hasClass("active"),$(".back-top").removeClass("active")}$(window).on("scroll",(function(){var timeEnd=Date.now();timeEnd-timeStart<100&&clearTimeout(timer),timeStart=timeEnd,timer=setTimeout(toTop,100)})),$(document.body).on("click","#back-top",(function(){$("html").animate({scrollTop:0},500)}))}function getFooterNavData(callback){$.ajax({url:"${APP_PATH}/MlbackFootNav/getMlfrontFootNavAllSimple",type:"post",async:!1,success:function(data){100==data.code?callback&&callback(data.extend):refreshPageModal()},error:function(err){refreshPageModal()}})}var footerData=[{name:"Megalook_Hair",icon:"plus",link:"javascript:;",children:[],"data-key":"mlbackFootNavOneList"},{name:"Buyer_Service",icon:"plus",link:"javascript:;",children:[],"data-key":"mlbackFootNavTwoList"},{name:"Activity",icon:"plus",link:"javascript:;",children:[],"data-key":"mlbackFootNavThreeList"},{name:"Client_Service_Support",icon:"plus",link:"javascript:;",children:[],"data-key":"mlbackFootNavFourList"}];getFooterNavData((function(data){0==data.isNav&&mlModalTip("<p>Failed to get to the relevant data !</p>"),1==data.isNav&&(initFooterData(data),renderFooterNav($(".footer-nav"),footerData),addWapFooterNavEvent())})),backTop();</script>