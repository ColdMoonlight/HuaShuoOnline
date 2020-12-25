package com.atguigu.controller.back;

import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.atguigu.bean.CouponAnalysisDate;
import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlbackCoupon;
import com.atguigu.bean.MlbackSearch;
import com.atguigu.bean.MlfrontUser;
import com.atguigu.bean.UrlCount;
import com.atguigu.common.Msg;
import com.atguigu.service.CouponAnalysisDateService;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackCouponService;
import com.atguigu.service.MlbackProductService;
import com.atguigu.service.MlfrontUserService;
import com.atguigu.service.UrlCountService;
import com.atguigu.utils.DateUtil;
import com.atguigu.utils.LuckDrawUtils;
import com.atguigu.vo.LuckDrawDate;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/MlbackCoupon")
public class MlbackCouponController {
		
	@Autowired
	MlbackCouponService mlbackCouponService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	@Autowired
	MlfrontUserService mlfrontUserService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	@Autowired
	UrlCountService urlCountService;
	
	@Autowired
	CouponAnalysisDateService couponAnalysisDateService;
	
	/**
	 * 1.0	zsh	1225
	 * to分类MlbackCoupon列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toMlbackCouponPage")
	public String toMlbackCouponPage(HttpSession session) throws Exception{
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("adminuser");
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/operate/mlbackCouponPage";
		}
	}
	
	/**2.0	useOn	0505
	 * 分类MlbackCoupon列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackCouponByPage")
	@ResponseBody
	public Msg getMlbackCouponByPage(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute("adminuser");
//		if(mlbackAdmin==null){
//			//SysUsers对象为空
//			return Msg.fail().add("resMsg", "session中adminuser对象为空");
//		}else{
			int PagNum = 20;
			PageHelper.startPage(pn, PagNum);
			List<MlbackCoupon> mlbackCouponList = mlbackCouponService.selectMlbackCouponGetAll();
			PageInfo page = new PageInfo(mlbackCouponList, PagNum);
			return Msg.success().add("pageInfo", page);
//		}
	}
	
	/**3.0	20200608
	 * MlbackProduct	initializaCategory
	 * @param MlbackProduct
	 * @return
	 */
	@RequestMapping(value="/initializaCoupon",method=RequestMethod.POST)
	@ResponseBody
	public Msg initializaCoupon(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackCoupon mlbackCoupon = new MlbackCoupon();
		//取出id
		String nowTime = DateUtil.strTime14s();
		mlbackCoupon.setCouponCreatetime(nowTime);
		mlbackCoupon.setCouponProductonlyType(0);
		mlbackCoupon.setCouponProductonlyPidstr("");
		//无id,insert
		System.out.println("插入前"+mlbackCoupon.toString());
		mlbackCouponService.insertSelective(mlbackCoupon);
		System.out.println("插入后"+mlbackCoupon.toString());
		return Msg.success().add("resMsg", "Coupon初始化成功").add("mlbackCoupon", mlbackCoupon);
	}
	
	/**3.1	useOn	0505
	 * MlbackCoupon	insert
	 * @param MlbackCoupon
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackCoupon mlbackCoupon){
		//接受参数信息
		//System.out.println("mlbackCoupon:"+mlbackCoupon);
		String nowTime = DateUtil.strTime14s();
		mlbackCoupon.setCouponMotifytime(nowTime);
		//取出是否绑定单品字段
		Integer couponProductOnlyType = mlbackCoupon.getCouponProductonlyType();
		
		if(couponProductOnlyType==null){
			mlbackCoupon.setCouponProductonlyType(0);
		}
		if(couponProductOnlyType==0){
			mlbackCoupon.setCouponProductonlyPidstr("");
		}
		//有id,update
		mlbackCouponService.updateByPrimaryKeySelective(mlbackCoupon);
		System.out.println("后台操作:CouponService.updateByPrimaryKeySelective:"+mlbackCoupon.toString());
		return Msg.success().add("resMsg", "更新成功");
	}
	
	/**4.0	useOn	0505
	 * MlbackCoupon	delete
	 * @param id
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackCoupon mlbackCoupon){
		//接收id信息
		int couponIdInt = mlbackCoupon.getCouponId();
		int intResult = mlbackCouponService.deleteByPrimaryKey(couponIdInt);
		System.out.println("后台操作:MlbackCoupon,delete success+intResult:"+intResult);
		return Msg.success().add("resMsg", "delete success");
	}
	
	/**
	 * 5.0	useOn	0505
	 * 查单条Coupon详情
	 * @param MlbackCoupon
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackCouponDetailById",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackCouponDetailById(@RequestParam(value = "couponId") Integer couponId){
		
		//接受信息
		MlbackCoupon mlbackCouponReq = new MlbackCoupon();
		mlbackCouponReq.setCouponId(couponId);
		List<MlbackCoupon> mlbackCouponResList =mlbackCouponService.selectMlbackCoupon(mlbackCouponReq);
		MlbackCoupon mlbackCouponOne =mlbackCouponResList.get(0);
		return Msg.success().add("resMsg", "查单条Coupon详情")
					.add("mlbackCouponOne", mlbackCouponOne);
	}
	
	/**
	 * 7.0	20200608
	 * 后端获取backSearchByProduct产品list
	 * @return 
	 * */
	@RequestMapping(value="/backSearchByCoupon",method=RequestMethod.POST)
	@ResponseBody
	public Msg backSearchByCoupon(HttpServletResponse rep,HttpServletRequest res,HttpSession session,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "couponName") String couponName) throws Exception{
		
		//接收传递进来的参数
		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		
		MlbackCoupon mlbackCouponReq = new MlbackCoupon();
		mlbackCouponReq.setCouponName(couponName);
		List<MlbackCoupon> mlbackCouponResList = mlbackCouponService.selectMlbackCouponBackSearch(mlbackCouponReq);
		PageInfo page = new PageInfo(mlbackCouponResList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * 6.0	useOn	0505
	 * 通过优惠码Code-查单条Coupon详情
	 * @param MlbackCoupon
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackCouponDetailByCode",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackCouponDetailByCode(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackCoupon mlbackCoupon){
	    
	    String couponCode = mlbackCoupon.getCouponCode();
	    
	    String nowOrderListPidstr =  mlbackCoupon.getCouponCreatetime();//当前这堆产品的id
	    //接受信息
	    MlbackCoupon mlbackCouponReq = new MlbackCoupon();
	    mlbackCouponReq.setCouponCode(couponCode);
	    mlbackCouponReq.setCouponStatus(1);//进查询生效的优惠码
	    List<MlbackCoupon> mlbackCouponResList =mlbackCouponService.selectMlbackCouponBYCode(mlbackCouponReq);
	    MlbackCoupon mlbackCouponOne = null;
	    Integer couponProductOnlyTypeifHave = 0;
	    if(mlbackCouponResList.size()>0){
	      //1判断优惠码存在不存在
	      mlbackCouponOne =mlbackCouponResList.get(0);
	      //取出本优惠券中的绑定产品字段,如果未绑定产品0,过
	      Integer couponProductOnlyType =  mlbackCouponOne.getCouponProductonlyType();
	      if(couponProductOnlyType==null){
	    	  couponProductOnlyType = 0;
	      }
	      if(couponProductOnlyType==1){
	        String couponPidStr = mlbackCouponOne.getCouponProductonlyPidstr();
	        String temPidStr="";
	        if(nowOrderListPidstr.contains(",")){
	          String couponStrPidsStrArr [] =nowOrderListPidstr.split(",");
	          for(int i=0;i<couponStrPidsStrArr.length;i++){
	            temPidStr = couponStrPidsStrArr[i];
	            if(couponPidStr.equals(temPidStr)){
	              couponProductOnlyTypeifHave = 1;
	              break;
	            }
	          }
	        }else{
	          temPidStr = nowOrderListPidstr;
	          if(couponPidStr.equals(temPidStr)){
	            couponProductOnlyTypeifHave = 1;
	          }
	        }
	      }
	    }
	    return Msg.success().add("resMsg", "getOneMCouponDetailByCode完毕")
	          .add("mlbackCouponOne", mlbackCouponOne).add("couponProductOnlyTypeifHave", couponProductOnlyTypeifHave);
	  }
	
	/**
	 * 7.0	useOn	0505
	 * 查询该用户名下所有优惠券
	 * @param MlbackCoupon
	 * @return 
	 */
	@RequestMapping(value="/getOneMlbackCouponDetailByUId",method=RequestMethod.POST)
	@ResponseBody
	public Msg getOneMlbackCouponDetailByUId(HttpServletResponse rep,HttpServletRequest res,HttpSession session){
		Integer userType= 0;
		MlfrontUser mlfrontUserLogin  = (MlfrontUser) session.getAttribute("loginUser");
		List<MlbackCoupon> mlbackCouponReturnList = new ArrayList<MlbackCoupon>();
		if(mlfrontUserLogin==null){
			//非登录状态
			userType =0;
			return Msg.success().add("resMsg", "查询该用户名下所有优惠券完毕").add("userType", userType);
		}else{
			//登录状态
			userType =1;
			MlfrontUser mlfrontUserreq =new MlfrontUser();
			String userEmail = mlfrontUserLogin.getUserEmail();
			mlfrontUserreq.setUserEmail(userEmail);
			List<MlfrontUser> mlfrontUserList= mlfrontUserService.selectMlfrontUserWhenFirst(mlfrontUserreq);
			if(mlfrontUserList.size()>0){
				//此账号邮箱已经注册,返回即可
				//0的话取出resMsg
				MlfrontUser mlfrontUserres =mlfrontUserList.get(0);
				String couponidstr = mlfrontUserres.getUserCouponidstr();
				
				String couponidstrArr[] = couponidstr.split(",");
				String couponIdStr =""; 
				Integer couponIdInt =0;
				
				for(int i=0;i<couponidstrArr.length;i++){
					couponIdStr = couponidstrArr[i];
					couponIdInt = Integer.parseInt(couponIdStr);
					//拿到couponId,封装参数,查回本条优惠券的详情
					MlbackCoupon mlbackCouponReq = new MlbackCoupon();
					mlbackCouponReq.setCouponId(couponIdInt);
					List<MlbackCoupon> mlbackCouponResList =mlbackCouponService.selectMlbackCoupon(mlbackCouponReq);
					MlbackCoupon mlbackCouponOne =mlbackCouponResList.get(0);
					mlbackCouponReturnList.add(mlbackCouponOne);
				}
				return Msg.success().add("resMsg", "查询该用户名下所有优惠券完毕").add("mlbackCouponReturnList", mlbackCouponReturnList).add("userType", userType);
			}else{
				userType =0;
				return Msg.success().add("resMsg", "查询该用户名下所有优惠券完毕").add("userType", userType);
			}
		}
	}

	/**
	 * 8.0	zsh200728
	 * 查询生效中得抽奖优惠券
	 * @param MlbackCoupon
	 * @return 
	 */
	@RequestMapping(value="/getMlbackCouponShowByLuckDrawType",method=RequestMethod.POST)
	@ResponseBody
	public Msg getMlbackCouponShowByLuckDrawType(HttpServletResponse rep,HttpServletRequest res){
		
		//接受信息
		MlbackCoupon mlbackCouponReq = new MlbackCoupon();
		mlbackCouponReq.setCouponLuckdrawType(1);
		List<MlbackCoupon> mlbackCouponResList =mlbackCouponService.selectMlbackCouponByLuckDrawType(mlbackCouponReq);
		
		LuckDrawDate luckDrawDate =new LuckDrawDate();
		try {
			luckDrawDate = LuckDrawUtils.getLuckDrawDate(mlbackCouponResList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return Msg.success().add("resMsg", "查询转盘优惠券及结果完毕").add("mlbackCouponResList", mlbackCouponResList).add("luckDrawDate", luckDrawDate);
	}
	
	/**
	 * 9.0	zsh200728
	 * 初始化请求,getMlbackCouponShowByLuckDrawType,拿回8个优惠券图片和结果,
	 * 点击按钮,弹出输入邮箱的框框.
	 * 输入完毕,checkCouponLuckDrawResultAndUserEmail.
	 * 点击开始抽奖。getCouponLuckDrawResultAndUserEmail.
	 * 该邮件邮箱已经抽到过次类优惠券,请登陆后可在个人中心查看.自动登陆中.
	 * 恭喜你获得XXXXX,3s后自动登录。账号密码已发送至您的邮箱。--调接口把email+couponId传递进来。
	 * 接口调用成功后,重定向到首页。
	 * @param MlbackCoupon
	 * @return 
	 */
	@RequestMapping(value="/checkCouponLuckDrawResultAndUserEmail",method=RequestMethod.POST)
	@ResponseBody
	public Msg cheakCouponLuckDrawResultAndUserEmail(@RequestParam(value = "couponId") String couponId,
			@RequestParam(value = "userEmail") String userEmail,HttpSession session){
		
		//接受参数,客户email,抽奖优惠券结果
		MlfrontUser mlfrontUserreq = new MlfrontUser();
		mlfrontUserreq.setUserEmail(userEmail);
		List<MlfrontUser> mlfrontUserList= mlfrontUserService.selectMlfrontUserWhenFirst(mlfrontUserreq);
		Integer emailIsCan = 0;//名下没有账户内无券,默认有抽奖资格

		if(mlfrontUserList.size()>0){
			//此账号邮箱存在,准备查是否已经包含此优惠券
			MlfrontUser mlfrontUserres = mlfrontUserList.get(0);
			String couponidstr= mlfrontUserres.getUserCouponidstr();
			
			String[] couponidArr = couponidstr.split(",");
			
			for(int i=0;i<couponidArr.length;i++){
				String couponOne = couponidArr[i];
				if(couponOne.equals(couponId)){
					emailIsCan = 0;
					break;
				}
			}
			if(emailIsCan==1){
				//老帐号名下有此券不能再抽了
				return Msg.success().add("resMsg", "老帐号名下有此券不能再抽").add("emailIsCan", emailIsCan);
			}else{
				//老帐号名下无此券,可以抽
				return Msg.success().add("resMsg", "老帐号名下无此券,可以抽").add("emailIsCan", emailIsCan);
			}
		}else{
			//此账号新来的,可以抽奖
			return Msg.success().add("resMsg", "该账号属于新用户账号").add("emailIsCan", emailIsCan);
		}
	}
	
	/**
	 * 10.0	zsh200728
	 * 获取抽中优惠券,并注册账号,设置登陆状态
	 * @param MlbackCoupon
	 * @return
	 */
	@RequestMapping(value="/getCouponLuckDrawResultAndUserEmail",method=RequestMethod.POST)
	@ResponseBody
	public Msg getCouponLuckDrawResultAndUserEmail(@RequestParam(value = "couponId") String couponId,
			@RequestParam(value = "userEmail") String userEmail,HttpSession session){
		
		//接受参数,客户email,抽奖优惠券结果
		
		//先查这个账号是否存在,
		//1,不存在的话,补全默认信息,新增此条账号数据,强制登陆
		//2,存在的话,更新里面的接口信息,强制登陆
		
		MlfrontUser mlfrontUserreq = new MlfrontUser();
		mlfrontUserreq.setUserEmail(userEmail);
		List<MlfrontUser> mlfrontUserList= mlfrontUserService.selectMlfrontUserWhenFirst(mlfrontUserreq);
		
		String nowtime = DateUtil.strTime14s();
		
		//能进来说明是老账户,但是名下没有这个券,
		if(mlfrontUserList.size()>0){
			//2,存在的话,判断账户中是否有这个优惠券,有的话更新里面的接口信息,强制登陆
			
			MlfrontUser mlfrontUserres = mlfrontUserList.get(0);
			String couponidstr= mlfrontUserres.getUserCouponidstr();
			
			String[] couponidArr = couponidstr.split(",");
			
			Integer isHave = 0; 
			
			for(int i=0;i<couponidArr.length;i++){
				String couponOne = couponidArr[i];
				if(couponOne.equals(couponId)){
					isHave = 1;
					break;
				}
			}
			if(isHave==1){
				//已经有老此优惠券了
				System.out.println("该账户已经有此优惠券,无需要");
			}else{
				couponidstr = couponidstr+","+couponId;
				
				//把这个优惠券字段地算补充进去
				mlfrontUserres.setUserCouponidstr(couponidstr);
				
			}
			mlfrontUserreq.setUserMotifytime(nowtime);
			mlfrontUserreq.setUserLastonlinetime(nowtime);
			mlfrontUserService.updateByPrimaryKeySelective(mlfrontUserres);
			
			session.setAttribute("loginUser", mlfrontUserres);
		}else{
			//1,不存在的话,补全默认信息,新增此条账号数据,强制登陆
			mlfrontUserreq.setUserEmail(userEmail);
			mlfrontUserreq.setUserPassword(userEmail);
			String couponidstr = "1,2,3,"+couponId+"";
			//把优惠券写入账号中
			mlfrontUserreq.setUserCouponidstr(couponidstr);
			
			mlfrontUserreq.setUserCreatetime(nowtime);
			mlfrontUserreq.setUserMotifytime(nowtime);
			mlfrontUserreq.setUserLastonlinetime(nowtime);
			mlfrontUserreq.setUserViplevel(0);
			mlfrontUserreq.setUserTimes(0);
			
			//新增本条数据
			mlfrontUserService.insertSelective(mlfrontUserreq);

			session.setAttribute("loginUser", mlfrontUserreq);
		}
		//session中记录客户登录信息,即把客户信息放置在客户中
		return Msg.success().add("resMsg", "获取完毕抽奖客户邮箱完毕,强制注册完成");
		
	}
	
	/**
	 * 11.0	useOn	0505
	 * to分类MlbackCoupon列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toCouponAnalysisPage")
	public String toCouponCaclPage() throws Exception{
	
		return "back/operate/mlbackCouponAnalysisPage";
	}
	
	/**
	 * 12.0	20201207
	 * 后端时间筛选下的优惠券使用次数MlbackSearch/getSearchListByTime
	 * @param	MlbackSearch
	 * @return
	 */
	@RequestMapping(value="/getSearchListByTime",method=RequestMethod.POST)
	@ResponseBody
	public Msg getSearchListByTime(HttpSession session,@RequestBody MlbackSearch mlbackSearch) {
		
		String starttime = mlbackSearch.getSearchCreatetime();
		String endtime = mlbackSearch.getSearchMotifytime();
		UrlCount urlCountReq = new UrlCount();
		urlCountReq.setSearchStartTime(starttime);
		urlCountReq.setSearchEndTime(endtime);
		
		List<UrlCount> urlCountList = urlCountService.selectCouponCountByTime(urlCountReq);
		
		return Msg.success().add("urlCountList", urlCountList);
	}
	
	/**
	 * 13.1	zsh	20201207
	 * to分类MlbackCoupon列表页面
	 * @param jsp
	 * @return 
	 * */
	@RequestMapping("/toCouponUsedDetailListPage")
	public String toCouponUsedDetailListPage() throws Exception{
	
		return "back/operate/mlbackCouponUsedDetailListPage";
	}
	
	/**
	 * 13.2	20201207
	 * 后端时间筛选下的时间内某一个优惠券的使用单子大概qingliang
	 * @param	getCouponUsedDetailListByTime
	 * @return
	 */
	@RequestMapping(value="/getCouponUsedDetailListByTime",method=RequestMethod.POST)
	@ResponseBody
	public Msg getCouponUsedDetailListByTime(HttpSession session,@RequestBody MlbackSearch mlbackSearch) {
		
		String starttime = mlbackSearch.getSearchCreatetime();
		String endtime = mlbackSearch.getSearchMotifytime();
		String couponCode = mlbackSearch.getSearchContent();
		CouponAnalysisDate couponAnalysisDateReq = new CouponAnalysisDate();
		couponAnalysisDateReq.setPayinfoCreatetime(starttime);
		couponAnalysisDateReq.setPayinfoMotifytime(endtime);
		couponAnalysisDateReq.setSearchCouponCode(couponCode);
		
		List<CouponAnalysisDate> CouponAnalysisDateList = couponAnalysisDateService.selectCouponAnalysisList(couponAnalysisDateReq);
		
		return Msg.success().add("CouponAnalysisDateList", CouponAnalysisDateList);
	}
	
	/**
	 * 7.0	20200608
	 * 后端获取backSearchByProduct产品list
	 * @return 
	 * */
	@RequestMapping(value="/backSearchByCouponCode",method=RequestMethod.POST)
	@ResponseBody
	public Msg backSearchByCouponCode(HttpServletResponse rep,HttpServletRequest res,HttpSession session,
			@RequestParam(value = "pn", defaultValue = "1") Integer pn,
			@RequestParam(value = "couponName") String couponName) throws Exception{
		
		//接收传递进来的参数
		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		
		MlbackCoupon mlbackCouponReq = new MlbackCoupon();
		mlbackCouponReq.setCouponName(couponName);//因为
		List<MlbackCoupon> mlbackCouponResList = mlbackCouponService.selectMlbackCouponBackSearch(mlbackCouponReq);
		PageInfo page = new PageInfo(mlbackCouponResList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
}
