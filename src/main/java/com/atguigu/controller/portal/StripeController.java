package com.atguigu.controller.portal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import static spark.Spark.get;
//import static spark.Spark.post;
//import static spark.Spark.staticFiles;
//import static spark.Spark.port;
import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;
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
    
	/**
	 * 1.0	UseNow	0505
	 * toPaySuccessPage列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toIndexPage")
	public String toPaySuccessPage() throws Exception{
	
		return "portal/cardpayindex";
	}
	
	
	@RequestMapping(method = RequestMethod.POST, value = "/create-payment-intent")
	@ResponseBody
    public String stripePay(HttpSession session,HttpServletResponse response,HttpServletRequest request){
		
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
	
//	
//	@RequestMapping(method = RequestMethod.GET, value = "mpay")
//    public String stripePay(HttpSession session){
//	      
//	      Stripe.apiKey = "sk_test_51HNEjlGgEkMvvUCbQmhbiwmioK5hlLfueCutt7tlYQniSGV7zkZxxXEwbhi0fUL2m83yxPZQ1UaRXS76ZjfCZ0ol00O1WgmFS0";
//
//
//	      port(4242);
//	        Dotenv dotenv = Dotenv.load();
//
//	        Stripe.apiKey = dotenv.get("STRIPE_SECRET_KEY");
//
//	        staticFiles.externalLocation(
//	                Paths.get(Paths.get("").toAbsolutePath().toString(), dotenv.get("STATIC_DIR")).normalize().toString());
//
//	        post("/create-payment-intent", (request, response) -> {
//	            response.type("application/json");
//
//	            CreatePaymentBody postBody = gson.fromJson(request.body(), CreatePaymentBody.class);
//	            PaymentIntentCreateParams createParams = new PaymentIntentCreateParams.Builder()
//	                    .setCurrency(postBody.getCurrency()).setAmount(new Long(calculateOrderAmount(postBody.getItems())))
//	                    .build();
//	            // Create a PaymentIntent with the order amount and currency
//	            PaymentIntent intent = PaymentIntent.create(createParams);
//	            // Send publishable key and PaymentIntent details to client
//	            return gson.toJson(new CreatePaymentResponse(dotenv.get("STRIPE_PUBLISHABLE_KEY"), intent.getClientSecret()));
//	        });
//
//	        post("/webhook", (request, response) -> {
//	            String payload = request.body();
//	            String sigHeader = request.headers("Stripe-Signature");
//	            String endpointSecret = dotenv.get("STRIPE_WEBHOOK_SECRET");
//
//	            Event event = null;
//
//	            try {
//	                event = Webhook.constructEvent(payload, sigHeader, endpointSecret);
//	            } catch (SignatureVerificationException e) {
//	                // Invalid signature
//	                response.status(400);
//	                return "";
//	            }
//
//	            switch (event.getType()) {
//	            case "payment_intent.succeeded":
//	                // Fulfill any orders, e-mail receipts, etc
//	                // To cancel the payment you will need to issue a Refund
//	                // (https://stripe.com/docs/api/refunds)
//	                System.out.println("💰Payment received!");
//	                break;
//	            case "payment_intent.payment_failed":
//	                System.out.println("❌ Payment failed.");
//	                break;
//	            default:
//	                // Unexpected event type
//	                response.status(400);
//	                return "";
//	            }
//
//	            response.status(200);
//	            return "";
//	        });
//			return "";
//	}
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