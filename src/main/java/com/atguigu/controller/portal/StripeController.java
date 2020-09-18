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
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.portal.ToPaypalInfo;
import com.atguigu.service.MlPaypalShipAddressService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontUserService;
//import static spark.Spark.get;
//import static spark.Spark.post;
//import static spark.Spark.staticFiles;
//import static spark.Spark.port;
import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;
import com.paypal.api.payments.Amount;
import com.paypal.api.payments.Details;
import com.paypal.api.payments.Item;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Metadata;
import com.stripe.Stripe;
import com.stripe.model.Event;
import com.stripe.model.PaymentIntent;
import com.stripe.exception.*;
import com.stripe.net.Webhook;
import com.stripe.param.PaymentIntentCreateParams;
import com.stripe.param.PaymentIntentCreateParams.ConfirmationMethod;

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
//  		demo:	item.setName(name).setQuantity("1").setCurrency("USD").setPrice(money);
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
  		
  		String amTotal = getamountTotal(subMoney,Shopdiscount,addressMoney);
  		amount.setTotal(amTotal);
  		amount.setDetails(details);
//  		transaction.setAmount(amount);
//  		transaction.setItemList(itemList);
		
		
		Stripe.apiKey = "sk_test_51HNEjlGgEkMvvUCbQmhbiwmioK5hlLfueCutt7tlYQniSGV7zkZxxXEwbhi0fUL2m83yxPZQ1UaRXS76ZjfCZ0ol00O1WgmFS0";
		
		//接收参数
//		CreatePaymentBody postBody = gson.fromJson(request.body(), CreatePaymentBody.class);
		
		Metadata metadata = new Metadata();
		//metadata.s
		//
//		ConfirmationMethod ConfirmationMethod = null;
        PaymentIntentCreateParams createParams = new PaymentIntentCreateParams.Builder()
                .setCurrency("usd").setAmount((long)136)
//                .setDescription("userEmail").setConfirm(true).setConfirmationMethod(ConfirmationMethod.MANUAL)
                .build();
        // Create a PaymentIntent with the order amount and currency
		try {
			PaymentIntent intent = PaymentIntent.create(createParams);
			return gson.toJson(new CreatePaymentResponse("pk_test_51HNEjlGgEkMvvUCbMCN9IWPKBXCZv6ldWEq3XdnEGX9MtF3NqE3WfzQ6xZtLiYfiXdZh5F7gqkHAzKfm5s0OuSew00FQWoN8UA", intent.getClientSecret()));
		} catch (StripeException e) {
			// TODO Auto-generated catch block
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

//	
//	public static void main(String[] args) {
//        port(4242);
//        Dotenv dotenv = Dotenv.load();
//
////        Stripe.apiKey = dotenv.get("STRIPE_SECRET_KEY");
//        Stripe.apiKey = "sk_test_51HNEjlGgEkMvvUCbQmhbiwmioK5hlLfueCutt7tlYQniSGV7zkZxxXEwbhi0fUL2m83yxPZQ1UaRXS76ZjfCZ0ol00O1WgmFS0";
//
//        staticFiles.externalLocation(
//                Paths.get(Paths.get("").toAbsolutePath().toString(), dotenv.get("STATIC_DIR")).normalize().toString());
//
//        post("/create-payment-intent", (request, response) -> {
//            response.type("application/json");
//
//            CreatePaymentBody postBody = gson.fromJson(request.body(), CreatePaymentBody.class);
//            PaymentIntentCreateParams createParams = new PaymentIntentCreateParams.Builder()
//                    .setCurrency(postBody.getCurrency()).setAmount(new Long(calculateOrderAmount(postBody.getItems())))
//                    .build();
//            // Create a PaymentIntent with the order amount and currency
//            //使用订单金额和币种创建PaymentIntent
//            PaymentIntent intent = PaymentIntent.create(createParams);
//            // Send publishable key and PaymentIntent details to client
//            //将可发布的密钥和PaymentIntent详细信息发送给客户端
//            return gson.toJson(new CreatePaymentResponse(dotenv.get("STRIPE_PUBLISHABLE_KEY"), intent.getClientSecret()));
//        });
//
//        post("/webhook", (request, response) -> {
//            String payload = request.body();
//            String sigHeader = request.headers("Stripe-Signature");
//            String endpointSecret = dotenv.get("STRIPE_WEBHOOK_SECRET");
//
//            Event event = null;
//
//            try {
//                event = Webhook.constructEvent(payload, sigHeader, endpointSecret);
//            } catch (SignatureVerificationException e) {
//                // Invalid signature
//            	//无效的签名
//                response.status(400);
//                return "";
//            }
//
//            switch (event.getType()) {
//            case "payment_intent.succeeded":
//                // Fulfill any orders, e-mail receipts, etc
//                // To cancel the payment you will need to issue a Refund
//            	//完成所有订单，电子邮件回执等
//            	//要取消付款，您将需要退款
//                // (https://stripe.com/docs/api/refunds)
//                System.out.println("💰Payment received!");
//                break;
//            case "payment_intent.payment_failed":
//                System.out.println("❌ Payment failed.");
//                break;
//            default:
//                // Unexpected event type
//            	//意外的事件类型
//                response.status(400);
//                return "";
//            }
//
//            response.status(200);
//            return "";
//        });
//    }


}