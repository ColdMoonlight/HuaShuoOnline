package com.atguigu.utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.ecpp.HttpClient_ConnectEcpp;
import com.atguigu.vo.ecppItem;
import com.atguigu.vo.order;

public class EcppUpdateWebStatusUtil {
	
	public static String getXML(String token, String order_sn) {
		
		String soapXML = "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
				+"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
					+"<soap:Body>"
				    +"<queryOrder xmlns=\"http://s24.vekinerp.com/ecpp_server.php/\">"
				    	+"<token>"+token+"</token>"
				    	+"<order_sn>"+order_sn+"</order_sn>"
				    +"</queryOrder>"
				  +"</soap:Body>"
				+"</soap:Envelope>";
		System.out.println(soapXML);
		return soapXML;
	}

	public static String send(String token, String soapXML) throws Exception {
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
			
			String EcppReturnStr = jDom4(returnStr);
			
			//解析数据,那会
			is.close();
			isr.close();
			br.close();
		}
		os.close();
		
		return EcppHSNum;
	}
	
	private static String jDom4(String returnStr) {

		//1.创建Reader对象
        SAXReader reader = new SAXReader();
        //2.加载xml
        Document document;
		try {
			//document = reader.read(returnStr);
			document = DocumentHelper.parseText(returnStr);
			
			
			//3.获取根节点
	        Element rootElement = document.getRootElement();
	        Iterator iterator = rootElement.elementIterator();
	        while (iterator.hasNext()){
	            Element stu = (Element) iterator.next();
	            List<Attribute> attributes = stu.attributes();
	            System.out.println("======获取属性值======");
	            for (Attribute attribute : attributes) {
	                System.out.println(attribute.getValue());
	            }
	            System.out.println("======遍历子节点======");
	            Iterator iterator1 = stu.elementIterator();
	            while (iterator1.hasNext()){
	                Element stuChild = (Element) iterator1.next();
	                System.out.println("节点名："+stuChild.getName()+"---节点值："+stuChild.getStringValue());
	                if("queryOrderResponse".equals(stuChild.getName())){
	                	System.out.println("------queryOrderResponse------");
	                	
	                	System.out.println(stuChild.getStringValue());
	                	String queryOrderResponseStr = stuChild.getStringValue();
	                	
	                	System.out.println("------queryOrderResponse------");
	                	
	                	JSONObject queryOrderResponseJSONObject= JSON.parseObject(queryOrderResponseStr);
	                	
	                	System.out.println("------------queryOrderResponseJSONObject------------");
	                	System.out.println(queryOrderResponseJSONObject.get("data"));
	                	System.out.println("------------queryOrderResponseJSONObject------------");
	                	
	                	JSONObject orderDataJSONObject = (JSONObject) queryOrderResponseJSONObject.get("data");
	                	
	                	
	                	System.out.println("------------orderDataJSONObject------------");
	                	System.out.println(orderDataJSONObject.get("track_no"));
	                	System.out.println("------------orderDataJSONObject------------");
	                	
	                	return queryOrderResponseStr;
	                }
	            }
	        }
		} catch (DocumentException e) {
			e.printStackTrace();
		}
		return "";
	
}

}
