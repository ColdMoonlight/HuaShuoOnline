package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.EmailPayPalRetuenSuccess;
import com.atguigu.bean.MlbackActShowPro;
import com.atguigu.dao.EmailPayPalRetuenSuccessMapper;

@Service
public class EmailPayPalRetuenSuccessService {
	
	@Autowired
	EmailPayPalRetuenSuccessMapper emailPayPalRetuenSuccessMapper;
	
	/**
	 * @author Shinelon
	 * @param EmailPayPalRetuenSuccess
	 * @exception add方法用户信息是否存在
	 * 	3.0
	 * */
	public int insertSelective(EmailPayPalRetuenSuccess EmailPayPalRetuenSuccess) {
		int intReslut = emailPayPalRetuenSuccessMapper.insertSelective(EmailPayPalRetuenSuccess);
		return intReslut;
	}

	/**
	 * @author
	 * @param 
	 * @exception 删除本条信息
	 * 	3.0
	 * */
	public int deleteByPrimaryKey(int CatalogId) {
		int  intReslut = emailPayPalRetuenSuccessMapper.deleteByPrimaryKey(CatalogId);
		return intReslut;
	}

	/**
	 * @author	3.0
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(EmailPayPalRetuenSuccess EmailPayPalRetuenSuccess) {
		int  intReslut = emailPayPalRetuenSuccessMapper.updateByPrimaryKeySelective(EmailPayPalRetuenSuccess);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPayPalRetuenSuccess> selectALl() {
		List<EmailPayPalRetuenSuccess>  EmailPayPalRetuenSuccessList = emailPayPalRetuenSuccessMapper.selectALl();
		return EmailPayPalRetuenSuccessList;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<EmailPayPalRetuenSuccess> selectByEmail(EmailPayPalRetuenSuccess EmailPayPalRetuenSuccess) {
		List<EmailPayPalRetuenSuccess>  MlbackActShowProList = emailPayPalRetuenSuccessMapper.selectByEmail(EmailPayPalRetuenSuccess);
		return MlbackActShowProList;
	}

}
