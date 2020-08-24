package com.atguigu.controller.back;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import com.atguigu.bean.MlfrontReview;
import com.atguigu.service.DownPayCheckDateService;
import com.atguigu.service.MlfrontPayInfoService;

@Controller
@RequestMapping("/excleImport")
public class ExcleImportController {
		
	@Autowired
	MlfrontPayInfoService mlfrontPayInfoService;
	
	@Autowired
	DownPayCheckDateService downPayCheckDateService;
	
	/**
	 * zsh 200730
	 * 中控台首页
	 * */
	@RequestMapping("/reviewsImportPage")
	public String reviewsImportPage(HttpSession session){
		
		return "back/product/excleintoPage";
	}
	
	/**
     * 人员信息导入
     * @param conId
     * @param code
     * @param request
     * @param response
     */
	@RequestMapping(value="/inportReviews",method=RequestMethod.POST)
	public void insertReviews(Integer conId,String code,HttpServletRequest request,HttpServletResponse response,HttpSession session){
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile multipartFile = multipartRequest.getFile("files");
			InputStream is = multipartFile.getInputStream();
			if(is!=null){
				HSSFWorkbook wb = (HSSFWorkbook) WorkbookFactory.create(is);
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
						for(int l=0;l<colNum;l++){//读取每一行的每一列
							HSSFCell cell = row.getCell(l);
							reviewOne.setReviewConfirmtime(cell.getStringCellValue());
							reviewOne.setReviewCreatetime(cell.getStringCellValue());
							reviewOne.setReviewDetailstr(cell.getStringCellValue());
							reviewOne.setReviewFrom(Integer.parseInt(cell.getStringCellValue()));
							reviewOne.setReviewId(Integer.parseInt(cell.getStringCellValue()));
							reviewOne.setReviewImgidstr(cell.getStringCellValue());
							reviewOne.setReviewMotifytime(cell.getStringCellValue());
							reviewOne.setReviewPid(Integer.parseInt(cell.getStringCellValue()));
							reviewOne.setReviewPname(cell.getStringCellValue());
							reviewOne.setReviewProstarnum(Integer.parseInt(cell.getStringCellValue()));
							reviewOne.setReviewPseoname(cell.getStringCellValue());
							reviewOne.setReviewStatus(Integer.parseInt(cell.getStringCellValue()));
							reviewOne.setReviewSupercateidstr(cell.getStringCellValue());
							reviewOne.setReviewUid(Integer.parseInt(cell.getStringCellValue()));
							reviewOne.setReviewUimgurl(cell.getStringCellValue());
							reviewOne.setReviewUname(cell.getStringCellValue());
						}
						System.out.println(reviewOne.toString());
						reviewList.add(reviewOne);
					}
					is.close();
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
