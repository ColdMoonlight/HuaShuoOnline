package com.atguigu.controller.back;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
//import com.atguigu.Vo.SortNumTh;
import com.atguigu.bean.MlbackAddCartViewDetail;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlbackAddCartViewDetailService;

@Controller
@RequestMapping("/MlbackAddCartViewDetail")
public class MlbackAddCartViewDetailController {
	
	@Autowired
	MlbackAddCartViewDetailService mlbackAddCartViewDetailService;
		
	/**
	 * 1.0	UseNow	0505
	 * toMlbackActShowPro列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toMlbackAddCartViewDetailPage")
	public String tologin(HttpSession session) throws Exception{
	
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackAddCartViewDetailPage";
		}
	}
	
	/**
	 * 1.1	UseNow	0505
	 * MlbackAddCartViewbuynowDetail列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toMlbackAddCartViewbuynowDetailPage")
	public String toMlbackAddCartViewbuynowDetailPage(HttpSession session) throws Exception{
	
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/mlbackAddCartViewbuynowDetailPage";
		}
	}
	
	
	/**2.0	UseNow	0505
	 * 分类MlbackActShowPro列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackAddCartViewDetailPage")
	@ResponseBody
	public Msg getMlbackAddCartViewDetailPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session,String starttime,String endtime) {
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("adminuser");
//		if(mlbackAdmin==null){
//			//SysUsers对象为空
//			return Msg.fail().add("resMsg", "session中adminuser对象为空");
//		}else{
			MlbackAddCartViewDetail mlbackAddCartViewDetailreq = new MlbackAddCartViewDetail();
			mlbackAddCartViewDetailreq.setAddcartviewdetailCreatetime(starttime);
			mlbackAddCartViewDetailreq.setAddcartviewdetailMotifytime(endtime);
			int PagNum = 20;
			PageHelper.startPage(pn, PagNum);
			List<MlbackAddCartViewDetail> mlbackAddCartList = mlbackAddCartViewDetailService.selectMlbackAddCartViewDetailByTimeAndActnum(mlbackAddCartViewDetailreq);
			PageInfo page = new PageInfo(mlbackAddCartList, PagNum);
			return Msg.success().add("pageInfo", page);
//		}
	}
	
//	
//	/**3.0	UseNow	0505
//	 * 分类MlbackActShowPro列表分页list数据
//	 * @param pn
//	 * @return
//	 */
//	@RequestMapping(value="/getAddCartViewDetailNum",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getAddCartViewDetailNum(HttpSession session,@RequestBody MlbackAddCartViewDetail mlbackAddCartViewDetail) {
//		
//		String starttime = mlbackAddCartViewDetail.getAddcartviewdetailCreatetime();
//		String endtime = mlbackAddCartViewDetail.getAddcartviewdetailEndtime();
//		MlbackAddCartViewDetail mlbackAddCartViewDetailreq = new MlbackAddCartViewDetail();
//		mlbackAddCartViewDetailreq.setAddcartviewdetailCreatetime(starttime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailEndtime(endtime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailActNum(0);
//		List<MlbackAddCartViewDetail> mlbackAddCartViewDetailList = mlbackAddCartViewDetailService.selectMlbackAddCartViewDetailByTime(mlbackAddCartViewDetailreq);
//		Integer toDayNum = mlbackAddCartViewDetailList.size();
//		return Msg.success().add("mlbackAddCartViewDetailList", mlbackAddCartViewDetailList).add("toDayNum", toDayNum);
//	}
//	
//	
//	/**4.0	UseNow	0505
//	 * 分类MlbackProductViewDetail列表list数据
//	 * @param
//	 * @return
//	 */
//	@RequestMapping(value="/getAddCartViewDetailList",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getAddCartViewDetailList(HttpSession session,@RequestBody MlbackAddCartViewDetail mlbackAddCartViewDetail) {
//		
//		String starttime = mlbackAddCartViewDetail.getAddcartviewdetailCreatetime();
//		String endtime = mlbackAddCartViewDetail.getAddcartviewdetailEndtime();
//		MlbackAddCartViewDetail mlbackAddCartViewDetailreq = new MlbackAddCartViewDetail();
//		mlbackAddCartViewDetailreq.setAddcartviewdetailStarttime(starttime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailEndtime(endtime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailActNum(0);	//用户行为，0纯加购	1点buyNow附带的加购
//		int PagNum = 20;
//		List<MlbackAddCartViewDetail> mlbackAddCartViewDetailList = mlbackAddCartViewDetailService.selectMlbackAddCartViewDetailByTime(mlbackAddCartViewDetailreq);
//		
//		String  proSeo = "";
//		Integer proSeoNum = 0;
//		Integer k=0;
//		List<Integer> numList = new ArrayList<Integer>();
//		List<String> SeoStringList = new ArrayList<String>();
//		
//		for(int i=0;i<mlbackAddCartViewDetailList.size();i++){
//			k++;
//			MlbackAddCartViewDetail mlbackAddCartViewDetailOne = mlbackAddCartViewDetailList.get(i);
//			if(proSeo.isEmpty()){
//				System.out.println("第一次来，都不记录");
//				proSeo = mlbackAddCartViewDetailOne.getAddcartviewdetailSeoname();
//				SeoStringList.add(proSeo);
//			}else{
//				proSeo = mlbackAddCartViewDetailOne.getAddcartviewdetailSeoname();
//				MlbackAddCartViewDetail mlbackAddCartViewDetailOneLast =mlbackAddCartViewDetailList.get(i-1);
//				String lastSeo = mlbackAddCartViewDetailOneLast.getAddcartviewdetailSeoname();
//				if(proSeo.equals(lastSeo)){
//					proSeoNum++;
//				}else{
//					SeoStringList.add(proSeo);
//					proSeoNum = k-1;
//					numList.add(proSeoNum);
//					k=1;
//				}
//			}
//		}
//		numList.add(k);
//		//封装对象
//		List<SortNumTh> SortNumThList = new ArrayList<SortNumTh>();
//		Integer lenth = SeoStringList.size();
//		SortNumTh[] arrayA = new SortNumTh[lenth];
//		for(int x=0;x<lenth;x++){
//			SortNumTh sortNumThOne = new SortNumTh();
//			String SeoString = SeoStringList.get(x);
//			Integer numCount = numList.get(x);
//			sortNumThOne.setSeoString(SeoString);
//			sortNumThOne.setSeoStringCount(numCount);
//			SortNumThList.add(sortNumThOne);
//			arrayA[x] = sortNumThOne;
//		}
//		//排序
//		for (int m = 0; m < arrayA.length - 1; m++) {				//外循环只需要比较arr.length-1次就可以了
//			for (int n = 0; n < arrayA.length - 1 - m; n++) {		//-1为了防止索引越界,-i为了提高效率
//				if(arrayA[n].getSeoStringCount() < arrayA[n+1].getSeoStringCount()) {
//					SortNumTh temp = arrayA[n];
//					arrayA[n] = arrayA[n + 1];
//					arrayA[n+1] = temp;
//				}
//			}
//		}
//		return Msg.success().add("SeoStringList", SeoStringList).add("numList", numList).add("arrayA", arrayA);
//	}
//	
//	/**5.0	UseNow	0505
//	 * 分类MlbackActShowPro列表分页list数据
//	 * @param pn
//	 * @return
//	 */
//	@RequestMapping(value="/getAddCartViewDetailBuyNowNum",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getAddCartViewDetailBuyNowNum(HttpSession session,@RequestBody MlbackAddCartViewDetail mlbackAddCartViewDetail) {
//		
//		String starttime = mlbackAddCartViewDetail.getAddcartviewdetailStarttime();
//		String endtime = mlbackAddCartViewDetail.getAddcartviewdetailEndtime();
//		MlbackAddCartViewDetail mlbackAddCartViewDetailreq = new MlbackAddCartViewDetail();
//		mlbackAddCartViewDetailreq.setAddcartviewdetailStarttime(starttime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailEndtime(endtime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailActNum(1);
//		List<MlbackAddCartViewDetail> mlbackAddCartViewDetailList = mlbackAddCartViewDetailService.selectMlbackAddCartViewDetailByTime(mlbackAddCartViewDetailreq);
//		Integer toDayNum = mlbackAddCartViewDetailList.size();
//		return Msg.success().add("mlbackAddCartViewDetailList", mlbackAddCartViewDetailList).add("toDayNum", toDayNum);
//	}
//	
//	
//	/**6.0	UseNow	0505
//	 * 分类MlbackProductViewDetail列表list数据
//	 * @param
//	 * @return
//	 */
//	@RequestMapping(value="/getAddCartViewDetailBuyNowList",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getAddCartViewDetailBuyNowList(HttpSession session,@RequestBody MlbackAddCartViewDetail mlbackAddCartViewDetail) {
//		
//		String starttime = mlbackAddCartViewDetail.getAddcartviewdetailStarttime();
//		String endtime = mlbackAddCartViewDetail.getAddcartviewdetailEndtime();
//		MlbackAddCartViewDetail mlbackAddCartViewDetailreq = new MlbackAddCartViewDetail();
//		mlbackAddCartViewDetailreq.setAddcartviewdetailStarttime(starttime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailEndtime(endtime);
//		mlbackAddCartViewDetailreq.setAddcartviewdetailActNum(1);	//用户行为，0纯加购	1点buyNow附带的加购
//		int PagNum = 20;
//		List<MlbackAddCartViewDetail> mlbackAddCartViewDetailList = mlbackAddCartViewDetailService.selectMlbackAddCartViewDetailByTime(mlbackAddCartViewDetailreq);
//		
//		String  proSeo = "";
//		Integer proSeoNum = 0;
//		Integer k=0;
//		List<Integer> numList = new ArrayList<Integer>();
//		List<String> SeoStringList = new ArrayList<String>();
//		
//		for(int i=0;i<mlbackAddCartViewDetailList.size();i++){
//			k++;
//			MlbackAddCartViewDetail mlbackAddCartViewDetailOne = mlbackAddCartViewDetailList.get(i);
//			if(proSeo.isEmpty()){
//				System.out.println("第一次来，都不记录");
//				proSeo = mlbackAddCartViewDetailOne.getAddcartviewdetailSeoname();
//				SeoStringList.add(proSeo);
//			}else{
//				proSeo = mlbackAddCartViewDetailOne.getAddcartviewdetailSeoname();
//				MlbackAddCartViewDetail mlbackAddCartViewDetailOneLast =mlbackAddCartViewDetailList.get(i-1);
//				String lastSeo = mlbackAddCartViewDetailOneLast.getAddcartviewdetailSeoname();
//				if(proSeo.equals(lastSeo)){
//					proSeoNum++;
//				}else{
//					SeoStringList.add(proSeo);
//					proSeoNum = k-1;
//					numList.add(proSeoNum);
//					k=1;
//				}
//			}
//		}
//		numList.add(k);
//		List<SortNumTh> SortNumThList = new ArrayList<SortNumTh>();
//		Integer lenth = SeoStringList.size();
//		SortNumTh[] arrayA = new SortNumTh[lenth];
//		for(int x=0;x<lenth;x++){
//			SortNumTh sortNumThOne = new SortNumTh();
//			String SeoString = SeoStringList.get(x);
//			Integer numCount = numList.get(x);
//			sortNumThOne.setSeoString(SeoString);
//			sortNumThOne.setSeoStringCount(numCount);
//			SortNumThList.add(sortNumThOne);
//			arrayA[x] = sortNumThOne;
//		}
//		//排序
//		for (int m = 0; m < arrayA.length - 1; m++) {				//外循环只需要比较arr.length-1次就可以了
//			for (int n = 0; n < arrayA.length - 1 - m; n++) {		//-1为了防止索引越界,-i为了提高效率
//				if(arrayA[n].getSeoStringCount() < arrayA[n+1].getSeoStringCount()) {
//					SortNumTh temp = arrayA[n];
//					arrayA[n] = arrayA[n + 1];
//					arrayA[n+1] = temp;
//				}
//			}
//		}
//		return Msg.success().add("SeoStringList", SeoStringList).add("numList", numList).add("arrayA", arrayA);
//	}

}
