package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.EmailAddress;
import com.atguigu.bean.MlbackActShowPro;
import com.atguigu.dao.EmailAddressMapper;

@Service
public class EmailAddressService {
	
	@Autowired
	EmailAddressMapper emailAddressMapper;
	
	/**
	 * @author Shinelon
	 * @param EmailAddress
	 * @exception add方法用户信息是否存在
	 * 	3.0
	 * */
	public int insertSelective(EmailAddress EmailAddress) {
		int intReslut = emailAddressMapper.insertSelective(EmailAddress);
		return intReslut;
	}

	/**
	 * @author
	 * @param 
	 * @exception 删除本条信息
	 * 	3.0
	 * */
	public int deleteByPrimaryKey(int CatalogId) {
		int  intReslut = emailAddressMapper.deleteByPrimaryKey(CatalogId);
		return intReslut;
	}

	/**
	 * @author	3.0
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(EmailAddress EmailAddress) {
		int  intReslut = emailAddressMapper.updateByPrimaryKeySelective(EmailAddress);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailAddress> selectALl() {
		List<EmailAddress>  EmailAddressList = emailAddressMapper.selectALl();
		return EmailAddressList;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailAddress> selectByEmail(EmailAddress EmailAddress) {
		List<EmailAddress>  MlbackActShowProList = emailAddressMapper.selectByEmail(EmailAddress);
		return MlbackActShowProList;
	}

}
