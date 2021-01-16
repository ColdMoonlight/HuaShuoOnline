package com.atguigu.controller.back;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.atguigu.bean.MlfrontCheckoutView;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.atguigu.service.MlfrontCheckoutViewService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlfrontCheckoutView")
public class MlfrontCheckoutViewController {
	
	@Autowired
	MlfrontCheckoutViewService mlfrontCheckoutViewService;
		
	/**
	 * 1.0	zsh200804
	 * toMlbackActShowPro列表页面
	 * @return jsp
	 * */
	@RequestMapping("/toMlfrontCheckoutViewPage")
	public String tologin(HttpSession session) throws Exception{
	
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute(Const.ADMIN_USER);
		if(mlbackAdmin==null){
			//mlbackAdmin对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/report/mlfrontCheckoutViewPage";
		}
	}
	
//	/**3.0	zsh200804
//	 * 分类MlbackActShowPro列表分页list数据
//	 * @param pn
//	 * @return
//	 */
//	@RequestMapping(value="/getAddCartViewDetailNumByTimeAndActnum",method=RequestMethod.POST)
//	@ResponseBody
//	public Msg getAddCartViewDetailNum(HttpSession session,@RequestBody MlfrontCheckoutView mlfrontCheckoutView) {
//		
//		String starttime = mlfrontCheckoutView.getAddcartviewdetailCreatetime();
//		String endtime = mlfrontCheckoutView.getAddcartviewdetailMotifytime();
//		Integer cartviewdetailActnum = mlfrontCheckoutView.getAddcartviewdetailActnum();
//		MlfrontCheckoutView mlfrontCheckoutViewreq = new MlfrontCheckoutView();
//		mlfrontCheckoutViewreq.setAddcartviewdetailCreatetime(starttime);
//		mlfrontCheckoutViewreq.setAddcartviewdetailMotifytime(endtime);
//		mlfrontCheckoutViewreq.setAddcartviewdetailActnum(cartviewdetailActnum);
//		List<MlfrontCheckoutView> mlfrontCheckoutViewList = mlfrontCheckoutViewService.selectMlfrontCheckoutViewByTimeAndActnum(mlfrontCheckoutViewreq);
//		Integer toDayNum = mlfrontCheckoutViewList.size();
//		return Msg.success().add("toDayNum", toDayNum);
//	}
	
	/**4.0	zsh200804
	 * 分类getAddCartViewDetailList列表list数据
	 * @param	MlfrontCheckoutView
	 * @return
	 */
	/**4.0	20200608
	 * MlbackCategory	update
	 * @param MlbackCategory
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlfrontCheckoutView mlfrontCheckoutView){
		//接受参数信息
		String nowTime = DateUtil.strTime14s();
		mlfrontCheckoutView.setCheckoutviewCreatetime(nowTime);
		mlfrontCheckoutView.setCheckoutviewMotifytime(nowTime);
		mlfrontCheckoutViewService.insertSelective(mlfrontCheckoutView);
		return Msg.success().add("resMsg", "category保存成功").add("mlfrontCheckoutView", mlfrontCheckoutView);
	}

}
