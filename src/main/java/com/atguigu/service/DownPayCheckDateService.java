package com.atguigu.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.DownPayCheckDate;
import com.atguigu.dao.DownPayCheckDateMapper;

@Service
public class DownPayCheckDateService {
	
	@Autowired
	DownPayCheckDateMapper downPayCheckDateMapper;
	
	public List<DownPayCheckDate> selectHighPayCheckList(DownPayCheckDate downPayIFDateReq) {
		List<DownPayCheckDate>  mlfrontPayInfoList = downPayCheckDateMapper.selectHighPayCheckList(downPayIFDateReq);
		return mlfrontPayInfoList;
	}
	
}
