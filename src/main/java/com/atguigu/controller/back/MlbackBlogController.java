package com.atguigu.controller.back;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlbackBlog;
import com.atguigu.bean.MlbackSearch;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackBlogService;
import com.atguigu.service.MlbackSearchService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackBlog")
public class MlbackBlogController {
	
	@Autowired
	MlbackBlogService mlbackBlogService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	@Autowired
	MlbackSearchService mlbackSearchService;
	
	/**
	 * 1.0	20200608
	 * to后台分类MlbackBlog列表页面
	 * @return jsp
	 * */
	@RequestMapping("/toMlbackBlogPage")
	public String tologin(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute(Const.ADMIN_USER);
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/marketing/mlbackBlogPage";
		}
	}
	
	/**2.0	20200608
	 * 后台MlbackBlog列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackBlogByPage")
	@ResponseBody
	public Msg getMlbackBlogByPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {

		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		List<MlbackBlog> mlbackBlogList = mlbackBlogService.selectMlbackBlogGetAll();
		PageInfo page = new PageInfo(mlbackBlogList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
	/**3.0	20200608
	 * MlbackBlog	initializaBlog
	 * @param MlbackBlog
	 * @return
	 */
	@RequestMapping(value="/initializaBlog",method=RequestMethod.POST)
	@ResponseBody
	public Msg initializaBlog(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackBlog mlbackBlog = new MlbackBlog();
		//取出id
		String nowTime = DateUtil.strTime14s();
		mlbackBlog.setBlogCreatetime(nowTime);
		mlbackBlog.setBlogMotifytime(nowTime);
		mlbackBlog.setBlogStatus(0);
		//System.out.println("插入前"+MlbackBlog.toString());
		mlbackBlogService.insertSelective(mlbackBlog);
		//System.out.println("插入后"+MlbackBlog.toString());
		return Msg.success().add("resMsg", "Product初始化成功").add("MlbackBlog", mlbackBlog);
	}
	
	/**
	 * 4.0	20200608
	 * 查看单个产品的详情
	 * @param productId
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackBlogDetail",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackBlogDetail(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackBlog mlbackBlog){
		//接受信息
		Integer blogIdInt = mlbackBlog.getBlogId();
		
		MlbackBlog mlbackBlogReq = new MlbackBlog();
		mlbackBlogReq.setBlogId(blogIdInt);
		List<MlbackBlog> mlbackBlogResList =mlbackBlogService.selectMlbackBlogByParam(mlbackBlogReq);
		MlbackBlog mlbackBlogOne = new MlbackBlog();
		if(mlbackBlogResList.size()>0){
			//如果用这个id查到,就拿出来.
			mlbackBlogOne = mlbackBlogResList.get(0);
		}else{
			//如果用这个id没查到,就取出当前所有产品最新上的那款.
			mlbackBlogResList = mlbackBlogService.selectMlbackBlogGetAll();
			mlbackBlogOne = mlbackBlogResList.get(0);
		}
		//System.out.println("操作说明：查询-MlbackBlogOne:"+MlbackBlogOne);
		return Msg.success().add("resMsg", "查看单个产品详情完毕").add("MlbackBlogOne", mlbackBlogOne);
	}
	
	/**5.0	20200608
	 * MlbackBlog	update
	 * @param MlbackBlog
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackBlog mlbackBlog){
		//接受参数信息
		String nowTime = DateUtil.strTime14s();
		mlbackBlog.setBlogMotifytime(nowTime);
		
		//先对这个产品选择的一些类,进行productIdStr的清理
		//4.0.1从中读取categoryIdsStr,切割得到每一个categoryId,遍历,把productId,填充再每个查回来的categort中的proidStr拼上
		mlbackBlogService.updateByPrimaryKeySelective(mlbackBlog);
		return Msg.success().add("resMsg", "category保存成功");
	}
	
//	/**
//	 * 4.0.1
//	 * 从中读取categoryIdsStr,切割得到每一个categoryId,
//	 * 遍历categoryId查询,把productId,填充再每个查回来的category中的proidStr拼上
//	 * */
//	private void UpdateCategoryProductIdStr(String categoryIdsStr, Integer productId,String productName, Integer productSupercateid) {
//		
//		String inproductIdStr=productId+"";
//		
//		if(categoryIdsStr==""){
//			System.out.println("categoryIdsStr为空");
//			//把该productId下的
//			ProductCategoryIdsStrUpdateOld(productId,categoryIdsStr);
//			//清理掉,该产品下的类
//			MlbackBlog MlbackBlogReq = new MlbackBlog();
//			MlbackBlogReq.setProductId(productId);
//			MlbackBlogReq.setProductCategoryIdsstr("");
//			MlbackBlogReq.setProductCategoryNamesstr("");
//			MlbackBlogService.updateByPrimaryKeySelective(MlbackBlogReq);
//		}else{
//			//先清理老的数据
//			ProductCategoryIdsStrUpdateOld(productId,categoryIdsStr);
//			//从中读取categoryIdsStr,切割得到每一个categoryId,
//			String categoryIdsStrArr [] = categoryIdsStr.split(",");
//			String categoryIdStr = "";
//			Integer categoryIdInt = 0;
//			MlbackCategory mlbackCategoryReq = new MlbackCategory();
//			MlbackCategory mlbackCategoryRes = new MlbackCategory();
//			
//			MlbackCategory mlbackCategoryReqUpdate = new MlbackCategory();
//			List<MlbackCategory> mlbackCategoryList = new ArrayList<MlbackCategory>();
//			String categoryProductIdsStr = "";
//			String categoryproductNamesStr = "";
//			
//			for(int i=0;i<categoryIdsStrArr.length;i++){
//				categoryIdStr=categoryIdsStrArr[i];
//				categoryIdInt = Integer.parseInt(categoryIdStr);
//				//遍历categoryId查询
//				mlbackCategoryReq.setCategoryId(categoryIdInt);
//				mlbackCategoryList = mlbackCategoryService.selectMlbackCategory(mlbackCategoryReq);
//				mlbackCategoryRes = mlbackCategoryList.get(0);
// 				categoryProductIdsStr = mlbackCategoryRes.getCategoryProductIds();
//				categoryproductNamesStr = mlbackCategoryRes.getCategoryProductNames();
//				//把productId,填充再每个查回来的categort中的proidStr拼上
//				if(categoryProductIdsStr==null||categoryProductIdsStr.length()==0){
//					//如果当前没有,属于第一次填充,直接替代就好
//					categoryProductIdsStr =inproductIdStr;
//					categoryproductNamesStr=productName;
//				}else{
//					//如果产品类下已经有数据
//					int ifHave = cheakifHave(categoryProductIdsStr,inproductIdStr);
//					//先判断是否包含本次
//					if(ifHave>0){
//						//只要test.indexOf('This')返回的值不是-1说明test字符串中包含字符串'This',相反如果包含返回的值必定是-1"
//						//如果包含,跳过
//						continue;
//					}else{
//						//如果不包含,拼接
//						categoryProductIdsStr = categoryProductIdsStr +","+ inproductIdStr;
//						categoryproductNamesStr = categoryproductNamesStr+","+productName;
//					}
//				}
//				//操作完,执行更新
//				mlbackCategoryReqUpdate.setCategoryId(categoryIdInt);
//				mlbackCategoryReqUpdate.setCategoryProductIds(categoryProductIdsStr);
//				mlbackCategoryReqUpdate.setCategoryProductNames(categoryproductNamesStr);
//				mlbackCategoryService.updateByPrimaryKeySelective(mlbackCategoryReqUpdate);
//			}
//		}
//	}
//	//* 4.0.2
//	private int cheakifHave(String categoryProductIdsStr, String inproductIdStr) {
//		
//		int num = 0;
//		String arrStr [] = categoryProductIdsStr.split(",");
//		String nowPidStr = "";
//		for(int i=0;i<arrStr.length;i++){
//			nowPidStr =arrStr[i];
//			if(nowPidStr.equals(inproductIdStr)){
//				//有相同的,所以num增加
//				num++;
//				break;//找到,跳出
//			}
//		}
//		return num;
//	}
//
//	//* 4.0.3清理每条的新产品信息
//	private void ProductCategoryIdsStrUpdateOld(Integer productId,String categoryIdsStrNew) {
//		MlbackBlog MlbackBlogReq = new MlbackBlog();
//		MlbackBlog MlbackBlogRes = new MlbackBlog();
//		MlbackBlogReq.setProductId(productId);
//		List<MlbackBlog> MlbackBlogListOld =  MlbackBlogService.selectMlbackBlogByParam(MlbackBlogReq);
//		MlbackBlogRes = MlbackBlogListOld.get(0);
//		String productCategoryIdsStr = MlbackBlogRes.getProductCategoryIdsstr();
//		MlbackCategory mlbackCategoryReq = new MlbackCategory();
//		MlbackCategory mlbackCategoryRes = new MlbackCategory();
//		List<MlbackCategory> MlbackCategoryList = new ArrayList<MlbackCategory>();
//		if(productCategoryIdsStr==null||productCategoryIdsStr.length()==0){
//			//没有被类管理绑定过
//			System.out.println("产品的这个字段下,没有被类管理绑定过,不需要进行移除操作");
//		}else{
//			//被类管理绑定过
//			String productCategoryIdsStrArr [] =  productCategoryIdsStr.split(",");
//			for(int i=0;i<productCategoryIdsStrArr.length;i++){
//				//遍历categoryIdsStr
//				String  categoryIdsStr = productCategoryIdsStrArr[i];
//				Integer categoryIdsInt = Integer.parseInt(categoryIdsStr);
//				mlbackCategoryReq.setCategoryId(categoryIdsInt);
//				MlbackCategoryList = mlbackCategoryService.selectMlbackCategory(mlbackCategoryReq);
//				if(!(MlbackCategoryList.size()>0)){
//					continue;
//				}
//				mlbackCategoryRes = MlbackCategoryList.get(0);
//				
//				//从该中取的老的产品串串
//				String categoryProductIds = "";
//				String categoryProductNames = "";
//				categoryProductIds = mlbackCategoryRes.getCategoryProductIds();
//				categoryProductNames = mlbackCategoryRes.getCategoryProductNames();
//				
//				String categoryProductIdsArr [] = categoryProductIds.split(",");
//				String categoryProductNamesArr [] = categoryProductNames.split(",");
//				
//				List<String> categoryProductIdsStrNewList = new ArrayList<String>();
//				List<String> categoryProductNamesStrNewList = new ArrayList<String>();
//				
//				String categoryProductIdsStrNew="";
//				String categoryProductNamesStrNew="";
//				//对来的产品串进行遍历
//				String productIdnow = productId+"";
//				//该类的产品串进行
//				for(int j =0;j<categoryProductIdsArr.length;j++){
//					//
//					String productOldIdOneStr = categoryProductIdsArr[j];
//					String productOldNamesStr = categoryProductNamesArr[j];
//					
//					if(productOldIdOneStr.equals(productIdnow)){
//						System.out.println("一致就不存了");
//					}else{
//						//移除本个后的该类下全部产品
//						categoryProductIdsStrNewList.add(productOldIdOneStr);
//						categoryProductIdsStrNew+=productOldIdOneStr+",";
//						
//						categoryProductNamesStrNewList.add(productOldNamesStr);
//						categoryProductNamesStrNew+=productOldNamesStr+",";
//					}
//				}
//				//判断是不是空了,空了的话,不移除最后一个字符","
//				if(categoryProductIdsStrNew.length()>0){
//					categoryProductIdsStrNew=categoryProductIdsStrNew.substring(0,categoryProductIdsStrNew.length()-1);
//					categoryProductNamesStrNew=categoryProductNamesStrNew.substring(0,categoryProductNamesStrNew.length()-1);
//				}
//				//封装参数
//				MlbackCategory mlbackCategoryRemoveOld = new MlbackCategory();
//				mlbackCategoryRemoveOld.setCategoryId(categoryIdsInt);
//				mlbackCategoryRemoveOld.setCategoryProductIds(categoryProductIdsStrNew);
//				mlbackCategoryRemoveOld.setCategoryProductNames(categoryProductNamesStrNew);
//				//执行更新
//				mlbackCategoryService.updateByPrimaryKeySelective(mlbackCategoryRemoveOld);
//			}
//		}
//	}
	
	/**5.0	20200608
	 * MlbackBlog	delete
	 * @param MlbackBlog-categoryId
	 * @return 
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackBlog mlbackBlog){
		//接收id信息
		int blogIdInt = mlbackBlog.getBlogId();
		mlbackBlogService.deleteByPrimaryKey(blogIdInt);
		return Msg.success().add("resMsg", "category delete  success");
	}
	

	
	/**
	 * 7.0	20200608
	 * 后端获取backSearchByProduct产品list
	 * @return 
	 * */
//	@RequestMapping(value="/backSearchByProduct",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg backSearchByProduct(HttpServletResponse rep,HttpServletRequest res,HttpSession session,
//			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
//			@RequestParam(value = "blogName") String blogName) throws Exception{
//		
//		//接收传递进来的参数
//		int PagNum = 30;
//		PageHelper.startPage(pn, PagNum);
//		
//		MlbackBlog mlbackBlogReq = new MlbackBlog();
//		mlbackBlogReq.setBlogName(blogName);
//		List<MlbackBlog> MlbackBlogResList = mlbackBlogService.selectMlbackBlogBackSearch(mlbackBlogReq);
//		PageInfo page = new PageInfo(MlbackBlogResList, PagNum);
//		return Msg.success().add("pageInfo", page);
//	}
	
//	/**
//	 * 8.0	onuse	200103
//	 * 前台详情页面wap/pc的productDetails
//	 * @param jsp
//	 * @return 
//	 * */
//	@RequestMapping(value="/tofbProductDetailPageByhtml",method=RequestMethod.GET)
//	 public ModelAndView tomfbProductDetailPageByhtml(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestParam(value = "productSeo") String productSeo) throws Exception{
//	
//		//准备封装参数
//		MlbackBlog mlbackBlogrepBySeo = new MlbackBlog();
//		MlbackBlogrepBySeo.setProductSeo(productSeo);
//		String nowTime = DateUtil.strTime14s();
//		System.out.println("nowTime:"+nowTime+"客户点击ProSeo链接进入: "+productSeo);
//	
//		ModelAndView modelAndView = new ModelAndView();
//		
//		List<MlbackBlog> MlbackBlogResList = MlbackBlogService.selectMlbackBlogByParam(MlbackBlogrepBySeo);
//	  
//		if(!(MlbackBlogResList.size()>0)){
//			//return "redirect:/";
//			modelAndView.setViewName("redirect:/");
//			
//			return modelAndView;
//		}else{
//			MlbackBlog MlbackBlogRes = MlbackBlogResList.get(0);
//			
//			Integer proStatus = MlbackBlogRes.getProductStatus();
//			if(proStatus==1){
//				
//				Integer productIdReq = MlbackBlogRes.getProductId();
//				
//				//接受信息
//				List<MlbackBlogImg> mbackProductImgResList =MlbackBlogImgService.selectMlbackBlogImgByProductId(productIdReq);
//				modelAndView.addObject("mbackProductImgResList", mbackProductImgResList);
//				//放回响应域中
//				res.setAttribute("productId", productIdReq);
//				//放回session域中
//				session.setAttribute("productDetailId", productIdReq);
//				session.setAttribute("MlbackBlogMetaTitle", MlbackBlogRes.getProductMetaTitle());
//				session.setAttribute("MlbackBlogMetaKeywords", MlbackBlogRes.getProductMetaKeywords());
//				session.setAttribute("MlbackBlogMeteDesc", MlbackBlogRes.getProductMetaDesc());
//				//返回视图
//				//return "portal/product/productDetails";
//				modelAndView.setViewName("portal/product/productDetails");
//				return modelAndView;
//			}else{
//				System.out.println("通过链接点进来的productSeo:"+productSeo+",但是此产品已下架,跳回首页");
//				//return "redirect:/";
//				modelAndView.setViewName("redirect:/");
//				return modelAndView;
//			}
//		}
//	 }
	
//	/**
//	  * 11.0	zsh200721
//	  * 通过产品名模糊搜索
//	  * @param productId
//	  * @return 
//	  */
//	 @RequestMapping(value="/searchProductLike",method=RequestMethod.POST)
//	 @ResponseBody
//	 public Msg searchProductLike(@RequestParam(value = "productName") String productName){
//	  //接受信息
//	  //客户搜索记录
//	  MlbackSearch mlbackSearchReq = new MlbackSearch();
//	  mlbackSearchReq.setSearchContent(productName);
//	  String nowTime = DateUtil.strTime14s();
//	  mlbackSearchReq.setSearchCreatetime(nowTime);
//	  mlbackSearchReq.setSearchMotifytime(nowTime);
//	  mlbackSearchService.insertSelective(mlbackSearchReq);
//	  System.out.println("客户搜索的内容,mlbackSearchReq:"+mlbackSearchReq.toString());
//	  //执行搜索
//	  MlbackBlog MlbackBlogReq = new MlbackBlog();
//	  MlbackBlogReq.setProductName(productName);
//	  //System.out.println("操作说明:客户搜索的产品名字productName:"+productName);
//	  List<MlbackBlog> MlbackBlogResList =MlbackBlogService.selectMlbackBlogLike(MlbackBlogReq);
//	  List<MlbackBlog> MlbackBlogResListnum =MlbackBlogService.selectMlbackBlogLikeNum(MlbackBlogReq);
//	  Integer num = MlbackBlogResListnum.size();
//	  //System.out.println("操作说明:客户搜索的产品名,查询结果MlbackBlogResListnum:"+num);
//	  return Msg.success().add("resMsg", "产品名模糊搜索完毕")
//	     .add("MlbackBlogResList", MlbackBlogResList).add("MlbackBlogResListnum", num).add("productName", productName);
//	 }
	 
}
