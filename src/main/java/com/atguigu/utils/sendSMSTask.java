package com.atguigu.utils;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import com.atguigu.bean.MlbackOrderStateEmail;
import com.atguigu.bean.MlbackSmstype;
import com.atguigu.bean.MlfrontAddress;
import com.atguigu.bean.MlfrontOrder;
import com.atguigu.bean.MlfrontPayInfo;
import com.atguigu.service.MlbackHtmlEmailService;
import com.atguigu.service.MlbackOrderStateEmailService;
import com.atguigu.service.MlbackSmstypeService;
import com.atguigu.service.MlfrontAddressService;
import com.atguigu.service.MlfrontOrderItemService;
import com.atguigu.service.MlfrontOrderService;
import com.atguigu.service.MlfrontPayInfoService;

@Component
public class sendSMSTask {
	
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
	
	@Autowired
	MlbackHtmlEmailService mlbackHtmlEmailService;
	
	@Autowired
	MlbackOrderStateEmailService mlbackOrderStateEmailService;
	
	/**
	 * 6.0	zsh200804
	 * 点击按钮发送短信
	 * @param String PayInfoNumStr
	 * @return 
	 * */
	@Scheduled(cron = "0 0 0/3 * * ?")
    public void doTask()  throws InterruptedException{
     
		MlbackOrderStateEmail mlbackOrderStateEmailReq = new MlbackOrderStateEmail();
        mlbackOrderStateEmailReq.setOrderstateemailName("AbondonEmail");
        
        List<MlbackOrderStateEmail> mlbackOrderStateEmailList = mlbackOrderStateEmailService.selectMlbackOrderStateEmailByName(mlbackOrderStateEmailReq);
        
        MlbackOrderStateEmail mlbackOrderStateEmailOne = mlbackOrderStateEmailList.get(0);
        String webSiteUrl = mlbackOrderStateEmailOne.getOrderstateemailOne();
        String lastHour = mlbackOrderStateEmailOne.getOrderstateemailTwo();
        
        Integer lastHourInt = Integer.parseInt(lastHour);
        
        String nowtime = DateUtil.strTime14s();//当前时间
        String endTime = DateUtil.dateRoll(lastHourInt);//当前时间2小时
		String startTime = DateUtil.dateRoll(lastHourInt+12);
        
		MlfrontPayInfo mlfrontPayInfoRe = new MlfrontPayInfo();
		
		mlfrontPayInfoRe.setPayinfoCreatetime(startTime);
		mlfrontPayInfoRe.setPayinfoMotifytime(endTime);
		mlfrontPayInfoRe.setPayinfoIfEmail(0);
		
		mlfrontPayInfoRe.setPayinfoCreatetime(startTime);
		System.out.println("startTime"+startTime);
		mlfrontPayInfoRe.setPayinfoMotifytime(endTime);
		System.out.println("endTime"+endTime);
				
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
				
				MlfrontPayInfo mlfrontPayInfoReq = new MlfrontPayInfo();
				mlfrontPayInfoReq.setPayinfoCreatetime(startTime);
				mlfrontPayInfoReq.setPayinfoMotifytime(endTime);
				
				List<MlfrontPayInfo> mlfrontPayInfoList =  mlfrontPayInfoService.selectUnpayToSMSByDate(mlfrontPayInfoReq);
				
				if(mlfrontPayInfoList.size()>0){
					
					String orderIdLastOneStr = "";
					
					for(MlfrontPayInfo mlfrontPayInfoOne:mlfrontPayInfoList){
						
						//本payinfoId是多少,更新完了的话,需要把这一单的payinfo_SMS更新过来
						Integer payId = mlfrontPayInfoOne.getPayinfoId();
						
						Integer checkRecoverOrderId = mlfrontPayInfoOne.getPayinfoOid();
						
						String checkRecoverOrderIdNowStr = checkRecoverOrderId+"";
						
						if(checkRecoverOrderIdNowStr.equals(orderIdLastOneStr)){
							//当前orderid=上一个orderid,逃过,循环下一个.
							//当前单子有毛病
							continue;
						}else{
							//读出order对应的order明细;
							//---------------拿到orderId,去地址表中查询addressId,再从地址信息中查询邮箱手机号-------begin----------
							MlfrontOrder mlfrontOrderPay = new MlfrontOrder();
							mlfrontOrderPay.setOrderId(checkRecoverOrderId);
							List<MlfrontOrder> mlfrontOrderPayResList= mlfrontOrderService.selectMlfrontOrderById(mlfrontOrderPay);
							MlfrontOrder mlfrontOrderPayOneRes = mlfrontOrderPayResList.get(0);
							//2.2从详情中拿到addressid;
							Integer addressinfoId = mlfrontOrderPayOneRes.getOrderAddressinfoId();
							MlfrontAddress MlfrontAddressReq = new MlfrontAddress();
							MlfrontAddressReq.setAddressId(addressinfoId);
							List<MlfrontAddress> MlfrontAddressList = mlfrontAddressService.selectMlfrontAddressByParam(MlfrontAddressReq);
							MlfrontAddress mlfrontAddressOne = MlfrontAddressList.get(0);
							String telephone = mlfrontAddressOne.getAddressTelephone();
							String firstName = mlfrontAddressOne.getAddressUserfirstname();
							String countryCode = mlfrontAddressOne.getAddressCountryCode();
							
							String realTel = getRealTel(countryCode,telephone);
							
							String userName = firstName+" ";
							//---------------拿到orderId,去地址表中查询addressId,再从地址信息中查询邮箱手机号-------end--------
							String checkRecoverOrderIdStr = checkRecoverOrderId+"";
							
							String websiteStr = webSiteUrl;
							
							String secretOrderIdStr = EncryptUtil.XORencode(checkRecoverOrderIdStr,"megalook");
							
							String SendStr = "【MegaLook】Dear "+userName+","+Content+"."+websiteStr+"recover/"+checkRecoverOrderIdStr+".html";
//							System.out.println("本单号位checkRecoverOrderIdStr："+checkRecoverOrderIdStr+",本条弃购链接为SendStr:"+SendStr);
							String SendSecretStr = "【MegaLook】Dear "+userName+","+Content+"."+websiteStr+"recover/"+secretOrderIdStr+".html";
//							System.out.println("本单号位checkRecoverOrderIdStr："+checkRecoverOrderIdStr+",本条弃购链接为SendSecretStr:"+SendSecretStr);
							
							//这里要解密
//							String unSecretOrderIdStr = EncryptUtil.XORdecode(secretOrderIdStr,"megalook");
//							String SendUnSecretStr = Content+"."+websiteStr+"recover/"+unSecretOrderIdStr+".html";
//							System.out.println("本单号位checkRecoverOrderIdStr："+checkRecoverOrderIdStr+",本条弃购链接为SendUnSecretStr:"+SendUnSecretStr);
							
							try {
								//这个是真实发送
								//String SMSreturnData = SMSUtilshtml.sendSMS(SendStr,telephone);//未加密串
								String SMSreturnData = SMSUtilshtml.sendSMS(SendSecretStr,telephone);//加密串
								System.out.println(SendSecretStr+",这一单发送成功");
								//System.out.println("payid为:"+mlfrontPayInfoOne.getPayinfoId()+","+SendSecretStr+",这一单短信通知成功--被屏蔽,仅仅打印,未实际发送,");
								//这个是真实发送
							} catch (Exception e) {
								e.printStackTrace();
								System.out.println(SendStr+",这一单系统异常,报错了");
							}
							//1-本payinfoId是多少,更新完了的话;
							MlfrontPayInfo mlfrontPayInfoSMSed = new MlfrontPayInfo();
							mlfrontPayInfoSMSed.setPayinfoId(payId);
							mlfrontPayInfoSMSed.setPayinfoIfSMS(1);
							//2-需要把这一单的payinfo_SMS更新过来
							mlfrontPayInfoService.updateByPrimaryKeySelective(mlfrontPayInfoSMSed);
							
							//操作完毕，把当前orderid存住；
							orderIdLastOneStr = checkRecoverOrderIdNowStr;
						}
						
					}
					//该状态不生效,没有生效的
					//return Msg.success().add("resMsg", "本时间段的弃购挽回信息操作完毕");
				}else{
					//该状态不生效,没有生效的
					//return Msg.fail().add("resMsg", "本时间段没有可以弃购挽回的订单信息");
				}
			}else{
				//该状态不生效,没有生效的
				//return Msg.fail().add("resMsg", "没有生效的smstype命令");
			}
		}else{
			//没查到这个,返回
			//return Msg.fail().add("resMsg", "没配置smstypeName对象");
		}
	}

	private String getRealTel(String countryCode, String telephone) {
		
		
		
		return null;
	}

}
