package com.atguigu.controller.back;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.service.MlfrontUserService;

/**
 * MlbackPagearea
 * @author
 */
@Controller
@RequestMapping("/MlbackPagearea")
public class MlbackPageareaController {
	
	@Autowired
	MlfrontUserService mlfrontUserService;
	
	/**
	 * zsh 201014
	 * 中控台首页
	 * */
	@RequestMapping("/MlbackPageareaPage")
	public String MlbackPageareaPage(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUser对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackPageAreaPage";
		}
	}

}
