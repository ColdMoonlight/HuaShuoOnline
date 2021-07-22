<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<style type="text/css">
.big_ul {
	padding: 0;
}
.big_ul li {
	list-style: none;
}
.big_ul .icon {
	color: #fff;
}
.big_ul .one_ul .icon {
	font-size: 22px;
}
.big_ul .one_ol .icon {
	font-size: 18px;
}
.big_ul>li {
	border: 1px solid #ccc;
	margin-bottom: 10px;
	padding: 10px 20px;
	background-color: #fff;
	border-radius: 5px;
}
.big_ul .one_ul {
	display: none;
	padding: 0;
}
.big_ul .one_ul>li {
	margin-top: 10px;
	margin-left: 0px;
	border: 1px solid #e6e6e6;
	border-radius: 4px;
}
.big_ul .one_top {
	display: flex;
	align-items: center;
	margin-bottom: 10px;
}
.big_ul .one_top .img {
	display: inline-block;
	width: 40px;
	height: 40px;
}
.big_ul .one_top .title {
	display: inline-block;
	margin-left: 10px;
	font-size: 18px;
	text-align: center;
}
.big_ul .one_ul>li .top {
	height: 50px;
	line-height: 50px;
	display: block;
	padding: 0 12px;
	position: relative;
	border-radius: 3px;
}
.big_ul .one_ul .top {
	background-color: #545454;
}
.big_ul .one_ul>li .top p {
	font-size: 15px;
	color: #fff;
	line-height: 50px;
	margin: 0 0 0 -5px;
}
.big_ul .one_ul>li .bot {
	display: none;
}
.big_ul .one_ul>li .img {
	position: absolute;
	right: 0px;
	top: 0px;
	width: 50px;
	height: 50px;
	padding: 20px;
	box-sizing: border-box;
	cursor: pointer;
}
.big_ul .one_ol {
	padding: 10px;
}
.big_ul .one_ol li+li {
	margin-top: 5px;
}
.big_ul .one_ol .top {
	min-height: 50px;
	height: auto !important;
	background-color: #3fb0e2;
}
.big_ul .one_ol .top p {
	line-height: 22px !important;
	padding: 10px 30px 10px 0;
	text-align: justify;
}
.big_ul .one_ol .bot {
	padding: 16px;
}
.big_ul .one_ol .bot p {
	margin: 0;
}
</style>
<ul class="big_ul">
	<li>
		<div class="one_top">
			<img class="img" src="https://cdn.shopify.com/s/files/1/2465/8681/files/before-pic-1.png">
			<span class="title">Question Before Purchase</span>
		</div>
		<ul class="one_ul">
			<li>
				<div class="top two_top">
					<p>About Return Policy</p>
					<span class="img icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>If I don't like it, can I return it? Can I get the full amount?</p>
								<span class="img icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">If you don't want your order or you place the wrong order or
									want a longer length and you would like to exchange the order, you need to
									pay for the return charge, and your refund will be reduced $20 (because of
									the shipping fee we paid at the beginning).</p>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can I have a return label if I return it?</p>
								<span class="img icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We don't provide return label. If you need to return, please
									contact us via email at first, then we will provide the return information.
									You can try to use the USPS to return it.</p>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>If I return the parcel, do I need to pay the returned shipping fee?</p>
								<span class="img icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">If the returning is due to our problems (such as incorrect
									products, the quality problem of products), we will provide a full refund
									for you; If the returning is due to buyer`s problems (such as don't
									like/want, order wrong product/size ), we will remove $20 from your refund
									as the loss of freight and handling fee.</p>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>How long can I get a refund if I return it?</p>
								<span class="img icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Once your return is received and inspected, we will send you an
									email to notify you that we have received your returned item. We will also
									notify you of the approval or rejection of your refund. If approved, your
									refund will be processed, and the refund will automatically be returned to
									your credit card or original method of payments within a certain amount of
									days.</p>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>If I make a wrong order, can I exchange it?</p>
								<span class="img icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">If the parcel has not been shipped, you can send an email to
									Info@luvmehair.com. We will modify the order for you. Once your parcel is
									shipped out, you can try to make an exchange after receiving it.</p>
							</div>
						</li>
					</ol>
				</div>
			</li>			
			<li>
				<div class="top two_top">
					<p>About Us (LUVME HAIR)</p>
					<span class="img icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>Can I be your brand ambassador?</p>
								<span class="img icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">It would be better if you have active social skills and
									outstanding shooting skills. If you meet our requirements, please send an
									email to collaborate@luvmehair.com .</p>
							</div>
						</li>
					</ol>
				</div>
			</li>
		</ul>
	</li>
	<li>
		<div class="one_top">
			<img class="img" src="https://cdn.shopify.com/s/files/1/2465/8681/files/before-pic-1.png">
			<span class="title">Question Before Purchase</span>
		</div>
	</li>
</ul>
