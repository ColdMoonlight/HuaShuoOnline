<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<div class="ml-ad"></div>
<header>
	<div class="pc-header">
		<div class="ml-search">
			<div class="container">
				<a class="logo" href="${APP_PATH}">
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
					<i class="icon person unactive"></i>
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
		<div class="wap-navbar">
			<span id="menu" class="icon menu"></span>
			<span class="icon person unactive"></span>
			<a href="TEL:(501)7226336" class="icon phone"></a>
			<a class="logo" href="${APP_PATH}">
				<img src="${APP_PATH}/static/common/dblogo.png" alt="megalook" title="megalook">
			</a>
			<span class="icon share" id="iphone-share"></span>
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
		} else if (id == 5) {
			return "label-15a";
		}
		return "";
	}
	// render nav
	function renderMainCategory(parentEl, data1, data2) {
		var menuHhtml = "";
		for (var i = 0; i < data1.length; i++) {
			var labelClass = getLabelClass(data1[i].categoryLable);
			var secondNavSeo = data1[i].categorySeo;
			var secondNavName = data1[i].categoryName;
			menuHhtml += '<li class="menu-item label ' + labelClass + '">';
			if (secondNavSeo == "") {
				menuHhtml += '<a href="${APP_PATH}/search/nowig.html">' + secondNavName + '</a>';
			} else if (secondNavSeo == "home") {
				menuHhtml += '<a href="${APP_PATH}/index.html">' + secondNavName + '</a>';
			} else if (secondNavSeo == "Activty") {
				menuHhtml += '<a href="${APP_PATH}/Activty.html">' + secondNavName + '</a>';
			} else if (secondNavSeo == "CUSTOMER-VOICE") {
				menuHhtml += '<a href="javascript:void(0)">' + secondNavName + '</a>';
			} else {
				menuHhtml += '<a href="${APP_PATH}/search/' + secondNavSeo + '.html">' + secondNavName + '</a>';
			}

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
							var labelClass = getLabelClass(data2[i][j][k].categoryLable);
							var thirdNavSeo = data2[i][j][k].categorySeo;
							var thirdNavName = data2[i][j][k].categoryName;

							if (k == 0) {
								subMenuHtml += '<dt class="label ' + labelClass + '">';
								if (thirdNavSeo == "") {
									subMenuHtml += '<a href="${APP_PATH}/search/nowig.html">' + thirdNavName + '</a>';
								} else if (thirdNavSeo == "Customer-Videos") {
									subMenuHtml += '<a href="${APP_PATH}/MlbackVideoShowArea/toVideoListPage">' + thirdNavName + '</a>';
								} else if (thirdNavSeo == "Shop-By-Look") {
									subMenuHtml += '<a href="${APP_PATH}/MlfrontReview/toReviewCustomer">' + thirdNavName + '</a>';
								} else if (thirdNavSeo == "Photo-Gallery") {
									subMenuHtml += '<a href="${APP_PATH}/MlfrontReview/toReviewInsPage">' + thirdNavName + '</a>';
								} else {
									subMenuHtml += '<a href="${APP_PATH}/search/' + thirdNavSeo + '.html">' + thirdNavName + '</a>';
								}
								subMenuHtml += (thirdMenuLen > 1 ? '<i class="operate gw-i2"></i>' : '') + '</dt>';
							} else {
								isWrap = false;
								subMenuHtml += '<dd class="' + labelClass + '"><a href="${APP_PATH}/search/' + thirdNavSeo + '.html">' + thirdNavName + '</a></dd>';
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
			url: '${APP_PATH}/MlbackCategory/getCategorySuperMenu',
			method: 'post',
			success: function (data) {
				if (data.code == 100) {
					callback(data.extend);
				} else {
					var modal = createModal({
	        			body: {
	        				html: '<p>Failed to get to the relevant data !</p>'
	        			},
		    			autoClose: true
	        		});
				}
			},
			error: function(err) {
				var modal = createModal({
	    			body: {
	    				html: '<p>Error: '+ err + '</p>'
	    			},
	    			autoClose: true
	    		});
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
	// initial header nav
	getNavMenuData(function (data) {
		renderMainCategory($('.ml-nav'), data.categoryFirstList, data.mlbackCategorySuperList);
		// pc event
		addNavEvent();
		// wap event;
		addWapNavEvent();
	});
	// initial cart num
	updateProructNumberInCart();
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
	var startY = 0;
	$(window).on('scroll', function () {
		var currentY = window.pageYOffset;
		if (currentY >= startY) {
			if (window.innerWidth > 1024) {
				$('.ml-search').hide();
				$('main').css({ 'paddingTop': '4rem' });
			}
		}

		if (currentY < startY && currentY < 60) {
			if (window.innerWidth > 1024) {
				$('.ml-search').show();
				$('main').css({ 'paddingTop': '9rem' });
			}
		}
		startY = currentY;
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
	$(document.body).on('click', '.icon.person.unactive', function() {
		function loginModalTip(text) {
			var modal = createModal({
				body: {
					html: '<p>'+ text +'</p>'
				},
				autoClose: true
			});
		}
		
		function registerFn(reqData, callback) {
			$.ajax({
				url: "${APP_PATH }/MlfrontUser/register",
				type: 'post',
				data: JSON.stringify(reqData),
				dataType: 'json',
				contentType: 'application/json',
				success: function (data) {
					if (data.extend.registerYes) {
						 loginModalTip('Registered successfully !');
						 callback && callback();
					} else {
						loginModalTip('Registered failed !');
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
						 loginModalTip('Password change successfully !');
						 callback && callback();
					} else {
						loginModalTip('Password change failed !');
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
						 loginModalTip('Login successfully !');
						 callback && callback();
					} else {
						loginModalTip('Login failed !');
					}
				},
				error: function() {
					sysModalTip();
				}
			});
		}
		var emailPattern = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
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
						'<a href="${APP_PATH}" class="btn btn-no">Go Home</a>' +
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
		var loginRegisterModal = createModal({
			header: {
				html: '<p>MegaLook</p>'
			},
			body: {
				html: loginRegisterHtml
			}
		});
		loginRegisterModal.addClass('login-register');
		// tab event
		$(document.body).on('click', '.tab-item', function() {
			if (!$(this).hasClass('active')) {
				$(this).addClass('active').siblings().removeClass('active');
				$('.tab-pane.'+ $(this).data('id')).addClass('active').siblings().removeClass('active');
			}
		});
		// login event
		$('.btn.sigin').on('click', function () {
			var email = $('#signin input[name=userEmail]').val();
			var password = $('#signin input[name=userPassword]').val();

			if (!email || !emailPattern.test(email)) {
				loginModalTip('It is illegal to enter an email address ！');
				return ;
			}

			if (password.length < 6) {
				loginModalTip('The password entered is invalid ！');
				return ;
			}

			loginFn({
				'userEmail': email,
				'userPassword': password
			}, function () {
				removeModal(loginRegisterModal);
				updateProructNumberInCart();
				$('.icon.person').removeClass('unactive').addClass('active');
			});
		});
		// register event
		$('.btn.register').on('click', function () {
			var email = $('#register input[name=userEmail]').val();
			var password = $('#register input[name=userPassword]').val();
			var password2 = $('#register input[name=ConfirmPassword]').val();

			if (!email || !emailPattern.test(email)) {
				loginModalTip('It is illegal to enter an email address ！');
				return ;
			}

			if (password.length < 6) {
				loginModalTip('The password entered is invalid ！');
				return ;
			}

			if (!password2.length) {
				loginModalTip('Please enter a confirmation password ！');
				return ;
			}

			if (password2.length < 6) {
				loginModalTip('The confirm password entered is invalid ！');
				return ;				
			}

			if (password != password2) {
				loginModalTip('Twice the password is double, please re-enter the password ！');
				$('#register input[name=ConfirmPassword]').val('');
				return ;				
			}

			registerFn({
				'userEmail': email,
				'userPassword': password
			}, function() {
				removeModal(loginRegisterModal);
			});
		});
		// forget event
		$('#forget-password').on('click', function() {
			$('.left-box').hide();
			$('.right-box').show();
		});
		$('.btn.forget-password').on('click', function () {
			var email = $('#forget-password input[name=userEmail]').val();
			var password = $('#forget-password input[name=userPassword]').val();
			var password2 = $('#forget-password input[name=ConfirmPassword]').val();

			if (!email || !emailPattern.test(email)) {
				loginModalTip('It is illegal to enter an email address ！');
				return ;
			}

			if (password.length < 6) {
				loginModalTip('The password entered is invalid ！');
				return ;
			}

			if (!password2.length) {
				loginModalTip('Please enter a confirmation password ！');
				return ;
			}

			if (password2.length < 6) {
				loginModalTip('The confirm password entered is invalid ！');
				return ;				
			}

			if (password != password2) {
				loginModalTip('Twice the password is double, please re-enter the password ！');
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
	});
</script>