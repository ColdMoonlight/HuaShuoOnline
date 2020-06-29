package com.atguigu.controller;

import java.util.List;

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

import com.atguigu.bean.MlbackCategory;
import com.atguigu.bean.MlbackProduct;
import com.atguigu.bean.MlbackProductImg;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackCategoryService;
import com.atguigu.service.MlbackProductImgService;
import com.atguigu.service.MlbackProductService;
import com.atguigu.service.ThumbnailService;
import com.atguigu.service.UploadService;
import com.atguigu.utils.DateUtil;
import com.atguigu.utils.ImageNameUtil;
import com.atguigu.utils.URLLocationUtils;

/**
 * ImageUploadPage
 * @author
 */
@Controller
@RequestMapping("/ImageUpload")
public class ImageUploadController {
	
	@Autowired
	UploadService uploadService;
	
	@Autowired
	ThumbnailService thumbnailService;
	
	@Autowired
	MlbackCategoryService mlbackCategoryService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	@Autowired
	MlbackProductImgService mlbackProductImgService;
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/thumImageCategory",method=RequestMethod.POST)
	@ResponseBody
	public Msg thumImageCategory(@RequestParam("image")CommonsMultipartFile file,@RequestParam("categorySeo")String categorySeo,
			@RequestParam("categoryId")Integer categoryId,@RequestParam("type")String type,
			HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		
		//判断参数,确定信息
		String typeName=ImageNameUtil.gettypeName(type);
		
		String categoryIdStr = categoryId+"";
		String imgName = ImageNameUtil.getfilename(typeName,categoryIdStr);
		
		String uploadPath = "static/upload/img/category";
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
			sqlimageUrl=basePathStr+imageUrl;
			System.out.println("sqlimageUrl:"+sqlimageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String uploadPathcompress = "static/upload/imagecompress/category";
		String realUploadPathcompress = session.getServletContext().getRealPath(uploadPathcompress);
		
		try {
			
			thumImageUrl = thumbnailService.Thumbnail(file, uploadPathcompress, realUploadPathcompress,imgName);
			sqlthumImageUrl=basePathStr+thumImageUrl;
			System.out.println("sqlthumImageUrl:"+sqlthumImageUrl);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		MlbackCategory mlbackCategory = new MlbackCategory();
		mlbackCategory.setCategoryId(categoryId);
		mlbackCategory.setCategoryImgpcurl(sqlimageUrl);
		mlbackCategory.setCategoryImgurl(sqlthumImageUrl);
		
		mlbackCategoryService.updateByPrimaryKeySelective(mlbackCategory);
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl)
				.add("sqlimageUrl", sqlimageUrl).add("sqlthumImageUrl", sqlthumImageUrl);
	}
	
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/thumImageProduct",method=RequestMethod.POST)
	@ResponseBody
	public Msg thumImageProduct(@RequestParam("image")CommonsMultipartFile file,@RequestParam("productSeo")String productSeo,
			@RequestParam("productId")Integer productId,@RequestParam("type")String type,
			HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		
		//判断参数,确定信息
		String typeName=ImageNameUtil.gettypeName(type);
		
		String productIdStr = productId+"";
		String imgName = ImageNameUtil.getfilename(typeName,productIdStr);
		
		String uploadPath = "static/upload/img/product";
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
			sqlimageUrl=basePathStr+imageUrl;
			System.out.println("sqlimageUrl:"+sqlimageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String uploadPathcompress = "static/upload/imagecompress/product";
		String realUploadPathcompress = session.getServletContext().getRealPath(uploadPathcompress);
		
		try {
			
			thumImageUrl = thumbnailService.Thumbnail(file, uploadPathcompress, realUploadPathcompress,imgName);
			sqlthumImageUrl=basePathStr+thumImageUrl;
			System.out.println("sqlthumImageUrl:"+sqlthumImageUrl);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		MlbackProduct mlbackProduct = new MlbackProduct();
		mlbackProduct.setProductId(productId);
		mlbackProduct.setProductMainimgurl(sqlimageUrl);
		mlbackProduct.setProductMainsmallimgurl(sqlthumImageUrl);
		
		mlbackProductService.updateByPrimaryKeySelective(mlbackProduct);
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl)
				.add("sqlimageUrl", sqlimageUrl).add("sqlthumImageUrl", sqlthumImageUrl);
	}
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/thumImageProductAll",method=RequestMethod.POST)
	@ResponseBody
	public Msg thumImageProductAll(@RequestParam("imageAll")CommonsMultipartFile file,@RequestParam("productId")Integer productId,
			@RequestParam("productimgSortOrder")Integer productimgSortOrder,
			HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		
		//判断参数,确定信息
		String productIdStr = productId+"";
		String productimgSortIdstr = productimgSortOrder+"";
		String imgName = ImageNameUtil.getImageAllfilename(productIdStr,productimgSortIdstr);
		
		String uploadPath = "static/upload/img/productAll";
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
			sqlimageUrl=basePathStr+imageUrl;
			System.out.println("sqlimageUrl:"+sqlimageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String uploadPathcompress = "static/upload/imagecompress/productAll";
		String realUploadPathcompress = session.getServletContext().getRealPath(uploadPathcompress);
		
		try {
			
			thumImageUrl = thumbnailService.Thumbnail(file, uploadPathcompress, realUploadPathcompress,imgName);
			sqlthumImageUrl=basePathStr+thumImageUrl;
			System.out.println("sqlthumImageUrl:"+sqlthumImageUrl);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		//查询文件是否在
		MlbackProductImg mlbackProductImgIf = new MlbackProductImg();
		
		mlbackProductImgIf.setProductId(productId);
		mlbackProductImgIf.setProductimgSortOrder(productimgSortOrder);
		
		List<MlbackProductImg> mlbackProductImgIfList = mlbackProductImgService.selectMlbackProductImgByPIdAndImgSort(mlbackProductImgIf);
		MlbackProductImg mlbackProductImg = new MlbackProductImg();
		
		mlbackProductImg.setProductId(productId);
		
		mlbackProductImg.setProductimgUrl(sqlimageUrl);
		
		mlbackProductImg.setProductimgSmallturl(sqlthumImageUrl);//详情页轮播筛选所用
		
		mlbackProductImg.setProductimgSortOrder(productimgSortOrder);
		
		mlbackProductImg.setProductimgName(imgName);
		
		String nowTime = DateUtil.strTime14s();
		mlbackProductImg.setProductimgMotifytime(nowTime);
		
		if(mlbackProductImgIfList.size()>0){
			//取出id
			int pImgId = mlbackProductImgIfList.get(0).getProductimgId();
			
			mlbackProductImg.setProductimgId(pImgId);
			
			mlbackProductImgService.updateByPrimaryKeySelective(mlbackProductImg);
			
			//存在update
		}else{
			mlbackProductImg.setProductimgCreatetime(nowTime);
			//存在insert
			mlbackProductImgService.insertSelective(mlbackProductImg);
		}
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl)
				.add("sqlimageUrl", sqlimageUrl).add("sqlthumImageUrl", sqlthumImageUrl);
	}
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/productDiscount",method=RequestMethod.POST)
	@ResponseBody
	public Msg productDiscount(@RequestParam("image")CommonsMultipartFile file,
			@RequestParam("productId")Integer productId,@RequestParam("type")String type,
			HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		
		//判断参数,确定信息
		String typeName=ImageNameUtil.gettypeName(type);//proidDiscout
		
		String productIdStr = productId+"";
		String imgName = ImageNameUtil.getfilename(typeName,productIdStr);
		
		//当前服务器路径
		String basePathStr = URLLocationUtils.getbasePathStr(rep,res);
        System.out.println("basePathStr:"+basePathStr);
		
		String uploadPath = "static/upload/img/productDiscount";
		String realUploadPath = session.getServletContext().getRealPath(uploadPath);
				
		String imageUrl ="";
		String thumImageUrl ="";
		String sqlimageUrl="";
		String sqlthumImageUrl="";
		try {
			
			imageUrl = uploadService.uploadImage(file, uploadPath, realUploadPath,imgName);//图片原图路径
			sqlimageUrl=basePathStr+imageUrl;
			System.out.println("sqlimageUrl:"+sqlimageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String uploadPathcompress = "static/upload/imagecompress/productDiscount";
		String realUploadPathcompress = session.getServletContext().getRealPath(uploadPathcompress);
		
		try {
			
			thumImageUrl = thumbnailService.Thumbnail(file, uploadPathcompress, realUploadPathcompress,imgName);
			sqlthumImageUrl=basePathStr+thumImageUrl;
			System.out.println("sqlthumImageUrl:"+sqlthumImageUrl);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		MlbackProduct mlbackProduct = new MlbackProduct();
		mlbackProduct.setProductId(productId);
		mlbackProduct.setProductDiscoutimgurl(sqlimageUrl);		
		mlbackProductService.updateByPrimaryKeySelective(mlbackProduct);
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl)
				.add("sqlimageUrl", sqlimageUrl).add("sqlthumImageUrl", sqlthumImageUrl);
	}
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/thumProVideoImage",method=RequestMethod.POST)
	@ResponseBody
	public Msg thumProVideoImage(@RequestParam("image")CommonsMultipartFile file,
			@RequestParam("productId")Integer productId,@RequestParam("type")String type,
			HttpSession session,HttpServletResponse rep,HttpServletRequest res){
		
		//判断参数,确定信息
		String typeName=ImageNameUtil.gettypeName(type);
		
		String productIdStr = productId+"";
		String imgName = ImageNameUtil.getfilename(typeName,productIdStr);
		
		//当前服务器路径
		String basePathStr = URLLocationUtils.getbasePathStr(rep,res);
        System.out.println("basePathStr:"+basePathStr);
		
		String uploadPath = "static/upload/video/productVideoImage";
		String realUploadPath = session.getServletContext().getRealPath(uploadPath);
				
		String imageUrl ="";
		String thumImageUrl ="";
		String sqlimageUrl="";
		String sqlthumImageUrl="";
		try {
			
			imageUrl = uploadService.uploadImage(file, uploadPath, realUploadPath,imgName);//图片原图路径
			sqlimageUrl=basePathStr+imageUrl;
			System.out.println("sqlimageUrl:"+sqlimageUrl);
		} catch (Exception e) {
			e.printStackTrace();
		}
//		
//		String uploadPathcompress = "static/video/productVideoImage";
//		String realUploadPathcompress = session.getServletContext().getRealPath(uploadPathcompress);
//		
//		try {
//			
//			thumImageUrl = thumbnailService.Thumbnail(file, uploadPathcompress, realUploadPathcompress,imgName);
//			sqlthumImageUrl=basePathStr+thumImageUrl;
//			System.out.println("sqlthumImageUrl:"+sqlthumImageUrl);
//			
//		} catch (Exception e) {
//			e.printStackTrace();
//		}

		MlbackProduct mlbackProduct = new MlbackProduct();
		mlbackProduct.setProductId(productId);
		mlbackProduct.setProductVideoImgUrl(sqlimageUrl);
		
		mlbackProductService.updateByPrimaryKeySelective(mlbackProduct);
		
		return Msg.success().add("resMsg", "登陆成功").add("imageUrl", imageUrl).add("thumImageUrl", thumImageUrl)
				.add("sqlimageUrl", sqlimageUrl).add("sqlthumImageUrl", sqlthumImageUrl);
	}
	
}
