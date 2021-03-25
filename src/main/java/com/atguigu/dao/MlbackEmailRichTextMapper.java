package com.atguigu.dao;

import com.atguigu.bean.MlbackEmailRichText;

public interface MlbackEmailRichTextMapper {
    int deleteByPrimaryKey(Integer emailrichtextId);

    int insert(MlbackEmailRichText record);

    int insertSelective(MlbackEmailRichText record);

    MlbackEmailRichText selectByPrimaryKey(Integer emailrichtextId);

    int updateByPrimaryKeySelective(MlbackEmailRichText record);

    int updateByPrimaryKey(MlbackEmailRichText record);
}