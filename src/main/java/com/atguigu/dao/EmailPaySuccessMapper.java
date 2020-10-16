package com.atguigu.dao;

import java.util.List;
import com.atguigu.bean.EmailPaySuccess;

public interface EmailPaySuccessMapper {
    int deleteByPrimaryKey(Integer paysuccessId);

    int insert(EmailPaySuccess record);

    int insertSelective(EmailPaySuccess record);

    EmailPaySuccess selectByPrimaryKey(Integer paysuccessId);

    int updateByPrimaryKeySelective(EmailPaySuccess record);

    int updateByPrimaryKey(EmailPaySuccess record);
    
	List<EmailPaySuccess> selectALl(EmailPaySuccess record);

	List<EmailPaySuccess> selectByEmail(EmailPaySuccess emailAddress);
}