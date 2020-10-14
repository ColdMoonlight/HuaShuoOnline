package com.atguigu.controller.back;

import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.MlbackActShowPro;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlbackPageArea;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackPageAreaService;
import com.atguigu.service.MlfrontUserService;
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
}
