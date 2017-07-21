package com.second_hand.comment.dao;

import java.util.List;

import com.second_hand.model.Comment;

public interface CommentDao {

	//新增评论
	public boolean add(Comment comments);
	//根据商品Id查询所有评论
	public List<Comment> findByGoodsId(int goodsid);
	//删除评论
	public boolean delete(int id);
	//修改回复状态
	public Comment update(Comment comment);
	//根据留言编号查找留言信息
	public Comment findById(int id);
	//分页查询所有留言信息
	public List<Comment> findAllCommentByPage(final int page, final int pageSize);
	//查询总留言数
	public int countMaxPageByAllComment(int pageSize) throws Exception;
	//查询我的留言
	public List<Comment> findByPage(final int page, final int pageSize,final int userId);
	//查询我的留言的最大页数
	public int countMaxPage(int pageSize,int userId) throws Exception;
	//查询给我的留言并且已经回复的
	public List<Comment> findAllCommentByPageToMeYes(final int page, final int pageSize,final int userId);
	//查询给我的留言的最大页数并且已经回复的
	public int countMaxPageToMeYes(int pageSize,int userId) throws Exception;
	//查询给我的留言未回复的
	public List<Comment> findAllCommentByPageToMeNo(final int page, final int pageSize,final int userId);
	//查询给我的留言的最大页数未回复的
	public int countMaxPageToMeNo(int pageSize,int userId) throws Exception;
	//查询回复
	public List<Comment> findAllRevert(int comId);
	//查询用户待回复条数
	public int countWaitRevert(int userId);
	//查询买家提示的发货信息，在发货后便于删除
	public List<Comment> findCommentByGoodsZrIdAndAuto(int goodsZrId);
}
