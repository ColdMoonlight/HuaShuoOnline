<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>Cart List</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
</head>

<body>
	<jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
		<div class="container"></div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		// ajax fetch cart-list
		function getCartListData(callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackCart/getCartitemIdDetails',
				type: 'post',
				success: function (data) {
					if (data.code == 100) {
						callback(data.extend.mlfrontCartItemListRes);
					}
				}
			});
		}
		function renderCartList(data) {
			var htmlHeader = '<div class="cart-header"></div>';
			var htmlBody = '<div class="cart-body"></div>';
			$('main .container').html(htmlHeader + htmlBody);
		}
		function renderCartEmpty() {
			var htmlStr = '<div class="cart-empty">' +
				'<img src="${APP_PATH}/static/pc/img/cart-empty.png">' +
				'<p>The shopping cart is empty. Come and fill it up!</p>' +
				'<a href="${APP_PATH}/index.html" class="btn"> Shop Now </a>' +
			'</div>';
			$('main .container').html(htmlStr);
		}
		getCartListData(function(data) {
			if (data.length) {
				renderCartList(data);
			} else {
				renderCartEmpty();
			}			
		});
	</script>
</body>

</html>