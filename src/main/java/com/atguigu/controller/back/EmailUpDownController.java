package com.atguigu.controller.back;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.atguigu.bean.EmailAddress;
import com.atguigu.bean.EmailPayPalRetuenSuccess;
import com.atguigu.bean.EmailPaySuccess;
import com.atguigu.bean.EmailUser;
import com.atguigu.service.DownPayCheckDateService;
import com.atguigu.service.EmailAddressService;
import com.atguigu.service.EmailPayPalRetuenSuccessService;
import com.atguigu.service.EmailPaySuccessService;
import com.atguigu.service.EmailUserService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontReviewService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/EmailUpDown")
public class EmailUpDownController {
		
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	DownPayCheckDateService downPayCheckDateService;
	
	@Autowired
	MlfrontReviewService mlfrontReviewService;
	
	@Autowired
	EmailPaySuccessService emailPaySuccessService;//PayInfoSuccessAddressEmail
	
	@Autowired
	EmailPayPalRetuenSuccessService emailPayPalRetuenSuccessService;//billingEmail
	
	@Autowired
	EmailAddressService emailAddressService;//PayInfo非SuccessAddressEmail
	
	@Autowired
	EmailUserService emailUserService;//全部注册
	
	/**
	 * 下载付款成功的Email
	 * */
	@RequestMapping(value="/exportPaySuccess",method=RequestMethod.GET)
	public void exportPaySuccess(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		
		rep.setContentType("application/octet-stream");
		
		String nowTime = DateUtil.strTime14();
		rep.setHeader("Content-Disposition", "attachment;filename="+nowTime+"payinfoSuccess.xls");
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		HSSFSheet sheet = wb.createSheet("sheet0");
		
		HSSFRow row = sheet.createRow(0);
		
		HSSFCell cell = row.createCell(0);
		
		List<String> successList = new ArrayList<String>();
		List<String> successNowList = new ArrayList<String>();
		
		//billingEmail
		EmailPayPalRetuenSuccess emailPayPalRetuenSuccessReq = new EmailPayPalRetuenSuccess();
		List<EmailPayPalRetuenSuccess> billingEmailList= emailPayPalRetuenSuccessService.selectALl(emailPayPalRetuenSuccessReq);
		
		for(EmailPayPalRetuenSuccess billEmailOne :billingEmailList){
			successList.add(billEmailOne.getPayretuensuccessEmail());
			successNowList.add(billEmailOne.getPayretuensuccessEmail());
		}
		
		//付款成功的Email
		EmailPaySuccess emailPayPalSuccessReq = new EmailPaySuccess();
		List<EmailPaySuccess> paySuccessEmailList= emailPaySuccessService.selectALl(emailPayPalSuccessReq);
		System.out.println("paySuccessEmailList.size():"+paySuccessEmailList.size());
		
		//遍历结算付款的,去billing中查询,如果查到-跳过.没查到-add进billingList中;
		for(EmailPaySuccess emailPaySuccessOne:paySuccessEmailList){
			Integer ifHave = 0;
			String email = emailPaySuccessOne.getPaysuccessEmail();
			ifHave = getIfIntoEmail(email,successNowList);
			if(ifHave>0){
				//包含了
				System.out.println("这个邮箱已经包含了");
			}else{
				successList.add(email);
			}
		}
		
		cell.setCellValue("num");
	    cell = row.createCell(1);
		cell.setCellValue("billingEmail");
	    cell = row.createCell(2);
	    
	    for (int i = 0; i < successList.size(); i++) {
	    	String successEmail = successList.get(i);
	        row = sheet.createRow(i+1);
	        row.createCell(0).setCellValue(i+1);
	        row.createCell(1).setCellValue(successEmail+"");
	    }
		try {
			OutputStream out =rep.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	private Integer getIfIntoEmail(String email, List<String> successList) {
		Integer ifHave = 0;
		for(String billingEmail:successList){
			//如果查到有相同的
			if(billingEmail.equals(email)){
				ifHave++;
				break;
			}
		}
		if(ifHave>0){
			return 1;
		}else{
			return 0; 
		}
	}

	/**
	 * 下载付款结算的Email
	 * */
	@RequestMapping(value="/exportAddressEmail",method=RequestMethod.GET)
	public void exportAddressEmail(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		
		rep.setContentType("application/octet-stream");
		String nowTime = DateUtil.strTime14();
		rep.setHeader("Content-Disposition", "attachment;filename="+nowTime+"addressEmailunPay.xls");
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("sheet0");
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(0);
		
		List<String> successList = new ArrayList<String>();
		List<String> successNowList = new ArrayList<String>();
		
		//billingEmail
		EmailPayPalRetuenSuccess emailPayPalRetuenSuccessReq = new EmailPayPalRetuenSuccess();
		List<EmailPayPalRetuenSuccess> billingEmailList= emailPayPalRetuenSuccessService.selectALl(emailPayPalRetuenSuccessReq);
		
		for(EmailPayPalRetuenSuccess billEmailOne :billingEmailList){
			successList.add(billEmailOne.getPayretuensuccessEmail());
			successNowList.add(billEmailOne.getPayretuensuccessEmail());
		}
		
		//付款成功的Email
		EmailPaySuccess emailPayPalSuccessReq = new EmailPaySuccess();
		List<EmailPaySuccess> paySuccessEmailList= emailPaySuccessService.selectALl(emailPayPalSuccessReq);
		System.out.println("paySuccessEmailList.size():"+paySuccessEmailList.size());
		
		//遍历结算付款的,去billing中查询,如果查到-跳过.没查到-add进billingList中;
		for(EmailPaySuccess emailPaySuccessOne:paySuccessEmailList){
			Integer ifHave = 0;
			String email = emailPaySuccessOne.getPaysuccessEmail();
			ifHave = getIfIntoEmail(email,successNowList);
			if(ifHave>0){
				//包含了
				System.out.println("这个邮箱已经包含了"+email+"....");
			}else{
				successList.add(email);
			}
		}
		//successList这是//billingEmail+paySuccessEmail
		List<String> nowAddressList = new ArrayList<String>();
		//查询结算地址里的Email
		EmailAddress emailAddressReq = new EmailAddress();
		List<EmailAddress> emailAddressList= emailAddressService.selectALl(emailAddressReq);
		//System.out.println("emailAddressList.size():"+emailAddressList.size());
		
		List<EmailAddress> emailAddressNoRubbish1List = new ArrayList<EmailAddress>();
		List<EmailAddress> emailAddressNoRubbish2List = new ArrayList<EmailAddress>();
		
		//清理到垃圾
		for(EmailAddress emailAddressOne:emailAddressList){
			
			String oneEmail = emailAddressOne.getAddressemailEmail();
			if(oneEmail.contains("@")){
				System.out.println("这是正确的邮箱格式");
				emailAddressNoRubbish1List.add(emailAddressOne);
			}
			
		}
		for(EmailAddress emailAddressOne:emailAddressNoRubbish1List){
			
			String oneEmail = emailAddressOne.getAddressemailEmail();
			if(oneEmail.contains("qq.")){
				System.out.println("这是谁的qq邮箱");
			}else{
				emailAddressNoRubbish2List.add(emailAddressOne);
			}
		}
		
		//遍历结算地址-去billing中查询,如果查到-跳过.没查到-add进billingList中;
		for(EmailAddress emailAddressOne:emailAddressNoRubbish2List){
			Integer ifHave = 0;
			String email = emailAddressOne.getAddressemailEmail();
			ifHave = getIfIntoEmail(email,successList);
			if(ifHave>0){
				//包含了
				System.out.println("这个邮箱已经包含了"+email+"....");
			}else{
				//不包含的话,插入
				System.out.println("这个邮箱未付过款"+email+"....");
				nowAddressList.add(email);
			}
		}
		
		cell.setCellValue("num");
	    cell = row.createCell(1);
		cell.setCellValue("添加支付信息未付款的Email");
	    cell = row.createCell(2);
	    
	    for (int i = 0; i < nowAddressList.size(); i++) {
	    	String addressEmail = nowAddressList.get(i);
	        row = sheet.createRow(i+1);
	        row.createCell(0).setCellValue(i+1);
	        row.createCell(1).setCellValue(addressEmail+"");
	    }
		try {
			OutputStream out =rep.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 下载UserEmail
	 * */
	@RequestMapping(value="/exportUserEmail",method=RequestMethod.GET)
	public void exportUserEmail(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		
		rep.setContentType("application/octet-stream");
		
		String nowTime = DateUtil.strTime14();
		rep.setHeader("Content-Disposition", "attachment;filename="+nowTime+"payinfoIf.xls");
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("sheet0");
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(0);
		
		//----------------------------------------------------------------------------
		List<String> successList = new ArrayList<String>();
		List<String> successNowList = new ArrayList<String>();
		List<String> successNowNowList = new ArrayList<String>();
		//1获取billingEmail-信息
		EmailPayPalRetuenSuccess emailPayPalRetuenSuccessReq = new EmailPayPalRetuenSuccess();
		List<EmailPayPalRetuenSuccess> billingEmailList= emailPayPalRetuenSuccessService.selectALl(emailPayPalRetuenSuccessReq);
		
		for(EmailPayPalRetuenSuccess billEmailOne :billingEmailList){
			successList.add(billEmailOne.getPayretuensuccessEmail());
			successNowList.add(billEmailOne.getPayretuensuccessEmail());
			successNowNowList.add(billEmailOne.getPayretuensuccessEmail());
		}
		//2获取-付款成功的Email-信息
		EmailPaySuccess emailPayPalSuccessReq = new EmailPaySuccess();
		List<EmailPaySuccess> paySuccessEmailList= emailPaySuccessService.selectALl(emailPayPalSuccessReq);
		System.out.println("paySuccessEmailList.size():"+paySuccessEmailList.size());
		//3遍历结算付款的,去billing中查询,如果查到-跳过.没查到-add进successList和临时的下一列中;
		for(EmailPaySuccess emailPaySuccessOne:paySuccessEmailList){
			Integer ifHave = 0;
			String email = emailPaySuccessOne.getPaysuccessEmail();
			ifHave = getIfIntoEmail(email,successNowList);
			if(ifHave>0){
				//包含了
				//System.out.println("这个邮箱已经包含了"+email+"....");
			}else{
				successList.add(email);
				successNowNowList.add(email);
			}
		}
		//4-successList这是//billingEmail+paySuccessEmail
		List<String> nowAddressList = new ArrayList<String>();
		//5-查询结算地址里的Email
		EmailAddress emailAddressReq = new EmailAddress();
		List<EmailAddress> emailAddressList= emailAddressService.selectALl(emailAddressReq);
		//System.out.println("emailAddressList.size():"+emailAddressList.size());
		
		List<EmailAddress> emailAddressNoRubbish1List = new ArrayList<EmailAddress>();
		List<EmailAddress> emailAddressNoRubbish2List = new ArrayList<EmailAddress>();
		
		//5.1-清理包含@的到垃圾
		for(EmailAddress emailAddressOne:emailAddressList){
			String oneEmail = emailAddressOne.getAddressemailEmail();
			if(oneEmail.contains("@")){
				//System.out.println("这是正确的邮箱格式");
				emailAddressNoRubbish1List.add(emailAddressOne);
			}
		}
		//5.2-清理包含qq的到垃圾
		for(EmailAddress emailAddressOne:emailAddressNoRubbish1List){
			String oneEmail = emailAddressOne.getAddressemailEmail();
			if(oneEmail.contains("qq.")){
				//System.out.println("这是谁的qq邮箱");
			}else{
				emailAddressNoRubbish2List.add(emailAddressOne);
			}
		}
		//6遍历清除垃圾后的地址信息emailList,去成功的里面比较,如果查到了,跳过.没查到-add进successList和付款返回+结算成功+结算未成功的集合
		for(EmailAddress emailAddressOne:emailAddressNoRubbish2List){
			Integer ifHave = 0;
			String email = emailAddressOne.getAddressemailEmail();
			ifHave = getIfIntoEmail(email,successList);
			if(ifHave>0){
				//包含了
				//System.out.println("这个邮箱已经包含了"+email+"....");
			}else{
				//不包含的话,插入
				//System.out.println("这个邮箱未付过款"+email+"....");
				nowAddressList.add(email);
				successNowNowList.add(email);
			}
		}
		//------------------------------------------------------------------------------
		//所有付款邮箱successList
		//所有结算地址邮箱邮箱nowAddressList
		//7查询user-Email
		EmailUser emailUserReq = new EmailUser();
		List<EmailUser> emailUserList= emailUserService.selectALl(emailUserReq);
		System.out.println("筛选前的emailUserList.size():"+emailUserList.size());
		
		List<String> emailUser1List = new ArrayList<String>();
		List<String> emailUser2List = new ArrayList<String>();
		
		//7.1-筛选出包含@的到email
		for(EmailUser emailUserOne:emailUserList){
			String oneEmail = emailUserOne.getUseremailEmail();
			if(oneEmail.contains("@")){
				//System.out.println("这是正确的邮箱格式");
				emailUser1List.add(oneEmail);
			}
		}
		//7.2-清理掉包含qq的到垃圾
		for(String emailOneString:emailUser1List){
			if(emailOneString.contains("qq.")){
				//System.out.println("这是谁的qq邮箱");
			}else{
				emailUser2List.add(emailOneString);
			}
		}
		List<String> userList = new ArrayList<String>();
		//8拿着user去付款返回+结算成功+结算未成功的集合successNowNowList中去比较
		for(String emailOneStr:emailUser2List){
			
			//String emailNow = emailUserOne.getUseremailEmail();
			Integer ifHave = 0;
			ifHave = getIfIntoEmail(emailOneStr,successNowNowList);
			if(ifHave>0){
				//包含了
				//System.out.println("这个邮箱已经包含了"+emailOneStr+"....");
			}else{
				//不包含的话,插入
				//System.out.println("这个邮箱未付过款"+emailOneStr+"....");
				userList.add(emailOneStr);
			}
		}
		//-------------------------------------------------------------------------------
		cell.setCellValue("num");
	    cell = row.createCell(1);
		cell.setCellValue("仅注册-未加购-未购买");
	    cell = row.createCell(2);
	    System.out.println("筛选出的userEmail的数量"+userList.size());
	    for (int i = 0; i < userList.size(); i++) {
	    	String userEmail = userList.get(i);
	        row = sheet.createRow(i+1);
	        row.createCell(0).setCellValue(i+1);
	        row.createCell(1).setCellValue(userEmail+"");
	    }
		try {
			OutputStream out =rep.getOutputStream();
			wb.write(out);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

}
