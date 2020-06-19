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
		<div class="container">
			
		</div>
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		// ajax fetch cart-list
		function getCartListData() {
			$.ajax({
				url: '${APP_PATH}/MlbackCart/getCartitemIdDetails',
				type: 'post',
				success: function (data) {
					if (data.code == 100) {
						console.log(data.extend.mlfrontCartItemListRes)	
					}
				}
			})
		}
		
		getCartListData();
		var modal = createModal();
	</script>
</body>

</html>