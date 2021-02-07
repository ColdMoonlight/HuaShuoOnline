package com.atguigu.dao;

import java.util.List;
import com.atguigu.bean.CheckRecover;

public interface CheckRecoverMapper {

	List<CheckRecover> selectCheckRecoverOrderList(CheckRecover downPayIFDateReq);
    
}