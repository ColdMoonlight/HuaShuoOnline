package com.atguigu.dao;

import com.atguigu.bean.MlbackAddCartViewDetail;

public interface MlbackAddCartViewDetailMapper {
    int deleteByPrimaryKey(Integer addcartviewdetailId);

    int insert(MlbackAddCartViewDetail record);

    int insertSelective(MlbackAddCartViewDetail record);

    MlbackAddCartViewDetail selectByPrimaryKey(Integer addcartviewdetailId);

    int updateByPrimaryKeySelective(MlbackAddCartViewDetail record);

    int updateByPrimaryKey(MlbackAddCartViewDetail record);
}