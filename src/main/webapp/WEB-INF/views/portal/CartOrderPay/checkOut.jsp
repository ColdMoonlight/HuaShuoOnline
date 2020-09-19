<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>Checkout</title>
	<jsp:include page="../common/processor.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>main { margin: 0; }</style>
	<style>.spinner,.spinner:after,.spinner:before{border-radius:50%}.spinner{position:relative;margin-right:.75rem;color:#fff;width:20px;height:20px;box-shadow:inset 0 0 0 2px;-webkit-transform:translateZ(0);-ms-transform:translateZ(0);transform:translateZ(0)}.spinner:after,.spinner:before{position:absolute;content:"";background:#5469d4}.spinner:before{width:10.4px;height:20.4px;border-radius:20.4px 0 0 20.4px;top:-.2px;left:-.2px;-webkit-transform-origin:10.4px 10.2px;transform-origin:10.4px 10.2px;-webkit-animation:loading 2s infinite ease 1.5s;animation:loading 2s infinite ease 1.5s}.spinner:after{width:10.4px;height:10.2px;border-radius:0 10.2px 10.2px 0;top:-.1px;left:10.2px;-webkit-transform-origin:0 10.2px;transform-origin:0 10.2px;-webkit-animation:loading 2s infinite ease;animation:loading 2s infinite ease}@-webkit-keyframes loading{0%{-webkit-transform:rotate(0);transform:rotate(0)}100%{-webkit-transform:rotate(360deg);transform:rotate(360deg)}}@keyframes loading{0%{-webkit-transform:rotate(0);transform:rotate(0)}100%{-webkit-transform:rotate(360deg);transform:rotate(360deg)}}.card-element-box{position:relative;padding:1rem;margin:.5rem 1rem;background-color:#f5f5f5}.card-element-box .spinner:after,.card-element-box .spinner:before{background-color:#f5f5f5}#card-element{width:100%;height:2.75rem;padding:.75rem;border-radius:.25rem .25rem 0 0;border:1px solid rgba(50,50,93,.1);background-color:#fff}#card-error{margin:.25rem 0 0 0;font-style:italic;font-size:.75rem;text-align:left;color:#ff1671}.card-element-box.mask #card-element{background-color:#f5f5f5;border-color:#f5f5f5}.card-element-box.mask .spinner{display:block;color:#333}#payment-form{display:flex;align-items:center;justify-content:center}#payment-form .spinner:after,#payment-form .spinner:before{background-color:#ccc}#payment-form[disabled]{background-color:#ccc;border-color:#ccc}.card-element-box .spinner{position:absolute;top:50%;left:50%;display:none;transform:translate(-50%,-50%)}.paypal-box{padding:1rem;margin:.5rem 1rem;text-align:center;background-color:#f5f5f5}.paypal-box .paypal-des{margin-top:1rem;font-size:.875rem;color:#545454}.order-payment-item~.order-payment-item{margin-top:.5rem;}</style>
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