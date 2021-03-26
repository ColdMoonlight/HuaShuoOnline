package com.atguigu.dao;

import com.atguigu.bean.MlbackBlog;

public interface MlbackBlogMapper {
    int deleteByPrimaryKey(Integer blogId);

    int insert(MlbackBlog record);

    int insertSelective(MlbackBlog record);

    MlbackBlog selectByPrimaryKey(Integer blogId);

    int updateByPrimaryKeySelective(MlbackBlog record);

    int updateByPrimaryKeyWithBLOBs(MlbackBlog record);

    int updateByPrimaryKey(MlbackBlog record);
}