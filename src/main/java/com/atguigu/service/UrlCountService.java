package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.UrlCount;
import com.atguigu.dao.UrlCountMapper;

@Service
public class UrlCountService {
	
	@Autowired
	UrlCountMapper urlCountMapper;
	
	/**
	 * @author Shinelon
	 * @param UrlCount
	 * @exception selectUrlCountByTime
	 * */
	public List<UrlCount> selectUrlCountByTime(UrlCount urlCountReq) {
		List<UrlCount>  urlCountList = urlCountMapper.selectUrlCountByTime(urlCountReq);
		return urlCountList;
	}

}
