package com.atguigu.dao;

import java.util.List;
import com.atguigu.bean.EmailCheckUnPay;

public interface EmailCheckUnPayMapper {
    int deleteByPrimaryKey(Integer checkunpayId);

    int insert(EmailCheckUnPay record);

    int insertSelective(EmailCheckUnPay record);

    EmailCheckUnPay selectByPrimaryKey(Integer checkunpayId);

    int updateByPrimaryKeySelective(EmailCheckUnPay record);

    int updateByPrimaryKey(EmailCheckUnPay record);
    
	List<EmailCheckUnPay> selectALl(EmailCheckUnPay record);

	List<EmailCheckUnPay> selectByEmail(EmailCheckUnPay EmailCheckUnPay);
}