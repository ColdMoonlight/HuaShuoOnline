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

import com.atguigu.bean.MlbackActShowPro;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlbackCategory;
import com.atguigu.bean.MlbackPageArea;
import com.atguigu.bean.MlbackProduct;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackPageAreaService;
import com.atguigu.service.MlfrontUserService;
import com.atguigu.utils.DateUtil;
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
