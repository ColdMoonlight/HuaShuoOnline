<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!-- custom script -->
<script>

 // modal mask
function addFixed() {
	$(document.body).css({
		overflow: 'hidden',
	});
}

function removeFixed() {
	$(document.body).css({
		overflow: 'auto',
	});
}
/* product add/sub */
function productAdd(el, callback) {
	var parentEl = el.parents('.product-qty');
	var max = parentEl.find('.product-num').data('count') && parseInt(parentEl.find('.product-num').data('count')) || Infinity;
	var curr = parseInt(parentEl.find('.product-num').val());

	curr += 1;
	if (curr > max) {
		curr = max;
		var modal = createModal({
			body: {
				html: '<p>Existing inventory <b>'+ curr + '</b> pieces !</p>'
			},
			autoClose: true,
		});
	}

	parentEl.find('.product-num').val(curr);
	callback && callback(parentEl, curr);
}

function productSub(el, callback) {
	var parentEl = el.parents('.product-qty');
	var curr = parseInt(parentEl.find('.product-num').val());
	curr -= 1;
	if (curr < 1) {
		curr = 1;
		var modal = createModal({
			body: {
				html: '<p>At least one product !</p>'
			},
			autoClose: true
		});
	}

	parentEl.find('.product-num').val(curr);
	callback && callback(parentEl, curr);
}

/* product option */
function getProductOption(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackProductAttributeName/getMlbackProductAttributeNameListByProductId',
		data: JSON.stringify({ "productattrnamePid": productId }),
		dataType: 'json',
		contentType: 'application/json',
		type: "post",
		async: false,
		success: function (data) {
			if (data.code == 100) {
				callback && callback(data.extend.mbackProductAttributeNameResList);
			}
		}
	});
}
function renderProductOptions(data, selectedRadioArr) {
	function createOption(data, value) {
		var optionName = data.productattrnameName;
		var optionValue  = data.productattrnameValues.split(',');
		var optionItem = $('<div class="product-option-item" data-type="'+ optionName +'" data-id="'+ data.productattrnameId +'" />');
		var htmlStr = '<div class="name">'+ optionName +':</div>';

		optionObj[optionName] = optionValue;
		optionIdArr.push(data.productattrnameId);

		htmlStr += '<div class="body">';
		optionValue.forEach(function(item, idx) {
			htmlStr += '<span class="radio'+ (value == item ? ' active' : '') +'" data-text="'+ item +'">'+ item +'</span>';
		});
		htmlStr += '</div>'
		optionItem.html(htmlStr);
		$('.product-options').append(optionItem);
	}
	data.forEach(function(item, idx) {
		createOption(item, selectedRadioArr && selectedRadioArr[idx]);
	});
}

/* get coupon area data */
function getCouponAreaData(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackCouponDescTitle/getMlbackCouponDescTitleListByStatus',
		contentType: 'application/json',
		type: "post",
		async: false,
		success: function (data) {
			if (data.code == 100) {
				callback && callback(data.extend);
			}
		}
	});
}

/* render coupon area */
function renderCouponAreaData(data) {
	function generateCouponAreaDetailsListData(data) {
		var html = '';
		data.forEach(function(item, idx) {
			html += '<li>'+ item.coupondescdetailStrengthpre +'&nbsp;<span>&nbsp;'+ item.coupondescdetailStrength +'&nbsp;</span>&nbsp;'+ item.coupondescdetailCodepre +'&nbsp;<b>&nbsp;'+ item.coupondescdetailCode +'</b></li>';
		});
		return html;
	}
	var $el = $('.product-coupons');
	var htmlStr = '<div class="left lazyload" data-src="'+  data.mlbackCouponDescTitleList[0].coupondesctieleImgurl +'"></div>' +
				'<div class="right">' +
			'<div class="title">'+ data.mlbackCouponDescTitleList[0].coupondesctieleTieledetail +'</div>' +
			'<ul class="body">' + generateCouponAreaDetailsListData(data.mlbackCouponDescDetailList) + '</ul>' +
		'</div>';
	
	$el.html(htmlStr);
	
	if (data.mlbackCouponDescTitleList[0].coupondesctieleStatus) {
		$el.removeClass('hide');
	}
	
	new LazyLoad($el.find('.lazyload'), {
		root: null,
		rootMargin: "10px",
		threshold: 0
	});
}
/* product sku-list status=1 */
function getProductSkus(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackProductSku/customerGetMlbackProductSkuListByPId',
		data: JSON.stringify({
			"productskuPid": productId,
			"productskuStatus": 1
		}),
		dataType: 'json',
		contentType: 'application/json',
		type: "post",
		async: false,
		success: function (data) {
			if (data.code == 100) {
				callback && callback(data.extend.mlbackProductSkuResList);
			}
		}
	});
}	
// skus		
function buildResult(items) {
    var paths = getPaths(items);
    for (var i = 0; i < paths.length; i+=1) {
        var curr = paths[i];
        var stock = items[i].productskuStock || 0;
        var arr = curr.split(',')
        var allSets = powerset(arr);

        for (var j = 0; j < allSets.length; j+=1) {
            var subSet = allSets[j].join(',')
            if (mapSet[subSet]) {
                mapSet[subSet].count += stock
            } else {
                mapSet[subSet] = { 'count': stock }
            }
        }
    }
}
function getPaths(items) {
    return items.reduce(function(acc, item) {
        mapItems[item.productskuName] = item
        acc.push(item.productskuName)
        return acc
    }, [])
}
function trimSpliter(str) {
    var reLeft = new RegExp('^,+', 'g');
    var reRight = new RegExp(',+$', 'g');
    var reSpliter = new RegExp(',+', 'g');

    return str.replace(reLeft, '')
        .replace(reRight, '')
        .replace(reSpliter, ',')
}
function getSelectedItem() {
    var selectedItems = [];
    $('.product-option-item').each(function () {
        var $selected = $(this).find('.radio.active');
        if ($selected.length) {
            selectedItems.push($selected.data('text'));
        } else {
            selectedItems.push('');
        }
    })

    return selectedItems
}
function powerset(arr) {
    var ps = [[]];
    for (var i = 0; i < arr.length; i+=1) {
        for (var j = 0, len = ps.length; j < len; j+=1) {
            ps.push(ps[j].concat(arr[i]))
        }
    }
    return ps;
}
function updateProductStatus(selected) {
	var keys = Object.keys(optionObj);
    for (var i = 0, len = keys.length; i < len; i+=1) {
        var key = keys[i];
        var data = optionObj[key];
        var selectArr = selected.slice();

        for (var j = 0; j < data.length; j+=1) {
            var item = data[j];

            /* if (selected[i] == item) continue; */

            selectArr[i] = item;

            var curr = trimSpliter(selectArr.join(','), ',');
            var $item = $('.product-option-item[data-type="' + key + '"]').find('.radio[data-text="' + item + '"]');

            if (mapSet[curr] && mapSet[curr].count) {
                $item.removeClass('disabled');
            } else {
            	 $item.addClass('disabled').removeClass('active');
            }
        }
    }
}
function handleNormalClick(el) {
    el.hasClass('active')
        ? (el.siblings().removeClass('disabled'), el.removeClass('active'))
        : (el.siblings().removeClass('active'), el.addClass('active'))
}
function showResult() {
    var selectedItems = getSelectedItem();
    var selectedKeys = [];

    for (var i = 0; i < selectedItems.length; i+=1) {
        var item = selectedItems[i];
        if (!!item) {
            selectedKeys.push(item);
        }
    }

    updateProductData(selectedKeys);
}

// check add/sub product; add-to-cart/buynow product;
function isCorrectProduct() {
	var optionItems = $('.product-option-item');
	var flag = true;
	// option check
	for (var i = 0, len = optionItems.length; i < len; i += 1) {
		var $optionItem = $(optionItems[i]);
		if (!$optionItem.find('.radio.active').length) {
    		var modal = createModal({
    			body: {
    				html: '<p>Please select a product specifications and options: '+ $optionItem.data('type') + '</p>'
    			},
    			autoClose: true
    		});
    		flag = false;
    		break;
		}
	}
	return flag;
}
// product radio click
$(document.body).on('click', '.radio', function(e) {
	var $this = $(this)

    if (!$this.hasClass('disabled')) {
        handleNormalClick($this);
        updateProductStatus(getSelectedItem());
        showResult();
   	}

	$('.radio').each(function () {
        if (!mapSet[$(this).data('text')] && !$(this).hasClass('active')) {
            $(this).addClass('disabled');
        }
    });
});
/* modal */
function closeModalEvent(e) {
    if (e.target == this) {
    	removeFixed();
        $('.modal').remove();
    }
}

function mergeOpts (opts1, opts2) {
    var res = $.extend(true, {}, opts1, opts2);

    $.each(opts2, function (key, value) {
      if ($.isArray(value)) {
        res[key] = value;
      }
    });

    return res;
}

function createModal(option) {
	var opt = mergeOpts({
		header: {
			html: '',
			isShow: true,
		},
		body: {
			html: '',
			isShow: true,
		},
		footer: {
			html: '',
			isShow: false,
		},
		autoClose: false,
		blockEvent: false,
	}, option);
	var htmlStr = '';
	var timer = null
	var modal = $('<div class="modal">' +
	    '<div class="modal-close icon close"></div>' +
	    '<div class="modal-container">' +
	    	(opt.header.isShow ? ('<div class="modal-header">' + (opt.header.html ? opt.header.html : '<p>Megalook Tip !</p>') + '</div>') : '') +
	    	('<div class="modal-body">' + opt.body.html + '</div>') +
	    	(opt.footer.isShow
	    			? ('<div class="modal-footer">' + 
	    					(opt.footer.html ? opt.footer.html : '<button class="btn btn-pink modal-no"> No </button><button class="btn btn-yes modal-ok"> Yes </button>') +
	    				'</div>')
	    			: '') +
	    '</div>' +
	'</div>');
	function openTimer() {
		timer = setTimeout(function() {
    		removeModal(modal);
    	}, 1500);
	}
	var modalLen = $('.modal').length;
	$(document.body).append(modal);
	setTimeout(function() {
		modal.addClass('active');
	});
    addFixed();
	// modal z-index
	if (modalLen) modal.css('z-index', getComputedStyle($('.modal')[0]).zIndex + modalLen + 1);
    // auto close
    if (opt.autoClose) {
    	openTimer();
	    var modalContainer = modal.find('.modal-container');
	    modalContainer.on('mouseenter', function() {
	    	clearTimeout(timer);
	    });
	    
	    modalContainer.on('mouseleave', function() {
	    	openTimer();
	    });
    }
    // modal close event
    if (!opt.blockEvent) {    	
	    modal.on('click', closeModalEvent);
	    modal.find('.modal-close, .btn-no').on('click', closeModalEvent);
    }
    
	return modal;
}

function removeModal(modal) {
	modal.remove();
    removeFixed();
}

function mlModalTip(text) {
	var modal = createModal({
		body: {
			html: '<p>'+ text +'</p>'
		},
		autoClose: true,
	});
}

function sysModalTip() {
	mlModalTip('Settlement system error, temporarily unable to get data, please try again later !');
}

function sysModalErrorTip (err) {
	mlModalTip('Error: '+ JSON.stringify(err));
}

function refreshPageModal() {
	mlModalTip('please refresh the page to get again !');
}

function deleteProductSuccessModal() {
	mlModalTip('Successfully deleting  the product !');
}

function deleteProductFailModal() {
	mlModalTip('Failed to delete the product !');
}

function updateProductNumSuccessModal() {
	mlModalTip('Successfully updating the product !');	
}

function updateProductNumFailModal() {
	mlModalTip('Failed to update the product !');
}

function loginNotTip() {
	var loginModal = createModal({
		header: {
			isShow: false,
		},
		body: {
			html: '<p>Not logged in, 3s later, it will jump to the homepage !</p>'
		},
		blockEvent: true,
	});
	loginModal.find('.modal-close').hide();
	setTimeout(goToIndex, 3000);
}

// pay loading
function payLoading() {
	var $payLoading = $('<div class="pay-loading"><div class="load-list"><div class="loader-item"></div><div class="loader-item"></div><div class="loader-item"></div></div>');
	$(document.body).append($payLoading);
	addFixed();
}

/* jump link function */
function goToIndex() {
	window.location.href = '${APP_PATH}';
}
function goToCheckout() {
	window.location.href = '${APP_PATH}/MlbackCart/toCheakOut';
}
function goToCartList() {
	window.location.href = '${APP_PATH}/MlbackCart/toCartList';
}
function goToPay() {
	window.location.href = '${APP_PATH }/paypal/mpay';
}
function goTopayInstance() {
	window.location.href = '${APP_PATH}/paypalProDetailExpress/mpay';
}
function goToUserCenter() {
	 window.location.href = "${APP_PATH }/MlfrontUser/toUserCenter";
}
function goToUserCenerOrder() {
	window.location.href = "${APP_PATH }/MlfrontUser/tomyOrderPage";
}
function goToUserCenerCoupon() {
	window.location.href = "${APP_PATH }/MlfrontUser/toCouponPage";
}
function goToUserCenerPersonal() {
	window.location.href = "${APP_PATH }/MlfrontUser/toPersonInfoPage";
}

/* pagination */
/* pageNum */
function getPageNum() {
	return storage.getItem('pageNum') || 1
}

function setPageNum(val) {
	storage.setItem('pageNum', val);
}

function makerArray(n) {
	var arr = []
	for (var i = 0; i < n; i++) {
		arr.push(i + 1);
	}
	return arr;
}
function renderTablePagination(data) {
	if (data) {
		$("#table-pagination").empty();
		//构建元素
		var pageUl = $('<ul class="pagination" />'),
			firstPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('first')),
			prePageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&laquo;')),
			nextPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('&raquo;')),
			lastPageLi = $('<li class="page-item" />').append($('<a class="page-link" />').append('last')),
			pageCurrentNum = data.pageNum,
			pageNums = data.pages,
			pageArr = [];
		prePageLi.on('click', function () {
			pageCurrentNum > 1 && setPageNum(pageCurrentNum - 1);
		});
		nextPageLi.on('click', function () {
			pageCurrentNum < pageNums && setPageNum(pageCurrentNum + 1);
		});
		if (pageNums > 5) {
			if (pageCurrentNum <= 5) {
				pageArr = [1, 2, 3, 4, 5];
			} else if (pageCurrentNum > pageNums - 5) {
				pageArr = [pageNums - 4, pageNums - 3, pageNums - 2, pageNums - 1, pageNums];
			} else {
				pageArr = [pageCurrentNum - 2, pageCurrentNum - 1, pageCurrentNum, pageCurrentNum + 1, pageCurrentNum + 2];
			}
		} else {
			pageArr = makerArray(pageNums || 1);
		}

		if (data.hasPreviousPage == false) {
			firstPageLi.addClass('disabled');
			prePageLi.addClass('disabled');
		} else {
			//为元素添加点击翻页的事件
			firstPageLi.click(function () {
				setPageNum(1);
			});
			prePageLi.click(function () {
				setPageNum(pageCurrentNum - 1);
			});
		}

		if (data.hasNextPage == false) {
			nextPageLi.addClass('disabled');
			lastPageLi.addClass('disabled');
		} else {
			nextPageLi.click(function () {
				setPageNum(pageCurrentNum + 1);
			});
			lastPageLi.click(function () {
				setPageNum(pageNums);
			});
		}

		pageUl.append(firstPageLi).append(prePageLi);

		$.each(pageArr, function (i, item) {
			var numLi = $('<li class="page-item" />').append($('<a class="page-link" href="javascript:;" />').append(item));
			if (pageCurrentNum == item) {
				numLi.addClass('active');
			}
			numLi.click(function () {
				setPageNum(item);
			});
			pageUl.append(numLi);
		});

		pageUl.append(nextPageLi).append(lastPageLi);

		var navEle = $('<nav aria-label="Page navigation" />').append(pageUl);
		navEle.appendTo('#table-pagination');
	}
}
// get slide-area product
function getProductSlideArea(callback) {
	$.ajax({
		url: '${APP_PATH}/MlbackSlide/getMlbackSlidewapListByArea',
		data: JSON.stringify({ "slideArea": 3 }),
		type: 'post',
		dataType: 'json',
		contentType: 'application/json',
		success: function (data) {
			if (data.code == 100) {
				callback && callback(data.extend.mlbackProductResList);
			}
		}
	});
}
function generateSwiperSlideProduct(data) {
	var htmlStr = '';
	var $productSwiper = $('<div class="swiper-container"><div class="swiper-wrapper"></div><div class="swiper-btn swiper-button-next"></div><div class="swiper-btn swiper-button-prev"></div></div>');

	data.forEach(function(item, idx) {
		var productLink = item.productSeo ? '${APP_PATH}/' + item.productSeo + '.html' : 'javascript:;';
		htmlStr += '<div class="swiper-slide product-item" data-productid="'+ item.productId +'">' +
		    '<span class="product-discount-label'+ (item.productDiscoutimgShow ? ' show' : '') +'" style="background-image: url('+ (item.productDiscoutimgurl || '') +');"></span>' +
			'<div class="product-img">' +
				'<a href="'+ productLink +'" class="lazyload" data-src="'+ item.productMainimgurl +'"></a>' +
			'</div>' +
			'<div class="product-desc">' +
				'<div class="product-name"><a href="'+ productLink +'">'+ item.productName +'</a></div>' +
				'<div class="product-data">' +
					'<span class="product-pay-num">'+ (item.productHavesalenum || 0) +' Order(s)</span>' +
					'<span class="product-review-num">'+ (item.productReviewnum || 0) +' Review(s)</span>' +
				'</div>' +
				'<div class="product-price">' +
					'<span class="product-define-price">$'+ (item.productOriginalprice || 0) +'</span>' +
					'<span class="product-now-price">$'+ (item.productOriginalprice && item.productActoffoff ? (item.productOriginalprice * item.productActoffoff / 100).toFixed(2) : 0) +'</span>' +
				'</div>' +
			'</div>' +
		'</div>';
	});

	$productSwiper.find('.swiper-wrapper').html(htmlStr);

	return $productSwiper;
}
function renderIntroduceProductSlide($el, data) {
	var productSlide = generateSwiperSlideProduct(data).addClass('introduce-product');
	$el.append('<div class="introduce-product-title">YOU MIGHT ALSO LIKE<div>');
	$el.append(productSlide)
	var productSwiper = new Swiper('.introduce-product.swiper-container', {
		slidesPerView: 'auto',
		spaceBetween: 5,
		freeMode: true,
		autoplay: {
			delay: 5000,
			stopOnLastSlide: false,
			disableOnInteraction: false,
		},
		navigation: {
			nextEl: '.introduce-product .swiper-button-next',
			prevEl: '.introduce-product .swiper-button-prev',
		},
		pagination: {
			el: '.introduce-product .swiper-pagination',
			clickable: true
		},
		on: {
		    resize: function(){
		    	productSwiper.slidesPerView = (window.innerWidth > 799 ? 4 : 2);
		    	productSwiper.updateSlidesOffset();
		    }, 
		}
	});
}
</script>