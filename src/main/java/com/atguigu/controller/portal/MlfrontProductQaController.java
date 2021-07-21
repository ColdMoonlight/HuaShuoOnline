package com.atguigu.controller.portal;

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
import com.atguigu.bean.MlfrontProductQa;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.atguigu.service.MlfrontProductQaService;
import com.atguigu.utils.DateUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/MlfrontProductQa")
public class MlfrontProductQaController {
		
	@Autowired
	MlfrontProductQaService MlfrontProductQaService;
	
	
	/**
	 * 1.0	20200703
	 * to后台分类MlfrontProductQa列表页面
	 * @return jsp
	 * */
	@RequestMapping("/toMlfrontProductQaPage")
	public String toMlfrontProductQaPage(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute(Const.ADMIN_USER);
		if(mlbackAdmin==null){
			//MlbackAdmin对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/product/mlfrontProductQaPage";
		}
	}
	/**
	 * 4.0	useOn	0505
	 * 后台MlfrontProductQa列表分页list数据
	 * @param MlbackAreafreight
	 * @return 
	 */
	@RequestMapping(value="/getAllMlfrontProductQa")
	@ResponseBody
	public Msg getAllMlfrontProductQa(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session){
		//查询全部QA
		int PagNum = Const.PAGE_NUM_CATEGORY;
		PageHelper.startPage(pn, PagNum);
		List<MlfrontProductQa> MlfrontProductQaResList =MlfrontProductQaService.selectMlfrontProductQaGetAll();
		PageInfo page = new PageInfo(MlfrontProductQaResList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	/**1.0	UseNow	1202
	 * MlfrontProductQa	insert
	 * @param MlfrontProductQa
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontProductQa MlfrontProductQa){
		//接受参数信息
		MlfrontProductQaService.updateByPrimaryKeySelective(MlfrontProductQa);
		return Msg.success().add("resMsg", "保存QA成功").add("MlfrontProductQa", MlfrontProductQa);
	}
	/**2.0	useOn	0505
	 * MlfrontProductQa	delete
	 * @param id
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlfrontProductQa MlfrontProductQa){
		//接收id信息
		int productqaId = MlfrontProductQa.getProductqaId();
		MlfrontProductQaService.deleteByPrimaryKey(productqaId);
		return Msg.success().add("resMsg", "delete success");
	}
	
	/**3.0	useOn	0505
	 * MlfrontProductQa	update
	 * @param id MlfrontProductQa
	 * @return
	 */
	@RequestMapping(value="/update",method=RequestMethod.POST)
	@ResponseBody
	public Msg update(@RequestBody MlfrontProductQa MlfrontProductQa){
		//接受信息
		String nowtime = DateUtil.strTime14s();
		MlfrontProductQa.setProductqaModifyTime(nowtime);
		//更新本条状态
		MlfrontProductQaService.updateByPrimaryKeySelective(MlfrontProductQa);
		return Msg.success().add("resMsg", "更新成功");
	}
	
	/**
	 * 4.0	useOn	0505
	 * 查看单条信息
	 * @param MlbackAreafreight
	 * @return 
	 */
	@RequestMapping(value="/getOneMlfrontProductQaDetail",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlfrontProductQaDetail(@RequestParam(value = "productqaId") Integer productqaId){
		
		//接受categoryId
		MlfrontProductQa MlfrontProductQaReq = new MlfrontProductQa();
		MlfrontProductQaReq.setProductqaId(productqaId);
		//查询本条
		List<MlfrontProductQa> MlfrontProductQaResList =MlfrontProductQaService.selectMlfrontProductQaById(MlfrontProductQaReq);
		MlfrontProductQa MlfrontProductQaOne =MlfrontProductQaResList.get(0);
		return Msg.success().add("resMsg", "查看单条MlfrontProductQaOne的详情细节完毕")
					.add("MlfrontProductQaOne", MlfrontProductQaOne);
	}
	
}
