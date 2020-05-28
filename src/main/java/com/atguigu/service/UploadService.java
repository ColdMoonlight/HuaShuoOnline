package com.atguigu.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Service
public class UploadService {
	
	/**
	 * @author Shinelon
	 * @param MlbackAdmin
	 * @exception 查看用户信息是否存在
	 * 
	 * */
	public String uploadImage(CommonsMultipartFile file,String uploadPath,String realUploadUrl) {
		
		InputStream is = null;
		OutputStream os = null;
		try {
			is = file.getInputStream();
			String des = realUploadUrl+"/"+file.getOriginalFilename();
			os = new FileOutputStream(des);
			
			//我们就每次读写10K,我们的文件小，这个就已经够用了
	        byte[] b = new byte[1024*10];

	        int len = 0 ;

	        //读写文件,-1标识为空
	        while( (len = is.read(b) ) != -1 ) {
	            os.write(b);
	        }
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(is!=null){
				try {
					is.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(os!=null){
				try {
					os.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			
		}
		
		return uploadPath+"/"+file.getOriginalFilename();
	}
	

}
