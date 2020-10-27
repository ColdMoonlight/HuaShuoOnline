package com.atguigu.controller.back;

import java.io.IOException;
import java.io.InputStream;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import com.atguigu.bean.EmailAddress;
import com.atguigu.bean.EmailCheckUnPay;
import com.atguigu.bean.EmailPayAllsuccess;
import com.atguigu.bean.EmailPayPalRetuenSuccess;
import com.atguigu.bean.EmailPaySuccess;
import com.atguigu.bean.EmailUser;
import com.atguigu.service.DownPayCheckDateService;
import com.atguigu.service.EmailAddressService;
import com.atguigu.service.EmailPayAllsuccessService;
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
	EmailPaySuccessService emailPaySuccessService;//
	
	@Autowired
	EmailPayPalRetuenSuccessService emailPayPalRetuenSuccessService;
	
	@Autowired
	EmailAddressService emailAddressService;
	
	@Autowired
	EmailUserService emailUserService;
	
	@Autowired
	EmailPayAllsuccessService emailPayAllsuccessService;
	
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
		
		//billingEmail
		EmailPayPalRetuenSuccess emailPayPalRetuenSuccessReq = new EmailPayPalRetuenSuccess();
		List<EmailPayPalRetuenSuccess> billingEmailList= emailPayPalRetuenSuccessService.selectALl(emailPayPalRetuenSuccessReq);
		
		//付款Email
		EmailPaySuccess emailPayPalSuccessReq = new EmailPaySuccess();
		List<EmailPaySuccess> paySuccessEmailList= emailPaySuccessService.selectALl(emailPayPalSuccessReq);
		System.out.println("paySuccessEmailList.size():"+paySuccessEmailList.size());
		
		//遍历结算付款的,去billing中查询,如果查到-跳过.没查到-add进billingList中;
		for(EmailPaySuccess emailPaySuccessOne:paySuccessEmailList){
			
			//挨个去PayInfo的表中去查询如果存在-跳过,不存在-add进billingList
			String email = emailPaySuccessOne.getPaysuccessEmail();
			EmailPayPalRetuenSuccess emailPayPalRetuenSuccessCheckReq = new EmailPayPalRetuenSuccess();
			emailPayPalRetuenSuccessCheckReq.setPayretuensuccessEmail(email);
			//去查询
			List<EmailPayPalRetuenSuccess> emailPayPalRetuenSuccessCheckList = emailPayPalRetuenSuccessService.selectByEmail(emailPayPalRetuenSuccessCheckReq);
			if(emailPayPalRetuenSuccessCheckList.size()>0){
				//存在-跳过
				System.out.println("已经有了.不走插入,直接跳过");
			}else{
				//不存在-add进billingList
				EmailPayPalRetuenSuccess NewOneEmailPayPalRetuenSuccess = new EmailPayPalRetuenSuccess();
				NewOneEmailPayPalRetuenSuccess.setPayretuensuccessEmail(email);
				billingEmailList.add(NewOneEmailPayPalRetuenSuccess);
				System.out.println("Email:"+email);
			}
		}
		
		cell.setCellValue("num");
	    cell = row.createCell(1);
		cell.setCellValue("billingEmail");
	    cell = row.createCell(2);
	    
	    EmailPayPalRetuenSuccess billOne = new EmailPayPalRetuenSuccess();
	    for (int i = 0; i < billingEmailList.size(); i++) {
	    	billOne = billingEmailList.get(i);
	        row = sheet.createRow(i+1);
	        row.createCell(0).setCellValue(i+1);
	        row.createCell(1).setCellValue(billOne.getPayretuensuccessEmail()+"");
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
	 * 下载付款结算的Email
	 * */
	@RequestMapping(value="/exportAddressEmail",method=RequestMethod.GET)
	public void exportAddressEmail(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		
		rep.setContentType("application/octet-stream");
		String nowTime = DateUtil.strTime14();
		rep.setHeader("Content-Disposition", "attachment;filename="+nowTime+"tryToPay.xls");
		
		HSSFWorkbook wb = new HSSFWorkbook();
		
		HSSFSheet sheet = wb.createSheet("sheet0");
		
		HSSFRow row = sheet.createRow(0);
		
		HSSFCell cell = row.createCell(0);
		
		//billingEmail
		EmailPayPalRetuenSuccess emailPayPalRetuenSuccessReq = new EmailPayPalRetuenSuccess();
		List<EmailPayPalRetuenSuccess> billingEmailList= emailPayPalRetuenSuccessService.selectALl(emailPayPalRetuenSuccessReq);
		
		//付款Email
		EmailPaySuccess emailPayPalSuccessReq = new EmailPaySuccess();
		List<EmailPaySuccess> paySuccessEmailList= emailPaySuccessService.selectALl(emailPayPalSuccessReq);
		System.out.println("paySuccessEmailList.size():"+paySuccessEmailList.size());
		
		//遍历结算付款的,去billing中查询,如果查到-跳过.没查到-add进billingList中;
		for(EmailPaySuccess emailPaySuccessOne:paySuccessEmailList){
			
			//挨个去PayInfo的表中去查询如果存在-跳过,不存在-add进billingList
			String email = emailPaySuccessOne.getPaysuccessEmail();
			EmailPayPalRetuenSuccess emailPayPalRetuenSuccessCheckReq = new EmailPayPalRetuenSuccess();
			emailPayPalRetuenSuccessCheckReq.setPayretuensuccessEmail(email);
			//去查询
			List<EmailPayPalRetuenSuccess> emailPayPalRetuenSuccessCheckList = emailPayPalRetuenSuccessService.selectByEmail(emailPayPalRetuenSuccessCheckReq);
			if(emailPayPalRetuenSuccessCheckList.size()>0){
				//存在-跳过
				//System.out.println("已经有了.不走插入,直接跳过");
			}else{
				//不存在-add进billingList
				EmailPayPalRetuenSuccess NewOneEmailPayPalRetuenSuccess = new EmailPayPalRetuenSuccess();
				NewOneEmailPayPalRetuenSuccess.setPayretuensuccessEmail(email);
				billingEmailList.add(NewOneEmailPayPalRetuenSuccess);
				//System.out.println("Email:"+email);
			}
		}
		//----------------------------此时billingEmailList是全部付款客户-----------------------------------
		//把这个插入EmailPayAllsuccess表中
		for(EmailPayPalRetuenSuccess emailOne:billingEmailList){
			
			EmailPayAllsuccess emailPayAllsuccessReq = new EmailPayAllsuccess();
			emailPayAllsuccessReq.setPayallsuccessEmail(emailOne.getPayretuensuccessEmail());
			emailPayAllsuccessService.insertSelective(emailPayAllsuccessReq);
			//遍历完毕入库了
		}
		
		//查询结算地址里的Email
		EmailAddress emailAddressReq = new EmailAddress();
		List<EmailAddress> emailAddressList= emailAddressService.selectALl(emailAddressReq);
		System.out.println("emailAddressList.size():"+emailAddressList.size());
		
		
		List<EmailCheckUnPay> emailCheckUnPayList= new ArrayList<EmailCheckUnPay>();
		//遍历结算地址-去billing中查询,如果查到-跳过.没查到-add进billingList中;
		for(EmailAddress emailAddressOne:emailAddressList){
			
			//挨个去PayInfo的表中去查询如果存在-跳过,不存在-add进billingList
			String email = emailAddressOne.getAddressemailEmail();
			EmailPayAllsuccess emailPayAllsuccessReq = new EmailPayAllsuccess();
			emailPayAllsuccessReq.setPayallsuccessEmail(email);
			//去查询
			List<EmailPayAllsuccess> emailPayAllsuccessList = emailPayAllsuccessService.selectByEmail(emailPayAllsuccessReq);
			if(emailPayAllsuccessList.size()>0){
				//存在-跳过
				//System.out.println("已经有了.不走插入,直接跳过");
			}else{
				//不存在-add进billingList
				EmailCheckUnPay emailCheckUnPayOne = new EmailCheckUnPay();
				emailCheckUnPayOne.setCheckunpayEmail(email);
				emailCheckUnPayList.add(emailCheckUnPayOne);
				//System.out.println("Email:"+email);
			}
		}
		
		//--------------------
		
		cell.setCellValue("num");
	    cell = row.createCell(1);
		cell.setCellValue("添加支付信息未付款的Email");
	    cell = row.createCell(2);
	    
	    EmailCheckUnPay emailCheckUnPayOne = new EmailCheckUnPay();
	    for (int i = 0; i < emailCheckUnPayList.size(); i++) {
	    	emailCheckUnPayOne = emailCheckUnPayList.get(i);
	        row = sheet.createRow(i+1);
	        row.createCell(0).setCellValue(i+1);
	        row.createCell(1).setCellValue(emailCheckUnPayOne.getCheckunpayEmail()+"");
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
		
		EmailPayPalRetuenSuccess emailPayPalRetuenSuccessReq = new EmailPayPalRetuenSuccess();
		List<EmailPayPalRetuenSuccess> billingEmailList= emailPayPalRetuenSuccessService.selectALl(emailPayPalRetuenSuccessReq);
		System.out.println("billingEmailList.size():"+billingEmailList.size());
		
		cell.setCellValue("num");
	    cell = row.createCell(1);
		cell.setCellValue("billingEmail");
	    cell = row.createCell(2);
	    
	    EmailPayPalRetuenSuccess billOne = new EmailPayPalRetuenSuccess();
	    for (int i = 0; i < billingEmailList.size(); i++) {
	    	billOne = billingEmailList.get(i);
	        row = sheet.createRow(i+1);
	        row.createCell(0).setCellValue(i+1);
	        row.createCell(1).setCellValue(billOne.getPayretuensuccessEmail()+"");
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
	
//	/**1.1.1导入pay关联的emial表中
//     * inportPaySuccessEmail
//     * @param request
//     * @param response
//     */
//	@RequestMapping(value="/inportPaySuccessEmail",method=RequestMethod.POST)
//	public void inportPaySuccessEmail(@RequestParam(value = "file", required = false) MultipartFile multipartFile,HttpServletRequest request,
//			HttpServletResponse response,HttpSession session){
//		try {
//			InputStream is = multipartFile.getInputStream();
//			String nowTime = DateUtil.strTime14();
//			if(is!=null){
//				HSSFWorkbook wb = new HSSFWorkbook(is);
//				List<EmailPaySuccess> emailPaySuccessList = new ArrayList<EmailPaySuccess>();
//				int rowCount = 0;
//				try {
//					HSSFSheet st = wb.getSheetAt(0);
//					int rowNum = st.getLastRowNum(); //获取Excel最后一行索引，从零开始，所以获取到的是表中最后一行行数减一
//					int colNum = st.getRow(0).getLastCellNum();//获取Excel列数
//					for(int r=1;r<=rowNum;r++){//读取每一行，第一行为标题，从第二行开始
//						rowCount = r;
//						HSSFRow row = st.getRow(r);
//						EmailPaySuccess emailPaySuccessOne = new EmailPaySuccess();
//						HSSFCell getCell = null;
//						getCell = row.getCell(0);
//						if (getCell != null) {
//		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
//		                    emailPaySuccessOne.setPaysuccessEmail(getCell.getStringCellValue());
//		                }
//						emailPaySuccessList.add(emailPaySuccessOne);
//					}
//					is.close();
//					for(EmailPaySuccess emailPaySuccessOne:emailPaySuccessList){
//						emailPaySuccessService.insertSelective(emailPaySuccessOne);
//						System.out.println("emailPaySuccessOne.getId():"+emailPaySuccessOne.getPaysuccessId());
//					}
//				}catch (Exception e) {
//					System.out.println("第行出错");
//					e.printStackTrace();
//				}
//			}
//		}catch (Exception e) {
//			System.out.println("第行出错");
//			e.printStackTrace();
//		}
//	}
//	
//	/**1.1.2导入payReturn的BillingEmial表中
//     * inportPayPalReturnSuccessEmail
//     * @param request
//     * @param response
//     */
//	@RequestMapping(value="/inportPayPalReturnSuccessEmail",method=RequestMethod.POST)
//	public void inportPayPalReturnSuccessEmail(@RequestParam(value = "file", required = false) MultipartFile multipartFile,HttpServletRequest request,
//			HttpServletResponse response,HttpSession session){
//		try {
//			InputStream is = multipartFile.getInputStream();
//			String nowTime = DateUtil.strTime14();
//			if(is!=null){
//				HSSFWorkbook wb = new HSSFWorkbook(is);
//				List<EmailPayPalRetuenSuccess> emailPayPalRetuenSuccessList = new ArrayList<EmailPayPalRetuenSuccess>();
//				int rowCount = 0;
//				try {
//					HSSFSheet st = wb.getSheetAt(0);
//					int rowNum = st.getLastRowNum(); //获取Excel最后一行索引,从零开始，所以获取到的是表中最后一行行数减一
//					int colNum = st.getRow(0).getLastCellNum();//获取Excel列数
//					for(int r=1;r<=rowNum;r++){//读取每一行,第一行为标题,从第二行开始
//						rowCount = r;
//						HSSFRow row = st.getRow(r);
//						EmailPayPalRetuenSuccess emailPayPalRetuenSuccessOne = new EmailPayPalRetuenSuccess();
//						HSSFCell getCell = null;
//						getCell = row.getCell(0);
//						if (getCell != null) {
//		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
//		                    emailPayPalRetuenSuccessOne.setPayretuensuccessEmail(getCell.getStringCellValue());
//		                }
//						emailPayPalRetuenSuccessList.add(emailPayPalRetuenSuccessOne);
//					}
//					is.close();
//					for(EmailPayPalRetuenSuccess emailPayPalRetuenOne:emailPayPalRetuenSuccessList){
//						
//						//挨个去PayInfo的表中去查询如果存在-跳过,不存在-insert
//						String email = emailPayPalRetuenOne.getPayretuensuccessEmail();
//						
//						EmailPaySuccess emailPaySuccessReq = new EmailPaySuccess();
//						emailPaySuccessReq.setPaysuccessEmail(email);
//						List<EmailPaySuccess> emailPaySuccessList = emailPaySuccessService.selectByEmail(emailPaySuccessReq);
//						if(emailPaySuccessList.size()>0){
//							System.out.println("已经有了.不走插入,直接跳过");
//						}else{
//							emailPayPalRetuenSuccessService.insertSelective(emailPayPalRetuenOne);
//							System.out.println("emailPaySuccessOne.getId():"+emailPayPalRetuenOne.getPayretuensuccessId()+",Email:"+emailPayPalRetuenOne.getPayretuensuccessEmail());
//						}
//					}
//				}catch (Exception e) {
//					System.out.println("第行出错");
//					e.printStackTrace();
//				}
//			}
//		}catch (Exception e) {
//			System.out.println("第行出错");
//			e.printStackTrace();
//		}
//	}
//	
//	/**1.1.3地址Email
//     * inportPayPalReturnSuccessEmail
//     * @param request
//     * @param response
//     */
//	@RequestMapping(value="/inportPayAddressEmail",method=RequestMethod.POST)
//	public void inportPayAddressEmail(@RequestParam(value = "file", required = false) MultipartFile multipartFile,HttpServletRequest request,
//			HttpServletResponse response,HttpSession session){
//		try {
//			InputStream is = multipartFile.getInputStream();
//			String nowTime = DateUtil.strTime14();
//			if(is!=null){
//				HSSFWorkbook wb = new HSSFWorkbook(is);
//				List<EmailAddress> emailAddressList = new ArrayList<EmailAddress>();
//				int rowCount = 0;
//				try {
//					HSSFSheet st = wb.getSheetAt(0);
//					int rowNum = st.getLastRowNum(); //获取Excel最后一行索引,从零开始，所以获取到的是表中最后一行行数减一
//					int colNum = st.getRow(0).getLastCellNum();//获取Excel列数
//					for(int r=1;r<=rowNum;r++){//读取每一行,第一行为标题,从第二行开始
//						rowCount = r;
//						HSSFRow row = st.getRow(r);
//						EmailAddress emailAddressOne = new EmailAddress();
//						HSSFCell getCell = null;
//						getCell = row.getCell(0);
//						if (getCell != null) {
//		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
//		                    emailAddressOne.setAddressemailEmail(getCell.getStringCellValue());
//		                }
//						emailAddressList.add(emailAddressOne);
//					}
//					is.close();
//					for(EmailAddress emailAddressOne:emailAddressList){
//						emailAddressService.insertSelective(emailAddressOne);
//						System.out.println("emailAddressOne.getId():"+emailAddressOne.getAddressemailId());
//					}
//				}catch (Exception e) {
//					System.out.println("第行出错");
//					e.printStackTrace();
//				}
//			}
//		}catch (Exception e) {
//			System.out.println("第行出错");
//			e.printStackTrace();
//		}
//	}
//	/**1.1.4导入UserEmail
//     * inportPayPalReturnSuccessEmail
//     * @param request
//     * @param response
//     */
//	@RequestMapping(value="/inportPayUserEmail",method=RequestMethod.POST)
//	public void inportPayUserEmail(@RequestParam(value = "file", required = false) MultipartFile multipartFile,HttpServletRequest request,
//			HttpServletResponse response,HttpSession session){
//		try {
//			InputStream is = multipartFile.getInputStream();
//			String nowTime = DateUtil.strTime14();
//			if(is!=null){
//				HSSFWorkbook wb = new HSSFWorkbook(is);
//				List<EmailUser> emailUserList = new ArrayList<EmailUser>();
//				int rowCount = 0;
//				try {
//					HSSFSheet st = wb.getSheetAt(0);
//					int rowNum = st.getLastRowNum(); //获取Excel最后一行索引,从零开始，所以获取到的是表中最后一行行数减一
//					int colNum = st.getRow(0).getLastCellNum();//获取Excel列数
//					for(int r=1;r<=rowNum;r++){//读取每一行,第一行为标题,从第二行开始
//						rowCount = r;
//						HSSFRow row = st.getRow(r);
//						EmailUser emailUserOne = new EmailUser();
//						HSSFCell getCell = null;
//						getCell = row.getCell(0);
//						if (getCell != null) {
//		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
//		                    emailUserOne.setUseremailEmail(getCell.getStringCellValue());
//		                }
//						emailUserList.add(emailUserOne);
//					}
//					is.close();
//					for(EmailUser emailUserOne:emailUserList){
//						emailUserService.insertSelective(emailUserOne);
//						System.out.println("emailUserOne.getId():"+emailUserOne.getUseremailId());
//					}
//				}catch (Exception e) {
//					System.out.println("第行出错");
//					e.printStackTrace();
//				}
//			}
//		}catch (Exception e) {
//			System.out.println("第行出错");
//			e.printStackTrace();
//		}
//	}
}
