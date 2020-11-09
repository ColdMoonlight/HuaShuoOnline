package com.atguigu.controller.portal;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.MlPaypalShipAddress;
import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.bean.portal.ToPaypalInfo;
import com.atguigu.common.Msg;
import com.atguigu.enumC.PaypalPaymentIntent;
import com.atguigu.enumC.PaypalPaymentMethod;
import com.atguigu.service.MlPaypalShipAddressService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontUserService;
import com.atguigu.service.PaypalService;
import com.atguigu.utils.DateUtil;
import com.atguigu.utils.PropertiesUtil;
import com.atguigu.utils.URLUtils;
import com.atguigu.utils.EcppIntoUtil;
import com.atguigu.utils.EmailUtilshtml;
import com.atguigu.utils.EmailUtilshtmlCustomer;
import com.atguigu.vo.order;
import com.paypal.api.payments.ErrorDetails;
import com.paypal.api.payments.Links;
import com.paypal.api.payments.PayerInfo;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.Transaction;
import com.paypal.base.rest.PayPalRESTException;

@Controller
@RequestMapping("/paypal")
public class PaypalController {
	//wap端相关路径
	public static final String PAYPAL_SUCCESS_M_URL = "paypal/msuccess";
    public static final String PAYPAL_CANCEL_M_URL = "paypal/mcancel";
    public static final String PAYPAL_SUCCESS_M_URLIn = "msuccess";
    public static final String PAYPAL_CANCEL_M_URLIn = "mcancel";

    private Logger log = LoggerFactory.getLogger(getClass());
    
    @Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
    
    @Autowired
	MlfrontOrderService mlfrontOrderService;
    
    @Autowired
    MlfrontOrderItemService mlfrontOrderItemService;
    
    @Autowired
    MlfrontAddressService mlfrontAddressService;
    
    @Autowired
    MlPaypalShipAddressService mlPaypalShipAddressService;
    
	@Autowired
	MlfrontUserService mlfrontUserService;

    /**1.0
     * 组装参数,WAP端发起真实的支付
     * paypal/mpay
     * */
    @RequestMapping(method = RequestMethod.POST, value = "mpay")
    @ResponseBody
    public Msg pay(HttpServletRequest request,HttpSession session){
    	
    	System.out.println("into**********/paypal/mpay**********");
    	//1.1,准备支付前,从session中读取getPayInfo参数
    	ToPaypalInfo toPaypalInfo = getPayInfo(session);
    	//1.2,准备支付前,从session中获取优惠券减去额度
    	String Shopdiscount = getCouponMoney(session);
    	//1.3,准备支付前,从session中获取地址运费
    	String addressMoney = getAddressMoney(session);
    	//1.4,准备支付前,从session中获取地址信息
    	MlfrontAddress mlfrontAddress = getMlfrontAddress(session);
    	//1.5,准备支付前,从session中获取orderList详情
    	List<MlfrontOrderItem> mlfrontOrderItemList = getMlfrontOrderItemList(session);
    	
    	BigDecimal money = toPaypalInfo.getMoneyNum();
    	String moneyStr = money.toString();
    	Double moneyDouble = Double.parseDouble(moneyStr);
    	String moneyTypeStr = toPaypalInfo.getMoneyType();
    	String payDes = toPaypalInfo.getPaymentDescription();

    	//封装paypal所需
        String cancelUrl = URLUtils.getBaseURl(request) + "/" + PAYPAL_CANCEL_M_URL;
        String successUrl = URLUtils.getBaseURl(request) + "/" + PAYPAL_SUCCESS_M_URL;
        
        Payment payment = new Payment();
        PaypalService paypalService = new PaypalService();
        
        String PaypalErrorName="";
        List<ErrorDetails> paypalErrorList= null;
        try {
            payment = paypalService.createPayment(
            		moneyDouble,// 888.00, 
            		moneyTypeStr, //"USD",  
            		mlfrontAddress,//mlfrontAddress
            		mlfrontOrderItemList,
                    PaypalPaymentMethod.paypal, //paypal
                    PaypalPaymentIntent.sale,//paypal
                    payDes,//"payment description", 
                    Shopdiscount,//"CouponMoney", 
                    addressMoney,//shopping
                    cancelUrl, 
                    successUrl);
            for(Links links : payment.getLinks()){
                if(links.getRel().equals("approval_url")){
                	System.out.println("links.getHref:"+links.getHref());
                    //return "redirect:" + links.getHref();
                	return Msg.success().add("ifPaypalCheckSuccess", 1).add("redirectUrl", links.getHref());
                }
            }
        } catch (PayPalRESTException e) {
            log.error(e.getMessage());
            System.out.println("----------/paypal/mpay/Exception----------");
            System.out.println("---------e.getMessage()-----begin------");
            System.out.println(e.getMessage());
            System.out.println("---------e.getMessage()------end-------");
            System.out.println("---------e.getDetails()-----begin------");
            System.out.println(e.getDetails());
            if(e.getDetails()==null){
            	PaypalErrorName = "retry fails..  check log for more information";
            }else{
            	PaypalErrorName = e.getDetails().getName();
            	paypalErrorList = e.getDetails().getDetails();
            	if(paypalErrorList.size()>1){
            		//city,state,zip不匹配
            		PaypalErrorName = e.getDetails().getDetails()+" city,state,zip 不匹配";
            	}else{
            		//看看是什么
            		String errStr = paypalErrorList.get(0).getField();
//            		String errStrll = errStr.replace(".", ",");
//            		System.out.println("errStrll:"+errStrll);
//            		Integer errLen = errStrll.length();
//            		String lastStr = errStrll;
            		
            		PaypalErrorName = errStr+" 不匹配";
            	}
            }
            System.out.println("---------e.getDetails()------end------");
            return Msg.success().add("ifPaypalCheckSuccess", 2).add("errorDetail", PaypalErrorName);
        }
        return Msg.success().add("ifPaypalCheckSuccess", 0).add("redirectUrl", "MlbackCart/toCheakOut");
    }
    
//    /**1.0
//     * 组装参数,WAP端发起真实的支付
//     * paypal/mpay
//     * */
//    @RequestMapping(method = RequestMethod.GET, value = "mpay")
//    public String pay(HttpServletRequest request,HttpSession session){
//    	System.out.println("into**********/paypal/mpay**********");
//    	//1.1,准备支付前,从session中读取getPayInfo参数
//    	ToPaypalInfo toPaypalInfo = getPayInfo(session);
//    	//1.2,准备支付前,从session中获取优惠券减去额度
//    	String Shopdiscount = getCouponMoney(session);
//    	//1.3,准备支付前,从session中获取地址运费
//    	String addressMoney = getAddressMoney(session);
//    	//1.4,准备支付前,从session中获取地址信息
//    	MlfrontAddress mlfrontAddress = getMlfrontAddress(session);
//    	//1.5,准备支付前,从session中获取orderList详情
//    	List<MlfrontOrderItem> mlfrontOrderItemList = getMlfrontOrderItemList(session);
//    	
//    	BigDecimal money = toPaypalInfo.getMoneyNum();
//    	String moneyStr = money.toString();
//    	Double moneyDouble = Double.parseDouble(moneyStr);
//    	String moneyTypeStr = toPaypalInfo.getMoneyType();
//    	String payDes = toPaypalInfo.getPaymentDescription();
//
//    	//封装paypal所需
//        String cancelUrl = URLUtils.getBaseURl(request) + "/" + PAYPAL_CANCEL_M_URL;
//        String successUrl = URLUtils.getBaseURl(request) + "/" + PAYPAL_SUCCESS_M_URL;
//        
//        Payment payment = new Payment();
//        PaypalService paypalService = new PaypalService();
//        
//        String PaypalErrorName="";
//        PaypalErrorName = (String) session.getAttribute("PaypalErrorName");
//        if(("").equals(PaypalErrorName)){
//        	System.out.println("这是初始化的PaypalErrorName ： "+PaypalErrorName+" .");
//        }else{
//        	session.removeAttribute("PaypalErrorName");
//        }
//        try {
//            payment = paypalService.createPayment(
//            		moneyDouble,// 888.00, 
//            		moneyTypeStr, //"USD",  
//            		mlfrontAddress,//mlfrontAddress
//            		mlfrontOrderItemList,
//                    PaypalPaymentMethod.paypal, //paypal
//                    PaypalPaymentIntent.sale,//paypal
//                    payDes,//"payment description", 
//                    Shopdiscount,//"CouponMoney", 
//                    addressMoney,//shopping
//                    cancelUrl, 
//                    successUrl);
//            for(Links links : payment.getLinks()){
//                if(links.getRel().equals("approval_url")){
//                	System.out.println("links.getHref:"+links.getHref());
//                    return "redirect:" + links.getHref();
//                }
//            }
//        } catch (PayPalRESTException e) {
//            log.error(e.getMessage());
//            System.out.println("----------/paypal/mpay/Exception----------");
//            System.out.println("---------e.getMessage()-----begin------");
//            System.out.println(e.getMessage());
//            System.out.println("---------e.getMessage()------end-------");
//            System.out.println("---------e.getDetails()-----begin------");
//            System.out.println(e.getDetails());
//            //PaypalErrorUtil.getPaypalError(e.getDetails());
//            if(e.getDetails()==null){
//            	PaypalErrorName = "retry fails..  check log for more information";
//            }else{
//            	PaypalErrorName = e.getDetails().getName();
//            }
//            session.setAttribute("PaypalErrorName", PaypalErrorName);
//            String regularName ="";
//            regularName+= " is not match";
//            session.setAttribute("PaypalError", regularName);
//            System.out.println("---------e.getDetails()------end------");
//        }
//        return "redirect:/MlbackCart/toCheakOut";
//    }
    
    /**2.0
     * wap端返回成功页面
     * mfront/paySuccess
     * */
    @RequestMapping(method = RequestMethod.GET, value = PAYPAL_SUCCESS_M_URLIn)
    public String successPay(HttpSession session,@RequestParam("paymentId") String paymentId, @RequestParam("PayerID") String payerId){

    	try {
    		PaypalService paypalService = new PaypalService();
            Payment payment = paypalService.executePayment(paymentId, payerId);
            
            session.setAttribute("successpaymentId", paymentId);
            session.setAttribute("successpayerId", payerId);
            session.setAttribute("successpayment", payment);
            //2.1wap+pc端处理toUpdatePayInfoStateSuccess
            //1生成支付号,2更改payinfo的状态,从返回的payment中获取VIPId=payinfoId
        	toUpdatePayInfoStateSuccess(session,payerId,paymentId,payment);
        	//2.2修改order的状态
        	toUpdateOrderInfoSuccess(session,payment);
        	//输出返回payment信息
            System.out.println(payment.toJSON());
            
            if(payment.getState().equals("approved")){
            	return "redirect:/Success.html";
            }else{
            	return "portal/CartOrderPay/payFail";
            }
        } catch (PayPalRESTException e) {
            log.error(e.getMessage());
            System.out.println("----wap端返回成功接口的Exception-----e.getMessage()-----begin------");
            System.out.println(e.getMessage());
            System.out.println("----wap端返回成功接口的Exception-----e.getMessage()-----end------");
        }
    	return "redirect:/MlbackCart/toCheakOut";
    }

    /**
	 * 1.1读取getPayInfo参数
     * 准备支付前,从session中读取getPayInfo参数
     * */
    private ToPaypalInfo getPayInfo(HttpSession session) {
    	//从session中获取对象
    	MlfrontAddress mlfrontAddressToPay = (MlfrontAddress) session.getAttribute("mlfrontAddressToPay");
    	//从session中获取payinfoId,准备填入Desc中,防止paypal收到钱,却无法查帐
    	Integer payinfoId = (Integer) session.getAttribute("payinfoId");
    	String payinfoIdStr = payinfoId+"";
    	BigDecimal totalprice = (BigDecimal) session.getAttribute("totalprice");
    	ToPaypalInfo toPaypalInfo = new ToPaypalInfo();
		//从对象中获取参数
		String toPayTelephone = mlfrontAddressToPay.getAddressTelephone();
		String toPayCountry = mlfrontAddressToPay.getAddressCountry();
		String toPayProvince = mlfrontAddressToPay.getAddressProvince();
		String toPayCity = mlfrontAddressToPay.getAddressCity();
		String toPayDetail = mlfrontAddressToPay.getAddressDetail();
		String toPayUserfirstname = mlfrontAddressToPay.getAddressUserfirstname();
		String toPayUserlastname = mlfrontAddressToPay.getAddressUserlastname();
		//拼接参数
		String toPayDesc = "";
		toPayDesc+="VIP";
		toPayDesc+=payinfoIdStr+",";
		toPayDesc+=toPayTelephone+",";
		toPayDesc+=toPayCountry+",";
		toPayDesc+=toPayProvince+",";
		toPayDesc+=toPayCity+",";
		toPayDesc+=toPayDetail+",";
		toPayDesc+=toPayUserfirstname+",";
		toPayDesc+=toPayUserlastname;
		toPaypalInfo.setMoneyNum(totalprice);
		toPaypalInfo.setMoneyType("USD");
		toPaypalInfo.setPaymentDescription(toPayDesc);
		return toPaypalInfo;
	}
    /**
	 * 1.2读取优惠信息CouponMoney
     * 准备支付前,从session中获取优惠券减去额度
     * */
	private String getCouponMoney(HttpSession session) {
    	String Shopdiscount = (String) session.getAttribute("CouponCodeMoney");
    	System.out.println("从session中获取优惠券减去额度-Shopdiscount:"+Shopdiscount);
		return Shopdiscount;
	}
	/**
	 * 1.3session中获取运费AddressMoney
     * 准备支付前,从session中获取运费AddressMoney
     * */
    private String getAddressMoney(HttpSession session) {
    	String addressMoney = (String) session.getAttribute("addressMoney");
    	System.out.println("从session中获取地址运费-addressMoney:"+addressMoney);
		return addressMoney;
	}
    /**
     * 1.4从session中获取地址信息
     * 准备支付前,从session中获取地址信息
     * */
    private MlfrontAddress getMlfrontAddress(HttpSession session) {
    	MlfrontAddress mlfrontAddressToPay = (MlfrontAddress) session.getAttribute("mlfrontAddressToPay");
		return mlfrontAddressToPay;
	}
    /**
     * 1.5从session中获取orderList详情
     * 准备支付前,从session中获取orderList详情
     * */
    private List<MlfrontOrderItem> getMlfrontOrderItemList(HttpSession session) {
    	Integer orderId = (Integer) session.getAttribute("orderId");
    	
    	MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
    	mlfrontOrderReq.setOrderId(orderId);
    	List<MlfrontOrder> mlfrontOrderList = mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderReq);
    	//这一行报错了,没查到值
    	MlfrontOrder mlfrontOrderRes = mlfrontOrderList.get(0);//这一行报错
    	//这一行报错了,没查到值
    	String orderitemidstr = mlfrontOrderRes.getOrderOrderitemidstr();
    	String orderitemidArr[] = orderitemidstr.split(",");
    	
    	MlfrontOrderItem mlfrontOrderItemReq = new MlfrontOrderItem();
    	MlfrontOrderItem mlfrontOrderItemRes = new MlfrontOrderItem();
    	
    	List<MlfrontOrderItem> mlfrontOrderItemsList = new ArrayList<MlfrontOrderItem>();
    	for(int i=0;i<orderitemidArr.length;i++){
			Integer orderItemId = Integer.parseInt(orderitemidArr[i]);
			mlfrontOrderItemReq.setOrderitemId(orderItemId);
			List<MlfrontOrderItem> mlfrontOrderItemList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemReq);
			mlfrontOrderItemRes = mlfrontOrderItemList.get(0);
			mlfrontOrderItemsList.add(mlfrontOrderItemRes);
		}
		return mlfrontOrderItemsList;
	}
    
    /**20200611
     * 2.1wap+pc端
     * 处理toUpdatePayInfoStateSuccess
     * 生成支付号,修改支付成功的payinfo状态
     * @param payment 
     * */
    private void toUpdatePayInfoStateSuccess(HttpSession session, String payerId, String paymentId, Payment payment) {
    	//从交易信息中获取Transactions,
    	Transaction TransactionReturn = payment.getTransactions().get(0);
    	//包括交易id,交易标记,支付状态,
    	String transactionId = TransactionReturn.getRelatedResources().get(0).getSale().getId();
    	String paypalDescription =  TransactionReturn.getDescription();
    	String transactionState = TransactionReturn.getRelatedResources().get(0).getSale().getState();
    	//从交易信息中获取PayerInfo,
    	PayerInfo payerInfoReturn = payment.getPayer().getPayerInfo();
		//支付人,name,支付邮箱
    	String paypayEmail = payerInfoReturn.getEmail();
    	String paypayFirstName = payerInfoReturn.getFirstName();
    	String paypayLastName = payerInfoReturn.getLastName();
    	
    	//从交易信息中获取Transactions
    	String paypalDescriptionArr[] = paypalDescription.split(",");
    	String DescVipIdStr = "";
    	String DescIdStr = "";
    	if(paypalDescriptionArr.length>1){
			//1.1如果有多个删除字段中的该项
    		DescVipIdStr = paypalDescriptionArr[0];
		}
    	DescIdStr = DescVipIdStr.replace("VIP", "");
    	Integer payinfoId =  Integer.parseInt(DescIdStr);
    	session.setAttribute("payinfoId", payinfoId);
    	//2.1.1paypal返回的付款地址插入数据库中
    	insertMlPaypalShipAddressInfo(paymentId,DescIdStr,payerInfoReturn);
    	//修改支付单状态
    	MlfrontPayInfo mlfrontPayInfoNew = new MlfrontPayInfo();
		mlfrontPayInfoNew.setPayinfoId(payinfoId);
		List<MlfrontPayInfo> MlfrontPayInfoList =mlfrontPayInfoService.selectMlfrontPayInfoById(mlfrontPayInfoNew);
		MlfrontPayInfo mlfrontPayInfoIOne = MlfrontPayInfoList.get(0);
		//从中取出payOid
		Integer PayOid = mlfrontPayInfoIOne.getPayinfoOid();
		mlfrontPayInfoIOne.setPayinfoStatus(1);//付款成功
		mlfrontPayInfoIOne.setPayinfoPlatformserialcode(payerId);
		String nowTime = DateUtil.strTime14s();
		mlfrontPayInfoIOne.setPayinfoMotifytime(nowTime);
		mlfrontPayInfoIOne.setPayinfoReturntime(nowTime);
		//增加生成字段信息
		String payinfoIdStr = payinfoId+"";
		Integer orderlen = payinfoIdStr.length();
		if(orderlen==6){
			payinfoIdStr = "0"+payinfoIdStr;
		}else if(orderlen==5){
			payinfoIdStr = "00"+payinfoIdStr;
		}else if(orderlen==4){
			payinfoIdStr = "000"+payinfoIdStr;
		}else if(orderlen==3){
			payinfoIdStr = "0000"+payinfoIdStr;
		}else if(orderlen==2){
			payinfoIdStr = "00000"+payinfoIdStr;
		}else if(orderlen==1){
			payinfoIdStr = "000000"+payinfoIdStr;
		}
		String payInfoTime = DateUtil.getDateTime();
		String teamLogo = (String) PropertiesUtil.getProperty("megalook.properties", "teamLogo");
		//  ML(megalook)	HSH(huashuohair)
		String payinfoPlateNum = teamLogo+payInfoTime+payinfoIdStr;
		mlfrontPayInfoIOne.setPayinfoPlatenum(payinfoPlateNum);
		mlfrontPayInfoIOne.setPayinfoTransidnum(transactionId);
		mlfrontPayInfoIOne.setPayinfoTransStatus(transactionState);	
		mlfrontPayInfoIOne.setPayinfoUemail(paypayEmail);
		mlfrontPayInfoIOne.setPayinfoUname(paypayFirstName+" "+paypayLastName);
		
		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoIOne);
		
		//2.1.2准备调用ecpp接口,将客户的付款信息,导入ecpp中
		payInfoIntoEcpp(mlfrontPayInfoIOne);
		session.setAttribute("mlfrontPayInfoIOne", mlfrontPayInfoIOne);
		session.setAttribute("payinfoIdStr", payinfoIdStr);//这个是长串MLXXXXXXXXX0001;
		session.setAttribute("orderId", PayOid);
		
	}

	/**
     * 2.1.1paypal返回的付款地址插入数据库中
     * insertMlPaypalShipAddressInfo
     * 从返回中插入Paypal地址
     * @param payment 
     * */
    private void insertMlPaypalShipAddressInfo(String paymentId, String payinfoIdStr, PayerInfo payerInfoReturn) {
    	
    	MlPaypalShipAddress mlPaypalShipAddressReq = new MlPaypalShipAddress();
    	mlPaypalShipAddressReq.setShippingaddressCountryCode(payerInfoReturn.getShippingAddress().getCountryCode());
    	mlPaypalShipAddressReq.setShippingaddressState(payerInfoReturn.getShippingAddress().getState());
    	mlPaypalShipAddressReq.setShippingaddressCity(payerInfoReturn.getShippingAddress().getCity());
    	mlPaypalShipAddressReq.setShippingaddressPostalCode(payerInfoReturn.getShippingAddress().getPostalCode());
    	mlPaypalShipAddressReq.setShippingaddressLine1(payerInfoReturn.getShippingAddress().getLine1());
    	mlPaypalShipAddressReq.setShippingaddressLine2(payerInfoReturn.getShippingAddress().getLine2());
    	mlPaypalShipAddressReq.setShippingaddressRecipientName(payerInfoReturn.getShippingAddress().getRecipientName());
    	mlPaypalShipAddressReq.setShippingaddressEmail(payerInfoReturn.getEmail());
    	mlPaypalShipAddressReq.setShippingaddressPayinfoid(payinfoIdStr);
    	mlPaypalShipAddressReq.setShippingaddressPaymentid(paymentId);
    	mlPaypalShipAddressService.insertSelective(mlPaypalShipAddressReq);
	}
    
    /**
     * 2.1.2准备调用ecpp接口,将客户的付款信息,导入ecpp中
     * */
    private void payInfoIntoEcpp(MlfrontPayInfo mlfrontPayInfoIn) {
    	
    	Integer payinfoId = mlfrontPayInfoIn.getPayinfoId();
    	
    	MlfrontPayInfo mlfrontPayInfoNew = new MlfrontPayInfo();
		mlfrontPayInfoNew.setPayinfoId(payinfoId);
		List<MlfrontPayInfo> MlfrontPayInfoList =mlfrontPayInfoService.selectMlfrontPayInfoById(mlfrontPayInfoNew);
		MlfrontPayInfo mlfrontPayInfoIOne = MlfrontPayInfoList.get(0);
		System.out.println(mlfrontPayInfoIOne.toString());
		
		//获取orderId
		Integer orderId = mlfrontPayInfoIOne.getPayinfoOid();
		String paypalIdStr = mlfrontPayInfoIOne.getPayinfoTransidnum();
		
		//封装MlfrontOrderReq
		MlfrontOrder mlfrontOrderPayReq = new MlfrontOrder();
		mlfrontOrderPayReq.setOrderId(orderId);
		//查回结果
		List<MlfrontOrder> mlfrontOrderList =  mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderPayReq);
		System.out.println("mlfrontOrderList:"+mlfrontOrderList.toString());
		MlfrontOrder mlfrontOrderResOne = mlfrontOrderList.get(0);
		
		String orderitemidstr = mlfrontOrderResOne.getOrderOrderitemidstr();
		String orderitemidArr[] = orderitemidstr.split(",");
		List<MlfrontOrderItem> mlfrontOrderItemEcppNeedList =new ArrayList<MlfrontOrderItem>();
		for(int x=0;x<orderitemidArr.length;x++){
			MlfrontOrderItem mlfrontOrderItem = new MlfrontOrderItem();
			int orderItemId = Integer .parseInt(orderitemidArr[x]);
			mlfrontOrderItem.setOrderitemId(orderItemId);
			List<MlfrontOrderItem>  mlfrontOrderItemList= mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItem);
			MlfrontOrderItem mlfrontOrderItemRes = mlfrontOrderItemList.get(0);
			mlfrontOrderItemEcppNeedList.add(mlfrontOrderItemRes);
		}
		
		//准备从中获取地址id
		Integer payAddressinfoId = mlfrontOrderResOne.getOrderAddressinfoId();
		MlfrontAddress mlfrontAddress =new MlfrontAddress();
		mlfrontAddress.setAddressId(payAddressinfoId);
		List<MlfrontAddress> mlfrontAddressToPayList = mlfrontAddressService.selectMlfrontAddressByParam(mlfrontAddress);
		
		MlfrontAddress mlfrontAddressToPay = mlfrontAddressToPayList.get(0);
		
		order ecppOrderResult = EcppIntoUtil.getEcppNeedOrder(mlfrontPayInfoIOne,mlfrontOrderResOne,mlfrontOrderItemEcppNeedList,mlfrontAddressToPay);
		
		String token = (String) PropertiesUtil.getProperty("megalook.properties", "ecppToken");
//		String token="Lujia2015200708";
		
		String soapXML = EcppIntoUtil.getXML(token,ecppOrderResult);
		
		String EcppHSNum = "";
		try {
			EcppHSNum = EcppIntoUtil.send(token,soapXML,paypalIdStr);
			
			//将ecpp返回的EcppHSNum,更新入本条mlfrontPayInfo中
	    	
	    	MlfrontPayInfo mlfrontPayInfoEcppreturnReq = new MlfrontPayInfo();
	    	mlfrontPayInfoEcppreturnReq.setPayinfoId(payinfoId);
	    	mlfrontPayInfoEcppreturnReq.setPayinfoEcpphsnum(EcppHSNum);
			mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoEcppreturnReq);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    
	/**
     * 2.2wap/pc端处理toUpdateOrderInfoSuccess
	 * @param payment
     * */
	private void toUpdateOrderInfoSuccess(HttpSession session,Payment payment) {
    	
		//从交易信息中获取Transactions,
    	Transaction TransactionReturn = payment.getTransactions().get(0);
    	//从交易信息的标记记录中获取payinfoId,
    	String paypalDescription =  TransactionReturn.getDescription();
    	String paypalDescriptionArr[] = paypalDescription.split(",");
    	String DescVipIdStr = "";
    	String DescIdStr = "";
    	if(paypalDescriptionArr.length>1){
			//1.1如果有多个删除字段中的该项
    		DescVipIdStr = paypalDescriptionArr[0];
		}
    	DescIdStr = DescVipIdStr.replace("VIP", "");
    	Integer payinfoId =  Integer.parseInt(DescIdStr);
    	
    	MlfrontPayInfo mlfrontPayInfoNew = new MlfrontPayInfo();
		mlfrontPayInfoNew.setPayinfoId(payinfoId);
		List<MlfrontPayInfo> MlfrontPayInfoList =mlfrontPayInfoService.selectMlfrontPayInfoById(mlfrontPayInfoNew);
		MlfrontPayInfo mlfrontPayInfoIOne = MlfrontPayInfoList.get(0);
		//从中取出payOid
		Integer orderId = mlfrontPayInfoIOne.getPayinfoOid();
		//修改order单状态
    	String nowTime = DateUtil.strTime14s();
    	System.out.println("orderId:"+orderId);
		//封装req
		MlfrontOrder mlfrontOrderPayReq = new MlfrontOrder();
		mlfrontOrderPayReq.setOrderId(orderId);
		//查回结果
		List<MlfrontOrder> mlfrontOrderList =  mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderPayReq);
		System.out.println("mlfrontOrderList:"+mlfrontOrderList.toString());
		MlfrontOrder mlfrontOrderResOne = mlfrontOrderList.get(0);
		//准备更新数据
		mlfrontOrderResOne.setOrderStatus(1);
		mlfrontOrderResOne.setOrderMotifytime(nowTime);
		//执行更新
		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderResOne);
		//将付款成功的参数successPayinfoId,successOrderId放入session中
		session.setAttribute("successPayinfoId", payinfoId);
		session.setAttribute("successOrderId", orderId);
		
		String ShippingMoney = TransactionReturn.getRelatedResources().get(0).getSale().getAmount().getDetails().getShipping();;
		String addressMoney = ShippingMoney;
		//2.2.1	wap+pc同时处理邮件
		sendResultEmail(session,mlfrontPayInfoIOne, mlfrontOrderResOne,addressMoney);
		
		//更新用户的vip等级+购买次数
		MlfrontUser mlfrontUser= (MlfrontUser) session.getAttribute("loginUser");
		if(mlfrontUser==null){
			System.out.println("次购买为非注册用户,不对mlfrontUser进行任何操作");
		}else{
			//获取session中的mlfrontUser信息，从中获取userEmail
			String userEmail = mlfrontUser.getUserEmail();
			//拿到userEmail,准备信息
			MlfrontUser mlfrontUserByEmail = new MlfrontUser();
			mlfrontUserByEmail.setUserEmail(userEmail);
			List<MlfrontUser> mlfrontUserByEmailListres =  mlfrontUserService.selectMlfrontUserWhenFirst(mlfrontUserByEmail);
			MlfrontUser mlfrontUserByEmailres = mlfrontUserByEmailListres.get(0);
			Integer uid = mlfrontUserByEmailres.getUserId();
			Integer userTimesOld = mlfrontUserByEmailres.getUserTimes();
			if(userTimesOld==null){
				userTimesOld = 0;
			}
			Integer userTimesafter =userTimesOld+1;
			Integer userVipLevelOld =mlfrontUserByEmailres.getUserViplevel();
			if(userVipLevelOld==null){
				userVipLevelOld = 0;
			}
			Integer userVipLevelafter = userVipLevelOld+1;
			mlfrontUserByEmailres.setUserId(uid);
			mlfrontUserByEmailres.setUserTimes(userTimesafter);
			mlfrontUserByEmailres.setUserViplevel(userVipLevelafter);
			mlfrontUserService.updateByPrimaryKeySelective(mlfrontUserByEmailres);
		}
	}

	/**
     * 2.2.1	wap+pc同时处理邮件
     * */
    private void sendResultEmail(HttpSession session,MlfrontPayInfo mlfrontPayInfoIOne, MlfrontOrder mlfrontOrderResOne, String addressMoney) {
    	try {
    		
    		Integer orderId = mlfrontOrderResOne.getOrderId();
        	List<MlfrontOrderItem> mlfrontOrderItemList = successGetMlfrontOrderItemList(orderId);
        	
        	Integer addressId = mlfrontOrderResOne.getOrderAddressinfoId();
    		MlfrontAddress mlfrontAddressReq = new MlfrontAddress();
    		MlfrontAddress mlfrontAddressRes = new MlfrontAddress();
    		mlfrontAddressReq.setAddressId(addressId);
    		
    		List<MlfrontAddress> mlfrontAddressResList = mlfrontAddressService.selectMlfrontAddressByParam(mlfrontAddressReq);
    		mlfrontAddressRes = mlfrontAddressResList.get(0);
    		String userEmail = mlfrontAddressRes.getAddressEmail();
    		
			//测试方法
			String getToEmail = userEmail;
			String Message = "pay Success</br>,已收到您的付款,会尽快给您安排发货,注意留意发货通知.祝您购物愉快";
			EmailUtilshtml.readyEmailPaySuccess(getToEmail, Message,mlfrontOrderItemList,mlfrontPayInfoIOne,mlfrontOrderResOne,addressMoney);
			EmailUtilshtmlCustomer.readyEmailPaySuccessCustomer(getToEmail, Message,mlfrontOrderItemList,mlfrontPayInfoIOne,mlfrontOrderResOne,addressMoney);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
    
    /**
     * 1.5.2从session中获取orderList详情
     * 支付成功后,用orderId查询orderList详情
     * */
    private List<MlfrontOrderItem> successGetMlfrontOrderItemList(Integer orderId) {
    	
    	MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
    	mlfrontOrderReq.setOrderId(orderId);
    	List<MlfrontOrder> mlfrontOrderList = mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderReq);
    	//这一行报错了,没查到值
    	MlfrontOrder mlfrontOrderRes = mlfrontOrderList.get(0);
    	//这一行报错了,没查到值
    	String orderitemidstr = mlfrontOrderRes.getOrderOrderitemidstr();
    	String orderitemidArr[] = orderitemidstr.split(",");
    	
    	MlfrontOrderItem mlfrontOrderItemReq = new MlfrontOrderItem();
    	MlfrontOrderItem mlfrontOrderItemRes = new MlfrontOrderItem();
    	List<MlfrontOrderItem> mlfrontOrderItemsList = new ArrayList<MlfrontOrderItem>();
    	for(int i=0;i<orderitemidArr.length;i++){
			Integer orderItemId = Integer.parseInt(orderitemidArr[i]);
			mlfrontOrderItemReq.setOrderitemId(orderItemId);
			List<MlfrontOrderItem> mlfrontOrderItemList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemReq);
			mlfrontOrderItemRes = mlfrontOrderItemList.get(0);
			mlfrontOrderItemsList.add(mlfrontOrderItemRes);
		}
		return mlfrontOrderItemsList;
	}

	/**3.0
     * 返回失败page
     * mfront/payFail
     * */
	@RequestMapping(method = RequestMethod.GET, value = PAYPAL_CANCEL_M_URLIn)
    public String cancelPay(HttpSession session){
		
		//返回结算页面,重来即可
        return "redirect:/MlbackCart/toCheakOut";
    }

}