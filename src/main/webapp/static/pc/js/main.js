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
function productAdd(el, flag) {
	var max = parseInt($('.product-num').data('count'));
	var curr = parseInt($('.product-num').val());
	var parentEl = el.parents('.cart-item');

	curr += 1;
	if (curr > max) {
		curr = max;
		modal = createModal({
			body: {
				html: '<p>Existing inventory <b>'+ curr + '</b> pieces !</p>'
			}
		});
		setTimeout(function() {
			removeModal(modal);
		}, 1000);
	}

	parentEl.find('.product-num').val(curr);
	if (flag) updateCartNum(parentEl, curr);
}

function productSub(el, flag) {
	var curr = parseInt($('.product-num').val());
	var parentEl = el.parents('.cart-item');
	curr -= 1;
	if (curr < 1) {
		curr = 1;
		modal = createModal({
			body: {
				html: '<p>At least one product !</p>'
			}
		});
		setTimeout(function() {
			removeModal(modal);
		}, 1000);
	}

	parentEl.find('.product-num').val(curr);
	if (flag) updateCartNum(parentEl, curr);
}
// update cart product number
function updateCartNum(el, num) {
	var targetData = el.data('cartitem') && JSON.parse(el.data('cartitem')) || null,
		reqData = {
			cartitemId: targetData.cartitemId,
			cartitemProductNumber: num
		};

	$.ajax({
		url: '/MlbackCart/updateCartItemSkuNum',
		data: JSON.stringify(reqData),
		type: "post",
		dataType: 'json',
		contentType: 'application/json',
		success: function (data) {
			updateProructNumberInCart();
			targetData.cartitemProductNumber = num;
			el.data('cartitem', targetData);
			modal = createModal({
				body: {
					html: '<p>Successfully adding products !</p>'
				},
				autoClose: true
			});
		},
		error: function () {
			el.find('.product-num').val(targetData.cartitemProductNumber);
			modal = createModal({
				body: {
					html: '<p>Failed to add products !</p>'
				},
				autoClose: true
			});
		}
	});
}
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
	    	(opt.header.isShow ? ('<div class="modal-header">' + (opt.header.html ? opt.hedder.html : '<p>Megalook Tip !</p>') + '</div>') : '') +
	    	('<div class="modal-body">' + opt.body.html + '</div>') +
	    	(opt.footer.isShow
	    			? ('<div class="modal-footer">' + 
	    					(opt.footer.html ? opt.footer.html : '<button class="btn btn-no modal-no"> No </button><button class="btn btn-yes modal-ok"> Yes </button>') +
	    				'</div>')
	    			: '') +
	    '</div>' +
	'</div>');
	function openTimer() {
		timer = setTimeout(function() {
    		removeModal(modal);
    	}, 2000);
	}
	$(document.body).append(modal);
	setTimeout(function() {
		modal.addClass('active');
	});
    addFixed();
    
    if (opt.autoClose) openTimer();
    var modalContainer = modal.find('.modal-container');
    modalContainer.on('mouseenter', function() {
    	clearTimeout(timer);
    });
    
    modalContainer.on('mouseleave', function() {
    	openTimer();
    });
    
	return modal;
}

function removeModal(modal) {
	modal.remove();
    removeFixed();
}

/* varient */
var modal = null, timer = null, timeStart = Date.now();
