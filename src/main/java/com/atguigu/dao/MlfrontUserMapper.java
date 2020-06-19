package com.atguigu.dao;

import java.util.List;
import com.atguigu.bean.MlfrontUser;

public interface MlfrontUserMapper {

    int insert(MlfrontUser record);

    MlfrontUser selectByPrimaryKey(Integer userId);

    int updateByPrimaryKey(MlfrontUser record);
    
    //插入MlfrontUser00
    int insertSelective(MlfrontUser record);
    //删除MlfrontUser00
    int deleteByPrimaryKey(Integer userId);
    //更新MlfrontUser00
    int updateByPrimaryKeySelective(MlfrontUser record);
    //更新updatePwdByEmail
    int updatePwdByEmail(MlfrontUser record);
    
    List<MlfrontUser> selectMlfrontUserWhenFirst(MlfrontUser example);
    //条件查询MlfrontUser00
    List<MlfrontUser> selectMlfrontUserByConditionS(MlfrontUser example);
//    //全部查询MlfrontUser00
//  	List<MlfrontUser> selectMlfrontUserGetAll();
//  	
//  	//通过时间查询MlfrontUser00
//  	List<MlfrontUser> selectMlfrontUserByDate(MlfrontUser record);
}