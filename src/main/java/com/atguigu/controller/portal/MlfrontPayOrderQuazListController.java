package com.atguigu.controller.portal;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.MlbackHtmlEmail;
import com.atguigu.bean.MlbackSmstype;
import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackHtmlEmailService;
import com.atguigu.service.MlbackSmstypeService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.utils.DateUtil;
import com.atguigu.utils.EmailHtmlUtil;
import com.atguigu.utils.EncryptUtil;
import com.atguigu.utils.URLLocationUtils;

@Controller
@RequestMapping("/MlfrontOrderList")
public class MlfrontPayOrderQuazListController {
		
	@Autowired
	MlfrontOrderService mlfrontOrderService;

	@Autowired
	MlfrontOrderItemService mlfrontOrderItemService;
	
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	MlbackSmstypeService mlbackSmstypeService;
	
	@Autowired
	MlfrontAddressService mlfrontAddressService;
	
	@Autowired
	MlbackHtmlEmailService mlbackHtmlEmailService;
	
//	public static void main(String[] args) {
//		
//		String hour12BeforeTimes = DateUtil.dateRoll(18);
//		
//		System.out.println("hour12BeforeTimes:"+hour12BeforeTimes);
//		
//	}
	
	/**
	 * 1.0	zsh	200720
	 * to	全部订单-分状态查询
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping(value="/selectOrderlistBySearch",method=RequestMethod.GET)
	@ResponseBody
	public Msg selectOrderlistBySearch(HttpServletResponse rep,HttpServletRequest res,HttpSession session) {
		
		
		/**
		 * 准备筛选前的数据
		 * 1自动查询12小时以内的payinfo订单List
		 * 存储付款成功的paySuccessList	包含成功名字
		 * 存储失败的UnPayList
		 * */
		
		//获取当前系统时间
		
		MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
		
		String nowtime = DateUtil.strTime14s();
		
		String beforeTime = DateUtil.dateRoll(36);
		
//		
//		mlfrontPayInfoReq.setPayinfoCreatetime(beforeTime);
//		mlfrontPayInfoReq.setPayinfoMotifytime(nowtime);
		
		mlfrontPayInfoReq.setPayinfoCreatetime("2021-02-25 23:59:59");
		mlfrontPayInfoReq.setPayinfoMotifytime("2021-02-26 23:59:50");
		
		List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoByDateAndIfEmail(mlfrontPayInfoReq);
		
		
		List<MlfrontPayInfo> mlfrontPayInfoSuccessList = new ArrayList<MlfrontPayInfo>();
		
		List<MlfrontPayInfo> mlfrontPayInfoUnPayList = new ArrayList<MlfrontPayInfo>();
		

        Map<String, String> successPayInfoOrderIdMap = new HashMap<String, String>();
        
        Map<String, String> successPayInfoUserNameMap = new HashMap<String, String>();
        
        
        List<Integer> successPayIdList = new ArrayList<Integer>();
        
        List<Integer> sameUnPayIdList = new ArrayList<Integer>();
        
        List<Integer> trueUnPayIdList = new ArrayList<Integer>();
			
		for(MlfrontPayInfo mlfrontPayInfoOne:mlfrontPayInfoList){
			Integer patStatus = mlfrontPayInfoOne.getPayinfoStatus();
			if(patStatus==0){
				//失败订单
				mlfrontPayInfoUnPayList.add(mlfrontPayInfoOne);
				
			}else{
				//成功订单
				mlfrontPayInfoSuccessList.add(mlfrontPayInfoOne);
				
				successPayIdList.add(mlfrontPayInfoOne.getPayinfoId());
				
				successPayInfoOrderIdMap.put(mlfrontPayInfoOne.getPayinfoOid()+"", mlfrontPayInfoOne.getPayinfoOid()+"");
				successPayInfoUserNameMap.put(mlfrontPayInfoOne.getPayinfoUname(), mlfrontPayInfoOne.getPayinfoUname());
			}
			
		}
		//订单(客户A，试了4次，分别是A1-N，A1-N，A2-N，A3-Y)(客户B，试了1次，B1-N)(客户C,试了5次，C1-N，C1-N，C2-N，C3-N，C3-N，C3-Y)
		
		/**遍历
		 * 
		 * */

		List<MlfrontPayInfo> mlfrontPayInfoRemoveSameOidNowList = new ArrayList<MlfrontPayInfo>();
			
		for(MlfrontPayInfo mlfrontPayInfoB:mlfrontPayInfoUnPayList){
			Integer unpOrderID = mlfrontPayInfoB.getPayinfoOid();
			
			String pOrderIDSuccessStr = successPayInfoOrderIdMap.get(unpOrderID+"");
			
			if(pOrderIDSuccessStr==null){
				
				//这一单起码orderid没有重复//存起来
				mlfrontPayInfoRemoveSameOidNowList.add(mlfrontPayInfoB);
				//这里面-剔除了--跟已支付同orderid的重复单(未支付的重复单子)
				
				//把此时的客户名字存起来放进Map成功map中
			}else{
				//这个是重复单子(最终客户付款之前的单子),跳过
				sameUnPayIdList.add(mlfrontPayInfoB.getPayinfoId());
			}

		}
		
		//没有跟成功单相同的orderid了。现在要删掉，剩下的非与成功相同的orderid。去除了跟成功单相同的orderid的payinfo单子
		
		
		List<MlfrontPayInfo> mlfrontPayInfoRemoveUnameList = new ArrayList<MlfrontPayInfo>();
		
        Map<String, String> reallyUnPayInfoOrderIdMap = new HashMap<String, String>();
        
        Map<String, String> reallyUnPayInfoUserNameMap = new HashMap<String, String>();
		
		
		for(MlfrontPayInfo mlfrontPayInfoC:mlfrontPayInfoRemoveSameOidNowList){
			String payinfoUname = mlfrontPayInfoC.getPayinfoUname();
			
			String pOrderUnameSuccessStr = successPayInfoUserNameMap.get(payinfoUname);
			
			if(pOrderUnameSuccessStr==null){
				//这一单起码orderid没有重复//存起来
				mlfrontPayInfoRemoveUnameList.add(mlfrontPayInfoC);
				//这里面-剔除了--跟已支付同Uname的重复单(未支付的重复单子)
				
				//把此时的客户名字存起来放进Map成功map中
				
				reallyUnPayInfoOrderIdMap.put(mlfrontPayInfoC.getPayinfoOid()+"", mlfrontPayInfoC.getPayinfoOid()+"");
				reallyUnPayInfoUserNameMap.put(mlfrontPayInfoC.getPayinfoUname(), mlfrontPayInfoC.getPayinfoUname());
			}else{
				//这个是人名重复重复单子(最终客户付款之前的单子),跳过
				sameUnPayIdList.add(mlfrontPayInfoC.getPayinfoId());
			}
			
		}
		
		//移除了与成功单相同Orderid的单子/与成功单相同UserName的单子
		
		Integer lastUnPayOid = 0;
		
		List<MlfrontPayInfo> mlfrontPayInfoRemoveUnPayOrderIdSameList = new ArrayList<MlfrontPayInfo>();
		
		for(MlfrontPayInfo mlfrontPayInfoD:mlfrontPayInfoRemoveUnameList){
			Integer unpOrderID = mlfrontPayInfoD.getPayinfoOid();
			
			if(lastUnPayOid.equals(unpOrderID)){
				//这一单重复啦(未支付里面的orderid重复)
				//仅仅记录到未成功付款的重复单里
				sameUnPayIdList.add(mlfrontPayInfoD.getPayinfoId());
			}else{
				mlfrontPayInfoRemoveUnPayOrderIdSameList.add(mlfrontPayInfoD);
				lastUnPayOid = unpOrderID;
			}
		}
		
		
		List<MlfrontPayInfo> mlfrontPayInfoRemoveUnPayOrderUnameSameList = new ArrayList<MlfrontPayInfo>();
		
		String lastUnpOrderUname = "";
		
		for(MlfrontPayInfo mlfrontPayInfoE:mlfrontPayInfoRemoveUnPayOrderIdSameList){
			String unpOrderUname = mlfrontPayInfoE.getPayinfoUname();
			
			if(lastUnpOrderUname.equals(unpOrderUname)){
				//这一单重复啦(未支付里面的orderid重复)
				
				//仅仅记录到未成功付款的重复单里
				sameUnPayIdList.add(mlfrontPayInfoE.getPayinfoId());
			}else{
				mlfrontPayInfoRemoveUnPayOrderUnameSameList.add(mlfrontPayInfoE);
				trueUnPayIdList.add(mlfrontPayInfoE.getPayinfoId());
				lastUnpOrderUname = unpOrderUname;
			}
		}
		
		//先发邮件
		
		sendEmailToUnpayList(rep, res, session, sameUnPayIdList);
		
		//把发完的邮件变成状态1
		
		//重复单标记状态2
		
		return Msg.success().add("trueUnPayIdList", trueUnPayIdList).add("successPayIdList", successPayIdList).add("sameUnPayIdList", sameUnPayIdList);
		
	}
	
//	
//	sendAbondonEmail();
	
	
	private void sendEmailToUnpayList(HttpServletResponse rep,HttpServletRequest res,HttpSession session,List<Integer> sameUnPayIdList) {

		//接受categoryId
		MlbackHtmlEmail MlbackHtmlEmailReq = new MlbackHtmlEmail();
		MlbackHtmlEmailReq.setHtmlemailName("checkEmail");
		MlbackHtmlEmailReq.setHtmlemailStatus(1);
		//查询本条
		List<MlbackHtmlEmail> mlbackHtmlEmailResList =mlbackHtmlEmailService.selectMlbackHtmlEmailListByName(MlbackHtmlEmailReq);
		MlbackHtmlEmail mlbackHtmlEmailOne = new MlbackHtmlEmail();
		if(mlbackHtmlEmailResList.size()>0){
			mlbackHtmlEmailOne =mlbackHtmlEmailResList.get(0);
			
			//准备发送消息
			readyToSendEmai(rep, res, session, mlbackHtmlEmailOne,sameUnPayIdList);
		}else{
			mlbackHtmlEmailOne = null;
		}
		
	}
	
	
	private void readyToSendEmai(HttpServletResponse rep,HttpServletRequest res,HttpSession session,MlbackHtmlEmail mlbackHtmlEmailOne, List<Integer> sameUnPayIdList) {
		//把发完的邮件变成状态1
		
		//重复单标记状态2
		for(Integer payinfoIda:sameUnPayIdList){
			
			Integer resifSuccessed = SendOneAndUpdateOne(rep,res,session,mlbackHtmlEmailOne,payinfoIda);
			
			if(resifSuccessed>0){
				
				MlfrontPayInfo mlfrontPayInfoOne = new MlfrontPayInfo();
				mlfrontPayInfoOne.setPayinfoId(payinfoIda);
				mlfrontPayInfoOne.setPayinfoIfEmail(1);
				mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoOne);
			}else{
				System.out.println("本条未发送成功");
			}
			
		}
}

	private Integer SendOneAndUpdateOne(HttpServletResponse rep,HttpServletRequest res,HttpSession session,MlbackHtmlEmail mlbackHtmlEmailOne, Integer payinfoIda) {
		
		//mlbackHtmlEmailOne.get
		//查询本条的orderid,email,生成信息
		MlfrontPayInfo mlfrontPayInfoOne = new MlfrontPayInfo();
		mlfrontPayInfoOne.setPayinfoId(payinfoIda);
		List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoById(mlfrontPayInfoOne);
		if(mlfrontPayInfoList.size()>0){
			//这一单存在
			MlfrontPayInfo mlfrontPayInfoRes = mlfrontPayInfoList.get(0);
			Integer poid = mlfrontPayInfoRes.getPayinfoOid();
			
			MlfrontOrder mlfrontOrderOneReq = new MlfrontOrder();
			mlfrontOrderOneReq.setOrderId(poid);
			List<MlfrontOrder> mlfrontOrderList = mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderOneReq);
			
			if(mlfrontOrderList.size()>0){
				MlfrontOrder mlfrontOrderOne = mlfrontOrderList.get(0);
				
				Integer orderAddressId = mlfrontOrderOne.getOrderAddressinfoId();
				
				MlfrontAddress mlfrontAddressReq = new MlfrontAddress();
				
				mlfrontAddressReq.setAddressId(orderAddressId);
				
				List<MlfrontAddress> mlfrontAddressList = mlfrontAddressService.selectMlfrontAddressByParam(mlfrontAddressReq);
				if(mlfrontAddressList.size()>0){
					MlfrontAddress mlfrontAddressOne = mlfrontAddressList.get(0);
					String UserEmail = mlfrontAddressOne.getAddressEmail();
					
					String htmlProductStr = getOrderProductInfo(mlfrontOrderOne);
					
					//获取链接信息
					String recoverLink = getRecoverLink(rep,res,session,poid);//点击链接
					
					//获取模板信息
					
					String emailContent = getEmailTemplateIfno(UserEmail,recoverLink,mlbackHtmlEmailOne);
					
					

				}else{
					
				}
			}else{
				//该orderid不存在本条没了，没了就不操作
			}
		}else{
			//这一单不存在
		}
		return 0;
	}
	
	
//  String content = "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" style=\"font-family:'黑体',Helvetica,Arial,sans-serif;font-size:14px;background: lightblue;border-radius: 10px;\" width=\"100%\"><tbody><tr>\n" +
//  "\t\t<td style=\"font-family:Helvetica,Arial,sans-serif;font-size:14px;text-align: center;color: white;\">\n" +
//  "\t\t<h3 style=\"margin: 15px 0px;\">页面访问升级中...</h3>\n" +
//  "\t\t<a style=\"display: inline-block;text-decoration:none;width: 150px;height: 40px;background: steelblue;line-height: 40px;color: white;border-radius: 10px;margin-bottom: 20px;\" \n" +
//  "\t\thref=\"xxx\">www.se783.co</a>\n" +
//  "\t\t<hr style=\"color:steelblue;border: 2px solid aliceblue;margin: 5px 20px;border-radius: 10px;\">\n" +
//  "\t\t<h5>温馨提示<br>海外网络永久域名<br>www.se783.co<br>记住防止迷路</h5>\n" +
//  "\t\t<table width=\"100%\" border=\"0\" cellpadding=\"5\" cellspacing=\"0\"><tbody><tr>\n" +
//  "\t\t<td style=\"text-align: right;\">\n" +
//  "\t\t<p style=\"font-size:14px;line-height:24px;font-family: '黑体', sans-serif;padding:0px 10px;margin:8px\">尊敬的访问者：<b>FanX</b></p>\n" +
//  "\t\t<p style=\"color:white;font-size:14px;line-height:24px;font-family:'黑体',Helvetica,Arial,sans-serif;padding:0px 10px;margin:8px\">您的访问次数程度：<span style=\"color:#af5c61;\">99颗星</span> (最高5颗星)</p>\n" +
//  "\t\t</td></tr></tbody></table></td></tr></tbody></table>";

	private String getOrderProductInfo(MlfrontOrder mlfrontOrderOne) {
		
		String orderProductStr="";
		String orderItemIdstr = mlfrontOrderOne.getOrderOrderitemidstr();
		String orderItemArr[] =orderItemIdstr.split(",");
		int orginalItemNum = orderItemArr.length;
		for(int i= 0;i<orginalItemNum;i++){
			String orderItemId = orderItemArr[i];
			MlfrontOrderItem mlfrontOrderItemReq  =new MlfrontOrderItem();
			mlfrontOrderItemReq.setOrderitemId(Integer.parseInt(orderItemId));
			List<MlfrontOrderItem> mlfrontOrderItemResList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemReq);
			if(mlfrontOrderItemResList.size()>0){
				MlfrontOrderItem mlfrontOrderItemOne = mlfrontOrderItemResList.get(0);
				String proImg = mlfrontOrderItemOne.getOrderitemProductMainimgurl();
				String pname = mlfrontOrderItemOne.getOrderitemPname();
				String pmoney = mlfrontOrderItemOne.getOrderitemPskuReamoney();
				orderProductStr+='<tr style="font-size: 16px;">' +
			            '<td align="left" valign="top" style="padding-bottom: 10px;">' +
		              '<img width="100" height="100" src="'+ proImg +'" />' +
		            '</td>' +
		            '<td align="left" valign="top" style="padding-left: 10px; padding-bottom: 10px; max-width: 302px;">'+ pnameImg +'</td>' +
		            '<td align="left" valign="top" style="padding-left: 10px; padding-bottom: 10px;">'+ pmoney +'</td>' +
		          '</tr>';
			}
		}
		
		return null;
	}
	
//	public static String getSendTemp() {
//    
//    String htmlProductStr = "";//getOrderProductInfo();
//    
//    function getOrderProductInfo() {
//        var orderProductStr = '';
//        $('.payinfo .order-item').each(function(idx, item) {
//          var $item = $(item);
//          orderProductStr += '<tr style="font-size: 16px;">' +
//            '<td align="left" valign="top" style="padding-bottom: 10px;">' +
//              '<img width="100" height="100" src="'+ $item.find('img').attr('src') +'" />' +
//            '</td>' +
//            '<td align="left" valign="top" style="padding-left: 10px; padding-bottom: 10px; max-width: 302px;">'+ $item.find('.order-product-link').html() +'</td>' +
//            '<td align="left" valign="top" style="padding-left: 10px; padding-bottom: 10px;">'+ $item.find('.order-product-cal .order-product-money').html() +'</td>' +
//          '</tr>';
//        });
//        return orderProductStr;
//      }
	

	private String getEmailTemplateIfno(String userEmail, String recoverLink, MlbackHtmlEmail mlbackHtmlEmailOne) {
		// TODO Auto-generated method stub
		return "";
		
	}
//
//	@RequestMapping(value="/tosendMlbackHtmlEmailOneContent",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg tosendMlbackHtmlEmailOneContent(@RequestBody MlbackHtmlEmail mlbackHtmlEmail){
//		
//		String content = mlbackHtmlEmail.getHtmlemailSeven();
//		String userEmail = mlbackHtmlEmail.getHtmlemailSix();
//		
//		EmailHtmlUtil.sendHtmlUnCheckoutEmil(userEmail,content) ;
//		
//		
//		Integer payInfoId = mlbackHtmlEmail.getHtmlemailId();
//		
//		MlfrontPayInfo mlfrontPayInfoSMSed = new MlfrontPayInfo();
//		mlfrontPayInfoSMSed.setPayinfoId(payInfoId);
//		mlfrontPayInfoSMSed.setPayinfoIfEmail(1);
//		//2-需要把这一单的payinfo_SMS更新过来
//		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoSMSed);
//		
//		return Msg.success().add("resMsg", "邮件发送成功");
//	}
	
	
	


// 
//	      var recoverLink = getRecoverLink();//点击链接
//	      var etIfno = getEmailTemplateIfno();
//	      
//	      var etIfno = getEmailTemplateIfno();
//	      
//	      
//	      String htmlEmailStr = '<table align="center" border="0" cellpadding="0" cellspacing="0" width="100%" style="max-width: 666px !important;border-collapse: collapse;mso-table-lspace: 0pt;mso-table-rspace: 0pt;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%;border: 0;background-color: #fafafa;"><tbody><tr><td style="padding: 16px;">'+
//	  	        '<table border="0" cellpadding="0" cellspacing="0" width="100%">' +
//	  	          '<tbody>' +
//	  	            '<tr>' +
//	  	              '<td style="padding-left: 16px; padding-right: 16px; border-top: 0; border-bottom: 2px solid #EAEAEA; background-color: #FFFFFF;">' +
//	  	                '<table border="0" cellpadding="0" cellspacing="0" width="100%">' +
//	  	                  '<tbody>' +
//	  	                    '<tr><td align="center" style="padding-top: 40px; padding-bottom: 20px;"><img src="'+ (etIfno && etIfno.htmlemailHeadimgurl) +'" alt="" width="196" style="display: inline-block;"></td></tr>' +
//	  	                    '<tr><td align="center" style="padding: 6px; font-size: 22px; font-weight: bold;">'+ (etIfno && etIfno.htmlemailTitle) +'</td></tr>' +
//	  	                    '<tr><td style="padding: 8px 0; font-size: 18px;">'+ (etIfno && etIfno.htmlemailRetrieve) +'</td></tr>' +
//	  	                    '<tr><td style="padding: 8px 0; font-size: 16px; font-weight: bold;">'+ (etIfno && etIfno.htmlemailRetrievecode && etIfno.htmlemailRetrievecode.replace(/\n/g, '<br>')) +'</td></tr>' +
//	  	                    '<tr>' +
//	  	                      '<td style="padding: 20px 0;">' +
//	  	                        '<table border="0" cellpadding="0" cellspacing="0" width="100%">' + htmlProductStr + '</table>' +
//	  	                      '</td>' +
//	  	                    '</tr>' +
//	  	                    '<tr>' +
//	  	                      '<td align="center" style="padding-bottom: 36px;">' +
//	  	                        '<a href="'+ recoverLink +'" style="display: inline-block; padding: 8px 16px; font-weight:bold; letter-spacing:normal; text-decoration:none; color:#FFFFFF; border-radius: 3px; background-color: #2BAADF;" title="Return to Checkout">Return to Checkout</a>' +
//	  	                      '</td>' +
//	  	                    '</tr>' +
//	  	                  '</tbody>' +
//	  	                '</table>' +
//	  	              '</td>' +
//	  	            '</tr>' +
//	  	            '<tr>' +
//	  	              '<td style="padding-top: 16px; padding-bottom: 8px;">Copyright © 2021 Megalook Hair, All rights reserved.<br>You are receiving this email because you opted in via our website.</td>' +
//	  	            '</tr>' +
//	  	          '</tbody>' +
//	  	        '</table>' +
//	  	      '</td></tr></tbody><table>';
//	      
//	  }
	
	/**
	 * 5.1	zsh20210223
	 * 查看单条类目的详情细节
	 * @param MlbackHtmlEmail
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackHtmlEmailOneAllDetailByName",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackHtmlEmailOneAllDetailByName(@RequestBody MlbackHtmlEmail mlbackHtmlEmailInto){
		
		String htmlemailName = mlbackHtmlEmailInto.getHtmlemailName();
		
		//接受categoryId
		MlbackHtmlEmail MlbackHtmlEmailReq = new MlbackHtmlEmail();
		MlbackHtmlEmailReq.setHtmlemailName(htmlemailName);
		MlbackHtmlEmailReq.setHtmlemailStatus(1);
		//查询本条
		List<MlbackHtmlEmail> mlbackHtmlEmailResList =mlbackHtmlEmailService.selectMlbackHtmlEmailListByName(MlbackHtmlEmailReq);
		MlbackHtmlEmail mlbackHtmlEmailOne = new MlbackHtmlEmail();
		if(mlbackHtmlEmailResList.size()>0){
			mlbackHtmlEmailOne =mlbackHtmlEmailResList.get(0);
		}else{
			mlbackHtmlEmailOne = null;
		}
		return Msg.success().add("resMsg", "查看单条MlbackHtmlEmailOne的详情细节完毕")
					.add("mlbackHtmlEmailOne", mlbackHtmlEmailOne);
	}
	
	public String getRecoverLink(HttpServletResponse rep,HttpServletRequest res,HttpSession session,Integer orderId) {
		Integer checkRecoverOrderId = orderId;
		
		String checkRecoverOrderIdStr = checkRecoverOrderId+"";
		
		String secretOrderIdStr = EncryptUtil.XORencode(checkRecoverOrderIdStr,"megalook");
		
		String websiteStr = getNowWeb(rep,res,session);
		
		String SendSecretStr = websiteStr+"recover/"+secretOrderIdStr+".html";
		
		System.out.println("客服人员点击,生成信息SendSecretStr:"+SendSecretStr);
		
		return SendSecretStr;	
	}
	private String getNowWeb(HttpServletResponse rep, HttpServletRequest res, HttpSession session) {

		//当前服务器路径
		String basePathStr = URLLocationUtils.getbasePathStr(rep,res);
        System.out.println("basePathStr:"+basePathStr);
		return basePathStr;
	}
}
