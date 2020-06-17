<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<div class="ml-ad"></div>
<header>
	<div class="pc-header">
		<div class="container">		
			<div class="ml-search">
				   	<a class="logo" href="${APP_PATH}/index.html">
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
			<ul class="pc-nav ml-nav"></ul>
		</div>
	</div>
	<div class="wap-header">
		<div class="wap-navbar">
			<span id="menu" class="icon menu"></span>
			<span class="icon person"></span>
			<a href="TEL:(501)7226336" class="icon phone"></a>
			<a class="logo" href="${APP_PATH}/index.html">
				<img src="${APP_PATH }/static/common/dblogo.png" alt="megalook" title="megalook">
			</a>
			<span class="icon iphone"></span>
			<span class="icon cart"><span class="num">0</span></span>
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
	// ajax fetch data
	function getNavMenuData(callback) {
		$.ajax({
			url: '${APP_PATH}/MlbackCategory/getCategorySuperMenu',
			method: 'post',
			success: function (data) {
				if (data.code === 100) {
					callback(data.extend);
				} else {
					renderErrorMsg($('.pc-nav'), '未获取到目录相关的数据');
				}
			}
		});
	}
	// initial header nav
	getNavMenuData(function(data) {
		renderMainCategory($('.ml-nav'), data.categoryFirstList, data.mlbackCategorySuperList);
		// pc event
		addNavEvent();
		// wap event;
		addWapNavEvent();
	});
	// listener search event
	$('.search-inputgroup input').on('click', function() {
		addFixed();
		$(this).parents('.search-box').addClass('active').find('.search-result-box').slideDown(300);
	});
	// close search-result box
	$('.search-result-box').on('click', function(e) {
		if(e.target == this) {
			removeFixed();
			$(this).slideUp(300);
		}
	});
	$('.wap-navbar .search-box .close, .search-result-item').on('click', function() {
		$('.wap-navbar .search-box').hide();
		removeFixed();
	});
	$('.pc-header .search-result-box .close').on('click', function() {
		$('.pc-header .search-result-box').slideUp();
		removeFixed();
	});
	// wap-navbar
	$('.wap-navbar .search').on('click', function() {
		addFixed();
		$('.wap-navbar .search-box').show();
	});
</script>