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
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackProductService;
import com.atguigu.service.MlfrontCartItemService;
import com.atguigu.service.MlfrontCartService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlfrontOrder")
public class MlfrontOrderController {
		
	@Autowired
	MlfrontOrderService mlfrontOrderService;
	
	@Autowired
	MlfrontOrderItemService mlfrontOrderItemService;
	
	@Autowired
	MlfrontCartItemService mlfrontCartItemService;
	
	@Autowired
	MlfrontCartService mlfrontCartService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	/**
	 * 1.0	onuse	20191225	检查
	 * 前台移动端获取详情页面mfront/tomOrderDetailPage
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping(value="/getNowOrderDetail",method=RequestMethod.GET)
	@ResponseBody
	public Msg getNowOrderDetail(HttpServletResponse rep,HttpServletRequest res,HttpSession session) throws Exception{
		//接收传递进来的参数
		MlfrontUser loginUser =(MlfrontUser) session.getAttribute("loginUser");
		Integer usertype = 0;
		if(loginUser==null){
			usertype = 0;
		}else{
			usertype = 1;
		}
		Integer orderId =  (Integer) session.getAttribute("orderId");
		MlfrontOrderItem mlfrontOrderItemReq = new MlfrontOrderItem();
		mlfrontOrderItemReq.setOrderId(orderId);
		List<MlfrontOrderItem> mlfrontOrderItemList = mlfrontOrderItemService.selectMlfrontOrderItemByOrderId(mlfrontOrderItemReq);
		//返回视图
		return Msg.success().add("resMsg", "更新成功").add("mlfrontOrderItemList", mlfrontOrderItemList).add("orderId", orderId).add("usertype", usertype);
	}
	
	/**3.0	useOn	200323
	 * Cheekout页面,加减更新order表中的OrderItem数量。
	 * @param MlfrontOrder
	 */
	@RequestMapping(value="/updateOrderItemNum",method=RequestMethod.POST)
	@ResponseBody
	public Msg updateOrderItemNum(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontOrderItem mlfrontOrderItem){
		
		Integer orderitemId =  mlfrontOrderItem.getOrderitemId();
		Integer orderitemPskuNumber = mlfrontOrderItem.getOrderitemPskuNumber();
		
		MlfrontOrderItem mlfrontOrderItemReq = new MlfrontOrderItem();
		mlfrontOrderItemReq.setOrderitemId(orderitemId);
		mlfrontOrderItemReq.setOrderitemPskuNumber(orderitemPskuNumber);
		
		mlfrontOrderItemService.updateByPrimaryKeySelective(mlfrontOrderItemReq);
		
		return Msg.success().add("resMsg", "更新成功"); 
	}
	
	/**
	 * 4.0	zsh 0615
	 * 删除购物车中的项delCartItem
	 * @param Msg
	 * @return 
	 * */
	@RequestMapping(value="/delOrderItem",method=RequestMethod.POST)
	@ResponseBody
	public Msg delOrderItem(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontOrderItem mlfrontOrderItem) throws Exception{
		//接收传递进来的参数
		//System.out.println(mlfrontOrderItem);
		Integer orderitemIdOriginal = mlfrontOrderItem.getOrderitemId();
		int isDelSuccess = 0;
		if(orderitemIdOriginal==null){
			//前台传递异常,没有把订单项的id值传进来
			return Msg.success().add("resMsg", "删除失败,主建为null,请联系管理员").add("isDelSuccess", isDelSuccess);//isDelSuccess0删除失败，alert	resMsg/1,删除成功
		}else{
			//通过cartitem的之间查回该条信息，从中取出cartId
			MlfrontOrderItem mlfrontOrderItemReq  =new MlfrontOrderItem();
			mlfrontOrderItemReq.setOrderitemId(orderitemIdOriginal);
			List<MlfrontOrderItem> mlfrontOrderItemResList = mlfrontOrderItemService.selectMlfrontOrderItemByParam(mlfrontOrderItemReq);
			if(mlfrontOrderItemResList.size()>0){
				Integer orderId = mlfrontOrderItemResList.get(0).getOrderId();
				String orderitemIdOriginalStr = orderitemIdOriginal+"";
				String nowTime = DateUtil.strTime14s();
				MlfrontOrder MlfrontOrderReq = new MlfrontOrder();
				MlfrontOrderReq.setOrderId(orderId);
				List<MlfrontOrder> mlfrontOrderListRes  = mlfrontOrderService.selectMlfrontOrderById(MlfrontOrderReq);
				MlfrontOrder mlfrontOrderRes = mlfrontOrderListRes.get(0);
				//1根据cart该购物车中的本条cartItemStr中的字段
				String orderitemidstr = mlfrontOrderRes.getOrderOrderitemidstr();
				String orderItemArr[] =orderitemidstr.split(",");
				String orderitemStrEnd = "";
				int orginalItemNum = orderItemArr.length;
				if(orderItemArr.length>1){
					//1.1如果有多个删除字段中的该项
					for(int i =0;i<orderItemArr.length;i++){
						String tem = orderItemArr[i];
						if(tem.equals(orderitemIdOriginalStr)){
							continue;
						}else{
							orderitemStrEnd=orderitemStrEnd+tem+",";
						}
					}
					int lastIN = orderitemStrEnd.length();
					orderitemStrEnd = orderitemStrEnd.substring(0, (lastIN-1));
					//更新cart中的cartitemStr字段
					MlfrontOrder mlfrontOrderreqE = new MlfrontOrder();
					mlfrontOrderreqE.setOrderId(orderId);
					mlfrontOrderreqE.setOrderOrderitemidstr(orderitemStrEnd);
					mlfrontOrderreqE.setOrderMotifytime(nowTime);
					mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderreqE);
				}else{
					//1.2如果只有一个，删掉购物车
					mlfrontOrderService.deleteByPrimaryKey(orderId);
				}
				//2删除该条CartItem信息
				mlfrontOrderItemService.deleteByPrimaryKey(orderitemIdOriginal);
				orginalItemNum=orginalItemNum-1;
				isDelSuccess = 1;
				return Msg.success().add("resMsg", "删除成功").add("isDelSuccess", isDelSuccess).add("orginalItemNum", orginalItemNum);//isDelSuccess0删除失败，alert	resMsg/1,删除成功
			}else{
				return Msg.success().add("resMsg", "删除失败，该cartitem项不存在，请联系管理员").add("isDelSuccess", isDelSuccess);//isDelSuccess0删除失败，alert	resMsg/1,删除成功
			}
		}			
	}

}