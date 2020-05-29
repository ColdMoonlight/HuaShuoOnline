package com.atguigu.controller.back;

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
import org.springframework.web.servlet.ModelAndView;

import com.atguigu.common.Msg;
import com.atguigu.service.ThumbnailService;
import com.atguigu.service.UploadService;

/**
 * HomePage
 * @author
 */
@Controller
@RequestMapping("/thumImageUrlImg")
public class ImgController {
	
	@Autowired
	UploadService uploadService;
	
	@Autowired
	ThumbnailService thumbnailService;
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/toTmagePage",method=RequestMethod.GET)
	public String toTmagePage(HttpSession session) throws Exception{
		
		return "image";
	}
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/thumImage",method=RequestMethod.POST)
	@ResponseBody
	public Msg thumbnail(@RequestParam("image")CommonsMultipartFile file,HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		
		System.out.println("----into----thumImageUrlImg/thumImage----");
		
		String uploadPath = "/image";
		String realUploadPath = session.getServletContext().getRealPath(uploadPath);
		System.out.println("uploadPath:"+uploadPath);
		System.out.println(file);
		System.out.println("realUploadPath:"+realUploadPath);
		String imageUrl ="";
		String thumImageUrl ="";
		try {
			
			imageUrl = uploadService.uploadImage(file, uploadPath, realUploadPath);//图片原图路径
			System.out.println("imageUrl:"+imageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			
			thumImageUrl = thumbnailService.Thumbnail(file, uploadPath, realUploadPath);
			System.out.println("thumImageUrl:"+thumImageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl);
	}
	
}
