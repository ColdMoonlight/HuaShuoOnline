package com.atguigu.controller.portal;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.ship.Classes.Tracking;
import com.atguigu.utils.app.shipInformation;

@Controller
@RequestMapping("/MlfrontOrderList")
public class MlfrontOrderListController {
		
	@Autowired
	MlfrontOrderService mlfrontOrderService;

	@Autowired
	MlfrontOrderItemService mlfrontOrderItemService;
	
	/**
	 * 1.0	zsh	200720
	 * to	全部订单-分状态查询
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping(value="/selectOrderlistBySearch",method=RequestMethod.POST)
	@ResponseBody
	public Msg selectOrderlistBySearch(@RequestParam(value = "pn", defaultValue = "1") Integer pn,@RequestParam(value = "orderStatus") Integer orderStatus,HttpSession session) {

		MlfrontUser loginUser = (MlfrontUser) session.getAttribute("loginUser");
		
		Integer Uid = loginUser.getUserId();
		MlfrontOrder mlfrontOrder = new MlfrontOrder();
		List<MlfrontOrder> mlfrontOrderList = new ArrayList<MlfrontOrder>();
		mlfrontOrder.setOrderUid(Uid);
		int PagNum = 5;
		PageHelper.startPage(pn, PagNum);
		PageInfo page = new PageInfo();
		System.out.println("orderStatus状态"+orderStatus);
		if(orderStatus==999){
			mlfrontOrderList = mlfrontOrderService.selectOrderListByUidAndSuccessStatus(mlfrontOrder);
			page = new PageInfo(mlfrontOrderList, PagNum);
			mlfrontOrderList = page.getList();
		}else{
			mlfrontOrder.setOrderStatus(orderStatus);//全部//0未支付//1支付成功//2支付失败//3审单完毕 //4发货完毕//5已退款
			//只保留//999全部//1支付成功//3审单完毕(待发货) //4发货完毕(运输中)//5已退款
			mlfrontOrderList = mlfrontOrderService.selectOrderListByUidAndStatus(mlfrontOrder);
			page = new PageInfo(mlfrontOrderList, PagNum);
			mlfrontOrderList = page.getList();
		}
		//1查询2遍历mlfrontOrderList,3读取每个的orderItemIdStr,4切割,5再遍历产寻单条的获取orderItemId对象
		String orderitemidstr="";
		MlfrontOrderItem mlfrontOrderItemReq = new MlfrontOrderItem();
		MlfrontOrderItem mlfrontOrderItemRes = new MlfrontOrderItem();
		List<MlfrontOrderItem> mlfrontOrderItemList = new ArrayList<MlfrontOrderItem>();
		List<MlfrontOrderItem> mlfrontOrderItemReturnList = new ArrayList<MlfrontOrderItem>();
		List<Integer> sizeList = new ArrayList<Integer>();
		for(MlfrontOrder mlfrontOrderOne:mlfrontOrderList){
			orderitemidstr = mlfrontOrderOne.getOrderOrderitemidstr();
			String orderitemidArr[] = orderitemidstr.split(",");
			Integer size = orderitemidArr.length;
			sizeList.add(size);
			for(int i=0;i<orderitemidArr.length;i++){
				String orderitemid = orderitemidArr[i];
				Integer orderitemidInt = Integer.valueOf(orderitemid);
				mlfrontOrderItemReq.setOrderitemId(orderitemidInt); 
				mlfrontOrderItemList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemReq);
				mlfrontOrderItemRes = mlfrontOrderItemList.get(0);
				mlfrontOrderItemReturnList.add(mlfrontOrderItemRes);
			}
		}
		return Msg.success().add("pageInfo", page).add("sizeList", sizeList).add("mlfrontOrderItemReturnList", mlfrontOrderItemReturnList);
	}
	
	/**
	 * 2.0	zsh200722
	 * 登录客户在myOrderListPage中查询某一单的物流跟踪明细
	 * @param String trackingNumber,String Slug
	 * @return 
	 * */
	@RequestMapping(value="/getCheckpointByTrackingNumber",method=RequestMethod.POST)
	@ResponseBody
	public Msg getCheckpointByTrackingNumber(HttpServletResponse rep,HttpServletRequest res,HttpSession session,
			@RequestParam(value = "trackingNumber") String trackingNumber,@RequestParam(value = "Slug") String Slug) {
		
		Tracking TrackingRes = shipInformation.getTrackingByTrackingNumberAndSlug(trackingNumber,Slug);
		return Msg.success().add("TrackingRes", TrackingRes);
	}
}
