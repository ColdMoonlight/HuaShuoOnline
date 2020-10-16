package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.EmailPayAllsuccess;
import com.atguigu.dao.EmailPayAllsuccessMapper;

@Service
public class EmailPayAllsuccessService {
	
	@Autowired
	EmailPayAllsuccessMapper emailPayAllsuccessMapper;
	
	/**
	 * @author Shinelon
	 * @param EmailPayAllsuccess
	 * @exception add方法用户信息是否存在
	 * 	3.0
	 * */
	public int insertSelective(EmailPayAllsuccess EmailPayAllsuccess) {
		int intReslut = emailPayAllsuccessMapper.insertSelective(EmailPayAllsuccess);
		return intReslut;
	}

	/**
	 * @author
	 * @param 
	 * @exception 删除本条信息
	 * 	3.0
	 * */
	public int deleteByPrimaryKey(int CatalogId) {
		int  intReslut = emailPayAllsuccessMapper.deleteByPrimaryKey(CatalogId);
		return intReslut;
	}

	/**
	 * @author	3.0
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(EmailPayAllsuccess EmailPayAllsuccess) {
		int  intReslut = emailPayAllsuccessMapper.updateByPrimaryKeySelective(EmailPayAllsuccess);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPayAllsuccess> selectALl(EmailPayAllsuccess EmailPayAllsuccess) {
		List<EmailPayAllsuccess>  EmailPayAllsuccessList = emailPayAllsuccessMapper.selectALl(EmailPayAllsuccess);
		return EmailPayAllsuccessList;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPayAllsuccess> selectByEmail(EmailPayAllsuccess EmailPayAllsuccess) {
		List<EmailPayAllsuccess>  MlbackActShowProList = emailPayAllsuccessMapper.selectByEmail(EmailPayAllsuccess);
		return MlbackActShowProList;
	}

}
