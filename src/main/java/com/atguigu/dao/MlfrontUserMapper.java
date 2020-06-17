package com.atguigu.dao;

import com.atguigu.bean.MlfrontUser;

public interface MlfrontUserMapper {
    int deleteByPrimaryKey(Integer userId);

    int insert(MlfrontUser record);

    int insertSelective(MlfrontUser record);

    MlfrontUser selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(MlfrontUser record);

    int updateByPrimaryKey(MlfrontUser record);
}