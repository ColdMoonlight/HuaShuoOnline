<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no"/>
<!-- icon -->
<link rel="icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
<link rel="apple-touch-icon" sizes="120x120" href="${APP_PATH }/static/apple/micon1.png">
<link rel="apple-touch-icon" sizes="180x180" href="${APP_PATH }/static/apple/micon2.png">
<!-- common css -->
<link href="${APP_PATH}/static/pc/css/main.css" rel="stylesheet">
<script src="${APP_PATH}/static/common/jquery.min.js"></script>
<script src="${APP_PATH}/static/pc/js/lazyload/lazyload.min.js"></script>
<script>
	function addMeta(name, content) {
		var meta = document.createElement('meta');
		meta.name = name;
		meta.content = content;
		document.head.appendChild(meta);
	}
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

	function addTidio() {
		var script = document.createElement('script');
		script.async = true;
		script.src = ml.tidio;
		document.body.appendChild(script);
	}
	/* varient */
	var timer = null, timeStart = Date.now(), mapSet = {}, mapItems = {}, optionObj = {}, optionIdArr = [], emailPattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
	var storage = window.localStorage;
 	var ml = {
 		facebookAppId: '667403967094866', // megalook
 		// facebookAppId: '246433859565492', // huashuohair
		tidio: '//code.tidio.co/sjcpaqy3xxtkt935ucnyf2gxv1zuh9us.js', // megalook
		// "tidio": '//code.tidio.co/0rpdotjoqewxstfjahkd1ajtxrcp8phh.js', // megalookhair
		// "tidio": '//code.tidio.co/folzahtp5vdopiwathysfiyz75dk5vnm.js', // huashuohair
 	};
</script>