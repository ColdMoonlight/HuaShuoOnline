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
//			List<MlfrontOrderItem> mlfrontOrderItemResList = mlfrontOrderItemService.selectMlfrontOrderItemByParam(mlfrontOrderItemReq);
			List<MlfrontOrderItem> mlfrontOrderItemResList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemReq);
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
	
	/**5.0	useOn	200323
	 * 更新order表中的:地址字段,优惠券字段,优惠券折扣。
	 * @param MlfrontOrder
	 */
//	@RequestMapping(value="/orderToPayInfo",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg orderToPayInfo(HttpServletResponse rep,HttpServletRequest res,HttpSession session,@RequestBody MlfrontOrder mlfrontOrder){
//		//0.0接受参数信息
//		//System.out.println("mlfrontOrder:"+mlfrontOrder);
//		Integer originalOrderId = mlfrontOrder.getOrderId();
////		String filnanyNumber = mlfrontOrder.getOrderProNumStr();
//		String filnanyNumber = mlfrontOrder.getOrderPronumStr();
//		Integer CouponId =mlfrontOrder.getOrderCouponId();
//		//System.out.println("点结算按钮的时候,接收到的CouponId:"+CouponId);
//		Integer orderPayPlateInt = mlfrontOrder.getOrderPayPlate();//客户选择的支付方式，0paypal,1待定
//		String buyMessStr = mlfrontOrder.getOrderBuyMess();
//		//1.0用order查orderItem,遍历orderItem,计算每个Item的价格，再加在一起；
//		String Orderitemidstr = mlfrontOrder.getOrderOrderitemidstr();
//		String orderitemidArr[] = Orderitemidstr.split(",");
//		BigDecimal totalprice = new BigDecimal(0);	//初始化最终价格参数
//		DecimalFormat df1 = new DecimalFormat("0.00");
//		MlfrontOrderItem mlfrontOrderItemReq = new MlfrontOrderItem();
//		MlfrontOrderItem mlfrontOrderItemRes = new MlfrontOrderItem();
//		String orderitemidArri="";
//		for(int i=0;i<orderitemidArr.length;i++){
//			BigDecimal oneAllprice = new BigDecimal(0);//01初始化字段，用来存本sku的钱
//			System.out.println("orderitemidArr[i]:"+orderitemidArr[i]);
//			orderitemidArri = orderitemidArr[i].trim();
//			Integer orderItemId = Integer.parseInt(orderitemidArri);
//			mlfrontOrderItemReq.setOrderitemId(orderItemId);
//			List<MlfrontOrderItem> mlfrontOrderItemList = mlfrontOrderItemService.selectMlfrontOrderItemById(mlfrontOrderItemReq);
//			mlfrontOrderItemRes = mlfrontOrderItemList.get(0);
//			BigDecimal ItemProductOriginalprice =mlfrontOrderItemRes.getOrderitemProductOriginalprice();
//			String OrderitemPskuMoneystr = mlfrontOrderItemRes.getOrderitemPskuMoneystr();
//			Integer number = mlfrontOrderItemRes.getOrderitemPskuNumber();
//			Integer accoff = mlfrontOrderItemRes.getOrderitemProductAccoff();
//			String PskuMoneystr[] = OrderitemPskuMoneystr.split(",");
//			BigDecimal pskuMoneyOne = new BigDecimal(0);
//			String pskuTrimStr="";
//			for(int j =0;j<PskuMoneystr.length;j++){
//				pskuTrimStr = PskuMoneystr[j].trim();
//				pskuMoneyOne = new BigDecimal(pskuTrimStr);
//				oneAllprice = oneAllprice.add(pskuMoneyOne);//02计算本orderItem下的所有sku项的钱
//			}
//			oneAllprice=oneAllprice.add(ItemProductOriginalprice);//03叠加本品基础价的钱(now：该条的allPskumoney+该条Pro的基础价)
//			//计算这一项的价格，(基础价格+每个的sku价格的和)*折扣*数量,存入orderitemPskuReamoney字段中;
//			oneAllprice = oneAllprice.multiply(new BigDecimal(number));//04乘本品的个数得到总价
//			oneAllprice = oneAllprice.multiply(new BigDecimal(accoff));//05乘本品的折扣
//			oneAllprice = oneAllprice.multiply(new BigDecimal(0.01));//06还原本品+sku集合的最终价
//			String str = df1.format(oneAllprice);
//			//System.out.println("OrderitemPskuReamoney原始值:"+oneAllprice);
//			System.out.println("存进去的OrderitemPskuReamoney:"+str); //13.15
//			MlfrontOrderItem mlfrontOrderItemMoneyBlack = new MlfrontOrderItem();
//			mlfrontOrderItemMoneyBlack.setOrderitemId(orderItemId);
//			mlfrontOrderItemMoneyBlack.setOrderitemPskuReamoney(str);
//			//更新本条，存入orderitemPskuReamoney字段
//			mlfrontOrderItemService.updateByPrimaryKeySelective(mlfrontOrderItemMoneyBlack);
//			//一个字段存储总价格
//			totalprice = totalprice.add(oneAllprice);//07总价字段累加该条的全部价格
//		}
//		/*		加		单个的	(基础价格+每个的sku价格的和)*折扣*数量,
//		 * 		加				地址运费
//		 * 		减				优惠价格
//		 * */
//		//2.0计算地址价格，计算优惠价格，插入order项目价格
//		//2.1拿到地址ID,
//		Integer AddressId = mlfrontOrder.getAddressinfoId();
//		
//		if(AddressId==null){
//			AddressId= (Integer) session.getAttribute("realAddressId");
//		}
//		//2.2查询英文名,查询该英文名的价格运费价格
//		Integer addressMoney = getAddressMoney(AddressId);
//		
//		String addressMoneyStr= df1.format(addressMoney);
//		session.setAttribute("addressMoney", addressMoneyStr);
//		//2.2加上地区快递费
//		totalprice = totalprice.add(new BigDecimal(addressMoney));
//		//拿到优惠码Code,
//		String CouponCode = mlfrontOrder.getOrderCouponCode();
//		//查询该优惠码的优惠价格
//		BigDecimal CouponCodeMoney = getCouponCodeMoney(CouponCode, totalprice);
//		String CouponCodeMoneyStr= df1.format(CouponCodeMoney);
//		session.setAttribute("CouponCodeMoney", CouponCodeMoneyStr);
//		//加上优惠券减掉的
//		totalprice = totalprice.subtract(CouponCodeMoney);
//		//计算该订单的实际价格
//		String totalpriceStr = df1.format(totalprice);
//		//2.3更新order表(地区字段,优惠券字段,总价的价格，结算方式,留言,总价的价格)
//		MlfrontOrder mlfrontOrderEnd = new  MlfrontOrder();
//		mlfrontOrderEnd.setOrderId(originalOrderId);
//		mlfrontOrderEnd.setAddressinfoId(AddressId);//地区字段
//		mlfrontOrderEnd.setOrderCouponId(CouponId);
//		mlfrontOrderEnd.setOrderCouponCode(CouponCode);//优惠券字段
//		mlfrontOrderEnd.setOrderCouponPrice(CouponCodeMoney);//优惠券money
//		mlfrontOrderEnd.setOrderPayPlate(orderPayPlateInt);//结算方式
//		mlfrontOrderEnd.setOrderProNumStr(filnanyNumber);//最终各个产品数量
//		mlfrontOrderEnd.setOrderBuyMess(buyMessStr);//留言
//		BigDecimal bigTotalprice = new BigDecimal(totalpriceStr);//总价的价格
//		mlfrontOrderEnd.setOrderMoney(bigTotalprice);
//		String nowTime = DateUtil.strTime14s();
//		mlfrontOrderEnd.setOrderMotifytime(nowTime);
//		//执行更新order表
//		mlfrontOrderService.updateByPrimaryKeySelective(mlfrontOrderEnd);
//		//3.0将order信息写入payInfo信息中心//uid oid 支付方式，交易订单号，支付信息
//		//从orderId中查询uid,地址id,buyMess字段;
//		Integer payAddressinfoId = mlfrontOrderEnd.getAddressinfoId();
//		
//		MlfrontAddress mlfrontAddress =new MlfrontAddress();
//		mlfrontAddress.setAddressId(payAddressinfoId);
//		
//		List<MlfrontAddress> mlfrontAddressToPayList = mlfrontAddressService.selectMlfrontAddressById(mlfrontAddress);
//		
//		MlfrontAddress mlfrontAddressToPay = mlfrontAddressToPayList.get(0);
//		
//		session.setAttribute("mlfrontAddressToPay", mlfrontAddressToPay);
//		session.setAttribute("totalprice", totalprice);
//		
//		MlfrontPayInfo mlfrontPayInfoNew = new MlfrontPayInfo();
//		mlfrontPayInfoNew.setPayinfoOid(originalOrderId);
//		mlfrontPayInfoNew.setPayinfoStatus(0);//0未支付1已支付
//		if(orderPayPlateInt==0){
//			mlfrontPayInfoNew.setPayinfoPlatform("paypal");
//		}else{
//			mlfrontPayInfoNew.setPayinfoPlatform("bank_Card");
//		}
//
//		//6获取returnmoney
//		String orderAllMoney = GetOrderTopayinfoMoney(Orderitemidstr);
//		
//		String addressMoneyendStr = addressMoney+"";
//		
//		String amTotal = getamountTotal(orderAllMoney,CouponCodeMoneyStr,addressMoneyendStr);
//		
//		BigDecimal amTotalBig=new BigDecimal(amTotal);  
//		
//		mlfrontPayInfoNew.setPayinfoMoney(amTotalBig);//总钱数排除一分钱后的计算结果
//		mlfrontPayInfoNew.setPayinfoCreatetime(nowTime);
//		mlfrontPayInfoNew.setPayinfoMotifytime(nowTime);
//		mlfrontPayInfoService.insertSelective(mlfrontPayInfoNew);
////		List<MlfrontPayInfo> mlfrontPayInfoResList = mlfrontPayInfoService.selectMlfrontPayInfoAll();
////		MlfrontPayInfo mlfrontPayInfoResOne = mlfrontPayInfoResList.get(0);
////		Integer payinfoId = mlfrontPayInfoResOne.getPayinfoId();
//		Integer payinfoId = mlfrontPayInfoNew.getPayinfoId();
//		session.setAttribute("payinfoId", payinfoId);
//		
//		session.setAttribute("sendAddressinfoId", payAddressinfoId);
//		
//		//取出sessionid，再次放入
//		Integer orderIdFinally = (Integer) session.getAttribute("orderId");
//		session.setAttribute("orderId", orderIdFinally);
//		//4.0传入orderid,查询其中的orderItemID,找到cartID 找到cartid,移除购物车中的
//		updateCart(mlfrontOrder);
//		//5.0发起支付
//		Integer isSuccess = 0;//返回0，跳支付成功页面;返回1，跳支付失败页面
//		return Msg.success().add("resMsg", "更新成功").add("isSuccess", isSuccess).add("payinfoId", payinfoId).add("orderId", orderIdFinally);
//	}

}