package com.atguigu.controller.back;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.atguigu.bean.MlbackAddCheakoutViewDetail;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackAddCheakoutViewDetailService;
//import com.atguigu.vo.SortNumTh;

@Controller
@RequestMapping("/MlbackAddCheakoutViewDetail")
public class MlbackAddCheakoutViewDetailController {
	
	@Autowired
	MlbackAddCheakoutViewDetailService mlbackAddCheakoutViewDetailService;
		
	/**
	 * 1.0	zsh200804
	 * toMlbackActShowPro列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toMlbackAddCheakoutViewDetailPage")
	public String tologin(HttpSession session) throws Exception{
	
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("AdminUser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/report/mlbackAddCheakoutViewDetailPage";
		}
	}

	/**3.0	zsh200804
	 * 计数MlbackAddCheakoutViewDetailByTime
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getAddCheakoutViewDetailNum",method=RequestMethod.POST)
	@ResponseBody
	public Msg getAddCheakoutViewDetailNum(HttpSession session,@RequestBody MlbackAddCheakoutViewDetail mlbackAddCheakoutViewDetail) {
		
		String starttime = mlbackAddCheakoutViewDetail.getAddcheakoutviewdetailCreatetime();
		String endtime = mlbackAddCheakoutViewDetail.getAddcheakoutviewdetailMotifytime();
		Integer actnum = mlbackAddCheakoutViewDetail.getAddcheakoutviewdetailActnum();
		MlbackAddCheakoutViewDetail mlbackAddCheakoutViewDetailreq = new MlbackAddCheakoutViewDetail();
		mlbackAddCheakoutViewDetailreq.setAddcheakoutviewdetailCreatetime(starttime);
		mlbackAddCheakoutViewDetailreq.setAddcheakoutviewdetailMotifytime(endtime);
		mlbackAddCheakoutViewDetailreq.setAddcheakoutviewdetailActnum(actnum);
		List<MlbackAddCheakoutViewDetail> mlbackAddCheakoutViewDetailList = mlbackAddCheakoutViewDetailService.selectMlbackAddCheakoutViewDetailByTimeAndActnum(mlbackAddCheakoutViewDetailreq);
		Integer toDayNum = mlbackAddCheakoutViewDetailList.size();
		return Msg.success().add("toDayNum", toDayNum);
	}
	
	
//	/**4.0	zsh200804
//	 * 分类MlbackProductViewDetail列表list数据
//	 * @param
//	 * @return
//	 */
//	@RequestMapping(value="/getAddCheakoutViewDetailList",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getAddCheakoutViewDetailList(HttpSession session,@RequestBody MlbackAddCheakoutViewDetail mlbackAddCheakoutViewDetail) {
//		
//		String starttime = mlbackAddCheakoutViewDetail.getAddcheakoutviewdetailCreatetime();
//		String endtime = mlbackAddCheakoutViewDetail.getAddcheakoutviewdetailMotifytime();
//		Integer actnum = mlbackAddCheakoutViewDetail.getAddcheakoutviewdetailActnum();
//		MlbackAddCheakoutViewDetail mlbackAddCheakoutViewDetailreq = new MlbackAddCheakoutViewDetail();
//		mlbackAddCheakoutViewDetailreq.setAddcheakoutviewdetailCreatetime(starttime);
//		mlbackAddCheakoutViewDetailreq.setAddcheakoutviewdetailMotifytime(endtime);
//		mlbackAddCheakoutViewDetailreq.setAddcheakoutviewdetailActnum(actnum);	//用户行为，0纯加购	1点buyNow附带的加购
//		
//		List<MlbackAddCheakoutViewDetail> mlbackAddCheakoutViewDetailList = mlbackAddCheakoutViewDetailService.selectMlbackAddCheakoutViewDetailByTimeAndActnum(mlbackAddCheakoutViewDetailreq);
//		
//		String  proSeo = "";
//		Integer proSeoNum = 0;
//		Integer k=0;
//		List<Integer> numList = new ArrayList<Integer>();
//		List<String> SeoStringList = new ArrayList<String>();
//		
//		for(int i=0;i<mlbackAddCheakoutViewDetailList.size();i++){
//			k++;
//			MlbackAddCheakoutViewDetail mlbackAddCheakoutViewDetailOne = mlbackAddCheakoutViewDetailList.get(i);
//			if(proSeo.isEmpty()){
//				System.out.println("第一次来，都不记录");
//				proSeo = mlbackAddCheakoutViewDetailOne.getAddcheakoutviewdetailProseo();
//				SeoStringList.add(proSeo);
//			}else{
//				proSeo = mlbackAddCheakoutViewDetailOne.getAddcheakoutviewdetailProseo();
//				MlbackAddCheakoutViewDetail mlbackAddCheakoutViewDetailOneLast =mlbackAddCheakoutViewDetailList.get(i-1);
//				String lastSeo = mlbackAddCheakoutViewDetailOneLast.getAddcheakoutviewdetailProseo();
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
