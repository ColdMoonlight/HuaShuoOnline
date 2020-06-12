package com.atguigu.controller.portal;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.atguigu.bean.MlfrontCart;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackProductService;
import com.atguigu.service.MlfrontCartService;

@Controller
@RequestMapping("/MlbackCart")
public class MlfrontCartController {
	
	@Autowired
	MlfrontCartService mlfrontCartService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	/**
	 * 1.0	useOn	0505
	 * 前台购物车列表页面CartPage
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toCartList")
	public String toCartList(HttpServletResponse rep,HttpServletRequest res,HttpSession session) throws Exception{
		
		return "portal/CartOrderPay/cartList";
	}
	
	/**
	 * 2.0	useOn	0505
	 * 前台移动端解算页面mfront/cheakOut
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toCheakOut")
	public String toCheakOut(HttpServletResponse rep,HttpServletRequest res,HttpSession session) throws Exception{
		
		return "portal/CartOrderPay/checkOut";
	}
	
	/**
	 * 3.0	200612
	 * getMlfrontCartByDate
	 * @param mlfrontCart
	 * @return 
	 * */
	@RequestMapping(value="/getMlfrontCartByDate",method=RequestMethod.POST)
	@ResponseBody
	public Msg getMlfrontCartByDate(HttpServletResponse rep,HttpServletRequest res,HttpSession session ,@RequestBody MlfrontCart mlfrontCart){
	
		String beginTime = mlfrontCart.getCartCreatetime();
		String endTime = mlfrontCart.getCartMotifytime();
		MlfrontCart mlfrontCartReq = new MlfrontCart();
		mlfrontCartReq.setCartCreatetime(beginTime);
		mlfrontCartReq.setCartMotifytime(endTime);
		List<MlfrontCart> mlfrontCartReqList = mlfrontCartService.selectMlfrontCartByDate(mlfrontCartReq);
		Integer countNumber =mlfrontCartReqList.size();
		return Msg.success().add("countNumber", countNumber).add("resMsg", "加购数查询成功");
	}
}
