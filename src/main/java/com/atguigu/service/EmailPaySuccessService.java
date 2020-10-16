package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.EmailPaySuccess;
import com.atguigu.bean.EmailUser;
import com.atguigu.dao.EmailPaySuccessMapper;

@Service
public class EmailPaySuccessService {
	
	@Autowired
	EmailPaySuccessMapper emailPaySuccessMapper;
	
	/**
	 * @author Shinelon
	 * @param EmailPaySuccess
	 * @exception add方法用户信息是否存在
	 * 	3.0
	 * */
	public int insertSelective(EmailPaySuccess EmailPaySuccess) {
		int intReslut = emailPaySuccessMapper.insertSelective(EmailPaySuccess);
		return intReslut;
	}

	/**
	 * @author
	 * @param 
	 * @exception 删除本条信息
	 * 	3.0
	 * */
	public int deleteByPrimaryKey(int CatalogId) {
		int  intReslut = emailPaySuccessMapper.deleteByPrimaryKey(CatalogId);
		return intReslut;
	}

	/**
	 * @author	3.0
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(EmailPaySuccess EmailPaySuccess) {
		int  intReslut = emailPaySuccessMapper.updateByPrimaryKeySelective(EmailPaySuccess);
		return intReslut;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPaySuccess> selectALl(EmailPaySuccess EmailPaySuccess) {
		List<EmailPaySuccess>  EmailPaySuccessList = emailPaySuccessMapper.selectALl(EmailPaySuccess);
		return EmailPaySuccessList;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPaySuccess> selectByEmail(EmailPaySuccess EmailPaySuccess) {
		List<EmailPaySuccess>  EmailPaySuccessList = emailPaySuccessMapper.selectByEmail(EmailPaySuccess);
		return EmailPaySuccessList;
	}

}
