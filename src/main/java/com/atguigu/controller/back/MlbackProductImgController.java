package com.atguigu.controller.back;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.bean.MlbackProduct;
import com.atguigu.bean.MlbackProductImg;
import com.atguigu.common.Msg;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackProductImgService;
import com.atguigu.service.MlbackProductService;

@Controller
@RequestMapping("/MlbackProductImg")
public class MlbackProductImgController {
		
	@Autowired
	MlbackProductImgService mlbackProductImgService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	/**
	 * 1.0	onuse	200104
	 * 查看单条id下的细节详情图
	 * @param MlbackProductImg
	 * @return 
	 */
	@RequestMapping(value="/getMlbackProductImgListByProductId",method=RequestMethod.POST)
	@ResponseBody
	public Msg getMlbackProductImgListByProductId(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProduct mlbackProduct){
		
		Integer productId = mlbackProduct.getProductId();
		//接受信息
		List<MlbackProductImg> mbackProductImgResList =mlbackProductImgService.selectMlbackProductImgByProductId(productId);
		return Msg.success().add("resMsg", "查看本productId下的所有小图,完毕")
					.add("mbackProductImgResList", mbackProductImgResList);
	}
	
	/**2.0	onuse	200104
	 * MlbackProductImg	delete
	 * @param id
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackProductImg mlbackProductImg){
		//接收id信息
		Integer productimgId = mlbackProductImg.getProductimgId();
		
		List<MlbackProductImg> mbackProductImgResList =mlbackProductImgService.selectMlbackProductImgByProductImgId(productimgId);
		if(mbackProductImgResList.size()>0){
			//本条存在,执行删除
			mlbackProductImgService.deleteByPrimaryKey(productimgId);
			return Msg.success().add("resMsg", "delete success");
		}else{
			//本条不存在,仅此而已
			//System.out.println("本条不存在,刷新后重试");
			return Msg.success().add("resMsg", "本条不存在,刷新后重试");
		}
	}
	
}
