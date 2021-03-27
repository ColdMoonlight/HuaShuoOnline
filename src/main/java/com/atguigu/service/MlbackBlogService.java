package com.atguigu.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.atguigu.bean.MlbackBlog;
import com.atguigu.dao.MlbackBlogMapper;

@Service
public class MlbackBlogService {
	
	@Autowired
	MlbackBlogMapper mlbackBlogMapper;
	
	/**
	 * @author Shinelon
	 * @param MlbackBlog
	 * @exception add方法用户信息是否存在
	 * */
	public int insertSelective(MlbackBlog mlbackBlog) {
		int intReslut = mlbackBlogMapper.insertSelective(mlbackBlog);
		return intReslut;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 删除本条信息
	 * */
	public int deleteByPrimaryKey(int productId) {
		int  intReslut = mlbackBlogMapper.deleteByPrimaryKey(productId);
		return intReslut;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 更新本条信息
	 * */
	public int updateByPrimaryKeySelective(MlbackBlog mlbackBlog) {
		int  intReslut = mlbackBlogMapper.updateByPrimaryKeySelective(mlbackBlog);
		return intReslut;
	}
	
	/**
	 * @author Shinelon
	 * @param 
	 * @exception 查看全部用户信息
	 * */
	public List<MlbackBlog> selectMlbackBlogGetAll() {
		List<MlbackBlog>  mlbackBlogList = mlbackBlogMapper.selectMlbackBlogGetAll();
		return mlbackBlogList;
	}

	/**
	 * @author Shinelon
	 * @param MlbackBlog
	 * @exception 查看用户信息是否存在
	 * */
	public List<MlbackBlog> selectMlbackBlogByParam(MlbackBlog mlbackBlog) {
		List<MlbackBlog>  mlbackBlogList = mlbackBlogMapper.selectMlbackBlogByParam(mlbackBlog);
		return mlbackBlogList;
	}
//	/**
//	 * @author Shinelon
//	 * @param MlbackBlog
//	 * @exception 查看用户信息是否存在
//	 * 
//	 * */
//	public List<MlbackBlog> selectMlbackBlogBackSearch(MlbackBlog mlbackBlogReq) {
//		List<MlbackBlog>  mlbackBlogList = mlbackBlogMapper.selectMlbackBlogBackSearch(mlbackBlogReq);
//		return mlbackBlogList;
//	}
//
//	public List<MlbackBlog> selectMlbackBlogbyBlogSeo(MlbackBlog mlbackBlogReq) {
//		List<MlbackBlog>  mlbackBlogList = mlbackBlogMapper.selectMlbackBlogbyBlogSeo(mlbackBlogReq);
//		return mlbackBlogList;
//	}
//	/**
//	 * @author Shinelon
//	 * @param MlbackBlog
//	 * @exception 查看用户信息是否存在
//	 * 
//	 * */
//	public List<MlbackBlog> selectMlbackBlogSimpleByParam(MlbackBlog mlbackBlog) {
//		List<MlbackBlog>  mlbackCategoryList = mlbackBlogMapper.selectMlbackBlogSimpleByParam(mlbackBlog);
//		return mlbackCategoryList;
//	}
//
//	/**
//	 * 查询单个产品信息(无富文本描述)
//	 * */
//	public List<MlbackBlog> selectMlbackBlogSimple(MlbackBlog MlbackBlogReq) {
//		List<MlbackBlog>  MlbackBlogList = MlbackBlogMapper.selectMlbackBlogSimple(MlbackBlogReq);
//		return MlbackBlogList;
//	}
//	
//	public List<MlbackBlog> selectMlbackBlogLike(MlbackBlog MlbackBlog) {
//		List<MlbackBlog>  MlbackBlogList = MlbackBlogMapper.selectMlbackBlogLike(MlbackBlog);
//		return MlbackBlogList;
//	}
//
//	public List<MlbackBlog> selectMlbackBlogLikeNum(MlbackBlog MlbackBlog) {
//		List<MlbackBlog>  MlbackBlogList = MlbackBlogMapper.selectMlbackBlogLikeNum(MlbackBlog);
//		return MlbackBlogList;
//	}
//
//	public List<MlbackBlog> selectMlbackBlogDownLoadByParam(MlbackBlog MlbackBlogReq) {
//		List<MlbackBlog>  MlbackBlogList = MlbackBlogMapper.selectMlbackBlogDownLoadByParam(MlbackBlogReq);
//		return MlbackBlogList;
//	}
//
//	public List<MlbackBlog> selectMlbackBlogBeforeTime(MlbackBlog MlbackBlogReq) {
//		List<MlbackBlog>  MlbackBlogList = MlbackBlogMapper.selectMlbackBlogBeforeTime(MlbackBlogReq);
//		return MlbackBlogList;
//	}
//
//	public List<MlbackBlog> selectMlbackBlogSimpleByParamOnlyProDateilUsed(MlbackBlog MlbackBlogReq) {
//		List<MlbackBlog>  mlbackCategoryList = MlbackBlogMapper.selectMlbackBlogSimpleByParamOnlyProDateilUsed(MlbackBlogReq);
//		return mlbackCategoryList;
//	}

}
