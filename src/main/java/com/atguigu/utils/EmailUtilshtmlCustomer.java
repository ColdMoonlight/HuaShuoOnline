package com.atguigu.utils;

import java.math.BigDecimal;
import java.security.Security;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.MlfrontUser;
public class EmailUtilshtmlCustomer {
	
	/**
     * @Method: readyEmail----Fictitious
     * @Description: 准备发邮件的服务器等相关身份资料
     * @Anthor:zsh
     * @param session
     * @return
     * @throws Exception
     */ 
	public static void readyEmailRegisterCustomer(String getToEmail, String Message, MlfrontUser mlfrontUserafterIn)  throws Exception{
		sendEmilRegisterCustomer(getToEmail, Message, mlfrontUserafterIn);
	}
	
	public static void readyEmailPaySuccessCustomer(String getToEmail, String Message,List<MlfrontOrderItem> mlfrontOrderItemList,MlfrontPayInfo mlfrontPayInfoIOne, MlfrontOrder mlfrontOrderResOne, String addressMoney)  throws Exception{
		sendEmilPayCustomer(getToEmail, Message, mlfrontOrderItemList,mlfrontPayInfoIOne,mlfrontOrderResOne,addressMoney);
	}
	
	public static void readyEmailAbandoningPurchaseCustomer(String getToEmail, String toCustomerAbandoningPurchaseStr) {
		sendEmilAbandoningPurchaseCustomer(getToEmail,toCustomerAbandoningPurchaseStr);
	}

	/*
	 * Register通知Customer
	 * megalookweb@outlook.com
	 * mingyueqingl@163.com
	 * */
	public static void sendEmilRegisterCustomer(String to, String message,MlfrontUser mlfrontUserafterIn) {
        try {
            Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
            final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
            //设置邮件会话参数
            Properties props = new Properties();
            //邮箱的发送服务器地址
            props.setProperty("mail.smtp.host", "smtp.138mail.net");
            props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            //邮箱发送服务器端口,这里设置为465端口
            props.setProperty("mail.smtp.port", "465");
            props.setProperty("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.auth", "true");
            /*final String username = "发送者邮箱用户名";
            final String password = "发送者邮箱密码或者邮箱授权码";*/
//          final String username = "service@megalook.com";//megalook
//          final String password = "DfcorpKXl6CbH1It";         
//          final String username = "sales@megalook.com";//huashuohair
//          final String password = "qPVGjvIM6wXVSsFn";
            String username = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.username");
            String password = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.userhighpwd");
            //获取到邮箱会话,利用匿名内部类的方式,将发送者邮箱用户名和密码授权给jvm
            Session session = Session.getDefaultInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            //读取配置文件
    		String team = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.team");
    		String email = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.email");
    		String whatsapp = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.whatsapp");
    		String Telephone = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.Telephone");
            String content="Thank you for your registr in Megalook ,Here is your account number and password：<br><br><br>  "+
            "Account number:"+mlfrontUserafterIn.getUserEmail()+" <br>"+
            "password:"+mlfrontUserafterIn.getUserPassword()+" <br><br>"+
            "Wishing you a pleasant shopping trip. <br><br>"+
            "Best Regards,<br>"+
            "------------------------------------------<br>"+
	  		team+"<br>"+
	  		"Email:"+email+"<br>"+
	  		"Whatsapp:"+whatsapp+"<br>"+
	  		"Telephone/SMS:"+Telephone+"<br>";
            //通过会话,得到一个邮件,用于发送
            MimeMessage  msg = new MimeMessage(session);
            //设置发件人
//          msg.setFrom(new InternetAddress("发件人邮箱"));
//          msg.setFrom(new InternetAddress("service@megalook.com"));//megalook
//          msg.setFrom(new InternetAddress("sales@megalook.com"));//huashuohair
            String sendEmail = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.username");
            msg.setFrom(new InternetAddress(sendEmail));
            //设置收件人,to为收件人,cc为抄送,bcc为密送
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Welcome to Register Megalook.");
            
            Multipart mp = new MimeMultipart("related"); 
            BodyPart bodyPart = new MimeBodyPart(); 
            bodyPart.setDataHandler(new DataHandler(content,"text/html;charset=UTF-8"));
            mp.addBodyPart(bodyPart); 
            msg.setContent(mp);// 设置邮件内容对象 
            
            //设置发送的日期
            msg.setSentDate(new Date());
            //调用Transport的send方法去发送邮件
            Transport.send(msg);
            //System.out.println("给"+to+"客户,发送邮件完毕,"+"邮件内容为"+message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	/*
	 * Pay通知Customer
	 * megalookweb@outlook.com
	 * mingyueqingl@163.com
	 * */
	public static void sendEmilPayCustomer(String to, String message,List<MlfrontOrderItem> mlfrontOrderItemList,MlfrontPayInfo mlfrontPayInfoIOne, MlfrontOrder mlfrontOrderResOne, String addressMoney) {
        try {
            Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
            final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
            //设置邮件会话参数
            Properties props = new Properties();
            //邮箱的发送服务器地址
            props.setProperty("mail.smtp.host", "smtp.138mail.net");
            props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            //邮箱发送服务器端口,这里设置为465端口
            props.setProperty("mail.smtp.port", "465");
            props.setProperty("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.auth", "true");
            /*final String username = "发送者邮箱用户名";
            final String password = "发送者邮箱密码或者邮箱授权码";*/
//          final String username = "service@megalook.com";//megalook
//          final String password = "DfcorpKXl6CbH1It";         
//          final String username = "sales@megalook.com";//huashuohair
//          final String password = "qPVGjvIM6wXVSsFn";
            String username = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.username");
            String password = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.userhighpwd");
            //获取到邮箱会话,利用匿名内部类的方式,将发送者邮箱用户名和密码授权给jvm
            Session session = Session.getDefaultInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });

            String pdetail ="";
            for(MlfrontOrderItem mlfrontOrderItem :mlfrontOrderItemList){
            	String Pname = mlfrontOrderItem.getOrderitemPname();
            	Integer Pnumber = mlfrontOrderItem.getOrderitemPskuNumber();
            	String Psku = mlfrontOrderItem.getOrderitemPskuName();
            	String pAllmoney = mlfrontOrderItem.getOrderitemPskuReamoney();
            	
            	pdetail=pdetail+Pnumber+" x "+Pname+" ( "+Psku+" )   "+pAllmoney+"<br><br>";
            	
            }
            
            String SubTotal = getSubTotal(mlfrontPayInfoIOne.getPayinfoMoney(),addressMoney,mlfrontOrderResOne.getOrderCouponPrice());
            
            String CouponCodeStr ="";
            
            if(mlfrontOrderResOne.getOrderCouponCode()!=null){
            	CouponCodeStr = "Coupon"+" ( "+mlfrontOrderResOne.getOrderCouponCode()+" ) : -$"+mlfrontOrderResOne.getOrderCouponPrice()+" <br>";
            }else{
            	CouponCodeStr ="";
            }
            //读取配置文件
    		String team = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.team");
    		String email = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.email");
    		String whatsapp = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.whatsapp");
    		String Telephone = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.Telephone");
            
            String content="Hi gorgeous girl.<br><br>  "+
            "Here is Megalook Hair . We have received your order and confirmed your payment.：<br><br>  "+
            "Order ID :"+mlfrontPayInfoIOne.getPayinfoPlatenum()+" <br>"+
            "Date Added :"+mlfrontOrderItemList.get(0).getOrderitemMotifytime()+" <br>"+
            "Order Status : Payment completed, order processing... <br><br>"+
            "Products:<br><br> "+
            pdetail+"<br> "+
            "payment details :<br><br> "+
            "products-Total: $"+SubTotal+" <br>"+
            "Free Shipping: $"+addressMoney+"<br>"+
            CouponCodeStr +
            "Sub-Total: $"+mlfrontPayInfoIOne.getPayinfoMoney()+" <br><br><br>"+
            "Best Regards,<br>"+
            "------------------------------------------<br>"+
	  		team+"<br>"+
	  		"Email:"+email+"<br>"+
	  		"Whatsapp:"+whatsapp+"<br>"+
	  		"Telephone/SMS:"+Telephone+"<br>";
            
            //通过会话,得到一个邮件,用于发送
            MimeMessage msg = new MimeMessage(session);
            //设置发件人
//          msg.setFrom(new InternetAddress("发件人邮箱"));
//          msg.setFrom(new InternetAddress("service@megalook.com"));//megalook
//          msg.setFrom(new InternetAddress("sales@megalook.com"));//huashuohair
            String sendEmail = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.username");
            msg.setFrom(new InternetAddress(sendEmail));
            //设置收件人,to为收件人,cc为抄送,bcc为密送
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Order Confirmation From Megalook Hair.");
            
            Multipart mp = new MimeMultipart("related");
            BodyPart bodyPart = new MimeBodyPart();
            bodyPart.setDataHandler(new DataHandler(content,"text/html;charset=UTF-8"));
            mp.addBodyPart(bodyPart);
         // 设置邮件内容对象 
            msg.setContent(mp);
            //设置发送的日期
            msg.setSentDate(new Date());
            //调用Transport的send方法去发送邮件
            Transport.send(msg);
            System.out.println("给"+to+"客户,发送邮件完毕,"+"邮件内容为"+content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	private static String getSubTotal(BigDecimal payinfoMoney, String addressMoney, BigDecimal orderCouponPrice) {
		//总钱数=物价+运费-优惠
		//原价=总价+优惠-运费
		BigDecimal SubTotal = payinfoMoney.add(orderCouponPrice);
		BigDecimal addressMoneyBig = new BigDecimal(addressMoney);
		SubTotal=SubTotal.subtract(addressMoneyBig);
		DecimalFormat df1 = new DecimalFormat("0.00");
		String SubTotalStr = df1.format(SubTotal);
		return SubTotalStr;
	}

	private static void sendEmilAbandoningPurchaseCustomer(String to, String toCustomerAbandoningPurchaseStr) {
		try {
            Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
            final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
            //设置邮件会话参数
            Properties props = new Properties();
            //邮箱的发送服务器地址
            props.setProperty("mail.smtp.host", "smtp.138mail.net");
            props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
            props.setProperty("mail.smtp.socketFactory.fallback", "false");
            //邮箱发送服务器端口,这里设置为465端口
            props.setProperty("mail.smtp.port", "465");
            props.setProperty("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.auth", "true");
            /*final String username = "发送者邮箱用户名";
            final String password = "发送者邮箱密码或者邮箱授权码";*/
//          final String username = "service@megalook.com";//megalook
//          final String password = "DfcorpKXl6CbH1It";         
//          final String username = "sales@megalook.com";//huashuohair
//          final String password = "qPVGjvIM6wXVSsFn";
            String username = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.username");
            String password = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.userhighpwd");
            //获取到邮箱会话,利用匿名内部类的方式,将发送者邮箱用户名和密码授权给jvm
            Session session = Session.getDefaultInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(username, password);
                }
            });
            
            String content=toCustomerAbandoningPurchaseStr;
            //通过会话,得到一个邮件,用于发送
            MimeMessage msg = new MimeMessage(session);
            //设置发件人
//           msg.setFrom(new InternetAddress("发件人邮箱"));
//          msg.setFrom(new InternetAddress("service@megalook.com"));//megalook
//          msg.setFrom(new InternetAddress("sales@megalook.com"));//huashuohair
            String sendEmail = (String) PropertiesUtil.getProperty("megalook.properties", "sendEmil.username");
            msg.setFrom(new InternetAddress(sendEmail));
            //设置收件人,to为收件人,cc为抄送,bcc为密送
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            msg.setSubject("Customer help from Megalook hair.");
            
            Multipart mp = new MimeMultipart("related"); 
            BodyPart bodyPart = new MimeBodyPart(); 
            bodyPart.setDataHandler(new DataHandler(content,"text/html;charset=UTF-8"));
            mp.addBodyPart(bodyPart);
            // 设置邮件内容对象 
            msg.setContent(mp);
            
            //设置发送的日期
            msg.setSentDate(new Date());
            //调用Transport的send方法去发送邮件
            Transport.send(msg);
            System.out.println("给"+to+"客户,发送邮件完毕,"+"邮件内容为"+content);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}