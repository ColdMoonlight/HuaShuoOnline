package com.atguigu.dao;

import com.atguigu.bean.MlbackSearch;

public interface MlbackSearchMapper {
    int deleteByPrimaryKey(Integer searchId);

    int insert(MlbackSearch record);

    int insertSelective(MlbackSearch record);

    MlbackSearch selectByPrimaryKey(Integer searchId);

    int updateByPrimaryKeySelective(MlbackSearch record);

    int updateByPrimaryKey(MlbackSearch record);
}