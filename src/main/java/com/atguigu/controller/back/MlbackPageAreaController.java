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
import com.atguigu.bean.MlbackCategory;
import com.atguigu.bean.MlbackPageArea;
import com.atguigu.bean.MlbackProduct;
import com.atguigu.bean.MlbackSlide;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackCategoryService;
import com.atguigu.service.MlbackPageAreaService;
import com.atguigu.service.MlbackProductService;
import com.atguigu.service.MlbackSlideService;
import com.atguigu.service.MlfrontUserService;
import com.atguigu.utils.DateUtil;
import com.atguigu.utils.IfMobileUtils;
import com.atguigu.vo.PageAreaDetail;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * MlbackPageArea
 * @author
 */
@Controller
@RequestMapping("/MlbackPageArea")
public class MlbackPageAreaController {
	
	@Autowired
	MlfrontUserService mlfrontUserService;
	
	@Autowired
	MlbackPageAreaService mlbackPageAreaService;
	
	@Autowired
	MlbackSlideService mlbackSlideService;
	
	@Autowired
	MlbackCategoryService mlbackCategoryService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	/**
	 * zsh 201014
	 * 首页后台控制台
	 * */
	@RequestMapping("/MlbackPageAreaPage")
	public String MlbackPageAreaPage(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUser对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackPageAreaPage";
		}
	}
	
	/**2.0	zsh 201014
	 * 分类MlbackPageArea列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackPageAreaByPage")
	@ResponseBody
	public Msg getMlbackPageAreaByPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {
		int PagNum = 20;
		PageHelper.startPage(pn, PagNum);
		List<MlbackPageArea> mlbackActShowProList = mlbackPageAreaService.selectMlbackPageAreaGetAll();
		PageInfo page = new PageInfo(mlbackActShowProList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
	/**3.0	20201014
	 * mlbackPageArea	initializaPageArea
	 * @param mlbackPageArea
	 * @return
	 */
	@RequestMapping(value="/initializaPageArea",method=RequestMethod.POST)
	@ResponseBody
	public Msg initializaPageArea(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackPageArea mlbackPageArea = new MlbackPageArea();
		//取出id
		String nowTime = DateUtil.strTime14s();
		mlbackPageArea.setPageareaCreatetime(nowTime);
		mlbackPageArea.setPageareaStatus(0);//0未上架1上架中
		mlbackPageArea.setPageareaPcstatus(0);//0未上架1上架中
		//无id,insert
		System.out.println("插入前"+mlbackPageArea.toString());
		mlbackPageAreaService.insertSelective(mlbackPageArea);
		System.out.println("插入后"+mlbackPageArea.toString());
		return Msg.success().add("resMsg", "PageArea初始化成功").add("mlbackPageArea", mlbackPageArea);
	}
	
	/**4.0	20201014
	 * mlbackPageArea	save
	 * @param mlbackPageArea
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackPageArea mlbackPageArea){
		//接收参数信息
		String nowTime = DateUtil.strTime14s();
		mlbackPageArea.setPageareaMotifytime(nowTime);
		//有id,update
		mlbackPageAreaService.updateByPrimaryKeySelective(mlbackPageArea);
		System.out.println("mlbackPageArea-save"+mlbackPageArea.toString());
		return Msg.success().add("resMsg", "更新成功");
	}
	
	/**5.0	20201014
	 * mlbackPageArea	delete
	 * @param id
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackPageArea mlbackPageArea){
		//接收id信息
		Integer pageareaId = mlbackPageArea.getPageareaId();
		mlbackPageAreaService.deleteByPrimaryKey(pageareaId);
		System.out.println("删除了首页pageareaId为:"+pageareaId+"的展区");
		return Msg.success().add("resMsg", "delete success");
	}
	/**
	 * 6.0	20201014
	 * 查看单条类目的详情细节
	 * @param MlbackPageArea
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackPageAreaDetail",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackPageAreaDetail(@RequestBody MlbackPageArea mlbackPageArea){
		
		Integer pageareaId = mlbackPageArea.getPageareaId();
		//接受actshowproId
		MlbackPageArea mlbackPageAreaReq = new MlbackPageArea();
		mlbackPageAreaReq.setPageareaId(pageareaId);
		//查询本条
		MlbackPageArea mlbackPageAreaOne =mlbackPageAreaService.selectMlbackPageAreaById(mlbackPageAreaReq);
		return Msg.success().add("resMsg", "查看单条类目的详情细节完毕")
					.add("mlbackPageAreaOne", mlbackPageAreaOne);
	}
	
	/**3.0	20200703
	 * MlbackActShowPro	initializaActShowPro
	 * @param MlbackActShowPro
	 * @return
	 */
	@RequestMapping(value="/portalSelectPageArea",method=RequestMethod.POST)
	@ResponseBody
	public Msg portalSelectPageArea(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackPageArea mlbackPageAreaReq = new MlbackPageArea();
		//取出id
		String nowTime = DateUtil.strTime14s();
		mlbackPageAreaReq.setPageareaCreatetime(nowTime);
		
		List<MlbackPageArea> mlbackPageAreaResList = new ArrayList<MlbackPageArea>();
		String ifMobile = IfMobileUtils.isMobileOrPc(rep, res);
		
		List<List<PageAreaDetail>> pageArealist = new ArrayList<List<PageAreaDetail>>();
		if(ifMobile.equals("1")){
			//手机
			mlbackPageAreaReq.setPageareaStatus(1);
			mlbackPageAreaResList = mlbackPageAreaService.selectHomepageByStatus(mlbackPageAreaReq);
			
			pageArealist = toReturnList(mlbackPageAreaResList,ifMobile);
		}else{
			//pc
			mlbackPageAreaReq.setPageareaPcstatus(1);
			mlbackPageAreaResList = mlbackPageAreaService.selectHomepageByPcStatus(mlbackPageAreaReq);
			pageArealist = toReturnList(mlbackPageAreaResList,ifMobile);
			
		}
		return Msg.success().add("resMsg", "PageArea初始化成功").add("pageArealist", pageArealist);
	}

	private List<List<PageAreaDetail>> toReturnList(List<MlbackPageArea> mlbackPageAreaResList,String ifMobile) {
		
		List<List<PageAreaDetail>> pageAreaDetailAllList = new ArrayList<List<PageAreaDetail>>();
		
		for(MlbackPageArea mlbackPageAreaOne:mlbackPageAreaResList){
			//第一层
			Integer type = mlbackPageAreaOne.getPageareaType();//0轮播1活动品
			String idstr = mlbackPageAreaOne.getPageareaTypedetailIdstr();
			
			String idstrArr [] = idstr.split(",");
			
			List<PageAreaDetail> pageAreaDetailFollrList = new ArrayList<PageAreaDetail>();
			if(type==0){
				//type==0
				for(int i=0;i<idstrArr.length;i++){
					//第一个
					PageAreaDetail pageAreaDetailOne = new PageAreaDetail();
					
					String slideIdStr=idstrArr[i];
					Integer slideIdInt = Integer.parseInt(slideIdStr);
					
					MlbackSlide mlbackSlideReq = new MlbackSlide();
					mlbackSlideReq.setSlideId(slideIdInt);
					
					MlbackSlide mlbackSlideRes= mlbackSlideService.selectMlbackSlideById(mlbackSlideReq);
					if(mlbackSlideRes!=null){
						Integer ifproORcateORpage = mlbackSlideRes.getSlideIfproorcateorpage();
						pageAreaDetailOne.setPageAreaDetailType(0);//这个轮播
						if(ifMobile.equals("1")){
							pageAreaDetailOne.setPageAreaDetaiImglUrl(mlbackSlideRes.getSlideWapimgurl());
						}else{
							pageAreaDetailOne.setPageAreaDetaiImglUrl(mlbackSlideRes.getSlidePcimgurl());
						}
						pageAreaDetailOne.setPageAreaDetailIfinto(mlbackSlideRes.getSlideIfinto());
						
						if(ifproORcateORpage==0){
							//0pro
							pageAreaDetailOne.setPageAreaDetaiLinklUrl(mlbackSlideRes.getSlideSeoname()+".html");
						}else if(ifproORcateORpage==1){
							//1cate
							pageAreaDetailOne.setPageAreaDetaiLinklUrl("search/"+mlbackSlideRes.getSlideCateseoname()+".html");
						}else{
							//2page
							pageAreaDetailOne.setPageAreaDetaiLinklUrl(mlbackSlideRes.getSlidePageseoname()+".html");
						}
					}
					pageAreaDetailFollrList.add(pageAreaDetailOne);
				}
			}else if(type==1){
				//type==1活动品
				
			}else{
				//type==2类目
				for(int i=0;i<idstrArr.length;i++){
					//第一个
					PageAreaDetail pageAreaDetailOne = new PageAreaDetail();
					
					String cateIdStr=idstrArr[i];
					Integer cateIdInt = Integer.parseInt(cateIdStr);
					
					MlbackCategory mlbackCategoryReq = new MlbackCategory();
					mlbackCategoryReq.setCategoryId(cateIdInt);
					
					MlbackCategory mlbackCategoryRes= mlbackCategoryService.selectMlbackCategoryById(mlbackCategoryReq);
					List<MlbackProduct> mlbackProductResList = new ArrayList<MlbackProduct>();
					if(mlbackCategoryRes!=null){
						String pidsStr = mlbackCategoryRes.getCategoryProductIds();
						if(pidsStr==null){
							continue;
						}
						if("".equals(pidsStr)){
							continue;
						}else{
							String productidsStrArr [] = pidsStr.split(",");
							String productidStr ="";
							Integer productidInt =0;
							List<MlbackProduct> mlbackProductReqList = new ArrayList<MlbackProduct>();
							
							MlbackProduct mlbackProductResOne = new MlbackProduct();
							for(int x=0;x<productidsStrArr.length;x++){
								productidStr = productidsStrArr[x];
								productidInt = Integer.parseInt(productidStr);
								//查询白pid的产品详情
								MlbackProduct mlbackProductReq = new MlbackProduct();
								mlbackProductReq.setProductId(productidInt);
								//查回来的直接就是仅上架的产品
								mlbackProductReqList =mlbackProductService.selectMlbackProductbyPid(mlbackProductReq);
								if(mlbackProductReqList.size()>0){
									mlbackProductResOne = mlbackProductReqList.get(0);
									mlbackProductResList.add(mlbackProductResOne);
								}
							}
						}
					}//cateResList结束
					for(MlbackProduct mlbackProductOne :mlbackProductResList){
						pageAreaDetailOne.setMlbackProduct(mlbackProductOne);
						pageAreaDetailOne.setPageAreaDetailIfinto(1);
						pageAreaDetailOne.setPageAreaDetailType(2);
						pageAreaDetailFollrList.add(pageAreaDetailOne);
					}
				}
			}
			pageAreaDetailAllList.add(pageAreaDetailFollrList);
		}
		return pageAreaDetailAllList;
		
	}
	
//	/**3.0	20200703
//	 * MlbackActShowPro	initializaActShowPro
//	 * @param MlbackActShowPro
//	 * @return
//	 */
//	@RequestMapping(value="/initializaActShowPro",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg initializaActShowPro(HttpServletResponse rep,HttpServletRequest res){
//		
//		MlbackActShowPro mlbackActShowPro = new MlbackActShowPro();
//		//取出id
//		String nowTime = DateUtil.strTime14s();
//		mlbackActShowPro.setActshowproCreatetime(nowTime);
//		mlbackActShowPro.setActshowproStatus(0);//0未上架1上架中
//		//无id，insert
//		System.out.println("插入前"+mlbackActShowPro.toString());
//		mlbackActShowProService.insertSelective(mlbackActShowPro);
//		System.out.println("插入后"+mlbackActShowPro.toString());
//		return Msg.success().add("resMsg", "Catalog初始化成功").add("mlbackActShowPro", mlbackActShowPro);
//	}
	
}
