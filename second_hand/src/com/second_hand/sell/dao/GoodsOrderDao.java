package com.second_hand.sell.dao;

import java.util.List;

import com.second_hand.model.OrderInfo;

public interface GoodsOrderDao {

	//新增
	public boolean add(OrderInfo order);
	//根据订单id查找订单信息
	public OrderInfo findById(int id);
	//根据订单编号删除
	public boolean delete(int id);
	//分页查询用户售出的订单
	public List<OrderInfo> findByPageSale(final int page, final int pageSize,final int userId,int condition);
	//查询用户售出的订单最大页数
	public int countMaxPageSale(int pageSize,int userId,int condition);
	//分页查询用户购买的订单
	public List<OrderInfo> findByPageBuy(final int page, final int pageSize,final int userId,int condition);
	//查询用户购买的订单的最大页数
	public int countMaxPageBuy(int pageSize,int userId,int condition);
	//修改订单状态
	public void updateStatu(OrderInfo order);
	//删除评价
	public void deleteEvaluate(OrderInfo order);
	//评价
	public boolean evaluate(OrderInfo order);
	//评价管理
	public List<OrderInfo> findEvaluateNotNullByPage(final int page, final int pageSize);
	//查询评价的最大页数
	public int countMaxPageByEvaluate(int pageSize);
	//不分页查询用户已卖出商品反馈（div）
	public List<OrderInfo> findEvaluateNotNullByUser(int userId);
	//分页查询用户已卖出商品反馈（重载）
	public List<OrderInfo> findEvaluateNotNullByUser(int userId,final int page, final int pageSize);
	//查询用户已卖出商品反馈的最大页数
	public int countMaxPageByEvaluateByUser(int userId,int pageSize);
	//查询卖家待发货数量
	public int countWaitSend(int userId);
	//查询买家待收货数量
	public int countWaitReceive(int userId);
	//查询买家待评价数量
	public int countWaitEvaluate(int userId);
	//查询买家待发货数量
	public int countWaitSendToBuy(int userId);

}
