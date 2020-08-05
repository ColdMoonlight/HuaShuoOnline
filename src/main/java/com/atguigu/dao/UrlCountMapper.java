package com.atguigu.dao;

import com.atguigu.bean.UrlCount;
import java.util.List;

public interface UrlCountMapper {

	List<UrlCount> selectUrlCountByTime(UrlCount UrlCount);
    
}