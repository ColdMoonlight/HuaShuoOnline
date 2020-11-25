package com.atguigu.controller.back;

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
import com.atguigu.bean.MlbackProfbreviewArea;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackProductService;
import com.atguigu.service.MlbackProfbreviewAreaService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackProfbReview")
public class MlbackProfbReviewController {
	
	@Autowired
	MlbackProfbreviewAreaService mlbackProfbreviewAreaService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	/**
	 * 1.0	20200608
	 * to后台分类MlbackProduct列表页面
	 * @return jsp
	 * */
	@RequestMapping("/toMlbackProfbReviewPage")
	public String toMlbackProfbReviewPage(HttpSession session) throws Exception{
		
//		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute(Const.ADMIN_USER);
//		if(mlbackAdmin==null){
//			//SysUsers对象为空
//			return "back/mlbackAdminLogin";
//		}else{
			return "back/product/mlbackProfbReviewPage";
//		}
	}
	
	/**2.0	20200608
	 * 后台MlbackProduct列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackProfbreviewByPage")
	@ResponseBody
	public Msg getMlbackProfbreviewByPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {

		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		List<MlbackProfbreviewArea> MlbackProfbreviewAreaList = mlbackProfbreviewAreaService.selectMlbackProductGetAllSimple();
		PageInfo page = new PageInfo(MlbackProfbreviewAreaList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
	/**3.0	20200608
	 * MlbackProfbreviewArea	initializaProfbreviewArea
	 * @param MlbackProfbreviewArea
	 * @return
	 */
	@RequestMapping(value="/initializaProfbreviewArea",method=RequestMethod.POST)
	@ResponseBody
	public Msg initializaProfbreviewArea(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackProfbreviewArea mlbackProfbreviewArea = new MlbackProfbreviewArea();
		//取出id
		String nowTime = DateUtil.strTime14s();
		mlbackProfbreviewArea.setProfbreviewAreaCreatetime(nowTime);
		mlbackProfbreviewAreaService.insertSelective(mlbackProfbreviewArea);
		return Msg.success().add("resMsg", "Product初始化成功").add("mlbackProfbreviewArea", mlbackProfbreviewArea);
	}
	
	/**4.0	20200608
	 * MlbackProduct	update
	 * @param MlbackProduct
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProfbreviewArea mlbackProfbreviewArea){
		//接受参数信息
		String nowTime = DateUtil.strTime14s();
		mlbackProfbreviewArea.setProfbreviewAreaMotifytime(nowTime);
		
		mlbackProfbreviewAreaService.updateByPrimaryKeySelective(mlbackProfbreviewArea);
		return Msg.success().add("resMsg", "category保存成功");
	}
	
	/**5.0	20200608
	 * MlbackProfbreviewArea	delete
	 * @param MlbackProfbreviewArea-profbreviewAreaId
	 * @return 
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackProfbreviewArea mlbackProfbreviewArea){
		//接收id信息
		int profbreviewAreaId = mlbackProfbreviewArea.getProfbreviewAreaId();
		mlbackProfbreviewAreaService.deleteByPrimaryKey(profbreviewAreaId);
		return Msg.success().add("resMsg", "category delete  success");
	}
	
	/**
	 * 6.0	20200608
	 * 查看单个产品的详情
	 * @param productId
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackProfbreviewAreaDetail",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackProfbreviewAreaDetail(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProfbreviewArea mlbackProfbreviewArea){
		//接受信息
		Integer profbreviewAreaId = mlbackProfbreviewArea.getProfbreviewAreaId();
		Integer productSupercateid = mlbackProfbreviewArea.getProfbreviewSupercateId();
		
		MlbackProfbreviewArea mlbackProfbreviewAreaReq = new MlbackProfbreviewArea();
		mlbackProfbreviewAreaReq.setProfbreviewAreaId(profbreviewAreaId);
		mlbackProfbreviewAreaReq.setProfbreviewSupercateId(productSupercateid);
		
		MlbackProfbreviewArea mlbackProfbreviewAreaOne = new MlbackProfbreviewArea();
		
		List<MlbackProfbreviewArea> mlbackProfbreviewAreaResList =mlbackProfbreviewAreaService.selectMlbackProfbreviewAreabyParam(mlbackProfbreviewAreaReq);
		if(mlbackProfbreviewAreaResList.size()>0){
			//如果用这个id查到,就拿出来.
			mlbackProfbreviewAreaOne = mlbackProfbreviewAreaResList.get(0);
		}
		//System.out.println("操作说明：查询-mlbackProductOne:"+mlbackProductOne);
		return Msg.success().add("resMsg", "查看单个产品的fb评论").add("mlbackProfbreviewAreaOne", mlbackProfbreviewAreaOne);
	}
	
}
