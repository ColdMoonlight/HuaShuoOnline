package com.atguigu.dao;

import java.util.List;

import com.atguigu.bean.MlbackEmailRichText;

public interface MlbackEmailRichTextMapper {
    int deleteByPrimaryKey(Integer emailrichtextId);

    int insert(MlbackEmailRichText record);

    int insertSelective(MlbackEmailRichText record);

    MlbackEmailRichText selectByPrimaryKey(Integer emailrichtextId);

    int updateByPrimaryKeySelective(MlbackEmailRichText record);

    int updateByPrimaryKey(MlbackEmailRichText record);

	List<MlbackEmailRichText> selectMlbackEmailRichTextGetAll();

	List<MlbackEmailRichText> selectMlbackEmailRichTextListByName(MlbackEmailRichText mlbackEmailRichTextReq);
}