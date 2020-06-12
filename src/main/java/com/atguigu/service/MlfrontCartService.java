package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.bean.MlfrontCart;
import com.atguigu.dao.MlfrontCartMapper;


@Service
public class MlfrontCartService {
	
	
	@Autowired
	MlfrontCartMapper mlfrontCartMapper;
	
	/**
	 * @author Shinelon
	 * @param MlfrontCart
	 * @exception add方法用户信息是否存在
	 * 
	 * */
	public int insertSelective(MlfrontCart mlfrontCart) {
		int intReslut = mlfrontCartMapper.insertSelective(mlfrontCart);
		return intReslut;
	}

	/**
	 * @author Shinelon
	 * @param 
	 * @exception 删除本条信息
	 * 
	 * */
	public int deleteByPrimaryKey(int cartId) {
		int  intReslut = mlfrontCartMapper.deleteByPrimaryKey(cartId);
		return intReslut;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 更新本条信息
	 * 
	 * */
	public int updateByPrimaryKeySelective(MlfrontCart mlfrontCart) {
		int  intReslut = mlfrontCartMapper.updateByPrimaryKeySelective(mlfrontCart);
		return intReslut;
	}
	

	public List<MlfrontCart> selectMlfrontCartByDate(MlfrontCart mlfrontCart) {
		List<MlfrontCart>  mlfrontCartList = mlfrontCartMapper.selectMlfrontCartByDate(mlfrontCart);
		return mlfrontCartList;
	}

	public List<MlfrontCart> selectMlfrontCartGetAllHundred() {
		List<MlfrontCart>  mlfrontCartList = mlfrontCartMapper.selectMlfrontCartGetAllHundred();
		return mlfrontCartList;
	}
	
}
