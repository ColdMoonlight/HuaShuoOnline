package com.atguigu.dao;

import java.util.List;
import com.atguigu.bean.EmailUser;

public interface EmailUserMapper {
    int deleteByPrimaryKey(Integer useremailId);

    int insert(EmailUser record);

    int insertSelective(EmailUser record);

    EmailUser selectByPrimaryKey(Integer useremailId);

    int updateByPrimaryKeySelective(EmailUser record);

    int updateByPrimaryKey(EmailUser record);

	List<EmailUser> selectALl(EmailUser record);

	List<com.atguigu.bean.EmailUser> selectByEmail(EmailUser emailUser);
}