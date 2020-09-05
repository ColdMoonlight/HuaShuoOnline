package com.atguigu.dao;

import com.atguigu.bean.MlbackCaclPay;

public interface MlbackCaclPayMapper {
    int deleteByPrimaryKey(Integer tbMlbackCaclpayId);

    int insert(MlbackCaclPay record);

    int insertSelective(MlbackCaclPay record);

    MlbackCaclPay selectByPrimaryKey(Integer tbMlbackCaclpayId);

    int updateByPrimaryKeySelective(MlbackCaclPay record);

    int updateByPrimaryKey(MlbackCaclPay record);
}