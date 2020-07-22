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
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.atguigu.bean.MlPaypalShipAddress;
import com.atguigu.bean.MlbackAreafreight;
import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontOrderItem;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlPaypalShipAddressService;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackAreafreightService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontUserService;
import com.atguigu.utils.EcppUpdateWebStatusUtil;
import com.atguigu.utils.PropertiesUtil;
import com.atguigu.utils.app.shipInformation;
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
	public Msg getMlfrontPayInfoWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {
//		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("adminuser");
//		if(mlbackAdmin==null){
//			//SysUsers对象为空
//			return Msg.fail().add("resMsg", "session中adminuser对象为空");
//		}else{
			int PagNum = 50;
			PageHelper.startPage(pn, PagNum);
			List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoAll();
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
			//2.获取本条单子的orderId，2.1查询本条的order详情;2.2从详情中拿到addressid;2.3orderItemIDStr;2.4uid信息，历史购买次数;
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
	 * 6.0	useOn	0505
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
		//2.获取本条单子的orderId，2.1查询本条的order详情;2.2从详情中拿到addressid;2.3orderItemIDStr;2.4uid信息，历史购买次数;
		//2.1查询本条的order详情;
		Integer payinfoOid = mlfrontPayInfoOne.getPayinfoOid();
		MlfrontOrder mlfrontOrderPay = new MlfrontOrder();
		mlfrontOrderPay.setOrderId(payinfoOid);
		List<MlfrontOrder> mlfrontOrderPayResList= mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderPay);
		MlfrontOrder mlfrontOrderPayOneRes = mlfrontOrderPayResList.get(0);
		//2.2从详情中拿到addressid;
//		Integer addressinfoId = mlfrontOrderPayOneRes.getAddressinfoId();
		Integer addressinfoId = mlfrontOrderPayOneRes.getOrderAddressinfoId();
		MlfrontAddress MlfrontAddressReq = new MlfrontAddress();
		MlfrontAddressReq.setAddressId(addressinfoId);
//		List<MlfrontAddress> MlfrontAddressList = mlfrontAddressService.selectMlfrontAddressById(MlfrontAddressReq);
		List<MlfrontAddress> MlfrontAddressList = mlfrontAddressService.selectMlfrontAddressByParam(MlfrontAddressReq);
		MlfrontAddress mlfrontAddressOne = MlfrontAddressList.get(0);
		//2.2.1从地址中取出国家字段	addressCountry: "US"	addressCountryAll: "United States"
		//拿到国家的code
		String areafreightCountryEnglish = mlfrontAddressOne.getAddressCountry();
		//封装国家code
		MlbackAreafreight mlbackAreafreightReq = new MlbackAreafreight();
//		mlbackAreafreightReq.setAreafreightCountryEnglish(areafreightCountryEnglish);
		mlbackAreafreightReq.setAreafreightCountryCode(areafreightCountryEnglish);
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
	
	/**11.0	zsh200720
	 * 检查已支付的单子,是否在ecpp上已经审核
	 * 1,收到前台的查询时间范围，后台查询这些时间内的已支付订单,
	 * 2,便利这些单子,用token+H号,去查询本条的状态,
	 * 3.1如果是审核完毕,就在我方系统中,将本条改成已经审核的状态
	 * 3.2如果是已发货,就在我方系统中,将本单改成已经已发货的状态;并且把哪家物流的名字+track_no,同步回我方后台
	 * @param "payinfoCreatetime": "2020-07-21 08:20:06",
     * 		  "payinfoMotifytime": "2020-07-21 08:50:06"
	 */
	@RequestMapping(value="/checkEcppIfVerify",method=RequestMethod.POST)
	@ResponseBody
	public Msg checkEcppIfVerify(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo){
		
		String startTime = mlfrontPayInfo.getPayinfoCreatetime();
		String endTime = mlfrontPayInfo.getPayinfoMotifytime();
		
		MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
		
		mlfrontPayInfoReq.setPayinfoCreatetime(startTime);
		mlfrontPayInfoReq.setPayinfoMotifytime(endTime);
		mlfrontPayInfoReq.setPayinfoStatus(1);//只查询已支付的状态
		
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
                		
                		//查询本条的order信息，更新物流单号+物流名称
                		mlfrontOrderReq.setOrderLogisticsname(ecppTrackItem.getShippingName());
                		mlfrontOrderReq.setOrderLogisticsnumber(ecppTrackItem.getEcppOrderTrackNo());
                		mlfrontOrderReq.setOrderStatus(4);//orderStatus == 4已发货,待接收
                		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
                		
                		String orderLogisticsname = ecppTrackItem.getShippingName();
                		
                		String orderLogisticsnumber = ecppTrackItem.getEcppOrderTrackNo();
                		
                		String payinfoPlateNum = mlfrontPayInfoOne.getPayinfoPlatenum();
                		
                		//10.1向afterShip官方发送物流添加按钮
                		try {
                			//向物流中插入物流单号,订单号,Item,价格,
                			String resultStr =  shipInformation.addTrackingNumberIntoAfterShip(orderLogisticsname,orderLogisticsnumber,payinfoPlateNum);
                			System.out.println(resultStr);
                		} catch (Exception e) {
                			e.printStackTrace();
                			System.out.println("物流中插入物流单号--有异常");
                			System.out.println(e.getMessage());
                		}
                		
                		
					}else if("UOO".equals(ecppOrderStatusCode)){
							//113-UOO-客服审核完成的状态，就更新成审核完毕的状态
							mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
	                		mlfrontPayInfoUpdate.setPayinfoStatus(2);//payinfo状态为2,已审单//orderStatus == 3已审单，待发货
	                		mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
	                		mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
	                		
	                		mlfrontOrderReq.setOrderStatus(3);//orderStatus == 3已审单,待发货//
	                		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
					}else{
						mlfrontPayInfoUpdate.setPayinfoId(payInfoId);//不改状态,只赋值
						mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);
						mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			return Msg.success().add("resMsg", "本次刷新有修改，请注意观察payInfo列表变化");
		}else{
			//查询结果为空
			//当前没有状态为已支付的数据
			return Msg.success().add("resMsg", "本次刷新没有状态是已支付的单子，无改变");
		}
	}
	
	/**12.0	zsh200722
	 * 检查已审核的单子,是否在ecpp上已经发货
	 * 1,收到前台的查询时间范围，后台查询这些时间内的已审核订单,
	 * 2,便利这些单子,用token+H号,去查询本条的状态,
	 * 3,如果是已发货,就在我方系统中,将本单改成已经已发货的状态;并且把哪家物流的名字+track_no,同步回我方后台
	 * @param "payinfoCreatetime": "2020-07-21 08:20:06",
     * 		  "payinfoMotifytime": "2020-07-21 08:50:06"
	 */
	@RequestMapping(value="/checkEcppIfSend",method=RequestMethod.POST)
	@ResponseBody
	public Msg checkEcppIfSend(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontPayInfo mlfrontPayInfo){
		
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
                		
                		//查询本条的order信息，更新物流单号+物流名称
                		mlfrontOrderReq.setOrderLogisticsname(ecppTrackItem.getShippingName());
                		mlfrontOrderReq.setOrderLogisticsnumber(ecppTrackItem.getEcppOrderTrackNo());
                		mlfrontOrderReq.setOrderStatus(4);//orderStatus == 4已发货,待接收
                		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderReq);
                		
					}else{
						mlfrontPayInfoUpdate.setPayinfoId(payInfoId);
						mlfrontPayInfoUpdate.setPayinfoEcpphsnumStatus(ecppOrderStatusCode);//不改状态,只赋值
						mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoUpdate);
					}
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
			}
			return Msg.success().add("resMsg", "本次刷新有修改，请注意观察payInfo列表变化");
		}else{
			//查询结果为空
			//当前没有状态为已支付的数据
			return Msg.success().add("resMsg", "本次刷新没有状态是已支付的单子，无改变");
		}
	}
	
}