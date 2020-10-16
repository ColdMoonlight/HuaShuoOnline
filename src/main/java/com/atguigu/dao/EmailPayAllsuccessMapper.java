package com.atguigu.dao;

import java.util.List;

import com.atguigu.bean.EmailCheckUnPay;
import com.atguigu.bean.EmailPayAllsuccess;

public interface EmailPayAllsuccessMapper {
    int deleteByPrimaryKey(Integer payallsuccessId);

    int insert(EmailPayAllsuccess record);

    int insertSelective(EmailPayAllsuccess record);

    EmailPayAllsuccess selectByPrimaryKey(Integer payallsuccessId);

    int updateByPrimaryKeySelective(EmailPayAllsuccess record);

    int updateByPrimaryKey(EmailPayAllsuccess record);

	List<EmailPayAllsuccess> selectALl(EmailPayAllsuccess record);

	List<EmailPayAllsuccess> selectByEmail(EmailPayAllsuccess EmailCheckUnPay);
}