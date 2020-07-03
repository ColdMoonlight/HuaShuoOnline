package com.atguigu.dao;

import com.atguigu.bean.MlbackCatalog;

public interface MlbackCatalogMapper {
    int deleteByPrimaryKey(Integer catalogId);

    int insert(MlbackCatalog record);

    int insertSelective(MlbackCatalog record);

    MlbackCatalog selectByPrimaryKey(Integer catalogId);

    int updateByPrimaryKeySelective(MlbackCatalog record);

    int updateByPrimaryKey(MlbackCatalog record);
}