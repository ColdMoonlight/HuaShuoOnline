package com.atguigu.service;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import net.coobird.thumbnailator.Thumbnails;

@Service
public class ThumbnailService {
	
	public static final int WIDTH = 100;
	public static final int HEIGH = 100; 
	
	/**
	 * @author Shinelon
	 * @param MlbackAdmin
	 * @exception 查看用户信息是否存在
	 * 
	 * */
	public String Thumbnail(CommonsMultipartFile file,String uploadPath,String realUploadUrl) {
		
		try {
			String des = realUploadUrl+"/"+file.getOriginalFilename();
			Thumbnails.of(file.getInputStream()).size(WIDTH,HEIGH).toFile(des);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return uploadPath+"/"+file.getOriginalFilename();
	}
	

}
