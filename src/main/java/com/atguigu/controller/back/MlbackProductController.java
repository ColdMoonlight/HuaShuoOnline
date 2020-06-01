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

import com.atguigu.bean.MlbackAdmin;
import com.atguigu.bean.MlbackProduct;
import com.atguigu.common.Const;
import com.atguigu.common.Msg;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.atguigu.service.MlbackAdminService;
import com.atguigu.service.MlbackCategoryService;
import com.atguigu.service.MlbackProductService;
import com.atguigu.utils.DateUtil;

@Controller
@RequestMapping("/MlbackProduct")
public class MlbackProductController {
	
	@Autowired
	MlbackProductService mlbackProductService;
	
	@Autowired
	MlbackCategoryService mlbackCategoryService;
	
	@Autowired
	MlbackAdminService mlbackAdminService;
	
	/**
	 * 1.0	onuse	20191225	检查
	 * to后台分类MlbackProduct列表页面
	 * @return jsp
	 * */
	@RequestMapping("/toMlbackProductPage")
	public String tologin(HttpSession session) throws Exception{
		
		MlbackAdmin mlbackAdmin =(MlbackAdmin) session.getAttribute(Const.ADMIN_USER);
		if(mlbackAdmin==null){
			//SysUsers对象为空
			return "back/mlbackAdminLogin";
		}else{
			return "back/product/mlbackProductPage";
		}
	}
	
	/**2.0	onuse	20191225	检查
	 * 后台MlbackProduct列表分页list数据
	 * @param pn
	 * @return
	 */
	@RequestMapping(value="/getMlbackProductByPage")
	@ResponseBody
	public Msg getGroupDisplayWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn,HttpSession session) {

		int PagNum = 30;
		PageHelper.startPage(pn, PagNum);
		List<MlbackProduct> MlbackProductList = mlbackProductService.selectMlbackProductGetAll();
		PageInfo page = new PageInfo(MlbackProductList, PagNum);
		return Msg.success().add("pageInfo", page);
	}
	
	/**3.0	onuse	20191225	检查
	 * MlbackProduct	initializaCategory
	 * @param MlbackProduct
	 * @return
	 */
	@RequestMapping(value="/initializaProduct",method=RequestMethod.POST)
	@ResponseBody
	public Msg initializaCategory(HttpServletResponse rep,HttpServletRequest res){
		
		MlbackProduct mlbackProduct = new MlbackProduct();
		//取出id
		String nowTime = DateUtil.strTime14s();
		mlbackProduct.setProductCreatetime(nowTime);
		//无id，insert
		System.out.println("插入前"+mlbackProduct.toString());
		mlbackProductService.insertSelective(mlbackProduct);
		System.out.println("插入后"+mlbackProduct.toString());
		return Msg.success().add("resMsg", "Product初始化成功").add("mlbackProduct", mlbackProduct);
	}
	
	/**3.0	onuse	20191225	检查
	 * MlbackProduct	update
	 * @param MlbackProduct
	 * @return
	 */
	@RequestMapping(value="/save",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveSelective(HttpServletResponse rep,HttpServletRequest res,@RequestBody MlbackProduct mlbackProduct){
		//接受参数信息
		//获取类名

		String nowTime = DateUtil.strTime14s();
		mlbackProduct.setProductCreatetime(nowTime);
		mlbackProductService.updateByPrimaryKeySelective(mlbackProduct);
		return Msg.success().add("resMsg", "category保存成功");
	}
	
	/**4.0	onuse	20191225	检查
	 * MlbackProduct	delete
	 * @param MlbackProduct-categoryId
	 * @return 
	 */
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	@ResponseBody
	public Msg delete(@RequestBody MlbackProduct mlbackProduct){
		//接收id信息
		int productIdInt = mlbackProduct.getProductId();
		mlbackProductService.deleteByPrimaryKey(productIdInt);
		return Msg.success().add("resMsg", "category delete  success");
	}

}
