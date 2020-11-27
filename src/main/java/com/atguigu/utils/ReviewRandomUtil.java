package com.atguigu.utils;

public class ReviewRandomUtil {
	
	/**
     * @Method: readyEmail----Fictitious
     * @Description: 获取60以内的随机数
     * @Anthor:zsh
     * @param session
     * @return
     * @throws Exception
     */
	public static void main(String[] args) throws Exception {
		
		String kkk="2020-08-17 19:22:51";
		
		String year="2020";
		
		String month="2020";
		
		for(int i=0;i<100;i++){
			
			String timeHHMMSSStr = getHourMinuteSecond();
			System.out.println("timeHHMMSSStr:"+timeHHMMSSStr);
		}
	}
	
	public static String getAllTimeStr(String year,String month,String day,String timeHHMMSS){
		
		String allTime ="";
		allTime = year+"-"+month+"-"+day+" "+ timeHHMMSS;
		System.out.println("allTime:"+allTime);
		return allTime;
		
	}
	
	public static String getHourMinuteSecond() {
		
		String hour =getRandom24();
		String minute =getRandom60();
		String second =getRandom60();
		
		String timeStr = hour+":"+minute+":"+second;
		System.out.println("timeStr:"+timeStr);
		return timeStr;
	}



	public static String getRandom60() {
		int low = 0 ;
		int high = 60;
		String random60Str = "";
		int n = ((int) (Math.random()*(high-low)))+low;
		if(n>9){
			random60Str = n+"";
		}else{
			random60Str = "0"+(n+"");
		}
		//System.out.println("random60Str:"+random60Str);
		return random60Str;
	}
	
	
	public static String getRandom24() {
		int low = 0 ;
		int high = 24;
		String random24Str = "";
		int n = ((int) (Math.random()*(high-low)))+low;
		if(n>9){
			random24Str = n+"";
		}else{
			random24Str = "0"+(n+"");
		}
		//System.out.println("random24Str:"+random24Str);
		return random24Str;
	}
	
}
