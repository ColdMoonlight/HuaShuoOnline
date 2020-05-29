package com.atguigu.controller;

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
			@RequestParam("categoryId")String categoryId,HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		
		String uploadPath = "/static/img/category";
		String realUploadPath = session.getServletContext().getRealPath(uploadPath);
		System.out.println("uploadPath:"+uploadPath);
		System.out.println("realUploadPath:"+realUploadPath);
		String imageUrl ="";
		String thumImageUrl ="";
		try {
			
			imageUrl = uploadService.uploadImage(file, uploadPath, realUploadPath);//图片原图路径
			System.out.println("uploadPath:"+uploadPath);
			System.out.println("realUploadPath:"+realUploadPath);
			System.out.println("imageUrl:"+imageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String uploadPathcompress = "/static/imagecompress/category";
		String realUploadPathcompress = session.getServletContext().getRealPath(uploadPathcompress);
		
		try {
			
			thumImageUrl = thumbnailService.Thumbnail(file, uploadPathcompress, realUploadPathcompress);
			System.out.println("uploadPathcompress:"+uploadPathcompress);
			System.out.println("realUploadPathcompress:"+realUploadPathcompress);
			System.out.println("thumImageUrl:"+thumImageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl);
	}
	
}
