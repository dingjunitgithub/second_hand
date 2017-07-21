package com.second_hand.comment.service;

import java.util.List;

import com.second_hand.model.Comment;

public interface CommentService {

	//新增
	public boolean add(Comment comments);
	//根据商品编号查询所有评论
	public List<Comment> findByGoodsId(int goodsid);
	//删除
	public boolean delete(int id);
	//根据留言id查找
	public Comment findById(int id);
	//分页查询所有留言信息
	public List<Comment> findAllCommentByPage(final int page, final int pageSize);
	//查询留言总数
	public int countMaxPageByAllComment(int pageSize) throws Exception;
	//分页查询我的留言
	public List<Comment> findByPage(final int page, final int pageSize,final int userId);
	//查询我的留言的最大页数
	public int countMaxPage(int pageSize,int userId) throws Exception;
	//分页查询给我的留言已回复的
	public List<Comment> findAllCommentByPageToMeYes(final int page, final int pageSize,final int userId);
	//查询给我的留言总条数
	public int countMaxPageToMeYes(int pageSize,int userId) throws Exception;
	//修改回复状态
	public Comment update(Comment comment);
	//查询给我的留言未回复的
	public List<Comment> findAllCommentByPageToMeNo(final int page, final int pageSize,final int userId);
	//查询给我的留言但未回复的总条数
	public int countMaxPageToMeNo(int pageSize,int userId) throws Exception;
	//根据留言编号查询所有回复
	public List<Comment> findAllRevert(int comId);
	//提醒卖家发货
	public boolean sendMessageToSaleUser(int orderId);
	//查询用户待回复条数
	public int countWaitRevert(int userId);
}
