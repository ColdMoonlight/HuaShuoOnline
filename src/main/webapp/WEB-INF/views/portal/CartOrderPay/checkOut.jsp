<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>Checkout</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>main { margin: 0; }</style>
</head>

<body>
	<jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<!-- main start -->
		<div class="container">
			<div class="order-header"></div>			
			<div class="order-body">
				<div class="order-left">
					<div class="cart-box">
						<div class="cart-box-title"><span class="order-sort">1</span>SHIPPING ADDRESS</div>
						<div class="cart-box-body">
							<div class="address-box">
								<!-- address id -->
								<input type="hidden" id="addressId" class="form-control" name="addressId">
								<!-- first name -->
								<div class="form-group">
									<label for="addressUserfirstname" class="form-label">First Name</label>
									<div class="form-input">
										<input type="text" name="addressUserfirstname" id="addressUserfirstname" class="form-control">
									</div>
								</div>
								<!-- last name -->
								<div class="form-group">
									<label for="addressUserlastname" class="form-label">Last Name</label>
									<div class="form-input">
										<input type="text" name="addressUserlastname" id="addressUserlastname" class="form-control">
									</div>
								</div>
								<!-- email address -->
								<div class="form-group">
									<label for="addressEmail" class="form-label">Email Adress</label>
									<div class="form-input">
										<input type="text" name="addressEmail" id="addressEmail" class="form-control" placeholder="eg:@gmail.com,and so on">
									</div>
								</div>
								<!-- telephone -->
								<div class="form-group">
									<label for="addressTelephone" class="form-label">Telephone</label>
									<div class="form-input">
										<input type="text" name="addressTelephone" id="addressTelephone" class="form-control">
									</div>
								</div>
								<!-- address -->
								<div class="form-group" style="width: 100%">
									<label for="addressDetail" class="form-label required">Address</label>
									<span class="address-detail-tip">Don't forget the apartment No.</span>
									<div class="form-input">
										<input type="text" name="addressDetail" id="addressDetail" class="form-control" placeholder="street address (Dont't forget the apartment)">
									</div>
								</div>
								<!-- country -->
								<div class="form-group">
									<label for="addressCountry" class="form-label">Country</label>
									<div class="form-input">
										<select name="addressCountry" id="addressCountry" class="form-control" value="US"></select>
									</div>
								</div>
								<!-- stateprovinceName -->
								<div class="form-group">
									<label for="addressProvince" class="form-label">State/Province</label>
									<div class="form-input">
										<select name="addressProvince" id="addressProvince" class="form-control"></select>
									</div>
								</div>
								<!-- city -->
								<div class="form-group">
									<label for="addressCity" class="form-label">City</label>
									<div class="form-input">
										<input type="text" name="addressCity" id="addressCity" class="form-control">
									</div>
								</div>
								<!-- Zip/Postal code -->
								<div class="form-group">
									<label for="addressPost" class="form-label">Zip/Postal code</label>
									<div class="form-input">
										<input type="text" name="addressPost" id="addressPost" class="form-control">
									</div>
								</div>
							</div>
							<div class="paypal-error-tip hide">
								<span class="icon tip"></span>
								<div class="text">A match of the shipping Address E-mail, Country, State and Postal Code failed.</div>
							</div>
							<div class="order-address-shipping">
								<div class="name">SHIPPING COST:</div>
								<div class="value">$0</div>
							</div>
						</div>
					</div>
				</div>
				
				<div class="order-right"></div>
			</div>
		</div>
	<!-- main end -->
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<!-- checkout script -->	
	<jsp:include page="./checkout-script.min.jsp" flush="true"></jsp:include>
	<!-- footer nav -->
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<script> addTidio(); </script>
</body>
</html>