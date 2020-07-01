<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!DOCTYPE html>
<html>

<head>
	<title>Checkout</title>
	<jsp:include page="../common/header.jsp" flush="true"></jsp:include>
	<style>main { margin: 0; }</style>
</head>

<body>
	<jsp:include page="../layout/header.jsp" flush="true"></jsp:include>
	<main>
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
	</main>
	<jsp:include page="../layout/footer.jsp" flush="true"></jsp:include>
	<jsp:include page="../common/footer.jsp" flush="true"></jsp:include>
	<script>
		// get order list
		function getProductOrderList(callback) {
			$.ajax({
				url: '${APP_PATH}/MlfrontOrder/getNowOrderDetail',
				type: 'get',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend);
					}
				}
			});
		}
		// get province data		
		function getProvinceData(reqData, callback) {
			$.ajax({
				url: '${APP_PATH}/MlfrontAddress/getAreafreightMoney',
				data: JSON.stringify(reqData),
				async: false,
				type: 'post',
				dataType: 'json',
				contentType: 'application/json',
				async: false,
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend);
					}					
				}
			});
		}
		// get user info
		function getUserInfo(callback) {
			$.ajax({
				url: '${APP_PATH}/MlfrontAddress/getOneMlfrontAddressDetailByUinfo',
				type: 'post',
				dataType: 'json',
				async: false,
				success: function (data) {
					callback && callback(data.extend);
				}
			});
		}
		// update order product number
		function updateOrderNum(el, num, callback) {
			var targetData = el.parents('.order-item').data('orderitem') || null,
				reqData = {
					"orderitemId": parseInt(targetData.orderitemId),
					"orderitemPskuNumber": num
				};

			$.ajax({
				url: '${APP_PATH}/MlfrontOrder/updateOrderItemNum',
				data: JSON.stringify(reqData),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						updateProructNumberInCart();
						targetData.orderitemPskuNumber = num;
						el.parents('.order-item').data('orderitem', targetData);
						callback && callback();
						updateProductNumSuccessModal();
					} else {
						el.find('.product-num').val(targetData.orderitemPskuNumber);
						updateProductNumFailModal();
					}
				},
				error: function () {
					el.find('.product-num').val(targetData.cartitemProductNumber);
					updateProductNumFailModal();
				}
			});
		}
		// delete order product
		function deleteOrderProduct(el, callback) {
			var targetData = el.data('orderitem') || null,
				reqData = {
					"orderitemId": parseInt(targetData.orderitemId)
				};

			$.ajax({
				url: '${APP_PATH}/MlfrontOrder/delOrderItem',
				data: JSON.stringify(reqData),
				type: "post",
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					el.remove();
					if (!$('.cart-item').length) goToCartList();
					callback && callback();
					deleteProductSuccessModal();
				},
				error: function () {
					el.find('.product-num').val(targetData.cartitemProductNumber);
					deleteProductFailModal();
				}
			});
		}
		// save user address
		function orderSaveAddress(reqData, callback) {
			$.ajax({
				url: '${APP_PATH}/MlfrontAddress/save',
				type: 'post',
				dataType: 'json',
				data: JSON.stringify(reqData),
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend.mlfrontAddress);
					} else {
						sysModalTip();
					}
				},
				error: function () {
					sysModalTip();
				}
			});
		}
		// order pay
		function orderPay(reqData, callback) {
			$.ajax({
				url: '${APP_PATH}/MlfrontOrder/orderToPayInfo',
				data: JSON.stringify(reqData),
				type: 'post',
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback && callback();
					} else {
						sysModalTip();
					}
				},
				error: function(err) {
					sysModalTip();
				}
			});
		}
		// country combine with province
		function countryCombineWithProvince() {
			getProvinceData({
				"addressCountry": $('#addressCountry').find('option:checked').data('value')
			}, function(data) {
				var money = data.areafreightMoney,
					provinceList = data.mlPaypalStateprovinceList;

				$('.order-address-shipping').data('shipping', money).find('.value').text('$' + money);

				if (provinceList && provinceList.length > 0) {
					renderProvince(provinceList);
					$('#addressProvince').data('status', false);

					hasProvince = true;
					$("#addressProvince").parents('.form-group').show();
					$("#addressCountry").parents('.form-group').css("width", "50%");
				} else {
					$('#addressProvince').val('').data('status', true);

					hasProvince = false;
					$("#addressProvince").parents('.form-group').hide();
					$("#addressCountry").parents('.form-group').css("width", "100%");
				}
			});
		}
		// get current time
		function getTime() {
			var date = new Date(),
				year = date.getFullYear(),
				month = date.getMonth() + 1,
				day = date.getDate(),
				hours = date.getHours(),
				minutes = date.getMinutes(),
				seconds = date.getSeconds();
			return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + (seconds < 10 ? '0' + seconds : seconds);
		}
		// cal orderList data
		function calOrderList () {
			var couponData = $('.order-coupon-group').data('coupon');
			var resData = {
					prototal: 0,
					subtotal: 0,
					shipping: $('.order-address-shipping').data('shipping') || 0,
					coupon: 0,
				};

			$('.order-item').each(function(idx, item) {
				var $data = $(item).data('orderitem');

				var orderitemPrice = parseFloat((parseFloat((($data.orderitemProductOriginalprice + parseInt($data.orderitemPskuMoneystr || 0)) * ($data.orderitemProductAccoff) / 100).toFixed(2)) * $data.orderitemPskuNumber).toFixed(2));
				// bind single-product discount
				if (couponData && couponData.couponProductOnlyTypeifHave && couponData.mlbackCouponOne && (couponData.mlbackCouponOne.couponProductonlyPidstr == $data.orderitemPid)) {
					if (couponData.mlbackCouponOne.couponType == '0') {
						resData.coupon = couponData.mlbackCouponOne.couponPrice;
					} else {
						resData.coupon = parseFloat((orderitemPrice * couponData.mlbackCouponOne.couponPriceoff / 100).toFixed(2));
					}
				}

				resData.prototal += orderitemPrice;
			});
			
			// coupon code
			if (couponData && !couponData.mlbackCouponOne) {
				resData.coupon = 0;
				$('.order-coupon-tip').html('<p>Code invalid !</p>');
			}
			
			if (couponData && couponData.mlbackCouponOne) {
				if (!couponData.couponProductOnlyTypeifHave) {
					if (couponData.mlbackCouponOne.couponProductonlyType) {
						$('.order-coupon-tip').html('<p>Code invalid !</p>');
					} else {
						if (couponData.mlbackCouponOne.couponType == '0') {
							if (!couponData.mlbackCouponOne.couponPriceBaseline) {
								resData.coupon = couponData.mlbackCouponOne.couponPrice;
								$('.order-coupon-tip').html('<p><i style="color: #f00">'+ couponData.mlbackCouponOne.couponCode +'</i> Has been used ! </p>');
							} else {
								if (resData.prototal >= parseFloat(couponData.mlbackCouponOne.couponPriceBaseline)) {
									resData.coupon = couponData.mlbackCouponOne.couponPrice;
									$('.order-coupon-tip').html('<p><i style="color: #f00">'+ couponData.mlbackCouponOne.couponCode +'</i> Has been used ! </p>');
								} else {
									resData.coupon = 0;
									$('.order-coupon-tip').html('<p>The minimum usage price of this coupon is + <i style="color: #f00">$'+ couponData.mlbackCouponOne.couponPriceBaseline +'<i></p>');
								}
							}
						}

						if (couponData.mlbackCouponOne.couponType == '1') {
							if (!couponData.mlbackCouponOne.couponPriceBaseline) {
								resData.coupon = parseFloat((resData.prototal * couponData.mlbackCouponOne.couponPriceoff / 100).toFixed(2));
								$('.order-coupon-tip').html('<p><i style="color: #f00">'+ couponData.mlbackCouponOne.couponCode +'</i> Has been used ! </p>');
							} else {
								if (resData.prototal >= parseFloat(couponData.mlbackCouponOne.couponPriceBaseline)) {
									resData.coupon = parseFloat((resData.prototal * couponData.mlbackCouponOne.couponPriceoff / 100).toFixed(2));
									$('.order-coupon-tip').html('<p><i style="color: #f00">'+ couponData.mlbackCouponOne.couponCode +'</i> Has been used ! </p>');
								} else {
									resData.coupon = 0;
									$('.order-coupon-tip').html('<p>The minimum usage price of this coupon is + <i style="color: #f00">$'+ couponData.mlbackCouponOne.couponPriceBaseline +'<i></p>');
								}
							}
						}
					}
					
				} else {
					var singProductId = couponData.mlbackCouponOne.couponProductonlyPidstr;
					if (singProductId && $('.order-list').data('productidarr').indexOf(parseInt(singProductId)) > -1) {
						$('.order-coupon-tip').html('<p><i style="color: #f00">'+ couponData.mlbackCouponOne.couponCode +'</i> Has been used ! </p>');
					} else {
						$('.order-coupon-tip').html('<p><i style="color: #f00">'+ couponData.mlbackCouponOne.couponCode +'</i> The coupon is invalid for the purchase of products, it is only applicable to specific products ! </p>');
					}
				}
			}

			resData.subtotal = resData.prototal + resData.shipping - resData.coupon;

			return resData;
		}
		// reset order  cal
		function resetOrderCal() {
			var calOrder = calOrderList();
			$('.order-cal-prototal').text('$' + (calOrder.prototal).toFixed(2));
			$('.order-cal-shipping').text('$'+ calOrder.shipping);
			$('.order-cal-coupon').text('-$'+ calOrder.coupon);
			$('.order-cal-subtotal').text('$'+ (calOrder.subtotal).toFixed(2));
		}
		// render country
		function renderCountry() {
			var htmlStr = '',
				countryList = [{name:"United States",nickname:"US"},{name:"United Kingdom",nickname:"GB"},{name:"Canada",nickname:"CA"},{name:"Nigeria",nickname:"NG"},{name:"Australia",nickname:"AU"},{name:"South Africa",nickname:"ZA"},{name:"Germany",nickname:"DE"},{name:"Kenya",nickname:"KE"},{name:"Spain",nickname:"ES"},{name:"United Arab Emirates",nickname:"AE"},{name:"Afghanistan",nickname:"AF"},{name:"France",nickname:"FR"},{name:"Åland Islands",nickname:"AX"},{name:"Albania",nickname:"AL"},{name:"Algeria",nickname:"DZ"},{name:"American Samoa",nickname:"AS"},{name:"Andorra",nickname:"AD"},{name:"Angola",nickname:"AO"},{name:"Anguilla",nickname:"AI"},{name:"Antarctica",nickname:"AQ"},{name:"Antigua and Barbuda",nickname:"AG"},{name:"Argentina",nickname:"AR"},{name:"Armenia",nickname:"AM"},{name:"Aruba",nickname:"AW"},{name:"Austria",nickname:"AT"},{name:"Azerbaijan",nickname:"AZ"},{name:"Bahamas",nickname:"BS"},{name:"Bahrain",nickname:"BH"},{name:"Bangladesh",nickname:"BD"},{name:"Barbados",nickname:"BB"},{name:"Belarus",nickname:"BY"},{name:"Belgium",nickname:"BE"},{name:"Belize",nickname:"BZ"},{name:"Benin",nickname:"BJ"},{name:"Bermuda",nickname:"BM"},{name:"Bhutan",nickname:"BT"},{name:"Bolivia",nickname:"BO"},{name:"Bosnia and Herzegovina",nickname:"BA"},{name:"Botswana",nickname:"BW"},{name:"Bouvet Island",nickname:"BV"},{name:"Brazil",nickname:"BR"},{name:"British Indian Ocean Territory",nickname:"IO"},{name:"British Virgin Islands",nickname:"VG"},{name:"Brunei",nickname:"BN"},{name:"Bulgaria",nickname:"BG"},{name:"Burkina Faso",nickname:"BF"},{name:"Burundi",nickname:"BI"},{name:"Cambodia",nickname:"KH"},{name:"Cameroon",nickname:"CM"},{name:"Cape Verde",nickname:"CV"},{name:"Cayman Islands",nickname:"KY"},{name:"Central African Republic",nickname:"CF"},{name:"Chad",nickname:"TD"},{name:"Chile",nickname:"CL"},{name:"China",nickname:"CN"},{name:"Christmas Island",nickname:"CX"},{name:"Cocos (Keeling) Islands",nickname:"CC"},{name:"Colombia",nickname:"CO"},{name:"Comoros",nickname:"KM"},{name:"Congo - Brazzaville",nickname:"CG"},{name:"Congo - Kinshasa",nickname:"CD"},{name:"Cook Islands",nickname:"CK"},{name:"Costa Rica",nickname:"CR"},{name:"Côte d’Ivoire",nickname:"CI"},{name:"Croatia",nickname:"HR"},{name:"Cuba",nickname:"CU"},{name:"Cyprus",nickname:"CY"},{name:"Czech Republic",nickname:"CZ"},{name:"Denmark",nickname:"DK"},{name:"Djibouti",nickname:"DJ"},{name:"Dominica",nickname:"DM"},{name:"Dominican Republic",nickname:"DO"},{name:"Ecuador",nickname:"EC"},{name:"Egypt",nickname:"EG"},{name:"El Salvador",nickname:"SV"},{name:"Equatorial Guinea",nickname:"GQ"},{name:"Eritrea",nickname:"ER"},{name:"Estonia",nickname:"EE"},{name:"Ethiopia",nickname:"ET"},{name:"Falkland Islands",nickname:"FK"},{name:"Faroe Islands",nickname:"FO"},{name:"Fiji",nickname:"FJ"},{name:"Finland",nickname:"FI"},{name:"French Guiana",nickname:"GF"},{name:"French Polynesia",nickname:"PF"},{name:"French Southern Territories",nickname:"TF"},{name:"Gabon",nickname:"GA"},{name:"Gambia",nickname:"GM"},{name:"Georgia",nickname:"GE"},{name:"Ghana",nickname:"GH"},{name:"Gibraltar",nickname:"GI"},{name:"Greece",nickname:"GR"},{name:"Greenland",nickname:"GL"},{name:"Grenada",nickname:"GD"},{name:"Guadeloupe",nickname:"GP"},{name:"Guam",nickname:"GU"},{name:"Guatemala",nickname:"GT"},{name:"Guernsey",nickname:"GG"},{name:"Guinea",nickname:"GN"},{name:"Guinea-Bissau",nickname:"GW"},{name:"Guyana",nickname:"GY"},{name:"Haiti",nickname:"HT"},{name:"Heard &amp; McDonald Islands",nickname:"HM"},{name:"Honduras",nickname:"HN"},{name:"Hong Kong SAR China",nickname:"HK"},{name:"Hungary",nickname:"HU"},{name:"Iceland",nickname:"IS"},{name:"India",nickname:"IN"},{name:"Indonesia",nickname:"ID"},{name:"Iran",nickname:"IR"},{name:"Iraq",nickname:"IQ"},{name:"Ireland",nickname:"IE"},{name:"Isle of Man",nickname:"IM"},{name:"Israel",nickname:"IL"},{name:"Italy",nickname:"IT"},{name:"Jamaica",nickname:"JM"},{name:"Japan",nickname:"JP"},{name:"Jersey",nickname:"JE"},{name:"Jordan",nickname:"JO"},{name:"Kazakhstan",nickname:"KZ"},{name:"Kiribati",nickname:"KI"},{name:"Kuwait",nickname:"KW"},{name:"Kyrgyzstan",nickname:"KG"},{name:"Laos",nickname:"LA"},{name:"Latvia",nickname:"LV"},{name:"Lebanon",nickname:"LB"},{name:"Lesotho",nickname:"LS"},{name:"Liberia",nickname:"LR"},{name:"Libya",nickname:"LY"},{name:"Liechtenstein",nickname:"LI"},{name:"Lithuania",nickname:"LT"},{name:"Luxembourg",nickname:"LU"},{name:"Macau SAR China",nickname:"MO"},{name:"Macedonia",nickname:"MK"},{name:"Madagascar",nickname:"MG"},{name:"Malawi",nickname:"MW"},{name:"Malaysia",nickname:"MY"},{name:"Maldives",nickname:"MV"},{name:"Mali",nickname:"ML"},{name:"Malta",nickname:"MT"},{name:"Marshall Islands",nickname:"MH"},{name:"Martinique",nickname:"MQ"},{name:"Mauritania",nickname:"MR"},{name:"Mauritius",nickname:"MU"},{name:"Mayotte",nickname:"YT"},{name:"Mexico",nickname:"MX"},{name:"Micronesia",nickname:"FM"},{name:"Moldova",nickname:"MD"},{name:"Monaco",nickname:"MC"},{name:"Mongolia",nickname:"MN"},{name:"Montenegro",nickname:"ME"},{name:"Montserrat",nickname:"MS"},{name:"Morocco",nickname:"MA"},{name:"Mozambique",nickname:"MZ"},{name:"Myanmar (Burma)",nickname:"MM"},{name:"Namibia",nickname:"NA"},{name:"Nauru",nickname:"NR"},{name:"Nepal",nickname:"NP"},{name:"Netherlands",nickname:"NL"},{name:"Netherlands Antilles",nickname:"AN"},{name:"New Caledonia",nickname:"NC"},{name:"New Zealand",nickname:"NZ"},{name:"Nicaragua",nickname:"NI"},{name:"Niger",nickname:"NE"},{name:"Niue",nickname:"NU"},{name:"Norfolk Island",nickname:"NF"},{name:"Northern Mariana Islands",nickname:"MP"},{name:"North Korea",nickname:"KP"},{name:"Norway",nickname:"NO"},{name:"Oman",nickname:"OM"},{name:"Pakistan",nickname:"PK"},{name:"Palau",nickname:"PW"},{name:"Palestinian Territories",nickname:"PS"},{name:"Panama",nickname:"PA"},{name:"Papua New Guinea",nickname:"PG"},{name:"Paraguay",nickname:"PY"},{name:"Peru",nickname:"PE"},{name:"Philippines",nickname:"PH"},{name:"Pitcairn Islands",nickname:"PN"},{name:"Poland",nickname:"PL"},{name:"Portugal",nickname:"PT"},{name:"Puerto Rico",nickname:"PR"},{name:"Qatar",nickname:"QA"},{name:"Réunion",nickname:"RE"},{name:"Romania",nickname:"RO"},{name:"Russia",nickname:"RU"},{name:"Rwanda",nickname:"RW"},{name:"Saint Barthélemy",nickname:"BL"},{name:"Saint Helena",nickname:"SH"},{name:"Saint Kitts and Nevis",nickname:"KN"},{name:"Saint Lucia",nickname:"LC"},{name:"Saint Martin",nickname:"MF"},{name:"Saint Pierre and Miquelon",nickname:"PM"},{name:"Samoa",nickname:"WS"},{name:"San Marino",nickname:"SM"},{name:"São Tomé and Príncipe",nickname:"ST"},{name:"Saudi Arabia",nickname:"SA"},{name:"Senegal",nickname:"SN"},{name:"Serbia",nickname:"RS"},{name:"Seychelles",nickname:"SC"},{name:"Sierra Leone",nickname:"SL"},{name:"Singapore",nickname:"SG"},{name:"Slovakia",nickname:"SK"},{name:"Slovenia",nickname:"SI"},{name:"Solomon Islands",nickname:"SB"},{name:"Somalia",nickname:"SO"},{name:"South Georgia &amp; South Sandwich Islands",nickname:"GS"},{name:"South Korea",nickname:"KR"},{name:"Sri Lanka",nickname:"LK"},{name:"St. Vincent &amp; Grenadines",nickname:"VC"},{name:"Sudan",nickname:"SD"},{name:"Suriname",nickname:"SR"},{name:"Svalbard and Jan Mayen",nickname:"SJ"},{name:"Swaziland",nickname:"SZ"},{name:"Sweden",nickname:"SE"},{name:"Switzerland",nickname:"CH"},{name:"Syria",nickname:"SY"},{name:"Taiwan",nickname:"TW"},{name:"Tajikistan",nickname:"TJ"},{name:"Tanzania",nickname:"TZ"},{name:"Thailand",nickname:"TH"},{name:"Timor-Leste",nickname:"TL"},{name:"Togo",nickname:"TG"},{name:"Tokelau",nickname:"TK"},{name:"Tonga",nickname:"TO"},{name:"Trinidad and Tobago",nickname:"TT"},{name:"Tunisia",nickname:"TN"},{name:"Turkey",nickname:"TR"},{name:"Turkmenistan",nickname:"TM"},{name:"Turks and Caicos Islands",nickname:"TC"},{name:"Tuvalu",nickname:"TV"},{name:"Uganda",nickname:"UG"},{name:"Ukraine",nickname:"UA"},{name:"Uruguay",nickname:"UY"},{name:"U.S. Outlying Islands",nickname:"UM"},{name:"U.S. Virgin Islands",nickname:"VI"},{name:"Uzbekistan",nickname:"UZ"},{name:"Vanuatu",nickname:"VU"},{name:"Vatican City",nickname:"VA"},{name:"Venezuela",nickname:"VE"},{name:"Vietnam",nickname:"VN"},{name:"Wallis and Futuna",nickname:"WF"},{name:"Western Sahara",nickname:"EH"},{name:"Yemen",nickname:"YE"},{name:"Zambia",nickname:"ZM"},{name:"Zimbabwe",nickname:"ZW"}];
			for (var i = 0, len = countryList.length; i < len; i++) {
				htmlStr += '<option data-value="' + countryList[i].nickname + '" value="' + countryList[i].name + '">' + countryList[i].name + '</option>';
			}
			$('#addressCountry').html(htmlStr);
		}
		// redner province
		function renderProvince(data) {
			var htmlStr = '<option value="state">State</option>',
				defaultValue = $('#addressProvince').data('value');
			for (var i = 0, len = data.length; i < len; i += 1) {
				htmlStr += '<option value="' + data[i].stateprovinceName + '"'+ (defaultValue == data[i].stateprovinceName ? "selected" : "") +'>' + data[i].stateprovinceName + '</option>';
			}

			$('#addressProvince').html(htmlStr);
		}
		// renderd order list
		function renderOrderList(data) {
			var $orderList = $('<div class="order-list" />'),
				orderProductIdArr = [],
				orderItemIdArr = [],
				orderProductNumArr = [];
			data.forEach(function(item, idx) {
				var orderSkuList = '',
					optionArr = item.orderitemPskuIdnamestr.split(','),
					skuNameArr = item.orderitemPskuName.split(',');
				
				optionArr.forEach(function(item, idx) {
					orderSkuList += '<div class="order-sku-list-item">' +
						'<span class="name">'+ item +' :</span>' +
						'<span class="value">'+ skuNameArr[idx] +'</span>' +
					'</div>';
				});

				orderProductIdArr.push(item.orderitemPid);
				orderItemIdArr.push(item.orderitemId);
				orderProductNumArr.push(item.orderitemPskuNumber);

				var productLink = item.orderitemPseo ? ('${APP_PATH}/'+ item.orderitemPseo +'.html') : 'javascript:;';
				$orderList.append($('<div class="order-item">' +
					'<a href="'+ productLink +'"><img class="order-img" src="'+ item.orderitemProductMainimgurl +'"></a>' +
					'<div class="order-product">' +
						'<a class="order-product-name" href="'+ productLink +'">'+ item.orderitemPname +'</a>' +
						'<div class="order-sku-list">'+ orderSkuList +'</div>' +
						'<div class="order-product-num">' +
							'<div class="order-product-price">' +
								'<span class="product-now-price">$'+ (item.orderitemProductOriginalprice && item.orderitemProductAccoff ? ((item.orderitemProductOriginalprice  + parseFloat(item.orderitemPskuMoneystr)) * item.orderitemProductAccoff / 100) : 0).toFixed(2) +'</span>' +
								'<span class="product-define-price">$'+ (item.orderitemProductOriginalprice || 0).toFixed(2) +'</span>' +
							'</div>' +
							'<span class="icon delete product-delete">' + '</span>' +
							'<div class="product-qty">' +
								'<span class="group-addon product-sub"><i class="icon sub"></i></span>' +
								'<input type="text" disabled class="product-num" value="' + (item.orderitemPskuNumber) + '" />' +
								'<span class="group-addon product-add"><i class="icon plus"></i></span>' +
							'</div>' +
						'</div>' +
					'</div>' +
				'</div>').data('orderitem', item));
			});
			$orderList.data('itemidarr', orderItemIdArr.join(',')).data('productidarr', orderProductIdArr.join(',')).data('itemnumarr', orderProductNumArr.join(','))
			var $cartReviewBox = $('<div class="cart-box">'+
					'<div class="cart-box-title"><span class="order-sort">2</span>Checkout Review</div>'+
					'<div class="cart-box-body">'+
						'<div class="cart-box-time">'+ getTime() +'</div>' +
					'</div>'+
				'</div>');
			$cartReviewBox.find('.cart-box-body').append($orderList);

			$('main .order-left').append($cartReviewBox);
		}
		// render order couopons
		function renderOrderCoupons() {
			var $cartCouponBox = $('<div class="cart-box">'+
					'<div class="cart-box-title"><span class="order-sort">5</span>DISCOUNT CODES</div>'+
					'<div class="cart-box-body">'+
						'<div class="order-coupons">'+
							'<div class="order-coupon-list"></div>'+
							'<div class="order-coupon-group">'+
								'<input type="text" placeholder="Please enter code" />'+
								'<button id="order-check-coupon" class="btn btn-gray">check it</button>'+
							'</div>'+
							'<div class="order-coupon-tip"></div>'+
						'</div>'+
					'</div>'+
				'</div>');
			$('main .order-right').append($cartCouponBox);
		}
		// render order payment method
		function renderOrderPaymentMethod() {
			var $cartPaymentBox = $('<div class="cart-box">'+
					'<div class="cart-box-title"><span class="order-sort">4</span>PAYMENT METHOD</div>'+
					'<div class="cart-box-body">'+
						'<div class="order-payment" data-pay="0">' +
							'<div class="order-payment-item custom-check">'+
								'<input type="radio" name="payment" id="payment-paypal" checked value="0">' +
								'<label for="payment-paypal">' +
									'<img src="${APP_PATH}/static/pc/img/paypal-1.png">' +
									'<span>Pay with PayPal account</span>' +
								'</label>' +
							'</div>' +
							'<div class="order-payment-item custom-check">'+
								'<input type="radio" name="payment" id="payment-paypalcard" value="1">' +
								'<label for="payment-paypalcard">' +
									'<img src="${APP_PATH}/static/pc/img/paypal-2.png">' +
									'<span>Credit card via PayPal</span>' +
								'</label>' +
							'</div>' +
						'</div>'+
					'</div>'+
				'</div>');
			$('main .order-right').append($cartPaymentBox);
		}
		// render order buyer message
		function renderOrderBuyerMsg() {
			var $cartBuyerMsgBox = $('<div class="cart-box">'+
					'<div class="cart-box-title"><span class="order-sort">5</span>ADDITIONAL INFORMATION</div>'+
					'<div class="cart-box-body">'+
						'<div class="order-buyer-msg"><textarea rows="4" placeholder="Buyer message"></textarea></div>'+
					'</div>'+
				'</div>');
			$('main .order-right').append($cartBuyerMsgBox);
		}
		// render order cal
		function rednerOrderCal() {
			var calOrder = calOrderList();
			var $cartCalBox = $('<div class="cart-box">'+
					// '<div class="cart-box-title"></div>'+
					'<div class="cart-box-body">'+
						'<div class="order-cal">' +
							'<div class="order-cal-item"><span class="name">prototal</span><span class="value order-cal-prototal">'+ (calOrder.prototal).toFixed(2) +'</span></div>' +
							'<div class="order-cal-item"><span class="name">shipping</span><span class="value order-cal-shipping">$'+ calOrder.shipping +'</span></div>' +
							'<div class="order-cal-item"><span class="name">coupon</span><span class="value order-cal-coupon">-$'+ calOrder.coupon +'</span></div>' +
							'<div class="order-cal-item"><span class="name">subtotal</span><span class="value order-cal-subtotal">$'+ (calOrder.subtotal).toFixed(2) +'</span></div>' +
							'<div class="order-cal-btn"><a href="javascript:;" id="pay-now" class="btn btn-no">Pay Securely Now</a></div>' +
						'</div>'+
					'</div>'+
				'</div>');
			$('main .order-right').append($cartCalBox);
		}
		// check user input address info
		function checkInputAdressInfo() {
			var flag = true;
			for(var idx = 0, len = $('.address-box .form-group').length; idx < len; idx += 1) {
				var item = $('.address-box .form-group')[idx];
				if ($(item).find('.form-control').data('status')) continue;
				if (!$(item).find('.form-control').val() || $(item).find('.form-control').val() == 'state') {
					mlModalTip('Address information <i style="color: #f00">'+ $(item).find('.form-label').text() +"</i> can't be empty !");
					$(item).find('.form-control').focus();
					flag = false;
					break;
				}
			}
			return flag;
		}
		// check couopon code
		function checkCouponCode(reqData, callback) {
			$.ajax({
				url: '${APP_PATH}/MlbackCoupon/getOneMlbackCouponDetailByCode',
				data: JSON.stringify(reqData),
				type: 'post',
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.code == 100) {
						callback && callback(data.extend);
					} else {
						sysModalTip();
					}
				},
				error: function(err) {
					sysModalErrorTip (err);
				}
			});
		}
		// get order address
		function getOrderAddress() {
			var addressData = {};
			$('.address-box .form-control').each(function(idx, item) {
				if (item.name == 'addressCountry') addressData['addressCountryCode'] = $(item).find('option:checked').data('value');
				addressData[item.name] = (item.value || '').trim();
			});
			return addressData;
		}
		// init order address
		function initOrderAddress(data) {
			$('.address-box .form-control').each(function(idx, item) {
				if (item.name == 'addressProvince') $(item).data('value', data[item.name]);
				$(item).val(data[item.name]);
			});
		}
		// get order pay info
		function getOrderPayInfo() {
			var couponData = $('.order-coupon-group').data('coupon');
			return {
				"orderId": $('.order-list').data('orderid') || null,
				"orderOrderitemidstr": $('.order-list').data('itemidarr'),
				"orderCouponId": (couponData && couponData.mlbackCouponOne.couponId) || '',
				"orderCouponCode": (couponData && couponData.mlbackCouponOne.couponCode) || '',
				"orderPayPlate": $('input[name="payment"]:checked').val(),
				"orderProNumStr": $('.order-list').data('itemnumarr'),
				"orderBuyMess": $('.order-buyer-msg textarea').val(),
				"addressinfoId": $('#addressId').val(),	
			}
		}
		// initial order for checkout 
		function initialOrder() {
			// 1
			renderCountry();
			// userinfo initial
			getUserInfo(function(data) {
				var addressData = data.mlfrontAddressOne;
				if (data.usertype) {
					addressData && initOrderAddress(addressData);
					// $('.order-address-shipping').data('shipping', data.areafreightMoney).find('.value', '$' + data.areafreightMoney);
				}
				countryCombineWithProvince();
			});
			// 2
			getProductOrderList(function(data) {
				var orderListData = data.mlfrontOrderItemList;
				if (!orderListData.length) {
					mlModalTip("Don't have to pay for goods, please to add items in the shopping cart, and then to pay !");
					goToCartList();
					return ;
				}

				renderOrderList(orderListData);
				$('.order-list').data('orderid', data.orderId);
			});
			renderOrderCoupons(); // 3
			renderOrderPaymentMethod(); // 4
			renderOrderBuyerMsg(); // 5
			rednerOrderCal(); // 6
		}
		var hasProvince = true;
		// initial
		initialOrder();
		// event
		$("#addressCountry").on('change', function() {
			countryCombineWithProvince();
			resetOrderCal();
		});
		// add product
		$(document.body).on('click', '.product-add', function() {
			productAdd($(this), function(el, num) {
				updateOrderNum(el, num, resetOrderCal);
			});
		});
		// sub product
		$(document.body).on('click', '.product-sub', function() {
			productSub($(this), function(el, num) {
				updateOrderNum(el, num, resetOrderCal);
			});
		});
		// delete product
		$(document.body).on('click', '.product-delete', function() {
			deleteOrderProduct($(this).parents('.order-item'), resetOrderCal);
		});
		// check input coupon-code
		$(document.body).on('click', '#order-check-coupon', function() {
			var couponCode = $('.order-coupon-group input').val().trim();
			if (couponCode) {
				checkCouponCode({
					"couponCreatetime": $('.order-list').data('productidarr'),
					"couponCode": couponCode
				}, function(data) {					
					$('.order-coupon-group').data('coupon', data);
					resetOrderCal();
				});	
			} else {
				mlModalTip('Please enter a valid coupon code !');
			}
		});
		// pay event
		$(document.body).on('click', '#pay-now', function() {
			if (checkInputAdressInfo()) {
				orderSaveAddress(getOrderAddress(), function(data) {
					$('#addressId').val(data.addressId);
					payLoading();
					orderPay(getOrderPayInfo(), goToPay);
				});
			}
		});
	</script>
</body>
</html>