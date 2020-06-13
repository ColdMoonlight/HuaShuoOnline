<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
    <title></title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<script>
		// console.log('${sessionScope}')
		var productId = '${sessionScope.productDetailId}';
		var seoTitle = '${sessionScope.mlbackProductMetaTitle}';
		var seoDescription = '${sessionScope.mlbackProductMeteDesc}';
		var seoKeywords = '${sessionScope.mlbackProductMetaKeyWords}';
		document.title = seoTitle;
		addMeta('keyword', seoKeywords);
		addMeta('description', seoDescription);
	</script>
</head>

<body>
    <jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main></main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script>
		/* product imgs */
		$.ajax({
			url: '${APP_PATH}/MlbackProductImg/getMlbackProductImgListByProductId',
			data: JSON.stringify({ "productId": productId }),
			dataType: 'json',
			contentType: 'application/json',
			type: "post",
			success: function (data) {
				if (data.code == 100) {
					var resData = data.extend;
					console.log(resData.mbackProductImgResList);
				}
			}
		});
		
		/* details of main */
		$.ajax({
			url: '${APP_PATH}/MlbackProduct/getOneMlbackProductDetail',
			data: JSON.stringify({ "productId": productId }),
			dataType: 'json',
			contentType: 'application/json',
			type: "post",
			success: function (data) {
				if (data.code == 100) {
					var resData = data.extend.mlbackProductOne;
					console.log(resData);
				}
			}
		});
		/* product sku-list status=1 */
		$.ajax({
			url: '${APP_PATH}/MlbackProductSku/customerGetMlbackProductSkuListByPId',
			data: JSON.stringify({
				"productskuPid": productId,
				"productskuStatus": 1
			}),
			dataType: 'json',
			contentType: 'application/json',
			type: "post",
			success: function (data) {
				if (data.code == 100) {
					var resData = data.extend;
					console.log(resData);
				}
			}
		});
		/* product option */
		$.ajax({
			url: '${APP_PATH}/MlbackProductAttributeName/getMlbackProductAttributeNameListByProductId',
			data: JSON.stringify({ "productattrnamePid": productId }),
			dataType: 'json',
			contentType: 'application/json',
			type: "post",
			success: function (data) {
				if (data.code == 100) {
					var resData = data.extend;
					console.log(resData);
				}
			}
		});
		
		
		
	</script>
</body>
</html>