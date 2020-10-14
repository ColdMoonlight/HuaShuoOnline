package com.atguigu.dao;

import com.atguigu.bean.MlbackPagearea;

public interface MlbackPageareaMapper {
    int deleteByPrimaryKey(Integer pageareaId);

    int insert(MlbackPagearea record);

    int insertSelective(MlbackPagearea record);

    MlbackPagearea selectByPrimaryKey(Integer pageareaId);

    int updateByPrimaryKeySelective(MlbackPagearea record);

    int updateByPrimaryKey(MlbackPagearea record);
}