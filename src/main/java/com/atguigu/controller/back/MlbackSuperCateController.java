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
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlbackCategory;
import com.atguigu.common.Const;
//import com.atguigu.bean.MlbackProduct;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackCategoryService;
//import com.atguigu.service.MlbackProductService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackSuperCate")
public class MlbackSuperCateController {
	
	@Autowired
	MlbackCategoryService mlbackCategoryService;
	
//	@Autowired
//	MlbackProductService mlbackProductService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	
	/**
	 * 1.0	onuse	20191225	检查
	 * to后台分类MlbackCategory列表页面
	 * @return jsp
	 * */
	@RequestMapping("/toMlbackSuperCatePage")
	public String tologin(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute(Const.ADMIN_USER);
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/product/mlbackSuperCatePage";
		}
	}
	
	/**2.0	onuse	20191225	检查
	 * 后台MlbackCategory列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackCategoryByPage")
	@ResponseBody
	public Msg getGroupDisplayWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {

		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		List<MlbackCategory> mlbackCategoryList = mlbackCategoryService.selectMlbackCategoryGetAll();
		PageInfo page = new PageInfo(mlbackCategoryList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
	
	/**3.0	onuse	20191225	检查
	 * MlbackCategory	insert/update
	 * @param MlbackCategory
	 * @return
	 */
	@RequestMapping(value="/initializaCategory",method=RequestMethod.POST)
	@ResponseBody
	public Msg initializaCategory(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackCategory mlbackCategory = new MlbackCategory();
		//接受参数信息
		String categoryParentName="---none---";
		String categoryDesc="";
			categoryParentName ="---none---";
		//判断归属是否为none
		Integer	categoryParentId = -1;
		mlbackCategory.setCategoryParentId(categoryParentId);
		mlbackCategory.setCategoryDesc(categoryDesc);
		mlbackCategory.setCategoryParentName(categoryParentName);
		//取出id
		String nowTime = DateUtil.strTime14s();
		mlbackCategory.setCategoryCreatetime(nowTime);
		//无id，insert
		System.out.println("插入前"+mlbackCategory.toString());
		mlbackCategoryService.insertSelective(mlbackCategory);
		System.out.println("插入后"+mlbackCategory.toString());
		return Msg.success().add("resMsg", "插入成功").add("mlbackCategory", mlbackCategory);
	}
	
	
	
	/**3.0	onuse	20191225	检查
	 * MlbackCategory	insert/update
	 * @param MlbackCategory
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackCategory mlbackCategory){
		//接受参数信息
		//获取类名
		String categoryName = mlbackCategory.getCategoryName();
		//获取归属类名
		Integer categoryParentId = mlbackCategory.getCategoryParentId();
		MlbackCategory MlbackCategoryParentNameReq = new MlbackCategory();
		MlbackCategoryParentNameReq.setCategoryId(categoryParentId);
		List<MlbackCategory> MlbackCategoryList = mlbackCategoryService.selectMlbackCategory(MlbackCategoryParentNameReq);
		String categoryParentName="";
		String categoryDesc="";
		if(MlbackCategoryList.size()>0){
			MlbackCategory MlbackCategoryParentNameRes = MlbackCategoryList.get(0);
			categoryParentName = MlbackCategoryParentNameRes.getCategoryName();
			categoryDesc = MlbackCategoryParentNameRes.getCategoryDesc();
		}else{
			categoryParentName ="---none---";
		}
		//判断归属是否为none
		if(categoryParentName.equals("---none---")){
			mlbackCategory.setCategoryDesc(categoryName);
		}else{
			mlbackCategory.setCategoryDesc(categoryDesc+">"+categoryName);
		}
		//取出id
		Integer categoryId = mlbackCategory.getCategoryId();
		String nowTime = DateUtil.strTime14s();
		mlbackCategory.setCategoryMotifytime(nowTime);
		mlbackCategory.setCategoryParentName(categoryParentName);
		if(categoryId==null){
			//无id，insert
			//System.out.println("插入前"+mlbackCategory.toString());
			mlbackCategoryService.insertSelective(mlbackCategory);
			//System.out.println("插入后"+mlbackCategory.toString());
			return Msg.success().add("resMsg", "插入成功");
		}else{
			//有id，update
			mlbackCategoryService.updateByPrimaryKeySelective(mlbackCategory);
			//System.out.println("后台操作:categoryId不为null,走update+intResult:"+intResult);
			return Msg.success().add("resMsg", "更新成功");
		}		
	}
	
	/**4.0	onuse	20191225	检查
	 * MlbackCategory	delete
	 * @param id
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackCategory mlbackCategory){
		//接收id信息
		int categoryIdInt = mlbackCategory.getCategoryId();
		mlbackCategoryService.deleteByPrimaryKey(categoryIdInt);
		return Msg.success().add("resMsg", "delete success");
	}
	
	/**
	 * 5.0	onuse	20200103	检查
	 * 查单条MlbackCategory详情by-categoryId
	 * @param categoryId
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackCategoryDetail",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackCategoryDetail(@RequestParam(value = "categoryId") Integer categoryId){
		
		//接受categoryId
		MlbackCategory mlbackCategoryReq = new MlbackCategory();
		mlbackCategoryReq.setCategoryId(categoryId);
		//查询本条
		List<MlbackCategory> mlbackCategoryResList =mlbackCategoryService.selectMlbackCategory(mlbackCategoryReq);
		MlbackCategory mlbackCategoryOne =mlbackCategoryResList.get(0);
		return Msg.success().add("resMsg", "查categoryOne完毕").add("mlbackCategoryOne", mlbackCategoryOne);
	}
	
	/**
	 * 6.0	onuse	20191225	检查
	 * 传进Cid查询所有的类下的产品list
	 * @param MlbackCategory
	 * @return 
	 */
//	@RequestMapping(value="/getMlFrontCategoryAllProductByCid",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getMlFrontCategoryAllProductByPid(@RequestParam(value = "categoryId") Integer categoryId){
//		
//		//接受categoryId
//		MlbackCategory mlbackCategoryReq = new MlbackCategory();
//		mlbackCategoryReq.setCategoryId(categoryId);
//		//查询本条
//		List<MlbackCategory> mlbackCategoryResList =mlbackCategoryService.selectMlbackCategory(mlbackCategoryReq);
//		MlbackCategory mlbackCategoryOne =mlbackCategoryResList.get(0);
//		String productidsStr = mlbackCategoryOne.getCategoryProductIds();
//		
//		String productidsStrArr [] =productidsStr.split(",");
//		String productidStr ="";
//		Integer productidInt =0;
//		List<MlbackProduct> mlbackProductReqList = new ArrayList<MlbackProduct>();
//		List<MlbackProduct> mlbackProductResList = new ArrayList<MlbackProduct>();
//		MlbackProduct mlbackProductResOne = new MlbackProduct();
//		for(int i=0;i<productidsStrArr.length;i++){
//			productidStr = productidsStrArr[i];
//			productidInt = Integer.parseInt(productidStr);
//			//查询本pid的产品详情
//			MlbackProduct mlbackProductReq = new MlbackProduct();
//			mlbackProductReq.setProductId(productidInt);
//			mlbackProductReqList =mlbackProductService.selectMlbackProduct(mlbackProductReq);
//			mlbackProductResOne = mlbackProductReqList.get(0);
//			mlbackProductResList.add(mlbackProductResOne);
//		}
//		return Msg.success().add("resMsg", "传进Cid查询所有的类下的产品list完毕")
//					.add("mlbackProductResList", mlbackProductResList);
//	}
	
	/**
	 * 7.0	onuse	20191225	检查
	 * 获取全部类目，以便于下拉选择
	 * @param 无参
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackCategoryParentDetail",method=RequestMethod.GET)
	@ResponseBody
	public Msg getOneMlbackCategoryParentDetail(HttpServletResponse rep,HttpServletRequest res){
		
		//查询全部的category信息，便于下拉选择
		List<MlbackCategory> mlbackCategorydownList = mlbackCategoryService.selectMlbackCategoryGetAllByParentId();
		//System.out.println("操作说明:管理员查-categorydownList菜单");
		
		List<MlbackCategory> mlbackCategorydownEr =new ArrayList<MlbackCategory>();
		for(MlbackCategory mlbackCategoryOne :mlbackCategorydownList){
			Integer categoryParentId = mlbackCategoryOne.getCategoryParentId();
			if(categoryParentId>0){
				mlbackCategorydownEr.add(mlbackCategoryOne);
			}
		}
		return Msg.success().add("resMsg", "success")
					.add("mlbackCategorydownList", mlbackCategorydownList).add("mlbackCategorydownEr", mlbackCategorydownEr);
	}
	
	/**
	 * 8.0	onuse	20200103	check
	 * 获取全部类目，以便于下拉选择
	 * @param MlbackCategory
	 * @return 
	 */
	@RequestMapping(value="/getMenuMlbackCategory",method=RequestMethod.GET)
	@ResponseBody
	public Msg getMenuMlbackCategory(HttpServletResponse rep,HttpServletRequest res){
		
		//查询全部的category信息，便于下拉选择
		List<MlbackCategory> mlbackCategorydownList = mlbackCategoryService.selectMenuMlbackCategoryGetAll();
		System.out.println("操作说明:客户查询-getMenuMlbackCategory-菜单");
		
		List<MlbackCategory> mlbackCategorydownEr =new ArrayList<MlbackCategory>();
		for(MlbackCategory mlbackCategoryOne :mlbackCategorydownList){
			Integer categoryParentId = mlbackCategoryOne.getCategoryParentId();
			if(categoryParentId>0){
				mlbackCategorydownEr.add(mlbackCategoryOne);
			}
		}
		
		return Msg.success().add("resMsg", "查allCategorydownList")
					.add("mlbackCategorydownList", mlbackCategorydownList).add("mlbackCategorydownEr", mlbackCategorydownEr);
	}
	
	/**
	 * 9.0	onuse	20200103	check
	 * 前台获取类下产品list详情页面wap/pc
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping(value="/toprolistBycategorySeo",method=RequestMethod.GET)
	public String toprolistBycategorySeoPage(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestParam(value = "categorySeo") String categorySeo) throws Exception{
		//接收传递进来的参数
		String categorySeoReq = categorySeo;
		
		//放回响应域中
		res.setAttribute("categorySeo", categorySeoReq);
		//放回session域中
		session.setAttribute("categorySeo", categorySeoReq);
		
		MlbackCategory mlbackCategoryReq = new MlbackCategory();
		
		mlbackCategoryReq.setCategorySeo(categorySeoReq);
		
		List<MlbackCategory> mlbackCategoryResList = mlbackCategoryService.selectMlbackCategoryBySeo(mlbackCategoryReq);
		
		if(mlbackCategoryResList.size()>0){
			
			MlbackCategory mlbackCategoryRes = mlbackCategoryResList.get(0);
			
			String categoryMetaTitle = mlbackCategoryRes.getCategoryMetatitle();
			String categoryMetaKeyWords = mlbackCategoryRes.getCategoryMetakeywords();
			String categoryMetaDesc = mlbackCategoryRes.getCategoryMetadesc();
			session.setAttribute("categoryMetaTitle", categoryMetaTitle);
			session.setAttribute("categoryMetaKeyWords", categoryMetaKeyWords);
			session.setAttribute("categoryMetaDesc", categoryMetaDesc);
		}else{
			
			return "redirect:https://www.megalook.com";
			
		}
		//返回视图
		return "mfront/prolistBycategorySeo";
	}
	
	/**
	  * 10.0	onuse	20200103	check
	  * 通过产品名查看单条产品的详情
	  * @param productId
	  * @return 
	  */
//	 @RequestMapping(value="/searchBycategorySeo",method=RequestMethod.POST)
//	 @ResponseBody
//	 public Msg searchBycategorySeo(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlbackCategory mlbackCategory){
//		 
//		 //初始化返回下拉所需
//		 //查询all-category信息，便于下拉选择
//		 List<MlbackCategory> mlbackCategorydownList = mlbackCategoryService.selectMlbackCategoryGetAllByParentId();
//		 
//		 List<MlbackCategory> mlbackCategorydownEr =new ArrayList<MlbackCategory>();
//		 for(MlbackCategory mlbackCategoryOne :mlbackCategorydownList){
//			 Integer categoryParentId = mlbackCategoryOne.getCategoryParentId();
//			 if(categoryParentId>0){
//				 mlbackCategorydownEr.add(mlbackCategoryOne);
//			 }
//		 }
//		 
//		 //接受信息
//		 String categorySeoReq = mlbackCategory.getCategorySeo();
//		 MlbackCategory mlbackCategoryReq = new MlbackCategory();
//		 mlbackCategoryReq.setCategorySeo(categorySeoReq);
//		 List<MlbackCategory> mlbackCategoryList = mlbackCategoryService.selectMlbackCategoryBySeo(mlbackCategoryReq);
//		 
//		 if(!(mlbackCategoryList.size()>0)){
//			 return Msg.success().add("resMsg", "通过categorySeo未查到该category").add("mlbackProductResList", null).add("mlbackCategorydownEr", mlbackCategorydownEr);
//		 }
//		 
//		 MlbackCategory mlbackCategoryres = mlbackCategoryList.get(0);
//		 //System.out.println("操作说明:客户点击类菜单-searchBycategorySeo");
//	 
//		 String CategoryProductIdsStr = mlbackCategoryres.getCategoryProductIds();
//		 
//		 if(CategoryProductIdsStr==null){
//			 return Msg.success().add("resMsg", "该类下无prolist").add("mlbackProductResList", null).add("mlbackCategorydownEr", mlbackCategorydownEr);
//		 }
//		 if("".equals(CategoryProductIdsStr)){
//			 return Msg.success().add("resMsg", "该类下无prolist").add("mlbackProductResList", null).add("mlbackCategorydownEr", mlbackCategorydownEr);
//		 }
//		
//		 String productidsStrArr [] =CategoryProductIdsStr.split(",");
//		 String productidStr ="";
//		 Integer productidInt =0;
//		 List<MlbackProduct> mlbackProductReqList = new ArrayList<MlbackProduct>();
//		 List<MlbackProduct> mlbackProductResList = new ArrayList<MlbackProduct>();
//		 MlbackProduct mlbackProductResOne = new MlbackProduct();
//		 for(int i=0;i<productidsStrArr.length;i++){
//			 productidStr = productidsStrArr[i];
//			 productidInt = Integer.parseInt(productidStr);
//			 //查询白pid的产品详情
//			 MlbackProduct mlbackProductReq = new MlbackProduct();
//			 mlbackProductReq.setProductId(productidInt);
//			 mlbackProductReqList =mlbackProductService.selectMlbackProductbyCategorySeo(mlbackProductReq);
//			 if(mlbackProductReqList.size()>0){
//				 mlbackProductResOne = mlbackProductReqList.get(0);
//				 mlbackProductResList.add(mlbackProductResOne);
//			 }
//		 }
//		 return Msg.success().add("resMsg", "searchBycategorySeo完毕")
//				 .add("mlbackProductResList", mlbackProductResList).add("mlbackCategorydownEr", mlbackCategorydownEr);
//	 }
	 
	/**
	 * 11.0	onuse	20191225	检查
	 * 获取getCategorySuperMenu
	 * @param rep res
	 * @return 
	 */
	@RequestMapping(value="/getCategorySuperMenu",method=RequestMethod.POST)
	@ResponseBody
	public Msg getCategorySuperMenu(HttpServletResponse rep,HttpServletRequest res){
		
		//查询全部的category信息
		List<MlbackCategory> mlbackCategorydownList = mlbackCategoryService.selectMenuMlbackCategoryGetAll();
		//System.out.println("操作说明:客户查询-getCategorySuperMenu");
		
		List<MlbackCategory> mlbackCategorydownFirst =new ArrayList<MlbackCategory>();
		for(MlbackCategory mlbackCategoryOne :mlbackCategorydownList){
			Integer categoryParentId = mlbackCategoryOne.getCategoryParentId();
			if(categoryParentId>0){
				//System.out.println("categoryParentId:"+categoryParentId);
			}else{
				//筛选出一级菜单(patentId=-1)的类，//第一级别的导航
				//存到list中，存一下这些ids,这些是一级类
				mlbackCategorydownFirst.add(mlbackCategoryOne);//一级类list;
			}
		}
		List<List<List<MlbackCategory>>> mlbackCategorySuperList =new ArrayList<List<List<MlbackCategory>>>();
		//遍历第一等级导航
		for(MlbackCategory categoryFirstOne :mlbackCategorydownFirst){
			Integer categoryFirstId = categoryFirstOne.getCategoryId();
			
			MlbackCategory mlbackCategorySecReq = new MlbackCategory();
			mlbackCategorySecReq.setCategoryParentId(categoryFirstId);
			
			//查询该父id下的全部category信息
			List<MlbackCategory> categoryNowSecondList = mlbackCategoryService.selectCategorylistByParam(mlbackCategorySecReq);
			//System.out.println("操作说明:客户查询-本二级的菜单完毕Category-菜单");
			
			List<List<MlbackCategory>> mlbackCategoryfirstdownList =new ArrayList<List<MlbackCategory>>();
			for(MlbackCategory categoryOne :categoryNowSecondList){
				Integer categoryId = categoryOne.getCategoryId();
				List<MlbackCategory> mlbackCategorydownEr =new ArrayList<MlbackCategory>();
				//
				mlbackCategorydownEr.add(categoryOne);
				//准备参数，请求此二级下的三级菜单
				MlbackCategory mlbackCategoryReq = new MlbackCategory();
				mlbackCategoryReq.setCategoryParentId(categoryId);
				List<MlbackCategory> mlbackCategoryReqList = mlbackCategoryService.selectCategorylistByParam(mlbackCategoryReq);
				
				if(mlbackCategoryReqList.size()>0){
					for(int i=0;i<mlbackCategoryReqList.size();i++){
						MlbackCategory mlbackCategoryThreeOne = mlbackCategoryReqList.get(i);
						mlbackCategorydownEr.add(mlbackCategoryThreeOne);
					}
					
					mlbackCategoryfirstdownList.add(mlbackCategorydownEr);
				}else{
					mlbackCategoryfirstdownList.add(mlbackCategorydownEr);
					//System.out.println("该二级下没有三级分类");
				}
			}
			mlbackCategorySuperList.add(mlbackCategoryfirstdownList);
		}
		
		return Msg.success().add("resMsg", "getCategoryMenuSenond-end").add("mlbackCategorySuperList", mlbackCategorySuperList).add("categoryFirstList", mlbackCategorydownFirst);
	}
}
