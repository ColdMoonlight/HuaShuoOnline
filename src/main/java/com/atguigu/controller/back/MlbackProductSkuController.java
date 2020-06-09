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
import org.springframework.web.multipart.commons.CommonsMultipartFile;

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
		if(productskuId==null){
			mlbackProductSku.setProductskuCreatetime(nowtime);
			mlbackProductSku.setProductskuStatus(0);
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
		//接受信息
		List<MlbackProductSku> mlbackProductSkuResList =mlbackProductSkuService.selectMlbackProductSkuListByPId(productskuPid);
		return Msg.success().add("resMsg", "查看本productId下的所有属性,完毕")
					.add("mlbackProductSkuResList", mlbackProductSkuResList);
	}
	
	/**
	 * 	onuse	20200103	检查
	 * */
	@RequestMapping(value="/productDiscount",method=RequestMethod.POST)
	@ResponseBody
	public Msg productDiscount(HttpSession session,HttpServletResponse rep,HttpServletRequest res,
			@RequestParam("mlbackProductSkuList")List<MlbackProductSku> mlbackProductSkuList){
		
		for(MlbackProductSku mlbackProductSkuOne :mlbackProductSkuList){
			
			String nowtime = DateUtil.strTime14s();
			mlbackProductSkuOne.setProductskuCreatetime(nowtime);
			mlbackProductSkuService.insertSelective(mlbackProductSkuOne);
			
		}
		
		return Msg.success().add("resMsg", "查看本productId下的所有属性,完毕")
				.add("mlbackProductSkuResList", mlbackProductSkuList);
		
	}
	
}
