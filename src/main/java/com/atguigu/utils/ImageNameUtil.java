package com.atguigu.utils;

import java.util.Calendar;

public class ImageNameUtil {

	public static String gettypeName(String type) {
		String typeName = "";
		if("category".equals(type)){
			typeName="cateid";
		}
		return typeName;
	}
	
	public static String getfilename(String typeName,String typeIdStr) {
		Calendar c = Calendar.getInstance();//可以对每个时间域单独修改   对时间进行加减操作等
		int year = c.get(Calendar.YEAR);  
		 int month = c.get(Calendar.MONTH);   
		int date = c.get(Calendar.DATE);    
		int hour = c.get(Calendar.HOUR_OF_DAY);   
		int minute = c.get(Calendar.MINUTE);   
		int second = c.get(Calendar.SECOND);
		System.out.println(year + "/" + month + "/" + date + " " +hour + ":" +minute + ":" + second);    
		String newfilename = typeName+ typeIdStr +"time"+date+hour+minute+second+".jpg";
		System.out.println(newfilename);
		return newfilename;
	}

}
