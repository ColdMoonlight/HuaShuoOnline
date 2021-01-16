package com.atguigu.dao;

import com.atguigu.bean.MlfrontCheckoutView;

public interface MlfrontCheckoutViewMapper {
    int deleteByPrimaryKey(Integer checkoutviewId);

    int insert(MlfrontCheckoutView record);

    int insertSelective(MlfrontCheckoutView record);

    MlfrontCheckoutView selectByPrimaryKey(Integer checkoutviewId);

    int updateByPrimaryKeySelective(MlfrontCheckoutView record);

    int updateByPrimaryKey(MlfrontCheckoutView record);
}