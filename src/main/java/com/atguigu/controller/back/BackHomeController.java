package com.atguigu.controller.back;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontUserService;

/**
 * HomePage
 * @author
 */
@Controller
@RequestMapping("/BackHome")
public class BackHomeController {
	
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	MlfrontOrderService mlfrontOrderService;
	
	@Autowired
	MlfrontOrderItemService mlfrontOrderItemService;
	
	@Autowired
	MlfrontUserService mlfrontUserService;
	
	/**
	 * 	onuse	20200103
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
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping("/getBackHomePayInfo")
	public String getBackHomePayInfo(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackHomePage";
		}
	}
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping("/getBackHomeOrderInfo")
	public String getBackHomeOrderInfo(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackHomePage";
		}
	}
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping("/getBackHomeUserListInfo")
	public String getBackHomeUserListInfo(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackHomePage";
		}
	}

}
