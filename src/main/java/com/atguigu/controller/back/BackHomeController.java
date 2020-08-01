package com.atguigu.controller.back;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.common.Msg;
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
	 * zsh 200730
	 * 中控台首页
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
	 * zsh 200730
	 * 中控台获取付款总金额钱数,总单数
	 * */
	@RequestMapping(value="/getBackHomePayInfo",method=RequestMethod.POST)
	@ResponseBody
	public Msg getBackHomePayInfo(HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo) throws Exception{
		
		List<MlfrontPayInfo> mlfrontPayInfoList =  mlfrontPayInfoService.selectMlfrontPayInfoByDate(mlfrontPayInfo);
		List<MlfrontPayInfo> mlfrontPayInfoSuccessList = new ArrayList<MlfrontPayInfo>();
		Integer payInfoStatus = 0;
		if(mlfrontPayInfoList.size()>0){
			
			for(MlfrontPayInfo mlfrontPayInfoOne:mlfrontPayInfoList){
				payInfoStatus = mlfrontPayInfoOne.getPayinfoStatus();
				//0未支付//1支付成功//2审单完毕//3发货完毕 //4已退款
				if(1==payInfoStatus){
					mlfrontPayInfoSuccessList.add(mlfrontPayInfoOne);
				}else if(2==payInfoStatus){
					mlfrontPayInfoSuccessList.add(mlfrontPayInfoOne);
				}else if(3==payInfoStatus){
					mlfrontPayInfoSuccessList.add(mlfrontPayInfoOne);
				}
				
			}
		}
		return Msg.success().add("resMsg", "统计面板查询某时间内的成交金额,单数").add("mlfrontPayInfoSuccessList", mlfrontPayInfoSuccessList);
	}
	
	/**
	 * zsh 200730
	 * 中控台获取总用户数
	 * */
	@RequestMapping(value="/getBackHomeUserListInfo",method=RequestMethod.POST)
	@ResponseBody
	public Msg getBackHomeUserListInfo(HttpSession session,@RequestBody MlfrontUser mlfrontUser) throws Exception{
		
		
		List<MlfrontUser> mlfrontUserList =  mlfrontUserService.selectMlfrontUserByDate(mlfrontUser);
		return Msg.success().add("resMsg", "统计面板某时间内的总用户数").add("mlfrontUserList", mlfrontUserList);
	}
	


}
