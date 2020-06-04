package com.atguigu.controller.back;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.MlbackProductAttributeValue;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackProductAttributeValueService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackProductAttributeValue")
public class MlbackProductAttributeValueController {
		
	@Autowired
	MlbackProductAttributeValueService mlbackProductAttributeValueService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	

	/**1.0	UseNow	0505
	 * MlbackChannel	insert
	 * @param MlbackChannel
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProductAttributeValue mlbackProductAttributeValue){
		//接受参数信息
		Integer productattrvalueId = mlbackProductAttributeValue.getProductattrvalueId();
		String nowtime = DateUtil.strTime14s();
		if(productattrvalueId==null){
			mlbackProductAttributeValue.setProductattrvalueCreatetime(nowtime);
			mlbackProductAttributeValue.setProductattrvalueStatus(0);
			//无id,insert
			mlbackProductAttributeValueService.insertSelective(mlbackProductAttributeValue);
			System.out.println("MlbackProductAttributeValue insert success+intResult:"+mlbackProductAttributeValue.toString());
			return Msg.success().add("resMsg", "插入成功");
		}else{
			//有id,update
			mlbackProductAttributeValueService.updateByPrimaryKeySelective(mlbackProductAttributeValue);
			return Msg.success().add("resMsg", "更新成功");
		}
	}
	
	/**2.0	onuse	200104
	 * MlbackProductAttributeValue	delete
	 * @param id
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackProductAttributeValue mlbackProductAttributeValue){
		//接收id信息
		Integer productattrvalueId = mlbackProductAttributeValue.getProductattrvalueId();
		//本条存在,执行删除
		mlbackProductAttributeValueService.deleteByPrimaryKey(productattrvalueId);
		return Msg.success().add("resMsg", "delete success");

	}
	
	/**
	 * 3.0	onuse	200104
	 * 查看单条id下的细节详情图
	 * @param MlbackProductAttributeValue
	 * @return 
	 */
	@RequestMapping(value="/getMlbackProductAttributeValueListByPAttributeNameId",method=RequestMethod.POST)
	@ResponseBody
	public Msg getMlbackProductAttributeValueListByPAttributeNameId(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProductAttributeValue mlbackProductAttributeValue){
		
		Integer productattrvaluePattributenameid = mlbackProductAttributeValue.getProductattrvaluePattributenameid();
		//接受信息
		List<MlbackProductAttributeValue> mlbackProductAttributeValueResList =mlbackProductAttributeValueService.selectMlbackProductAttributeValueByPAttributeNameId(productattrvaluePattributenameid);
		return Msg.success().add("resMsg", "查看本productId下的所有属性,完毕")
					.add("mlbackProductAttributeValueResList", mlbackProductAttributeValueResList);
	}
	
}
