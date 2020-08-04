<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<script>
function addMeta(name, content) {
	var meta = document.createElement('meta');
	meta.name = name;
	meta.content = content;
	document.head.appendChild(meta);
}
// tidio widget
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
	//test的fbid googleid tidio
	facebook_id: '611850146411825', // test
	google_id: 'UA-148324397-1', // test
	tidio: '//code.tidio.co/sjcpaqy3xxtkt935ucnyf2gxv1zuh9us.js', 
	//www.megalook.com的fbid googleid tidio
	// facebook_id: '667403967094866', // megalook
	// google_id: 'UA-145178467-1', // megalook
	// "tidio": '//code.tidio.co/sjcpaqy3xxtkt935ucnyf2gxv1zuh9us.js', 
	//www.huashuohair.com的fbid googleid tidio
	// facebook_id: '246433859565492', // huashuohair
	// google_id: 'UA-128377932-1', // huashuohair
	// "tidio": '//code.tidio.co/folzahtp5vdopiwathysfiyz75dk5vnm.js', 
};
</script>