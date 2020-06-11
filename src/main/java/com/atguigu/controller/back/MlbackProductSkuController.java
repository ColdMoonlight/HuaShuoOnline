package com.atguigu.controller.back;

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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.atguigu.bean.MlbackProductSku;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackProductSkuService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackProductSku")
public class MlbackProductSkuController {
		
	@Autowired
	MlbackProductSkuService mlbackProductSkuService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	

	/**1.0	UseNow	0505
	 * MlbackChannel	insert
	 * @param MlbackChannel
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProductSku mlbackProductSku){
		//接受参数信息
		Integer productskuId = mlbackProductSku.getProductskuId();
		String nowtime = DateUtil.strTime14s();
		mlbackProductSku.setProductskuMotifytime(nowtime);
		mlbackProductSku.setProductskuStatus(1);
		if(productskuId==null){
			mlbackProductSku.setProductskuCreatetime(nowtime);
			//无id,insert
			mlbackProductSkuService.insertSelective(mlbackProductSku);
			System.out.println("mlbackProductSku insert success+intResult:"+mlbackProductSku.toString());
			return Msg.success().add("resMsg", "插入成功").add("mlbackProductSku", mlbackProductSku);
		}else{
			//有id,update
			mlbackProductSkuService.updateByPrimaryKeySelective(mlbackProductSku);
			return Msg.success().add("resMsg", "更新成功");
		}
	}
	
	/**2.0	onuse	200104
	 * MlbackProductSku	delete
	 * @param id
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackProductSku mlbackProductSku){
		//接收id信息
		Integer productskuId = mlbackProductSku.getProductskuId();
		//本条存在,执行删除
		mlbackProductSkuService.deleteByPrimaryKey(productskuId);
		return Msg.success().add("resMsg", "delete success");

	}
	
	/**
	 * 3.0	onuse	200104
	 * 查看单条id下的细节详情图
	 * @param MlbackProductSku
	 * @return 
	 */
	@RequestMapping(value="/getMlbackProductSkuListByPId",method=RequestMethod.POST)
	@ResponseBody
	public Msg getMlbackProductSkuListByPId(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProductSku mlbackProductSku){
		
		
		Integer productskuPid = mlbackProductSku.getProductskuPid();
		MlbackProductSku mlbackProductSkuReq = new MlbackProductSku();
		mlbackProductSkuReq.setProductskuPid(productskuPid);
		//接受信息
		List<MlbackProductSku> mlbackProductSkuResList =mlbackProductSkuService.selectMlbackProductSkuListByPId(mlbackProductSkuReq);
		return Msg.success().add("resMsg", "查看本productId下的所有属性,完毕")
					.add("mlbackProductSkuResList", mlbackProductSkuResList);
	}
	
	/**4.0
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/productSkuListInto",method=RequestMethod.POST)
	@ResponseBody
	public Msg productDiscount(HttpSession session,HttpServletResponse rep,HttpServletRequest res,
			@RequestParam("mlbackProductSkuList")List<MlbackProductSku> mlbackProductSkuList,
			@RequestParam("productskuPid") Integer productskuPid){
		
		//1.收到productskuPid，查询该id下，所有的产品sku
		//收到list集合,先对该产品下,所有的生效中的进行状态为0,
		//遍历集合
		//取出一条,查询这一条,如果存在,将状态改成1，生效中。如果有，更改属性值即可，如果没，新增本条即可。
		
		MlbackProductSku mlbackProductSkuReq = new MlbackProductSku();
		mlbackProductSkuReq.setProductskuPid(productskuPid);
		mlbackProductSkuReq.setProductskuStatus(1);//查询其中状态为1
		List<MlbackProductSku> mlbackProductSkuListOldRes= mlbackProductSkuService.selectMlbackProductSkuListByPId(mlbackProductSkuReq);
		//如果当前有生效中
		if(mlbackProductSkuListOldRes.size()>0){
			//更改每一条的状态为0
			for(MlbackProductSku mlbackProductSkuOne :mlbackProductSkuList){
				Integer productskuId = mlbackProductSkuOne.getProductskuId();
				
				String nowtimeStatus = DateUtil.strTime14s();
				MlbackProductSku mlbackProductSkuStatueReq = new MlbackProductSku();
				mlbackProductSkuStatueReq.setProductskuId(productskuId);
				mlbackProductSkuStatueReq.setProductskuStatus(0);//先对该产品下,所有的生效中的进行状态为0
				mlbackProductSkuStatueReq.setProductskuMotifytime(nowtimeStatus);
			}
		}
		
		for(MlbackProductSku mlbackProductSkuOne :mlbackProductSkuList){
			
			String nowtime = DateUtil.strTime14s();
			String PSkuName = mlbackProductSkuOne.getProductskuName();
			
			MlbackProductSku mlbackProductSkuNewReq = new MlbackProductSku();
			mlbackProductSkuNewReq.setProductskuName(PSkuName);
			mlbackProductSkuNewReq.setProductskuPid(productskuPid);
			List<MlbackProductSku> mlbackProductSkuNewRes = mlbackProductSkuService.selectMlbackProductSkuListByPId(mlbackProductSkuNewReq);
			
			MlbackProductSku mlbackProductSkuStatue = new MlbackProductSku();
			//取出一条,查询这一条,如果存在,将状态改成1
			if(mlbackProductSkuNewRes.size()>0){
				mlbackProductSkuStatue = mlbackProductSkuNewRes.get(0);
				Integer productskuId = mlbackProductSkuStatue.getProductskuId();//本条的id
				//付给新数据对象
				mlbackProductSkuOne.setProductskuId(productskuId);
				mlbackProductSkuOne.setProductskuStatus(1);
				mlbackProductSkuOne.setProductskuMotifytime(nowtime);
				//新数据对象有了id，走更新
				mlbackProductSkuService.updateByPrimaryKeySelective(mlbackProductSkuOne);
			}else{
				//没有这一条,新增本条即可
				mlbackProductSkuOne.setProductskuCreatetime(nowtime);
				mlbackProductSkuOne.setProductskuStatus(1);
				mlbackProductSkuService.insertSelective(mlbackProductSkuOne);
			}
			
		}
		
		MlbackProductSku mlbackProductSkuFinallReq = new MlbackProductSku();
		mlbackProductSkuFinallReq.setProductskuPid(productskuPid);
		mlbackProductSkuFinallReq.setProductskuStatus(1);//查询其中状态为1
		List<MlbackProductSku> mlbackProductSkuListFinallRes= mlbackProductSkuService.selectMlbackProductSkuListByPId(mlbackProductSkuFinallReq);
		
		return Msg.success().add("resMsg", "查看本productId下的所有属性,完毕")
				.add("mlbackProductSkuListFinallRes", mlbackProductSkuListFinallRes);
		
	}
	/**4.0
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/productSkuListIntoA",method=RequestMethod.POST)
	@ResponseBody
	public Msg productSkuListIntoA(HttpSession session,HttpServletResponse rep,HttpServletRequest res,
			@RequestParam("teams") String teams,@RequestParam("productskuPid") Integer productskuPid){
		
		//1.收到productskuPid，查询该id下，所有的产品sku
		//收到list集合,先对该产品下,所有的生效中的进行状态为0,
		//遍历集合
		//取出一条,查询这一条,如果存在,将状态改成1，生效中。如果有，更改属性值即可，如果没，新增本条即可。
		
		JSONArray jsonArray= JSON.parseArray(teams);
	    List<MlbackProductSku> mlbackProductSkuList = jsonArray.toJavaList(MlbackProductSku.class);
		
	    
	  //1.收到productskuPid，查询该id下，所有的产品sku
  		//收到list集合,先对该产品下,所有的生效中的进行状态为0,
  		//遍历集合
  		//取出一条,查询这一条,如果存在,将状态改成1，生效中。如果有，更改属性值即可，如果没，新增本条即可。
  		
  		MlbackProductSku mlbackProductSkuReq = new MlbackProductSku();
  		mlbackProductSkuReq.setProductskuPid(productskuPid);
  		mlbackProductSkuReq.setProductskuStatus(1);//查询其中状态为1
  		List<MlbackProductSku> mlbackProductSkuListOldRes= mlbackProductSkuService.selectMlbackProductSkuListByPId(mlbackProductSkuReq);
  		//如果当前有生效中
  		if(mlbackProductSkuListOldRes.size()>0){
  			//更改每一条的状态为0
  			for(MlbackProductSku mlbackProductSkuOne :mlbackProductSkuList){
  				Integer productskuId = mlbackProductSkuOne.getProductskuId();
  				
  				String nowtimeStatus = DateUtil.strTime14s();
  				MlbackProductSku mlbackProductSkuStatueReq = new MlbackProductSku();
  				mlbackProductSkuStatueReq.setProductskuId(productskuId);
  				mlbackProductSkuStatueReq.setProductskuStatus(0);//先对该产品下,所有的生效中的进行状态为0
  				mlbackProductSkuStatueReq.setProductskuMotifytime(nowtimeStatus);
  			}
  		}
  		
  		for(MlbackProductSku mlbackProductSkuOne :mlbackProductSkuList){
  			
  			String nowtime = DateUtil.strTime14s();
  			String PSkuName = mlbackProductSkuOne.getProductskuName();
  			
  			MlbackProductSku mlbackProductSkuNewReq = new MlbackProductSku();
  			mlbackProductSkuNewReq.setProductskuName(PSkuName);
  			mlbackProductSkuNewReq.setProductskuPid(productskuPid);
  			List<MlbackProductSku> mlbackProductSkuNewRes = mlbackProductSkuService.selectMlbackProductSkuListByPId(mlbackProductSkuNewReq);
  			
  			MlbackProductSku mlbackProductSkuStatue = new MlbackProductSku();
  			//取出一条,查询这一条,如果存在,将状态改成1
  			if(mlbackProductSkuNewRes.size()>0){
  				mlbackProductSkuStatue = mlbackProductSkuNewRes.get(0);
  				Integer productskuId = mlbackProductSkuStatue.getProductskuId();//本条的id
  				//付给新数据对象
  				mlbackProductSkuOne.setProductskuId(productskuId);
  				mlbackProductSkuOne.setProductskuStatus(1);
  				mlbackProductSkuOne.setProductskuMotifytime(nowtime);
  				//新数据对象有了id，走更新
  				mlbackProductSkuService.updateByPrimaryKeySelective(mlbackProductSkuOne);
  			}else{
  				//没有这一条,新增本条即可
  				mlbackProductSkuOne.setProductskuCreatetime(nowtime);
  				mlbackProductSkuOne.setProductskuStatus(1);
  				mlbackProductSkuService.insertSelective(mlbackProductSkuOne);
  			}
  			
  		}
  		
  		MlbackProductSku mlbackProductSkuFinallReq = new MlbackProductSku();
  		mlbackProductSkuFinallReq.setProductskuPid(productskuPid);
  		mlbackProductSkuFinallReq.setProductskuStatus(1);//查询其中状态为1
  		List<MlbackProductSku> mlbackProductSkuListFinallRes= mlbackProductSkuService.selectMlbackProductSkuListByPId(mlbackProductSkuFinallReq);
	
		
		return Msg.success().add("resMsg", "查看本productId下的所有属性,完毕")
				.add("mlbackProductSkuListFinallRes", mlbackProductSkuListFinallRes);
		
	}
	
}
