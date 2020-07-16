<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<header>
	<div class="pc-header">
		<div class="ml-ad"></div>
		<div class="ml-search">
			<div class="container">
				<a class="logo" href="javascript:goToIndex();">
					<img src="${APP_PATH }/static/common/dblogo.png" alt="megalook" title="megalook">
				</a>
				<div class="search-box">
					<div class="search-inputgroup">
						<input type="text" placeholder="Search Products..." />
						<button class="btn" type="submit"><i class="icon search"></i></button>
					</div>
					<div class="search-result-box">
						<span class="icon close"></span>
						<ul class="search-result">
							<li class="search-result-item">bob</li>
							<li class="search-result-item">wigs</li>
							<li class="search-result-item">bundle</li>
							<li class="search-result-item">613</li>
							<li class="search-result-item">Water</li>
						</ul>
					</div>
				</div>
				<div class="login">
					<i class="icon person"></i>
				</div>
			</div>
		</div>
		<div class="pc-nav">
			<div class="container">
				<ul class="ml-nav"></ul>
			</div>
		</div>
		<a href="${APP_PATH}/MlbackCart/toCartList" class="icon cart"><span class="num">0</span></a>
	</div>
	<div class="wap-header">
		<div class="ml-ad"></div>
		<div class="wap-navbar">
			<span id="menu" class="icon menu"></span>
			<span class="icon person"></span>
			<a href="TEL:(501)7226336" class="icon phone"></a>
			<a class="logo" href="javascript:goToIndex();">
				<img src="${APP_PATH}/static/common/dblogo.png" alt="megalook" title="megalook">
			</a>
			<span class="icon share hide" id="iphone-share"></span>
			<a href="${APP_PATH}/MlbackCart/toCartList" class="icon cart"><span class="num">0</span></a>
			<span class="icon search"></span>

			<div class="search-box">
				<div class="title">
					<span class="icon close"></span>
					<p>What are you Looking for?</p>
				</div>
				<div class="search-inputgroup">
					<input type="text" placeholder="Search Products..." />
					<button class="btn" type="submit">Search</button>
				</div>
				<div class="search-result-box">
					<ul class="search-result">
						<li class="search-result-item">bob</li>
						<li class="search-result-item">wigs</li>
						<li class="search-result-item">bundle</li>
						<li class="search-result-item">613</li>
						<li class="search-result-item">Water</li>
					</ul>
				</div>
			</div>
		</div>

		<div class="wap-nav-box">
			<i class="icon close"></i>
			<ul class="wap-nav ml-nav"></ul>
		</div>
	</div>
</header>
<script>
	// get one product data
	function getOneProductData(reqData, callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackProduct/getOneProductSimple',
			data: JSON.stringify(reqData),
			type: "post",
			dataType: 'json',
			contentType: 'application/json',
			success: function(data) {
				if (data.code == 100) {
					callback && callback(data.extend.mlbackProductOne)
				} else {
					sysModalTip();
				}
			},
			error: function() {
				sysModalTip();
			}
		});
	}
	function matchYoutubeUrl(url) {
	    return url.split("watch?v=")[1];
   	}
	// render video data
	function renderVideoData(data, videoLink) {
		var videoRecommendHtml = '<div class="video-recommend">'+
				'<iframe frameborder="0" allowfullscreen="1" allow="autoplay; encrypted-media" title="YouTube video player" width="100%" height="300" src="'+ videoLink +'"></iframe>' +
				'<div class="video-recommend-product">'+
					'<div class="video-recommend-img lazyload" data-src="'+ data.productImgurl +'"></div>'+
					'<div class="video-recommend-data">' +
						'<div class="video-recommend-name">'+ data.productName +'</div>'+
						'<div class="video-recommend-dprice"><span class="">Regular Price :</span><span class="value">$'+ data.productOriginalprice +'</span></div>'+
						'<div class="video-recommend-nprice"><span class="name">Sale Price :</span><span class="value">$'+ (data.productOriginalprice && data.productActoffoff ? (data.productOriginalprice * data.productActoffoff / 100).toFixed(2) : 0) +'</span></div>'+
						'<a class="btn btn-pink" href="'+ (data.productSeo ? ('${APP_PATH}/' + data.productSeo +'.html') : 'jvascrtip:;') +'">Buy Now</a>'+
					'</div>'+
				'</div>' +
			'</div>';
		var videoRecommendModal = createModal({
			header: {
				html: '<p>Hot Video Recommend...</p>'
			},
			body: {
				html: videoRecommendHtml
			}
		});
		new LazyLoad(videoRecommendModal.find('.lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	}
	// get Label Class
	function getLabelClass(id) {
		if (id == 1) {
			return "label-hot";
		} else if (id == 2) {
			return "label-new";
		} else if (id == 3) {
			return "label-sale";
		} else if (id == 4) {
			return "label-doubledrawn";
		} else if (id == 9) {
			return "label-15a";
		}
		return "";
	}
	// render nav
	function renderMainCategory(parentEl, data1, data2) {
		var menuHhtml = "";
		for (var i = 0; i < data1.length; i++) {
			var labelClass = getLabelClass(data1[i].catalogLable);
			var secondNavSeo;
			// product
			if (data1[i].catalogIfproorcateorpage == 0) {				
				secondNavSeo = data1[i].catalogSeoname;
			}
			// collection
			if (data1[i].catalogIfproorcateorpage == 1) {
				secondNavSeo = 'search/' + data1[i].catalogCateseoname;
			}
			// subject
			if (data1[i].catalogIfproorcateorpage == 2) {
				secondNavSeo = data1[i].catalogPageseoname;
			}
			menuHhtml += '<li class="menu-item label ' + labelClass + '">';
			menuHhtml += '<a href="' + (data1[i].catalogIfinto ? '${APP_PATH}/' + secondNavSeo + '.html' : 'javascript:;') + '">' + data1[i].catalogName + '</a>';
			if (data2 && data2.length > 0 && data2[i] && data2[i].length > 0) {
				var subMenuHtml = '',
					isWrap = true,
					subMenuLen = data2[i].length;
				if (subMenuLen) menuHhtml += '<i class="operate gw-i"></i>';

				for (var j = 0; j < subMenuLen; j += 1) {
					if (data2[i][j] && data2[i][j].length > 0) {
						subMenuHtml += '<dl class="sub-menu-item">';
						var thirdMenuLen = data2[i][j].length;
						for (var k = 0; k < thirdMenuLen; k += 1) {
							var labelClass = getLabelClass(data2[i][j][k].catalogLable);
							var thirdNavSeo;

							// product
							if (data2[i][j][k].catalogIfproorcateorpage == 0) {			
								thirdNavSeo = data2[i][j][k].catalogSeoname;
							}
							// collection
							if (data2[i][j][k].catalogIfproorcateorpage == 1) {
								thirdNavSeo = 'search/'+ data2[i][j][k].catalogCateseoname;
							}
							// subject
							if (data2[i][j][k].catalogIfproorcateorpage == 2) {
								thirdNavSeo = data2[i][j][k].catalogPageseoname;
							}
						
							if (k == 0) {
								subMenuHtml += '<dt>' +
									'<a href="'+ (data2[i][j][k].catalogIfinto ? '${APP_PATH}/' + thirdNavSeo + '.html' : 'javascript:;') +'">' + data2[i][j][k].catalogName + '</a>' +
									(thirdMenuLen > 1 ? '<i class="operate gw-i2"></i>' : '') + '</dt>';
							} else {
								isWrap = false;
								subMenuHtml += '<dd><a href="'+ (data2[i][j][k].catalogIfinto ? '${APP_PATH}/' + thirdNavSeo + '.html' : 'javascript:;') +'">' + data2[i][j][k].catalogName + '</a></dd>';
							}
						}
						subMenuHtml += '</dl>';
					}
				}

				menuHhtml += '<div class="sub-menu-container"><div class="sub-menu' + (isWrap ? " nowrap" : "") + '">' + subMenuHtml + '</div></div>';
			}
			menuHhtml += '</li>';
		}
		parentEl.html(menuHhtml);
	}
	// listner event throttle
	function addNavEvent() {
		var timer = null;
		$('.pc-nav .menu-item').on('mouseenter', function (e) {
			var $this = $(this);
			timer = setTimeout(function () {
				enterEvent($this, e);
			}, 300);
		}).on('mouseleave', function (e) {
			var $this = $(this);
			clearTimeout(timer);
			$this.find('.sub-menu-container').removeClass('active');
			$this.find('a').removeClass('active');
		});
	}
	function addWapNavEvent() {
		$('#menu').on('click', function () {
			$('.wap-nav-box').addClass('active');
		});
		$('.wap-nav-box').on('click', function () {
			$('.wap-nav-box').removeClass('active');
		});
		$('.wap-nav-box .close').on('click', function () {
			$('.wap-nav-box').removeClass('active');
		});
		// dropdwon menu
		$(".wap-nav .gw-i").click(function (e) {
			e.stopPropagation();
			var $this = $(this);
			var str = $this.next('.sub-menu-container').css('display');
			if (str == 'none') {
				$this.next('.sub-menu-container').show(200);
				$this.addClass("active");
			} else {
				$this.next('.sub-menu-container').hide(200);
				$this.removeClass("active");
			}
			$this.parent('.menu-item').siblings('.menu-item').find('.gw-i.active').removeClass('active').next('.sub-menu-container').hide(200);
		});
		$(".wap-nav .gw-i2").click(function (e) {
			e.stopPropagation();
			var $this = $(this);
			if ($this.hasClass('active')) {
				$this.removeClass('active').parents("dl").find('dd').hide(200);
			} else {
				$('.operate.active.gw-i2').removeClass("active").parents('dl').find('dd').hide(200);
				$this.addClass('active').parents("dl").find('dd').show(200);
			}
		});
	}
	// mouse enter event
	function enterEvent($this, e) {
		var menuContentHright = $this.find('.sub-menu-container').outerHeight();
		var targetEl = $this.find('.sub-menu-container'),
			outerWidth = 0,
			clientRect = $this[0].getBoundingClientRect(),
			navulClientRect = $('.pc-nav')[0].getBoundingClientRect();
		offsetWidth = window.innerWidth > navulClientRect.width ? navulClientRect.width : window.innerWidth,
			offsetLeft = clientRect.left - navulClientRect.left,
			offsetBottom = clientRect.bottom - navulClientRect.top;
		targetEl.addClass('active');
		outerWidth = targetEl.outerWidth();
		if (outerWidth >= offsetWidth) {
			targetEl.css({
				'width': offsetWidth + 'px',
				'left': '0' + 'px',
				'top': offsetBottom + 'px'
			});
		} else {
			if (offsetLeft < (outerWidth - clientRect.width) / 2 && (offsetLeft + clientRect.width / 2 < offsetWidth / 2)) {
				targetEl.css({
					'left': '0px',
					'top': offsetBottom + 'px'
				});
			} else if (offsetLeft + clientRect.width + (outerWidth - clientRect.width) / 2 >= offsetWidth && (offsetLeft + clientRect.width / 2 > offsetWidth / 2)) {
				targetEl.css({
					'left': 'unset',
					'right': '0' + 'px',
					'top': offsetBottom + 'px'
				});
			} else {
				var defaultLeft = offsetLeft - (outerWidth - clientRect.width) / 2;
				targetEl.css({
					'left': defaultLeft + 'px',
					'top': offsetBottom + 'px'
				});
			}
		}
		$this.find('a').addClass('active');
	}
	// ajax fetch nav data
	function getNavMenuData(callback) {
		$.ajax({
			/* url: '${APP_PATH}/MlbackCategory/getCategorySuperMenu', */
			url: '${APP_PATH}/MlbackCatalog/getCatalogSuperMenu',
			method: 'post',
			success: function (data) {
				if (data.code == 100) {
					callback(data.extend);
				} else {
					mlModalTip('Failed to get to the relevant data !');
				}
			},
			error: function(err) {
				sysModalErrorTip (err);
			}
		});
	}
	// ajax fetch productNum in the cart
	function updateProructNumberInCart() {
		$.ajax({
			url: '${APP_PATH}/MlbackCart/getCartProductNumber',
			method: 'post',
			success: function (data) {
				if (data.code == 100) {
					$('.cart .num').html(data.extend.number || 0);
				}
			}
		});
	}
	// update user login status fn
	function updateUserLoginStatus() {
		$.ajax({
			url: "${APP_PATH}/MlfrontUser/ifLogin",
			type: 'post',
			success: function (data) {
			 	var resData = data.extend,
			 		$pserson = $('.icon.person');
			 	if (resData.ifLogin && !$pserson.hasClass('active')) $pserson.addClass('active');
			
			 	if (!resData.ifLogin && $pserson.hasClass('active')) $person.removeClass('active');
			}
		});
	}
	// login register fn
	function registerFn(reqData, callback) {
		$.ajax({
			url: "${APP_PATH }/MlfrontUser/register",
			type: 'post',
			data: JSON.stringify(reqData),
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.extend.registerYes) {
					mlModalTip('Registered successfully !');
					 callback && callback();
				} else {
					mlModalTip('Registered failed !');
				}
			},
			error: function() {
				sysModalTip();
			}
		});
	}
	
	function forgetFn(reqData, callback) {
		$.ajax({
			url: "${APP_PATH}/MlfrontUser/reSetPwd",
			type: 'post',
			data: JSON.stringify(reqData),
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.code == 100) {
					mlModalTip('Password change successfully !');
					 callback && callback();
				} else {
					mlModalTip('Password change failed !');
				}
			},
			error: function() {
				sysModalTip();
			}
		});
	}

	function loginFn(reqData, callback) {
		$.ajax({
			url: "${APP_PATH }/MlfrontUser/login",
			type: 'post',
			data: JSON.stringify(reqData),
			dataType: 'json',
			contentType: 'application/json',
			success: function (data) {
				if (data.extend.loginYes) {
					mlModalTip('Login successfully !');
					callback && callback();
				} else {
					mlModalTip('Login failed !');
				}
			},
			error: function() {
				sysModalTip();
			}
		});
	}
	// login-register box	
	function loginRegisterBox () {		
		var loginRegisterHtml = '<div class="left-box">' +
				'<div class="tab">' +
					'<div class="tab-item active" data-id="signin">Sign In</div>' +
					'<div class="tab-item" data-id="register">Register</div>' +
				'</div>' +
				'<div class="tab-pane signin active">' +
					'<form id="signin">' +
						'<div class="input-group">' +
							'<label for="userEmail">E-mail</label>' +
							'<input type="email" id="userEmail" name="userEmail" placeholder="eamil" required>' +
						'</div>' +
						'<div class="input-group">' +
							'<label for="userPassword">Password</label>' +
							'<input type="password" id="userPassword" name="userPassword" placeholder="password at least six figures">' +
						'</div>' +
					'</form>' +
					'<div class="btn-group">' +
						'<a href="javascript:;" class="btn btn-black sigin">SIGN IN</a>' +
					'</div>' +
					'<p class="forget-password"><a id="forget-password">Forget PassWord?</a></p>' +
				'</div>' +
				'<div class="tab-pane register">' +
					'<form id="register">' +
						'<div class="input-group">' +
							'<label for="userEmail">E-mail</label>' +
							'<input type="email" id="userEmail" name="userEmail" placeholder="please input eamil" required>' +
						'</div>' +
						'<div class="input-group">' +
							'<label for="userPassword">Password</label>' +
							'<input type="password" id="userPassword" name="userPassword" placeholder="password at least six figures">' +
						'</div>' +
						'<div class="input-group">' +
							'<label for="ConfirmPassword">ConfirmPassword</label>' +
							'<input type="password" id="ConfirmPassword" name="ConfirmPassword" placeholder="ConfirmPassword">' +
						'</div>' +
					'</form>' +
					'<div class="btn-group">' +
						'<a href="javascript:;" class="btn btn-black register"> REGISTER </a>' +
						'<a href="javascript:goToIndex();" class="btn btn-pink">Go Home</a>' +
					'</div>' +
				'</div>' +
			'</div>' +
			'<div class="right-box">' +
				'<form id="forget-password">' +
					'<div class="input-group">' +
						'<label for="userEmail">E-mail</label>' +
						'<input type="email" id="userEmail" name="userEmail" placeholder="please input eamil" required>' +
					'</div>' +
					'<div class="input-group">' +
						'<label for="userPassword">Password</label>' +
						'<input type="password" id="userPassword" name="userPassword" placeholder="password at least six figures">' +
					'</div>' +
					'<div class="input-group">' +
						'<label for="ConfirmPassword">ConfirmPassword</label>' +
						'<input type="password" id="ConfirmPassword" name="ConfirmPassword" placeholder="ConfirmPassword">' +
					'</div>' +
				'</form>' +
				'<div class="btn-group">' +
					'<a href="javascript:;" class="btn btn-black forget-password"> Confirm </a>' +
				'</div>'
			'</div>';
		loginRegisterModal = createModal({
			header: {
				html: '<p>MegaLook</p>'
			},
			body: {
				html: loginRegisterHtml
			}
		});
		loginRegisterModal.addClass('login-register');
	}
	/* render header ad */
	function renderHeaderAd(data) {
		var adSeo, adLink;
		if (data.slideIfproorcateorpage == 0) {				
			adSeo = data.slideSeoname;
		}
		// collection
		if (data.slideIfproorcateorpage == 1) {
			adSeo = 'search/' + data.slideCateseoname;
		}
		// subject
		if (data.slideIfproorcateorpage == 2) {
			adSeo = data.slidePageseoname;
		}
		adLink = data.slideIfinto ? '${APP_PATH}/' + adSeo + '.html' : 'javascript:;';
		$('.wap-header .ml-ad').html('<a class="lazyload" href="'+ adLink +'" data-src="'+ data.slideWapimgurl +'"></a>');
		$('.pc-header .ml-ad').html('<a class="lazyload" href="'+ adLink +'" data-src="'+ data.slidePcimgurl +'"></a>');
		// lazyload
		new LazyLoad($('.ml-ad .lazyload'), {
			root: null,
			rootMargin: "10px",
			threshold: 0
		});
	}
	var isIOS = navigator.userAgent && navigator.userAgent.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/);
	if (isIOS) $('#iphone-share').removeClass('hide');

	// initial ml-ad
	getCarouselData(5, function(data) {
		var hData = data[0]
		hData && renderHeaderAd(hData);
	});
	// initial header nav
	getNavMenuData(function (data) {
		renderMainCategory($('.ml-nav'), data.CatalogFirstList, data.MlbackCatalogSuperList);
		// pc event
		addNavEvent();
		// wap event;
		addWapNavEvent();
		// main padding-top
		$('main').css({ 'paddingTop': $('header').height() + 16 });
	});
	// initial cart num
	updateProructNumberInCart();
	// initial login status
	updateUserLoginStatus();
	// listener search event
	$('.search-inputgroup input').on('click', function () {
		addFixed();
		$(this).parents('.search-box').addClass('active').find('.search-result-box').slideDown(300);
	});
	// close search-result box
	$('.search-result-box').on('click', function (e) {
		if (e.target == this) {
			removeFixed();
			$(this).slideUp(300);
		}
	});
	$('.wap-navbar .search-box .close, .search-result-item').on('click', function () {
		$('.wap-navbar .search-box').hide();
		removeFixed();
	});
	$('.pc-header .search-result-box .close').on('click', function () {
		$('.pc-header .search-result-box').slideUp();
		removeFixed();
	});
	// wap-navbar
	$('.wap-navbar .search').on('click', function () {
		addFixed();
		$('.wap-navbar .search-box').show();
	});
	var startY = 0,
		loginRegisterModal = null;
	$(window).on('scroll', function () {
		var currentY = window.pageYOffset;
		var isPc = window.innerWidth > 1024;
		if (currentY >= startY && currentY > 60 && isPc) {
			!$('.ml-search').hasClass('down') && ($('.ml-search').addClass('hide down').removeClass('up'), $('main').css({ 'paddingTop': $('header').height() + 16 }));
		}

		if (currentY < startY && currentY < 60 && isPc) {
			!$('.ml-search').hasClass('up') && ($('.ml-search').removeClass('down').removeClass('hide').addClass('up'), $('main').css({ 'paddingTop': $('header').height() + 16 }));
		}
		startY = currentY;
	});
	$(window).on('resize', function () {
		debounce(function() {
			$('main').css({ 'paddingTop': $('header').height() + 16 });
		}, 100);
	});
	// iphone share
	$('#iphone-share').on('click', function() {
		var $iphoneAdvice = $('.iphone-advice');
		if (!$iphoneAdvice.length) {
			$iphoneAdvice = $('<div class="iphone-advice"><img src="${APP_PATH }/static/pc/img/iphone-advice.gif" /><span class="icon close"></span></div>');
			$(document.body).append($iphoneAdvice)
		}
		$iphoneAdvice.show();
	});
	$(document.body).on('click', '.iphone-advice .close', function() {
		$('.iphone-advice').hide();
	});
	// login-register
	$('.icon.person').on('click', function() {
		if ($(this).hasClass('active')) {
			goToUserCenter();
			return ;
		} else {
			loginRegisterBox();
		}
	});
	// login-register tab event
	$(document.body).on('click', '.login-register .tab-item', function() {
		if (!$(this).hasClass('active')) {
			$(this).addClass('active').siblings().removeClass('active');
			$('.tab-pane.'+ $(this).data('id')).addClass('active').siblings().removeClass('active');
		}
	});
	// tab forget-password box
	$(document.body).on('click', '#forget-password', function() {
		$('.left-box').hide();
		$('.right-box').show();
	});
	// login event
	$(document.body).on('click', '.btn.sigin', function () {
		var email = $('#signin input[name=userEmail]').val();
		var password = $('#signin input[name=userPassword]').val();

		if (!email || !emailPattern.test(email)) {
			mlModalTip('It is illegal to enter an email address !');
			return ;
		}

		if (password.length < 6) {
			mlModalTip('The password entered is invalid !');
			return ;
		}

		loginFn({
			'userEmail': email,
			'userPassword': password
		}, function () {
			removeModal(loginRegisterModal);
			updateProructNumberInCart();
			$('.icon.person').addClass('active');
		});
	});
	// register event
	$(document.body).on('click', '.btn.register', function () {
		var email = $('#register input[name=userEmail]').val();
		var password = $('#register input[name=userPassword]').val();
		var password2 = $('#register input[name=ConfirmPassword]').val();

		if (!email || !emailPattern.test(email)) {
			mlModalTip('It is illegal to enter an email address !');
			return ;
		}

		if (password.length < 6) {
			mlModalTip('The password entered is invalid !');
			return ;
		}

		if (!password2.length) {
			mlModalTip('Please enter a confirmation password !');
			return ;
		}

		if (password2.length < 6) {
			mlModalTip('The confirm password entered is invalid !');
			return ;				
		}

		if (password != password2) {
			mlModalTip('Twice the password is double, please re-enter the password !');
			$('#register input[name=ConfirmPassword]').val('');
			return ;				
		}

		registerFn({
			'userEmail': email,
			'userPassword': password
		}, function() {
			removeModal(loginRegisterModal);
			updateProructNumberInCart();
			$('.icon.person').addClass('active');
			setTimeout(function() {
				mlModalTip('The new account has been automatically logged in !');
			}, 2000);
		});
	});
	// forget password event
	$(document.body).on('click', '.btn.forget-password', function () {
		var email = $('#forget-password input[name=userEmail]').val();
		var password = $('#forget-password input[name=userPassword]').val();
		var password2 = $('#forget-password input[name=ConfirmPassword]').val();

		if (!email || !emailPattern.test(email)) {
			mlModalTip('It is illegal to enter an email address !');
			return ;
		}

		if (password.length < 6) {
			mlModalTip('The password entered is invalid !');
			return ;
		}

		if (!password2.length) {
			mlModalTip('Please enter a confirmation password !');
			return ;
		}

		if (password2.length < 6) {
			mlModalTip('The confirm password entered is invalid !');
			return ;				
		}

		if (password != password2) {
			mlModalTip('Twice the password is double, please re-enter the password !');
			$('#register input[name=ConfirmPassword]').val('');
			return ;				
		}

		forgetFn({
			'userEmail': email,
			'userPassword': password
		}, function() {
			$('.left-box').show();
			$('.right-box').hide();
		});
	});
</script>