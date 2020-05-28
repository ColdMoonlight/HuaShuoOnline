package com.atguigu.controller.back;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
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
	
	private UploadService uploadService;
	
	private ThumbnailService thumbnailService;
	
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
	public Msg thumbnail(@RequestParam(value = "image")CommonsMultipartFile file,HttpSession session) throws Exception{
		System.out.println("--into--thumImageUrlImg/thumImage--");
		
		String uploadPath = "/images";
		String realUploadUrl = session.getServletContext().getRealPath(uploadPath);
		
		String imageUrl = uploadService.uploadImage(file, uploadPath, realUploadUrl);
		
		String thumImageUrl = thumbnailService.Thumbnail(file, uploadPath, realUploadUrl);
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl);
	}
	
}
