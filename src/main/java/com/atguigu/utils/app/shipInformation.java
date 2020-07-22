package com.atguigu.utils.app;

import java.util.List;
import com.atguigu.ship.Classes.Checkpoint;
import com.atguigu.ship.Classes.ConnectionAPI;
import com.atguigu.ship.Classes.Tracking;

public class shipInformation {
	
	
//	afterShip的真实物流url环境
	private final static String ConnectionAPIid = "7b04f01f-4f04-4b37-bbb9-5b159af73ee1";
	
	public static void main(String[] args) {
		getTrackingByTrackingNumberAndSlug("392338333836", "");
	}
	
	/**
	 * 01绑定物流单号进入app
	 * 
	 * 02查询物流信息
	 * */
	
	/**
     * @param String orderLogisticsname, String trackingNumber, String payinfoPlateNum
     * @Description: 01绑定物流单号进入app
     * @Anthor:zsh
     * @return
     */ 
	public static String addTrackingNumberIntoAfterShip(String orderLogisticsname, String trackingNumber, String payinfoPlateNum){
		
		String connectionAPIStr = ConnectionAPIid;
		ConnectionAPI connection = new ConnectionAPI(connectionAPIStr);
		
		//First we have to create a Tracking
		Tracking tracking = new Tracking(trackingNumber);
		//Then we can add information;
		tracking.setSlug(orderLogisticsname);//
		tracking.setTitle(payinfoPlateNum);//订单号
		tracking.setOrderID(payinfoPlateNum);//Ecpp的订单号
		
		
		tracking.setCustomerName("shaohua");
		tracking.addEmails("mingyueqingl@163.com");
		tracking.addSmses("+8617600209637");

		//Even add customer fields
		tracking.addCustomFields("product_name","iPhone Case");
		tracking.addCustomFields("product_price","USD999.60");

		//Finally we add the tracking to our account
		Tracking trackingPosted;
		try {
			trackingPosted = connection.postTracking(tracking);

			System.out.println("trackingPosted.getTrackingNumber()------------------------");
			System.out.println(trackingPosted.getTrackingNumber());
			
			trackingPosted.getExpectedDelivery();
			trackingPosted.generateJSON();
			trackingPosted.getSlug();
			System.out.println("trackingPosted.getSlug()------------------------");
			System.out.println(trackingPosted.getSlug());
			return "0";
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return "1";
		}
		
	}
	
	/**
     * @param String trackingNumber, String Slug
     * @Description: 查询物流信息
     * @Anthor:zsh
     * @return
     * @throws Exception
     */ 
	public static Tracking getTrackingByTrackingNumberAndSlug(String trackingNumber, String Slug) {
		
//		ConnectionAPI connection = new ConnectionAPI("7b04f01f-4f04-4b37-bbb9-5b159af73ee1");
//		Tracking tracking = new Tracking("778708372986");
		
		String connectionAPIStr = ConnectionAPIid;
		ConnectionAPI connection = new ConnectionAPI(connectionAPIStr);
		
		//First we have to create a Tracking
		Tracking tracking = new Tracking(trackingNumber);
		
		Tracking trackingRes = new Tracking("");
		tracking.setSlug(Slug);
		try {
			trackingRes = connection.getTrackingByNumber(tracking);
			System.out.println(trackingRes);
			
			List<Checkpoint> CheckpointList =  trackingRes.getCheckpoints();
			
			int i=0;
			for(Checkpoint Checkpoint:CheckpointList){
				System.out.println(i+":"+Checkpoint);
				i++;
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		} 
		
		return trackingRes;
	}
	
}
