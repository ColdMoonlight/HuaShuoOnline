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
import com.atguigu.bean.CheckRecover;
import com.atguigu.bean.MlbackSearch;
import com.atguigu.bean.MlbackSmstype;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlbackSmstypeService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.CheckRecoverService;
import com.atguigu.ship.Classes.Checkpoint;
import com.atguigu.ship.Classes.Tracking;
import com.atguigu.utils.SMSUtilshtml;
import com.atguigu.utils.URLLocationUtils;
import com.atguigu.utils.app.shipInformation;

@Controller
@RequestMapping("/MlfrontOrderList")
public class MlfrontOrderListController {
		
	@Autowired
	MlfrontOrderService mlfrontOrderService;

	@Autowired
	MlfrontOrderItemService mlfrontOrderItemService;
	
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	MlbackSmstypeService mlbackSmstypeService;
	
	@Autowired
	CheckRecoverService checkRecoverService;
	
//	afterShip的真实物流url环境
	private final static String ConnectionAPIid = "7b04f01f-4f04-4b37-bbb9-5b159af73ee1";
	
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
		int PagNum = Const.PAGE_NUM_FrontOrderNum;
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
		
		Tracking trackingRes = shipInformation.getTrackingByTrackingNumberAndSlug(trackingNumber,Slug);
		List<Checkpoint> CheckpointList =  trackingRes.getCheckpoints();
		
		int i=0;
		for(Checkpoint Checkpoint:CheckpointList){
			System.out.println(i+":"+Checkpoint);
			i++;
		}
		return Msg.success().add("trackingRes", trackingRes);
	}
	
	/**
	 * 	3.0	zsh20804
	 * */
	@RequestMapping("/searchTrackPage")
	public String searchTrackPage(HttpSession session) throws Exception{
		
		return "portal/searchTrackPage";
	}
	
	/**
	 * 4.0	zsh200804
	 * 游客查询物流明细by平台交易号payinfoPlatenum
	 * @param String PayInfoNumStr
	 * @return 
	 * */
	@RequestMapping(value="/getTrackDetailByPayinfoPlatenum",method=RequestMethod.POST)
	@ResponseBody
	public Msg getCheckpointByTrackingNumber(HttpServletResponse rep,HttpServletRequest res,HttpSession session,
			@RequestParam(value = "payinfoPlatenum") String payinfoPlatenum) {
		
		//查询payInfo表,找回本支付单的进程状态,并描述
		MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
		mlfrontPayInfoReq.setPayinfoPlatenum(payinfoPlatenum);
		mlfrontPayInfoReq.setPayinfoStatus(null);
		List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectHighPayInfoListBySearch(mlfrontPayInfoReq);
		MlfrontPayInfo mlfrontPayInfoOne = new MlfrontPayInfo();
		if(mlfrontPayInfoList.size()>0){
			mlfrontPayInfoOne = mlfrontPayInfoList.get(0);
			Integer orderId = mlfrontPayInfoOne.getPayinfoOid();
			
			Integer payinfoStatus = mlfrontPayInfoOne.getPayinfoStatus();
			
			if(payinfoStatus==1){
				return Msg.fail().add("resMsg", "The order is being processing...");
			}else if(payinfoStatus==2){
				return Msg.fail().add("resMsg", "The order is being processing...");
			}else if(payinfoStatus==3){
				MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
				mlfrontOrderReq.setOrderId(orderId);
				List<MlfrontOrder> mlfrontOrderList = mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderReq);
				if(mlfrontOrderList.size()>0){
					MlfrontOrder mlfrontOrderOne = mlfrontOrderList.get(0);
					String Slug = mlfrontOrderOne.getOrderLogisticsname();
					String trackingNumber = mlfrontOrderOne.getOrderLogisticsnumber();
					Tracking trackingRes = shipInformation.getTrackingByTrackingNumberAndSlug(trackingNumber,Slug);
					return Msg.success().add("trackingRes", trackingRes);
				}else if(payinfoStatus==4){
					return Msg.fail().add("resMsg", "The order has been refunded, please check...");
				}else{
					return Msg.fail().add("resMsg", "Please check your platform transaction number");
				}
			}else{
				return Msg.fail().add("resMsg", "Please check your platform transaction number");
			}
		}else{
			return Msg.fail().add("resMsg", "Please check your platform transaction number");
		}
	}
	
	/**
	 * 5.0	zsh200804
	 * 游客查询物流明细by物流单号TrackingNumber
	 * @param String PayInfoNumStr
	 * @return 
	 * */
	@RequestMapping(value="/getTrackDetailByTrackingNumber",method=RequestMethod.POST)
	@ResponseBody
	public Msg getTrackDetailByTrackingNumber(HttpServletResponse rep,HttpServletRequest res,HttpSession session,
			@RequestParam(value = "trackingNumber") String trackingNumber) {
		
		MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
		mlfrontOrderReq.setOrderLogisticsnumber(trackingNumber);
		mlfrontOrderReq.setOrderStatus(4);
		//0未支付//1支付成功//2支付失败//3审单完毕 //4发货完毕//5已退款
		List<MlfrontOrder> mlfrontOrderList = mlfrontOrderService.selectMlfrontOrderByTrackingNumber(mlfrontOrderReq);
		
		if(mlfrontOrderList.size()>0){
			MlfrontOrder mlfrontOrderOne = mlfrontOrderList.get(0);
			String Slug = mlfrontOrderOne.getOrderLogisticsname();
			String Logisticsnumber = mlfrontOrderOne.getOrderLogisticsnumber();
			Tracking trackingRes = shipInformation.getTrackingByTrackingNumberAndSlug(Logisticsnumber,Slug);
			return Msg.success().add("trackingRes", trackingRes);
		}else{
			return Msg.fail().add("resMsg", "Please check your shipping order number");
		}
	}
	
	
	/**
	 * 5.0	zsh200804
	 * 点击按钮发送短信
	 * @param String PayInfoNumStr
	 * @return 
	 * */
	@RequestMapping(value="/toSendcheckoutRecoverSMS",method=RequestMethod.POST)
	@ResponseBody
	public Msg toSendcheckoutRecoverSMS(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlbackSearch mlbackSearch) {
			
		String startTime = mlbackSearch.getSearchCreatetime();
		String endTime = mlbackSearch.getSearchMotifytime();
		
		
		//查询接口,发送时间定时的几点,间隔几小时,发送文案
		
		MlbackSmstype mlbackSmstype = new MlbackSmstype();
		
		mlbackSmstype.setSmstypeName("sms");
		
		List<MlbackSmstype> mlbackSmstypeList = mlbackSmstypeService.selectMlbackSmstypeByName(mlbackSmstype);
		
		if(mlbackSmstypeList.size()>0){
			
			MlbackSmstype mlbackSmstypeOne = mlbackSmstypeList.get(0);
			
			Integer SmstypeStatus =  mlbackSmstypeOne.getSmstypeStatus();
			
			if(SmstypeStatus>0){
				String Content = mlbackSmstypeOne.getSmstypeContent();
				System.out.println("本短信的挽回语为:Content"+Content);
				
				//查询一下这个时间段的orderid没有结算的并且有结算地址的信息
				
				CheckRecover checkRecoverReq = new CheckRecover();
				checkRecoverReq.setStartTime(startTime);
				checkRecoverReq.setEndTime(endTime);
				
				List<CheckRecover> checkRecoverList = checkRecoverService.selectCheckRecoverOrderList(checkRecoverReq);
				
				if(checkRecoverList.size()>0){
					
					for(CheckRecover checkRecoverOne:checkRecoverList){
						Integer checkRecoverOrderId = checkRecoverOne.getOrderId();
						String telephone=checkRecoverOne.getOrderTelephone();
						String checkRecoverOrderIdStr = checkRecoverOrderId+"";
						System.out.println("本条order以挽回checkRecoverOrderIdStr："+checkRecoverOrderIdStr);
						
						String websiteStr = getNowWeb(rep,res,session);
						
						String SendStr = Content+"."+websiteStr+"checkoutRecover/"+checkRecoverOrderIdStr+".html";
						System.out.println("本单号位checkRecoverOrderIdStr："+checkRecoverOrderIdStr+",本条弃购链接为SendStr:"+SendStr);
						
						try {
							String SMSreturnData = SMSUtilshtml.sendSMS(SendStr,telephone);
							System.out.println(SendStr+",这一单发送成功功");
						} catch (Exception e) {
							e.printStackTrace();
							System.out.println(SendStr+",这一单系统异常,报错了");
						}
					}
					//该状态不生效,没有生效的
					return Msg.success().add("resMsg", "本时间段没有可以弃购挽回的订单信息");
					
				}else{
					//该状态不生效,没有生效的
					return Msg.fail().add("resMsg", "本时间段没有可以弃购挽回的订单信息");
				}
				
				
			}else{
				//该状态不生效,没有生效的
				return Msg.fail().add("resMsg", "没有生效的smstype命令");
			}
			
		}else{
			//没查到这个,返回
			return Msg.fail().add("resMsg", "没配置smstypeName对象");
		}
	}

	private String getNowWeb(HttpServletResponse rep, HttpServletRequest res, HttpSession session) {

		//当前服务器路径
		String basePathStr = URLLocationUtils.getbasePathStr(rep,res);
        System.out.println("basePathStr:"+basePathStr);
		return basePathStr;
	}
	
}
