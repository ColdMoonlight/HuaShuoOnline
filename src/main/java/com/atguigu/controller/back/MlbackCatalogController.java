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
import com.atguigu.bean.MlbackCatalog;
import com.atguigu.bean.MlbackProduct;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackCatalogService;
import com.atguigu.service.MlbackProductService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackCatalog")
public class MlbackCatalogController {
	
	@Autowired
	MlbackCatalogService mlbackCatalogService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	/**
	 * 1.0	20200703
	 * to后台分类MlbackCatalog列表页面
	 * @return jsp
	 * */
	@RequestMapping("/toMlbackCatalogPage")
	public String tologin(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute(Const.ADMIN_USER);
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/marketing/mlbackCatalogPage";
		}
	}
	
	/**2.0	20200703
	 * 后台MlbackCatalog列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackCatalogByPage")
	@ResponseBody
	public Msg getGroupDisplayWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {

		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		List<MlbackCatalog> mlbackCatalogList = mlbackCatalogService.selectMlbackCatalogGetAll();
		PageInfo page = new PageInfo(mlbackCatalogList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
	/**3.0	20200608
	 * MlbackCatalog	initializaCatalog
	 * @param MlbackCatalog
	 * @return
	 */
	@RequestMapping(value="/initializaCatalog",method=RequestMethod.POST)
	@ResponseBody
	public Msg initializaCatalog(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackCatalog MlbackCatalog = new MlbackCatalog();
		//接受参数信息
		String CatalogParentName="---none---";
		String CatalogDesc="";
		CatalogParentName ="---none---";
		//判断归属是否为none
		Integer	CatalogParentId = -1;
		MlbackCatalog.setCatalogParentId(CatalogParentId);
		MlbackCatalog.setCatalogDesc(CatalogDesc);
		MlbackCatalog.setCatalogParentName(CatalogParentName);
		//取出id
		String nowTime = DateUtil.strTime14s();
		MlbackCatalog.setCatalogCreatetime(nowTime);
		MlbackCatalog.setCatalogStatus(0);//0未上架1上架中
		//无id，insert
		System.out.println("插入前"+MlbackCatalog.toString());
		mlbackCatalogService.insertSelective(MlbackCatalog);
		System.out.println("插入后"+MlbackCatalog.toString());
		return Msg.success().add("resMsg", "Catalog初始化成功").add("MlbackCatalog", MlbackCatalog);
	}
	
	/**4.0	20200608
	 * MlbackCatalog	update
	 * @param MlbackCatalog
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackCatalog MlbackCatalog){
		//接受参数信息
		//获取类名
		String CatalogName = MlbackCatalog.getCatalogName();
		//获取归属类名
		Integer CatalogParentId = MlbackCatalog.getCatalogParentId();
		MlbackCatalog MlbackCatalogParentNameReq = new MlbackCatalog();
		MlbackCatalogParentNameReq.setCatalogId(CatalogParentId);
		List<MlbackCatalog> MlbackCatalogList = mlbackCatalogService.selectMlbackCatalog(MlbackCatalogParentNameReq);
		String CatalogParentName="";
		String CatalogDesc="";
		if(MlbackCatalogList.size()>0){
			MlbackCatalog MlbackCatalogParentNameRes = MlbackCatalogList.get(0);
			CatalogParentName = MlbackCatalogParentNameRes.getCatalogName();
			CatalogDesc = MlbackCatalogParentNameRes.getCatalogDesc();
		}else{
			CatalogParentName ="---none---";
		}
		//判断归属是否为none
		if(CatalogParentName.equals("---none---")){
			MlbackCatalog.setCatalogDesc(CatalogName);
		}else{
			MlbackCatalog.setCatalogDesc(CatalogDesc+">"+CatalogName);
		}
		String nowTime = DateUtil.strTime14s();
		MlbackCatalog.setCatalogMotifytime(nowTime);
		MlbackCatalog.setCatalogParentName(CatalogParentName);
		mlbackCatalogService.updateByPrimaryKeySelective(MlbackCatalog);
		return Msg.success().add("resMsg", "Catalog保存成功");
	}
	
	/**5.0	20200608
	 * MlbackCatalog	delete
	 * @param MlbackCatalog-CatalogId
	 * @return 
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackCatalog MlbackCatalog){
		//接收id信息
		int CatalogIdInt = MlbackCatalog.getCatalogId();
		mlbackCatalogService.deleteByPrimaryKey(CatalogIdInt);
		return Msg.success().add("resMsg", "Catalog delete  success");
	}
	
	/**
	 * 6.0	20200608
	 * 查单条MlbackCatalog详情
	 * @param MlbackCatalog-CatalogId
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackCatalogDetail",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackCatalogDetail(@RequestBody MlbackCatalog MlbackCatalog){
		
		//接受CatalogId
		Integer CatalogId = MlbackCatalog.getCatalogId();
		MlbackCatalog MlbackCatalogReq = new MlbackCatalog();
		MlbackCatalogReq.setCatalogId(CatalogId);
		//查询本条
		List<MlbackCatalog> MlbackCatalogResList =mlbackCatalogService.selectMlbackCatalog(MlbackCatalogReq);
		MlbackCatalog MlbackCatalogOne =MlbackCatalogResList.get(0);
		return Msg.success().add("resMsg", "查CatalogOne完毕").add("MlbackCatalogOne", MlbackCatalogOne);
	}
	
	/**
	 * 7.0	20200608
	 * 获取全部类目，以便于下拉选择
	 * @param 无参
	 * @return 
	 */
	@RequestMapping(value="/getMlbackCatalogDropdownSelect",method=RequestMethod.POST)
	@ResponseBody
	public Msg getMlbackCatalogDropdownSelect(HttpServletResponse rep,HttpServletRequest res){
		
		//查询全部的Catalog信息，便于下拉选择
		List<MlbackCatalog> MlbackCatalogdownList = mlbackCatalogService.selectMlbackCatalogGetAllByParentId();
		//System.out.println("操作说明:管理员查-CatalogdownList菜单");
		
		List<MlbackCatalog> MlbackCatalogdownEr =new ArrayList<MlbackCatalog>();
		for(MlbackCatalog MlbackCatalogOne :MlbackCatalogdownList){
			Integer CatalogParentId = MlbackCatalogOne.getCatalogParentId();
			if(CatalogParentId>0){
				MlbackCatalogdownEr.add(MlbackCatalogOne);
			}
		}
		return Msg.success().add("resMsg", "success").add("MlbackCatalogdownList", MlbackCatalogdownList).add("MlbackCatalogdownEr", MlbackCatalogdownEr);
	}
	
	/**
	 * 8.0	20200608
	 * 后端获取类下产品list详情页面wap/pc
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping(value="/backSearchByCatalog",method=RequestMethod.POST)
	@ResponseBody
	public Msg backSearchByCatalog(HttpServletResponse rep,HttpServletRequest res,HttpSession session,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "CatalogName") String CatalogName,
			@RequestParam(value = "CatalogSuperCateId", defaultValue = "1") Integer CatalogSuperCateId) throws Exception{
		
		//接收传递进来的参数
		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		
		MlbackCatalog MlbackCatalogReq = new MlbackCatalog();
		MlbackCatalogReq.setCatalogCateid(CatalogSuperCateId);
		MlbackCatalogReq.setCatalogName(CatalogName);
		List<MlbackCatalog> MlbackCatalogResList = mlbackCatalogService.selectMlbackCatalogBackSearch(MlbackCatalogReq);
		
		PageInfo page = new PageInfo(MlbackCatalogResList, PagNum);
		
		return Msg.success().add("pageInfo", page);
			
	}
	
//	/**
//	 * 9.0	20200608
//	 * 前台获取类下产品list页面
//	 * @param jsp
//	 * @return 
//	 * */
//	@RequestMapping(value="/toprolistByCatalogSeoPage",method=RequestMethod.GET)
//	public String toprolistByCatalogSeoPage(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestParam(value = "CatalogSeo") String CatalogSeo) throws Exception{
//		//接收传递进来的参数
//		String CatalogSeoReq = CatalogSeo;
//		
//		//放回响应域中
//		res.setAttribute("CatalogSeo", CatalogSeoReq);
//		//放回session域中
//		session.setAttribute("CatalogSeo", CatalogSeoReq);
//		
//		MlbackCatalog MlbackCatalogReq = new MlbackCatalog();
//		
//		MlbackCatalogReq.setCatalogSeo(CatalogSeoReq);
//		
//		List<MlbackCatalog> MlbackCatalogResList = mlbackCatalogService.selectMlbackCatalogBySeo(MlbackCatalogReq);
//		
//		if(MlbackCatalogResList.size()>0){
//			
//			MlbackCatalog MlbackCatalogRes = MlbackCatalogResList.get(0);
//			
//			String CatalogMetaTitle = MlbackCatalogRes.getCatalogMetatitle();
//			String CatalogMetaKeyWords = MlbackCatalogRes.getCatalogMetakeywords();
//			String CatalogMetaDesc = MlbackCatalogRes.getCatalogMetadesc();
//			session.setAttribute("CatalogMetaTitle", CatalogMetaTitle);
//			session.setAttribute("CatalogMetaKeyWords", CatalogMetaKeyWords);
//			session.setAttribute("CatalogMetaDesc", CatalogMetaDesc);
//		}else{
//			
//			return "redirect:https://www.megalook.com";
//			
//		}
//		//返回视图
//		return "portal/prolistByCatalogSeo";
//	}
//	
//	/**
//	  * 10.0	20200608
//	  * 通过产品名查看单条产品的详情
//	  * @param MlbackCatalog-CatalogSeo
//	  * @return 
//	  */
//	 @RequestMapping(value="/searchByCatalogSeo",method=RequestMethod.POST)
//	 @ResponseBody
//	 public Msg searchByCatalogSeo(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlbackCatalog MlbackCatalog){
//		 
//		 //初始化返回下拉所需
//		 //查询all-Catalog信息，便于下拉选择
//		 List<MlbackCatalog> MlbackCatalogdownList = mlbackCatalogService.selectMlbackCatalogGetAllByParentId();
//		 
//		 List<MlbackCatalog> MlbackCatalogdownEr =new ArrayList<MlbackCatalog>();
//		 for(MlbackCatalog MlbackCatalogOne :MlbackCatalogdownList){
//			 Integer CatalogParentId = MlbackCatalogOne.getCatalogParentId();
//			 if(CatalogParentId>0){
//				 MlbackCatalogdownEr.add(MlbackCatalogOne);
//			 }
//		 }
//		 
//		 //接受信息
//		 String CatalogSeoReq = MlbackCatalog.getCatalogSeo();
//		 MlbackCatalog MlbackCatalogReq = new MlbackCatalog();
//		 MlbackCatalogReq.setCatalogSeo(CatalogSeoReq);
//		 List<MlbackCatalog> MlbackCatalogList = mlbackCatalogService.selectMlbackCatalogBySeo(MlbackCatalogReq);
//		 
//		 if(!(MlbackCatalogList.size()>0)){
//			 return Msg.success().add("resMsg", "通过CatalogSeo未查到该Catalog").add("mlbackProductResList", null).add("MlbackCatalogdownEr", MlbackCatalogdownEr);
//		 }
//		 
//		 MlbackCatalog MlbackCatalogres = MlbackCatalogList.get(0);
//		 //System.out.println("操作说明:客户点击类菜单-searchByCatalogSeo");
//	 
//		 String CatalogProductIdsStr = MlbackCatalogres.getCatalogProductIds();
//		 
//		 if(CatalogProductIdsStr==null){
//			 return Msg.success().add("resMsg", "该类下无prolist").add("mlbackProductResList", null).add("MlbackCatalogdownEr", MlbackCatalogdownEr);
//		 }
//		 if("".equals(CatalogProductIdsStr)){
//			 return Msg.success().add("resMsg", "该类下无prolist").add("mlbackProductResList", null).add("MlbackCatalogdownEr", MlbackCatalogdownEr);
//		 }
//		
//		 String productidsStrArr [] =CatalogProductIdsStr.split(",");
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
//			 mlbackProductReqList =mlbackProductService.selectMlbackProductbyCatalogSeo(mlbackProductReq);
//			 if(mlbackProductReqList.size()>0){
//				 mlbackProductResOne = mlbackProductReqList.get(0);
//				 mlbackProductResList.add(mlbackProductResOne);
//			 }
//		 }
//		 return Msg.success().add("resMsg", "searchByCatalogSeo完毕")
//				 .add("mlbackProductResList", mlbackProductResList).add("MlbackCatalogdownEr", MlbackCatalogdownEr);
//	 }
//	 
//	/**
//	 * 11.0	onuse	20191225	检查
//	 * 获取getCatalogSuperMenu
//	 * @param rep res
//	 * @return 
//	 */
//	@RequestMapping(value="/getCatalogSuperMenu",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getCatalogSuperMenu(HttpServletResponse rep,HttpServletRequest res){
//		
//		//查询全部的Catalog信息
//		List<MlbackCatalog> MlbackCatalogdownList = mlbackCatalogService.selectMenuMlbackCatalogGetAll();
//		//System.out.println("操作说明:客户查询-getCatalogSuperMenu");
//		
//		List<MlbackCatalog> MlbackCatalogdownFirst =new ArrayList<MlbackCatalog>();
//		for(MlbackCatalog MlbackCatalogOne :MlbackCatalogdownList){
//			Integer CatalogParentId = MlbackCatalogOne.getCatalogParentId();
//			if(CatalogParentId>0){
//				//System.out.println("CatalogParentId:"+CatalogParentId);
//			}else{
//				//筛选出一级菜单(patentId=-1)的类，//第一级别的导航
//				//存到list中，存一下这些ids,这些是一级类
//				MlbackCatalogdownFirst.add(MlbackCatalogOne);//一级类list;
//			}
//		}
//		List<List<List<MlbackCatalog>>> MlbackCatalogSuperList =new ArrayList<List<List<MlbackCatalog>>>();
//		//遍历第一等级导航
//		for(MlbackCatalog CatalogFirstOne :MlbackCatalogdownFirst){
//			Integer CatalogFirstId = CatalogFirstOne.getCatalogId();
//			
//			MlbackCatalog MlbackCatalogSecReq = new MlbackCatalog();
//			MlbackCatalogSecReq.setCatalogParentId(CatalogFirstId);
//			
//			//查询该父id下的全部Catalog信息
//			List<MlbackCatalog> CatalogNowSecondList = mlbackCatalogService.selectCataloglistByParam(MlbackCatalogSecReq);
//			//System.out.println("操作说明:客户查询-本二级的菜单完毕Catalog-菜单");
//			
//			List<List<MlbackCatalog>> MlbackCatalogfirstdownList =new ArrayList<List<MlbackCatalog>>();
//			for(MlbackCatalog CatalogOne :CatalogNowSecondList){
//				Integer CatalogId = CatalogOne.getCatalogId();
//				List<MlbackCatalog> MlbackCatalogdownEr =new ArrayList<MlbackCatalog>();
//				//
//				MlbackCatalogdownEr.add(CatalogOne);
//				//准备参数，请求此二级下的三级菜单
//				MlbackCatalog MlbackCatalogReq = new MlbackCatalog();
//				MlbackCatalogReq.setCatalogParentId(CatalogId);
//				List<MlbackCatalog> MlbackCatalogReqList = mlbackCatalogService.selectCataloglistByParam(MlbackCatalogReq);
//				
//				if(MlbackCatalogReqList.size()>0){
//					for(int i=0;i<MlbackCatalogReqList.size();i++){
//						MlbackCatalog MlbackCatalogThreeOne = MlbackCatalogReqList.get(i);
//						MlbackCatalogdownEr.add(MlbackCatalogThreeOne);
//					}
//					
//					MlbackCatalogfirstdownList.add(MlbackCatalogdownEr);
//				}else{
//					MlbackCatalogfirstdownList.add(MlbackCatalogdownEr);
//					//System.out.println("该二级下没有三级分类");
//				}
//			}
//			MlbackCatalogSuperList.add(MlbackCatalogfirstdownList);
//		}
//		
//		return Msg.success().add("resMsg", "getCatalogMenuSenond-end").add("MlbackCatalogSuperList", MlbackCatalogSuperList).add("CatalogFirstList", MlbackCatalogdownFirst);
//	}
}
