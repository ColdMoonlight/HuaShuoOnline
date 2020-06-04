package com.atguigu.dao;

import java.util.List;

import com.atguigu.bean.MlbackProductAttributeValue;

public interface MlbackProductAttributeValueMapper {

    int insert(MlbackProductAttributeValue record);

    MlbackProductAttributeValue selectByPrimaryKey(Integer productattrvalueId);

    int updateByPrimaryKey(MlbackProductAttributeValue record);
    
    //插入新类目
    int insertSelective(MlbackProductAttributeValue record);
    //删除本条图片00    
    int deleteByPrimaryKey(Integer productattrvalueId);
    //更新本条图片00
    int updateByPrimaryKeySelective(MlbackProductAttributeValue record);
    //selectMlbackProductAttributeValueByPAttributeNameId
	List<MlbackProductAttributeValue> selectMlbackProductAttributeValueByPAttributeNameId(Integer productattrvaluePattributenameid);
	
}