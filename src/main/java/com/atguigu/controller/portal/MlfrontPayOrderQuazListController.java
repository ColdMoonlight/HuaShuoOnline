package com.atguigu.controller.portal;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackSmstypeService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlfrontOrderList")
public class MlfrontPayOrderQuazListController {
		
	@Autowired
	MlfrontOrderService mlfrontOrderService;

	@Autowired
	MlfrontOrderItemService mlfrontOrderItemService;
	
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	MlbackSmstypeService mlbackSmstypeService;
	
	@Autowired
	MlfrontAddressService mlfrontAddressService;
	
//	afterShip的真实物流url环境
	private final static String ConnectionAPIid = "7b04f01f-4f04-4b37-bbb9-5b159af73ee1";
	
	
	
	public static void main(String[] args) {
		
		String hour12BeforeTimes = DateUtil.dateRoll(18);
		
		System.out.println("hour12BeforeTimes:"+hour12BeforeTimes);
		
	}
	
	/**
	 * 1.0	zsh	200720
	 * to	全部订单-分状态查询
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping(value="/selectOrderlistBySearch",method=RequestMethod.GET)
	@ResponseBody
	public Msg selectOrderlistBySearch(HttpSession session) {
		
		
		/**
		 * 准备筛选前的数据
		 * 1自动查询12小时以内的payinfo订单List
		 * 存储付款成功的paySuccessList	包含成功名字
		 * 存储失败的UnPayList
		 * */
		
		//获取当前系统时间
		
		MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
		
		String nowtime = DateUtil.strTime14s();
		
		String beforeTime = DateUtil.dateRoll(72);
		
		
		mlfrontPayInfoReq.setPayinfoCreatetime(beforeTime);
		mlfrontPayInfoReq.setPayinfoMotifytime(nowtime);
		
		List<MlfrontPayInfo> mlfrontPayInfoList = mlfrontPayInfoService.selectMlfrontPayInfoByDate(mlfrontPayInfoReq);
		
		
		List<MlfrontPayInfo> mlfrontPayInfoSuccessList = new ArrayList<MlfrontPayInfo>();
		
		List<MlfrontPayInfo> mlfrontPayInfoUnPayList = new ArrayList<MlfrontPayInfo>();
		

        Map<String, String> successPayInfoOrderIdMap = new HashMap<String, String>();
        
        Map<String, String> successPayInfoUserNameMap = new HashMap<String, String>();
        
        
        List<Integer> successPayIdList = new ArrayList<Integer>();
        
        List<Integer> sameUnPayIdList = new ArrayList<Integer>();
        
        List<Integer> trueUnPayIdList = new ArrayList<Integer>();
			
		for(MlfrontPayInfo mlfrontPayInfoOne:mlfrontPayInfoList){
			Integer patStatus = mlfrontPayInfoOne.getPayinfoStatus();
			if(patStatus==0){
				//失败订单
				mlfrontPayInfoUnPayList.add(mlfrontPayInfoOne);
				
			}else{
				//成功订单
				mlfrontPayInfoSuccessList.add(mlfrontPayInfoOne);
				
				successPayIdList.add(mlfrontPayInfoOne.getPayinfoId());
				
				successPayInfoOrderIdMap.put(mlfrontPayInfoOne.getPayinfoOid()+"", mlfrontPayInfoOne.getPayinfoOid()+"");
				successPayInfoUserNameMap.put(mlfrontPayInfoOne.getPayinfoUname(), mlfrontPayInfoOne.getPayinfoUname());
			}
			
		}
		//订单(客户A，试了4次，分别是A1-N，A1-N，A2-N，A3-Y)(客户B，试了1次，B1-N)(客户C,试了5次，C1-N，C1-N，C2-N，C3-N，C3-N，C3-Y)
		
		/**遍历
		 * 
		 * */

		List<MlfrontPayInfo> mlfrontPayInfoRemoveSameOidNowList = new ArrayList<MlfrontPayInfo>();
			
		for(MlfrontPayInfo mlfrontPayInfoB:mlfrontPayInfoUnPayList){
			Integer unpOrderID = mlfrontPayInfoB.getPayinfoOid();
			
			String pOrderIDSuccessStr = successPayInfoOrderIdMap.get(unpOrderID+"");
			if(pOrderIDSuccessStr.length()>0){
				//这个是重复单子(最终客户付款之前的单子),跳过
				
				sameUnPayIdList.add(mlfrontPayInfoB.getPayinfoId());
			}else{
				//这一单起码orderid没有重复//存起来
				mlfrontPayInfoRemoveSameOidNowList.add(mlfrontPayInfoB);
				//这里面-剔除了--跟已支付同orderid的重复单(未支付的重复单子)
				
				//把此时的客户名字存起来放进Map成功map中
			}

		}
		
		//没有跟成功单相同的orderid了。现在要删掉，剩下的非与成功相同的orderid。去除了跟成功单相同的orderid的payinfo单子
		
		
		List<MlfrontPayInfo> mlfrontPayInfoRemoveUnameList = new ArrayList<MlfrontPayInfo>();
		
        Map<String, String> reallyUnPayInfoOrderIdMap = new HashMap<String, String>();
        
        Map<String, String> reallyUnPayInfoUserNameMap = new HashMap<String, String>();
		
		
		for(MlfrontPayInfo mlfrontPayInfoC:mlfrontPayInfoRemoveSameOidNowList){
			String payinfoUname = mlfrontPayInfoC.getPayinfoUname();
			
			String pOrderUnameSuccessStr = successPayInfoUserNameMap.get(payinfoUname);
			
			if(pOrderUnameSuccessStr.length()>0){
				//这个是人名重复重复单子(最终客户付款之前的单子),跳过
				sameUnPayIdList.add(mlfrontPayInfoC.getPayinfoId());
			}else{
				//这一单起码orderid没有重复//存起来
				mlfrontPayInfoRemoveUnameList.add(mlfrontPayInfoC);
				//这里面-剔除了--跟已支付同Uname的重复单(未支付的重复单子)
				
				//把此时的客户名字存起来放进Map成功map中
				
				reallyUnPayInfoOrderIdMap.put(mlfrontPayInfoC.getPayinfoOid()+"", mlfrontPayInfoC.getPayinfoOid()+"");
				reallyUnPayInfoUserNameMap.put(mlfrontPayInfoC.getPayinfoUname(), mlfrontPayInfoC.getPayinfoUname());
			}
		}
		
		//移除了与成功单相同Orderid的单子/与成功单相同UserName的单子
		
		Integer lastUnPayOid = 0;
		
		List<MlfrontPayInfo> mlfrontPayInfoRemoveUnPayOrderIdSameList = new ArrayList<MlfrontPayInfo>();
		
		for(MlfrontPayInfo mlfrontPayInfoD:mlfrontPayInfoRemoveUnameList){
			Integer unpOrderID = mlfrontPayInfoD.getPayinfoOid();
			
			if(lastUnPayOid.equals(unpOrderID)){
				//这一单重复啦(未支付里面的orderid重复)
				//仅仅记录到未成功付款的重复单里
				sameUnPayIdList.add(mlfrontPayInfoD.getPayinfoId());
			}else{
				mlfrontPayInfoRemoveUnPayOrderIdSameList.add(mlfrontPayInfoD);
				lastUnPayOid = unpOrderID;
			}
		}
		
		
		List<MlfrontPayInfo> mlfrontPayInfoRemoveUnPayOrderUnameSameList = new ArrayList<MlfrontPayInfo>();
		
		String lastUnpOrderUname = "";
		
		for(MlfrontPayInfo mlfrontPayInfoE:mlfrontPayInfoRemoveUnPayOrderIdSameList){
			String unpOrderUname = mlfrontPayInfoE.getPayinfoUname();
			
			if(lastUnpOrderUname.equals(unpOrderUname)){
				//这一单重复啦(未支付里面的orderid重复)
				
				//仅仅记录到未成功付款的重复单里
				sameUnPayIdList.add(mlfrontPayInfoE.getPayinfoId());
			}else{
				mlfrontPayInfoRemoveUnPayOrderUnameSameList.add(mlfrontPayInfoE);
				trueUnPayIdList.add(mlfrontPayInfoE.getPayinfoId());
				lastUnpOrderUname = unpOrderUname;
			}
		}
		
		return Msg.success().add("trueUnPayIdList", trueUnPayIdList).add("successPayIdList", successPayIdList).add("sameUnPayIdList", sameUnPayIdList);
		
	}
	
	
	public static String dateRoll(int ihour) {
	      DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	      //（1）获取当前时间
	      LocalDateTime date = LocalDateTime.now();
	      //（2）获取当前时间的前几小时时间
	      LocalDateTime localDateTime = date.minusHours(ihour);

	      return dateTimeFormatter.format(localDateTime);
	  }
	
}
