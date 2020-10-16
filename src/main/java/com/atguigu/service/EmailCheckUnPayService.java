package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.EmailCheckUnPay;
import com.atguigu.dao.EmailCheckUnPayMapper;

@Service
public class EmailCheckUnPayService {
	
	@Autowired
	EmailCheckUnPayMapper emailCheckUnPayMapper;
	
	/**
	 * @author Shinelon
	 * @param EmailCheckUnPay
	 * @exception add方法用户信息是否存在
	 * 	3.0
	 * */
	public int insertSelective(EmailCheckUnPay EmailCheckUnPay) {
		int intReslut = emailCheckUnPayMapper.insertSelective(EmailCheckUnPay);
		return intReslut;
	}

	/**
	 * @author
	 * @param 
	 * @exception 删除本条信息
	 * 	3.0
	 * */
	public int deleteByPrimaryKey(int CatalogId) {
		int  intReslut = emailCheckUnPayMapper.deleteByPrimaryKey(CatalogId);
		return intReslut;
	}

	/**
	 * @author	3.0
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(EmailCheckUnPay EmailCheckUnPay) {
		int  intReslut = emailCheckUnPayMapper.updateByPrimaryKeySelective(EmailCheckUnPay);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailCheckUnPay> selectALl(EmailCheckUnPay EmailCheckUnPay) {
		List<EmailCheckUnPay>  EmailCheckUnPayList = emailCheckUnPayMapper.selectALl(EmailCheckUnPay);
		return EmailCheckUnPayList;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailCheckUnPay> selectByEmail(EmailCheckUnPay EmailCheckUnPay) {
		List<EmailCheckUnPay>  MlbackActShowProList = emailCheckUnPayMapper.selectByEmail(EmailCheckUnPay);
		return MlbackActShowProList;
	}

}
