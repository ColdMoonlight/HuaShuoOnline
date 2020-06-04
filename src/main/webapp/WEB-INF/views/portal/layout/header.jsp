<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<div class="main-ad></div>
<div class=" main-header">
	<div class="pc-header">
		<ul class="pc-nav ml-nav"></ul>
	</div>
	<div class="wap-header">
		<div class="container">
			<span id="menu" class="icon menu"></span>
			<span class="icon person"></span>
			<a href="TEL:(501)7226336" class="icon myphone"></a>
			<a href="${APP_PATH}/index.html">
				<div class="logo">
					<img src="${APP_PATH }/static/m/img/index/logo.png" alt="megalook">
				</div>
			</a>
			<span class="icon add_phone"></span>
			<span class="icon cart"><span class="num hide">0</span></span>
			<span class="icon search"></span>
		</div>
		<div class="wap-nav-box">
    		<i class="icon close"></i>
			<ul class="wap-nav ml-nav"></ul>
		</div>
	</div>
</div>
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
			menuHhtml += '<li class="menu-item ' + labelClass + '">';
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
								subMenuHtml += '<dt class="' + labelClass + '">';
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
		var startTime = Date.now();
		var timer = null;
		$('.pc-nav .menu-item').on('mouseenter', function (e) {
			var $this = $(this);
			var endTime = Date.now();
			if (endTime - startTime < 300) {
				clearTimeout(timer);
			}
			startTime = endTime;
			timer = setTimeout(function () {
				enterEvent($this, e);
				$this.on('mouseleave', function (e) {
					$this.find('.sub-menu-container').removeClass('active');
					$this.find('a').removeClass('active');
				});
			}, 300);
		});
	}
	function addWapNavEvent() {
		$('#menu').on('click', function () {
			$('.wap-nav-box').addClass('active');
		});
		$('.wap-nav-box .close').on('click', function () {
			$('.wap-nav-box').removeClass('active');
		});
		// dropdwon menu
		$(".wap-nav .gw-i").click(function () {
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
		$(".wap-nav .gw-i2").click(function () {
			var $this = $(this);
			if ($this.hasClass('active')) {
				$this.removeClass('active').parents("dl").find('dd').hide(200).siblings("dl").find('.operate').removeClass('active').find('dd').hide(200);;
			} else {
				$this.addClass('active').parents("dl").find('dd').show(200).siblings("dl").removeClass("active").find('.operate').find('dd').hide(200);
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
	$.ajax({
		url: '${APP_PATH}/MlbackCategory/getCategorySuperMenu',
		method: 'post',
		success: function (data) {
			if (data.code === 100) {
				renderMainCategory($('.ml-nav'), data.extend.categoryFirstList, data.extend.mlbackCategorySuperList);
				// pc event
				addNavEvent();
				// wap event;
				addWapNavEvent();
			} else {
				renderErrorMsg($('.pc-nav'), '未获取到目录相关的数据');
			}
		}
	});
</script>