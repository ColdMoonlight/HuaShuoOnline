package com.atguigu.dao;

import java.util.List;
import com.atguigu.bean.EmailPayAndCheck;

public interface EmailPayAndCheckMapper {
    int deleteByPrimaryKey(Integer payandcheckId);

    int insert(EmailPayAndCheck record);

    int insertSelective(EmailPayAndCheck record);

    EmailPayAndCheck selectByPrimaryKey(Integer payandcheckId);

    int updateByPrimaryKeySelective(EmailPayAndCheck record);

    int updateByPrimaryKey(EmailPayAndCheck record);
    
	List<EmailPayAndCheck> selectALl(EmailPayAndCheck record);

	List<EmailPayAndCheck> selectByEmail(EmailPayAndCheck EmailPayAndCheck);
}