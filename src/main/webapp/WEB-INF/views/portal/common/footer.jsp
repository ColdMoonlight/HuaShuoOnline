<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
<!-- custom script -->
<script>
/*!
 * @copyright Copyright (c) 2017 IcoMoon.io
 * @license   Licensed under MIT license
 *            See https://github.com/Keyamoon/svgxuse
 * @version   1.2.6
 */
(function(){if("undefined"!==typeof window&&window.addEventListener){var e=Object.create(null),l,d=function(){clearTimeout(l);l=setTimeout(n,100)},m=function(){},t=function(){window.addEventListener("resize",d,!1);window.addEventListener("orientationchange",d,!1);if(window.MutationObserver){var k=new MutationObserver(d);k.observe(document.documentElement,{childList:!0,subtree:!0,attributes:!0});m=function(){try{k.disconnect(),window.removeEventListener("resize",d,!1),window.removeEventListener("orientationchange",
d,!1)}catch(v){}}}else document.documentElement.addEventListener("DOMSubtreeModified",d,!1),m=function(){document.documentElement.removeEventListener("DOMSubtreeModified",d,!1);window.removeEventListener("resize",d,!1);window.removeEventListener("orientationchange",d,!1)}},u=function(k){function e(a){if(void 0!==a.protocol)var b=a;else b=document.createElement("a"),b.href=a;return b.protocol.replace(/:/g,"")+b.host}if(window.XMLHttpRequest){var d=new XMLHttpRequest;var m=e(location);k=e(k);d=void 0===
d.withCredentials&&""!==k&&k!==m?XDomainRequest||void 0:XMLHttpRequest}return d};var n=function(){function d(){--q;0===q&&(m(),t())}function l(a){return function(){!0!==e[a.base]&&(a.useEl.setAttributeNS("http://www.w3.org/1999/xlink","xlink:href","#"+a.hash),a.useEl.hasAttribute("href")&&a.useEl.setAttribute("href","#"+a.hash))}}function p(a){return function(){var c=document.body,b=document.createElement("x");a.onload=null;b.innerHTML=a.responseText;if(b=b.getElementsByTagName("svg")[0])b.setAttribute("aria-hidden",
"true"),b.style.position="absolute",b.style.width=0,b.style.height=0,b.style.overflow="hidden",c.insertBefore(b,c.firstChild);d()}}function n(a){return function(){a.onerror=null;a.ontimeout=null;d()}}var a,b,q=0;m();var f=document.getElementsByTagName("use");for(b=0;b<f.length;b+=1){try{var h=f[b].getBoundingClientRect()}catch(w){h=!1}var g=(a=f[b].getAttribute("href")||f[b].getAttributeNS("http://www.w3.org/1999/xlink","href")||f[b].getAttribute("xlink:href"))&&a.split?a.split("#"):["",""];var c=
g[0];g=g[1];var r=h&&0===h.left&&0===h.right&&0===h.top&&0===h.bottom;h&&0===h.width&&0===h.height&&!r?(c.length||!g||document.getElementById(g)||(c=""),f[b].hasAttribute("href")&&f[b].setAttributeNS("http://www.w3.org/1999/xlink","xlink:href",a),c.length&&(a=e[c],!0!==a&&setTimeout(l({useEl:f[b],base:c,hash:g}),0),void 0===a&&(g=u(c),void 0!==g&&(a=new g,e[c]=a,a.onload=p(a),a.onerror=n(a),a.ontimeout=n(a),a.open("GET",c),a.send(),q+=1)))):r?c.length&&e[c]&&setTimeout(l({useEl:f[b],base:c,
hash:g}),0):void 0===e[c]?e[c]=!0:e[c].onload&&(e[c].abort(),delete e[c].onload,e[c]=!0)}f="";q+=1;d()};var p=function(){window.removeEventListener("load",p,!1);l=setTimeout(n,0)};"complete"!==document.readyState?window.addEventListener("load",p,!1):p()}})();
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
	callback & callback(parentEl, curr);
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
	callback & callback(parentEl, curr);
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
				callback(data.extend.mbackProductAttributeNameResList);
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
				callback(data.extend.mlbackProductSkuResList);
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
function updateStatus(selected) {
	var keys = Object.keys(optionObj);
    for (var i = 0, len = keys.length; i < len; i+=1) {
        var key = keys[i];
        var data = optionObj[key];
        var selectArr = selected.slice();

        for (var j = 0; j < data.length; j+=1) {
            var item = data[j];

            if (selected[i] == item) continue;

            selectArr[i] = item;

            var curr = trimSpliter(selectArr.join(','), ',');
            var $item = $('.product-option-item[data-type="' + key + '"]').find('.radio[data-text="' + item + '"]');

            if (mapSet[curr] && mapSet[curr].count) {
                $item.removeClass('disabled');
            } else {
                $item.addClass('disabled');
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
        updateStatus(getSelectedItem());
        showResult();
   	}

	$('.radio').each(function () {
        if (!mapSet[$(this).data('text')] && !$(this).hasClass('active')) {
            $(this).addClass('disabled');
        }
    });
});
/* modal */
$(document.body).on('click', '.modal, .modal-close, .btn-no', function(e) {
    if (e.target == this) {
    	removeFixed();
        $('.modal').remove();
    }
});

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
		autoClose: false
	}, option);
	var htmlStr = '';
	var timer = null
	var modal = $('<div class="modal">' +
	    '<div class="modal-close">x</div>' +
	    '<div class="modal-container">' +
	    	(opt.header.isShow ? ('<div class="modal-header">' + (opt.header.html ? opt.header.html : '<p>Megalook Tip !</p>') + '</div>') : '') +
	    	('<div class="modal-body">' + opt.body.html + '</div>') +
	    	(opt.footer.isShow
	    			? ('<div class="modal-footer">' + 
	    					(opt.footer.html ? opt.footer.html : '<button class="btn btn-no modal-no"> No </button><button class="btn btn-yes modal-ok"> Yes </button>') +
	    				'</div>')
	    			: '') +
	    '</div>' +
	'</div>');
	var modalLen = $('.modal').length;
	if (modalLen) modal.css('z-index', getComputedStyle($('.modal')[0]).zIndex + modalLen + 1);
	function openTimer() {
		timer = setTimeout(function() {
    		removeModal(modal);
    	}, 1000);
	}
	$(document.body).append(modal);
	setTimeout(function() {
		modal.addClass('active');
	});
    addFixed();
    
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
    
	return modal;
}

function removeModal(modal) {
	modal.remove();
    removeFixed();
}

/* jump link function */
function goToCheckout() {
	window.location.href = '${APP_PATH}/MlbackCart/toCheakOut';
}
function goToCartList() {
	window.location.href = '${APP_PATH}/MlbackCart/toCartList';
}
/* varient */
var timer = null, timeStart = Date.now(), mapSet = {}, mapItems = {}, optionObj = {}, optionIdArr = [];
</script>