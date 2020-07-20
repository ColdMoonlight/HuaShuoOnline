package com.atguigu.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.ecpp.HttpClient_ConnectEcpp;
import com.atguigu.vo.ecppItem;
import com.atguigu.vo.order;

public class EcppIntoUtil {
	
	/*------begin------以下方法是-----------支付成功之后，向ecpp中插入数据-------begin---------*/
	
	public static String getXML(String token, order ecppOrder) {
		
		List<ecppItem> ecppItemList = ecppOrder.getItem();
		
		String ecppItemListStr = getEcppItemListStr(ecppItemList);
		
		String soapXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				+"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
					+"<soap:Body>"
				    +"<addLineOrder xmlns=\"http://s24.vekinerp.com/ecpp_server.php/\">"
				    	+"<token>"+token+"</token>"
				    	+"<orders>"
					    	+"<order>"
					    	+"<userid>"+ecppOrder.getUserid()+"</userid>"
					    	+"<paid_time>"+ecppOrder.getPaid_time()+"</paid_time>"
					    	+"<email>"+ecppOrder.getEmail()+"</email>"				    					
					    	+"<paypalid>"+ecppOrder.getPaypalid()+"</paypalid>"
					    	+"<sellsrecord>"+ecppOrder.getSellsrecord()+"</sellsrecord>"
					    	+"<order_amount>"+ecppOrder.getOrder_amount()+"</order_amount>"
							+"<currency>"+ecppOrder.getCurrency()+"</currency>"
							+"<shipping_id>"+ecppOrder.getShipping_id()+"</shipping_id>"
							+"<Sales_channels>"+ecppOrder.getSales_channels()+"</Sales_channels>"
							+"<Sales_account_id>"+ecppOrder.getSales_account_id()+"</Sales_account_id>"
							+"<enableStockControl>"+ecppOrder.getEnableStockControl()+"</enableStockControl>"
							
							+"<consignee>"+ecppOrder.getConsignee()+"</consignee>"
							+"<street1>"+ecppOrder.getStreet1()+"</street1>"
							+"<street2 >"+ecppOrder.getStreet2()+"</street2>"
							+"<city>"+ecppOrder.getCity()+"</city>"
							+"<state>"+ecppOrder.getState()+"</state>"
							+"<country>"+ecppOrder.getCountry()+"</country>"
							+"<CountryCode>"+ecppOrder.getCountryCode()+"</CountryCode>"
							+"<tel>"+ecppOrder.getTel()+"</tel>"
							+"<zipcode>"+ecppOrder.getZipcode()+"</zipcode>"
							+ecppItemListStr
							+"</order>"
				    	+"</orders>"
				    +"</addLineOrder>"
				  +"</soap:Body>"
				+"</soap:Envelope>";
		System.out.println(soapXML);
		return soapXML;
	}

	public static String send(String token, String soapXML,String paypalIdStr) throws Exception {
		//第一步：创建服务地址，不是WSDL地址
		URL url = new URL("http://s24.vekinerp.com/ecpp_server.php");
		//第二步：打开一个通向服务地址的连接
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		//第三步：设置参数
		//3.1发送方式设置：POST必须大写
		connection.setRequestMethod("POST");
		//3.2设置数据格式：content-type
		connection.setRequestProperty("content-type", "text/xml;charset=utf-8");
		//3.3设置输入输出，因为默认新创建的connection没有读写权限，
		connection.setDoInput(true);
		connection.setDoOutput(true);
		
		OutputStream os = connection.getOutputStream();
		os.write(soapXML.getBytes());
		//第五步：接收服务端响应，打印
		int responseCode = connection.getResponseCode();
		System.out.println(responseCode);
		Object connectText = connection.getContent();
		System.out.println("connectText.toString()");
		System.out.println(connectText.toString());
		System.out.println("connectText.toString()");
		
		String EcppHSNum ="000000";
		if(200 == responseCode){//表示服务端响应成功
			InputStream is = connection.getInputStream();
			InputStreamReader isr = new InputStreamReader(is);
			BufferedReader br = new BufferedReader(isr);
			
			StringBuilder sb = new StringBuilder();
			String temp = null;
			while(null != (temp = br.readLine())){
				sb.append(temp);
			}
			
			String returnStr = sb.toString();
			
			System.out.println(returnStr);
			
			EcppHSNum = HttpClient_ConnectEcpp.jDom4EcppHSNum(returnStr,paypalIdStr);
			System.out.println("EcppHSNum:"+EcppHSNum);
			//解析数据,那会
			is.close();
			isr.close();
			br.close();
		}
		os.close();
		
		return EcppHSNum;
	}
	
	public static String getEcppItemListStr(List<ecppItem> ecppItemList) {

		String ecppItemInfoStr = "";
		Integer ecppItemListNums = ecppItemList.size();
		if(ecppItemListNums>1){
			for(ecppItem ecppItemOne:ecppItemList){
				ecppItemInfoStr+="<items>"
				+"<goods_sn>"+ecppItemOne.getGoods_sn()+"</goods_sn>"
				+"<goods_name>"+ecppItemOne.getGoods_name()+"</goods_name>"
				+"<goods_qty>"+ecppItemOne.getGoods_qty()+"</goods_qty>"
				+"<goods_price>"+ecppItemOne.getGoods_price()+"</goods_price>"
				+"</items>";
			}
		}else{
			ecppItem ecppItemOne = ecppItemList.get(0);
			ecppItemInfoStr+="<items>"
								+"<item>"
								+"<goods_sn>"+ecppItemOne.getGoods_sn()+"</goods_sn>"
								+"<goods_name>"+ecppItemOne.getGoods_name()+"</goods_name>"
								+"<goods_qty>"+ecppItemOne.getGoods_qty()+"</goods_qty>"
								+"<goods_price>"+ecppItemOne.getGoods_price()+"</goods_price>"
								+"</item>"
							+"</items>";
		}
		System.out.println("ecppItemInfoStr:"+ecppItemInfoStr);
		return ecppItemInfoStr;
	}
	
	public static order getEcppNeedOrder(MlfrontPayInfo mlfrontPayInfoIOne, MlfrontOrder mlfrontOrderResOne,
			List<MlfrontOrderItem> mlfrontOrderItemEcppNeedList, MlfrontAddress mlfrontAddressToPay) {
		
		order ecppOrder = new order();
		
//	    private String userid;//买家ID
//	    private String paid_time;//交易时间:Y-m-d H:i:s	默认为当前日期
//	    private String email;//买家邮箱
//	    private String paypalid;//交易号/订单号	唯一
//	    private String sellsrecord;//订单号/流水号
//	    private BigDecimal order_amount;//订单金额	两位小数
//	    private String currency;//币种	三字代码，例：USD
//	    private Integer shipping_id;//发货方式	参见字典查询接口 name为shipping
//	    private Integer Sales_channels;//销售渠道	参见字典查询接口		name为Sales_channels
//	    private Integer Sales_account_id;//渠道账号	参见渠道账号查询列表
//	    private Integer enableStockControl;//库存控制		0 默认 //1锁定扣除OOO//2锁定PPP
//	    private String consignee;//*收件人
//	    private String street1;//*地址1
//	    private String street2;//地址2
//	    private String city;//*城市
//	    private String state;//*省
//	    private String country;//*国家
//	    private String CountryCode;//*国家二字代码
//	    private String tel;//*电话
//	    private String zipcode;//*邮编
		
		String nowTime = DateUtil.strTime14s();
		ecppOrder.setUserid(mlfrontAddressToPay.getAddressUserfirstname()+" "+mlfrontAddressToPay.getAddressUserlastname());
		ecppOrder.setPaid_time(nowTime);
		ecppOrder.setEmail(mlfrontAddressToPay.getAddressEmail());
		ecppOrder.setPaypalid(mlfrontPayInfoIOne.getPayinfoTransidnum());
		ecppOrder.setSellsrecord(mlfrontPayInfoIOne.getPayinfoPlatenum());
		ecppOrder.setOrder_amount(mlfrontPayInfoIOne.getPayinfoMoney());
		ecppOrder.setCurrency("USD");
//		ecppOrder.setShipping_id(1);//发货方式	参见字典查询接口 name为shipping
		ecppOrder.setSales_channels(220);//销售渠道(220,)	参见字典查询接口		name为Sales_channels
		ecppOrder.setSales_account_id(30);//(30	Magalook test)		渠道账号	参见渠道账号查询列表
		ecppOrder.setEnableStockControl(0);
		
		ecppOrder.setConsignee(mlfrontAddressToPay.getAddressUserfirstname()+" "+mlfrontAddressToPay.getAddressUserlastname());
		ecppOrder.setStreet1(mlfrontAddressToPay.getAddressDetail());
		ecppOrder.setStreet2(" ");
		ecppOrder.setCity(mlfrontAddressToPay.getAddressCity());
		ecppOrder.setState(mlfrontAddressToPay.getAddressProvince());
		ecppOrder.setCountry(mlfrontAddressToPay.getAddressCountry());
		ecppOrder.setCountryCode(mlfrontAddressToPay.getAddressCountryCode());
		ecppOrder.setZipcode(mlfrontAddressToPay.getAddressPost());
		ecppOrder.setTel(mlfrontAddressToPay.getAddressTelephone());
		//封装pro产品字段
		List<ecppItem> ecppItemList = new ArrayList<ecppItem>();
		for(MlfrontOrderItem mlfrontOrderItem:mlfrontOrderItemEcppNeedList){
			ecppItem ecppItemOne = new ecppItem();
			ecppItemOne.setGoods_sn(mlfrontOrderItem.getOrderitemPskuCode());
			ecppItemOne.setGoods_name(mlfrontOrderItem.getOrderitemPskuName());
			ecppItemOne.setGoods_qty(mlfrontOrderItem.getOrderitemPskuNumber());
			ecppItemOne.setGoods_price(mlfrontOrderItem.getOrderitemPskuMoneystr());
			ecppItemList.add(ecppItemOne);
		}
		ecppOrder.setItem(ecppItemList);
		return ecppOrder;
	}
	
	/*------end------以下方法是-----------支付成功之后，向ecpp中插入数据-------end---------*/

}
