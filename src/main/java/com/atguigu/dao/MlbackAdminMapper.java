package com.atguigu.dao;

import com.atguigu.bean.MlbackAdmin;

public interface MlbackAdminMapper {
    int deleteByPrimaryKey(Integer adminId);

    int insert(MlbackAdmin record);

    int insertSelective(MlbackAdmin record);

    MlbackAdmin selectByPrimaryKey(Integer adminId);

    int updateByPrimaryKeySelective(MlbackAdmin record);

    int updateByPrimaryKey(MlbackAdmin record);
}