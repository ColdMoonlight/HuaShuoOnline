package com.atguigu.controller;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.atguigu.common.Msg;
import com.atguigu.service.ThumbnailService;
import com.atguigu.service.UploadService;
import com.atguigu.utils.URLLocationUtils;

/**
 * HomePage
 * @author
 */
@Controller
@RequestMapping("/ImageUpload")
public class ImageUploadController {
	
	@Autowired
	UploadService uploadService;
	
	@Autowired
	ThumbnailService thumbnailService;
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/thumImageCategory",method=RequestMethod.POST)
	@ResponseBody
	public Msg thumImageCategory(@RequestParam("image")CommonsMultipartFile file,@RequestParam("categorySeo")String categorySeo,
			@RequestParam("categoryId")String categoryId,@RequestParam("type")String type,
			HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		//判断参数,确定信息
		String typeName="";
		if("category".equals(type)){
			typeName="cateid";
		}
		
		String imgName = getfilename(typeName,categoryId);
		
		String uploadPath = "static/img/category";
		String realUploadPath = session.getServletContext().getRealPath(uploadPath);
		
		//当前服务器路径
		String basePathStr = URLLocationUtils.getbasePathStr(rep,res);
        System.out.println("basePathStr:"+basePathStr);
		
		String imageUrl ="";
		String thumImageUrl ="";
		String sqlimageUrl="";
		String sqlthumImageUrl="";
		try {
			
			imageUrl = uploadService.uploadImage(file, uploadPath, realUploadPath,imgName);//图片原图路径
//			System.out.println("uploadPath:"+uploadPath);
//			System.out.println("realUploadPath:"+realUploadPath);
//			System.out.println("imageUrl:"+imageUrl);
			sqlimageUrl=basePathStr+imageUrl;
			System.out.println("sqlimageUrl:"+sqlimageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String uploadPathcompress = "static/imagecompress/category";
		String realUploadPathcompress = session.getServletContext().getRealPath(uploadPathcompress);
		
		try {
			
			thumImageUrl = thumbnailService.Thumbnail(file, uploadPathcompress, realUploadPathcompress,imgName);
//			System.out.println("uploadPathcompress:"+uploadPathcompress);
//			System.out.println("realUploadPathcompress:"+realUploadPathcompress);
//			System.out.println("thumImageUrl:"+thumImageUrl);
			sqlthumImageUrl=basePathStr+thumImageUrl;
			System.out.println("sqlthumImageUrl:"+sqlthumImageUrl);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl)
				.add("sqlimageUrl", sqlimageUrl).add("sqlthumImageUrl", sqlthumImageUrl);
	}
	
    private static String getfilename(String typeName,String typeId) {
		Calendar c = Calendar.getInstance();//可以对每个时间域单独修改   对时间进行加减操作等
		int year = c.get(Calendar.YEAR);  
		 int month = c.get(Calendar.MONTH);   
		int date = c.get(Calendar.DATE);    
		int hour = c.get(Calendar.HOUR_OF_DAY);   
		int minute = c.get(Calendar.MINUTE);   
		int second = c.get(Calendar.SECOND);    
		System.out.println(year + "/" + month + "/" + date + " " +hour + ":" +minute + ":" + second);    
		String newfilename = typeName+ typeId +"time"+date+hour+minute+second+".jpg";
		System.out.println(newfilename);
		return newfilename;
	}
	
}
