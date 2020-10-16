package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.EmailPayAndCheck;
import com.atguigu.dao.EmailPayAndCheckMapper;

@Service
public class EmailPayAndCheckService {
	
	@Autowired
	EmailPayAndCheckMapper emailPayAndCheckMapper;
	
	/**
	 * @author Shinelon
	 * @param EmailPayAndCheck
	 * @exception add方法用户信息是否存在
	 * 	3.0
	 * */
	public int insertSelective(EmailPayAndCheck EmailPayAndCheck) {
		int intReslut = emailPayAndCheckMapper.insertSelective(EmailPayAndCheck);
		return intReslut;
	}

	/**
	 * @author
	 * @param 
	 * @exception 删除本条信息
	 * 	3.0
	 * */
	public int deleteByPrimaryKey(int CatalogId) {
		int  intReslut = emailPayAndCheckMapper.deleteByPrimaryKey(CatalogId);
		return intReslut;
	}

	/**
	 * @author	3.0
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(EmailPayAndCheck EmailPayAndCheck) {
		int  intReslut = emailPayAndCheckMapper.updateByPrimaryKeySelective(EmailPayAndCheck);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPayAndCheck> selectALl(EmailPayAndCheck EmailPayAndCheck) {
		List<EmailPayAndCheck>  EmailPayAndCheckList = emailPayAndCheckMapper.selectALl(EmailPayAndCheck);
		return EmailPayAndCheckList;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPayAndCheck> selectByEmail(EmailPayAndCheck EmailPayAndCheck) {
		List<EmailPayAndCheck>  MlbackActShowProList = emailPayAndCheckMapper.selectByEmail(EmailPayAndCheck);
		return MlbackActShowProList;
	}

}
