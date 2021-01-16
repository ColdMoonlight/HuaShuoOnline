package com.atguigu.dao;

import com.atguigu.bean.MlfrontCheckoutView;

public interface MlfrontCheckoutViewMapper {

    int insert(MlfrontCheckoutView record);

    MlfrontCheckoutView selectByPrimaryKey(Integer checkoutviewId);

    int updateByPrimaryKey(MlfrontCheckoutView record);
    
    int insertSelective(MlfrontCheckoutView record);
    
    int deleteByPrimaryKey(Integer checkoutviewId);
    
    int updateByPrimaryKeySelective(MlfrontCheckoutView record);
}