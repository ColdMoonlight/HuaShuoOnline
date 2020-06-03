<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<div class="main-ad></div>
<div class="main-header">
	<ul class="pc-nav menu"></ul>
</div>
<script>
	// MlbackCategory/getCategorySuperMenu
	function renderMainCategory(parentEl, data1, data2) {
	    var menuHhtml = "";
	    for (var i = 0; i < data1.length; i++) {
	        var categoryLableInt = data1[i].categoryLable;
	        var classimg = "";
	        if (categoryLableInt == 0) {
	            classimg = "classimg0";
	        } else if (categoryLableInt == 1) {
	            classimg = "classimg1";
	        } else if (categoryLableInt == 2) {
	            classimg = "classimg2";
	        } else if (categoryLableInt == 3) {
	            classimg = "classimg3";
	        } else if (categoryLableInt == 4) {
	            classimg = "classimg4";
	        } else if (categoryLableInt == 5) {
	            classimg = "classimg5";
	        }
	        var secondNavName = data1[i].categorySeo;
	        if (secondNavName == "") {
	            menuHhtml += '<li class="menu-item '+ classimg +'"><a href="${APP_PATH}/search/nowig.html">'+ data1[i].categoryName +'</a>';
	        } else if (secondNavName == "home") {
	            menuHhtml += '<li class="menu-item '+ classimg +'"><a href="${APP_PATH}/index.html">'+ data1[i].categoryName +'</a>';
	        } else if (secondNavName == "Activty") {
	            menuHhtml += '<li class="menu-item '+ classimg +'"><a href="${APP_PATH}/Activty.html">' + data1[i].categoryName +'</a>';
	        } else if (secondNavName == "CUSTOMER-VOICE") {
	            menuHhtml += '<li class="menu-item '+ classimg +'"><a href="javascript:void(0)">'+ data1[i].categoryName +'</a>';
	        } else {
	            menuHhtml += '<li class="menu-item '+ classimg +'"><a href="${APP_PATH}/search/'+ data1[i].categorySeo +'.html">'+ data1[i].categoryName +'</a>';
	        }

	        if (data2 && data2.length > 0 && data2[i] && data2[i].length > 0) {
	            var subMenuHtml = '',
	                isWrap = true;
	
	            for (var j = 0; j < data2[i].length; j+=1) {
	                if (data2[i][j] && data2[i][j].length > 0) {
	                    subMenuHtml += '<dl>';
	                    for (var k = 0; k < data2[i][j].length; k+=1) {
	                        var categoryLableInt2 = data2[i][j][k].categoryLable;
	                        var classimg = "";
	                        if (categoryLableInt2 == 0) {
	                            classimg = "classimg0";
	                        } else if (categoryLableInt2 == 1) {
	                            classimg = "classimg1";
	                        } else if (categoryLableInt2 == 2) {
	                            classimg = "classimg2";
	                        } else if (categoryLableInt2 == 3) {
	                            classimg = "classimg3";
	                        } else if (categoryLableInt2 == 4) {
	                            classimg = "classimg4";
	                        } else if (categoryLableInt2 == 5) {
	                            classimg = "classimg5";
	                        }
	                        if (k == 0) {
	                            var thirdNavName = data2[i][j][k].categorySeo;
	                            if (thirdNavName == "") {
	                                subMenuHtml += '<dt class="'+ classimg +'"><a href="${APP_PATH}/search/nowig.html">'+ data2[i][j][k].categoryName +'</a></dd>';
	                            } else if (thirdNavName == "Customer-Videos") {
	                                subMenuHtml += '<dt class="'+ classimg +'"><a href="${APP_PATH}/MlbackVideoShowArea/toVideoListPage">'+ data2[i][j][k].categoryName +'</a></dt>';
	                            } else if (thirdNavName == "Shop-By-Look") {
	                                subMenuHtml += '<dt class="'+ classimg +'"><a href="${APP_PATH}/MlfrontReview/toReviewCustomer">'+ data2[i][j][k].categoryName +'</a></dt>';
	                            } else if (thirdNavName == "Photo-Gallery") {
	                                subMenuHtml += '<dt class="'+ classimg +'"><a href="${APP_PATH}/MlfrontReview/toReviewInsPage">'+ data2[i][j][k].categoryName +'</a></dt>';
	                            } else {
	                                subMenuHtml += '<dt class="'+ classimg +'"><a href="${APP_PATH}/search/'+ data2[i][j][k].categorySeo +'.html">'+ data2[i][j][k].categoryName +'</a></dt>';
	                            }
	                        } else {
	                            isWrap = false;
	                            subMenuHtml += '<dd class="'+ classimg +'"><a href="${APP_PATH}/search/'+ data2[i][j][k].categorySeo +'.html">'+ data2[i][j][k].categoryName +'</a></dd>';
	                        }
	                    }
	                    subMenuHtml += '</dl>';
	                }
	            }
	            
	            menuHhtml += '<div class="sub-menu-container"><div class="sub-menu'+ (isWrap ? " nowrap" : "") +'">'+ subMenuHtml +'</div></div>';
	        }
	        menuHhtml += '</li>';
	    }
	    parentEl.html(menuHhtml);
		// add Event for nav
	    $('.menu-item').on('mouseenter', function (e) {
	        var menuContentHright = $(this).find('.sub-menu-container').outerHeight();
	        $('.navbar_itemContent-background').height(menuContentHright);
	        var targetEl = $(this).find('.sub-menu-container'),
	            outerWidth = 0,
	            clientRect = $(this)[0].getBoundingClientRect(),
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
	        $(this).find('a').addClass('active');
	    });
	    $('.menu-item').on('mouseleave', function (e) {
	        $(this).find('.sub-menu-container').removeClass('active');
	        $(this).find('a').removeClass('active');
	        $('.navbar_itemContent-background').height(0);
	    });
	}
	$.ajax({
	    url: '${APP_PATH}/MlbackCategory/getCategorySuperMenu',
	    method: 'post',
	    success: function (data) {
	        if (data.code === 100) {
	            FirstList = data.extend.categoryFirstList,
	            SecondList = data.extend.mlbackCategorySuperList;
	            renderMainCategory($('.pc-nav'), FirstList, SecondList)
	        } else {
	            renderErrorMsg($('.pc-nav'), '未获取到目录相关的数据');
	        }
	    }
	});
</script>