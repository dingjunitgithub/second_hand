package com.second_hand.comment.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.second_hand.comment.dao.CommentDao;
import com.second_hand.comment.service.CommentService;
import com.second_hand.model.Comment;
import com.second_hand.model.OrderInfo;
import com.second_hand.sell.dao.GoodsOrderDao;

public class CommentServiceImpl implements CommentService {

	CommentDao commentDao=null;
	GoodsOrderDao orderDao=null;
	
	//添加留言
	public boolean add(Comment comments) {
		// TODO Auto-generated method stub
		return commentDao.add(comments);
	}

	//根据商品编号查询所有留言
	public List<Comment> findByGoodsId(int goodsid) {
		// TODO Auto-generated method stub
		return commentDao.findByGoodsId(goodsid);
	}

	//删除留言
	public boolean delete(int id) {
		// TODO Auto-generated method stub
		return commentDao.delete(id);
	}

	//根据留言编号查询留言信息
	public Comment findById(int id) {
		// TODO Auto-generated method stub
		return commentDao.findById(id);
	}

	//分页查询用户我的留言
	public List<Comment> findByPage(int page, int pageSize, int userId) {
		// TODO Auto-generated method stub
		return commentDao.findByPage(page, pageSize, userId);
	}

	//查询我的留言总条数
	public int countMaxPage(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		return commentDao.countMaxPage(pageSize, userId);
	}

	//分页查询给我的留言且已回复的留言
	public List<Comment> findAllCommentByPageToMeYes(int page, int pageSize,
			int userId) {
		// TODO Auto-generated method stub
		return commentDao.findAllCommentByPageToMeYes(page, pageSize, userId);
	}

	//查询给我的留言且已回复的总条数
	public int countMaxPageToMeYes(int pageSize, int userId)
			throws Exception {
		// TODO Auto-generated method stub
		return commentDao.countMaxPageToMeYes(pageSize, userId);
	}

	//分页查询所有留言
	public List<Comment> findAllCommentByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return commentDao.findAllCommentByPage(page, pageSize);
	}

	//查询所有留言总条数
	public int countMaxPageByAllComment(int pageSize) throws Exception {
		// TODO Auto-generated method stub
		return commentDao.countMaxPageByAllComment(pageSize);
	}

	//更新留言
	public Comment update(Comment comment) {
		// TODO Auto-generated method stub
		return commentDao.update(comment);
	}

	//分页查询给我的留言但未回复的留言
	public List<Comment> findAllCommentByPageToMeNo(int page, int pageSize,
			int userId) {
		// TODO Auto-generated method stub
		return commentDao.findAllCommentByPageToMeNo(page, pageSize, userId);
	}

	//查询给我的留言但未回复的留言总条数
	public int countMaxPageToMeNo(int pageSize, int userId) throws Exception {
		// TODO Auto-generated method stub
		return commentDao.countMaxPageToMeNo(pageSize, userId);
	}

	//根据留言编号查询回复
	public List<Comment> findAllRevert(int comId) {
		// TODO Auto-generated method stub
		return commentDao.findAllRevert(comId);
	}

	//提醒卖家发货
	public boolean sendMessageToSaleUser(int orderId) {
		// TODO Auto-generated method stub
		OrderInfo order=orderDao.findById(orderId);
		Comment comment=new Comment();
		comment.setToUser(order.getGoodsZr().getUser());
		comment.setUser(order.getUser());
		//编辑提醒卖家发货的具体内容
		comment.setContent("您好！我已经购买了"+order.getGoodsZr().getGoodsName()+",请尽快发货！");
		comment.setCdate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		comment.setCtype(1);
		comment.setRevertSta(0);
		comment.setAutoType(1);
		comment.setGoodsZr(order.getGoodsZr());
		commentDao.add(comment);
		return true;
	}

	/**
	 * @return the orderDao
	 */
	public GoodsOrderDao getOrderDao() {
		return orderDao;
	}

	/**
	 * @param orderDao the orderDao to set
	 */
	public void setOrderDao(GoodsOrderDao orderDao) {
		this.orderDao = orderDao;
	}

	//查询用户待回复条数
	public int countWaitRevert(int userId) {
		// TODO Auto-generated method stub
		return commentDao.countWaitRevert(userId);
	}

	/**
	 * @return the commentDao
	 */
	public CommentDao getCommentDao() {
		return commentDao;
	}

	/**
	 * @param commentDao the commentDao to set
	 */
	public void setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
	}


	

}
