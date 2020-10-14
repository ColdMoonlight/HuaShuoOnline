package com.atguigu.dao;

import com.atguigu.bean.MlbackPageArea;

public interface MlbackPageAreaMapper {
    int deleteByPrimaryKey(Integer pageareaId);

    int insert(MlbackPageArea record);

    int insertSelective(MlbackPageArea record);

    MlbackPageArea selectByPrimaryKey(Integer pageareaId);

    int updateByPrimaryKeySelective(MlbackPageArea record);

    int updateByPrimaryKey(MlbackPageArea record);
}