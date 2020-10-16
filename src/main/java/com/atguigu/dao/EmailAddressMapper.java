package com.atguigu.dao;

import com.atguigu.bean.EmailAddress;

public interface EmailAddressMapper {
    int deleteByPrimaryKey(Integer addressemailId);

    int insert(EmailAddress record);

    int insertSelective(EmailAddress record);

    EmailAddress selectByPrimaryKey(Integer addressemailId);

    int updateByPrimaryKeySelective(EmailAddress record);

    int updateByPrimaryKey(EmailAddress record);
}