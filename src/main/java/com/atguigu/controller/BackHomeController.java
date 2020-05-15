package com.atguigu.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.atguigu.bean.back.MlbackAdmin;

/**
 * HomePage
 * @author
 *
 */
@Controller
@RequestMapping("/BackHome")
public class BackHomeController {
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping("/BackHomePage")
	public String tologin(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackHomePage";
		}
	}

}
