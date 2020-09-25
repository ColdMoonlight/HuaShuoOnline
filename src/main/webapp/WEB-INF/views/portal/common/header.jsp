<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<%-- <jsp:include page="intercept.jsp" flush="true"></jsp:include> --%>
<!-- common css -->
<link href="${APP_PATH}/static/pc/css/main.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script src="${APP_PATH}/static/pc/js/lazyload/lazyload.min.js"></script>
<!-- custom scripts -->
<script>function getCarouselData(area,async,callback){$.ajax({url:"${APP_PATH}/MlbackSlides/getMlbackSlidListByArea",data:JSON.stringify({slideArea:area}),dataType:"json",contentType:"application/json",type:"post",async:async,success:function(data){100==data.code&&callback&&callback(data.extend.mlbackSlideList)}})}function debounce(callback,delay){var timeEnd;delay=delay||100,Date.now()-timeStart>delay&&clearTimeout(timer),timer=setTimeout((function(){callback&&callback()}),delay)}</script>
<script>
/* Facebook Pixel Code */
!function(f,b,e,v,n,t,s) {if(f.fbq)return;n=f.fbq=function(){n.callMethod? n.callMethod.apply(n,arguments):n.queue.push(arguments)}; if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0'; n.queue=[];t=b.createElement(e);t.async=!0; t.src=v;s=b.getElementsByTagName(e)[0]; s.parentNode.insertBefore(t,s)}(window, document, 'script', 'https://connect.facebook.net/en_US/fbevents.js');
fbq('init', ml.facebook_id);
fbq('track', 'PageView');
fbq('track', 'ViewContent');
$(document.head).append('<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id='+ ml.facebook_id +'&ev=PageView&noscript=1" /></noscript>');
/* Global site tag (gtag.js) */
$(document.head).append($('<script async src="https://www.googletagmanager.com/gtag/js?id='+ ml.google_id +'" />'));
window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', ml.google_id);
/* Pinterest Tag */
!function(e){if(!window.pintrk){window.pintrk = function () {window.pintrk.queue.push(Array.prototype.slice.call(arguments))};var n=window.pintrk;n.queue=[],n.version="3.0";var t=document.createElement("script");t.async=!0,t.src=e;var r=document.getElementsByTagName("script")[0];r.parentNode.insertBefore(t,r)}}("https://s.pinimg.com/ct/core.js");
pintrk('load', ml.pinterest_id, {em: ml.pinterest_email});
pintrk('page');
pintrk('track', 'pagevisit');
$(document.head).append('<noscript><img height="1" width="1" style="display:none;" alt="" src="https://ct.pinterest.com/v3/?event=init&tid='+ ml.pinterest_id +'&pd[em]='+ ml.pinterest_hash_email +'&noscript=1" /></noscript>');
</script>