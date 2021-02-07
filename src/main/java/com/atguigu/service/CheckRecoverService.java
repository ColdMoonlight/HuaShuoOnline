package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.CheckRecover;
import com.atguigu.dao.CheckRecoverMapper;

@Service
public class CheckRecoverService {
	
	@Autowired
	CheckRecoverMapper checkRecoverMapper;
	
	public List<CheckRecover> selectCheckRecoverOrderList(CheckRecover CheckRecover) {
		List<CheckRecover>  mlfrontPayInfoList = checkRecoverMapper.selectCheckRecoverOrderList(CheckRecover);
		return mlfrontPayInfoList;
	}
	
}
