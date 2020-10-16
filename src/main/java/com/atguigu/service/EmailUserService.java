package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.EmailUser;
import com.atguigu.bean.MlbackActShowPro;
import com.atguigu.dao.EmailUserMapper;

@Service
public class EmailUserService {
	
	@Autowired
	EmailUserMapper emailUserMapper;
	
	/**
	 * @author Shinelon
	 * @param EmailUser
	 * @exception add方法用户信息是否存在
	 * 	3.0
	 * */
	public int insertSelective(EmailUser EmailUser) {
		int intReslut = emailUserMapper.insertSelective(EmailUser);
		return intReslut;
	}

	/**
	 * @author
	 * @param 
	 * @exception 删除本条信息
	 * 	3.0
	 * */
	public int deleteByPrimaryKey(int CatalogId) {
		int  intReslut = emailUserMapper.deleteByPrimaryKey(CatalogId);
		return intReslut;
	}

	/**
	 * @author	3.0
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(EmailUser EmailUser) {
		int  intReslut = emailUserMapper.updateByPrimaryKeySelective(EmailUser);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailUser> selectALl(EmailUser EmailUser) {
		List<EmailUser>  EmailUserList = emailUserMapper.selectALl(EmailUser);
		return EmailUserList;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailUser> selectByEmail(EmailUser EmailUser) {
		List<EmailUser>  MlbackActShowProList = emailUserMapper.selectByEmail(EmailUser);
		return MlbackActShowProList;
	}

}
