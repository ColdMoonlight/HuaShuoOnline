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
	padding: 16px 20px;
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
	position: relative;
	height: 50px;
	line-height: 50px;
	display: block;
	padding: 0 12px;
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
.big_ul .one_ul .icon {
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
}
.big_ul .one_ol .bot {
	padding: 16px;
}
.big_ul .one_ol .bot p {
	margin: 0;
}
.big_ul .helpful {
	display: flex;
	align-items: center;
	justify-content: flex-end;
	color: #5ea7f7;
}
.big_ul .helpful .text {
	cursor: pointer;
}
.big_ul .link {
	display: inline-block;
	margin-left: 1.5rem;
	color: inherit;
	text-decoration: none;
}
</style>
<!-- <style type="text/css">
.big_ul,
.big_ul ul {
	padding: 0;
}
.big_ul li {
	list-style: none;
}
.big_ul .icon {
	display: none;
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
	padding: 16px 20px;
	background-color: #fff;
	border-radius: 5px;
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
	position: relative;
	display: block;
	padding: 0 12px;
	height: 50px;
	line-height: 50px;
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
.big_ul .one_ul .icon {
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
}
.big_ul .one_ol .bot {
	padding: 16px;
}
.big_ul .one_ol .bot p {
	margin: 0;
}
</style> -->
<ul class="big_ul">
	<li>
		<div class="one_top">
			<img class="img" src="https://cdn.shopify.com/s/files/1/2465/8681/files/before-pic-1.png">
			<span class="title">Question Before Purchase</span>
		</div>
		<ul class="one_ul">
			<li>
				<div class="top two_top">
					<p>About Products</p>
					<span class="icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>Can I ask for small/large cap?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Yeah,we do have small/ large cap,if you do need that cap, pls notes on your order ,for example: i want small cap pls. Normally Our Stock Size is Medium which is 22.8 inches, and we have the combs and elastic band or adjustable straps inside. 
								Our cap size:</br>
								S-52cm =20.4inch</br>
								M-54cm =21.25inch</br>
								L-56cm =22inch</br>
								XL-58cm= 22.8 inch</br>
								</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Is your hair 100% human hair? What is the grade? Where are they from?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We are selling nice virgin hair, which is natural and nice. It is 100% human hair, and top Brazilian virgin hair. </p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Is your wig/hair getting tangled or shedding?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">It could be caused by dry hair. Please make sure to wash & condition your hair at least every 4days or so , you can deep conditioner the hair in a locked bag within 20mins or so, then just wash and dry it, the hair will refresh it’s life, Brazilian virgin hair needs to be combed from time to time. You could go to your stylist for further suggestions. If the hair is wavy or curly style, which we don't suggest combing it. If you have to, please comb it via hands or a wide-tooth brush gently. Tight-tooth brush will ruin the hair’s original shape and make it frizzy and feel like tangled! Please always comb the hair from the ends and work your way up. When you dye the hair with bleach powder, please control the time within 5 minutes. If you dye it with dye cream, you need to control the time within 20 minutes. Otherwise, the hair will be damaged by cream if you leave it too long there, which will lead to shedding. When sleeping, please bond the hair with an elastic band or wear a cap. It will avoid tangling or shapes-changing. After waking up, please remove the band and comb through beginning at the ends and working your way up to the roots. When swimming, we suggest wearing a swimming cap. Because the sea water or pool water is not good for hair, and it will make the hair tangled and rough. It`s better to wash it with warm water, hair shampoo and hair conditioner after swimming.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>What color is the wig of the lace?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We have the introduction of lace color in each product description. Normally for the lace wig, it is Swiss Lace, which comes in medium brown. For the undetectable full lace wig, it is Top Swiss Lace, which comes in Transparent Color, which is suitable for any skin.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can I go swimming with a wig?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Yes, you can go for a swim with the wig. When swimming, we suggest to wear a swimming cap. Because the sea water or pool water is not good for hair, it will make the hair tangle and rough. It`s better to wash it with warm water, with hair shampoo and hair conditioner after swimming.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can your hair be dyed? Can you dyed for me?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Yes,dear friend, we do offer color service now. If you want dye the hair to the color you want, pls leave notes or ask our online service worker, show us the color you want , then we will dye the hair to the color you want, of course, dye the hair would have extra dye fee, hope you know this ahead!</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can your wig use without glue? Can I make ponytail or bun?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">You can try to use it with glue or without glue, but using glue will be more natural looking. Some sisters don`t use glue because their hair is secured with a custom strap and comb in the back and got2b glued spray. So it's very secure and doesn`t move at all. And you can also choose got2b glue gel (black bottle) to install it. As for the ponytail or bun, definitely yes, you can make it.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
					</ol>
				</div>
			</li>			
			<li>
				<div class="top two_top">
					<p>About Shipment</p>
					<span class="icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>How long will my hair be shipped after I place an order?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Our shipping cycle is 1-3 working days. Normal stock: 360 Frontal, Frontal, Bundles, Closure . If the order adds the custom service, such as Pony tail, or 360 Wig, or Blonde wig,or U-part wig, or daily customized wig, which will need more extra 2-4 days to be ready for shipment.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Which express do you use? How long can I receive the parcel?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We use DHL, FedEx or UPS. Generally, the package will be delivered within 3-5 business days in the USA, and 5-8 days in other countries.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Do I need to pay the shipping fee?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Our shipping fee is free.However, there are some areas that need to charge the remote fees 20$.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Do I need to pay the shipping fee?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Our shipping fee is free.However, there are some areas that need to charge the remote fees 20$.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Do I need to pay the customs duty?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">The customs duty is determined by the custom of your country. And it is uncertain to know how much about it.which is depends on your local custom department.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can you provide the Overnight shipping service?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Sorry for that,we did not have the overnight service.The fastest delivery time is 2-3 days.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>I am in a remote area, can you ship it?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Generally, we can ship to most of the countries and regions worldwide, but individual places may be charged remote fees. If the zip code in the area can not be found on the express delivery system, we will not be able to ship it.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can I use Po.box as the shipping address? Or billing address?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We don't accept PO.box(including FPO or APO) as the shipping address, because the Express(DHL/FedEx/UPS) can't deliver and we only accept the physical address as shipping address.However, you can use PO.box as billing address.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can you provide the Overnight shipping service?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Sorry for that,we did not have the overnight service.The fastest delivery time is 2-3 days.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
					</ol>
				</div>
			</li>
			<li>
				<div class="top two_top">
					<p>About Payment</p>
					<span class="icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>When I pay via PayPal, do I have to have a PayPal account? Can I use credit cards?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">PayPal account is not necessary.You can choose the "Pay with Credit Card".</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Which payment methods can I use?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We accept the payment methods as Paypal and Credit Card. It is not necessary to have a PayPal account to order, you can pay with Credit/Debit Card directly. If you have any payment problems, please contact with us: team@megalookemail.com.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Why is my card declined?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Sometimes when your card is expired, insufficient balance or poor credit which may have a record of Chargeback or others will lead to card declined when paying. So we suggest customers not take a dispute for no reasons, because your credit record will be affected, and your next shopping will be declined. When your card is declined, you can call your bank for the problem. Or you can try another card. If you still have problems, please send an email to us : team@megalookemail.com.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>If I pay on your website, is my information safe?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We are sure that our website is legal , which has been certified by the card organization. So please don`t worry about that. Your payment information is kept by your bank or card organization, but not saved by us. We only use your shipping info for delivery. Your information is safe and we will keep your information confidential. If you have any problems, please feel free to contact us：team@megalookemail.com.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Do I need to pay the customs duty?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">The customs duty is determined by the custom of your country. And it is uncertain to know how much about it.which is depends on your local custom department.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can you send me an invoice?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Yes, we can send you the invoice if you need, just feel free to contact us via email or whatsapp or online service.normally we will reply you within 12 hours.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
					</ol>
				</div>
			</li>
			<li>
				<div class="top two_top">
					<p>About Us (MEGALOOK HAIR)</p>
					<span class="icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>Can I be your brand ambassador?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">It would be better if you have active social skills and outstanding shooting skills. If you meet our requirements, please send an email to : megalookhairreview@gmail.com .</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
					</ol>
				</div>
			</li>
			<li>
				<div class="top two_top">
					<p>About Wholesale</p>
					<span class="icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>Can I have a wholesale price?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We are very pleased to offer wholesale price for you. But it need over($500). Please send email to team@megalookemail.com.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Do you have any conditions for your wholesale? What is the minimum order quantity?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We have no more conditions, as long as your order exceeds $500.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Can I be your distributor?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Yes，we hope to cooperate with you to develop a better business.Please send email to megalookhairreview@gmail.com.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
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
			<span class="title">Question After Purchase</span>
		</div>
		<ul class="one_ul">
			<li>
				<div class="top two_top">
					<p>Track Order</p>
					<span class="icon plus"></span>
				</div>
				<div class="bot">
					<ol class="one_ol">
						<li>
							<div class="top three_top">
								<p>Why haven't I received my parcel yet? Where is my order? Can I have a tracking number?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Once the parcel has been shipped. We will post the tracking number on the website.You can check the status.If not,you can send us a e-mail. Our colleague will answer you.
								</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Why did I purchased two or there items in my order, but only 1pc is displayed in the shipment status?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We ship all 2/3 items of your order in one parcel, so the shipment only displays 1pc. That doesn't mean only 1 item in your parcel.Please don't worry.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>If I'm not at home, how can I sign for my package? Can I have a delivery service without signature?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Yes, you can. You can leave a note in your order, or call DHL/FedEx/UPS to apply the service. After you applied the service without signature,if the package is lost or stolen, we do not take any responsibility.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>Why the shipment status shows that I have signed. But I did not receive the parcel yet.</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Once that happens, it means someone has signed the package for you. It may be your neighbor or family and friends. Please confirm it first. If not, please contact us.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>When can I receive my order?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">Normally, your order can delivery within 2-4 business days, if weekend or holiday or Customized wig，it maybe have a 2-4days delay. If want to track order status, please go to this page: https://www.megalook.com/</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
						<li>
							<div class="top three_top">
								<p>I make two orders at the same time. Can I receive a special gift?</p>
								<span class="icon plus"></span>
							</div>
							<div class="bot">
								<p class="text1">We feel very sorry that this special offer has expired, please continue to pay attention to our website, we will post other promotions on our products details pages or social media.</p>
								<div class="helpful">
									<span class="text">Helpful(<span class="data">23</span>)</span>
									<a class="link" href="mailto:team@megalookemail.com?subject=Question%20for%20Can%20I%20ask%20for%20small/large%20cap?&amp;body=Hi,%20I%20still%20have%20question%20about%20this,%20"">Still have problem?</a>
								</div>
							</div>
						</li>
					</ol>
				</div>
			</li>
		</ul>
	</li>
</ul>
