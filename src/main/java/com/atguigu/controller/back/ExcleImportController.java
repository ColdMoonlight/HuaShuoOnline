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
import com.atguigu.bean.MlfrontReview;
import com.atguigu.service.DownPayCheckDateService;
import com.atguigu.service.MlfrontPayInfoService;
import com.atguigu.service.MlfrontReviewService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/excleImport")
public class ExcleImportController {
		
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	DownPayCheckDateService downPayCheckDateService;
	
	@Autowired
	MlfrontReviewService mlfrontReviewService;
	
	/**
	 * zsh 200730
	 * 中控台首页
	 * */
	@RequestMapping("/reviewsImportPage")
	public String reviewsImportPage(HttpSession session){
		
		return "back/product/excleintoPage";
	}
	
	/**
	 * 下载review模板
	 * */
	@RequestMapping(value="/exportReviewsImportDemo",method=RequestMethod.GET)
	public void exportReviewsImportDemo(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		
		rep.setContentType("application/octet-stream");
		String nowTime = DateUtil.strTime14();
		rep.setHeader("Content-Disposition", "attachment;filename="+nowTime+"reviewDemo.xls");
		
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet("sheet0");
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(0);
		
		cell.setCellValue("ReviewUname");
	    cell = row.createCell(1);
		cell.setCellValue("ReviewUimgurl");
	    cell = row.createCell(2);
	    cell.setCellValue("ReviewPid");
	    cell = row.createCell(3);
	    cell.setCellValue("ReviewCreatetime");
	    cell = row.createCell(4);
	    cell.setCellValue("ReviewMotifytime");
	    cell = row.createCell(5);
	    cell.setCellValue("ReviewPseoname");
	    cell = row.createCell(6);
	    cell.setCellValue("ReviewStatus");
	    cell = row.createCell(7);
	    cell.setCellValue("ReviewDetailstr");
	    cell = row.createCell(8);
	    cell.setCellValue("ReviewProstarnum");
	    cell = row.createCell(9);
	    cell.setCellValue("ReviewFrom");
	    cell = row.createCell(10);
	    
        row = sheet.createRow(1);
        row.createCell(0).setCellValue("MegaLookCustomer");//ReviewUname
        row.createCell(1).setCellValue("https://www.megalook.com/static/upload/img/ReviewUImg/M.png");//ReviewUimgurl
        row.createCell(2).setCellValue(252);//ReviewPid
        row.createCell(3).setCellValue("2019-07-02 15:23:43");//ReviewCreatetime
        row.createCell(4).setCellValue("2019-07-02 15:23:43");//ReviewMotifytime
        row.createCell(5).setCellValue("613-Color-13x4-Body-Wave-Lace-Wig");//ReviewPseoname
        row.createCell(6).setCellValue("0不展示/1展示");//ReviewStatus
        row.createCell(7).setCellValue("i like megalook's hair,very like");//ReviewDetailstr
        row.createCell(8).setCellValue("1/2/3/4/5星评论");//ReviewProstarnum
        row.createCell(9).setCellValue("0-self/1-customer/2-ins瀑布流/3-ins首页");//ReviewFrom
        
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
     * inportReviews
     * @param request
     * @param response
     */
	@RequestMapping(value="/inportReviews",method=RequestMethod.POST)
	public void inportReviews(@RequestParam(value = "file", required = false) MultipartFile multipartFile,HttpServletRequest request,HttpServletResponse response,HttpSession session){
		try {
			InputStream is = multipartFile.getInputStream();
			String nowTime = DateUtil.strTime14();
			if(is!=null){
				HSSFWorkbook wb = new HSSFWorkbook(is);
				List<MlfrontReview> reviewList = new ArrayList<MlfrontReview>();
				int rowCount = 0;
				try {
					HSSFSheet st = wb.getSheetAt(0);
					int rowNum = st.getLastRowNum(); //获取Excel最后一行索引，从零开始，所以获取到的是表中最后一行行数减一
					int colNum = st.getRow(0).getLastCellNum();//获取Excel列数
					for(int r=1;r<=rowNum;r++){//读取每一行，第一行为标题，从第二行开始
						rowCount = r;
						HSSFRow row = st.getRow(r);
						MlfrontReview reviewOne = new MlfrontReview();
						HSSFCell getCell = null;
						getCell = row.getCell(0);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewUname(getCell.getStringCellValue());
		                }
						getCell = row.getCell(1);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewUimgurl(getCell.getStringCellValue());
		                }
						getCell = row.getCell(2);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewPid(Integer.parseInt(getCell.getStringCellValue()));
		                }
						getCell = row.getCell(3);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewCreatetime(getCell.getStringCellValue());
		                }
						getCell = row.getCell(4);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewMotifytime(getCell.getStringCellValue());
		                    reviewOne.setReviewConfirmtime(nowTime);
		                    reviewOne.setReviewSupercateidstr("1");
		                }
						getCell = row.getCell(5);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewPseoname(getCell.getStringCellValue());
		                }
						getCell = row.getCell(6);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewStatus(Integer.parseInt(getCell.getStringCellValue()));
		                }
						getCell = row.getCell(7);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewDetailstr(getCell.getStringCellValue());
		                }
						getCell = row.getCell(8);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewProstarnum(Integer.parseInt(getCell.getStringCellValue()));
		                }
						getCell = row.getCell(9);
						if (getCell != null) {
		                    getCell.setCellType(HSSFCell.CELL_TYPE_STRING);
		                    reviewOne.setReviewFrom(Integer.parseInt(getCell.getStringCellValue()));
		                }
						System.out.println(reviewOne.toString());
						reviewList.add(reviewOne);
					}
					is.close();
					for(MlfrontReview mlfrontReview:reviewList){
						mlfrontReviewService.insertSelective(mlfrontReview);
						System.out.println("mlfrontReview.getReviewId():"+mlfrontReview.getReviewId());
					}
				}catch (Exception e) {
					System.out.println("第行出错");
					e.printStackTrace();
				}
			}
		}catch (Exception e) {
			System.out.println("第行出错");
			e.printStackTrace();
		}
	}
}
