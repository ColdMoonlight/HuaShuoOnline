package com.atguigu.dao;

import com.atguigu.bean.EmailPayPalRetuenSuccess;

public interface EmailPayPalRetuenSuccessMapper {
    int deleteByPrimaryKey(Integer payretuensuccessId);

    int insert(EmailPayPalRetuenSuccess record);

    int insertSelective(EmailPayPalRetuenSuccess record);

    EmailPayPalRetuenSuccess selectByPrimaryKey(Integer payretuensuccessId);

    int updateByPrimaryKeySelective(EmailPayPalRetuenSuccess record);

    int updateByPrimaryKey(EmailPayPalRetuenSuccess record);
}