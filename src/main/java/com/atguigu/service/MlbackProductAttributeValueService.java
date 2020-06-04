package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.MlbackProductAttributeValue;
import com.atguigu.dao.MlbackProductAttributeValueMapper;

@Service
public class MlbackProductAttributeValueService {
	
	@Autowired
	MlbackProductAttributeValueMapper mlbackProductAttributeValueMapper;
	
	/**
	 * @author Shinelon
	 * @param MlbackProductAttributeValue
	 * @exception add方法MlbackProductAttributeValue
	 * 
	 * */
	public int insertSelective(MlbackProductAttributeValue mlbackProductAttributeValue) {
		int intReslut = mlbackProductAttributeValueMapper.insertSelective(mlbackProductAttributeValue);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param MlbackProductAttributeValue
	 * @exception 删除本条MlbackProductAttributeValue
	 * 
	 * */
	public int deleteByPrimaryKey(int productattrvalueId) {
		int  intReslut = mlbackProductAttributeValueMapper.deleteByPrimaryKey(productattrvalueId);
		return intReslut;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 更新本条MlbackProductAttributeValue
	 * 
	 * */
	public int updateByPrimaryKeySelective(MlbackProductAttributeValue mlbackProductAttributeValue) {
		int  intReslut = mlbackProductAttributeValueMapper.updateByPrimaryKeySelective(mlbackProductAttributeValue);
		return intReslut;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部MlbackProductAttributeValue信息
	 * 
	 * */
	public List<MlbackProductAttributeValue> selectMlbackProductAttributeValueByPAttributeNameId(Integer productattrvaluePattributenameid) {
		List<MlbackProductAttributeValue>  MlbackProductAttributeValueList = mlbackProductAttributeValueMapper.selectMlbackProductAttributeValueByPAttributeNameId(productattrvaluePattributenameid);
		return MlbackProductAttributeValueList;
	}
//
//	/**
//	 * @author Shinelon
//	 * @param 
//	 * @exception 查看全部MlbackProductAttributeValue信息
//	 * */
//	public List<MlbackProductAttributeValue> selectMlbackProductAttributeValueByPIdAndImgSort(MlbackProductAttributeValue MlbackProductAttributeValue) {
//		List<MlbackProductAttributeValue>  MlbackProductAttributeValueList = MlbackProductAttributeValueMapper.selectMlbackProductAttributeValueByPIdAndImgSort(MlbackProductAttributeValue);
//		return MlbackProductAttributeValueList;
//	}
//	
//	/**
//	 * @author Shinelon
//	 * @param 
//	 * @exception 用productimgId,查看MlbackProductAttributeValue信息
//	 * */
//	public List<MlbackProductAttributeValue> selectMlbackProductAttributeValueByProductImgId(Integer productimgId) {
//		List<MlbackProductAttributeValue>  MlbackProductAttributeValueList = MlbackProductAttributeValueMapper.selectMlbackProductAttributeValueByProductImgId(productimgId);
//		return MlbackProductAttributeValueList;
//	}
	
}
