package com.second_hand.sell.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.second_hand.comment.dao.CommentDao;
import com.second_hand.goods.dao.GoodsZrDao;
import com.second_hand.model.Comment;
import com.second_hand.model.GoodsZr;
import com.second_hand.model.Integration;
import com.second_hand.model.OrderInfo;
import com.second_hand.model.Rule;
import com.second_hand.model.User;
import com.second_hand.sell.dao.GoodsOrderDao;
import com.second_hand.sell.service.GoodsOrderService;
import com.second_hand.user.dao.IntegrationDao;
import com.second_hand.user.dao.RuleDao;
import com.second_hand.user.dao.UserDao;

public class GoodsOrderServiceImpl implements GoodsOrderService {

	GoodsOrderDao orderDao=null;
	UserDao userDao=null;
	GoodsZrDao goodsZrDao=null;
	IntegrationDao integrationDao=null;
	RuleDao ruleDao=null;
	CommentDao commentDao=null;
	//新增订单
	public boolean add(OrderInfo order) {
		// TODO Auto-generated method stub
		return orderDao.add(order);
	}

	//根据订单编号查询订单信息
	public OrderInfo findById(int id) {
		// TODO Auto-generated method stub
		return orderDao.findById(id);
	}

	//前台删除交易已完成订单
	public void delete(int id,int statu) {
		// TODO Auto-generated method stub
		OrderInfo order=orderDao.findById(id);
		if(statu==1){
			//买家
			order.setBuyStatu(1);
		}else{
			//卖家
			order.setSaleStatu(1);
		}
		orderDao.updateStatu(order);
	}

	//用户售出订单
	public List<OrderInfo> findByPageSale(int page, int pageSize, int userId,int condition) {
		// TODO Auto-generated method stub
		return orderDao.findByPageSale(page, pageSize, userId,condition);
	}

	//查询用户售出订单的最大页数
	public int countMaxPageSale(int pageSize, int userId,int condition){
		// TODO Auto-generated method stub
		return orderDao.countMaxPageSale(pageSize, userId,condition);
	}
	
	//修改订单状态
	public void updateStatu(int id,String statu) {
		// TODO Auto-generated method stub
		//修改订单状态
		OrderInfo order=orderDao.findById(id);
		order.setStatu(statu);
		orderDao.updateStatu(order);
		if(statu=="1"){
			//卖家已发货，删除用户提示卖家发货的信息
			List<Comment> commentList=commentDao.findCommentByGoodsZrIdAndAuto(order.getGoodsZr().getGoodsZrId());
			if(commentList.size()!=0){
				for(Comment com:commentList){
					commentDao.delete(com.getComId());
				}
			}
		}
		if(statu=="2"){
			//买家收到货，给卖家积分和打款
			GoodsZr goodsZr=goodsZrDao.findById(order.getGoodsZr().getGoodsZrId());
			User user= userDao.findUserByEmail(goodsZr.getUser().getEmail());
			//查到商品的价格给买家打款，并且添加买家的积分
			float ye = user.getAccountBalance();
			float buyye =goodsZr.getPrice();
			user.setAccountBalance(ye+buyye);
			Rule rule=ruleDao.findRuleById(5);
			int value=Integer.parseInt(rule.getRuleValue().substring(1));
			user.setIntegral(user.getIntegral()+value);
			userDao.update(user);
			//添加积分明细
			Integration integration=new Integration();
			integration.setRule(rule);
			integration.setUser(user);
			integration.setIntegraDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
			integrationDao.addIntegration(integration);	
		}
		
	}
	
	//评价
	public boolean evaluate(int orderId, String evaluate) {
		// TODO Auto-generated method stub
		OrderInfo order=orderDao.findById(orderId);
		if(order!=null){
			System.out.println("bbbbbbbbbbbb"+evaluate);
			order.setEvaluate(evaluate);
			boolean flag=orderDao.evaluate(order);
			if(flag){
				return true;
			}else{
				return false;
			}
		}
		return false;
	}
	
	//删除评价
	public void deleteEvaluate(int orderId) {
		// TODO Auto-generated method stub
		OrderInfo order=orderDao.findById(orderId);
		order.setEvaluate(null);
		orderDao.deleteEvaluate(order);
	}

	//后台评价管理
	public List<OrderInfo> findEvaluateNotNullByPage(int page, int pageSize) {
		// TODO Auto-generated method stub
		return orderDao.findEvaluateNotNullByPage(page, pageSize);
	}

	//查询评价最大页数
	public int countMaxPageByEvaluate(int pageSize) {
		// TODO Auto-generated method stub
		return orderDao.countMaxPageByEvaluate(pageSize);
	}
	
	//查询用户售出商品评价反馈（不分页）
	public List<OrderInfo> findEvaluateNotNullByUser(int userId) {
		// TODO Auto-generated method stub
		return orderDao.findEvaluateNotNullByUser(userId);
	}

	//用户购买订单的最大页数
	public int countMaxPageBuy(int pageSize, int userId,int condition){
		// TODO Auto-generated method stub
		return orderDao.countMaxPageBuy(pageSize, userId,condition);
	}

	//分页查询用户购买订单
	public List<OrderInfo> findByPageBuy(int page, int pageSize, int userId,int condition) {
		// TODO Auto-generated method stub
		return orderDao.findByPageBuy(page, pageSize, userId,condition);
	}

	//计算卖家待发货数量
	public int countWaitSend(int userId) {
		// TODO Auto-generated method stub
		return orderDao.countWaitSend(userId);
	}

	//查询买家待收货数量
	public int countWaitReceive(int userId) {
		// TODO Auto-generated method stub
		return orderDao.countWaitReceive(userId);
	}

	//查询买家待评价数量
	public int countWaitEvaluate(int userId) {
		// TODO Auto-generated method stub
		return orderDao.countWaitEvaluate(userId);
	}

	//查询买家待发货数量
	public int countWaitSendToBuy(int userId) {
		// TODO Auto-generated method stub
		return orderDao.countWaitSendToBuy(userId);
	}

	//分页查询用户售出商品评价反馈
	public List<OrderInfo> findEvaluateNotNullByUser(int userId, int page,
			int pageSize) {
		// TODO Auto-generated method stub
		return orderDao.findEvaluateNotNullByUser(userId, page, pageSize);
	}

	//查询用户已售出商品评价反馈的最大页数
	public int countMaxPageByEvaluateByUser(int userId, int pageSize) {
		// TODO Auto-generated method stub
		return orderDao.countMaxPageByEvaluateByUser(userId, pageSize);
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

	/**
	 * @return the userDao
	 */
	public UserDao getUserDao() {
		return userDao;
	}

	/**
	 * @param userDao the userDao to set
	 */
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	/**
	 * @return the goodsZrDao
	 */
	public GoodsZrDao getGoodsZrDao() {
		return goodsZrDao;
	}

	/**
	 * @param goodsZrDao the goodsZrDao to set
	 */
	public void setGoodsZrDao(GoodsZrDao goodsZrDao) {
		this.goodsZrDao = goodsZrDao;
	}

	/**
	 * @return the integrationDao
	 */
	public IntegrationDao getIntegrationDao() {
		return integrationDao;
	}

	/**
	 * @param integrationDao the integrationDao to set
	 */
	public void setIntegrationDao(IntegrationDao integrationDao) {
		this.integrationDao = integrationDao;
	}

	/**
	 * @return the ruleDao
	 */
	public RuleDao getRuleDao() {
		return ruleDao;
	}

	/**
	 * @param ruleDao the ruleDao to set
	 */
	public void setRuleDao(RuleDao ruleDao) {
		this.ruleDao = ruleDao;
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
