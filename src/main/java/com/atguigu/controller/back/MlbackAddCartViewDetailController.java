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
import com.atguigu.bean.MlbackAddCartViewDetail;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackAddCartViewDetailService;
import com.atguigu.vo.SortNumTh;

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
			return "back/report/mlbackAddCartViewDetailPage";
		}
	}
	
	/**3.0	UseNow	0505
	 * 分类MlbackActShowPro列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getAddCartViewDetailNumByTimeAndActnum",method=RequestMethod.POST)
	@ResponseBody
	public Msg getAddCartViewDetailNum(HttpSession session,@RequestBody MlbackAddCartViewDetail mlbackAddCartViewDetail) {
		
		String starttime = mlbackAddCartViewDetail.getAddcartviewdetailCreatetime();
		String endtime = mlbackAddCartViewDetail.getAddcartviewdetailMotifytime();
		Integer cartviewdetailActnum = mlbackAddCartViewDetail.getAddcartviewdetailActnum();
		MlbackAddCartViewDetail mlbackAddCartViewDetailreq = new MlbackAddCartViewDetail();
		mlbackAddCartViewDetailreq.setAddcartviewdetailCreatetime(starttime);
		mlbackAddCartViewDetailreq.setAddcartviewdetailMotifytime(endtime);
		mlbackAddCartViewDetailreq.setAddcartviewdetailActnum(cartviewdetailActnum);
		List<MlbackAddCartViewDetail> mlbackAddCartViewDetailList = mlbackAddCartViewDetailService.selectMlbackAddCartViewDetailByTimeAndActnum(mlbackAddCartViewDetailreq);
		Integer toDayNum = mlbackAddCartViewDetailList.size();
		return Msg.success().add("toDayNum", toDayNum);
	}
	
	/**4.0	UseNow	0505
	 * 分类MlbackProductViewDetail列表list数据
	 * @param
	 * @return
	 */
	@RequestMapping(value="/getAddCartViewDetailList",method=RequestMethod.POST)
	@ResponseBody
	public Msg getAddCartViewDetailList(HttpSession session,@RequestBody MlbackAddCartViewDetail mlbackAddCartViewDetail) {
		
		String starttime = mlbackAddCartViewDetail.getAddcartviewdetailCreatetime();
		String endtime = mlbackAddCartViewDetail.getAddcartviewdetailMotifytime();
		Integer cartviewdetailActnum = mlbackAddCartViewDetail.getAddcartviewdetailActnum();
		MlbackAddCartViewDetail mlbackAddCartViewDetailreq = new MlbackAddCartViewDetail();
		mlbackAddCartViewDetailreq.setAddcartviewdetailCreatetime(starttime);
		mlbackAddCartViewDetailreq.setAddcartviewdetailMotifytime(endtime);
		mlbackAddCartViewDetailreq.setAddcartviewdetailActnum(cartviewdetailActnum);	//用户行为，0纯加购	1点buyNow附带的加购
		
		List<MlbackAddCartViewDetail> mlbackAddCartViewDetailList = mlbackAddCartViewDetailService.selectMlbackAddCartViewDetailByTimeAndActnum(mlbackAddCartViewDetailreq);
		
		String  proSeo = "";
		Integer proSeoNum = 0;
		Integer k=0;
		List<Integer> numList = new ArrayList<Integer>();
		List<String> SeoStringList = new ArrayList<String>();
		
		for(int i=0;i<mlbackAddCartViewDetailList.size();i++){
			k++;
			MlbackAddCartViewDetail mlbackAddCartViewDetailOne = mlbackAddCartViewDetailList.get(i);
			if(proSeo.isEmpty()){
				System.out.println("第一次来，都不记录");
				proSeo = mlbackAddCartViewDetailOne.getAddcartviewdetailProseo();
				SeoStringList.add(proSeo);
			}else{
				proSeo = mlbackAddCartViewDetailOne.getAddcartviewdetailProseo();
				MlbackAddCartViewDetail mlbackAddCartViewDetailOneLast =mlbackAddCartViewDetailList.get(i-1);
				String lastSeo = mlbackAddCartViewDetailOneLast.getAddcartviewdetailProseo();
				if(proSeo.equals(lastSeo)){
					proSeoNum++;
				}else{
					SeoStringList.add(proSeo);
					proSeoNum = k-1;
					numList.add(proSeoNum);
					k=1;
				}
			}
		}
		numList.add(k);
		//封装对象
		List<SortNumTh> SortNumThList = new ArrayList<SortNumTh>();
		Integer lenth = SeoStringList.size();
		SortNumTh[] arrayA = new SortNumTh[lenth];
		for(int x=0;x<lenth;x++){
			SortNumTh sortNumThOne = new SortNumTh();
			String SeoString = SeoStringList.get(x);
			Integer numCount = numList.get(x);
			sortNumThOne.setSeoString(SeoString);
			sortNumThOne.setSeoStringCount(numCount);
			SortNumThList.add(sortNumThOne);
			arrayA[x] = sortNumThOne;
		}
		//排序
		for (int m = 0; m < arrayA.length - 1; m++) {				//外循环只需要比较arr.length-1次就可以了
			for (int n = 0; n < arrayA.length - 1 - m; n++) {		//-1为了防止索引越界,-i为了提高效率
				if(arrayA[n].getSeoStringCount() < arrayA[n+1].getSeoStringCount()) {
					SortNumTh temp = arrayA[n];
					arrayA[n] = arrayA[n + 1];
					arrayA[n+1] = temp;
				}
			}
		}
		return Msg.success().add("SeoStringList", SeoStringList).add("numList", numList).add("arrayA", arrayA);
	}
}
