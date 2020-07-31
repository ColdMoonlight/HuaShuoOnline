<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
<!-- icon -->
<link rel="icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
<link rel="apple-touch-icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
<link rel="apple-touch-icon" sizes="180x180" href="${APP_PATH }/static/apple/micon2.png">
<%-- <jsp:include page="intercept.jsp" flush="true"></jsp:include> --%>
<!-- common css -->
<link href="${APP_PATH}/static/pc/css/main.css" rel="stylesheet">
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script src="${APP_PATH}/static/pc/js/lazyload/lazyload.min.js"></script>
<!-- custom scripts -->
<script>
	/* get carousel data */
	function getCarouselData(area, callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackSlides/getMlbackSlidListByArea',
			data: JSON.stringify({ "slideArea": area }),
			dataType: 'json',
			contentType: 'application/json',
			type: "post",
			async: false,
			success: function (data) {
				if (data.code == 100) {
					callback && callback(data.extend.mlbackSlideList);
				}
			}
		});
	}
	// debounce
	function debounce(callback, delay) {
		var timeEnd = Date.now();
		delay = delay || 100;
		if (timeEnd - timeStart > delay) clearTimeout(timer);
		timer = setTimeout(function() {
			callback && callback();			
		}, delay);
	}
</script>
<script>
<!-- Facebook Pixel Code -->
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
</script>