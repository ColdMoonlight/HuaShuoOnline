package com.atguigu.controller.portal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.math.BigDecimal;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.bean.portal.ToPaypalInfo;
import com.atguigu.common.Msg;
import com.atguigu.service.MlPaypalShipAddressService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontUserService;
import com.atguigu.utils.DateUtil;
import com.atguigu.utils.EcppIntoUtil;
import com.atguigu.utils.EmailUtilshtml;
import com.atguigu.utils.EmailUtilshtmlCustomer;
import com.atguigu.utils.PropertiesUtil;
import com.atguigu.vo.order;
import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Metadata;
import com.stripe.Stripe;
import com.stripe.model.Address;
import com.stripe.model.Event;
import com.stripe.model.PaymentIntent;
import com.stripe.model.PaymentIntent.PaymentMethodOptions;
import com.stripe.param.PaymentIntentConfirmParams.PaymentMethodData.BillingDetails;
//import com.stripe.model.issuing.Card.Shipping;
//import com.stripe.param.PaymentIntentCreateParams.Shipping;
//import com.stripe.param.PaymentIntentConfirmParams.PaymentMethodData.BillingDetails.Address;
import com.stripe.exception.*;
import com.stripe.net.Webhook;
import com.stripe.param.PaymentIntentConfirmParams;
import com.stripe.param.PaymentIntentCreateParams.PaymentMethodData;
import com.stripe.param.PaymentIntentCreateParams;
import com.stripe.param.PaymentIntentCreateParams.ConfirmationMethod;
import com.stripe.param.PaymentIntentCreateParams.Shipping;

import io.github.cdimascio.dotenv.Dotenv;
import spark.Request;
import spark.Response;

@Controller
@RequestMapping("/stripe")
public class StripeController {
	//wap端相关路径
	public static final String PAYPAL_SUCCESS_M_URL = "stripe/msuccess";
    public static final String PAYPAL_CANCEL_M_URL = "stripe/mcancel";
    public static final String PAYPAL_SUCCESS_M_URLIn = "stripe";
    public static final String PAYPAL_CANCEL_M_URLIn = "stripe";

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
	
	private static Gson gson = new Gson();
	
	static class CreatePaymentBody {
        @SerializedName("items")
        Object[] items;

        @SerializedName("currency")
        String currency;//字符串货币；

        public Object[] getItems() {
            return items;
        }

        public String getCurrency() {
            return currency;
        }
    }

	static class CreatePaymentResponse {
        private String publishableKey;
        private String clientSecret;

        public CreatePaymentResponse(String publishableKey, String clientSecret) {
            this.publishableKey = publishableKey;
            this.clientSecret = clientSecret;
        }
    }
    static int calculateOrderAmount(Object[] items) {
        // Replace this constant with a calculation of the order's amount
        // Calculate the order total on the server to prevent
        // users from directly manipulating the amount on the client
    	//将该常量替换为订单金额的计算
        //计算服务器上的订单总数以防止
        //用户直接在客户端上操纵金额
        return 1400;
    }
	
	@RequestMapping(method = RequestMethod.POST, value = "/create-payment-intent")
	@ResponseBody
    public String stripePay(HttpSession session,HttpServletResponse response,HttpServletRequest request,@RequestBody MlfrontPayInfo mlfrontPayInfoInto){
		
		Integer payinfoid = mlfrontPayInfoInto.getPayinfoId();
		
		Integer orderid = mlfrontPayInfoInto.getPayinfoOid();
		
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
    	
    	String subMoney = "";
    	
    	ItemList itemList = new ItemList();
  		if(mlfrontOrderItemList.size()>1){
  			itemList = getItemList(mlfrontOrderItemList);
  			subMoney = getItemListsMoney(mlfrontOrderItemList);
  		}else{
  			MlfrontOrderItem mlfrontOrderItem = mlfrontOrderItemList.get(0);
  			Item item = new Item();
  			String name=mlfrontOrderItem.getOrderitemPname();
//  			if(name.length()>40){
//  				name= name.substring(0, 40);
  				name=name+"...";
//  			}
  			Integer skuNum=mlfrontOrderItem.getOrderitemPskuNumber();
  			String skuNumStr = skuNum+"";
  			String money = mlfrontOrderItem.getOrderitemPskuReamoney();
  			String oneMoney = getOnemoney(skuNum,money);
  			item.setName(name).setQuantity(skuNumStr).setCurrency("USD").setPrice(oneMoney);
  			money = getOneAllMoney(skuNum,oneMoney);
  			subMoney = money;
  			List<Item> items = new ArrayList<Item>();
  			items.add(item);
  			itemList.setItems(items);
  		}
  		
  		Details details = new Details();
  		details.setShipping("0");
  		details.setSubtotal(subMoney);
  		details.setTax("0");//税
  		String shopdiscountMoney = "-"+Shopdiscount;
  		details.setShippingDiscount(shopdiscountMoney);
  		details.setShipping((addressMoney));

  		// ###Amount
  		// Let's you specify a payment amount.
  		Amount amount = new Amount();
  		amount.setCurrency("USD");
  		// Total must be equal to sum of shipping, tax and subtotal.
  		
  		
  		//实际需要付款的钱
  		String amTotal = getamountTotal(subMoney,Shopdiscount,addressMoney);
  		
  		//转bigD
  		BigDecimal amTotalBig = new BigDecimal(amTotal);
  		
  		BigDecimal amTotalBigFen =  amTotalBig.multiply(new BigDecimal(100));
//  		DecimalFormat df1 = new DecimalFormat("0");
//  		String amTotalFen = df1.format(amTotalBigFen);
  		
  		Long amTotalFen = amTotalBigFen.longValue();
  		
  		amount.setTotal(amTotal);
  		amount.setDetails(details);
  		System.out.println(amount.toJSON());
//  		transaction.setAmount(amount);
//  		transaction.setItemList(itemList);
		
		
		Stripe.apiKey = "sk_test_51HNEjlGgEkMvvUCbQmhbiwmioK5hlLfueCutt7tlYQniSGV7zkZxxXEwbhi0fUL2m83yxPZQ1UaRXS76ZjfCZ0ol00O1WgmFS0";
		
		//接收参数
//		CreatePaymentBody postBody = gson.fromJson(request.body(), CreatePaymentBody.class);
		//
//		ConfirmationMethod ConfirmationMethod = null;
//		BillingDetails billingDetails = new BillingDetails();
//		BillingDetails.setName("");
//		BillingDetails.setEmail("");
//		BillingDetails.setPhone("");
//		Address address = new Address();
//		address.setLine1("");
//		BillingDetails.setAddress(address);
		//paymentMethodData.getBillingDetails();
		
//		PaymentMethodData aaa = PaymentMethodData.builder().setBillingDetails("");
//		com.stripe.param.PaymentIntentCreateParams.PaymentMethodData PaymentMethodOptionsaa = new PaymentMethodData();
//		Address shipingaddress = null; 
		//shipingaddress
		//Shipping shipping = new Shipping(shipingaddress, amTotal, null, amTotal, amTotal, amTotal);
//		Shipping.builder().setAddress(address)
        PaymentIntentCreateParams createParams = new PaymentIntentCreateParams.Builder()
                .setCurrency("usd").setAmount(amTotalFen).addPaymentMethodType("card").setReceiptEmail(mlfrontAddress.getAddressEmail())
                .setDescription(toPaypalInfo.getPaymentDescription())
                //.setMandate(mandate)
                //.setPaymentMethodData(paymentMethodData)
                //.setConfirm(true).setReturnUrl("https://megalook.com/success.html")初始化的时候
                //.setCustomer("zsh1020064691@qq.com")
                //.setShipping(shipping)
                .build();
        // Create a PaymentIntent with the order amount and currency
		try {
			PaymentIntent intent = PaymentIntent.create(createParams);
//			return gson.toJson(new CreatePaymentResponse("pk_test_51HNEjlGgEkMvvUCbMCN9IWPKBXCZv6ldWEq3XdnEGX9MtF3NqE3WfzQ6xZtLiYfiXdZh5F7gqkHAzKfm5s0OuSew00FQWoN8UA", intent.getClientSecret()));
			CreatePaymentResponse paymentResponse = new CreatePaymentResponse("pk_test_51HNEjlGgEkMvvUCbMCN9IWPKBXCZv6ldWEq3XdnEGX9MtF3NqE3WfzQ6xZtLiYfiXdZh5F7gqkHAzKfm5s0OuSew00FQWoN8UA", intent.getClientSecret());
		    return gson.toJson(paymentResponse);
		} catch (StripeException e) {
			e.printStackTrace();
		}
        // Send publishable key and PaymentIntent details to client
		return "";
		
	}
	
	private String getamountTotal(String subMoney, String shopdiscount, String addressMoney) {
		
		Double subMoneyDou = Double.parseDouble(subMoney);
		
		Double shopdiscountDou = Double.parseDouble(shopdiscount);
		
		Double addressMoneyDou = Double.parseDouble(addressMoney);
		
		Double amountTotalDou = subMoneyDou - shopdiscountDou + addressMoneyDou;
		
		String amountTotalDouStr = (String.format("%.2f", amountTotalDou));
		
		return amountTotalDouStr;
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
		String toPayUserfirstname = mlfrontAddressToPay.getAddressUserfirstname();
		String toPayUserlastname = mlfrontAddressToPay.getAddressUserlastname();
		String toPayUserEmail = mlfrontAddressToPay.getAddressEmail();
		//拼接参数
		String toPayDesc = "";
		toPayDesc+="VIP";
		toPayDesc+=payinfoIdStr+",";
		toPayDesc+=toPayTelephone+",";
		toPayDesc+=toPayUserEmail+",";
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
    
    private ItemList getItemList(List<MlfrontOrderItem> mlfrontOrderItemList) {
		ItemList itemList = new ItemList();
		List<Item> items = new ArrayList<Item>();
		//System.out.println("paypalService中的结算单子的详情"+mlfrontOrderItemList.toString());
		for(MlfrontOrderItem mlfrontOrderItem:mlfrontOrderItemList){
			Item item = new Item();
			String name=mlfrontOrderItem.getOrderitemPname();
//			if(name.length()>40){
 // 				name= name.substring(0, 40);
  				name=name+"...";
//  			}
			Integer skuNum=mlfrontOrderItem.getOrderitemPskuNumber();
			String skuNumStr = skuNum+"";
			String money = mlfrontOrderItem.getOrderitemPskuReamoney();
			String oneMoney =getOnemoney(skuNum,money);
			item.setName(name).setQuantity(skuNumStr).setCurrency("USD").setPrice(oneMoney);
			money = getOneAllMoney(skuNum,oneMoney);
			
			items.add(item);
        }
		itemList.setItems(items);
		return itemList;
	}
    
    private String getItemListsMoney(List<MlfrontOrderItem> mlfrontOrderItemList) {
		
		Double MoneyDuball=new Double("0.00");
		for(MlfrontOrderItem mlfrontOrderItem:mlfrontOrderItemList){
			String name=mlfrontOrderItem.getOrderitemPname();
			if(name.length()>40){
  				name= name.substring(0, 40);
  				name=name+"...";
  			}
			Integer skuNum=mlfrontOrderItem.getOrderitemPskuNumber();
			String money = mlfrontOrderItem.getOrderitemPskuReamoney();
			String oneMoney =getOnemoney(skuNum,money);
			money = getOneAllMoney(skuNum,oneMoney);
			Double MoneyDub=new Double(money);
			MoneyDuball=MoneyDuball+ MoneyDub;
			
        }
		String OneAllMoney = String.format("%.2f", MoneyDuball);
		return OneAllMoney;
	}
    
    private String getOneAllMoney(Integer skuNum, String oneMoney) {
		Double oneMoneyDou = new Double(oneMoney);
		Double OneAllM = oneMoneyDou*skuNum;
		String OneAllMoney = String.format("%.2f", OneAllM);
		return OneAllMoney;
	}

	private String getOnemoney(Integer skuNum, String money) {
		System.out.println("paypalService中的:getOnemoney"+money+",skuNum:"+skuNum);
		Double moneyAll = new Double(money);
		System.out.println("paypalService中的Double moneyAll = new Double(money)+moneyAll:"+moneyAll);
		Double oneM = moneyAll/skuNum;
		String Onemoney = String.format("%.2f", oneM);
		return Onemoney;
	}

	/**2.0
     * wap端返回成功页面
     * mfront/paySuccess
     * */
    @RequestMapping(method = RequestMethod.POST, value = "/cardSuccessInfo")
	@ResponseBody
    public Msg successPay(HttpSession session,@RequestParam("payinfoId") Integer payinfoId, @RequestParam("CardID") String CardID){

    	try {
            session.setAttribute("successpayinfoId", payinfoId);
            session.setAttribute("successCardID", CardID);
            //2.1wap+pc端处理toUpdatePayInfoStateSuccess
            //1生成支付号,2更改payinfo的状态,从返回的payment中获取VIPId=payinfoId
        	toUpdatePayInfoStateCardSuccess(session,payinfoId,CardID);
        	//2.2修改order的状态
        	toUpdateOrderInfoCardSuccess(session,payinfoId,CardID);
        	return Msg.success().add("updateStatus", 1);
        } catch (Exception e) {
            log.error(e.getMessage());
            System.out.println("----wap端返回成功接口的Exception-----e.getMessage()-----begin------");
            System.out.println(e.getMessage());
            System.out.println("----wap端返回成功接口的Exception-----e.getMessage()-----end------");
            return Msg.success().add("updateStatus", 0);
        }
    }
    
    /**20200611
     * 2.1wap+pc端
     * 处理toUpdatePayInfoStateSuccess
     * 生成支付号,修改支付成功的payinfo状态
     * @param payment 
     * */
    private void toUpdatePayInfoStateCardSuccess(HttpSession session, Integer payinfoIdInto, String CardID) {
    	
    	Integer payinfoId =  payinfoIdInto;
    	session.setAttribute("payinfoId", payinfoId);
    	//修改支付单状态
    	MlfrontPayInfo mlfrontPayInfoNew = new MlfrontPayInfo();
		mlfrontPayInfoNew.setPayinfoId(payinfoId);
		List<MlfrontPayInfo> MlfrontPayInfoList =mlfrontPayInfoService.selectMlfrontPayInfoById(mlfrontPayInfoNew);
		MlfrontPayInfo mlfrontPayInfoIOne = MlfrontPayInfoList.get(0);
		//从中取出payOid
		Integer PayOid = mlfrontPayInfoIOne.getPayinfoOid();
		
		MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
		mlfrontOrderReq.setOrderId(PayOid);
		
		List<MlfrontOrder> mlfrontOrderList = mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderReq);
		MlfrontOrder mlfrontOrderOne = mlfrontOrderList.get(0);
		
    	String CardpayEmail = mlfrontOrderOne.getOrderAddressinfoUemail();
    	String CardUName = mlfrontOrderOne.getOrderAddressinfoUname();
		
		mlfrontPayInfoIOne.setPayinfoStatus(1);//付款成功
		mlfrontPayInfoIOne.setPayinfoPlatformserialcode(CardID);
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
		mlfrontPayInfoIOne.setPayinfoTransidnum(CardID);
		mlfrontPayInfoIOne.setPayinfoTransStatus("succeeded");	
		mlfrontPayInfoIOne.setPayinfoUemail(CardpayEmail);
		mlfrontPayInfoIOne.setPayinfoUname(CardUName);
		
		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoIOne);
		
		//2.1.2准备调用ecpp接口,将客户的付款信息,导入ecpp中
		payInfoIntoEcpp(mlfrontPayInfoIOne);
		session.setAttribute("mlfrontPayInfoIOne", mlfrontPayInfoIOne);
		session.setAttribute("payinfoIdStr", payinfoIdStr);//这个是长串MLXXXXXXXXX0001;
		session.setAttribute("orderId", PayOid);
		
	}
    
    /**
     * 2.2wap/pc端处理toUpdateOrderInfoSuccess
	 * @param payment
     * */
	private void toUpdateOrderInfoCardSuccess(HttpSession session,Integer payinfoIdInto,String CardID) {
    	
    	Integer payinfoId =  payinfoIdInto;
    	
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
		
		String ShippingMoney = (String) session.getAttribute("addressMoney");
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

}