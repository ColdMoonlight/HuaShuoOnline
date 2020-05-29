package com.atguigu.service;

import java.util.Calendar;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import net.coobird.thumbnailator.Thumbnails;

@Service
public class ThumbnailService {
	
	public static final int WIDTH = 200;
	public static final int HEIGH = 200; 
	
	/**
	 * @author Shinelon
	 * @param MlbackAdmin
	 * @exception 查看用户信息是否存在
	 * 
	 * */
	public String Thumbnail(CommonsMultipartFile file,String uploadPath,String realUploadUrl,String typeName) {
		
		try {
			String des = realUploadUrl+"/"+"thumb_"+file.getOriginalFilename();
			Thumbnails.of(file.getInputStream()).scale(0.4f).toFile(des);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return uploadPath+"/"+"thumb_"+file.getOriginalFilename();
		
	}
	
    private static String getfilename(String cateid) {
		Calendar c = Calendar.getInstance();//可以对每个时间域单独修改   对时间进行加减操作等
		int year = c.get(Calendar.YEAR);
		 int month = c.get(Calendar.MONTH);
		int date = c.get(Calendar.DATE);
		int hour = c.get(Calendar.HOUR_OF_DAY);
		int minute = c.get(Calendar.MINUTE);   
		int second = c.get(Calendar.SECOND);
		System.out.println(year + "/" + month + "/" + date + " " +hour + ":" +minute + ":" + second);    
		String newfilename = "cateid"+ cateid +"time"+date+hour+minute+second+".jpg";
		System.out.println(newfilename);
		return newfilename;
	}
	
}
