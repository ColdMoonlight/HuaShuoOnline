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
import com.atguigu.bean.MlPaypalShipAddress;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlbackAreafreight;
import com.atguigu.bean.MlbackOrderStateEmail;
import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlPaypalShipAddressService;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackAreafreightService;
import com.atguigu.service.MlbackOrderStateEmailService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontUserService;
import com.atguigu.ship.Classes.ConnectionAPI;
import com.atguigu.ship.Classes.Tracking;
import com.atguigu.utils.EcppUpdateWebStatusUtil;
import com.atguigu.utils.EmailUtilshtml;
import com.atguigu.utils.EmailUtilshtmlCustomer;
import com.atguigu.utils.PropertiesUtil;
import com.atguigu.vo.AfterShipReturn;
import com.atguigu.vo.EcppTrackItem;

@Controller
@RequestMapping("/MlfrontPayInfo")
public class MlfrontPayInfoController {
	
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	MlfrontOrderService mlfrontOrderService;
	
	@Autowired
	MlfrontOrderItemService mlfrontOrderItemService;
	
	@Autowired
	MlfrontUserService mlfrontUserService;
	
	@Autowired
	MlbackAreafreightService mlbackAreafreightService;
	
	@Autowired
	MlfrontAddressService mlfrontAddressService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	@Autowired
	MlPaypalShipAddressService mlPaypalShipAddressService;
	
	@Autowired
	MlbackOrderStateEmailService mlbackOrderStateEmailService;
	
//	afterShip的真实物流url环境
	private final static String ConnectionAPIid = "7b04f01f-4f04-4b37-bbb9-5b159af73ee1";
	
	/**
	 * 1.0	UseNow	0505
	 * toPaySuccessPage列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toPaySuccessPage")
	public String toPaySuccessPage() throws Exception{
	
		return "portal/CartOrderPay/paySuccess";
	}
	
	/**
	 * 2.0	UseNow	0505
	 * toMlbackPayInfoList列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toMlbackPayInfoList")
	public String toMlbackPayInfoList() throws Exception{
		
		return "back/order/mlbackPayInfoPage";
	}
	
	/**3.0	useOn	0505
	 * 分类MlfrontPayInfo列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlfrontPayInfoByPage")
	@ResponseBody
	public Msg getMlfrontPayInfoByPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {
//		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("adminuser");
//		if(mlbackAdmin==null){
//			//SysUsers对象为空
//			return Msg.fail().add("resMsg", "session中adminuser对象为空");
//		}else{
			int PagNum = Const.PAGE_NUM_PAYINFO;
			PageHelper.startPage(pn, PagNum);
//			List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoAll();
			List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoSuccessAll();
			PageInfo page = new PageInfo(mlfrontPayInfoList, PagNum);
			return Msg.success().add("pageInfo", page);
//		}
	}
	
	/**
	 * 4.0	UseNow	0505
	 * toMlbackPayInfoDetailPage列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping(value="/toMlbackPayInfoDetailPage",method=RequestMethod.GET)
	public String toMlbackPayInfoDetailPage(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestParam(value = "payinfoId") Integer payinfoId) throws Exception{
	
		//接收传递进来的参数
		Integer payinfoIdReq = payinfoId;
		//放回响应域中
		res.setAttribute("payinfoId", payinfoIdReq);
		//放回session域中
		session.setAttribute("payinfoId", payinfoId);
		return "back/order/mlbackPayInfoDetailPage";
	}
	
	/**
	 * 5.0	zsh200716
	 * 支付成功页面获取相关展示信息
	 * @param MlfrontPayInfo
	 * @return 
	 */
	@RequestMapping(value="/successPageGetPaymentInfo",method=RequestMethod.POST)
	@ResponseBody
	public Msg successPageGetPaymentInfo(HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo){
		
		Integer payinfoId = mlfrontPayInfo.getPayinfoId();
		//接受payinfoId
		MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
		mlfrontPayInfoReq.setPayinfoId(payinfoId);
		//1.查询本条pay支付单
		List<MlfrontPayInfo> mlfrontPayInfoResList =mlfrontPayInfoService.selectMlfrontPayInfoById(mlfrontPayInfoReq);
		MlfrontPayInfo mlfrontPayInfoOne = new MlfrontPayInfo();
		if(mlfrontPayInfoResList.size()>0){
			mlfrontPayInfoOne =mlfrontPayInfoResList.get(0);
			//2.获取本条单子的orderId,2.1查询本条的order详情;2.2从详情中拿到addressid;2.3orderItemIDStr;2.4uid信息,历史购买次数;
			//2.1查询本条的order详情;
			Integer payinfoOid = mlfrontPayInfoOne.getPayinfoOid();
			MlfrontOrder mlfrontOrderPay = new MlfrontOrder();
			mlfrontOrderPay.setOrderId(payinfoOid);
			List<MlfrontOrder> mlfrontOrderPayResList= mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderPay);
			MlfrontOrder mlfrontOrderPayOneRes = mlfrontOrderPayResList.get(0);
			//2.2从详情中拿到addressid;
			Integer addressinfoId = mlfrontOrderPayOneRes.getOrderAddressinfoId();
			MlfrontAddress MlfrontAddressReq = new MlfrontAddress();
			MlfrontAddressReq.setAddressId(addressinfoId);
			List<MlfrontAddress> MlfrontAddressList = mlfrontAddressService.selectMlfrontAddressByParam(MlfrontAddressReq);
			MlfrontAddress mlfrontAddressOne = MlfrontAddressList.get(0);
			//2.2.1从地址中取出国家字段	addressCountry: "US"	addressCountryAll: "United States"
			//从地址中拿到国家的code
			String areafreightCountryCode = mlfrontAddressOne.getAddressCountryCode();
			//封装国家code
			MlbackAreafreight mlbackAreafreightReq = new MlbackAreafreight();
			mlbackAreafreightReq.setAreafreightCountryCode(areafreightCountryCode);
			//查询该国家的运费
			List<MlbackAreafreight> mlbackAreafreightResList =mlbackAreafreightService.selectMlbackAreafreightByParam(mlbackAreafreightReq);
			Integer areafreightMoney = 0;
			if(mlbackAreafreightResList.size()>0){
				areafreightMoney =mlbackAreafreightResList.get(0).getAreafreightPrice();	//拿到国家运费
			}
			//2.3从详情中拿到orderItemIDStr;
			String orderItemIdsStr = mlfrontOrderPayOneRes.getOrderOrderitemidstr();
			List<MlfrontOrderItem>  mlfrontOrderItemList = new ArrayList<MlfrontOrderItem>();
			MlfrontOrderItem mlfrontOrderItemOne = new MlfrontOrderItem();
			MlfrontOrderItem mlfrontOrderItemOneReq = new MlfrontOrderItem();
			String orderItemIdStrArr [] = orderItemIdsStr.split(",");
			String orderItemIdStr = "";
			Integer orderItemIdInt = 0;
			for(int i =0;i<orderItemIdStrArr.length;i++){
				orderItemIdStr = orderItemIdStrArr[i];
				orderItemIdInt = Integer.parseInt(orderItemIdStr);
				mlfrontOrderItemOneReq.setOrderitemId(orderItemIdInt);
				List<MlfrontOrderItem> mlfrontOrderItemResList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemOneReq);
				mlfrontOrderItemOne = mlfrontOrderItemResList.get(0);
				mlfrontOrderItemList.add(mlfrontOrderItemOne);
			}
			//2.4uid信息
			Integer uid = mlfrontOrderPayOneRes.getOrderUid();
			MlfrontUser mlfrontUserOne = new MlfrontUser();
			if(uid==null){
				mlfrontUserOne = null;
			}else{
				MlfrontUser mlfrontUserReq = new MlfrontUser();
				mlfrontUserReq.setUserId(uid);
				List<MlfrontUser> mlfrontUserList = mlfrontUserService.selectMlfrontUserByConditionS(mlfrontUserReq);
				mlfrontUserOne = mlfrontUserList.get(0);
			}
			//3.获取本payinfoid的paypal_shippingaddress地址;
			MlPaypalShipAddress mlPaypalShipAddressReq = new MlPaypalShipAddress();
			String shippingaddressPayinfoid=payinfoId+"";
			mlPaypalShipAddressReq.setShippingaddressPayinfoid(shippingaddressPayinfoid);
			List<MlPaypalShipAddress> mlPaypalShipAddressResList =mlPaypalShipAddressService.selectMlPaypalShipAddressByPayinfoid(mlPaypalShipAddressReq);
			MlPaypalShipAddress mlPaypalShipAddressRes = new MlPaypalShipAddress();
			if(mlPaypalShipAddressResList.size()==0){
				System.out.println("xx调用了getOneMlfrontPayInfoDetail接口,paypal那边返回的地址为null,没有payment的返回地址");
			}else{
				mlPaypalShipAddressRes = mlPaypalShipAddressResList.get(0);
			}
			//完毕回传
			return Msg.success().add("resMsg", "查看单条mlfrontPayInfoOne的详情细节完毕")
						.add("mlfrontPayInfoOne", mlfrontPayInfoOne).add("mlfrontOrderPayOneRes", mlfrontOrderPayOneRes)
						.add("mlfrontAddressOne", mlfrontAddressOne).add("mlfrontOrderItemList", mlfrontOrderItemList)
						.add("mlfrontUserOne", mlfrontUserOne).add("mlPaypalShipAddressOne", mlPaypalShipAddressRes).add("areafreightMoney", areafreightMoney);
		}else{
			mlfrontPayInfoOne = null;
			//账户异常
			return Msg.success().add("resMsg", "查看单条mlfrontPayInfoOne的详情细节完毕").add("mlfrontPayInfoOne", mlfrontPayInfoOne);
		}
	}
	
	/**
	 * 6.0	zsh200815
	 * 后台单条明细页面获取展示信息
	 * @param MlfrontPayInfo
	 * @return 
	 */
	@RequestMapping(value="/backGetOnePayInfoDetail",method=RequestMethod.POST)
	@ResponseBody
	public Msg backGetOnePayInfoDetail(HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo){
		//接受payinfoId
		Integer payinfoId = mlfrontPayInfo.getPayinfoId();
		//准备req
		MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
		mlfrontPayInfoReq.setPayinfoId(payinfoId);
		//1.查询本条pay支付单
		List<MlfrontPayInfo> mlfrontPayInfoResList =mlfrontPayInfoService.selectMlfrontPayInfoById(mlfrontPayInfoReq);
		MlfrontPayInfo mlfrontPayInfoOne = new MlfrontPayInfo();
		if(mlfrontPayInfoResList.size()>0){
			mlfrontPayInfoOne =mlfrontPayInfoResList.get(0);
		}else{
			mlfrontPayInfoOne = null;
		}
		//2.获取本条单子的orderId,2.1查询本条的order详情;2.2从详情中拿到addressid;2.3orderItemIDStr;2.4uid信息,历史购买次数;
		//2.1查询本条的order详情;
		Integer payinfoOid = mlfrontPayInfoOne.getPayinfoOid();
		MlfrontOrder mlfrontOrderPay = new MlfrontOrder();
		mlfrontOrderPay.setOrderId(payinfoOid);
		List<MlfrontOrder> mlfrontOrderPayResList= mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderPay);
		MlfrontOrder mlfrontOrderPayOneRes = mlfrontOrderPayResList.get(0);
		//2.2从详情中拿到addressid;
		Integer addressinfoId = mlfrontOrderPayOneRes.getOrderAddressinfoId();
		MlfrontAddress MlfrontAddressReq = new MlfrontAddress();
		MlfrontAddressReq.setAddressId(addressinfoId);
//		List<MlfrontAddress> MlfrontAddressList = mlfrontAddressService.selectMlfrontAddressById(MlfrontAddressReq);
		List<MlfrontAddress> MlfrontAddressList = mlfrontAddressService.selectMlfrontAddressByParam(MlfrontAddressReq);
		MlfrontAddress mlfrontAddressOne = MlfrontAddressList.get(0);
		//2.2.1从地址中取出国家字段	addressCountry: "US"	addressCountryAll: "United States"
		//拿到国家的code
		String areafreightCountryCode = mlfrontAddressOne.getAddressCountryCode();
		//封装国家code
		MlbackAreafreight mlbackAreafreightReq = new MlbackAreafreight();
		mlbackAreafreightReq.setAreafreightCountryCode(areafreightCountryCode);
		//查询该国家的全称
//		List<MlbackAreafreight> mlbackAreafreightResList =mlbackAreafreightService.selectMlbackAreafreightByEng(mlbackAreafreightReq);
		List<MlbackAreafreight> mlbackAreafreightResList =mlbackAreafreightService.selectMlbackAreafreightByParam(mlbackAreafreightReq);
		Integer areafreightMoney = 0;
		if(mlbackAreafreightResList.size()>0){
			areafreightMoney =mlbackAreafreightResList.get(0).getAreafreightPrice();	//拿到国家运费
		}
		//2.3从详情中拿到orderItemIDStr;
		String orderItemIdsStr = mlfrontOrderPayOneRes.getOrderOrderitemidstr();
		List<MlfrontOrderItem>  mlfrontOrderItemList = new ArrayList<MlfrontOrderItem>();
		MlfrontOrderItem mlfrontOrderItemOne = new MlfrontOrderItem();
		MlfrontOrderItem mlfrontOrderItemOneReq = new MlfrontOrderItem();
		String orderItemIdStrArr [] = orderItemIdsStr.split(",");
		String orderItemIdStr = "";
		Integer orderItemIdInt = 0;
		for(int i =0;i<orderItemIdStrArr.length;i++){
			orderItemIdStr = orderItemIdStrArr[i];
			orderItemIdInt = Integer.parseInt(orderItemIdStr);
			mlfrontOrderItemOneReq.setOrderitemId(orderItemIdInt);
			List<MlfrontOrderItem> mlfrontOrderItemResList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemOneReq);
			mlfrontOrderItemOne = mlfrontOrderItemResList.get(0);
			mlfrontOrderItemList.add(mlfrontOrderItemOne);
		}
		//2.4uid信息
		Integer uid = mlfrontOrderPayOneRes.getOrderUid();
		MlfrontUser mlfrontUserOne = new MlfrontUser();
		if(uid==null){
			mlfrontUserOne = null;
		}else{
			MlfrontUser mlfrontUserReq = new MlfrontUser();
			mlfrontUserReq.setUserId(uid);
			List<MlfrontUser> mlfrontUserList = mlfrontUserService.selectMlfrontUserByConditionS(mlfrontUserReq);
			mlfrontUserOne = mlfrontUserList.get(0);
		}
		//3.获取本payinfoid的paypal_shippingaddress地址;
		MlPaypalShipAddress mlPaypalShipAddressReq = new MlPaypalShipAddress();
		String shippingaddressPayinfoid=payinfoId+"";
		mlPaypalShipAddressReq.setShippingaddressPayinfoid(shippingaddressPayinfoid);
		List<MlPaypalShipAddress> mlPaypalShipAddressResList =mlPaypalShipAddressService.selectMlPaypalShipAddressByPayinfoid(mlPaypalShipAddressReq);
		MlPaypalShipAddress mlPaypalShipAddressRes = new MlPaypalShipAddress();
		if(mlPaypalShipAddressResList.size()==0){
			System.out.println("后台点进单条查看支付单子明细backGetOnePayInfoDetail接口,paypal那边返回的地址为null,没有payment的返回地址");
		}else{
			mlPaypalShipAddressRes = mlPaypalShipAddressResList.get(0);
		}
		//完毕回传
		return Msg.success().add("resMsg", "查看单条mlfrontPayInfoOne的详情细节完毕")
					.add("mlfrontPayInfoOne", mlfrontPayInfoOne).add("mlfrontOrderPayOneRes", mlfrontOrderPayOneRes)
					.add("mlfrontAddressOne", mlfrontAddressOne).add("mlfrontOrderItemList", mlfrontOrderItemList)
					.add("mlfrontUserOne", mlfrontUserOne).add("mlPaypalShipAddressOne", mlPaypalShipAddressRes).add("areafreightMoney", areafreightMoney);
	}
	
	/**7.0	zsh200720
	 * 检查已支付的单子,是否在ecpp上已经审核
	 * 1,收到前台的查询时间范围,后台查询这些时间内的已支付订单,
	 * 2,便利这些单子,用token+H号,去查询本条的状态,
	 * 3.1如果是审核完毕,就在我方系统中,将本条改成已经审核的状态
	 * 3.2如果是已发货,就在我方系统中,将本单改成已经已发货的状态;并且把哪家物流的名字+track_no,同步回我方后台
	 * @param "payinfoCreatetime": "2020-07-21 08:20:06",
     * 		  "payinfoMotifytime": "2020-07-21 08:50:06"
	 */
//	@RequestMapping(value="/checkEcppIfVerify",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg checkEcppIfVerify(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo){
//		
//			String startTime = mlfrontPayInfo.getPayinfoCreatetime();
//			String endTime = mlfrontPayInfo.getPayinfoMotifytime();
//			
//			MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
//			mlfrontPayInfoReq.setPayinfoCreatetime(startTime);
//			mlfrontPayInfoReq.setPayinfoMotifytime(endTime);
//			mlfrontPayInfoReq.setPayinfoStatus(1);//只查询已支付的状态
//			
//			List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoByDateAndStatus(mlfrontPayInfoReq);
//			
//			if(mlfrontPayInfoList.size()>0){
//				//如果有已支付状态的文件
//				for(MlfrontPayInfo mlfrontPayInfoOne:mlfrontPayInfoList){
//					Integer payInfoId = mlfrontPayInfoOne.getPayinfoId();
//					Integer orderId = mlfrontPayInfoOne.getPayinfoOid();
//					
//					//取出mlfrontPayInfoOne中的Ecpphsnum中的信息
//					String ecppHSnum = mlfrontPayInfoOne.getPayinfoEcpphsnum();
//					String order_sn = ecppHSnum;
//					String token = (String) PropertiesUtil.getProperty("megalook.properties", "ecppToken");
//					
//					String soapXML = EcppUpdateWebStatusUtil.getXML(token,order_sn);
//					
//					MlfrontPayInfo mlfrontPayInfoUpdate = new MlfrontPayInfo();
//					
//					try {
//						EcppTrackItem ecppTrackItem = EcppUpdateWebStatusUtil.send(token,soapXML);
//						String ecppOrderStatusCode = ecppTrackItem.getEcppOrderStatusCode();
//						MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
//	            		mlfrontOrderReq.setOrderId(orderId);
//	            		
//						if("OOO".equals(ecppOrderStatusCode)){
//							//131-OOO-订单核对完成(已发货)
//							//更新成-发货-状态
//							mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
//	                		mlfrontPayInfoUpdate.setPayinfoStatus(3);//payinfo状态为3,已发货
//	                		mlfrontPayInfoUpdate.setPayinfoSendnum(ecppTrackItem.getEcppOrderTrackNo());
//	                		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
//	                		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
//	                		
//	                		//查询本条的order信息,更新物流单号+物流名称
//	                		mlfrontOrderReq.setOrderLogisticsname(ecppTrackItem.getShippingName());
//	                		mlfrontOrderReq.setOrderLogisticsnumber(ecppTrackItem.getEcppOrderTrackNo());
//	                		mlfrontOrderReq.setOrderStatus(4);//orderStatus == 4已发货,待接收
//	                		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
//	                		
//	                		String orderLogisticsname = ecppTrackItem.getShippingName();
//	                		String orderLogisticsnumber = ecppTrackItem.getEcppOrderTrackNo();
//	                		String payinfoPlateNum = mlfrontPayInfoOne.getPayinfoPlatenum();
//	                		
//	                		//10.1向afterShip官方发送物流添加按钮
//	                		try {
//	                			//向物流中插入物流单号,订单号(Item,价格),传递orderId,即可全部走查询
//	                			AfterShipReturn afterShipReturn = new AfterShipReturn();
//	                			afterShipReturn = addTrackingNumberIntoAfterShip(orderId,payinfoPlateNum,orderLogisticsnumber);
//	                			String afterOperateStatus = afterShipReturn.getAfterOperateStatus();
//	                			
//	                			if("1".equals(afterOperateStatus)){
//	                				//往aftership中插入成功
//	                				System.out.println("平台号为"+payinfoPlateNum+"的成交单,物流号插入AfterShip成功,返回的物流名为:"+afterShipReturn.getAfterShipSlugName());
//	                				orderLogisticsname  = afterShipReturn.getAfterShipSlugName();
//	                				//更新order表中本条成最终的物流信息的物流名称
//	                				MlfrontOrder mlfrontOrderAfterReq = new MlfrontOrder();
//	                				mlfrontOrderAfterReq.setOrderId(orderId);
//	                				mlfrontOrderAfterReq.setOrderLogisticsname(orderLogisticsname);
//	                				mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderAfterReq);
//	                			}else{
//	                				//往aftership没有插入成功
//	                				System.out.println("平台号为"+payinfoPlateNum+"的成交单,物流号插入AfterShip失败");
//	                			}
//	                		} catch (Exception e) {
//	                			e.printStackTrace();
//	                			System.out.println("aftership中插入物流单号--有异常");
//	                			System.out.println(e.getMessage());
//	                		}
//						}else if("UOO".equals(ecppOrderStatusCode)){
//							//113-UOO-客服审核完成的状态,就更新成审核完毕的状态
//							mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
//	                		mlfrontPayInfoUpdate.setPayinfoStatus(2);//payinfo状态为2,已审单//orderStatus == 3已审单,待发货
//	                		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
//	                		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
//	                		
//	                		mlfrontOrderReq.setOrderStatus(3);//orderStatus == 3已审单,待发货//
//	                		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
//						}else if("DEL".equals(ecppOrderStatusCode)){
//							//124-DEL-客户退件了,这是ecpp取消发货后的状态,就更新成取消发货的状态
//							mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
//	                		mlfrontPayInfoUpdate.setPayinfoStatus(4);//payinfoStatus=2已审单//payinfoStatus=3已发货//4已退款
//	                		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
//	                		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
//	                		
//	                		mlfrontOrderReq.setOrderStatus(5);//orderStatus == 5已退款//
//	                		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
//						}else{
//							mlfrontPayInfoUpdate.setPayinfoId(payInfoId);//不改状态,只赋值
//							mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
//							mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
//						}
//					} catch (Exception e) {
//						e.printStackTrace();
//					}
//					
//				}
//				return Msg.success().add("resMsg", "本次刷新有修改,请注意观察payInfo列表变化");
//			}else{
//				//查询结果为空
//				//当前没有状态为已支付的数据
//				return Msg.success().add("resMsg", "本次刷新没有状态是已支付的单子,无改变");
//			}
//	}
	
	/**7.0	zsh200720
	 * 检查已支付的单子,是否在ecpp上已经审核
	 * 1,收到前台的查询时间范围,后台查询这些时间内的已支付订单,
	 * 2,便利这些单子,用token+H号,去查询本条的状态,
	 * 3.1如果是审核完毕,就在我方系统中,将本条改成已经审核的状态
	 * 3.2如果是已发货,就在我方系统中,将本单改成已经已发货的状态;并且把哪家物流的名字+track_no,同步回我方后台
	 * @param Integer payInfoId,Integer orderId,String ecppHSnum,Integer orderId,
	 */
	@RequestMapping(value="/checkEcppOneIfVerify",method=RequestMethod.POST)
	@ResponseBody
	public Msg checkEcppOneIfVerify(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo){
		
		Integer payInfoId = mlfrontPayInfo.getPayinfoId();
		Integer orderId = mlfrontPayInfo.getPayinfoOid();
		String payinfoPlateNumInto = mlfrontPayInfo.getPayinfoPlatenum();
		String payinfoUemailInto = mlfrontPayInfo.getPayinfoUemail();
		
		//取出mlfrontPayInfoOne中的Ecpphsnum中的信息
		String ecppHSnum = mlfrontPayInfo.getPayinfoEcpphsnum();
		String order_sn = ecppHSnum;
		String token = (String) PropertiesUtil.getProperty("megalook.properties", "ecppToken");
		
		String soapXML = EcppUpdateWebStatusUtil.getXML(token,order_sn);
		
		MlfrontPayInfo mlfrontPayInfoUpdate = new MlfrontPayInfo();
		
		try {
			EcppTrackItem ecppTrackItem = EcppUpdateWebStatusUtil.send(token,soapXML);
			String ecppOrderStatusCode = ecppTrackItem.getEcppOrderStatusCode();
			MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
    		mlfrontOrderReq.setOrderId(orderId);
    		
			if("OOO".equals(ecppOrderStatusCode)){
				//131-OOO-订单核对完成(已发货)
				//更新成-发货-状态
				mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
        		mlfrontPayInfoUpdate.setPayinfoStatus(3);//payinfo状态为3,已发货
        		mlfrontPayInfoUpdate.setPayinfoSendnum(ecppTrackItem.getEcppOrderTrackNo());
        		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
        		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
        		
        		//查询本条的order信息,更新物流单号+物流名称
        		mlfrontOrderReq.setOrderLogisticsname(ecppTrackItem.getShippingName());
        		mlfrontOrderReq.setOrderLogisticsnumber(ecppTrackItem.getEcppOrderTrackNo());
        		mlfrontOrderReq.setOrderStatus(4);//orderStatus == 4已发货,待接收
        		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
        		
        		String orderLogisticsname = ecppTrackItem.getShippingName();
        		String orderLogisticsnumber = ecppTrackItem.getEcppOrderTrackNo();
        		String payinfoPlateNum = mlfrontPayInfo.getPayinfoPlatenum();
        		
        		//10.1向afterShip官方发送物流添加按钮
        		try {
        			//向物流中插入物流单号,订单号(Item,价格),传递orderId,即可全部走查询
        			AfterShipReturn afterShipReturn = new AfterShipReturn();
        			afterShipReturn = addTrackingNumberIntoAfterShip(orderId,payinfoPlateNum,orderLogisticsnumber);
        			String afterOperateStatus = afterShipReturn.getAfterOperateStatus();
        			
        			if("1".equals(afterOperateStatus)){
        				//往aftership中插入成功
        				System.out.println("平台号为"+payinfoPlateNum+"的成交单,物流号插入AfterShip成功,返回的物流名为:"+afterShipReturn.getAfterShipSlugName());
        				orderLogisticsname  = afterShipReturn.getAfterShipSlugName();
        				//更新order表中本条成最终的物流信息的物流名称
        				MlfrontOrder mlfrontOrderAfterReq = new MlfrontOrder();
        				mlfrontOrderAfterReq.setOrderId(orderId);
        				mlfrontOrderAfterReq.setOrderLogisticsname(orderLogisticsname);
        				mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderAfterReq);
        			}else{
        				//往aftership没有插入成功
        				System.out.println("平台号为"+payinfoPlateNum+"的成交单,物流号插入AfterShip失败");
        			}
        		} catch (Exception e) {
        			e.printStackTrace();
        			System.out.println("aftership中插入物流单号--有异常");
        			System.out.println(e.getMessage());
        		}
			}else if("UOO".equals(ecppOrderStatusCode)){
				//113-UOO-客服审核完成的状态,就更新成审核完毕的状态
				mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
        		mlfrontPayInfoUpdate.setPayinfoStatus(2);//payinfo状态为2,已审单//orderStatus == 3已审单,待发货
        		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
        		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
        		
        		mlfrontOrderReq.setOrderStatus(3);//orderStatus == 3已审单,待发货//
        		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
        		//发审核完毕的邮件通知客户
        		sendVerfirtEmail(payinfoPlateNumInto,payinfoUemailInto);
			}else if("POO".equals(ecppOrderStatusCode)){
				//114-POO-客服审核完成的状态,就更新成审核完毕的状态
				mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
        		mlfrontPayInfoUpdate.setPayinfoStatus(2);//payinfo状态为2,已审单//orderStatus == 3已审单,待发货
        		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
        		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
        		
        		mlfrontOrderReq.setOrderStatus(3);//orderStatus == 3已审单,待发货//
        		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
        		//发审核完毕的邮件通知客户
        		sendVerfirtEmail(payinfoPlateNumInto,payinfoUemailInto);
			}else if("PPP".equals(ecppOrderStatusCode)){
				//129-PPP-客服审核完成的状态,就更新成审核完毕的状态
				mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
        		mlfrontPayInfoUpdate.setPayinfoStatus(2);//payinfo状态为2,已审单//orderStatus == 3已审单,待发货
        		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
        		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
        		
        		mlfrontOrderReq.setOrderStatus(3);//orderStatus == 3已审单,待发货//
        		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
        		//发审核完毕的邮件通知客户
        		sendVerfirtEmail(payinfoPlateNumInto,payinfoUemailInto);
			}else if("DEL".equals(ecppOrderStatusCode)){
				//124-DEL-客户退件了,这是ecpp取消发货后的状态,就更新成取消发货的状态
				mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
        		mlfrontPayInfoUpdate.setPayinfoStatus(4);//payinfoStatus=2已审单//payinfoStatus=3已发货//4已退款
        		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
        		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
        		
        		mlfrontOrderReq.setOrderStatus(5);//orderStatus == 5已退款//
        		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
			}else{
				mlfrontPayInfoUpdate.setPayinfoId(payInfoId);//不改状态,只赋值
				mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
				mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Msg.success().add("resMsg", "本次刷新有修改,请注意观察payInfo列表变化");
	}

	private void sendVerfirtEmail(String payinfoPlateNum,String userEmail) {
		String toCustomerVerifyInfoStr = "";
		//查询
		MlbackOrderStateEmail mlbackOrderStateEmailReq = new MlbackOrderStateEmail();
		mlbackOrderStateEmailReq.setOrderstateemailName("Verifyed");
		//查询本条
		List<MlbackOrderStateEmail> mlbackOrderStateEmailList =mlbackOrderStateEmailService.selectMlbackOrderStateEmailByName(mlbackOrderStateEmailReq);
		if(mlbackOrderStateEmailList.size()>0){
			
			MlbackOrderStateEmail mlbackOrderStateEmailOne =mlbackOrderStateEmailList.get(0);
			
			toCustomerVerifyInfoStr = getToCustomerVerifyEmailManage(mlbackOrderStateEmailOne,payinfoPlateNum);
		}else{
			
			toCustomerVerifyInfoStr = getToCustomerVerifyEmail(payinfoPlateNum);
		}
		//提醒客户准备发货
		try {
			String getToEmail = userEmail;
			EmailUtilshtml.readyEmailVerifySuccess(getToEmail, toCustomerVerifyInfoStr,payinfoPlateNum);
			EmailUtilshtmlCustomer.readyEmailVerifyCustomer(getToEmail, toCustomerVerifyInfoStr,payinfoPlateNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private String getToCustomerVerifyEmailManage(MlbackOrderStateEmail mlbackOrderStateEmailOne,String payinfoPlateNum) {
		
		String emailOneStr =  mlbackOrderStateEmailOne.getOrderstateemailOne();
		String emailTwoStr =  mlbackOrderStateEmailOne.getOrderstateemailTwo();
		String emailThreeStr =  mlbackOrderStateEmailOne.getOrderstateemailThree();
		String emailFourStr =  mlbackOrderStateEmailOne.getOrderstateemailFour();
		String emailFiveStr =  mlbackOrderStateEmailOne.getOrderstateemailFive();
		String Message ="";
		Message =Message+"Hi gorgeous girl ,"+"<br><br>";
		Message=Message+emailOneStr+" # ("+payinfoPlateNum+") "+emailTwoStr+"<br><br>";
		Message=Message+emailThreeStr+"<br><br>";
		Message=Message+emailFourStr+"<br><br>";
		if("".equals(emailFiveStr)){
			System.out.println("emailFiveStr:"+emailFiveStr+"这句话为空");
		}else{
			Message=Message+emailFiveStr+"<br><br>";
		}
		Message=Message+"Best Regards,<br>";
		Message=Message+"-----------------------------------<br>";
		String team = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.team");
		String email = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.email");
		String whatsapp = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.whatsapp");
		String Telephone = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.Telephone");
		//读取配置文件
		Message=Message+team+"<br>";
		Message=Message+"Email:"+email+"<br>";
		Message=Message+"Whatsapp:"+whatsapp+"<br>";
		Message=Message+"Telephone/SMS:"+Telephone+"<br>";
		return Message;
	}
	
	//ToCustomerVerifyEmail
	private String getToCustomerVerifyEmail(String payinfoPlateNum) {
		String Message ="";
		Message =Message+"Hi gorgeous girl ,"+"<br><br>";
		Message=Message+"This is Megalook Hair  <br>. ";
		Message=Message+"We have received your order # ("+payinfoPlateNum+")  and confirmed your payment. <br><br><br>";
		Message=Message+"The hair you ordered is in stock and is expected to be shipped within 24-48 hours .<br><br>";
		Message=Message+"We will send the parcel tracking number to you through email & SMS after delivery, and you can also view it on the PayPal bill.<br><br><br>";
		Message=Message+"Please don't hesitate to call me if you need help. We still here behind Megalook Hair.<br><br>";
		Message=Message+"Best Regards,<br>";
		Message=Message+"-----------------------------------<br>";
		String team = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.team");
		String email = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.email");
		String whatsapp = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.whatsapp");
		String Telephone = (String) PropertiesUtil.getProperty("megalook.properties", "delvery.Telephone");
		//读取配置文件
		Message=Message+team+"<br>";
		Message=Message+"Email:"+email+"<br>";
		Message=Message+"Whatsapp:"+whatsapp+"<br>";
		Message=Message+"Telephone/SMS:"+Telephone+"<br>";
		return Message;
	}

	/**8.0	zsh200722
	 * 检查已审核的单子,是否在ecpp上已经发货
	 * 1,收到前台的查询时间范围,后台查询这些时间内的已审核订单,
	 * 2,便利这些单子,用token+H号,去查询本条的状态,
	 * 3,如果是已发货,就在我方系统中,将本单改成已经已发货的状态;并且把哪家物流的名字+track_no,同步回我方后台
	 * @param "payinfoCreatetime": "2020-07-21 08:20:06",
     * 		  "payinfoMotifytime": "2020-07-21 08:50:06"
	 */
	@RequestMapping(value="/checkEcppIfSend",method=RequestMethod.POST)
	@ResponseBody
	public Msg checkEcppIfSend(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo){
		
//		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("adminuser");
//		if(mlbackAdmin==null){
//			//SysUsers对象为空
//			return Msg.fail().add("resMsg", "请重新登陆");
//		}else{
			String startTime = mlfrontPayInfo.getPayinfoCreatetime();
			String endTime = mlfrontPayInfo.getPayinfoMotifytime();
			
			MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
			mlfrontPayInfoReq.setPayinfoCreatetime(startTime);
			mlfrontPayInfoReq.setPayinfoMotifytime(endTime);
			mlfrontPayInfoReq.setPayinfoStatus(2);//只查询已审单的状态
			
			List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoByDateAndStatus(mlfrontPayInfoReq);
			
			if(mlfrontPayInfoList.size()>0){
				//如果有已支付状态的文件
				for(MlfrontPayInfo mlfrontPayInfoOne:mlfrontPayInfoList){
					Integer payInfoId = mlfrontPayInfoOne.getPayinfoId();
					Integer orderId = mlfrontPayInfoOne.getPayinfoOid();
					
					//取出mlfrontPayInfoOne中的Ecpphsnum中的信息
					String ecppHSnum = mlfrontPayInfoOne.getPayinfoEcpphsnum();
					String order_sn = ecppHSnum;
					String token = (String) PropertiesUtil.getProperty("megalook.properties", "ecppToken");
					
					String soapXML = EcppUpdateWebStatusUtil.getXML(token,order_sn);
					
					MlfrontPayInfo mlfrontPayInfoUpdate = new MlfrontPayInfo();
					
					try {
						EcppTrackItem ecppTrackItem = EcppUpdateWebStatusUtil.send(token,soapXML);
						String ecppOrderStatusCode = ecppTrackItem.getEcppOrderStatusCode();
						MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
	            		mlfrontOrderReq.setOrderId(orderId);
						if("OOO".equals(ecppOrderStatusCode)){
							//131-OOO-订单核对完成(已发货)
							//更新成-发货-状态
							mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
	                		mlfrontPayInfoUpdate.setPayinfoStatus(3);//payinfo状态为3,已发货
	                		mlfrontPayInfoUpdate.setPayinfoSendnum(ecppTrackItem.getEcppOrderTrackNo());
	                		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
	                		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
	                		
	                		//查询本条的order信息,更新物流单号+物流名称
	                		mlfrontOrderReq.setOrderLogisticsname(ecppTrackItem.getShippingName());
	                		mlfrontOrderReq.setOrderLogisticsnumber(ecppTrackItem.getEcppOrderTrackNo());
	                		mlfrontOrderReq.setOrderStatus(4);//orderStatus == 4已发货,待接收
	                		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
	                		
	                		String orderLogisticsname = ecppTrackItem.getShippingName();
	                		String orderLogisticsnumber = ecppTrackItem.getEcppOrderTrackNo();
	                		String payinfoPlateNum = mlfrontPayInfoOne.getPayinfoPlatenum();
	                		
	                		//10.1向afterShip官方发送物流添加按钮
	                		try {
	                			//向物流中插入物流单号,订单号,orderId,即可全部走查询(Item,价格)
	                			AfterShipReturn afterShipReturn = new AfterShipReturn();
	                			afterShipReturn = addTrackingNumberIntoAfterShip(orderId,payinfoPlateNum,orderLogisticsnumber);
	                			String afterOperateStatus = afterShipReturn.getAfterOperateStatus();
	                			
	                			if("1".equals(afterOperateStatus)){
	                				//插入成功
	                				System.out.println("平台号为"+payinfoPlateNum+"的成交单,物流号插入AfterShip成功,返回的物流名为:"+afterShipReturn.getAfterShipSlugName());
	                				orderLogisticsname  = afterShipReturn.getAfterShipSlugName();
	                				//更新order表中本条成最终的物流信息的物流名称
	                				MlfrontOrder mlfrontOrderAfterReq = new MlfrontOrder();
	                				mlfrontOrderAfterReq.setOrderId(orderId);
	                				mlfrontOrderAfterReq.setOrderLogisticsname(orderLogisticsname);
	                				mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderAfterReq);
	                			}else{
	                				//没有插入成功
	                				System.out.println("平台号为"+payinfoPlateNum+"的成交单,物流号插入AfterShip失败");
	                			}
	                		} catch (Exception e) {
	                			e.printStackTrace();
	                			System.out.println("物流中插入物流单号--有异常");
	                			System.out.println(e.getMessage());
	                		}
						}else{
							mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
							mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);//不改状态,只赋值
							mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				return Msg.success().add("resMsg", "本次刷新有修改,请注意观察payInfo列表变化");
			}else{
				//查询结果为空
				//当前没有状态为已支付的数据
				return Msg.success().add("resMsg", "本次刷新没有状态是已支付的单子,无改变");
			}
//		}
	}
	
	/**
	 * 向afterShip官方发送物流单号
	 * */
	private AfterShipReturn addTrackingNumberIntoAfterShip(Integer orderId,String payinfoPlateNum,String trackingNumber) {
		
		AfterShipReturn afterShipReturn = new AfterShipReturn();
		afterShipReturn.setAfterOperateStatus("0");
		
		String connectionAPIStr = ConnectionAPIid;
		ConnectionAPI connection = new ConnectionAPI(connectionAPIStr);
		
		//First we have to create a Tracking
		Tracking tracking = new Tracking(trackingNumber);
		//Then we can add information;
		tracking.setTitle(payinfoPlateNum);//订单号
		tracking.setOrderID(payinfoPlateNum);//Ecpp的订单号
		
		//公共方法
		MlfrontOrder orderOne = getOrderDetailByOrderId(orderId);
		
		Integer addressId = orderOne.getOrderAddressinfoId();
		
		MlfrontAddress addressOne = getAddressDetailByAddressId(addressId);
		
		String userfirstname = addressOne.getAddressUserfirstname();
		String userlastname = addressOne.getAddressUserlastname();		
		String addressEmail = addressOne.getAddressEmail();
		String addressTelephone = addressOne.getAddressTelephone();
		
//		tracking.setCustomerName("shaohua");
//		tracking.addEmails("mingyueqingl@163.com");
//		tracking.addSmses("+8617600209637");
		
		String uname = userfirstname+" "+userlastname;
		System.out.println("uname:"+uname);
		System.out.println("addressEmail:"+addressEmail);
		System.out.println("addressTelephone:"+addressTelephone);
		tracking.setCustomerName(uname);
		tracking.addEmails(addressEmail);
		tracking.addSmses(addressTelephone);

		String orderitemidstr = orderOne.getOrderOrderitemidstr();
		String orderItemArr[] =orderitemidstr.split(",");
		String proStr = "";
		String proOneDetailStr = "";
		//1.1如果有多个删除字段中的该项
		for(int i =0;i<orderItemArr.length;i++){
			String orderItemId = orderItemArr[i];
			
			MlfrontOrderItem orderItemOne = getOrderItemDetailByOrderItemId(orderItemId);
			String proName = orderItemOne.getOrderitemPseo();
			Integer orderItemNum = orderItemOne.getOrderitemPskuNumber();
			String orderItemNumStr = orderItemNum+"";
			String proSkuName = orderItemOne.getOrderitemPskuName();
			
			proOneDetailStr= ""+orderItemNumStr+" x "+proName+"("+proSkuName+")"+".";
			proStr+=proOneDetailStr;
		}
		
		//Even add customer fields
		tracking.addCustomFields("product_Items",proStr);

		//Finally we add the tracking to our account
		Tracking trackingPosted;
		String afterShipNameSlug = "0";//初始化填入afterShip后运单号,返回的物流名称,异常话是1,无异常的话,是真实的ShipName
		try {
			trackingPosted = connection.postTracking(tracking);

			System.out.println("trackingPosted.getTrackingNumber()------------------------");
			System.out.println(trackingPosted.getTrackingNumber());
			
			trackingPosted.getExpectedDelivery();
			trackingPosted.generateJSON();
			afterShipNameSlug = trackingPosted.getSlug();
			
			afterShipReturn.setAfterOperateStatus("1");
			afterShipReturn.setAfterShipSlugName(afterShipNameSlug);
			
			System.out.println("trackingPosted.getSlug()------------------------");
			System.out.println(trackingPosted.getSlug());
			return afterShipReturn;
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getMessage());
			return afterShipReturn;
		}
	}
	
	//获取orderItem的明细
	private MlfrontOrderItem getOrderItemDetailByOrderItemId(String orderItemIdStr) {
		
		Integer orderItemId = Integer.parseInt(orderItemIdStr);
		MlfrontOrderItem mlfrontOrderItemReq = new MlfrontOrderItem();
		mlfrontOrderItemReq.setOrderitemId(orderItemId);
		List<MlfrontOrderItem> mlfrontOrderItemList  = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemReq);
		MlfrontOrderItem mlfrontOrderItemRes = mlfrontOrderItemList.get(0);
		return mlfrontOrderItemRes;
	}

	//公共方法,用orderId查询OrderDetail
	private MlfrontOrder getOrderDetailByOrderId(Integer orderId) {
		MlfrontOrder mlfrontOrderReq = new MlfrontOrder();
		mlfrontOrderReq.setOrderId(orderId);
		List<MlfrontOrder> mlfrontOrderListRes  = mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderReq);
		MlfrontOrder mlfrontOrderRes = mlfrontOrderListRes.get(0);
		return mlfrontOrderRes;
	}
	//公共方法,用addressId查询AddressDetail
	private MlfrontAddress getAddressDetailByAddressId(Integer addressId) {
		MlfrontAddress mlfrontAddressReq = new MlfrontAddress();
		mlfrontAddressReq.setAddressId(addressId);
		List<MlfrontAddress> mlfrontAddressListRes  = mlfrontAddressService.selectMlfrontAddressByParam(mlfrontAddressReq);
		MlfrontAddress mlfrontAddressRes = mlfrontAddressListRes.get(0);
		return mlfrontAddressRes;
	}

	/**
	 * 9.0	zsh	200720
	 * to	全部支付单的状态-分状态查询
	 * @param pn,Integer payinfoStatus,String payinfoPlateNum;
	 * @return
	 */
	@RequestMapping(value="/selectHighPayInfoListBySearch",method=RequestMethod.POST)
	@ResponseBody
	public Msg selectHighPayInfoListBySearch(@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "payinfoStatus") Integer payinfoStatus,
			@RequestParam(value = "payinfoPlateNum") String payinfoPlateNum,
			HttpSession session) {
		
		//初始化请求参数
		MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
		List<MlfrontPayInfo> mlfrontPayInfoList = new ArrayList<MlfrontPayInfo>();
		int PagNum = 50;
		PageHelper.startPage(pn, PagNum);
		PageInfo page = new PageInfo();
		
		if("".equals(payinfoPlateNum)){
			mlfrontPayInfoReq.setPayinfoPlatenum(null);
		}else{
			mlfrontPayInfoReq.setPayinfoPlatenum(payinfoPlateNum);
		}
		
		if(payinfoStatus==999){
			mlfrontPayInfoReq.setPayinfoStatus(null);
		}else{
			mlfrontPayInfoReq.setPayinfoStatus(payinfoStatus);
		}
		mlfrontPayInfoList = mlfrontPayInfoService.selectHighPayInfoListBySearch(mlfrontPayInfoReq);
		page = new PageInfo(mlfrontPayInfoList, PagNum);
		
		return Msg.success().add("pageInfo", page).add("mlfrontPayInfoList", mlfrontPayInfoList);
		
	}
	
	//PayinfoStatus(5);//0未支付//1支付成功//2审单完毕//3发货完毕 //4已退款//5发送弃购//6重复单关
	//OrderStatus(6);//0未支付//1支付成功//2支付失败//3审单完毕 //4发货完毕//5已退款//6发送弃购//7重复单关闭
}