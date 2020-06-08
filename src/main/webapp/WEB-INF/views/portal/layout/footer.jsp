<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>

<footer>
	<div class="footer-nav pc-footer"></div>
	<div class="footer-nav wap-footer"></div>
</footer>
<script>
var footerData = [{
    "name": "Megalook_Hair",
    "icon": "plus",
    "link": "javascript:;",
    "children": [],
    "data-key": "mlbackFootNavOneList"
  },
  {
    "name": "Buyer_Service",
    "icon": "plus",
    "link": "javascript:;",
    "children": [],
    "data-key": "mlbackFootNavTwoList"
  },
  {
    "name": "Activity",
    "icon": "plus",
    "link": "javascript:;",
    "children": [],
    "data-key": "mlbackFootNavThreeList"
  },
  {
    "name": "Client_Service_Support",
    "icon": "plus",
    "link": "javascript:;",
    "children": [],
    "data-key": "mlbackFootNavFourList"
  }
];

$.ajax({
	url: '${APP_PATH}/MlbackFootNav/getMlfrontFootNavAllSimple',
  type: 'post',
  success: function (data) {
    // console.log(data);
    var resData = data.extend;
    if (resData.isNav === 0) {
    	renderSysMsg('没获取到相关数据')
    }

    if (resData.isNav === 1) {
    	initFooterData(resData);        
        renderFooterNav($('.footer-nav'), footerData);
        addWapFooterNavEvent();
    }
  }
});

function initFooterData(data) {
	for (var key in footerData) {
        var blockData = data[footerData[key]["data-key"]];
        for (var key2 in blockData) {
          //加一个判断		footnavIfIncome		每条数据都有这个字段
          //0，不能点		比如有的就纯粹是，联系方式
          //1,能点进去		有富文本内容的。
          if (blockData[key2].footnavIfIncome) {
            footerData[key].children.push({
              "name": blockData[key2].footnavName,
              "icon": "",
			  "link": "${APP_PATH}/MlbackFootNav/toFootNavPage?footnavId=" + blockData[key2].footnavId
            })
          } else {
            footerData[key].children.push({
              "name": blockData[key2].footnavName,
              "icon": "",
              "link": "javascritp:;"
            })
          }
        }
    }
}

function renderFooterNav(parent, data) {
	var htmlStr = '';
	for (var i=0, len=data.length; i<len; i+=1) {
		htmlStr += '<div class="footer-nav-item '+ (data[i].name).toLowerCase() + '">' +
			'<h4 class="footer-nav-title">'+ (data[i].name.replace(/\_/g, ' ')) +
				'<i class="icon ' + data[i].icon + '"></i>' +
			'</h4>';
			var children = data[i].children;
			var len2 = (children && data[i].children.length) || 0;
			if (len2) {
				htmlStr += '<ul class="footer-nav-body footer-nav-submenu">';
				for (j=0; j<len2; j+=1) {
					htmlStr += '<li class="footer-nav-submenu-item"><a href="'+ children[j].link +'">'+ children[j].name +'</a></li>';
				}
				htmlStr += '</ul>';
			}

			htmlStr += '</div>';
	}

	parent.html(htmlStr);
}

function addWapFooterNavEvent() {
	$('.client_service_support').find('.icon').addClass('sub').removeClass('plus').parents('.footer-nav-item').find('.footer-nav-body').slideDown();
	$(document.body).on('click', '.footer-nav-title', function() {
		$('.footer-nav-body').slideUp().parents('.footer-nav').find('.icon').removeClass('sub').addClass('plus');
			$(this).find('.icon').addClass('sub').removeClass('plus').parents('.footer-nav-item').find('.footer-nav-body').slideDown();
	});
}
</script>